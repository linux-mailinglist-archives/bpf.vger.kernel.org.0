Return-Path: <bpf+bounces-4300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC6974A4FB
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9081C20E01
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2536BA45;
	Thu,  6 Jul 2023 20:34:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D86663BA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 20:34:59 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2291BC9;
	Thu,  6 Jul 2023 13:34:56 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso1778985e87.3;
        Thu, 06 Jul 2023 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688675695; x=1691267695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZcLuGOcqC9je/N86ZlVzR8JBvn5c9gXD7Gs2iQqc7g=;
        b=NKPkwA8BFDOLW2s6zGRlmUL7QH4+uKqTgMgNsZzfXG26G2skEosQ5SSYhRSInO2HZb
         7mp/fcII1JCLe52au9T38bnmp9vNgKilWAyFXkkUI/1tRwKLj5pw36WsDug5PfOHkcaD
         zibPhRcm9tRFK1YMyBTPyShzcAp2Vi/Dpq4jpjSOKr6AnaXBZMIlhtPtTNw+niPmxb1L
         pIBTRirzU5haRcwOK/ikPf47WTNG9TxH1UVBBqOtw8aiewYq4y6/fclyTl0yol+VPHE5
         fBrjCB1uaJRPKvSToscwiZ2LVPlkzL+e8GMwBTrzvvsWvHnHhthSoNCR/3VkJ1Tawr7q
         qywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688675695; x=1691267695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZcLuGOcqC9je/N86ZlVzR8JBvn5c9gXD7Gs2iQqc7g=;
        b=Fl83ZA9i5Pq7+0dyr1Ak9CzHsTsvnWWqCTtj/Rnpu8ywnLDgrQ4cCbT16j6+6G5R6v
         NDraH5ngIOjZ1hx8w5Vs0TBrmhDTlAN3OENOGMsz2na+oRF5E2VpWCXfTsv0nvNpFPg1
         qxNxJpA8oNVhQjpt5hAttAyxiaiwR7+m3h8JVnYhGqqaHd448aq0VCSsyk3KGOvJXf2y
         gr2IZd4LG0qfBW/DcYOGwPvUcYEeJH/+bwCE3bI7nlUMWZTndt5z1TrfXb2YV8GL1Y9D
         6MagT4Z1B2kvDwqqElNCMGGUQRfHws3iJXbIdhH6oEj8LmoCZUGJzj2GvRu4XScBR6DV
         fSJQ==
X-Gm-Message-State: ABy/qLa6VrEntenmFVV3YyAU7XhdqeGg62ipAxJ9HEjmxRpu0vy7+3BI
	Wc00ZUF7aWwN89umT8g6dnf88a36nvrVC7El4Fk=
X-Google-Smtp-Source: APBJJlFYqeHkMCbHSW3I8vqFZoBPXjFE6lWXXVj+qKj0Xq5aNLxdVk1CjIOD8GyzZY6ZbmjgXUw31mB8zI1AsywnQJw=
X-Received: by 2002:a19:7710:0:b0:4fb:8a92:4fd5 with SMTP id
 s16-20020a197710000000b004fb8a924fd5mr2208498lfc.54.1688675694363; Thu, 06
 Jul 2023 13:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629051832.897119-1-andrii@kernel.org> <CALOAHbBupxQ3RH+SbzUv=W2dRDS-mG1PuRpARrMnMv=o6Ro7Sw@mail.gmail.com>
 <CAEf4BzbS55xw2Scnid87O5TFQ7To56huPaKg_oH6gLSp+ggpdw@mail.gmail.com> <CALOAHbBBeXSfvVcUYgvPE8j7NAtd6EZfFYkvQxr316ucx37QzA@mail.gmail.com>
In-Reply-To: <CALOAHbBBeXSfvVcUYgvPE8j7NAtd6EZfFYkvQxr316ucx37QzA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 13:34:42 -0700
Message-ID: <CAEf4BzYHY_aqMdDd7vcfDxHgL+geA=Bp71xtDp-U8Ycz7Ggk0g@mail.gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 6:27=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Thu, Jul 6, 2023 at 4:37=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jun 30, 2023 at 7:06=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > On Thu, Jun 29, 2023 at 1:18=E2=80=AFPM Andrii Nakryiko <andrii@kerne=
l.org> wrote:
> > > >
> > > > This patch set introduces new BPF object, BPF token, which allows t=
o delegate
> > > > a subset of BPF functionality from privileged system-wide daemon (e=
.g.,
> > > > systemd or any other container manager) to a *trusted* unprivileged
> > > > application. Trust is the key here. This functionality is not about=
 allowing
