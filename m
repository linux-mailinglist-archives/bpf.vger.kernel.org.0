Return-Path: <bpf+bounces-3834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD3C7445FD
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 04:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348211C20C34
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 02:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83C517F2;
	Sat,  1 Jul 2023 02:06:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CB817CB
	for <bpf@vger.kernel.org>; Sat,  1 Jul 2023 02:06:24 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727654212;
	Fri, 30 Jun 2023 19:06:22 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-635dc2f6ef9so17226546d6.3;
        Fri, 30 Jun 2023 19:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688177181; x=1690769181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3smUnGEw7mT56KK3C7P8wgk7KPZaZlCNBDwAaXBuwc=;
        b=d6kl8WUsrmoo4SnLz4pH8zGJhVmqwlzJ/48Z0MShfshO9IDRRrTK0IyQ0ZqbfltjrE
         BGrPyj5lzlHvgJ0eICGR28y7DIGnMKBFjlY3ATxR/SbnR1FcLDs6c5cFT9LVGlsTH/ra
         /wAyhY4dncgMpfzhv1Pcc/qP1UOyEeWwlBZsOrCvkd7a+EUMIghzHh/bjhzFKZZdfe8R
         s87UEN9nV9SIVo1F3EMRLbTblyFIJg086niEosG0ClWEz7oHn4toFL3s1y22wIHplfxF
         9lUZmjhlmKaHZn8INfyvc1fT+drpU3/gJDG/DLg3fZYoqiWHIF5p6+IBLksw1gVtuvEM
         XQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688177181; x=1690769181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3smUnGEw7mT56KK3C7P8wgk7KPZaZlCNBDwAaXBuwc=;
        b=GGZEIGyxKzIpvrVs+nMy7zZKbQxfqmF92WnA+2GKnV4gKFhLrpkku5ewLVTkxhZjFa
         7OmkzuSKzwwn5CccYOmxsH1XnKI2ScKziyIVnwuBZeRzwReJM6rPHkiNp5Jvt0aoym8v
         e71OgUaOG44eZP4CIksGfnYftCcq+NXWYZkcgIxaqZwnbbWOofSoR3O4SLMDiBom3DPn
         +UIjulm+hUt3abu1ej3CiEfP+Drg6Lhwkpaz5HF3kDJapuqyTkaPhkpfugwIGNmJlew5
         f7o2UbO3QpEs94atc0yU/3MDilgMM5kI0QrxSyIErXres1qt63Rc7gcox1jZggIumk4f
         1txw==
X-Gm-Message-State: ABy/qLbYArtMN3ZSuNw49DMnBX47bHPFBGFTnLTo70k1q5ZA+HMAtKVy
	Sbt8PByCSBh+AW0B4aipI11E3LsqN+wLz6/j9Kc=
X-Google-Smtp-Source: APBJJlEdnQWegqx0e/d3qoYxhCVwdiYFe19JkL6c7pSTObHst6GK9SlMKCOYPFVE1i/EwWPIXSnn3OUicpWaHCFNdI8=
X-Received: by 2002:ad4:518f:0:b0:62d:df48:baf0 with SMTP id
 b15-20020ad4518f000000b0062ddf48baf0mr3968797qvp.61.1688177181315; Fri, 30
 Jun 2023 19:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629051832.897119-1-andrii@kernel.org>
In-Reply-To: <20230629051832.897119-1-andrii@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 1 Jul 2023 10:05:44 +0800
Message-ID: <CALOAHbBupxQ3RH+SbzUv=W2dRDS-mG1PuRpARrMnMv=o6Ro7Sw@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 bpf-next 00/14] BPF token
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	keescook@chromium.org, brauner@kernel.org, lennart@poettering.net, 
	cyphar@cyphar.com, luto@kernel.org, kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 29, 2023 at 1:18=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> This patch set introduces new BPF object, BPF token, which allows to dele=
gate
> a subset of BPF functionality from privileged system-wide daemon (e.g.,
> systemd or any other container manager) to a *trusted* unprivileged
> application. Trust is the key here. This functionality is not about allow=
ing
> unconditional unprivileged BPF usage. Establishing trust, though, is
> completely up to the discretion of respective privileged application that
> would create a BPF token, as different production setups can and do achie=
ve it
> through a combination of different means (signing, LSM, code reviews, etc=
),
> and it's undesirable and infeasible for kernel to enforce any particular =
way
> of validating trustworthiness of particular process.
>
> The main motivation for BPF token is a desire to enable containerized
> BPF applications to be used together with user namespaces. This is curren=
tly
> impossible, as CAP_BPF, required for BPF subsystem usage, cannot be names=
paced
> or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to BP=
F
> helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safely=
 read
