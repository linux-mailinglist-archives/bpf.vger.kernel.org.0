Return-Path: <bpf+bounces-8221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A42783918
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 07:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898C8280FE1
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 05:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A8C1FD0;
	Tue, 22 Aug 2023 05:10:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F201861
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 05:10:11 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3761FCCD
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 22:10:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf48546ccfso19488745ad.2
        for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 22:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692680999; x=1693285799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUUf0Hjl8i72aG9oWnPvk1AnRtZKlwriPghWys2pKlw=;
        b=aMR/o1IdCPK6otbsW0yCoytE8yi7Mr6euJVDZwek3syMhLc2FVSq5jBCTpVehIvz5i
         IF+0iwAc7HDFTl7TZoVueNfjed4wtG3HZ4wQsAI1u3wducQuZHGqHQHhJz71jFYLy1VQ
         m4QzCsV3ctDBbUTcJKexw1xpPIlyiiCm4IDllFDyEogUw4CE3rmW2Ys1Tfe7ST4Val5G
         OY9eoqkiaUAfMxBK77wLq9pr4WT6uNp2mFIKWfGSG9qJaiVnsCXF9xRmUqzVTD0YFWKM
         WO+5WwujSnTZ4nmALJe78UszVGkejyuKnfOETYRK4W7IJg8+DlTa4mtPT0/jQkTDw37W
         Ixmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692680999; x=1693285799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUUf0Hjl8i72aG9oWnPvk1AnRtZKlwriPghWys2pKlw=;
        b=RO4H22oz3Z52sCTvOgSjHx5UBHWXGZyZ0m5VVk4qkIlzUBnudIyXH2s3ALXDSwo2Vt
         EKVXKawl4xyJrOLW7HpKfZa96C2rVEur309iNYzCEA32CYJnXa3ZEysbOn1OzpXSxMdj
         Me/k6FxsrspUvNdbv5Zj0PKhtBnwUOxk9tbppJoeqTVoPVTL5GIbqfVm9PgEGMu/4VJT
         aa/6Ga3X1uQ6V1nZss8vYscxOZlVc9gdZpdrG96rsg00oCcy28FP3vsNYKoEwMUXZscA
         0ZAnccolexOPd7oGzgoXVv1w43GP3KJw7+B/+W5u+GXY8zreObEmFYqOPecl4rriALk1
         fTew==
X-Gm-Message-State: AOJu0YzghZzxpOcxLBfpBmd1ITj+lLLBfZmZRi0UKS3Ug27Dv6CGFR5A
	x3NKg064kSWTpEyQfr9a1JA=
X-Google-Smtp-Source: AGHT+IEQ2RliVAJSc2cRhEJzobyhXQtmbAPDqQO6W/ETYLmHwOcu/FoWXNmC6IpQD+jsNQ6qhkWUvg==
X-Received: by 2002:a17:903:1c4:b0:1bf:728:7458 with SMTP id e4-20020a17090301c400b001bf07287458mr7495257plh.58.1692680999410;
        Mon, 21 Aug 2023 22:09:59 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:400::5:863c])
        by smtp.gmail.com with ESMTPSA id z20-20020a170902ee1400b001bc5dc0cd75sm7951014plb.180.2023.08.21.22.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 22:09:59 -0700 (PDT)
Date: Mon, 21 Aug 2023 22:09:55 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v2 10/14] bpf: Disallow extensions to exception
 callbacks
Message-ID: <20230822050955.lnxdmgtchhhewyax@macbook-pro-8.dhcp.thefacebook.com>
References: <20230809114116.3216687-1-memxor@gmail.com>
 <20230809114116.3216687-11-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809114116.3216687-11-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 05:11:12PM +0530, Kumar Kartikeya Dwivedi wrote:
> During testing, it was discovered that extensions to exception callbacks
> had no checks, upon running a testcase, the kernel ended up running off
> the end of a program having final call as bpf_throw, and hitting int3
> instructions.
> 
> The reason is that while the default exception callback would have reset
> the stack frame to return back to the main program's caller, the
> replacing extension program will simply return back to bpf_throw, which
> will instead return back to the program and the program will continue
> execution, now in an undefined state where anything could happen.
> 
> The way to support extensions to an exception callback would be to mark
> the BPF_PROG_TYPE_EXT main subprog as an exception_cb, and prevent it
> from calling bpf_throw. This would make the JIT produce a prologue that
> restores saved registers and reset the stack frame. But let's not do
> that until there is a concrete use case for this, and simply disallow
> this for now.
> 
> One key point here to note is that currently X86_TAIL_CALL_OFFSET didn't
> require any modifications, even though we emit instructions before the
> corresponding endbr64 instruction. This is because we ensure that a main
> subprog never serves as an exception callback, and therefore the
> exception callback (which will be a global subprog) can never serve as
> the tail call target, eliminating any discrepancies. However, once we
> support a BPF_PROG_TYPE_EXT to also act as an exception callback, it
> will end up requiring change to the tail call offset to account for the
> extra instructions. For simplicitly, tail calls could be disabled for
> such targets.
> 
> Noting the above, it appears better to wait for a concrete use case
> before choosing to permit extension programs to replace exception
> callbacks.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/helpers.c  | 1 +
>  kernel/bpf/verifier.c | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 64a07232c58f..a04eff53354c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2470,6 +2470,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>  	 */
>  	kasan_unpoison_task_stack_below((void *)ctx.sp);
>  	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
> +	WARN(1, "A call to BPF exception callback should never return\n");
>  }
>  
>  __diag_pop();
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a0e1a1d1f5d3..13db1fa4163c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19622,6 +19622,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  					"Extension programs should be JITed\n");
>  				return -EINVAL;
>  			}
> +			if (aux->func && aux->func[subprog]->aux->exception_cb) {
> +				bpf_log(log,
> +					"Extension programs cannot replace exception callback\n");
> +				return -EINVAL;

Should we disallow fentry/fexit to exception cb as well?
Probably things will go wrong for similar reasons as freplace.

And also disallow fentry/fexit for main prog that is exception_boundary ?
since bpf trampoline doesn't know that it needs to save r12.

