Return-Path: <bpf+bounces-1894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD54C723391
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 01:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88ABE2814B2
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 23:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C37928C01;
	Mon,  5 Jun 2023 23:13:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595EE5256
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 23:13:01 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3F3BE;
	Mon,  5 Jun 2023 16:12:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5147f7d045bso7880290a12.2;
        Mon, 05 Jun 2023 16:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686006776; x=1688598776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8GNYY/c/moA+1C+Bdiy0CQjR3rzdGBAENf63MhNMzg=;
        b=A6eLdpPAFMSDRyJXOkS98+xEKfi9olNB+SjvDFjHUOy83oadNqCDtANILfss67Pvi0
         UIyy20eJEU0qvE7xKho7xgkSIf+2+x4hAYXaQkziANJXD2cTEKv5cMKUMgKMjOZpcgsy
         AyShibKymfd3rxCOaUOGnYKOY+pCyQINhBw93U7IqmDaHbOp2Xd3RlMaAsY20z5UuAUw
         KFKPgNLjk+ljZ51QGy/IYgQRpdwbVgUj2GfBhRJwqATp3RA1+ND63eXkbPxFvKldpaJb
         WnlVyLxuML8vlKYSHp9kRoS7VTOkn+fICXPoD4Phi98OVB5fQRwC9SGmIg/rg7lM9CUU
         H8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686006776; x=1688598776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8GNYY/c/moA+1C+Bdiy0CQjR3rzdGBAENf63MhNMzg=;
        b=EgPW+msL1guXSnxQx3QagFYRaVGwa0h7GDD5+TfoACRowgUmvT3Q9B6A889jvvxrFS
         j1mXxg/pKkIKiC1z/kn2DmkluIDkyVMqIg03QUFpBasvANJG2eb9fit5w9zXuS6ZvtSc
         gaF+BLFdz5H/moRHuhsY6gE2/rN/Cg8Ml5uGsBXwJJv2f3KE3zEYfDWULrLjooPEnuj5
         TTYiNLReUZUEj73nlkghTZ8dvVE/2Sg8l+iH2xMcew31sHfVHY0zsbw+nf85zjF2K3Hx
         g2zHLFspY7MzO9qJFClyUuGGZoUb6jCSw3icq725Ahm7MZS3jRammGgxtx1iM9tKumX3
         w0FQ==
X-Gm-Message-State: AC+VfDzLiXDrCgbjFKqyz51SJkuZW9OcOLYRInXkuWSN0yBPlKk3+4Gz
	GMnyoA3e1yAHKGatZ32r/KHXzuCeEqjPcBMmNB0=
X-Google-Smtp-Source: ACHHUZ4/2g9IMtOwaiFlJUaMO7uUTyFjOI02sp1T/wxB3SKnrOEtG0jxMgX+vzDqm557/FpC5paPwGm6lasVFvZOiDY=
X-Received: by 2002:aa7:d54e:0:b0:50b:c77e:b071 with SMTP id
 u14-20020aa7d54e000000b0050bc77eb071mr426169edr.18.1686006776343; Mon, 05 Jun
 2023 16:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602150011.1657856-1-andrii@kernel.org> <1930272b-cfbe-f366-21ca-e9e7a51347be@schaufler-ca.com>
 <CAEf4BzZ5adUcs1qaHx34ZuXMyG6ByczyUqpFKq=+CtxPHYgEVQ@mail.gmail.com> <24dcbfec-1527-ab14-9726-ca91d68f35d4@schaufler-ca.com>
In-Reply-To: <24dcbfec-1527-ab14-9726-ca91d68f35d4@schaufler-ca.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jun 2023 16:12:44 -0700
Message-ID: <CAEf4BzYj9YY==awasOt+ufJGJj7P2g6qC6aMxX-Phos01aUXqw@mail.gmail.com>
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