> > > > unconditional unprivileged BPF usage. Establishing trust, though, i=
s
> > > > completely up to the discretion of respective privileged applicatio=
n that
> > > > would create a BPF token, as different production setups can and do=
 achieve it
> > > > through a combination of different means (signing, LSM, code review=
s, etc),
> > > > and it's undesirable and infeasible for kernel to enforce any parti=
cular way
> > > > of validating trustworthiness of particular process.
> > > >
> > > > The main motivation for BPF token is a desire to enable containeriz=
ed
> > > > BPF applications to be used together with user namespaces. This is =
currently
> > > > impossible, as CAP_BPF, required for BPF subsystem usage, cannot be=
 namespaced
> > > > or sandboxed, as a general rule. E.g., tracing BPF programs, thanks=
 to BPF
> > > > helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can =
safely read
> > > > arbitrary memory, and it's impossible to ensure that they only read=
 memory of
> > > > processes belonging to any given namespace. This means that it's im=
possible to
> > > > have namespace-aware CAP_BPF capability, and as such another mechan=
ism to
> > > > allow safe usage of BPF functionality is necessary. BPF token and d=
elegation
> > > > of it to a trusted unprivileged applications is such mechanism. Ker=
nel makes
> > > > no assumption about what "trusted" constitutes in any particular ca=
se, and
> > > > it's up to specific privileged applications and their surrounding
> > > > infrastructure to decide that. What kernel provides is a set of API=
s to create
> > > > and tune BPF token, and pass it around to privileged BPF commands t=
hat are
> > > > creating new BPF objects like BPF programs, BPF maps, etc.
> > > >
> > > > Previous attempt at addressing this very same problem ([0]) attempt=
ed to
> > > > utilize authoritative LSM approach, but was conclusively rejected b=
y upstream
> > > > LSM maintainers. BPF token concept is not changing anything about L=
SM
> > > > approach, but can be combined with LSM hooks for very fine-grained =
security
> > > > policy. Some ideas about making BPF token more convenient to use wi=
th LSM (in
> > > > particular custom BPF LSM programs) was briefly described in recent=
 LSF/MM/BPF
> > > > 2023 presentation ([1]). E.g., an ability to specify user-provided =
data
> > > > (context), which in combination with BPF LSM would allow implementi=
ng a very
> > > > dynamic and fine-granular custom security policies on top of BPF to=
ken. In the
> > > > interest of minimizing API surface area discussions this is going t=
o be
> > > > added in follow up patches, as it's not essential to the fundamenta=
l concept
> > > > of delegatable BPF token.
> > > >
> > > > It should be noted that BPF token is conceptually quite similar to =
the idea of
> > > > /dev/bpf device file, proposed by Song a while ago ([2]). The bigge=
st
> > > > difference is the idea of using virtual anon_inode file to hold BPF=
 token and
> > > > allowing multiple independent instances of them, each with its own =
set of
> > > > restrictions. BPF pinning solves the problem of exposing such BPF t=
oken
> > > > through file system (BPF FS, in this case) for cases where transfer=
ring FDs
> > > > over Unix domain sockets is not convenient. And also, crucially, BP=
F token
> > > > approach is not using any special stateful task-scoped flags. Inste=
ad, bpf()
> > > > syscall accepts token_fd parameters explicitly for each relevant BP=
F command.
> > > > This addresses main concerns brought up during the /dev/bpf discuss=
ion, and
> > > > fits better with overall BPF subsystem design.
> > > >
> > > > This patch set adds a basic minimum of functionality to make BPF to=
ken useful
> > > > and to discuss API and functionality. Currently only low-level libb=
pf APIs
> > > > support passing BPF token around, allowing to test kernel functiona=
lity, but
> > > > for the most part is not sufficient for real-world applications, wh=
ich
> > > > typically use high-level libbpf APIs based on `struct bpf_object` t=
ype. This
> > > > was done with the intent to limit the size of patch set and concent=
rate on
> > > > mostly kernel-side changes. All the necessary plumbing for libbpf w=
ill be sent
> > > > as a separate follow up patch set kernel support makes it upstream.
> > > >
> > > > Another part that should happen once kernel-side BPF token is estab=
lished, is
> > > > a set of conventions between applications (e.g., systemd), tools (e=
.g.,
> > > > bpftool), and libraries (e.g., libbpf) about sharing BPF tokens thr=
ough BPF FS
> > > > at well-defined locations to allow applications take advantage of t=
his in
> > > > automatic fashion without explicit code changes on BPF application'=
s side.
> > > > But I'd like to postpone this discussion to after BPF token concept=
 lands.
