Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E704BEF9B
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 03:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbiBVCYL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Feb 2022 21:24:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiBVCYK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Feb 2022 21:24:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A0725C50
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 18:23:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D93C614EC
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 02:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FF8C340E9
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 02:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645496625;
        bh=u+0uuLt2FD+sYLZ8lyLSp1rJW1aRqJBzPGrMJ1SzMRQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a80/oSOtDaCUbpfl5hpTL7Nj0Jl8SeWFYLdx7WeAvJu5mXjX9TjNM9TtOxapk/BIN
         corUvKYFcG51+fH7/tF8uv4EW9JbfNB9nzz4CNeEGRVKLjT+f815vNv/zzUhnXlzsh
         V/zOeCp8Kw6xlj1NtXV+yp/CyUhqFaG15P6Eyh29g5bbXBAl3VUZGdOByRJR2dEllY
         FUCTmLhyVqZxDJ5CUbO2bsIXeVRwm6NdKYwipLOblMCBqF6+T0nHrrRmVmrlM6PdnD
         iGa8BhOLDojVW+aIiXiSC+L3ixTnqCeUzJGX8c+kGWFbWDs6N2LUcbCdh30nz0x2RR
         O+5Hh/xSZvgXw==
Received: by mail-yb1-f180.google.com with SMTP id c6so38085667ybk.3
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 18:23:45 -0800 (PST)
X-Gm-Message-State: AOAM532XSQNVAtDmGZweeuaM30XiC/yvT/TXwa71kVlpV3Os0NdzBPDq
        v5aL9gFARtRnUBIyQkkBXF6Jm2n4an1S59PhH+g=
X-Google-Smtp-Source: ABdhPJyY1KSzSTsR5NYz2Mq/GUGr0Ay7t8zk4ucGqi9F//y4zc4QCXszC8/9PRO80kg/IyY0FiWxv7GLEk1YiJ/6+UM=
X-Received: by 2002:a25:c89:0:b0:61d:a1e8:fd14 with SMTP id
 131-20020a250c89000000b0061da1e8fd14mr20683341ybm.322.1645496624629; Mon, 21
 Feb 2022 18:23:44 -0800 (PST)
MIME-Version: 1.0
References: <20220220023138.2224652-1-memxor@gmail.com>
In-Reply-To: <20220220023138.2224652-1-memxor@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 21 Feb 2022 18:23:33 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6Y=4dSgu=Ax+4YL7ED_yXm4y7P04rxG3PfzD7mU_=8jw@mail.gmail.com>
Message-ID: <CAPhsuW6Y=4dSgu=Ax+4YL7ED_yXm4y7P04rxG3PfzD7mU_=8jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add test for reg2btf_ids out of
 bounds access
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 19, 2022 at 6:31 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> This test tries to pass a PTR_TO_BTF_ID_OR_NULL to the release function,
> which would trigger a out of bounds access without the fix in commit
> 45ce4b4f9009 ("bpf: Fix crash due to out of bounds access into reg2btf_ids.")
> but after the fix, it should only index using base_type(reg->type),
> which should be less than __BPF_REG_TYPE_MAX, and also not permit any
> type flags to be set for the reg->type.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/testing/selftests/bpf/verifier/calls.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> index 829be2b9e08e..0a8ea60c2a80 100644
> --- a/tools/testing/selftests/bpf/verifier/calls.c
> +++ b/tools/testing/selftests/bpf/verifier/calls.c
> @@ -96,6 +96,25 @@
>                 { "bpf_kfunc_call_test_mem_len_fail1", 2 },
>         },
>  },
> +{
> +       "calls: trigger reg2btf_ids[reg->type] for reg->type > __BPF_REG_TYPE_MAX",
> +       .insns = {
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_SCHED_CLS,
> +       .result = REJECT,
> +       .errstr = "arg#0 pointer type STRUCT prog_test_ref_kfunc must point",

Why do we stop errstr at "must point"?

> +       .fixup_kfunc_btf_id = {
> +               { "bpf_kfunc_call_test_acquire", 3 },
> +               { "bpf_kfunc_call_test_release", 5 },
> +       },
> +},
>  {
>         "calls: basic sanity",
>         .insns = {
> --
> 2.35.1
>