> arbitrary memory, and it's impossible to ensure that they only read memor=
y of
> processes belonging to any given namespace. This means that it's impossib=
le to
> have namespace-aware CAP_BPF capability, and as such another mechanism to
> allow safe usage of BPF functionality is necessary. BPF token and delegat=
ion
> of it to a trusted unprivileged applications is such mechanism. Kernel ma=
kes
> no assumption about what "trusted" constitutes in any particular case, an=
d
> it's up to specific privileged applications and their surrounding
> infrastructure to decide that. What kernel provides is a set of APIs to c=
reate
> and tune BPF token, and pass it around to privileged BPF commands that ar=
e
> creating new BPF objects like BPF programs, BPF maps, etc.
>
> Previous attempt at addressing this very same problem ([0]) attempted to
> utilize authoritative LSM approach, but was conclusively rejected by upst=
ream
> LSM maintainers. BPF token concept is not changing anything about LSM
> approach, but can be combined with LSM hooks for very fine-grained securi=
ty
> policy. Some ideas about making BPF token more convenient to use with LSM=
 (in
> particular custom BPF LSM programs) was briefly described in recent LSF/M=
M/BPF
> 2023 presentation ([1]). E.g., an ability to specify user-provided data
> (context), which in combination with BPF LSM would allow implementing a v=
ery
> dynamic and fine-granular custom security policies on top of BPF token. I=
n the
> interest of minimizing API surface area discussions this is going to be
> added in follow up patches, as it's not essential to the fundamental conc=
ept
> of delegatable BPF token.
>
> It should be noted that BPF token is conceptually quite similar to the id=
ea of
> /dev/bpf device file, proposed by Song a while ago ([2]). The biggest
> difference is the idea of using virtual anon_inode file to hold BPF token=
 and
> allowing multiple independent instances of them, each with its own set of
> restrictions. BPF pinning solves the problem of exposing such BPF token
> through file system (BPF FS, in this case) for cases where transferring F=
Ds
> over Unix domain sockets is not convenient. And also, crucially, BPF toke=
n
> approach is not using any special stateful task-scoped flags. Instead, bp=
f()
> syscall accepts token_fd parameters explicitly for each relevant BPF comm=
and.
> This addresses main concerns brought up during the /dev/bpf discussion, a=
nd
> fits better with overall BPF subsystem design.
>
> This patch set adds a basic minimum of functionality to make BPF token us=
eful
> and to discuss API and functionality. Currently only low-level libbpf API=
s
> support passing BPF token around, allowing to test kernel functionality, =
but
> for the most part is not sufficient for real-world applications, which
> typically use high-level libbpf APIs based on `struct bpf_object` type. T=
his
> was done with the intent to limit the size of patch set and concentrate o=
n
> mostly kernel-side changes. All the necessary plumbing for libbpf will be=
 sent
> as a separate follow up patch set kernel support makes it upstream.
>
> Another part that should happen once kernel-side BPF token is established=
, is
> a set of conventions between applications (e.g., systemd), tools (e.g.,
> bpftool), and libraries (e.g., libbpf) about sharing BPF tokens through B=
PF FS
> at well-defined locations to allow applications take advantage of this in
> automatic fashion without explicit code changes on BPF application's side=
.
> But I'd like to postpone this discussion to after BPF token concept lands=
.
>
> Once important distinctions from v2 that should be noted is a chance in t=
he
> semantics of a newly added BPF_TOKEN_CREATE command. Previously,
> BPF_TOKEN_CREATE would create BPF token kernel object and return its FD t=
o
> user-space, allowing to (optionally) pin it in BPF FS using BPF_OBJ_PIN
> command. This v3 version changes this slightly: BPF_TOKEN_CREATE combines=
 BPF
