Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346F56958D6
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 07:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBNGJo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 01:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjBNGJf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 01:09:35 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235A0199DD
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 22:09:34 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id k16so5957628ejv.10
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 22:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pOXPbpb099h/zrHT7fq6IKdnJyG/KE+eGi/Za95qQsw=;
        b=MWVhn70ulGKdRlrktRJJhUZFFmgLoJAicyu2FDkXTL7kGo3u3oTpi/LdTZu7po1Z83
         L5gex48uVf6nhw9fZOububul7zAiYXobLocgQfXv2izi7AAyNldMxt/q+2Mc0bL9pFnY
         w5D4gqLIEvZwen8BBYtYzYnhbNVPotWvbvP9iFxR9vHK38pRGHuZdrj5YUzIo01/ruaB
         VNKLOKKj5jkCmuxMDW7NVY5dZp96LElm29LKKiUbZwRjblSKj3CWK59JA8aGnPZDOM+a
         LKgWR6SiBcwrr75OGj6wDBTEwckdPQXAtqA1DkZckhfAadeKIvUnejv2jTBzYskZQkmi
         jjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOXPbpb099h/zrHT7fq6IKdnJyG/KE+eGi/Za95qQsw=;
        b=jfvHgxsOX0FgZW06tBiNbpAwXYRYyy90UQQL7oITLp+ZrhM7UfPjsPMFXcJOulmwaw
         L94OCD95BxVX3Y5KNKmlwiC0UguR9J5FmuXBK05+kH9hN0xJpKxLJU0v74cPH7D1DG6A
         VcMoyv7lGhbhUXBK5wvniUFFRvS7GOIG0vY/OMDn/pv8VVYQalYjzeI2hwzUuqwXTG35
         bL7kOudltLGTid+puPtOD3xA07ShR6M/qSqEAT1390Z2OpNV6COXzhPANZWaVDFPQ0gJ
         TsTCpmT84KcvQM5cTY5qc1YYzELXnMPFp9N2ngDvNbFyyAROdEYDzHseVUCGOqJIIygH
         WylA==
X-Gm-Message-State: AO0yUKVcDSAUk1kBMpmCn6IDNklNDZZJ36s8YJGUtESrEMi8whQ5HD9G
        j5MiYvzFbU7MXSvDVFIhzShOZP1uAj+tQmAUxGr0vAq3/Ck=
X-Google-Smtp-Source: AK7set8VVnAnfOwVrs6ycYxeAl7Sy8TX+rFMJHi7E/kHGkIVwTgiSgGr+Mv3+p6iA4B18dJ3AoA7FPYT1+k9xHkOUI8=
X-Received: by 2002:a17:906:4d97:b0:88d:ba79:4315 with SMTP id
 s23-20020a1709064d9700b0088dba794315mr6772940eju.5.1676354972490; Mon, 13 Feb
 2023 22:09:32 -0800 (PST)
MIME-Version: 1.0
References: <1675949331-27935-1-git-send-email-alan.maguire@oracle.com> <CAADnVQ+hfQ9LEmEFXneB7hm17NvRniXSShrHLaM-1BrguLjLQw@mail.gmail.com>
In-Reply-To: <CAADnVQ+hfQ9LEmEFXneB7hm17NvRniXSShrHLaM-1BrguLjLQw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 13 Feb 2023 22:09:21 -0800
Message-ID: <CAADnVQJe6dRnhbSk92g5Np0tXyMxWLD+8LqUxYfYPr7dWkxzSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add --skip_encoding_btf_inconsistent_proto,
 --btf_gen_optimized to pahole flags for v1.25
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 13, 2023 at 7:12 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Feb 9, 2023 at 5:29 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > v1.25 of pahole supports filtering out functions with multiple
> > inconsistent function prototypes or optimized-out parameters
> > from the BTF representation.  These present problems because
> > there is no additional info in BTF saying which inconsistent
> > prototype matches which function instance to help guide
> > attachment, and functions with optimized-out parameters can
> > lead to incorrect assumptions about register contents.
> >
> > So for now, filter out such functions while adding BTF
> > representations for functions that have "."-suffixes
> > (foo.isra.0) but not optimized-out parameters.
> >
> > This patch assumes changes in [1] land and pahole is bumped
> > to v1.25.
> >
> > [1] https://lore.kernel.org/bpf/1675790102-23037-1-git-send-email-alan.maguire@oracle.com/
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > ---
> >  scripts/pahole-flags.sh | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> > index 1f1f1d3..728d551 100755
> > --- a/scripts/pahole-flags.sh
> > +++ b/scripts/pahole-flags.sh
> > @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
> >         # see PAHOLE_HAS_LANG_EXCLUDE
> >         extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
> >  fi
> > +if [ "${pahole_ver}" -ge "125" ]; then
> > +       extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
> > +fi
>
> We landed this too soon.
> #229     tracing_struct:FAIL
> is failing now.
> since bpf_testmod.ko is missing a bunch of functions though they're global.
>
> I've tried a bunch of different flags and attributes, but none of them
> helped.
> The only thing that works is:
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 46500636d8cd..5fd0f75d5d20 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -28,6 +28,7 @@ struct bpf_testmod_struct_arg_2 {
>         long b;
>  };
>
> +__attribute__((optimize("-O0")))
>  noinline int
>  bpf_testmod_test_struct_arg_1(struct bpf_testmod_struct_arg_2 a, int
> b, int c) {
>
> We cannot do:
> --- a/tools/testing/selftests/bpf/bpf_testmod/Makefile
> +++ b/tools/testing/selftests/bpf/bpf_testmod/Makefile
> @@ -10,7 +10,7 @@ endif
>  MODULES = bpf_testmod.ko
>
>  obj-m += bpf_testmod.o
> -CFLAGS_bpf_testmod.o = -I$(src)
> +CFLAGS_bpf_testmod.o = -I$(src) -O0
>
> The build fails due to asm stuff.
>
> Maybe we should make scripts/pahole-flags.sh selective
> and don't apply skip_encoding_btf_inconsiste to bpf_testmod ?
>
> Thoughts?

It's even worse with clang compiled kernel:
    WARN: resolve_btfids: unresolved symbol tcp_reno_cong_avoid
    WARN: resolve_btfids: unresolved symbol dctcp_update_alpha
    WARN: resolve_btfids: unresolved symbol cubictcp_cong_avoid
    WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_timestamp
    WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
    WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
    WARN: resolve_btfids: unresolved symbol bpf_task_acquire_not_zero
    WARN: resolve_btfids: unresolved symbol bpf_rdonly_cast
    WARN: resolve_btfids: unresolved symbol
bpf_kfunc_call_test_static_unused_arg
    WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_ref

so I reverted this commit for now.
Looks like pahole with skip_encoding_btf_inconsistent_proto needs
to be more accurate.
It's way too aggressive removing valid functions.
