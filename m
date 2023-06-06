Return-Path: <bpf+bounces-1939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A654724950
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 18:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828371C20B9D
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 16:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2CA1ED23;
	Tue,  6 Jun 2023 16:38:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E044174D4
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 16:38:31 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681ECE62;
	Tue,  6 Jun 2023 09:38:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-977d55ac17bso456903266b.3;
        Tue, 06 Jun 2023 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686069507; x=1688661507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+HZNjMwQdashp77X7/htZi1rAHPZ0ZpQPJkYn7644E=;
        b=ry3o+RYPl61C4CRU1wAuNz1f9AjA0TyLHtOaNZqMGyg5su/3Wi1PAzErj8NQSc8w4H
         ECP48S2tKVPS3ibhl1B1RCQNeMakiCZBNRJeDFMqnI6d9d/29QB2+iQ6TJ4x+obJbjGq
         0XdZvff+Qz5NKuQK281fZXPDgWXrVQ5WlqXBHgsQnOKLUXZEzxQcUyb0ExfELOfA7wXY
         iQAHhQN4YODCEWmkYr+7j84A9L3r+V/VHHm5T404N8g78LDgSnEI7ngHmSiqmMBnq4wd
         fBuG99WOq+0+WGxz3Oj8TYPREHiC3VP0bq9YzTWkvbJNQ67mYd9iaZPJb43NdjsNUqls
         Lkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686069507; x=1688661507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+HZNjMwQdashp77X7/htZi1rAHPZ0ZpQPJkYn7644E=;
        b=I6OTnf/zWdq3tD+Pm8QyCzQG6WTf0RGYnH2TB3M8aS2ylAA3OU3A6vvOvIqdcyghiX
         la6iK71Z1pAUrhsFHcnUt+9QGaLtBrAxDRwDgt6bgF2gxa9yM0n2CbyREXteqyfaUf3+
         f2zlLcG6qvoc57s3y+0j8U84sa50Zib383QYmW4qF4LSX8Di8lZnkAtH9iFnrHu49IIn
         0LWaC/QZNUNRNx0Ab5WYFGAVGd89blE7ygvziOmGrak3CSHhMLiABvoPcDQ+BB8hPMGL
         C/AsknFLHwZZ+QYoAEC4k45SRvXjxXFP7mES+sPpJSXpYtj1onwj+Bhe+rtqWz7KJvZ6
         33lg==
X-Gm-Message-State: AC+VfDwKaqfd+f58UHJ4F9JHRkPAmtlA7zv8htj6pj7tz/XJ1LZb4Uuh
	drzUAsjn/nbSdU4Cy0v7N1fxSMlsYhqHhdINZrA=
X-Google-Smtp-Source: ACHHUZ5n3UxYTOxAYzh644kCWV2+kg5UnbOxpbGOyb7ZPXglSPBBpUT00hCZHjoHLcUj6oGDSy3Zp58CQIzi2im+EqU=
X-Received: by 2002:a17:907:8a15:b0:974:1c98:d2d9 with SMTP id
 sc21-20020a1709078a1500b009741c98d2d9mr3266373ejc.3.1686069506444; Tue, 06
 Jun 2023 09:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602150011.1657856-1-andrii@kernel.org> <1930272b-cfbe-f366-21ca-e9e7a51347be@schaufler-ca.com>
 <CAEf4BzZ5adUcs1qaHx34ZuXMyG6ByczyUqpFKq=+CtxPHYgEVQ@mail.gmail.com>
 <24dcbfec-1527-ab14-9726-ca91d68f35d4@schaufler-ca.com> <CAEf4BzYj9YY==awasOt+ufJGJj7P2g6qC6aMxX-Phos01aUXqw@mail.gmail.com>
 <a61d8739-300f-67b0-7e7a-acf8fb1a44a8@schaufler-ca.com>
