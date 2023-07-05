Return-Path: <bpf+bounces-4052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC65674847D
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 14:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861051C20B46
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 12:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56997487;
	Wed,  5 Jul 2023 12:57:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AE6138F
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 12:57:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18EA10F5
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688561848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbwWt2y2iUb68X78AVNYTAhDubm+qk1U586TaH/96Qk=;
	b=Kv1oSaXth283f4AqMA2YMwZ9ka4Kd+Km+pcN5dTxV4XhZgbkL+38QRpC2xaXxH3jmR5HO+
	D5SJfWPTDz1Q1omHcNwqo7kOFNjd9p5hAH1VCY1dzspk5YRofI0oQVtqQFwHVHJOI0lBxk
	blsKpqTQhUwyzU//dtLw4EmPcczBleM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-VNoQfzSjOl-SHS3eBPdONQ-1; Wed, 05 Jul 2023 08:57:25 -0400
X-MC-Unique: VNoQfzSjOl-SHS3eBPdONQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F86880123E;
	Wed,  5 Jul 2023 12:57:25 +0000 (UTC)
Received: from elisabeth (unknown [10.39.208.44])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BDF45C478DE;
	Wed,  5 Jul 2023 12:57:22 +0000 (UTC)
Date: Wed, 5 Jul 2023 14:57:21 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
 brauner@kernel.org
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, keescook@chromium.org,
 lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org,
 kernel-team@meta.com, sargun@sargun.me, Alice Frosi <afrosi@redhat.com>
Subject: Re: [PATCH RESEND v3 bpf-next 00/14] BPF token
Message-ID: <20230705145721.67d471a2@elisabeth>
In-Reply-To: <87v8ezb6x5.fsf@toke.dk>
References: <20230629051832.897119-1-andrii@kernel.org>
	<87sfa9eu70.fsf@toke.dk>
	<CAEf4Bzb0bVD_fuU4Oz1oXKdwLpG1t=7d5MV3OhniHUUiysWE8g@mail.gmail.com>
	<87v8ezb6x5.fsf@toke.dk>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 05 Jul 2023 01:20:22 +0200
Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:

> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>=20
> > On Thu, Jun 29, 2023 at 4:15=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote: =20
> >>
> >> Andrii Nakryiko <andrii@kernel.org> writes:
> >> =20
> >> > This patch set introduces new BPF object, BPF token, which allows to=
 delegate
> >> > a subset of BPF functionality from privileged system-wide daemon (e.=
g.,
> >> > systemd or any other container manager) to a *trusted* unprivileged
> >> > application. Trust is the key here. This functionality is not about =
allowing
> >> > unconditional unprivileged BPF usage. Establishing trust, though, is
> >> > completely up to the discretion of respective privileged application=
 that
> >> > would create a BPF token, as different production setups can and do =
achieve it
> >> > through a combination of different means (signing, LSM, code reviews=
, etc),
> >> > and it's undesirable and infeasible for kernel to enforce any partic=
ular way
> >> > of validating trustworthiness of particular process.
> >> >
> >> > The main motivation for BPF token is a desire to enable containerized
> >> > BPF applications to be used together with user namespaces. This is c=
urrently
> >> > impossible, as CAP_BPF, required for BPF subsystem usage, cannot be =
namespaced
> >> > or sandboxed, as a general rule. E.g., tracing BPF programs, thanks =
to BPF
> >> > helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can s=
afely read
> >> > arbitrary memory, and it's impossible to ensure that they only read =
memory of
> >> > processes belonging to any given namespace. This means that it's imp=
ossible to
> >> > have namespace-aware CAP_BPF capability, and as such another mechani=
sm to
> >> > allow safe usage of BPF functionality is necessary. BPF token and de=
legation
> >> > of it to a trusted unprivileged applications is such mechanism. Kern=
el makes
> >> > no assumption about what "trusted" constitutes in any particular cas=
e, and
> >> > it's up to specific privileged applications and their surrounding
> >> > infrastructure to decide that. What kernel provides is a set of APIs=
 to create
