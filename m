Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6858695735
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 04:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjBNDNM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 22:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjBNDNK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 22:13:10 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619C3C655
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 19:12:46 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ml19so37026973ejb.0
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 19:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+PUcZTJD0vQzkihOwn3+I0aNrgza03I4pCFSaz3307s=;
        b=iGrcTgxXWLVKtuIvy2YSm+1rkwcx+NP8sKx5xxySZZJFvMUxaqanpCXVc3HDuC+NCy
         /TNDaRIBg+l14+Bkh/73+9l+pnAcMGKNM95/zIPiQ0R8fI4+vnsvjTurrkqXPLr0uQvD
         dDZSDFoVvM9b0/nkiCCsHgk9RD44Hcds+fwIi1B/qqLOGdT1ADL+/mX+t1A8mdtlsVLH
         7LODO5Ots/8MKSa0NXQy/Pgxq6sbHI6GYBS7MAe5WOywQI0jXIMgo+O+AINp/PJRQYVY
         NtnESz1ebZqfZ1zd3mggEJrIHPCWYG5BEGTtsuN2K0hpN01kJK12XW03Hiq3a8DhDTQx
         NqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+PUcZTJD0vQzkihOwn3+I0aNrgza03I4pCFSaz3307s=;
        b=oHZApuERSaRHayiziOAmw3dauuPO0ic3uMQrd7bH7HLvsNpCEz5wYXDpFHkA84FvVq
         hAmcRoNep77DdqbdVMOZDiDaXUVdFXs9MMGm7TOpP3BsIDvNozU1wcMAEVp+QejCQn2G
         KdSSSOZ8h1Pa+BT9v1o7sGYzLdlVxw3i/Xy8OkCCLlGZNeGiDB7dKAIKLlhuMu5m18Jy
         zaqTk/sRL/YCbZF5O/zXcZ1K2Vdqsb+0eaj5tzhP/1o5B7ucCR4ZagapJx2sBmc2IRS3
         t5fiDUO4tAkUAEU/Otw/G6JCXHdsjp4wwkmxB/bdCiuS3Mmrxh/fJm95wIA2UqHVmvIz
         DHyQ==
X-Gm-Message-State: AO0yUKXnBzZ3ZL2c0vCCjTgz6pi7mO4yXYOiUugpErAwffFbDe9tB/Rs
        XXx2uqbp1A1eFuGUdrbeeeFMKElxnfgBKqblXBM=
X-Google-Smtp-Source: AK7set9FBNZ+dyeaXtdX/3XTiq9ymny18YlSnSQPo4z3xgYrLKV0MWpu/cbg0ebkPJj0a0F/DPjn/Ivh5m5jztjyXro=
X-Received: by 2002:a17:907:984a:b0:87b:dce7:c245 with SMTP id
 jj10-20020a170907984a00b0087bdce7c245mr575781ejc.3.1676344364743; Mon, 13 Feb
 2023 19:12:44 -0800 (PST)
MIME-Version: 1.0
References: <1675949331-27935-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1675949331-27935-1-git-send-email-alan.maguire@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 13 Feb 2023 19:12:33 -0800
Message-ID: <CAADnVQ+hfQ9LEmEFXneB7hm17NvRniXSShrHLaM-1BrguLjLQw@mail.gmail.com>
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

On Thu, Feb 9, 2023 at 5:29 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> v1.25 of pahole supports filtering out functions with multiple
> inconsistent function prototypes or optimized-out parameters
> from the BTF representation.  These present problems because
> there is no additional info in BTF saying which inconsistent
> prototype matches which function instance to help guide
> attachment, and functions with optimized-out parameters can
> lead to incorrect assumptions about register contents.
>
> So for now, filter out such functions while adding BTF
> representations for functions that have "."-suffixes
> (foo.isra.0) but not optimized-out parameters.
>
> This patch assumes changes in [1] land and pahole is bumped
> to v1.25.
>
> [1] https://lore.kernel.org/bpf/1675790102-23037-1-git-send-email-alan.maguire@oracle.com/
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> ---
>  scripts/pahole-flags.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> index 1f1f1d3..728d551 100755
> --- a/scripts/pahole-flags.sh
> +++ b/scripts/pahole-flags.sh
> @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
>         # see PAHOLE_HAS_LANG_EXCLUDE
>         extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
>  fi
> +if [ "${pahole_ver}" -ge "125" ]; then
> +       extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
> +fi

We landed this too soon.
#229     tracing_struct:FAIL
is failing now.
since bpf_testmod.ko is missing a bunch of functions though they're global.

I've tried a bunch of different flags and attributes, but none of them
helped.
The only thing that works is:
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 46500636d8cd..5fd0f75d5d20 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -28,6 +28,7 @@ struct bpf_testmod_struct_arg_2 {
        long b;
 };

+__attribute__((optimize("-O0")))
 noinline int
 bpf_testmod_test_struct_arg_1(struct bpf_testmod_struct_arg_2 a, int
b, int c) {

We cannot do:
--- a/tools/testing/selftests/bpf/bpf_testmod/Makefile
+++ b/tools/testing/selftests/bpf/bpf_testmod/Makefile
@@ -10,7 +10,7 @@ endif
 MODULES = bpf_testmod.ko

 obj-m += bpf_testmod.o
-CFLAGS_bpf_testmod.o = -I$(src)
+CFLAGS_bpf_testmod.o = -I$(src) -O0

The build fails due to asm stuff.

Maybe we should make scripts/pahole-flags.sh selective
and don't apply skip_encoding_btf_inconsiste to bpf_testmod ?

Thoughts?