In-Reply-To: <a61d8739-300f-67b0-7e7a-acf8fb1a44a8@schaufler-ca.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 Jun 2023 09:38:13 -0700
Message-ID: <CAEf4BzaEbrRsebkgCvAOaDDL+DV8jY_+bf2-AvMi32WbLSrG3w@mail.gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 5, 2023 at 5:06=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> On 6/5/2023 4:12 PM, Andrii Nakryiko wrote:
> > On Mon, Jun 5, 2023 at 3:26=E2=80=AFPM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> >> On 6/5/2023 1:41 PM, Andrii Nakryiko wrote:
> >>> On Fri, Jun 2, 2023 at 8:55=E2=80=AFAM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >>>> On 6/2/2023 7:59 AM, Andrii Nakryiko wrote:
> >>>>> *Resending with trimmed CC list because original version didn't mak=
e it to
> >>>>> the mailing list.*
> >>>>>
> >>>>> This patch set introduces new BPF object, BPF token, which allows t=
o delegate
> >>>>> a subset of BPF functionality from privileged system-wide daemon (e=
.g.,
> >>>>> systemd or any other container manager) to a *trusted* unprivileged
> >>>>> application. Trust is the key here. This functionality is not about=
 allowing
> >>>>> unconditional unprivileged BPF usage. Establishing trust, though, i=
s
> >>>>> completely up to the discretion of respective privileged applicatio=
n that
> >>>>> would create a BPF token.
> >>>> Token based privilege has a number of well understood weaknesses,
> >>>> none of which I see addressed here. I also have a real problem with
> >>> Can you please provide some more details about those weaknesses? Hard
> >>> to respond without knowing exactly what we are talking about.
> >> Privileged Process (PP) sends a Token to Trusted Process (TP).
> >> TP sends the Token along to Untrusted Process, which performs nefariou=
s
> >> deeds.
> >>
> >> Privileged Process (PP) sends a Token to Trusted Process (TP).
> >> TP uses Token, and then saves it in its toolbox. PP later sends
> >> TP a different Token. TP realizes that with the combination of
> >> Tokens it now has it can do considerably more than what PP
> >> intended in either of the cases it sent Token for. TP performs
> >> nefarious deeds.
> >>
> >> Granted, in both cases TP does not deserve to be trusted.
> > Right, exactly. The intended use case here is a controlled production
> > containerized environment, where the container manager is privileged
> > and controls which applications are run inside the container. These
> > are coming from applications that are code reviewed and controlled by
> > whichever organization.
>
> I understand the intended use case. You have to allow for unintended abus=
e
> cases when you implement a security mechanism. You can't wave your hand a=
nd
> say that everything that is trusted in worthy of trust. You have to have
> mechanism to ensure that. The existing security mechanisms (uids, capabil=
ities
> and so forth) have explicit criteria for how they delegate privilege, and
> what the consequences of doing so might be.
>

I'm sorry, I'm failing to see the point you are trying to make. Any
API (especially privileged ones, like BPF_TOKEN_CREATE) can be misused
or abused, but we still grant root permissions to various production
processes, right? So I'm not sure where this is going. If you have
something specific in mind, please do tell.

