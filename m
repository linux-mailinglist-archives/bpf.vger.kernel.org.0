Return-Path: <bpf+bounces-14912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7C97E8E73
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 06:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30C51F20FAA
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 05:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC102904;
	Sun, 12 Nov 2023 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pgiw8CpO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8031023BD;
	Sun, 12 Nov 2023 05:27:05 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8F330C2;
	Sat, 11 Nov 2023 21:27:03 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32fb1d757f7so2132811f8f.0;
        Sat, 11 Nov 2023 21:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699766822; x=1700371622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AmJo+4JR9D++H06Odt2/It/dOE9mMoGAQoVBxUyxVu0=;
        b=Pgiw8CpOELr5BPeFDN3PrrCIVX8B3LlvXaRoS5c3mnK0Cw69+Lx1MPTSkXoOx2t5il
         qHaW5xv1pYwRB3ItnZ56E7lPfGOlu7YXnjIg6Ya4O0k/at/DR8ElEpk/ymTM5FXCZ8D2
         XH3lbHz7KiQBTVAVZslDULyFAq31FNpNwPRH3yiad0KYbU3BI+lxim/HBVgZ02cpM5Tp
         s9fWvjs33iBzA+vudc6fU1xADC8sCBGe6+f+PlX3qT+w2mVP12XA29camA5o4Qs/QqkG
         Aa99kNbeDenSVt75deUQqFiyrM+TeO5f8kjgkvRJPWQmC4aWOtrncMCdvsQ0M9ef2UtW
         Xp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699766822; x=1700371622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmJo+4JR9D++H06Odt2/It/dOE9mMoGAQoVBxUyxVu0=;
        b=XwissVlZpLxhdG3gDAQ4s49kpy04z6CZ7fZUF4CdeOTQ2SUrDvFLou6r6jzInFNREv
         oeYCCSdKNlE2OzPF0ZWk570uItHIlVd7WKLAHme/uxkB0Z6nOPzDVwrWOKtiYufAJlnn
         GtRHRGLnoxnMFMeBovePhwQ9434gqKcNA/VONtHm8fIA2rl2XNMoKQYx/2FxL3U4KR54
         C4dxPiRejqannWnG1a7v/7bjz45AmByOG+pYmRE/RXwD3x+9yvldRH/X0E4Y3VGwsHlj
         jPx7xTiCtku8srA2VHZF5QVu1bcOzb0A0LWSU7QU4RHdmPjmU+IsFCQKYQ+BkLkrOJMw
         dH4w==
X-Gm-Message-State: AOJu0Yz5VmkmTYD44/eeeBRerN5vnxO5jb0vQNIS34hs0QEZDApzXOzp
	bu5jJVvf4Dtc2xZGL7aVB4k=
X-Google-Smtp-Source: AGHT+IHC8LRwYI280EnhXhEYvBwgsY9T3ZzC0lxuCsoQwNs/s/0D3IZACASCbYB33dmuDiBB5RNb5Q==
X-Received: by 2002:a5d:5850:0:b0:323:1887:dd6d with SMTP id i16-20020a5d5850000000b003231887dd6dmr2889583wrf.3.1699766821864;
        Sat, 11 Nov 2023 21:27:01 -0800 (PST)
Received: from krava (brn-rj-tbond04.sa.cz. [185.94.55.133])
        by smtp.gmail.com with ESMTPSA id dl3-20020a0560000b8300b0032f79e55eb8sm2677740wrb.16.2023.11.11.21.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 21:27:01 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 12 Nov 2023 06:26:58 +0100
To: Jordan Rome <linux@jordanrome.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH v2] perf: get_perf_callchain return NULL for crosstask
Message-ID: <ZVBiItVMzcOFLscd@krava>
References: <20231111172001.1259065-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111172001.1259065-1-linux@jordanrome.com>

On Sat, Nov 11, 2023 at 09:20:01AM -0800, Jordan Rome wrote:
> Return NULL instead of returning 1 incorrect frame, which
> currently happens when trying to walk the user stack for
> any task that isn't current. Returning NULL is a better
> indicator that this behavior is not supported.
> 
> This issue was found using bpf_get_task_stack inside a BPF
> iterator ("iter/task"), which iterates over all tasks. The
> single address/frame in the buffer when getting user stacks
> for tasks that aren't current could not be symbolized (testing
> multiple symbolizers).
> 
> Signed-off-by: Jordan Rome <linux@jordanrome.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
> 
> Changes in v2:
> * move user and crosstask check before get_callchain_entry
> 
> v1:
> https://lore.kernel.org/linux-perf-users/CAEf4BzaWtOeTBb_+b7Td3NHaKjZU+OohuBJje_nvw9kd6xPA3g@mail.gmail.com/T/#t
> 
>  kernel/events/callchain.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 1273be84392c..104ea2975a57 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -184,6 +184,9 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
>  	struct perf_callchain_entry_ctx ctx;
>  	int rctx;
>  
> +	if (user && crosstask)
> +		return NULL;
> +
>  	entry = get_callchain_entry(&rctx);
>  	if (!entry)
>  		return NULL;
> @@ -209,9 +212,6 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
>  		}
>  
>  		if (regs) {
> -			if (crosstask)
> -				goto exit_put;
> -
>  			if (add_mark)
>  				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
>  
> @@ -219,7 +219,6 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
>  		}
>  	}
>  
> -exit_put:
>  	put_callchain_entry(rctx);
>  
>  	return entry;
> -- 
> 2.39.3
> 
> 

