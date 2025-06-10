Return-Path: <bpf+bounces-60207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992F5AD3F58
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 18:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D34117D70C
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F097244684;
	Tue, 10 Jun 2025 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jj1aDPDd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BBB244678
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573747; cv=none; b=nnhXJMiTibc0xqnofE7o+LY1Hn0L316AT8qyiegYwQC52VYAqf2TEcMZ83IuPuiTNP7Eelvki8rRvedR52pIcKFcvWbaEEWS2HkXtUWAlk1WJmSaKrZ4U6Y5OMvwvcgjUEwNSJxt7BIVOQUIQYCpjLE2j0Tv9HayvAn1NI0DHK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573747; c=relaxed/simple;
	bh=iUWEfepFxW5+wP1S6dLjzww/GMltVpjy2p3xoDW7Px8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5JxJJtjj+4mJGyqghBv9/KL5dn21G+w2OYGEszf26PSjbDZiUAQrPx/yq9KOV+p2t9xdafGsUG9TyE98OhbfUnjaBiNW69JguoA7gHry8M5LkhaCZk6FxvX3fgmEl/bxpLtTxW9SHLkk5dc5e1PauS9LjFve2BzEpflILIN/FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jj1aDPDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8B5C4AF0D
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 16:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749573746;
	bh=iUWEfepFxW5+wP1S6dLjzww/GMltVpjy2p3xoDW7Px8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jj1aDPDdPL5wTnYiOVqO7qQ8/LyJAD7a0fIuAECDTBvV89xIt/xOgukclzaIGzjSO
	 oLnYIL8zJjIkvKrs/MaXZveNy+mqPiYOpKfAmpFYFYQDfOV9FtXIKiqORmNdI8v4AE
	 5H9/Xwnoy7y8KakK9Lo6hUAYyLFq7f4+RdaGLX+HWOPrPugsD5wluVA7nh7Daqd0UD
	 n+aJ/XKkNGn+cfsRQSA1RUAN8DjzXk6n1voqt+HzAQBrlpu1vRuIYiBi6Fzgk+8J1T
	 i5ql46usSp6xfW/AG1iBulKnECNDmrjl0qsnNcfn90RQRc7BhQzYxIlB/zOPnAs3cB
	 fXwBLnXNMgCWA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-604f5691bceso11542095a12.0
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 09:42:26 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz2u+TyjTPh9P51PGYFCAwI8hS6TN3JZjbJ0p9sxEJgdA9gi5GK
	4u9FP9iKyLg+LYCZMgTMhw6TbxPlgxLe14aVW/8tohizqAwv1nQVwrb5gCUaekwvZfwJ7R/aogj
	6VK5nRYB8d1kctikCY2+sllnlS63ToQqQ6Yg2L36h
X-Google-Smtp-Source: AGHT+IF7QSZQlLmKQg2Q9QejlfTK6KpGhHPVrA+LwfTIu1aqn1R5gZeJALWyLPvtOg16poRBKeRtAKnqf1n+xwsdgk4=
X-Received: by 2002:a05:6402:35ca:b0:604:e602:77a5 with SMTP id
 4fb4d7f45d1cf-6082d59fd13mr2857239a12.15.1749573745257; Tue, 10 Jun 2025
 09:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-13-kpsingh@kernel.org>
 <87tt4nlfek.fsf@microsoft.com>
