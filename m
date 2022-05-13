Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E58525A56
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 05:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348813AbiEMDo7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 23:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355420AbiEMDo6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 23:44:58 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FBA274A1B
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 20:44:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id f4so7484637iov.2
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 20:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cOJOELFTrSOl+4ppFWRF9IlkFBUEk/qDNiFQaF7Rtw0=;
        b=pJdNRQvqTLLOMUjNL3q6NxDMXjgGbXgvlSNBYzfxSAO9jbyzNhflMAPXHkCIpVzttH
         6kHBpuAySb9+OVcBhGrdFIuQmOc1kXPDciQnF/62G4F4drobwCVP0AKWIbZwbZ6QAKiI
         SkFsqQb/xVZgciIvPi91r8/CNv3Y50M+FBDa3lgL1Vus348F8pE/oWWH5cO2XaK4CTDA
         Ze7Vj0UUlazIBdcFVRfWeSL/f7z+MeeQMMwJyt52tMiGy8wJm9GlmqO0tl1xvhRSGaPq
         gM2g3HhyK/54SPVDYj1zcbPVupAVkLLoP9J8vGs2/FC6mBiMkt5ilNR3VbonVGSzwI+A
         FlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOJOELFTrSOl+4ppFWRF9IlkFBUEk/qDNiFQaF7Rtw0=;
        b=7UvZXeXUH0IgYL+dCDxfVJlU8IVUjrB04aEXRbyyPXgYZz186jch+piH2saWwqKpEe
         opLfbstOBaRZnoyB8/SSk0iVIxL+aWycvrQOIOjW3OeaPPo8ub1nqEQKbau9+5K5Em82
         1nhhDjIe+Vhb3hw/6Ks4sQKyUAJNbpjlEclRMdO0HrG69FM/yfIb1H6OaGaM0IB2msp4
         MXdTR/lPRJeZGl8Go2BC2tCfTdZbC0koXpm/zNWjRBhIbYiLJpaxPPswwApz6wj311Be
         uolDOBf2aid9T+mUQ7YkyqZ85b7bgZGUH//KmFK1Mu+ox7iij2fu24mnC678++zGJ4tT
         inOA==
X-Gm-Message-State: AOAM530lYzjn1us/vb+22Z5MTAByHJ29sR3uG1GQxYNaO9OJwJlCv/ft
        vz5kUol+d9iVZ3cEeWXkU4C5aD+po3mfI+RuymY=
X-Google-Smtp-Source: ABdhPJyOG9OkQ9NSh28fXCBqTqO0bPL4394da3R99sue3K0jezkq1m2nF+xNpuveTAGmNT77fuBlSZPidMwKKqkRTRE=
X-Received: by 2002:a5e:8e42:0:b0:657:bc82:64e5 with SMTP id
 r2-20020a5e8e42000000b00657bc8264e5mr1411162ioo.112.1652413497535; Thu, 12
 May 2022 20:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220513011025.13344-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20220513011025.13344-1-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 May 2022 20:44:46 -0700
Message-ID: <CAEf4BzZP__5CGCQM+f6RG3Vpiw-Usi9aR_O=7a7WA4N10eFhiQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix combination of jit blinding and
 pointers to bpf subprogs.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 6:10 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> The combination of jit blinding and pointers to bpf subprogs causes:
> [   36.989548] BUG: unable to handle page fault for address: 0000000100000001
> [   36.990342] #PF: supervisor instruction fetch in kernel mode
> [   36.990968] #PF: error_code(0x0010) - not-present page
> [   36.994859] RIP: 0010:0x100000001
> [   36.995209] Code: Unable to access opcode bytes at RIP 0xffffffd7.
> [   37.004091] Call Trace:
> [   37.004351]  <TASK>
> [   37.004576]  ? bpf_loop+0x4d/0x70
> [   37.004932]  ? bpf_prog_3899083f75e4c5de_F+0xe3/0x13b
>
> The jit blinding logic didn't recognize that ld_imm64 with an address
> of bpf subprogram is a special instruction and proceeded to randomize it.
> By itself it wouldn't have been an issue, but jit_subprogs() logic
> relies on two step process to JIT all subprogs and then JIT them
> again when addresses of all subprogs are known.
> Blinding process in the first JIT phase caused second JIT to miss
> adjustment of special ld_imm64.
>
> Fix this issue by ignoring special ld_imm64 instructions that don't have
> user controlled constants and shouldn't be blinded.
>
> Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Thanks for the fix, LGTM.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  kernel/bpf/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 76f68d0a7ae8..9cc91f0f3115 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1434,6 +1434,16 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
>         insn = clone->insnsi;
>
>         for (i = 0; i < insn_cnt; i++, insn++) {
> +               if (bpf_pseudo_func(insn)) {
> +                       /* ld_imm64 with an address of bpf subprog is not
> +                        * a user controlled constant. Don't randomize it,
> +                        * since it will conflict with jit_subprogs() logic.
> +                        */
> +                       insn++;
> +                       i++;
> +                       continue;
> +               }
> +
>                 /* We temporarily need to hold the original ld64 insn
>                  * so that we can still access the first part in the
>                  * second blinding run.
> --
> 2.30.2
>
