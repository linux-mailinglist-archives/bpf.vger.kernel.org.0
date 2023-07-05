Return-Path: <bpf+bounces-4116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3038C748EFF
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 22:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92AE281108
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 20:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3E8134D2;
	Wed,  5 Jul 2023 20:37:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0970C2F38
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 20:37:47 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9617F19A3;
	Wed,  5 Jul 2023 13:37:45 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so76133645e9.3;
        Wed, 05 Jul 2023 13:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688589464; x=1691181464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cj35583xnzvGWyL7CZfPsTBPJGJLBB11EAo3CBt2aL8=;
        b=jjS/QqaIOe1xGLTCuaHTgbxwVAT65JqtlgnIbfK6PfzmMWJ9ieRuwWsJ4K78kRwigu
         NpCN3csAUDk7B3eh7DFUvnPwPC3CFBnyMZiqYBuX/iKR1Do0xn/hZ0xGqbG7kvAmmDZH
         1lElh1wvIqqTanASkiI4zNxt3Kd3QENfA2gAnmtctfc2yc25zTLTfZKYv49h7ORw/F+1
         7KbJGr0wVVCEH4muDSdSI26VOCyBeKUlpua8qbyHNCnlRMUMolIH5YcELTaFgb9+1mVs
         SNwYSItzEZCiG12V/EjQ9ZU+lQiB2xqn/1JkE42IfbJR8VkA7oxu00hL9/4R/hDrEVMQ
         pu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688589464; x=1691181464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cj35583xnzvGWyL7CZfPsTBPJGJLBB11EAo3CBt2aL8=;
        b=NAFHDipS7RudLmK3pcJCWtYFJuBK4oA3DJ6UR6FSl1oLl5/ym9az7bkAJeQLs8YOxp
         cj/JzQO5tASYZ6CbCwiLYrn22l7ImNrq9dH/xRaUFNX4PRNvdMZBsc6pu6+XK4nnMrxA
         0KlxYt9AtVPdZxnwh/x9OomVVdy6iF2c4xWBNN3bWWomwAo6b5HaTSXFAdPlTz3r3+R/
         pDagGpk2/YsOOYRQP39fUburbvsWp/DqPC/nvvSPwlKDhbYBo+5HQoeIYHIL+XOTtRUi
         A3f0vgjpiZPVRVSqlddO/2lz0YDmTBgLr+DA+L3wBUAvTmHdyS7qxXkqlSBpvIW2Bh+O
         6FoQ==
X-Gm-Message-State: AC+VfDwB88EO54IY03o9D+YTbO+R2KBeVT6LQKgsFIlAKQDAZ3C1vM3d
	ZOmbFSwVjwmeRxX/SEM5cFGvivUdGsZ0YZ1LQ4k=
X-Google-Smtp-Source: ACHHUZ6qEwE7QJuSLlhwRI2uvNpOjiLLUWDN0fIqLxlA+ZQ03ExHUjW1bfVQBLkzZ2Bc9PjUPZXSkJi7RiW3KPUPjFQ=
X-Received: by 2002:a1c:cc16:0:b0:3fb:404c:15e2 with SMTP id
 h22-20020a1ccc16000000b003fb404c15e2mr14449570wmb.41.1688589463674; Wed, 05
 Jul 2023 13:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629051832.897119-1-andrii@kernel.org> <CALOAHbBupxQ3RH+SbzUv=W2dRDS-mG1PuRpARrMnMv=o6Ro7Sw@mail.gmail.com>
In-Reply-To: <CALOAHbBupxQ3RH+SbzUv=W2dRDS-mG1PuRpARrMnMv=o6Ro7Sw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Jul 2023 13:37:31 -0700
Message-ID: <CAEf4BzbS55xw2Scnid87O5TFQ7To56huPaKg_oH6gLSp+ggpdw@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 bpf-next 00/14] BPF token
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com, 
	luto@kernel.org, kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 7:06=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Thu, Jun 29, 2023 at 1:18=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
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
> > would create a BPF token, as different production setups can and do ach=
ieve it
> > through a combination of different means (signing, LSM, code reviews, e=
tc),
> > and it's undesirable and infeasible for kernel to enforce any particula=
r way
> > of validating trustworthiness of particular process.
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
> > Once important distinctions from v2 that should be noted is a chance in=
 the
> > semantics of a newly added BPF_TOKEN_CREATE command. Previously,
> > BPF_TOKEN_CREATE would create BPF token kernel object and return its FD=
 to
> > user-space, allowing to (optionally) pin it in BPF FS using BPF_OBJ_PIN
> > command. This v3 version changes this slightly: BPF_TOKEN_CREATE combin=
es BPF
> > token object creation *and* pinning in BPF FS. Such change ensures that=
 BPF
