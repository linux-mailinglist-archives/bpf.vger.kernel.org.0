Return-Path: <bpf+bounces-2391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8CE72C4C3
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 14:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A04428117A
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 12:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA92418AF3;
	Mon, 12 Jun 2023 12:45:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A727B17AC5
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 12:45:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17D018C
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686573912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SIWyC+aF76wvMejpvThzs+ZM4CQHXLAvJcGXWvF/kU=;
	b=B2QPjuGqdvYaY0Rhy8SJVjb+cfV1Xz/5+v2NYeN7wS5zVOF5COQkp6VjpxgshYPmV4/O2p
	4TaTF7vqiO5cRquWrCrtpcQJkpyP3kzdI2gQIKtbOdO+vI/nBEvlidQ+HkRpmRhHlanatC
	QcpXZ9ptgqbNHYEGtY0rZilUzEnTiwQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-GKcNufmRMVu2Dzq1rGwwYA-1; Mon, 12 Jun 2023 08:45:10 -0400
X-MC-Unique: GKcNufmRMVu2Dzq1rGwwYA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7ecc15771so19253655e9.1
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 05:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686573909; x=1689165909;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SIWyC+aF76wvMejpvThzs+ZM4CQHXLAvJcGXWvF/kU=;
        b=JEpGs+KljBdns4UbluMXJacy+d2qvv/O+1Ux4ls0DG0wynVDQAaiqamyZAgF+umZ4A
         jt2jCd+3fHGkW41wrzTcYvjnXbGnSWf120TBlema/jwUDOZk12m6Ux/N4fP5J/vmtQOZ
         ODfdd3yxcq/Ju0hJDZMarLSPpR9NUCvkuiKWmN1kwyaTH1YfL+P9DmiV9YJ3+kJF/58K
         3K/GomgRgzsCJQsVlZZwNHAPTbe4KCV1V0kiyWt/nkMn0EW+xKh52KvdezqQx5HdgqTX
         lKpNiAj5X3Cow4PSQfgB3ujrqlrMhuqokQU50MkcgCeu1tmyyrYHKCaUXJvzyZTfn99G
         LPMg==
X-Gm-Message-State: AC+VfDyLyNVrOy5yV0gDqq5AzxuFW+kPWrIj7MePt1B/KsRVoyDNdKgO
	2TCy3qJUEuKDQ8IhtrP6qgtWPOT1woU09/n4cW/vb+xF0Irtw/jJV8PiGZQfw+OVfd97u8jz6ZO
	F202EsO1Av8ZF
X-Received: by 2002:a05:600c:518d:b0:3f8:643:182d with SMTP id fa13-20020a05600c518d00b003f80643182dmr7520350wmb.16.1686573909147;
        Mon, 12 Jun 2023 05:45:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7tN4dRJgxRFdeWVK+dxUk5I6WH19i/EuFTxgVW5PcPju33s4dWfWgtJe2iaslHtSz1NuSs0Q==
X-Received: by 2002:a05:600c:518d:b0:3f8:643:182d with SMTP id fa13-20020a05600c518d00b003f80643182dmr7520319wmb.16.1686573908756;
        Mon, 12 Jun 2023 05:45:08 -0700 (PDT)
Received: from smtpclient.apple (dtucker87.plus.com. [80.229.11.228])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c058b00b003f8146ac7f7sm6080467wmd.28.2023.06.12.05.45.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jun 2023 05:45:08 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
From: Dave Tucker <datucker@redhat.com>
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
Date: Mon, 12 Jun 2023 13:44:57 +0100
Cc: bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 keescook@chromium.org,
 brauner@kernel.org,
 lennart@poettering.net,
 cyphar@cyphar.com,
 luto@kernel.org,
 kernel-team@meta.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BEB36A1-9FE4-4552-B2FF-DE6DF74F3756@redhat.com>
References: <20230607235352.1723243-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On 8 Jun 2023, at 00:53, Andrii Nakryiko <andrii@kernel.org> wrote:
>=20
> This patch set introduces new BPF object, BPF token, which allows to =
delegate
> a subset of BPF functionality from privileged system-wide daemon =
(e.g.,
> systemd or any other container manager) to a *trusted* unprivileged
> application. Trust is the key here. This functionality is not about =
allowing
> unconditional unprivileged BPF usage. Establishing trust, though, is
> completely up to the discretion of respective privileged application =
that
> would create a BPF token.


Hello! Author of a bpfd[1] here.