> >
> >> Because TP does not run with privilege of its own, it is not
> >> treated with the same level of caution as it would be if it did.
> >>
> >> Privileged Process (PP) sends a Token to what it thinks is a Trusted
> >> Process (TP) but is in fact an Imposter Process (IP) that has been
> >> enabled on the system using any number of K33L techniques.
> > So if there is a probability of Imposter Process, neither BPF token
> > nor CAP_BPF should be granted at all. In production no one gives
> > CAP_BPF to processes that we cannot be reasonably sure is safe to use
> > BPF. As I mentioned in the cover letter, BPF token is not a mechanism
> > to implement unprivileged BPF.
>
> You're correct, PP *shouldn't* grant IP a Token. But it *can* do so.
> Think of the military definition of a threat. It's what the other guy
> is capable of doing to you, not what the other guy is expected to do to y=
ou.
> PP is capable to giving a Token to IP, even if PP does not intend to.
>
> > What I'm trying to achieve here is instead of needing to grant root
> > capabilities to any (trusted, otherwise no one would do this)
> > BPF-using application, we'd like to grant BPF token which is more
> > limited in scope and gives much less privileges to do anything with
> > the system. And, crucially, CAP_BPF is incompatible with user
> > namespaces, while BPF token is.
>
> I get that. Dynamically increasing a process' privilege (TP) from an
> external source (PP) without somehow marking TP as worthy of the privileg=
e
> is going to be insanely dangerous. Even in well controlled environments.
>
> >
> > Basically, I'd like to go from having root/CAP_BPF processes in init
> > namespace, to have unprivileged processes under user namespace, but
> > with BPF token that would still allow to do them controlled (through
> > combination of code reviews, audit, and security enforcements) BPF
> > usage.
>
> And the problem there is that if you put the feature in the kernel
> you can assume that some number of people will use it without code
> reviews, audit or security enforcement. Of course you can call out
> "user error", but someone is going to want you to "fix" it.
>
> >
> >> I don't see anything that ensures that PP communicates Tokens only
> >> to TP, nor any criteria for "trust" are met.
> > This should be up to PP how to organize this and will differ in
> > different production setups. E.g., for something like systemd or
> > container manager, one way to communicate this is to create a
> > dedicated instance of BPF FS, pin BPF token in it, and expose that
> > specific instance of BPF FS in the container's mount namespace.
>
> I have no doubt that you can make a system that works and works correctly=
.
> I'm saying that it's very easy to create a system that had easily exploit=
ed
> security holes. You won't do it, but someone who didn't design your
> mechanism will.
>

As I mentioned above, I'm failing to see where this is going... If you
give a process CAP_SYS_ADMIN capabilities, it can create a BPF token.
And it can pass it to some other process either through Unix domain
socket (SCM_RIGHTS), or BPF FS. If you can't be sure the privileged
process will do the right thing -- don't give it CAP_SYS_ADMIN. If you
did, don't blame API existence for your misused of it.

There are many privileged APIs, they exist for a reason, and yes, they
can be dangerous (which is why they are privileged), but they help to
solve real problems. Same here, we need something like a BPF token to
allow use of BPF within containers. And do that in a safer way than
granting CAP_SYS_ADMIN, CAP_BPF, etc capabilities.

> >
> >> Those are the issues I'm most familiar with, although I believe
> >> there are others.
> >>
> >>>> the notion of "trusted unprivileged" where trust is established by
> >>>> a user space application. Ignoring the possibility of malicious code
> >>>> for the moment, the opportunity for accidental privilege leakage is
> >>>> huge. It would be trivial (and tempting) to create a privileged BPF
> >>>> "shell" that would then be allowed to "trust" any application and
> >>>> run it with privilege by passing it a token.
> >>> Right now most BPF applications are running as real root in
> >>> production. Users have to trust such applications to not do anything
> >>> bad with their full root capabilities. How it is done depends on
> >>> specific production and organizational setups, and could be code
> >>> reviewing, audits, LSM, etc. So in that sense BPF token doesn't make
> >>> things worse. And it actually allows us to improve the situation by
> >>> creating and sharing more restrictive BPF tokens that limit what bpf(=
)
> >>> syscall parts are allowed to be used.
> >>>
> >>>>> The main motivation for BPF token is a desire to enable containeriz=
ed
> >>>>> BPF applications to be used together with user namespaces. This is =
currently
> >>>>> impossible, as CAP_BPF, required for BPF subsystem usage, cannot be=
 namespaced
> >>>>> or sandboxed, as a general rule. E.g., tracing BPF programs, thanks=
 to BPF
> >>>>> helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can =
safely read
> >>>>> arbitrary memory, and it's impossible to ensure that they only read=
 memory of
