Return-Path: <bpf+bounces-4378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B8D74A88D
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 03:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB119281592
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC9B1112;
	Fri,  7 Jul 2023 01:43:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF887F
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 01:43:35 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D3C9D;
	Thu,  6 Jul 2023 18:43:32 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-636801fada1so9634866d6.3;
        Thu, 06 Jul 2023 18:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688694212; x=1691286212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYrTXI7gSQCfLyqgnBuCQ501nuZv3jfn0CuxuIfqaAk=;
        b=FvuKByR8Dv7sHfpkna6Y42alqEv3R3uHVSmtx3kqcq3oP7xlHLUnPsiysLYpwp2G0n
         u7iIt1sAyZZuicEwS9CnaLS6lQZkDpkmNd/NEk30wAnl7PeRRN3pXAwHZZ35O/eMB4gV
         ea0YUGVJynfZNzVg1w1VEW2I07uD9ezamtmholNbDjSyAIABnehOALw8/W9jBlQm3GAP
         to4geWwO10kFIL9FkgUIstylYHlpvcig3j+OYKGul33MH2n8Mtf5FWCZcHxq4ZKp1aGX
         cxXoW25Q/9c++v81hIV7UzTi/uAD6tS0OcD1xxV5H31kQ27X3yg0sZ0n7kVoGl/Ctndw
         dG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688694212; x=1691286212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYrTXI7gSQCfLyqgnBuCQ501nuZv3jfn0CuxuIfqaAk=;
        b=Qa1MHy8NIT7WN2VkOTlCmfuu31wrmzX9K4PgnUqRpmLJM8UDzigu0NPFeCHz+WAZIM
         UZK32x9bmlST7YsO46UT2aCPyFjLvc+wQpdwq1t7UWoOcXY0ryYAqibFYct9qGwmMlah
         yVbnWTHgzvjWsV0M7oaICNdQ6KsPIseixXJtcUMi4csnxDW/Z2xTUMQxCuqY7Tc4Ks9a
         l6GBSRrI/xQ4XQelIgzVfnuMe4KFt+BnIPcm2rtcugW+lNgynvDGTWtGr6jRPefuW1OO
         266J4usSXlOHkEdp3/Ibpc6ja4YXXdV9FWVQFImeJnX4CYNvZGGx8HZk1pCceBz2u1+o
         Xvhw==
X-Gm-Message-State: ABy/qLYesOD4n6Kw1hlaDrTnGby1+LzV/x/M/PGW/pDiRLXJFhfqk4tZ
	GBLYVaDWohSL/mK8wBzzvpLdeXgqlyYzb5y44yU=
X-Google-Smtp-Source: APBJJlG8Zi36mJiwHABNj74/7D43qm0Alr9ZlT9tOQz14i68wajwEhm2dUck4ZtJZ68JduWqWnVrf2+2rN/vsKTpmxQ=
X-Received: by 2002:a0c:8e4f:0:b0:631:fb35:27e1 with SMTP id
 w15-20020a0c8e4f000000b00631fb3527e1mr2894703qvb.4.1688694211670; Thu, 06 Jul
 2023 18:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629051832.897119-1-andrii@kernel.org> <CALOAHbBupxQ3RH+SbzUv=W2dRDS-mG1PuRpARrMnMv=o6Ro7Sw@mail.gmail.com>
 <CAEf4BzbS55xw2Scnid87O5TFQ7To56huPaKg_oH6gLSp+ggpdw@mail.gmail.com>
 <CALOAHbBBeXSfvVcUYgvPE8j7NAtd6EZfFYkvQxr316ucx37QzA@mail.gmail.com> <CAEf4BzYHY_aqMdDd7vcfDxHgL+geA=Bp71xtDp-U8Ycz7Ggk0g@mail.gmail.com>
In-Reply-To: <CAEf4BzYHY_aqMdDd7vcfDxHgL+geA=Bp71xtDp-U8Ycz7Ggk0g@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 7 Jul 2023 09:42:54 +0800
Message-ID: <CALOAHbBNnHSJHUWxQceUo0yY_ZaH=-hyVrsz2+jdEqY6103TXQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 bpf-next 00/14] BPF token
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Fri, Jul 7, 2023 at 4:34=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jul 5, 2023 at 6:27=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Thu, Jul 6, 2023 at 4:37=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Jun 30, 2023 at 7:06=E2=80=AFPM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > On Thu, Jun 29, 2023 at 1:18=E2=80=AFPM Andrii Nakryiko <andrii@ker=
nel.org> wrote:
> > > > >
> > > > > This patch set introduces new BPF object, BPF token, which allows=
 to delegate
