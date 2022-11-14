Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C60627A9F
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 11:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbiKNKgr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 05:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbiKNKga (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 05:36:30 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619092BD8;
        Mon, 14 Nov 2022 02:36:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d9so12660135wrm.13;
        Mon, 14 Nov 2022 02:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QnetFY3EhYjRnfuMLD0Bkg7u+YtAr/GNLWodII00ghI=;
        b=Qb5QEYHGtlFMZu0koo17j7PDOQp5lK5yMvCuLjL36HJ0NG23Jymw904wkClKWJEscC
         eFd7D0blGeBlb2VHzo2jHr2yisNPb7nMtWlzACsq1xoBju2olNIKG0mzmwVE3VLTKWAE
         smvkmIsDLnJHt9jlnhgWrhn3s/mhdliHg0p9U2ZTFFWKKLXq0Z13yC/x+LTVpWs94xfe
         WxWmMHFTQ++wkcdVM+nSQplNKliByOV4pRWoGYVHogl19TXBOpIJFisGjYl23kuLfXXY
         1wj/mSBPxkjdPuxiHG2zwtAtOWZubOG0RCS+ISIOHldltaOdWhaJgtMTWBtpNeGD3SS9
         tG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnetFY3EhYjRnfuMLD0Bkg7u+YtAr/GNLWodII00ghI=;
        b=J4mbn2cfQc+WgopPZ92Wbb0tMXn+j/K1HEDxHnz5wsgrCSmcX/Up4ilxTfJxVPt+Ea
         M00p9SSSrnbZBObac/KwsGEYcZhTQTgpvtER6PwPanLhF7/7Zf84bWKb/S7/E08PiiFn
         7LyprSIhNNJNX2Zn9yQKPLQOrJtqOJ8Way8NYTSDESWz9Snggmu1WsLJEaMl7pqdDFzc
         Ge0qJiIWO58w1dGCu0Nwdb9p3gkEgStk1mHp+MrI+iy/21ZKH4Z3CECwaLutkeziXU5H
         T/n07ZE4gs3vyrMTPI69Oh6DrmVmzmqm1plYdFfoJOKarG86JpQ6AFoh2aKyRhLaaTFD
         LNSQ==
X-Gm-Message-State: ANoB5pmolUw7Sj19cb93WH7fX6KI4ZLdoZcaRy3cyJ8m3w43ttrnoNw6
        c9KP51yAr0oTxrqSaNWxFu0=
X-Google-Smtp-Source: AA0mqf7iL+LDWZpbb5z+rp+OqWXlIdCWiJo4VkCBdO+FsAu378cQVagXwfMnx+1M4wbpdennVwO9yQ==
X-Received: by 2002:adf:fbc6:0:b0:22e:3392:fb46 with SMTP id d6-20020adffbc6000000b0022e3392fb46mr6836375wrs.706.1668422187811;
        Mon, 14 Nov 2022 02:36:27 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b002206203ed3dsm9280970wrx.29.2022.11.14.02.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 02:36:27 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 14 Nov 2022 11:36:25 +0100
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>, houtao1@huawei.com,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH bpf] perf, bpf: Use subprog name when reporting subprog
 ksymbol
Message-ID: <Y3IaKXuDcR7dr8vp@krava>
References: <20221114095733.158588-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114095733.158588-1-houtao@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 14, 2022 at 05:57:33PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Since commit bfea9a8574f3 ("bpf: Add name to struct bpf_ksym"), when
> reporting subprog ksymbol to perf, prog name instead of subprog name is
> used. The backtrace of bpf program with subprogs will be incorrect as
> shown below:
> 
>   ffffffffc02deace bpf_prog_e44a3057dcb151f8_overwrite+0x66
>   ffffffffc02de9f7 bpf_prog_e44a3057dcb151f8_overwrite+0x9f
>   ffffffffa71d8d4e trace_call_bpf+0xce
>   ffffffffa71c2938 perf_call_bpf_enter.isra.0+0x48
> 
> overwrite is the entry program and it invokes the overwrite_htab subprog
> through bpf_loop, but in above backtrace, overwrite program just jumps
> inside itself.
> 
> Fixing it by using subprog name when reporting subprog ksymbol. After
> the fix, the output of perf script will be correct as shown below:
> 
>   ffffffffc031aad2 bpf_prog_37c0bec7d7c764a4_overwrite_htab+0x66
>   ffffffffc031a9e7 bpf_prog_c7eb827ef4f23e71_overwrite+0x9f
>   ffffffffa3dd8d4e trace_call_bpf+0xce
>   ffffffffa3dc2938 perf_call_bpf_enter.isra.0+0x48
> 
> Fixes: bfea9a8574f3 ("bpf: Add name to struct bpf_ksym")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4ec3717003d5..8b50ef2569d9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9030,7 +9030,7 @@ static void perf_event_bpf_emit_ksymbols(struct bpf_prog *prog,
>  				PERF_RECORD_KSYMBOL_TYPE_BPF,
>  				(u64)(unsigned long)subprog->bpf_func,
>  				subprog->jited_len, unregister,
> -				prog->aux->ksym.name);
> +				subprog->aux->ksym.name);
>  		}
>  	}
>  }
> -- 
> 2.29.2
> 