On Mon, Jun 5, 2023 at 3:26=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> On 6/5/2023 1:41 PM, Andrii Nakryiko wrote:
> > On Fri, Jun 2, 2023 at 8:55=E2=80=AFAM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> >> On 6/2/2023 7:59 AM, Andrii Nakryiko wrote:
> >>> *Resending with trimmed CC list because original version didn't make =
it to
> >>> the mailing list.*
> >>>
> >>> This patch set introduces new BPF object, BPF token, which allows to =
delegate
> >>> a subset of BPF functionality from privileged system-wide daemon (e.g=
.,
> >>> systemd or any other container manager) to a *trusted* unprivileged
> >>> application. Trust is the key here. This functionality is not about a=
llowing
> >>> unconditional unprivileged BPF usage. Establishing trust, though, is
> >>> completely up to the discretion of respective privileged application =
that
> >>> would create a BPF token.
> >> Token based privilege has a number of well understood weaknesses,
> >> none of which I see addressed here. I also have a real problem with
> > Can you please provide some more details about those weaknesses? Hard
> > to respond without knowing exactly what we are talking about.
>
> Privileged Process (PP) sends a Token to Trusted Process (TP).
> TP sends the Token along to Untrusted Process, which performs nefarious
> deeds.
>
> Privileged Process (PP) sends a Token to Trusted Process (TP).
> TP uses Token, and then saves it in its toolbox. PP later sends
> TP a different Token. TP realizes that with the combination of
> Tokens it now has it can do considerably more than what PP
> intended in either of the cases it sent Token for. TP performs
> nefarious deeds.
>
> Granted, in both cases TP does not deserve to be trusted.

Right, exactly. The intended use case here is a controlled production
containerized environment, where the container manager is privileged
and controls which applications are run inside the container. These
are coming from applications that are code reviewed and controlled by
whichever organization.

> Because TP does not run with privilege of its own, it is not
> treated with the same level of caution as it would be if it did.
>
> Privileged Process (PP) sends a Token to what it thinks is a Trusted
> Process (TP) but is in fact an Imposter Process (IP) that has been
> enabled on the system using any number of K33L techniques.

So if there is a probability of Imposter Process, neither BPF token
nor CAP_BPF should be granted at all. In production no one gives
CAP_BPF to processes that we cannot be reasonably sure is safe to use
BPF. As I mentioned in the cover letter, BPF token is not a mechanism
to implement unprivileged BPF.

What I'm trying to achieve here is instead of needing to grant root
capabilities to any (trusted, otherwise no one would do this)
BPF-using application, we'd like to grant BPF token which is more
limited in scope and gives much less privileges to do anything with
the system. And, crucially, CAP_BPF is incompatible with user
namespaces, while BPF token is.

Basically, I'd like to go from having root/CAP_BPF processes in init
namespace, to have unprivileged processes under user namespace, but
with BPF token that would still allow to do them controlled (through
combination of code reviews, audit, and security enforcements) BPF
usage.

>
> I don't see anything that ensures that PP communicates Tokens only
> to TP, nor any criteria for "trust" are met.

This should be up to PP how to organize this and will differ in
different production setups. E.g., for something like systemd or
container manager, one way to communicate this is to create a
dedicated instance of BPF FS, pin BPF token in it, and expose that
specific instance of BPF FS in the container's mount namespace.

>
> Those are the issues I'm most familiar with, although I believe
> there are others.
>
> >> the notion of "trusted unprivileged" where trust is established by
> >> a user space application. Ignoring the possibility of malicious code
> >> for the moment, the opportunity for accidental privilege leakage is
> >> huge. It would be trivial (and tempting) to create a privileged BPF
> >> "shell" that would then be allowed to "trust" any application and
> >> run it with privilege by passing it a token.
> > Right now most BPF applications are running as real root in
> > production. Users have to trust such applications to not do anything
> > bad with their full root capabilities. How it is done depends on
> > specific production and organizational setups, and could be code
> > reviewing, audits, LSM, etc. So in that sense BPF token doesn't make
> > things worse. And it actually allows us to improve the situation by
> > creating and sharing more restrictive BPF tokens that limit what bpf()
> > syscall parts are allowed to be used.
> >
> >>> The main motivation for BPF token is a desire to enable containerized
> >>> BPF applications to be used together with user namespaces. This is cu=
rrently
> >>> impossible, as CAP_BPF, required for BPF subsystem usage, cannot be n=
amespaced
> >>> or sandboxed, as a general rule. E.g., tracing BPF programs, thanks t=
o BPF
> >>> helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can sa=
fely read
> >>> arbitrary memory, and it's impossible to ensure that they only read m=
emory of
> >>> processes belonging to any given namespace. This means that it's impo=
ssible to
> >>> have namespace-aware CAP_BPF capability, and as such another mechanis=
m to
> >>> allow safe usage of BPF functionality is necessary. BPF token and del=
egation
> >>> of it to a trusted unprivileged applications is such mechanism. Kerne=
l makes
> >>> no assumption about what "trusted" constitutes in any particular case=
, and
> >>> it's up to specific privileged applications and their surrounding
> >>> infrastructure to decide that. What kernel provides is a set of APIs =
to create
> >>> and tune BPF token, and pass it around to privileged BPF commands tha=
t are
> >>> creating new BPF objects like BPF programs, BPF maps, etc.
> >>>
> >>> Previous attempt at addressing this very same problem ([0]) attempted=
 to
