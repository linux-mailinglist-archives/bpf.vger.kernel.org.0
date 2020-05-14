Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D7D1D2754
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 08:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgENGO3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 02:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgENGO3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 02:14:29 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ECFC061A0C
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 23:14:29 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id v15so1147732qvr.8
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 23:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NuVATXAFpcn9GL6sWvoXMpEqVGv7qA0n+rrsgz8aWpU=;
        b=aYX90yKgZitBVNGtKUN50It5cqLTzUW+LxOmROWuVdjSwGxPJByacDAacN2RfbBWlD
         OPan/OeXemBCaWD9eXpZmr7HRa6O/Smh+JFe1nShHh0RDWuwjisiVlF66vK1drGMMHbe
         J5yxkFpRDK4XfkiKhxfKYtVVARjTISaEyKYSTht0iqBfIQVgRJDCLPAuBEJ9qK5c4DKp
         21tpbLBnujyPE3TLL6jvo5r2HRAZ3+zdQBwqssebta3cYEcX4NWalOrF5u4v2ppYdYBC
         MUj2XziyO7Ldor5tMDMaci2M9vjdhZH4T1FyvOp4MhOfHitUgQk2OsD0W/npFU/Y+TDC
         8ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NuVATXAFpcn9GL6sWvoXMpEqVGv7qA0n+rrsgz8aWpU=;
        b=uKwnzrNgYKGots9UYm3ql43fyuYE0T9KCSqwGxlphmxkG0DmKWL0meIw7+BFXq1idf
         5J94wn3FOJs5rjQxN8vHCWCJtB2H7GUmdbtnKgEsdsNItZpiK1J2WHz3fu4p4ZBFcagF
         DQ1lHUeRUL3+BUgCHa84j1rdu4DPK+ckphrTmJGb45MYndMNhvhSAVvdkVuajzCS4mXE
         C/fxHbGdLZMLoqWW6DBZlMy7nH8fQBAtNP2x2NfMo5II4ULZpmkk+sCN6ViYaPbHZ1bP
         ZnDVnaO+VAtKf/EJriu6Ffjw8eRZix9Mjv2a91x6ob8Z/fZAkKkOyDhQ+lsHLeKTmp5e
         KGMA==
X-Gm-Message-State: AOAM531a9wsChQ/92A0i4EswNNruFGPHdKOgw87p4ydBTN3yPb+HLM2W
        ZTxc5CsaIDg1FdEmWtL0aAOS10Nr91sMqAmOXcA/2A==
X-Google-Smtp-Source: ABdhPJwTlygUiljdRYC9mbDD3xpPDlE7cWbxkfCDEBmKcWJ/gZmp5D2LJSR561xDFhGORUu7j3LYXZly2fqLd7lkWjc=
X-Received: by 2002:ad4:55ea:: with SMTP id bu10mr3309300qvb.163.1589436868129;
 Wed, 13 May 2020 23:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200514053205.1298315-1-yhs@fb.com> <20200514053206.1298415-1-yhs@fb.com>
In-Reply-To: <20200514053206.1298415-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 May 2020 23:14:17 -0700
Message-ID: <CAEf4Bzbks=ti1OuXg3d_Nc0Vm5cvv-ceLB+Dq8OZgHdBT+SA1Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: enforce returning 0 for fentry/fexit progs
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 13, 2020 at 10:32 PM Yonghong Song <yhs@fb.com> wrote:
>
> Currently, tracing/fentry and tracing/fexit prog
> return values are not enforced. In trampoline codes,
> the fentry/fexit prog return values are ignored.
> Let us enforce it to be 0 to avoid confusion and
> allows potential future extension.
>
> This patch also explicitly added return value
> checking for tracing/raw_tp, tracing/fmod_ret,
> and freplace programs such that these program
> return values can be anything. The purpose are
> two folds:
>  1. to make it explicit about return value expectations
>     for these programs in verifier.
>  2. for tracing prog_type, if a future attach type
>     is added, the default is -ENOTSUPP which will
>     enforce to specify return value ranges explicitly.
>
> Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Looks good, except a nit below.

Acked-by: Andrii Nakryiko <andriin@fb.com>

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fa1d8245b925..2d80cce0a28a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7059,6 +7059,24 @@ static int check_return_code(struct bpf_verifier_env *env)
>                         return 0;
>                 range = tnum_const(0);
>                 break;
> +       case BPF_PROG_TYPE_TRACING:
> +               switch ((env->prog->expected_attach_type)) {

nit: extra pair of ()?


> +               case BPF_TRACE_FENTRY:
> +               case BPF_TRACE_FEXIT:
> +                       range = tnum_const(0);
> +                       break;
> +               case BPF_TRACE_RAW_TP:
> +               case BPF_MODIFY_RETURN:
> +                       return 0;
> +               default:
> +                       return -ENOTSUPP;
> +               }
> +
> +               break;
> +       case BPF_PROG_TYPE_EXT:
> +               /* freplace program can return anything as its return value
> +                * depends on the to-be-replaced kernel func or bpf program.
> +                */
>         default:
>                 return 0;
>         }
> --
> 2.24.1
>
