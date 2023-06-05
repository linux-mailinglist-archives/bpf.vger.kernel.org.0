Return-Path: <bpf+bounces-1869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D25B72318F
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 22:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80821C20953
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 20:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD65023D6C;
	Mon,  5 Jun 2023 20:41:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB8323E
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 20:41:25 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABC4EC;
	Mon,  5 Jun 2023 13:41:23 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b1b1635661so45922041fa.0;
        Mon, 05 Jun 2023 13:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685997681; x=1688589681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhPIFegxoCeVIgDaOVjD/g9vkSGo9AaqaU1dNRBfAL8=;
        b=TFUXobFiMq3EvU6mZrws5tQ3f9cwtrAN2cpllmKc22nD0UpKXdlSZf4RNYjKmyZZlr
         wphISSXL114omyoRkB5Bi5RJfCDCjtT7EpU2Do2vk3+GMbfgmiR0Ci3dyXYuh/FaiIzc
         4Q5ZhifWumaYZWvRQlOdWTwibiuRIL7EOxe2/u/xBYzjfauQDRLhXBFAPasBng7ZETa8
         l/RHEiHGk8qe4gC91VeZRpJpR9h4A7/FF1vR2RTcKFRTAIkls688Cwb0F96jzwaM9axx
         KH86GaoYJ116TYQC5XAVYeClKp2fon2aKifwEJozQkg4qHEFmEjrjms/ju0mwTOAOFM3
         eO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685997681; x=1688589681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhPIFegxoCeVIgDaOVjD/g9vkSGo9AaqaU1dNRBfAL8=;
        b=UQ3kYMsBG09BdIklUkh7NtxKH+/wgDtC1jEPR4E5va6ezUY6Qv6skPL/0j+yyKRmpn
         4BM2YPLaTnzzFPh2FUlBRZwYhk2Z3OYkdNxE+vM7LfMhDUSToEOCOL+EZv/CY/xkEbt4
         02ReU8/JuNoy+fwKHG+vrUb4XegGoFQRvt4bMBGebDEkep3WGU5JT3jcblgcSS8i+kbd
         dIcvKAcpEmJx3DnP/9CpZK/kQNc25EGKZtRyeoMx760JgmG6WTM6uLwCMp7S+mx1Tzcm
         EFj+RlM2peBuS7JlH3+XowpyQqZAl/WnzkBgCXIBzSaGbgks8zyX62abkM+c5+MWBOMr
         DpfQ==
X-Gm-Message-State: AC+VfDyqXfgpObbRuL9oM6xlmPYkgxy0zfZBdOjy0FvL2zJCDDAxM30t
	oaoX/Sw+os7bllBnDYBkpYzkb3OQd9GbeQTO59WfwjYEP2Y=
X-Google-Smtp-Source: ACHHUZ7HTLeR7UdiYl3rN9ZnyKBD6yt+DGKL0D87He/dnsk58RNf2u87l/Fz85HIT0u5e9Ti4TQewIvEvRE5aRp+P4k=
X-Received: by 2002:a2e:94d7:0:b0:2ad:b9ed:5498 with SMTP id
 r23-20020a2e94d7000000b002adb9ed5498mr189616ljh.24.1685997681034; Mon, 05 Jun
 2023 13:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602150011.1657856-1-andrii@kernel.org> <1930272b-cfbe-f366-21ca-e9e7a51347be@schaufler-ca.com>
In-Reply-To: <1930272b-cfbe-f366-21ca-e9e7a51347be@schaufler-ca.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jun 2023 13:41:09 -0700
Message-ID: <CAEf4BzZ5adUcs1qaHx34ZuXMyG6ByczyUqpFKq=+CtxPHYgEVQ@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next 00/18] BPF token
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com, 
	luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 2, 2023 at 8:55=E2=80=AFAM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> On 6/2/2023 7:59 AM, Andrii Nakryiko wrote:
> > *Resending with trimmed CC list because original version didn't make it=
 to
> > the mailing list.*
> >
> > This patch set introduces new BPF object, BPF token, which allows to de=
legate
> > a subset of BPF functionality from privileged system-wide daemon (e.g.,
> > systemd or any other container manager) to a *trusted* unprivileged
> > application. Trust is the key here. This functionality is not about all=
owing
> > unconditional unprivileged BPF usage. Establishing trust, though, is
> > completely up to the discretion of respective privileged application th=
at
> > would create a BPF token.
>
> Token based privilege has a number of well understood weaknesses,
> none of which I see addressed here. I also have a real problem with