> The main motivation for BPF token is a desire to enable containerized
> BPF applications to be used together with user namespaces. This is =
currently
> impossible, as CAP_BPF, required for BPF subsystem usage, cannot be =
namespaced
> or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to =
BPF
> helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can =
safely read
> arbitrary memory, and it's impossible to ensure that they only read =
memory of
> processes belonging to any given namespace. This means that it's =
impossible to
> have namespace-aware CAP_BPF capability, and as such another mechanism =
to
> allow safe usage of BPF functionality is necessary. BPF token and =
delegation
> of it to a trusted unprivileged applications is such mechanism. Kernel =
makes
> no assumption about what "trusted" constitutes in any particular case, =
and
> it's up to specific privileged applications and their surrounding
> infrastructure to decide that. What kernel provides is a set of APIs =
to create
> and tune BPF token, and pass it around to privileged BPF commands that =
are
> creating new BPF objects like BPF programs, BPF maps, etc.

You could do that=E2=80=A6 but the problem is created due to the pattern =
of having a
single binary that is responsible for:

- Loading and attaching the BPF program in question
- Interacting with maps

Let=E2=80=99s set aside some of the other fun concerns of eBPF in =
containers:
 - Requiring mounting of vmlinux, bpffs, traces etc=E2=80=A6
 - How fs permissions on host translate into permissions in containers

While your proposal lets you grant a subset of CAP_BPF to some other =
process,
which I imagine could also be done with SELinux, it doesn=E2=80=99t stop =
you from needing
other required permissions for attaching tracing programs in such an
environment.=20

For example, say container A wants to attach a uprobe to a process in =
container B.
Container A needs to be able to nsenter into container B=E2=80=99s pidns =
in order for attachment
to succeed=E2=80=A6 but then what I can do with CAP_BPF is the least of =
my concerns since
I=E2=80=99d wager I=E2=80=99d need to mount `/proc` from the host in =
container A + have elevated privileges
much scarier than CAP_BPF in the first place.

If you move =E2=80=9CLoading and attaching=E2=80=9D away to somewhere =
else (i.e a daemon like bpfd)
then with recent kernels your container workload should be fine to run =
entirely unprivileged,
or worst case with only CAP_BPF since all you need to do is read/write =
maps.

Policy control - which process can request to load programs that monitor =
which other
processes - would happen within this system daemon and you wouldn=E2=80=99=
t need tokens.

Since it=E2=80=99s easy enough to do this in userspace, I=E2=80=99d be =
strongly against adding more
complexity into BPF to support this usecase.

> Previous attempt at addressing this very same problem ([0]) attempted =
to
> utilize authoritative LSM approach, but was conclusively rejected by =
upstream
> LSM maintainers. BPF token concept is not changing anything about LSM
> approach, but can be combined with LSM hooks for very fine-grained =
security
> policy. Some ideas about making BPF token more convenient to use with =
LSM (in
> particular custom BPF LSM programs) was briefly described in recent =
LSF/MM/BPF
> 2023 presentation ([1]). E.g., an ability to specify user-provided =
data
> (context), which in combination with BPF LSM would allow implementing =
a very
> dynamic and fine-granular custom security policies on top of BPF =
token. In the
> interest of minimizing API surface area discussions this is going to =
be
> added in follow up patches, as it's not essential to the fundamental =
concept
> of delegatable BPF token.
>=20
> It should be noted that BPF token is conceptually quite similar to the =
idea of
> /dev/bpf device file, proposed by Song a while ago ([2]). The biggest
> difference is the idea of using virtual anon_inode file to hold BPF =
token and
> allowing multiple independent instances of them, each with its own set =
of
> restrictions. BPF pinning solves the problem of exposing such BPF =
token
> through file system (BPF FS, in this case) for cases where =
transferring FDs
> over Unix domain sockets is not convenient. And also, crucially, BPF =
token
> approach is not using any special stateful task-scoped flags. Instead, =
bpf()
> syscall accepts token_fd parameters explicitly for each relevant BPF =
command.
> This addresses main concerns brought up during the /dev/bpf =
discussion, and
> fits better with overall BPF subsystem design.
>=20
> This patch set adds a basic minimum of functionality to make BPF token =
useful
> and to discuss API and functionality. Currently only low-level libbpf =
APIs
> support passing BPF token around, allowing to test kernel =
functionality, but
> for the most part is not sufficient for real-world applications, which
> typically use high-level libbpf APIs based on `struct bpf_object` =
type. This
> was done with the intent to limit the size of patch set and =
concentrate on
> mostly kernel-side changes. All the necessary plumbing for libbpf will =
be sent
> as a separate follow up patch set kernel support makes it upstream.
>=20
> Another part that should happen once kernel-side BPF token is =
established, is
> a set of conventions between applications (e.g., systemd), tools =
(e.g.,
> bpftool), and libraries (e.g., libbpf) about sharing BPF tokens =
through BPF FS
> at well-defined locations to allow applications take advantage of this =
in
> automatic fashion without explicit code changes on BPF application's =
side.
> But I'd like to postpone this discussion to after BPF token concept =
lands.
>=20
>  [0] =
https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel.org/
>  [1] =
http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_BPF_LSFMM=
2023.pdf
>  [2] =
https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubraving@fb.com=
/
>=20

- Dave

[1]: https://github.com/bpfd-dev/bpfd=