> > > >
> > > > Once important distinctions from v2 that should be noted is a chanc=
e in the
> > > > semantics of a newly added BPF_TOKEN_CREATE command. Previously,
> > > > BPF_TOKEN_CREATE would create BPF token kernel object and return it=
s FD to
> > > > user-space, allowing to (optionally) pin it in BPF FS using BPF_OBJ=
_PIN
> > > > command. This v3 version changes this slightly: BPF_TOKEN_CREATE co=
mbines BPF
> > > > token object creation *and* pinning in BPF FS. Such change ensures =
that BPF
> > > > token is always associated with a specific instance of BPF FS and c=
annot
> > > > "escape" it by application re-pinning it somewhere else using anoth=
er
> > > > BPF_OBJ_PIN call. Now, BPF token can only be pinned once during its=
 creation,
> > > > better containing it inside intended container (under assumption BP=
F FS is set
> > > > up in such a way as to not be shared with other containers on the s=
ystem).
> > > >
> > > >   [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@ke=
rnel.org/
> > > >   [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivile=
ged_BPF_LSFMM2023.pdf
> > > >   [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliub=
raving@fb.com/
> > > >
> > > > v3->v3-resend:
> > > >   - I started integrating token_fd into bpf_object_open_opts and hi=
gher-level
> > > >     libbpf bpf_object APIs, but it started going a bit deeper into =
bpf_object
> > > >     implementation details and how libbpf performs feature detectio=
n and
> > > >     caching, so I decided to keep it separate from this patch set a=
nd not
> > > >     distract from the mostly kernel-side changes;
> > > > v2->v3:
> > > >   - make BPF_TOKEN_CREATE pin created BPF token in BPF FS, and disa=
llow
> > > >     BPF_OBJ_PIN for BPF token;
> > > > v1->v2:
> > > >   - fix build failures on Kconfig with CONFIG_BPF_SYSCALL unset;
> > > >   - drop BPF_F_TOKEN_UNKNOWN_* flags and simplify UAPI (Stanislav).
> > > >
> > > > Andrii Nakryiko (14):
> > > >   bpf: introduce BPF token object
> > > >   libbpf: add bpf_token_create() API
> > > >   selftests/bpf: add BPF_TOKEN_CREATE test
> > > >   bpf: add BPF token support to BPF_MAP_CREATE command
> > > >   libbpf: add BPF token support to bpf_map_create() API
> > > >   selftests/bpf: add BPF token-enabled test for BPF_MAP_CREATE comm=
and
> > > >   bpf: add BPF token support to BPF_BTF_LOAD command
> > > >   libbpf: add BPF token support to bpf_btf_load() API
> > > >   selftests/bpf: add BPF token-enabled BPF_BTF_LOAD selftest
> > > >   bpf: add BPF token support to BPF_PROG_LOAD command
> > > >   bpf: take into account BPF token when fetching helper protos
> > > >   bpf: consistenly use BPF token throughout BPF verifier logic
> > > >   libbpf: add BPF token support to bpf_prog_load() API
> > > >   selftests/bpf: add BPF token-enabled BPF_PROG_LOAD tests
> > > >
> > > >  drivers/media/rc/bpf-lirc.c                   |   2 +-
> > > >  include/linux/bpf.h                           |  79 ++++-
> > > >  include/linux/filter.h                        |   2 +-
> > > >  include/uapi/linux/bpf.h                      |  53 ++++
> > > >  kernel/bpf/Makefile                           |   2 +-
> > > >  kernel/bpf/arraymap.c                         |   2 +-
> > > >  kernel/bpf/cgroup.c                           |   6 +-
> > > >  kernel/bpf/core.c                             |   3 +-
> > > >  kernel/bpf/helpers.c                          |   6 +-
> > > >  kernel/bpf/inode.c                            |  46 ++-
> > > >  kernel/bpf/syscall.c                          | 183 +++++++++---
> > > >  kernel/bpf/token.c                            | 201 +++++++++++++
> > > >  kernel/bpf/verifier.c                         |  13 +-
> > > >  kernel/trace/bpf_trace.c                      |   2 +-
> > > >  net/core/filter.c                             |  36 +--
> > > >  net/ipv4/bpf_tcp_ca.c                         |   2 +-
> > > >  net/netfilter/nf_bpf_link.c                   |   2 +-
> > > >  tools/include/uapi/linux/bpf.h                |  53 ++++
> > > >  tools/lib/bpf/bpf.c                           |  35 ++-
> > > >  tools/lib/bpf/bpf.h                           |  45 ++-
> > > >  tools/lib/bpf/libbpf.map                      |   1 +
> > > >  .../selftests/bpf/prog_tests/libbpf_probes.c  |   4 +
> > > >  .../selftests/bpf/prog_tests/libbpf_str.c     |   6 +
> > > >  .../testing/selftests/bpf/prog_tests/token.c  | 277 ++++++++++++++=
++++
> > > >  24 files changed, 957 insertions(+), 104 deletions(-)
> > > >  create mode 100644 kernel/bpf/token.c
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > > >
> > >
> > >
> > > Hi Andrii,
> > >
> > > Thanks for your proposal.
> > > That seems to be a useful functionality, and yet I have some question=
s.
> >
> > I've answered them below. But I don't think either of them have any
> > relation to BPF token and the problem I'm trying to solve.
> >
> > >
> > > 1. Why can't we add security_bpf_probe_read_{kernel,user}?
> > >     If possible, we can use these LSM hooks to refuse the process to
> > > read other tasks' information. E.g. if the other process is not withi=
n
> > > the same cgroup or the same namespace, we just refuse the reading. I
> > > think it is not hard to identify if the other process is within the
> > > same cgroup or the same namespace.
> >
> > There are probably many reasons. First, performance-wide, LSM hook for
> > each bpf_probe_read_{kernel,user}() call will be prohibitive. And just
> > in general, one would need to be very careful with such LSM hooks,
> > because bpf_probe_read_{kernel,user}() often happens from NMI context,
> > and LSM policy would have to be written and validated very carefully
> > with NMI context in mind.
> >
> > But, more conceptually, for probe_read you get a random address and
> > you know the process context you are running in (but you might be
> > actually running in softirq and NMI, and that process context is
> > irrelevant). How can you efficiently (or at all) tell if that random
> > address "belongs" to cgroup or namespace? Just at conceptual level?
> >
> > >
> > > 2. Why can't we extend bpf_cookie?
> > >    We're now using bpf_cookie to identify each user or each
> > > application, and only the permitted cookies can create new probe
> > > links.  However we find the bpf_cookie is only supported by tracing,
> > > perf_event and kprobe_multi, so we're planning to extend it to other
> > > possible link types, then we can use LSM hooks to control all bpf
> > > links.  I think that the upstream kernel should also support
> > > bpf_cookie for all bpf links. If possible, we will post it to the
> > > upstream in the future.
> > >    After I have read your BPF token proposal, I just have some other
> > > ideas. Why can't we just extend bpf_cookie to all other BPF objects?
> > > For example, all progs and maps should also have the bpf_cookie.
> > >
> >
> > I'm not exactly clear how you use BPF cookie, but it wasn't intended
> > to provide any sort of security or validation policy. It's purely a
> > user-provided u64 to help distinguish different attach points when the
> > same BPF program is attached in multiple places (e.g., kprobe tracing
> > many different kernel functions and needing to distinguish between
> > them at runtime).
>
> In our container environment, we enable the CAP_BPF, CAP_PERMON and
> CAP_NET_ADMIN for the containers which want to run BPF programs
> inside. However we don't want them to run whatever BPF programs they
> want. We only allow them to run the BPF programs we have permitted for
> each of them.  So we are using LSM to audit the BPF behavior such as
> prog load, map creation and link attach.  We define different BPF
> policies for different containers. In order to identify different
> containers efficiently, we assign different bpf_cookies for different
> containers. bpf_cookie is a u64, that's enough for our use cases.

I can see how you can use BPF cookies for this, but it's certainly not
an intended use case :) BPF cookie is most useful on BPF side of
things.

But what you are describing is meant to be doable with BPF token. It's
not in first patch set, but I intended to allow user to specify an
extra "user context" blog of bytes which would be stored with BPF
token. And this data should be accessible from BPF LSM programs to
make extra custom policy decisions. But we need to agree on initial
BPF token stuff first, and then build out all the rest.

> We didn't use cgroup id to identify different containers because
> cgroup id is a local value in a server, while bpf_cookie is a global
> value, that would be easy for deployment.
> For your use cases, maybe we could enable CAP_BPF (+CAP_PERMON,
> +CAP_NET_ADMIN) for all users, and then we assign different
> bpf_cookies for different users, so we can use LSM to allow the user
> who have the permitted cookies to run BPF program ?
>
> >
> > I do agree BPF cookie is super useful and we should keep extending
> > other types of BPF programs with BPF cookie support, of course. It's
> > just completely orthogonal to BPF token discussion.
> >
>
> --
> Regards
> Yafang

