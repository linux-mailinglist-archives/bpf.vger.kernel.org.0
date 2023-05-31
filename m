Return-Path: <bpf+bounces-1526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A08F07189C7
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 21:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390821C20EB2
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 19:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F4119E4C;
	Wed, 31 May 2023 19:02:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7AD805
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 19:02:30 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA95A101
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 12:02:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51458187be1so149173a12.2
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 12:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685559747; x=1688151747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1vDVFGQ7VOmpDBUhP1icyx2/StMiRXK79o+HWNHiMI=;
        b=SeARb8DfaDq8H6X/069XMeEjri2XdDszi4yEWvU40HU8WmqE8127MTl8QV7q2h7Ido
         Kx8Nq8QQntvp4tIJ8b79+sXR0JNTo+IsdO9DsVDfRQXAzTtXAi6O+FKvUd1gWP9aEoD6
         UM2WCET+HHSYWJSxHLzZkoCs9z9IID3+20PcRxxcdmQrO/1P+i897chjTBlFMwoR+iMl
         DlFeu4ISppPtBo8gRqdA4DxWVgWMUeXX4TvwT7Y1McVqSNK+RkQiVBUnIv2YFzTR6L8F
         18+du7boYy/viuuCWCkv+NgL1VzDuESDgtkEEhBGGsMxa+QofDPmgn//YG9mpCQGdayN
         J5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685559747; x=1688151747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1vDVFGQ7VOmpDBUhP1icyx2/StMiRXK79o+HWNHiMI=;
        b=AhQbDcDc/03+7m2iMYhhAckZ9ZuRGFYghfUG2tpNc+6D/Bb5QZjgyA+uRXPoRE3PU0
         OYYRHDJi/OJspQBms1I49WxYZdqv90dqsLhePDq9dqrcuJJyurZwwfRzZFxf1I5QiVRE
         e83QZ1b5LxJZ57HpQFRWYX76XrXCz+RNzs88GVbfYmXt33awTzoBKxsGYA0P/YJMgXeO
         PcWGw8J14cqk8S1mPMyaARkhuJTTcM4YMQO0QjFvu3H1Z3A/w5gAOli5lGHcpJQb0Cnp
         +pbByb762qQfSf7zScQ+YbNr8X67Y+QF+2LwLJdAkUf6uh47qZlLM1rMaX0to8eUWgE8
         NHew==
X-Gm-Message-State: AC+VfDxeDhiZvm2/yZ6zpN2hez6ooWDjkbAGNnq3U8JIvkHsmZwUSpAM
	+Ab7w1Gr6eu1ATqptv5vhLXfnckP6CJ0xWT1H0M=
X-Google-Smtp-Source: ACHHUZ5epQT0weHGsR+uvpPQjEpZVOlYS/3A9jLAuZ9YI2C4wc2dqXz4DRc3U33biip3b4dSunEAYTzUITbNuXyjLgE=
X-Received: by 2002:a05:6402:2cd:b0:510:82b4:844d with SMTP id
 b13-20020a05640202cd00b0051082b4844dmr5021595edx.2.1685559746949; Wed, 31 May
 2023 12:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <05b5dd79465be41ff8cf8b56b694118a0aa7ae12.1685140942.git.daniel@iogearbox.net>
In-Reply-To: <05b5dd79465be41ff8cf8b56b694118a0aa7ae12.1685140942.git.daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 31 May 2023 12:02:15 -0700
Message-ID: <CAEf4BzYZBC_518wLTEXVo4+QyJ=Lsx0BYuVsL38xYdPfGOKHEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, vmtest: Build test_progs and friends as
 statically linked
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: andrii@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 26, 2023 at 3:47=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Small fix for vmtest.sh that I've been carrying locally for quite a while
> now in order to work around the following linker issue:
>
>   # ./vmtest.sh -- ./test_progs -t lsm
>   [...]
>   + ip link set lo up
>   + [ -x /etc/rcS.d/S50-startup ]
>   + /etc/rcS.d/S50-startup
>   ./test_progs -t lsm
>   ./test_progs: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.33' not=
 found (required by ./test_progs)