> >>> utilize authoritative LSM approach, but was conclusively rejected by =
upstream
> >>> LSM maintainers. BPF token concept is not changing anything about LSM
> >>> approach, but can be combined with LSM hooks for very fine-grained se=
curity
> >>> policy. Some ideas about making BPF token more convenient to use with=
 LSM (in
> >>> particular custom BPF LSM programs) was briefly described in recent L=
SF/MM/BPF
> >>> 2023 presentation ([1]). E.g., an ability to specify user-provided da=
ta
> >>> (context), which in combination with BPF LSM would allow implementing=
 a very
> >>> dynamic and fine-granular custom security policies on top of BPF toke=
n. In the
> >>> interest of minimizing API surface area discussions this is going to =
be
> >>> added in follow up patches, as it's not essential to the fundamental =
concept
> >>> of delegatable BPF token.
> >>>
> >>> It should be noted that BPF token is conceptually quite similar to th=
e idea of
> >>> /dev/bpf device file, proposed by Song a while ago ([2]). The biggest
> >>> difference is the idea of using virtual anon_inode file to hold BPF t=
oken and
> >>> allowing multiple independent instances of them, each with its own se=
t of
> >>> restrictions. BPF pinning solves the problem of exposing such BPF tok=
en
> >>> through file system (BPF FS, in this case) for cases where transferri=
ng FDs
> >>> over Unix domain sockets is not convenient. And also, crucially, BPF =
token
> >>> approach is not using any special stateful task-scoped flags. Instead=
, bpf()
> >>> syscall accepts token_fd parameters explicitly for each relevant BPF =
command.
> >>> This addresses main concerns brought up during the /dev/bpf discussio=
n, and
> >>> fits better with overall BPF subsystem design.
> >>>
> >>> This patch set adds a basic minimum of functionality to make BPF toke=
n useful
> >>> and to discuss API and functionality. Currently only low-level libbpf=
 APIs