Can you please provide some more details about those weaknesses? Hard
to respond without knowing exactly what we are talking about.

> the notion of "trusted unprivileged" where trust is established by
> a user space application. Ignoring the possibility of malicious code
> for the moment, the opportunity for accidental privilege leakage is
> huge. It would be trivial (and tempting) to create a privileged BPF
> "shell" that would then be allowed to "trust" any application and
> run it with privilege by passing it a token.

Right now most BPF applications are running as real root in
production. Users have to trust such applications to not do anything
bad with their full root capabilities. How it is done depends on
specific production and organizational setups, and could be code
reviewing, audits, LSM, etc. So in that sense BPF token doesn't make
things worse. And it actually allows us to improve the situation by
creating and sharing more restrictive BPF tokens that limit what bpf()
syscall parts are allowed to be used.

>
> >
> > The main motivation for BPF token is a desire to enable containerized
> > BPF applications to be used together with user namespaces. This is curr=
ently
> > impossible, as CAP_BPF, required for BPF subsystem usage, cannot be nam=
espaced
> > or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to =
BPF
> > helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safe=
ly read
> > arbitrary memory, and it's impossible to ensure that they only read mem=
ory of
> > processes belonging to any given namespace. This means that it's imposs=
ible to
> > have namespace-aware CAP_BPF capability, and as such another mechanism =
to
> > allow safe usage of BPF functionality is necessary. BPF token and deleg=
ation
> > of it to a trusted unprivileged applications is such mechanism. Kernel =
makes
> > no assumption about what "trusted" constitutes in any particular case, =
and
> > it's up to specific privileged applications and their surrounding
> > infrastructure to decide that. What kernel provides is a set of APIs to=
 create
> > and tune BPF token, and pass it around to privileged BPF commands that =
are
> > creating new BPF objects like BPF programs, BPF maps, etc.
> >
> > Previous attempt at addressing this very same problem ([0]) attempted t=
o
> > utilize authoritative LSM approach, but was conclusively rejected by up=
stream
> > LSM maintainers. BPF token concept is not changing anything about LSM
> > approach, but can be combined with LSM hooks for very fine-grained secu=
rity
> > policy. Some ideas about making BPF token more convenient to use with L=
SM (in
> > particular custom BPF LSM programs) was briefly described in recent LSF=
/MM/BPF
> > 2023 presentation ([1]). E.g., an ability to specify user-provided data
> > (context), which in combination with BPF LSM would allow implementing a=
 very
> > dynamic and fine-granular custom security policies on top of BPF token.=
 In the
> > interest of minimizing API surface area discussions this is going to be
> > added in follow up patches, as it's not essential to the fundamental co=
ncept
> > of delegatable BPF token.
> >
> > It should be noted that BPF token is conceptually quite similar to the =
idea of
> > /dev/bpf device file, proposed by Song a while ago ([2]). The biggest
> > difference is the idea of using virtual anon_inode file to hold BPF tok=
en and
> > allowing multiple independent instances of them, each with its own set =
of
> > restrictions. BPF pinning solves the problem of exposing such BPF token
> > through file system (BPF FS, in this case) for cases where transferring=
 FDs
> > over Unix domain sockets is not convenient. And also, crucially, BPF to=
ken
> > approach is not using any special stateful task-scoped flags. Instead, =
bpf()
> > syscall accepts token_fd parameters explicitly for each relevant BPF co=
mmand.
> > This addresses main concerns brought up during the /dev/bpf discussion,=
 and
> > fits better with overall BPF subsystem design.
> >
> > This patch set adds a basic minimum of functionality to make BPF token =
useful
> > and to discuss API and functionality. Currently only low-level libbpf A=
PIs
> > support passing BPF token around, allowing to test kernel functionality=
, but
> > for the most part is not sufficient for real-world applications, which
> > typically use high-level libbpf APIs based on `struct bpf_object` type.=
 This
> > was done with the intent to limit the size of patch set and concentrate=
 on
> > mostly kernel-side changes. All the necessary plumbing for libbpf will =
be sent
> > as a separate follow up patch set kernel support makes it upstream.
> >
> > Another part that should happen once kernel-side BPF token is establish=
ed, is
> > a set of conventions between applications (e.g., systemd), tools (e.g.,
> > bpftool), and libraries (e.g., libbpf) about sharing BPF tokens through=
 BPF FS