In-Reply-To: <87tt4nlfek.fsf@microsoft.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 10 Jun 2025 18:42:14 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7y1ztHKH0+-uw9FzMzkJb3a6bKCXET5Dd5F1UV6+i4_A@mail.gmail.com>
X-Gm-Features: AX0GCFvi3cgmiI0nO_Xd7RGL0PTif_FtdHXMUKnH3pPettbEfGiDwfxnIpG_rCY
Message-ID: <CACYkzJ7y1ztHKH0+-uw9FzMzkJb3a6bKCXET5Dd5F1UV6+i4_A@mail.gmail.com>
Subject: Re: [PATCH 12/12] selftests/bpf: Enable signature verification for
 all lskel tests
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, kys@microsoft.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 6:39=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> KP Singh <kpsingh@kernel.org> writes:
>
> > Convert the kernel's generated verification certificate into a C header
> > file using xxd.  Finally, update the main test runner to load this
> > certificate into the session keyring via the add_key() syscall before
> > executing any tests.
> >
> > The kernel's module signing verification certificate is converted to a
> > headerfile and loaded as a session key and all light skeleton tests are
> > updated to be signed.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/.gitignore   |  1 +
> >  tools/testing/selftests/bpf/Makefile     | 13 +++++++++++--
> >  tools/testing/selftests/bpf/test_progs.c | 13 +++++++++++++
> >  3 files changed, 25 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/sel=
ftests/bpf/.gitignore
> > index e2a2c46c008b..5ab96f8ab1c9 100644
> > --- a/tools/testing/selftests/bpf/.gitignore
> > +++ b/tools/testing/selftests/bpf/.gitignore
> > @@ -45,3 +45,4 @@ xdp_redirect_multi
> >  xdp_synproxy
> >  xdp_hw_metadata
> >  xdp_features
> > +verification_cert.h
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index cf5ed3bee573..778b54be7ef4 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -7,6 +7,7 @@ CXX ?=3D $(CROSS_COMPILE)g++
> >
> >  CURDIR :=3D $(abspath .)
> >  TOOLSDIR :=3D $(abspath ../../..)
> > +CERTSDIR :=3D $(abspath ../../../../certs)
> >  LIBDIR :=3D $(TOOLSDIR)/lib
> >  BPFDIR :=3D $(LIBDIR)/bpf
> >  TOOLSINCDIR :=3D $(TOOLSDIR)/include
> > @@ -534,7 +535,7 @@ HEADERS_FOR_BPF_OBJS :=3D $(wildcard $(BPFDIR)/*.bp=
f.h)             \
> >  # $1 - test runner base binary name (e.g., test_progs)
> >  # $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc=
)
> >  define DEFINE_TEST_RUNNER
> > -
> > +LSKEL_SIGN :=3D -S -k $(CERTSDIR)/signing_key.pem -i $(CERTSDIR)/signi=
ng_key.x509
> >  TRUNNER_OUTPUT :=3D $(OUTPUT)$(if $2,/)$2
> >  TRUNNER_BINARY :=3D $1$(if $2,-)$2
> >  TRUNNER_TEST_OBJS :=3D $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,   =
 \
> > @@ -601,7 +602,7 @@ $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL=
) | $(TRUNNER_OUTPUT)
> >       $(Q)$$(BPFTOOL) gen object $$(<:.o=3D.llinked2.o) $$(<:.o=3D.llin=
ked1.o)
> >       $(Q)$$(BPFTOOL) gen object $$(<:.o=3D.llinked3.o) $$(<:.o=3D.llin=
ked2.o)
> >       $(Q)diff $$(<:.o=3D.llinked2.o) $$(<:.o=3D.llinked3.o)
> > -     $(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=3D.llinked3.o) name $$(no=
tdir $$(<:.bpf.o=3D_lskel)) > $$@
> > +     $(Q)$$(BPFTOOL) gen skeleton $(LSKEL_SIGN) $$(<:.o=3D.llinked3.o)=
 name $$(notdir $$(<:.bpf.o=3D_lskel)) > $$@
> >       $(Q)rm -f $$(<:.o=3D.llinked1.o) $$(<:.o=3D.llinked2.o) $$(<:.o=
=3D.llinked3.o)
> >
> >  $(LINKED_BPF_OBJS): %: $(TRUNNER_OUTPUT)/%
> > @@ -697,6 +698,13 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS) =
                       \
> >
> >  endef
> >
> > +CERT_HEADER :=3D verification_cert.h
> > +CERT_SOURCE :=3D $(CERTSDIR)/signing_key.x509
> > +
> > +$(CERT_HEADER): $(CERT_SOURCE)
> > +     @echo "GEN-CERT-HEADER: $(CERT_HEADER) from $<"
> > +     $(Q)xxd -i -n test_progs_verification_cert $< > $@
> > +
> >  # Define test_progs test runner.
> >  TRUNNER_TESTS_DIR :=3D prog_tests
> >  TRUNNER_BPF_PROGS_DIR :=3D progs
> > @@ -716,6 +724,7 @@ TRUNNER_EXTRA_SOURCES :=3D test_progs.c            =
 \
> >                        disasm.c               \
> >                        disasm_helpers.c       \
> >                        json_writer.c          \
> > +                      $(CERT_HEADER)         \
> >                        flow_dissector_load.h  \
> >                        ip_check_defrag_frags.h
> >  TRUNNER_EXTRA_FILES :=3D $(OUTPUT)/urandom_read                       =
         \
> > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/s=
elftests/bpf/test_progs.c
> > index 309d9d4a8ace..02a85dda30e6 100644
> > --- a/tools/testing/selftests/bpf/test_progs.c
> > +++ b/tools/testing/selftests/bpf/test_progs.c
> > @@ -14,12 +14,14 @@
> >  #include <netinet/in.h>
> >  #include <sys/select.h>
> >  #include <sys/socket.h>
> > +#include <linux/keyctl.h>
> >  #include <sys/un.h>
> >  #include <bpf/btf.h>
> >  #include <time.h>
> >  #include "json_writer.h"
> >
> >  #include "network_helpers.h"
> > +#include "verification_cert.h"
> >
> >  /* backtrace() and backtrace_symbols_fd() are glibc specific,
> >   * use header file when glibc is available and provide stub
> > @@ -1928,6 +1930,13 @@ static void free_test_states(void)
> >       }
> >  }
> >
> > +static __u32 register_session_key(const char *key_data, size_t key_dat=
a_size)
> > +{
> > +     return syscall(__NR_add_key, "asymmetric", "libbpf_session_key",
> > +                     (const void *)key_data, key_data_size,
> > +                     KEY_SPEC_SESSION_KEYRING);
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >       static const struct argp argp =3D {
> > @@ -1961,6 +1970,10 @@ int main(int argc, char **argv)
> >       /* Use libbpf 1.0 API mode */
> >       libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
> >       libbpf_set_print(libbpf_print_fn);
> > +     err =3D register_session_key((const char *)test_progs_verificatio=
n_cert,
> > +                                test_progs_verification_cert_len);
> > +     if (err < 0)
> > +             return err;
> >
> >       traffic_monitor_set_print(traffic_monitor_print_fn);
> >
> > --
> > 2.43.0
>
>
> There aren't any test cases showing the "trusted" loader doing any sort
> of enforcement of blocking invalid programs or maps.

Sure, we can add some more test cases.

>
> -blaise