> > token is always associated with a specific instance of BPF FS and canno=
t
> > "escape" it by application re-pinning it somewhere else using another
> > BPF_OBJ_PIN call. Now, BPF token can only be pinned once during its cre=
ation,
> > better containing it inside intended container (under assumption BPF FS=
 is set
> > up in such a way as to not be shared with other containers on the syste=
m).
> >
> >   [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel=
.org/
> >   [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_=
BPF_LSFMM2023.pdf
> >   [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubravi=
ng@fb.com/
> >
> > v3->v3-resend:
> >   - I started integrating token_fd into bpf_object_open_opts and higher=
-level
> >     libbpf bpf_object APIs, but it started going a bit deeper into bpf_=
object
> >     implementation details and how libbpf performs feature detection an=
d
> >     caching, so I decided to keep it separate from this patch set and n=
ot
> >     distract from the mostly kernel-side changes;
> > v2->v3:
> >   - make BPF_TOKEN_CREATE pin created BPF token in BPF FS, and disallow
> >     BPF_OBJ_PIN for BPF token;
> > v1->v2:
> >   - fix build failures on Kconfig with CONFIG_BPF_SYSCALL unset;
> >   - drop BPF_F_TOKEN_UNKNOWN_* flags and simplify UAPI (Stanislav).
> >
> > Andrii Nakryiko (14):
> >   bpf: introduce BPF token object
> >   libbpf: add bpf_token_create() API
> >   selftests/bpf: add BPF_TOKEN_CREATE test
> >   bpf: add BPF token support to BPF_MAP_CREATE command
> >   libbpf: add BPF token support to bpf_map_create() API
> >   selftests/bpf: add BPF token-enabled test for BPF_MAP_CREATE command
> >   bpf: add BPF token support to BPF_BTF_LOAD command
> >   libbpf: add BPF token support to bpf_btf_load() API
> >   selftests/bpf: add BPF token-enabled BPF_BTF_LOAD selftest
> >   bpf: add BPF token support to BPF_PROG_LOAD command
> >   bpf: take into account BPF token when fetching helper protos
> >   bpf: consistenly use BPF token throughout BPF verifier logic
> >   libbpf: add BPF token support to bpf_prog_load() API
> >   selftests/bpf: add BPF token-enabled BPF_PROG_LOAD tests
> >
> >  drivers/media/rc/bpf-lirc.c                   |   2 +-
> >  include/linux/bpf.h                           |  79 ++++-
> >  include/linux/filter.h                        |   2 +-
> >  include/uapi/linux/bpf.h                      |  53 ++++
> >  kernel/bpf/Makefile                           |   2 +-
> >  kernel/bpf/arraymap.c                         |   2 +-
> >  kernel/bpf/cgroup.c                           |   6 +-
> >  kernel/bpf/core.c                             |   3 +-
> >  kernel/bpf/helpers.c                          |   6 +-
> >  kernel/bpf/inode.c                            |  46 ++-
> >  kernel/bpf/syscall.c                          | 183 +++++++++---
> >  kernel/bpf/token.c                            | 201 +++++++++++++
> >  kernel/bpf/verifier.c                         |  13 +-
> >  kernel/trace/bpf_trace.c                      |   2 +-
> >  net/core/filter.c                             |  36 +--
> >  net/ipv4/bpf_tcp_ca.c                         |   2 +-
> >  net/netfilter/nf_bpf_link.c                   |   2 +-
> >  tools/include/uapi/linux/bpf.h                |  53 ++++
> >  tools/lib/bpf/bpf.c                           |  35 ++-
> >  tools/lib/bpf/bpf.h                           |  45 ++-
> >  tools/lib/bpf/libbpf.map                      |   1 +
> >  .../selftests/bpf/prog_tests/libbpf_probes.c  |   4 +
> >  .../selftests/bpf/prog_tests/libbpf_str.c     |   6 +
> >  .../testing/selftests/bpf/prog_tests/token.c  | 277 ++++++++++++++++++
> >  24 files changed, 957 insertions(+), 104 deletions(-)
> >  create mode 100644 kernel/bpf/token.c
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
> >
> > --
> > 2.34.1
> >
> >
>
>
> Hi Andrii,
>
> Thanks for your proposal.
> That seems to be a useful functionality, and yet I have some questions.

I've answered them below. But I don't think either of them have any
relation to BPF token and the problem I'm trying to solve.

>
> 1. Why can't we add security_bpf_probe_read_{kernel,user}?
>     If possible, we can use these LSM hooks to refuse the process to
> read other tasks' information. E.g. if the other process is not within
> the same cgroup or the same namespace, we just refuse the reading. I
> think it is not hard to identify if the other process is within the
> same cgroup or the same namespace.

There are probably many reasons. First, performance-wide, LSM hook for
each bpf_probe_read_{kernel,user}() call will be prohibitive. And just
in general, one would need to be very careful with such LSM hooks,
because bpf_probe_read_{kernel,user}() often happens from NMI context,
and LSM policy would have to be written and validated very carefully
with NMI context in mind.

But, more conceptually, for probe_read you get a random address and
you know the process context you are running in (but you might be
actually running in softirq and NMI, and that process context is
irrelevant). How can you efficiently (or at all) tell if that random
address "belongs" to cgroup or namespace? Just at conceptual level?

>
> 2. Why can't we extend bpf_cookie?
>    We're now using bpf_cookie to identify each user or each
> application, and only the permitted cookies can create new probe
> links.  However we find the bpf_cookie is only supported by tracing,
> perf_event and kprobe_multi, so we're planning to extend it to other
> possible link types, then we can use LSM hooks to control all bpf
> links.  I think that the upstream kernel should also support
> bpf_cookie for all bpf links. If possible, we will post it to the
> upstream in the future.
>    After I have read your BPF token proposal, I just have some other
> ideas. Why can't we just extend bpf_cookie to all other BPF objects?
> For example, all progs and maps should also have the bpf_cookie.
>

I'm not exactly clear how you use BPF cookie, but it wasn't intended
to provide any sort of security or validation policy. It's purely a
user-provided u64 to help distinguish different attach points when the
same BPF program is attached in multiple places (e.g., kprobe tracing
many different kernel functions and needing to distinguish between
them at runtime).

I do agree BPF cookie is super useful and we should keep extending
other types of BPF programs with BPF cookie support, of course. It's
just completely orthogonal to BPF token discussion.


>
> --
> Regards
> Yafang