> > > > > a subset of BPF functionality from privileged system-wide daemon =
(e.g.,
> > > > > systemd or any other container manager) to a *trusted* unprivileg=
ed
> > > > > application. Trust is the key here. This functionality is not abo=
ut allowing
> > > > > unconditional unprivileged BPF usage. Establishing trust, though,=
 is
> > > > > completely up to the discretion of respective privileged applicat=
ion that
> > > > > would create a BPF token, as different production setups can and =
do achieve it
> > > > > through a combination of different means (signing, LSM, code revi=
ews, etc),
> > > > > and it's undesirable and infeasible for kernel to enforce any par=
ticular way
> > > > > of validating trustworthiness of particular process.
> > > > >
> > > > > The main motivation for BPF token is a desire to enable container=
ized
> > > > > BPF applications to be used together with user namespaces. This i=
s currently
> > > > > impossible, as CAP_BPF, required for BPF subsystem usage, cannot =
be namespaced
> > > > > or sandboxed, as a general rule. E.g., tracing BPF programs, than=
ks to BPF
> > > > > helpers like bpf_probe_read_kernel() and bpf_probe_read_user() ca=
n safely read
> > > > > arbitrary memory, and it's impossible to ensure that they only re=
ad memory of
> > > > > processes belonging to any given namespace. This means that it's =
impossible to
> > > > > have namespace-aware CAP_BPF capability, and as such another mech=
anism to
> > > > > allow safe usage of BPF functionality is necessary. BPF token and=
 delegation
> > > > > of it to a trusted unprivileged applications is such mechanism. K=
ernel makes
> > > > > no assumption about what "trusted" constitutes in any particular =
case, and
> > > > > it's up to specific privileged applications and their surrounding
> > > > > infrastructure to decide that. What kernel provides is a set of A=
PIs to create
> > > > > and tune BPF token, and pass it around to privileged BPF commands=
 that are
> > > > > creating new BPF objects like BPF programs, BPF maps, etc.
> > > > >
> > > > > Previous attempt at addressing this very same problem ([0]) attem=
pted to
> > > > > utilize authoritative LSM approach, but was conclusively rejected=
 by upstream
> > > > > LSM maintainers. BPF token concept is not changing anything about=
 LSM
> > > > > approach, but can be combined with LSM hooks for very fine-graine=
d security
> > > > > policy. Some ideas about making BPF token more convenient to use =
with LSM (in
> > > > > particular custom BPF LSM programs) was briefly described in rece=
nt LSF/MM/BPF
> > > > > 2023 presentation ([1]). E.g., an ability to specify user-provide=
d data
> > > > > (context), which in combination with BPF LSM would allow implemen=
ting a very
> > > > > dynamic and fine-granular custom security policies on top of BPF =
token. In the
> > > > > interest of minimizing API surface area discussions this is going=
 to be
> > > > > added in follow up patches, as it's not essential to the fundamen=
tal concept
> > > > > of delegatable BPF token.
> > > > >
> > > > > It should be noted that BPF token is conceptually quite similar t=
o the idea of
> > > > > /dev/bpf device file, proposed by Song a while ago ([2]). The big=
gest
> > > > > difference is the idea of using virtual anon_inode file to hold B=
PF token and
> > > > > allowing multiple independent instances of them, each with its ow=
n set of
> > > > > restrictions. BPF pinning solves the problem of exposing such BPF=
 token
> > > > > through file system (BPF FS, in this case) for cases where transf=
erring FDs
> > > > > over Unix domain sockets is not convenient. And also, crucially, =
BPF token
> > > > > approach is not using any special stateful task-scoped flags. Ins=
tead, bpf()
> > > > > syscall accepts token_fd parameters explicitly for each relevant =
BPF command.
> > > > > This addresses main concerns brought up during the /dev/bpf discu=
ssion, and
> > > > > fits better with overall BPF subsystem design.
> > > > >
> > > > > This patch set adds a basic minimum of functionality to make BPF =
token useful
> > > > > and to discuss API and functionality. Currently only low-level li=
bbpf APIs
> > > > > support passing BPF token around, allowing to test kernel functio=
nality, but
> > > > > for the most part is not sufficient for real-world applications, =
which
> > > > > typically use high-level libbpf APIs based on `struct bpf_object`=
 type. This
> > > > > was done with the intent to limit the size of patch set and conce=
ntrate on
> > > > > mostly kernel-side changes. All the necessary plumbing for libbpf=
 will be sent
> > > > > as a separate follow up patch set kernel support makes it upstrea=
m.
> > > > >
> > > > > Another part that should happen once kernel-side BPF token is est=
ablished, is
> > > > > a set of conventions between applications (e.g., systemd), tools =
(e.g.,
> > > > > bpftool), and libraries (e.g., libbpf) about sharing BPF tokens t=
hrough BPF FS
> > > > > at well-defined locations to allow applications take advantage of=
 this in