> > at well-defined locations to allow applications take advantage of this =
in
> > automatic fashion without explicit code changes on BPF application's si=
de.
> > But I'd like to postpone this discussion to after BPF token concept lan=
ds.
> >
> >   [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel=
.org/
> >   [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_=
BPF_LSFMM2023.pdf
> >   [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubravi=
ng@fb.com/
> >
> > Andrii Nakryiko (18):
> >   bpf: introduce BPF token object
> >   libbpf: add bpf_token_create() API
> >   selftests/bpf: add BPF_TOKEN_CREATE test
> >   bpf: move unprivileged checks into map_create() and bpf_prog_load()
> >   bpf: inline map creation logic in map_create() function
> >   bpf: centralize permissions checks for all BPF map types
> >   bpf: add BPF token support to BPF_MAP_CREATE command
> >   libbpf: add BPF token support to bpf_map_create() API
> >   selftests/bpf: add BPF token-enabled test for BPF_MAP_CREATE command
> >   bpf: add BPF token support to BPF_BTF_LOAD command
> >   libbpf: add BPF token support to bpf_btf_load() API
> >   selftests/bpf: add BPF token-enabled BPF_BTF_LOAD selftest
> >   bpf: keep BPF_PROG_LOAD permission checks clear of validations
> >   bpf: add BPF token support to BPF_PROG_LOAD command
> >   bpf: take into account BPF token when fetching helper protos
> >   bpf: consistenly use BPF token throughout BPF verifier logic
> >   libbpf: add BPF token support to bpf_prog_load() API
> >   selftests/bpf: add BPF token-enabled BPF_PROG_LOAD tests
> >
> >  drivers/media/rc/bpf-lirc.c                   |   2 +-
> >  include/linux/bpf.h                           |  66 ++-
> >  include/linux/filter.h                        |   2 +-
> >  include/uapi/linux/bpf.h                      |  74 +++
> >  kernel/bpf/Makefile                           |   2 +-
> >  kernel/bpf/arraymap.c                         |   2 +-
> >  kernel/bpf/bloom_filter.c                     |   3 -
> >  kernel/bpf/bpf_local_storage.c                |   3 -
> >  kernel/bpf/bpf_struct_ops.c                   |   3 -
> >  kernel/bpf/cgroup.c                           |   6 +-
> >  kernel/bpf/core.c                             |   3 +-
> >  kernel/bpf/cpumap.c                           |   4 -
> >  kernel/bpf/devmap.c                           |   3 -
> >  kernel/bpf/hashtab.c                          |   6 -
> >  kernel/bpf/helpers.c                          |   6 +-
> >  kernel/bpf/inode.c                            |  26 ++
> >  kernel/bpf/lpm_trie.c                         |   3 -
> >  kernel/bpf/queue_stack_maps.c                 |   4 -
> >  kernel/bpf/reuseport_array.c                  |   3 -
> >  kernel/bpf/stackmap.c                         |   3 -
> >  kernel/bpf/syscall.c                          | 429 ++++++++++++++----
> >  kernel/bpf/token.c                            | 141 ++++++
> >  kernel/bpf/verifier.c                         |  13 +-
> >  kernel/trace/bpf_trace.c                      |   2 +-
> >  net/core/filter.c                             |  36 +-
> >  net/core/sock_map.c                           |   4 -
> >  net/ipv4/bpf_tcp_ca.c                         |   2 +-
> >  net/netfilter/nf_bpf_link.c                   |   2 +-
> >  net/xdp/xskmap.c                              |   4 -
> >  tools/include/uapi/linux/bpf.h                |  74 +++
> >  tools/lib/bpf/bpf.c                           |  32 +-
> >  tools/lib/bpf/bpf.h                           |  24 +-
> >  tools/lib/bpf/libbpf.map                      |   1 +
> >  .../selftests/bpf/prog_tests/libbpf_probes.c  |   4 +
> >  .../selftests/bpf/prog_tests/libbpf_str.c     |   6 +
> >  .../testing/selftests/bpf/prog_tests/token.c  | 282 ++++++++++++
> >  .../bpf/prog_tests/unpriv_bpf_disabled.c      |   6 +-
> >  37 files changed, 1098 insertions(+), 188 deletions(-)
> >  create mode 100644 kernel/bpf/token.c
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
> >

