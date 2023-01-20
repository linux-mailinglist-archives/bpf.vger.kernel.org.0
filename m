Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932AD674C3C
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjATF1h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjATF1Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:27:24 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7772D7A;
        Thu, 19 Jan 2023 21:21:05 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so3902083pjl.0;
        Thu, 19 Jan 2023 21:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BU8B2SB14Z6ZiYODQrWdR57MbN6lG8lvjV5NsFbBUic=;
        b=YJg5U5BwBM46xaurgJGanFwE5EoWzCswgWMMaFfWrewzypGOh7FGM3byTxlhFoHCmH
         cVMETyezTIa0lPyMBbmCaJ/4It7aWDKz2WcqjBK2a1TlHheqRvQO+rcQ/Gci/QUyqBu6
         aj8Zs6/xcOpb9blzvcU1zHx86gMpIYU0X9MGExU4iqEn2U6vEMew9S17D3iJXsHvORmA
         0SWZKQcu9nPZ/WUUSpu/bF+ieEAed9PsSC4nqE2frOC/iE8P8A343TlV/F3IFpYYxChk
         HbhyDuDSNFqlYaRbUArfJ5UlgBcY7smkpZG5a3/bmMtjOXTUNeJQytdcLc6XXHN+7Jp5
         vOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU8B2SB14Z6ZiYODQrWdR57MbN6lG8lvjV5NsFbBUic=;
        b=V4UYdNu1+oaKpKsC8UGrJ+EiiWuKADDgPl2MruVlm1gg+ws/XqOgEKVLJ3xoiKg0nU
         EJStsbpytiAIR1NX76CQR6P/pvTcpRCe/rzD3mKuQLBGtSSRLomWnpuGXj45H3kkgaEd
         K1Gsvo1tkjyPr55a5ABTIumUB+xoRsrNqQr/tTiYvocXDwhPFnBVn7bGmhyMVdwiD7SK
         PzFOSGYM3SOVzuHyfoTNuJjI8+4LJA2QqBDXwRg4uzFAyqncEPEgQq28NWScB4X/OvJU
         NcjFDRnc0misCtXphzsu4Opvw7jspG5yCOIWeJgNwj59eQnmtPunMP/aQ01nF5hexyaJ
         kpfA==
X-Gm-Message-State: AFqh2koLVns3nIgnDeORSFg7PiMfJ8x/S0Rl635qGi+HHuB0XxPNnmzD
        ZgkFcp4Y4lVugXb+fKTp++dOv99jKCA=
X-Google-Smtp-Source: AMrXdXsjzJEh5ZJAFX5DlvMyjrvo5UIiDllgPlJZQD6NYO63UWpuz6C2iGhulJtGFD7QHEiW7+0fcg==
X-Received: by 2002:a17:90b:4b8a:b0:229:f5a2:80c9 with SMTP id lr10-20020a17090b4b8a00b00229f5a280c9mr3212910pjb.49.1674192064630;
        Thu, 19 Jan 2023 21:21:04 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id w19-20020a17090aea1300b0020dc318a43esm554490pjy.25.2023.01.19.21.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 21:21:04 -0800 (PST)
Date:   Fri, 20 Jan 2023 10:51:01 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 3/8] bpf: Disallow NULL PTR_TO_MEM for trusted
 kfuncs
Message-ID: <20230120052101.sevhc4jybcm6onu2@apollo>
References: <20230119235833.2948341-1-void@manifault.com>
 <20230119235833.2948341-4-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119235833.2948341-4-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 05:28:28AM IST, David Vernet wrote:
> KF_TRUSTED_ARGS kfuncs currently have a subtle and insidious bug in
> validating pointers to scalars. Say that you have a kfunc like the
> following, which takes an array as the first argument:
>
> bool bpf_cpumask_empty(const struct cpumask *cpumask)
> {
> 	return cpumask_empty(cpumask);
> }
>
> ...
> BTF_ID_FLAGS(func, bpf_cpumask_empty, KF_TRUSTED_ARGS)
> ...
>

This is known and expected.

> If a BPF program were to invoke the kfunc with a NULL argument, it would
> crash the kernel. The reason is that struct cpumask is defined as a
> bitmap, which is itself defined as an array, and is accessed as a memory
> address memory by bitmap operations. So when the verifier analyzes the
> register, it interprets it as a pointer to a scalar struct, which is an
> array of size 8. check_mem_reg() then sees that the register is NULL,
> and returns 0, and the kfunc crashes when it passes it down to the
> cpumask wrappers.
>
> To fix this, this patch adds a check for KF_ARG_PTR_TO_MEM which
> verifies that the register doesn't contain a NULL pointer if the kfunc
> is KF_TRUSTED_ARGS.
>
> This may or may not be desired behavior. Some kfuncs may want to
> allow callers to pass NULL-able pointers. An alternative would be adding
> a KF_NOT_NULL flag and leaving KF_TRUSTED_ARGS alone, though given that
> a kfunc is saying it wants to "trust" an argument, it seems reasonable
> to prevent NULL.
>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  kernel/bpf/verifier.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9fa101420046..28ccb92ebe65 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9092,6 +9092,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  					i, btf_type_str(ref_t), ref_tname, PTR_ERR(resolve_ret));
>  				return -EINVAL;
>  			}
> +			if (is_kfunc_trusted_args(meta) && register_is_null(reg)) {
> +				verbose(env, "NULL pointer passed to trusted arg%d\n", i);
> +				return -EACCES;
> +			}
> +

Current patch looks like a stop gap solution. Just checking for register_is_null
is not enough, what about PTR_MAYBE_NULL? That can also be passed. Some
arguments can be both PTR_TO_BTF_ID and PTR_TO_MEM, so it will be bypassed in
the other case because this check is limited to KF_ARG_PTR_TO_MEM. It would
probably be better to disallow NULL by default and explicitly tag the argument
with __or_null to indicate that NULL is accepted. Seems like a much better
default to me.