> > > > > automatic fashion without explicit code changes on BPF applicatio=
n's side.
> > > > > But I'd like to postpone this discussion to after BPF token conce=
pt lands.
> > > > >
> > > > > Once important distinctions from v2 that should be noted is a cha=
nce in the
> > > > > semantics of a newly added BPF_TOKEN_CREATE command. Previously,
> > > > > BPF_TOKEN_CREATE would create BPF token kernel object and return =
its FD to
> > > > > user-space, allowing to (optionally) pin it in BPF FS using BPF_O=
BJ_PIN
> > > > > command. This v3 version changes this slightly: BPF_TOKEN_CREATE =
combines BPF
> > > > > token object creation *and* pinning in BPF FS. Such change ensure=
s that BPF
> > > > > token is always associated with a specific instance of BPF FS and=
 cannot
> > > > > "escape" it by application re-pinning it somewhere else using ano=
ther
> > > > > BPF_OBJ_PIN call. Now, BPF token can only be pinned once during i=
ts creation,
> > > > > better containing it inside intended container (under assumption =
BPF FS is set
> > > > > up in such a way as to not be shared with other containers on the=
 system).
> > > > >
> > > > >   [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@=
kernel.org/
> > > > >   [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivi=
leged_BPF_LSFMM2023.pdf
> > > > >   [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songli=
ubraving@fb.com/
> > > > >
> > > > > v3->v3-resend:
> > > > >   - I started integrating token_fd into bpf_object_open_opts and =
higher-level
> > > > >     libbpf bpf_object APIs, but it started going a bit deeper int=
o bpf_object
> > > > >     implementation details and how libbpf performs feature detect=
ion and
> > > > >     caching, so I decided to keep it separate from this patch set=
 and not
> > > > >     distract from the mostly kernel-side changes;
> > > > > v2->v3:
> > > > >   - make BPF_TOKEN_CREATE pin created BPF token in BPF FS, and di=
sallow
> > > > >     BPF_OBJ_PIN for BPF token;
> > > > > v1->v2:
> > > > >   - fix build failures on Kconfig with CONFIG_BPF_SYSCALL unset;
> > > > >   - drop BPF_F_TOKEN_UNKNOWN_* flags and simplify UAPI (Stanislav=
).
> > > > >
> > > > > Andrii Nakryiko (14):
> > > > >   bpf: introduce BPF token object
> > > > >   libbpf: add bpf_token_create() API
> > > > >   selftests/bpf: add BPF_TOKEN_CREATE test
> > > > >   bpf: add BPF token support to BPF_MAP_CREATE command
> > > > >   libbpf: add BPF token support to bpf_map_create() API
> > > > >   selftests/bpf: add BPF token-enabled test for BPF_MAP_CREATE co=
mmand
> > > > >   bpf: add BPF token support to BPF_BTF_LOAD command
> > > > >   libbpf: add BPF token support to bpf_btf_load() API
> > > > >   selftests/bpf: add BPF token-enabled BPF_BTF_LOAD selftest
> > > > >   bpf: add BPF token support to BPF_PROG_LOAD command
> > > > >   bpf: take into account BPF token when fetching helper protos
> > > > >   bpf: consistenly use BPF token throughout BPF verifier logic
> > > > >   libbpf: add BPF token support to bpf_prog_load() API
> > > > >   selftests/bpf: add BPF token-enabled BPF_PROG_LOAD tests
> > > > >
> > > > >  drivers/media/rc/bpf-lirc.c                   |   2 +-
> > > > >  include/linux/bpf.h                           |  79 ++++-
> > > > >  include/linux/filter.h                        |   2 +-
> > > > >  include/uapi/linux/bpf.h                      |  53 ++++
> > > > >  kernel/bpf/Makefile                           |   2 +-
> > > > >  kernel/bpf/arraymap.c                         |   2 +-
> > > > >  kernel/bpf/cgroup.c                           |   6 +-
> > > > >  kernel/bpf/core.c                             |   3 +-
> > > > >  kernel/bpf/helpers.c                          |   6 +-
> > > > >  kernel/bpf/inode.c                            |  46 ++-
> > > > >  kernel/bpf/syscall.c                          | 183 +++++++++---
> > > > >  kernel/bpf/token.c                            | 201 ++++++++++++=
+
> > > > >  kernel/bpf/verifier.c                         |  13 +-
> > > > >  kernel/trace/bpf_trace.c                      |   2 +-
> > > > >  net/core/filter.c                             |  36 +--
> > > > >  net/ipv4/bpf_tcp_ca.c                         |   2 +-
> > > > >  net/netfilter/nf_bpf_link.c                   |   2 +-
> > > > >  tools/include/uapi/linux/bpf.h                |  53 ++++
> > > > >  tools/lib/bpf/bpf.c                           |  35 ++-
> > > > >  tools/lib/bpf/bpf.h                           |  45 ++-
> > > > >  tools/lib/bpf/libbpf.map                      |   1 +
> > > > >  .../selftests/bpf/prog_tests/libbpf_probes.c  |   4 +
> > > > >  .../selftests/bpf/prog_tests/libbpf_str.c     |   6 +
> > > > >  .../testing/selftests/bpf/prog_tests/token.c  | 277 ++++++++++++=
++++++
> > > > >  24 files changed, 957 insertions(+), 104 deletions(-)
> > > > >  create mode 100644 kernel/bpf/token.c
> > > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/token.=
c
> > > > >
> > > > > --
> > > > > 2.34.1
> > > > >
> > > > >
> > > >
> > > >
> > > > Hi Andrii,
> > > >
> > > > Thanks for your proposal.
> > > > That seems to be a useful functionality, and yet I have some questi=
ons.
> > >
> > > I've answered them below. But I don't think either of them have any
> > > relation to BPF token and the problem I'm trying to solve.
> > >
> > > >
> > > > 1. Why can't we add security_bpf_probe_read_{kernel,user}?
> > > >     If possible, we can use these LSM hooks to refuse the process t=
o
> > > > read other tasks' information. E.g. if the other process is not wit=
hin
> > > > the same cgroup or the same namespace, we just refuse the reading. =
I
> > > > think it is not hard to identify if the other process is within the
> > > > same cgroup or the same namespace.
> > >
> > > There are probably many reasons. First, performance-wide, LSM hook fo=
r
> > > each bpf_probe_read_{kernel,user}() call will be prohibitive. And jus=
t
> > > in general, one would need to be very careful with such LSM hooks,
> > > because bpf_probe_read_{kernel,user}() often happens from NMI context=
,
> > > and LSM policy would have to be written and validated very carefully
> > > with NMI context in mind.
> > >
> > > But, more conceptually, for probe_read you get a random address and
> > > you know the process context you are running in (but you might be
> > > actually running in softirq and NMI, and that process context is
> > > irrelevant). How can you efficiently (or at all) tell if that random
> > > address "belongs" to cgroup or namespace? Just at conceptual level?
> > >
> > > >
> > > > 2. Why can't we extend bpf_cookie?
> > > >    We're now using bpf_cookie to identify each user or each
> > > > application, and only the permitted cookies can create new probe
> > > > links.  However we find the bpf_cookie is only supported by tracing=
,
> > > > perf_event and kprobe_multi, so we're planning to extend it to othe=
r
> > > > possible link types, then we can use LSM hooks to control all bpf
> > > > links.  I think that the upstream kernel should also support
> > > > bpf_cookie for all bpf links. If possible, we will post it to the
> > > > upstream in the future.
> > > >    After I have read your BPF token proposal, I just have some othe=
r
> > > > ideas. Why can't we just extend bpf_cookie to all other BPF objects=
?
> > > > For example, all progs and maps should also have the bpf_cookie.
> > > >
> > >
> > > I'm not exactly clear how you use BPF cookie, but it wasn't intended
> > > to provide any sort of security or validation policy. It's purely a
> > > user-provided u64 to help distinguish different attach points when th=
e
> > > same BPF program is attached in multiple places (e.g., kprobe tracing
> > > many different kernel functions and needing to distinguish between
> > > them at runtime).
> >
> > In our container environment, we enable the CAP_BPF, CAP_PERMON and
> > CAP_NET_ADMIN for the containers which want to run BPF programs
> > inside. However we don't want them to run whatever BPF programs they
> > want. We only allow them to run the BPF programs we have permitted for
> > each of them.  So we are using LSM to audit the BPF behavior such as
> > prog load, map creation and link attach.  We define different BPF
> > policies for different containers. In order to identify different
> > containers efficiently, we assign different bpf_cookies for different
> > containers. bpf_cookie is a u64, that's enough for our use cases.
>
> I can see how you can use BPF cookies for this, but it's certainly not
> an intended use case :) BPF cookie is most useful on BPF side of
> things.

The utilization of the bpf_cookie appid in our use case has proven to
be valuable, thus we continue to rely on its functionality :)

>
> But what you are describing is meant to be doable with BPF token. It's
> not in first patch set, but I intended to allow user to specify an
> extra "user context" blog of bytes which would be stored with BPF
> token. And this data should be accessible from BPF LSM programs to
> make extra custom policy decisions. But we need to agree on initial
> BPF token stuff first, and then build out all the rest.

Sounds good. Introducing support for user context within the BPF token
would enhance its utility and provide even more valuable
functionality.

--=20
Regards
Yafang