> >>>>> processes belonging to any given namespace. This means that it's im=
possible to
> >>>>> have namespace-aware CAP_BPF capability, and as such another mechan=
ism to
> >>>>> allow safe usage of BPF functionality is necessary. BPF token and d=
elegation
> >>>>> of it to a trusted unprivileged applications is such mechanism. Ker=
nel makes
> >>>>> no assumption about what "trusted" constitutes in any particular ca=
se, and
> >>>>> it's up to specific privileged applications and their surrounding
> >>>>> infrastructure to decide that. What kernel provides is a set of API=
s to create
> >>>>> and tune BPF token, and pass it around to privileged BPF commands t=
hat are
> >>>>> creating new BPF objects like BPF programs, BPF maps, etc.
> >>>>>
> >>>>> Previous attempt at addressing this very same problem ([0]) attempt=
ed to
> >>>>> utilize authoritative LSM approach, but was conclusively rejected b=
y upstream
> >>>>> LSM maintainers. BPF token concept is not changing anything about L=
SM
> >>>>> approach, but can be combined with LSM hooks for very fine-grained =
security
> >>>>> policy. Some ideas about making BPF token more convenient to use wi=
th LSM (in
> >>>>> particular custom BPF LSM programs) was briefly described in recent=
 LSF/MM/BPF
> >>>>> 2023 presentation ([1]). E.g., an ability to specify user-provided =
data
> >>>>> (context), which in combination with BPF LSM would allow implementi=
ng a very
> >>>>> dynamic and fine-granular custom security policies on top of BPF to=
ken. In the
> >>>>> interest of minimizing API surface area discussions this is going t=
o be
> >>>>> added in follow up patches, as it's not essential to the fundamenta=
l concept
> >>>>> of delegatable BPF token.
> >>>>>
> >>>>> It should be noted that BPF token is conceptually quite similar to =
the idea of
> >>>>> /dev/bpf device file, proposed by Song a while ago ([2]). The bigge=
st
> >>>>> difference is the idea of using virtual anon_inode file to hold BPF=
 token and
> >>>>> allowing multiple independent instances of them, each with its own =
set of
> >>>>> restrictions. BPF pinning solves the problem of exposing such BPF t=
oken
> >>>>> through file system (BPF FS, in this case) for cases where transfer=
ring FDs
> >>>>> over Unix domain sockets is not convenient. And also, crucially, BP=
F token
> >>>>> approach is not using any special stateful task-scoped flags. Inste=
ad, bpf()
> >>>>> syscall accepts token_fd parameters explicitly for each relevant BP=
F command.
> >>>>> This addresses main concerns brought up during the /dev/bpf discuss=
ion, and
> >>>>> fits better with overall BPF subsystem design.
> >>>>>
> >>>>> This patch set adds a basic minimum of functionality to make BPF to=
ken useful
> >>>>> and to discuss API and functionality. Currently only low-level libb=
pf APIs
> >>>>> support passing BPF token around, allowing to test kernel functiona=
lity, but
> >>>>> for the most part is not sufficient for real-world applications, wh=
ich
> >>>>> typically use high-level libbpf APIs based on `struct bpf_object` t=
ype. This
> >>>>> was done with the intent to limit the size of patch set and concent=
rate on
> >>>>> mostly kernel-side changes. All the necessary plumbing for libbpf w=
ill be sent
> >>>>> as a separate follow up patch set kernel support makes it upstream.
> >>>>>
> >>>>> Another part that should happen once kernel-side BPF token is estab=
lished, is
> >>>>> a set of conventions between applications (e.g., systemd), tools (e=
.g.,
> >>>>> bpftool), and libraries (e.g., libbpf) about sharing BPF tokens thr=
ough BPF FS
> >>>>> at well-defined locations to allow applications take advantage of t=
his in
> >>>>> automatic fashion without explicit code changes on BPF application'=
s side.
> >>>>> But I'd like to postpone this discussion to after BPF token concept=
 lands.
