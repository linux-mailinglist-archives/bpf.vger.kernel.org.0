Return-Path: <bpf+bounces-17812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC7E812C69
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 11:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C8F28209A
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 10:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD9A39FE9;
	Thu, 14 Dec 2023 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SkpUqCAg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A0593
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 02:01:30 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1c7d8f89a5so1044751366b.2
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 02:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702548089; x=1703152889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B1Akq8V3bknfGJps/yFde6v1w7I15tVFGRLtdFJ361Q=;
        b=SkpUqCAgkjFwiau2TMxXcKjTCnVrTESj4C3mM4qe0C62vdqE4GDJtKzfM4TyqYncin
         HdCwGLTTYzpioo8b0bOAuCiDkLyZt5JyAUhxChf9+8pYSR4LTDQdGUNvmquDhkgn0rC0
         NDumcXsj2ABixcvxXabxT3ZQn+dm8LGplUkzZSLebRZJR3yWyWZUdmH3L1TbFmdnWelr
         TOkrCJY3DQPgI6wzgTwaK4ay2e5TVr0Mljhnz5Jk5LMqXVwr1AcJLKhdzrRtVZeqqX7M
         Ys3k33VFQwTigcw0wQE2Hsk/3vv2cWn1l4IK49Xk4lzEPtjlBmFMcWEvWre8NdGA3afs
         5d6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548089; x=1703152889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1Akq8V3bknfGJps/yFde6v1w7I15tVFGRLtdFJ361Q=;
        b=Vz1HUfh+mwntwgOv2Ci1snF+cWGxOv5RptEK7NLck3REfg12TgVl0fSC5MkDRkKbiA
         9+eo+k5ZrHI/Bq3D3a8FAhosM3q9bL112NiXAjjRF7Qq/Sb8XxcmEsIEpOCAG0Eqzewb
         lP5T0JwC5HG86Qdk9rmkGHgZP12dZsKRDvDev39b2ZXt4XwYYSizufd7kSe445kt9LOv
         3nPTw90mUfJWBkjtL3em7vKk8dlVjdOwcYmhFoQbX6qme0EX9KiDphJ0l31avvcHyDRQ
         92WXp322ddZfa/c72tQL1sPnMazN8pibpW/MEvavbFN13Xn1YqkQ1hKE+BZBSUBQlOJj
         Sw8w==
X-Gm-Message-State: AOJu0YxTsSy++Fe4eGOvnSPcejCkr4d8I1b4CAgHeKni7wjyCNmfW/ZC
	2DmHryb+UJoLi7U4e5hdbYnYBw==
X-Google-Smtp-Source: AGHT+IEO/PF4PkRunvCCQIYpB8GCVvcgDib1ERF20CnB1/QvpCuOT0LoQF4Rxj9CHgFUTOChSzJRNw==
X-Received: by 2002:a17:906:5346:b0:a02:a2cc:66b8 with SMTP id j6-20020a170906534600b00a02a2cc66b8mr4653812ejo.14.1702548089098;
        Thu, 14 Dec 2023 02:01:29 -0800 (PST)
Received: from u94a (2001-b011-fa04-f750-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:f750:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id vs6-20020a170907a58600b00a1fa6a70b8dsm5511673ejc.133.2023.12.14.02.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:01:28 -0800 (PST)
Date: Thu, 14 Dec 2023 18:00:26 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf: make the verifier tracks the "not
 equal" for regs
Message-ID: <zbqhpcp5labyt5spryxfshb54hijyysfyooxtteeq2iaydzwe6@tfa3f7ct7h6a>
References: <20231214062434.3565630-1-menglong8.dong@gmail.com>
 <20231214062434.3565630-2-menglong8.dong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214062434.3565630-2-menglong8.dong@gmail.com>

On Thu, Dec 14, 2023 at 02:24:33PM +0800, Menglong Dong wrote:
> We can derive some new information for BPF_JNE in regs_refine_cond_op().
> Take following code for example:
> 
>   /* The type of "a" is u16 */
>   if (a > 0 && a < 100) {
>     /* the range of the register for a is [0, 99], not [1, 99],
>      * and will cause the following error:
>      *
>      *   invalid zero-sized read
>      *
>      * as a can be 0.
>      */
>     bpf_skb_store_bytes(skb, xx, xx, a, 0);
>   }
> 
> In the code above, "a > 0" will be compiled to "jmp xxx if a == 0". In the
> TRUE branch, the dst_reg will be marked as known to 0. However, in the
> fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
> the [min, max] for a is [0, 99], not [1, 99].
> 
> For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
> const and is exactly the edge of the dst reg.
> 
> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