> >>> support passing BPF token around, allowing to test kernel functionali=
ty, but
> >>> for the most part is not sufficient for real-world applications, whic=
h
> >>> typically use high-level libbpf APIs based on `struct bpf_object` typ=
e. This
> >>> was done with the intent to limit the size of patch set and concentra=
te on
> >>> mostly kernel-side changes. All the necessary plumbing for libbpf wil=
l be sent
> >>> as a separate follow up patch set kernel support makes it upstream.
> >>>
> >>> Another part that should happen once kernel-side BPF token is establi=
shed, is
> >>> a set of conventions between applications (e.g., systemd), tools (e.g=
.,
> >>> bpftool), and libraries (e.g., libbpf) about sharing BPF tokens throu=
gh BPF FS
> >>> at well-defined locations to allow applications take advantage of thi=
s in
> >>> automatic fashion without explicit code changes on BPF application's =
side.
> >>> But I'd like to postpone this discussion to after BPF token concept l=
ands.
> >>>
> >>>   [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kern=
el.org/
> >>>   [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivilege=
d_BPF_LSFMM2023.pdf
> >>>   [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubra=
ving@fb.com/
> >>>
> >>> Andrii Nakryiko (18):
> >>>   bpf: introduce BPF token object
> >>>   libbpf: add bpf_token_create() API
> >>>   selftests/bpf: add BPF_TOKEN_CREATE test
> >>>   bpf: move unprivileged checks into map_create() and bpf_prog_load()
> >>>   bpf: inline map creation logic in map_create() function
> >>>   bpf: centralize permissions checks for all BPF map types
> >>>   bpf: add BPF token support to BPF_MAP_CREATE command
> >>>   libbpf: add BPF token support to bpf_map_create() API
> >>>   selftests/bpf: add BPF token-enabled test for BPF_MAP_CREATE comman=
d
> >>>   bpf: add BPF token support to BPF_BTF_LOAD command
> >>>   libbpf: add BPF token support to bpf_btf_load() API
> >>>   selftests/bpf: add BPF token-enabled BPF_BTF_LOAD selftest
> >>>   bpf: keep BPF_PROG_LOAD permission checks clear of validations
> >>>   bpf: add BPF token support to BPF_PROG_LOAD command
> >>>   bpf: take into account BPF token when fetching helper protos
> >>>   bpf: consistenly use BPF token throughout BPF verifier logic
> >>>   libbpf: add BPF token support to bpf_prog_load() API
> >>>   selftests/bpf: add BPF token-enabled BPF_PROG_LOAD tests
> >>>
> >>>  drivers/media/rc/bpf-lirc.c                   |   2 +-
> >>>  include/linux/bpf.h                           |  66 ++-
> >>>  include/linux/filter.h                        |   2 +-
> >>>  include/uapi/linux/bpf.h                      |  74 +++
> >>>  kernel/bpf/Makefile                           |   2 +-
> >>>  kernel/bpf/arraymap.c                         |   2 +-
> >>>  kernel/bpf/bloom_filter.c                     |   3 -
> >>>  kernel/bpf/bpf_local_storage.c                |   3 -
> >>>  kernel/bpf/bpf_struct_ops.c                   |   3 -
> >>>  kernel/bpf/cgroup.c                           |   6 +-
> >>>  kernel/bpf/core.c                             |   3 +-
> >>>  kernel/bpf/cpumap.c                           |   4 -
> >>>  kernel/bpf/devmap.c                           |   3 -
> >>>  kernel/bpf/hashtab.c                          |   6 -
> >>>  kernel/bpf/helpers.c                          |   6 +-
> >>>  kernel/bpf/inode.c                            |  26 ++
> >>>  kernel/bpf/lpm_trie.c                         |   3 -
> >>>  kernel/bpf/queue_stack_maps.c                 |   4 -
> >>>  kernel/bpf/reuseport_array.c                  |   3 -
> >>>  kernel/bpf/stackmap.c                         |   3 -
> >>>  kernel/bpf/syscall.c                          | 429 ++++++++++++++--=
--
> >>>  kernel/bpf/token.c                            | 141 ++++++
> >>>  kernel/bpf/verifier.c                         |  13 +-
> >>>  kernel/trace/bpf_trace.c                      |   2 +-
> >>>  net/core/filter.c                             |  36 +-
> >>>  net/core/sock_map.c                           |   4 -
> >>>  net/ipv4/bpf_tcp_ca.c                         |   2 +-
> >>>  net/netfilter/nf_bpf_link.c                   |   2 +-
> >>>  net/xdp/xskmap.c                              |   4 -
> >>>  tools/include/uapi/linux/bpf.h                |  74 +++
> >>>  tools/lib/bpf/bpf.c                           |  32 +-
> >>>  tools/lib/bpf/bpf.h                           |  24 +-
> >>>  tools/lib/bpf/libbpf.map                      |   1 +
> >>>  .../selftests/bpf/prog_tests/libbpf_probes.c  |   4 +
> >>>  .../selftests/bpf/prog_tests/libbpf_str.c     |   6 +
> >>>  .../testing/selftests/bpf/prog_tests/token.c  | 282 ++++++++++++
> >>>  .../bpf/prog_tests/unpriv_bpf_disabled.c      |   6 +-
> >>>  37 files changed, 1098 insertions(+), 188 deletions(-)
> >>>  create mode 100644 kernel/bpf/token.c
> >>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
> >>>