>   ./test_progs: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.34' not=
 found (required by ./test_progs)
>   [    1.356497] ACPI: PM: Preparing to enter system sleep state S5
>   [    1.358950] reboot: Power down
>   [...]
>
> With the specified TRUNNER_LDFLAGS out of vmtest to force static linking
> runners like test_progs/test_maps/etc work just fine.
>

Should we make this a command line option to the vmtest.sh script
instead? I, for one, can't even successfully build on my machine with
this, probably due to missing some -static library package (though I
did install libzstd-static). I'm getting:

make: *** [Makefile:598:
/data/users/andriin/linux/tools/testing/selftests/bpf/test_maps] Error
1
make: *** Waiting for unfinished jobs....
/opt/rh/gcc-toolset-11/root/usr/bin/ld:
/lib/../lib64/libelf.a(elf_compress.o): in function
`__libelf_compress':
(.text[.text.group]+0x2c1): undefined reference to `ZSTD_createCCtx'
/opt/rh/gcc-toolset-11/root/usr/bin/ld: (.text[.text.group]+0x436):
undefined reference to `ZSTD_compressStream2'
/opt/rh/gcc-toolset-11/root/usr/bin/ld: (.text[.text.group]+0x441):
undefined reference to `ZSTD_isError'
/opt/rh/gcc-toolset-11/root/usr/bin/ld: (.text[.text.group]+0x468):
undefined reference to `ZSTD_freeCCtx'
/opt/rh/gcc-toolset-11/root/usr/bin/ld: (.text[.text.group]+0x626):
undefined reference to `ZSTD_freeCCtx'
/opt/rh/gcc-toolset-11/root/usr/bin/ld: (.text[.text.group]+0x6a1):
undefined reference to `ZSTD_freeCCtx'
/opt/rh/gcc-toolset-11/root/usr/bin/ld: (.text[.text.group]+0x6d1):
undefined reference to `ZSTD_freeCCtx'
/opt/rh/gcc-toolset-11/root/usr/bin/ld: (.text[.text.group]+0x6fd):
undefined reference to `ZSTD_freeCCtx'
/opt/rh/gcc-toolset-11/root/usr/bin/ld:
/lib/../lib64/libelf.a(elf_compress.o):(.text[.text.group]+0x771):
more undefined references to `ZSTD_freeCCtx' follow
/opt/rh/gcc-toolset-11/root/usr/bin/ld:
/lib/../lib64/libelf.a(elf_compress.o): in function
`__libelf_decompress':
(.text[.text.group]+0xa42): undefined reference to `ZSTD_decompress'



> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/testing/selftests/bpf/Makefile  | 2 +-
>  tools/testing/selftests/bpf/vmtest.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index cd2426cca3d0..4005d001f46c 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -547,7 +547,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)    =
               \
>                              $(TRUNNER_BPFTOOL)                         \
>                              | $(TRUNNER_BINARY)-extras
>         $$(call msg,BINARY,,$$@)
> -       $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
> +       $(Q)$$(CC) $$(CFLAGS) $(TRUNNER_LDFLAGS) $$(filter %.a %.o,$$^) $=
$(LDLIBS) -o $$@
>         $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
>         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpft=
ool \
>                    $(OUTPUT)/$(if $2,$2/)bpftool
> diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selfte=
sts/bpf/vmtest.sh
> index 685034528018..455518745cf9 100755
> --- a/tools/testing/selftests/bpf/vmtest.sh
> +++ b/tools/testing/selftests/bpf/vmtest.sh
> @@ -160,7 +160,7 @@ update_selftests()
>         local selftests_dir=3D"${kernel_checkout}/tools/testing/selftests=
/bpf"
>
>         cd "${selftests_dir}"
> -       ${make_command}
> +       TRUNNER_LDFLAGS=3D-static ${make_command}
>
>         # Mount the image and copy the selftests to the image.
>         mount_image
> --
> 2.21.0
>
>