> >> > and tune BPF token, and pass it around to privileged BPF commands th=
at are
> >> > creating new BPF objects like BPF programs, BPF maps, etc. =20
> >>
> >> So a colleague pointed out today that the Seccomp Notify functionality
> >> would be a way to achieve your stated goal of allowing unprivileged
> >> containers to (selectively) perform bpf() syscall operations. Christian
> >> Brauner has a pretty nice writeup of the functionality here:
> >> https://people.kernel.org/brauner/the-seccomp-notifier-new-frontiers-i=
n-unprivileged-container-development
> >>
> >> In fact he even mentions allowing unprivileged access to bpf() as a
> >> possible use case (in the second-to-last paragraph).
> >>
> >> AFAICT this would enable your use case without adding any new kernel
> >> functionality or changing the BPF-using applications, while allowing t=
he
> >> privileged userspace daemon to make case-by-case decisions on each
> >> operation instead of granting blanket capabilities (which is my main
> >> objection to the token proposal, as we discussed on the last iteration
> >> of the series). =20
> >
> > It's not "blanket" capabilities. You control types or maps and
> > programs that could be created. And again, CAP_SYS_ADMIN guarded.
> > Please, don't give CAP_SYS_ADMIN/root permissions to applications you
> > can't be sure won't do something stupid and blame kernel API for it. =20
>=20
> Right, I didn't mean "blanket" in the sense of "permission to do
> anything on the system"; I do get that you can restrict which subset of
> functionality you grant. However, *within* that subset, it's a blanket
> permission grant. I.e., you can't issue a token that grants a *specific*
> application permission to load a *specific* BPF program - you can only
> grant a general "load any program" permission that can be used by anyone
> who possesses the token.
>=20
> I guess we could in principle extend the token mechanism to allow this,
> but the kernel doesn't seem like the right place to implement such a
> fine-grained policy engine...
>=20
> > After all, the root process can setuid() any file and make it run with
> > elevated permissions, right? Doesn't get more "blanket" than that. =20
>=20
> Which is exactly why setuid binaries are not generally how we implement
> security delegation these days. So I don't think designing a new
> mechanism this way is a good idea.
>=20
> >> So I'm curious whether you considered this as an alternative to
> >> BPF_TOKEN? And if so, what your reason was for rejecting it?
> >> =20
> >
> > Yes, I'm aware, Christian has a follow up short blog post specifically
> > for using this for proxying BPF from privileged process ([0]).
> >
> > So, in short, I think it's not a good generic solution. It's very
> > fragile and high-maintenance. It's still proxying BPF UAPI (except
> > application does preserve illusion of using BPF syscall, yes, that
> > part is good) with all the implications: needing to replicate all of
> > UAPI (fetching all those FDs from another process, following all the
> > pointers from another process' memory, etc), and also writing back all
> > the correct things (into another process' memory): log content,
> > log_true_size (out param), any other output parameters. =20
>=20
> Right, OK, that bit does sound pretty tedious (although I'll note that
> there are people who are trying to make all this generally more
> palatable[0]).

[0] https://seitan.rocks/ :)

Some clickbaiting for Christian: the presentation we gave a couple of
weeks ago, also linked from the project website, actually credits you
(slide 29/30, of course).

The code is still very much draft quality (we mostly focused on
demos/feasibility so far, cleaning it up now), and we didn't prove (at
least not yet) that handling complicated stuff such as bpf(2) is
actually convenient, but that's at least in scope as a stretch goal.
I'm not claiming it's doable, but we'd give it a try.

What we have at the moment is a meagre set of eight syscall models,
some blatantly incomplete.

A couple of comments to specific points Christian mentioned:

On Tue, 4 Jul 2023 11:38:38 +0200
Christian Brauner <brauner@kernel.org> wrote:

> It's a pipe dream that you can transparently proxy system calls for
> another process via seccomp for sufficiently complex system calls. We
> did it for specific use-cases where we could sufficiently guarantee that
> they could be safe.

Right, so we're trying to pick it up from there. It's way too early to
claim success, but I thought it would make sense to chime in anyway.

> But to make this work it would involve way more invasive changes:
>=20
> * nesting/stacking of seccomp notifiers

The need for stacked seccomp filters is obvious to me and that works more
or less naturally. But why would you actually need to stack, or especially
nest *notifiers* themselves?

> * clean handling of pointer arguments in-kernel such that you can safely
>   continue system calls being sure that they haven't been modified. This
>   is currently only possible in scenarios where safety is guaranteed by
>   the kernel refusing nonsensical or unsafe arguments

We're considering a couple of options. One is to never use
SECCOMP_USER_NOTIF_FLAG_CONTINUE for system calls accepting pointers, or
only allowing that as an explicit "unsafe" option. For a "safe"
implementation, the supervisor (seitan) would in any case replay the
system call, matching the context (namespaces, credentials) of the target
process.

If PID or TID (per se, not in terms of associated context/capabilities) of
the caller matter for a specific system call, though, we simply can't
support that. But that shouldn't actually be relevant for bpf(2).

Strictly speaking, I think it's actually possible to "fix" this in the
kernel by means of checking or copying memory that's addressable by a
thread, but that might prove too invasive or end up in insurmountable
layering violations. This mechanism would involve "control" paths
rather than data paths, though, so the performance impact is not really
worrying.

Another option, which we outlined at this very convenient link:
  https://github.com/alicefr/community/blob/seitan/design-proposals/seitan/=
security-aspects-seitan.md#if-i-use-the-json-model-as-a-security-filter-can=
-another-thread-in-the-same-process-context-write-to-the-memory-area-pointe=
d-to-by-system-call-arguments-while-the-calling-thread-is-blocked-and-defy-=
the-purpose-of-the-filter

would be to make the supervisor perform a deep copy (system calls are
anyway modeled in the seitan-cooker component) and then use good old
ptrace(2) as needed.

> * correct privilege handling
>   The seccomp notifier emulates system calls in userspace and thus has
>   to mimick the privilege context of the task it is emulating the system
>   call for in such a way that (i) it allows it to succeed by avoiding the
>   privilege limitations of why the given system call was supposed to be
>   proxied in the first place, (ii) it doesn't allow to circumvent other,
>   generic restrictions that would otherwise cause the system call to
>   fail. It's like saying e.g., "execute with most of the proxied task's
>   creds but let it have a few more privileges". That's frail as Linux
>   creds aren't really composable. That's why we have override_creds()
>   not "add_creds()" and "subtract_creds()" which would probably be
>   nicer.

Right, at the moment we just run that as root, but we plan to take care
of (ii) (albeit not solving it entirely, I guess), by at least applying a
seccomp filter to the supervisor itself. As to the set of (composed?)
capabilities, we don't have an answer yet.

> Or it would have to be a generic first class kernel proxy which begs the
> question why not change the subsystems itself to do this cleanly.

Well, the fine-grained "policy" implementation we're trying to achieve
looks to me like something that's a bit too complicated for the kernel,
and really more appropriate for userspace.

--=20
Stefano