> token object creation *and* pinning in BPF FS. Such change ensures that B=
PF
> token is always associated with a specific instance of BPF FS and cannot
> "escape" it by application re-pinning it somewhere else using another
> BPF_OBJ_PIN call. Now, BPF token can only be pinned once during its creat=
ion,
> better containing it inside intended container (under assumption BPF FS i=
s set
> up in such a way as to not be shared with other containers on the system)=
.
>
>   [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel.o=
rg/
>   [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_BP=
F_LSFMM2023.pdf
>   [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubraving=
@fb.com/
>
> v3->v3-resend:
>   - I started integrating token_fd into bpf_object_open_opts and higher-l=
evel
>     libbpf bpf_object APIs, but it started going a bit deeper into bpf_ob=
ject
>     implementation details and how libbpf performs feature detection and
>     caching, so I decided to keep it separate from this patch set and not
>     distract from the mostly kernel-side changes;
> v2->v3:
>   - make BPF_TOKEN_CREATE pin created BPF token in BPF FS, and disallow
>     BPF_OBJ_PIN for BPF token;
> v1->v2:
>   - fix build failures on Kconfig with CONFIG_BPF_SYSCALL unset;
>   - drop BPF_F_TOKEN_UNKNOWN_* flags and simplify UAPI (Stanislav).
>
> Andrii Nakryiko (14):
>   bpf: introduce BPF token object
>   libbpf: add bpf_token_create() API
>   selftests/bpf: add BPF_TOKEN_CREATE test
>   bpf: add BPF token support to BPF_MAP_CREATE command
>   libbpf: add BPF token support to bpf_map_create() API
>   selftests/bpf: add BPF token-enabled test for BPF_MAP_CREATE command
>   bpf: add BPF token support to BPF_BTF_LOAD command
>   libbpf: add BPF token support to bpf_btf_load() API
>   selftests/bpf: add BPF token-enabled BPF_BTF_LOAD selftest
>   bpf: add BPF token support to BPF_PROG_LOAD command
>   bpf: take into account BPF token when fetching helper protos
>   bpf: consistenly use BPF token throughout BPF verifier logic
>   libbpf: add BPF token support to bpf_prog_load() API
>   selftests/bpf: add BPF token-enabled BPF_PROG_LOAD tests
>
>  drivers/media/rc/bpf-lirc.c                   |   2 +-
>  include/linux/bpf.h                           |  79 ++++-
>  include/linux/filter.h                        |   2 +-
>  include/uapi/linux/bpf.h                      |  53 ++++
>  kernel/bpf/Makefile                           |   2 +-
>  kernel/bpf/arraymap.c                         |   2 +-
>  kernel/bpf/cgroup.c                           |   6 +-
>  kernel/bpf/core.c                             |   3 +-
>  kernel/bpf/helpers.c                          |   6 +-
>  kernel/bpf/inode.c                            |  46 ++-
>  kernel/bpf/syscall.c                          | 183 +++++++++---
>  kernel/bpf/token.c                            | 201 +++++++++++++
>  kernel/bpf/verifier.c                         |  13 +-
>  kernel/trace/bpf_trace.c                      |   2 +-
>  net/core/filter.c                             |  36 +--
>  net/ipv4/bpf_tcp_ca.c                         |   2 +-
>  net/netfilter/nf_bpf_link.c                   |   2 +-
>  tools/include/uapi/linux/bpf.h                |  53 ++++
>  tools/lib/bpf/bpf.c                           |  35 ++-
>  tools/lib/bpf/bpf.h                           |  45 ++-
>  tools/lib/bpf/libbpf.map                      |   1 +
>  .../selftests/bpf/prog_tests/libbpf_probes.c  |   4 +
>  .../selftests/bpf/prog_tests/libbpf_str.c     |   6 +
>  .../testing/selftests/bpf/prog_tests/token.c  | 277 ++++++++++++++++++
>  24 files changed, 957 insertions(+), 104 deletions(-)
>  create mode 100644 kernel/bpf/token.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
>
> --
> 2.34.1
>
>


Hi Andrii,

Thanks for your proposal.
That seems to be a useful functionality, and yet I have some questions.

1. Why can't we add security_bpf_probe_read_{kernel,user}?
    If possible, we can use these LSM hooks to refuse the process to
read other tasks' information. E.g. if the other process is not within
the same cgroup or the same namespace, we just refuse the reading. I
think it is not hard to identify if the other process is within the
same cgroup or the same namespace.

2. Why can't we extend bpf_cookie?
   We're now using bpf_cookie to identify each user or each
application, and only the permitted cookies can create new probe
links.  However we find the bpf_cookie is only supported by tracing,
perf_event and kprobe_multi, so we're planning to extend it to other
possible link types, then we can use LSM hooks to control all bpf
links.  I think that the upstream kernel should also support
bpf_cookie for all bpf links. If possible, we will post it to the
upstream in the future.
   After I have read your BPF token proposal, I just have some other
ideas. Why can't we just extend bpf_cookie to all other BPF objects?
For example, all progs and maps should also have the bpf_cookie.


--=20
Regards
Yafang

