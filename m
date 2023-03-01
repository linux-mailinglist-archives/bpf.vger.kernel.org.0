Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A106A7404
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 20:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCATHU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 14:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCATHU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 14:07:20 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD54C6C2;
        Wed,  1 Mar 2023 11:07:18 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o15so55597787edr.13;
        Wed, 01 Mar 2023 11:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677697637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0SrDaMx47dZSDAQhcmlHOV2N9fQVTDg09mPQlLxC9M=;
        b=CDpRsh199rWY38RyCCGharyYY1hkwYA8Ws9uj5V2vaWsY2G3QxTsVJGjaz2EVqEA9+
         8hqIzTazTS3T8bQuDm7aeR7pprJL3QihwiNXUa5W3iGs46jxNkxOdQivQF7Zzb1T3mQo
         5TthgQrNgwZ6GEPylDOEWWnvZjXbS1nt5C0vuuQHQ9F97t4qWKy+1bQG3gR6TpHZbWwY
         uijByKpFzIyQBQ1xxNdYB6GyM8iUEUrQ6AS3KKu96xjSDcoakn3uzcne/Dn+10cZGNgt
         CRdqOSayQWN7eeHOlgxeoyUr9NRuVVBFzcCC+DlTSLjafAkzMaa7sb7kn+7uzzdk3yON
         P1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677697637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0SrDaMx47dZSDAQhcmlHOV2N9fQVTDg09mPQlLxC9M=;
        b=gvhd9363lPa2Z3WLqR0z4TNo77ApeAi8fj4EUz/wjk0lui2ugAv1UVad3SMkgBB+yU
         B+MjWNFc76FCK4YQXuey1VpLAxHWNDvU1wPTXbg7TepL6ZyVrvyYdr5YfCSk+h2LvpsZ
         LXsBzhlLKFCAjKIbf0MyX82vAIulyUxQgY0KR7NTeON7ZH4koHqvMwSECSo1yIr0gzVv
         lduG42ekgSgcQsvEfYhFjzuTOW16rxbdgYSfMzE4vAHxKxHgdlZj5nTf4TGYfGQQJLO7
         O8IIrw48I3OJGRcD5mtJsql+PoLxPprc+gtKXPnlp5pSHX/WlCsF62Rvm51Nc/0hzk/2
         O5WQ==
X-Gm-Message-State: AO0yUKX7N7s49lMdtWIIKaB+urlCnNie4rQS3GwPERbmcyPFFIugD6m7
        12XWZmq0PcOFBQvkvfk6TiBbmCgY8clYskKwi83VdBHy32E=
X-Google-Smtp-Source: AK7set+M+69w2igi8dfZYPhsZRTpH2ly6t8MSR4QfiEaQRo/nk897/ARs1e+HbzcbbSOkrhHiJYMdWktV6uvyOnBuPU=
X-Received: by 2002:a50:cdd5:0:b0:4bc:13f5:68a5 with SMTP id
 h21-20020a50cdd5000000b004bc13f568a5mr1835748edj.5.1677697637021; Wed, 01 Mar
 2023 11:07:17 -0800 (PST)
MIME-Version: 1.0
References: <1677585781-21628-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1677585781-21628-1-git-send-email-yangtiezhu@loongson.cn>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Mar 2023 11:07:05 -0800
Message-ID: <CAEf4BzbZogSTyvF4bPB8w_1KNrBOLOPKBWbo9na3_9JZSJnuAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Set __BITS_PER_LONG if target
 is bpf for LoongArch
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 28, 2023 at 4:03=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> If target is bpf, there is no __loongarch__ definition, __BITS_PER_LONG
> defaults to 32, __NR_nanosleep is not defined:
>
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
>   #define __NR_nanosleep 101
>   __SC_3264(__NR_nanosleep, sys_nanosleep_time32, sys_nanosleep)
>   #endif
>
> Work around this problem, by explicitly setting __BITS_PER_LONG to
> __loongarch_grlen which is defined by compiler as 64 for LA64, then
> __NR_nanosleep can also be defined to fix the following build errors:
>
>   clang  -g -Werror ... -target bpf -c progs/test_vmlinux.c ...
>   progs/test_vmlinux.c:24:18: error: use of undeclared identifier '__NR_n=
anosleep'
>           if (args->id !=3D __NR_nanosleep)
>                           ^
>   progs/test_vmlinux.c:42:12: error: use of undeclared identifier '__NR_n=
anosleep'
>           if (id !=3D __NR_nanosleep)
>                     ^
>   progs/test_vmlinux.c:60:12: error: use of undeclared identifier '__NR_n=
anosleep'
>           if (id !=3D __NR_nanosleep)
>                     ^
>   3 errors generated.

Not clear what __NR_nanosleep part has to do with this commit. I
dropped this part from the commit message. Applied to bpf-next.

>
> This is similar with commit 36e70b9b06bf ("selftests, bpf: Fix broken
> riscv build").
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/testing/selftests/bpf/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index b677dcd..f40606a 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -338,7 +338,8 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)=
/resolve_btfids        \
>  define get_sys_includes
>  $(shell $(1) $(2) -v -E - </dev/null 2>&1 \
>         | sed -n '/<...> search starts here:/,/End of search list./{ s| \=
(/.*\)|-idirafter \1|p }') \
> -$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{pri=
ntf("-D__riscv_xlen=3D%d -D__BITS_PER_LONG=3D%d", $$3, $$3)}')
> +$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{pri=
ntf("-D__riscv_xlen=3D%d -D__BITS_PER_LONG=3D%d", $$3, $$3)}') \
> +$(shell $(1) $(2) -dM -E - </dev/null | grep '__loongarch_grlen ' | awk =
'{printf("-D__BITS_PER_LONG=3D%d", $$3)}')
>  endef
>
>  # Determine target endianness.
> --
> 2.1.0
>
