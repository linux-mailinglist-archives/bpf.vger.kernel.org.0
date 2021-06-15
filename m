Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A257E3A7B4E
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 11:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhFOKAH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 06:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231374AbhFOKAG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 06:00:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0C79613F1
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 09:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623751082;
        bh=czoG2ybndFtSxdCO/hiwW/Fn5Z4Sx5cGjA2LNCL83cc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gfiQonDNll8SPc1IFY2gZDwhel/qkOnwn4Ysm1NvmayY1XCjVR0dB3oA2t8LSVHA1
         Ql1GInDMwMoZvrZRw+6keqm9Y7oNWVU5cEfmXDNwOseZZ3SA/EoGKLKp+KF4wD9H6j
         GrLd/xBAILA9vzYJgDoIYvJSE7heY/wN5l7kQCMC7smNp/aQP8I0Umut9XZY8AwlMd
         ERRaxPd6h0gGMH6zEHqVSAoSWQFkJcnZRjlc5nX1TsvWCOtWxqrvgypBfZ2G1NFIpt
         2PYTF7ft8ME80yiFV6RIWxFBVF44giGTL1Lp5qHMkitADih0FRdGtXVtKTlgvU3RRA
         65RG6uYunyTGA==
Received: by mail-lf1-f48.google.com with SMTP id r5so26040721lfr.5
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 02:58:02 -0700 (PDT)
X-Gm-Message-State: AOAM531JkJ2eYkuiCkn7fB8yXeqDUP4B5iP/ToqmWoPgqp2hpRqLUG5G
        NMxVZ1BVxpGYgRmOyGrib2CghHOOeiNLlmStwWp2Fw==
X-Google-Smtp-Source: ABdhPJyhGhxPeTUwJpz8Twy63AiX77B8xJXX25MWkeRBaTdA0KuTXJkYY+5b/IAkNaQO4p0iQ4vjjspMd2GRR/5/duo=
X-Received: by 2002:ac2:44bc:: with SMTP id c28mr15668645lfm.9.1623751081019;
 Tue, 15 Jun 2021 02:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAGG-pUTpppu-voYuT81LiTMAUA5oAWwnAwYQVAhyPwj3CwnZPA@mail.gmail.com>
 <CAEf4BzZkK9X2RadSYUWV5oh960iwaw3y5EKr7zu8WZ7XnRYz6g@mail.gmail.com> <CAHn8xc==x92fXpOM42-FJ_ondhGPdMOrTmgYr3K=w8WvZqXEVQ@mail.gmail.com>
In-Reply-To: <CAHn8xc==x92fXpOM42-FJ_ondhGPdMOrTmgYr3K=w8WvZqXEVQ@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 15 Jun 2021 11:57:50 +0200
X-Gmail-Original-Message-ID: <CACYkzJ59tvKKxaG9S+QLVbC=4szbFjouDUDaaTCNUytQBT7nSg@mail.gmail.com>
Message-ID: <CACYkzJ59tvKKxaG9S+QLVbC=4szbFjouDUDaaTCNUytQBT7nSg@mail.gmail.com>
Subject: Re: kernel bpf test_progs - vm wrong libc version
To:     Jussi Maki <joamaki@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "Geyslan G. Bem" <geyslan@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 15, 2021 at 10:06 AM Jussi Maki <joamaki@gmail.com> wrote:
>
> On Tue, Jun 15, 2021 at 8:28 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > It seems kind of silly to update our perfectly working image just
> > because a new version of glibc was released. Is there any way for you
> > to down-grade glibc or build it in some compatibility mode, etc?
> > selftests don't really rely on any bleeding-edge features of glibc.
>
> I've also hit this issue as Ubuntu 21.04 ships with glibc 2.33. I
> ended up solving it the hard way by rebuilding the image (I needed few
> other tools at the time anyway). Definitely agree it's a bit silly if
> we'd need to bump the image every time there's a new glibc version out
> there. I did try and see if there's a way to build against newer
> glibc, but target older versions and I didn't find a way to do that.
> Would statically linking test-progs be an option to avoid this kind of
> breakage in the future?

I think static linking tests_progs is the only real way one can solve this.
Even if we keep updating the image, there will still be users that will hit
glibc version issues.

Andrii, Maybe we can have a mode for vmtest.sh can build test_progs
statically?

maybe something like:

git diff
diff --git a/tools/testing/selftests/bpf/Makefile
b/tools/testing/selftests/bpf/Makefile
index f405b20c1e6c..5ab0b7e6a95d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -450,7 +450,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)
                 \
                             $(RESOLVE_BTFIDS)                          \
                             | $(TRUNNER_BINARY)-extras
        $$(call msg,BINARY,,$$@)
-       $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
+       $(Q)$$(CC) $$(CFLAGS) $(TRUNNER_LDFLAGS) $$(filter %.a
%.o,$$^) $$(LDLIBS) -o $$@
        $(Q)$(RESOLVE_BTFIDS) --no-fail --btf $(TRUNNER_OUTPUT)/btf_data.o $$@

 endef
diff --git a/tools/testing/selftests/bpf/vmtest.sh
b/tools/testing/selftests/bpf/vmtest.sh
index 8889b3f55236..331072074014 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -138,7 +138,7 @@ update_selftests()
        local selftests_dir="${kernel_checkout}/tools/testing/selftests/bpf"

        cd "${selftests_dir}"
-       ${make_command}
+       TRUNNER_LDFLAGS=-static ${make_command}

        # Mount the image and copy the selftests to the image.
        mount_image

file test_progs
test_progs: ELF 64-bit LSB executable, x86-64, version 1 (GNU/Linux),
statically linked,
BuildID[sha1]=b1915565b344c412f3eaa07eef4bfdd4a0fc672e, for GNU/Linux
3.2.0, with debug_info, not stripped

I tried with simply doing LDFLAGS=-static but that breaks other binaries:

/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/10/crtbeginT.o: relocation
R_X86_64_32 against hidden symbol `__TMC_END__' can not be used when
making a shared object
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile:167:
/home/kpsingh/projects/krsi/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.so.0.5.0]
Error 1
make[1]: *** [Makefile:135: all] Error 2
make: *** [Makefile:228:
/home/kpsingh/projects/krsi/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a]
Error 2
make: *** Deleting file
'/home/kpsingh/projects/krsi/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a'

Let me know if this works for you.




-