> >>>>>
> >>>>>   [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@ke=
rnel.org/
> >>>>>   [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivile=
ged_BPF_LSFMM2023.pdf
> >>>>>   [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliub=
raving@fb.com/
> >>>>>
> >>>>> Andrii Nakryiko (18):
> >>>>>   bpf: introduce BPF token object
> >>>>>   libbpf: add bpf_token_create() API
> >>>>>   selftests/bpf: add BPF_TOKEN_CREATE test
> >>>>>   bpf: move unprivileged checks into map_create() and bpf_prog_load=
()
> >>>>>   bpf: inline map creation logic in map_create() function
> >>>>>   bpf: centralize permissions checks for all BPF map types
> >>>>>   bpf: add BPF token support to BPF_MAP_CREATE command
> >>>>>   libbpf: add BPF token support to bpf_map_create() API
> >>>>>   selftests/bpf: add BPF token-enabled test for BPF_MAP_CREATE comm=
and
> >>>>>   bpf: add BPF token support to BPF_BTF_LOAD command
> >>>>>   libbpf: add BPF token support to bpf_btf_load() API
> >>>>>   selftests/bpf: add BPF token-enabled BPF_BTF_LOAD selftest
> >>>>>   bpf: keep BPF_PROG_LOAD permission checks clear of validations
> >>>>>   bpf: add BPF token support to BPF_PROG_LOAD command
> >>>>>   bpf: take into account BPF token when fetching helper protos
> >>>>>   bpf: consistenly use BPF token throughout BPF verifier logic
> >>>>>   libbpf: add BPF token support to bpf_prog_load() API
> >>>>>   selftests/bpf: add BPF token-enabled BPF_PROG_LOAD tests
> >>>>>
> >>>>>  drivers/media/rc/bpf-lirc.c                   |   2 +-
> >>>>>  include/linux/bpf.h                           |  66 ++-
> >>>>>  include/linux/filter.h                        |   2 +-
> >>>>>  include/uapi/linux/bpf.h                      |  74 +++
> >>>>>  kernel/bpf/Makefile                           |   2 +-
> >>>>>  kernel/bpf/arraymap.c                         |   2 +-
> >>>>>  kernel/bpf/bloom_filter.c                     |   3 -
> >>>>>  kernel/bpf/bpf_local_storage.c                |   3 -
> >>>>>  kernel/bpf/bpf_struct_ops.c                   |   3 -
> >>>>>  kernel/bpf/cgroup.c                           |   6 +-
> >>>>>  kernel/bpf/core.c                             |   3 +-
> >>>>>  kernel/bpf/cpumap.c                           |   4 -
> >>>>>  kernel/bpf/devmap.c                           |   3 -
> >>>>>  kernel/bpf/hashtab.c                          |   6 -
> >>>>>  kernel/bpf/helpers.c                          |   6 +-
> >>>>>  kernel/bpf/inode.c                            |  26 ++
> >>>>>  kernel/bpf/lpm_trie.c                         |   3 -
> >>>>>  kernel/bpf/queue_stack_maps.c                 |   4 -
> >>>>>  kernel/bpf/reuseport_array.c                  |   3 -
> >>>>>  kernel/bpf/stackmap.c                         |   3 -
> >>>>>  kernel/bpf/syscall.c                          | 429 ++++++++++++++=
----
> >>>>>  kernel/bpf/token.c                            | 141 ++++++
> >>>>>  kernel/bpf/verifier.c                         |  13 +-
> >>>>>  kernel/trace/bpf_trace.c                      |   2 +-
> >>>>>  net/core/filter.c                             |  36 +-
> >>>>>  net/core/sock_map.c                           |   4 -
> >>>>>  net/ipv4/bpf_tcp_ca.c                         |   2 +-
> >>>>>  net/netfilter/nf_bpf_link.c                   |   2 +-
> >>>>>  net/xdp/xskmap.c                              |   4 -
> >>>>>  tools/include/uapi/linux/bpf.h                |  74 +++
> >>>>>  tools/lib/bpf/bpf.c                           |  32 +-
> >>>>>  tools/lib/bpf/bpf.h                           |  24 +-
> >>>>>  tools/lib/bpf/libbpf.map                      |   1 +
> >>>>>  .../selftests/bpf/prog_tests/libbpf_probes.c  |   4 +
> >>>>>  .../selftests/bpf/prog_tests/libbpf_str.c     |   6 +
> >>>>>  .../testing/selftests/bpf/prog_tests/token.c  | 282 ++++++++++++
> >>>>>  .../bpf/prog_tests/unpriv_bpf_disabled.c      |   6 +-
> >>>>>  37 files changed, 1098 insertions(+), 188 deletions(-)
> >>>>>  create mode 100644 kernel/bpf/token.c
> >>>>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
> >>>>>

