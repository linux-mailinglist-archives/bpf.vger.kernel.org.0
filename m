Return-Path: <bpf+bounces-2268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0859272A547
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 23:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5438B1C211A2
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 21:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BF622E5D;
	Fri,  9 Jun 2023 21:21:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72591408E0
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 21:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D141C433D2;
	Fri,  9 Jun 2023 21:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686345667;
	bh=DyFNC7LIETj7edLx74ew7k5/9WVYaCVZtVt1+qeLBa4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aRLD0WGgVxhsJu0mfqkwObcAl+sxGkW0y4HxIaK/uUe9J0nw87d+tauy2eyKvEbiq
	 T8S8/cYEYx0K00YSe10lr11VLPwhM9o8K3jYM/zfdYpAw1K1c4QfJd5VUInx6rmaX0
	 paHatGjrKJKnOlpr0otw+KIH9J+sE6ydnk1eiach8nPY/PeeiliRBzSLl9hQdtJqok
	 QvvLvE/z20YrgVW4gtmWNe8I9y+VAYdKIRr3cmHjXVRACjG/3/jGqvs4nkuZTAUEzK
	 Wj8zQ7jTg9ZuLgTNV7jmBGbIejIXwgnozHzL7PmbNANEZnEkyHt84FqWPTtICA5GPR
	 JYllITpHOweQw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 10116BBE3A5; Fri,  9 Jun 2023 23:21:05 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, keescook@chromium.org,
 brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com,
 luto@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
In-Reply-To: <CAEf4BzYin==+WF27QBXoj23tHcr5BeezbPj2u9RW6qz4sLJsKw@mail.gmail.com>
References: <20230607235352.1723243-1-andrii@kernel.org>
 <871qik28bs.fsf@toke.dk>
 <CAEf4BzYin==+WF27QBXoj23tHcr5BeezbPj2u9RW6qz4sLJsKw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 09 Jun 2023 23:21:05 +0200
Message-ID: <87h6rgz60u.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Jun 9, 2023 at 4:17=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@kernel.org> wrote:
>>
>> Andrii Nakryiko <andrii@kernel.org> writes:
>>
>> > This patch set introduces new BPF object, BPF token, which allows to d=
elegate
>> > a subset of BPF functionality from privileged system-wide daemon (e.g.,
>> > systemd or any other container manager) to a *trusted* unprivileged
>> > application. Trust is the key here. This functionality is not about al=
lowing
>> > unconditional unprivileged BPF usage. Establishing trust, though, is
>> > completely up to the discretion of respective privileged application t=
hat
>> > would create a BPF token.
>>
>> I am not convinced that this token-based approach is a good way to solve
>> this: having the delegation mechanism be one where you can basically
>> only grant a perpetual delegation with no way to retract it, no way to
>> check what exactly it's being used for, and that is transitive (can be
>> passed on to others with no restrictions) seems like a recipe for
>> disaster. I believe this was basically the point Casey was making as
>> well in response to v1.
>
> Most of this can be added, if we really need to. Ability to revoke BPF
> token is easy to implement (though of course it will apply only for
> subsequent operations). We can allocate ID for BPF token just like we
> do for BPF prog/map/link and let tools iterate and fetch information
> about it. As for controlling who's passing what and where, I don't
> think the situation is different for any other FD-based mechanism. You
> might as well create a BPF map/prog/link, pass it through SCM_RIGHTS
> or BPF FS, and that application can keep doing the same to other
> processes.

No, but every other fd-based mechanism is limited in scope. E.g., if you
pass a map fd that's one specific map that can be passed around, with a
token it's all operations (of a specific type) which is way broader.

> Ultimately, currently we have root permissions for applications that
> need BPF. That's already very dangerous. But just because something
> might be misused or abused doesn't prevent us from making a good
> practical use of it, right?

That's not a given. It's always a trade-off, and if the mechanism is
likely to open up the system to additional risk that's not a good
trade-off even if it helps in some case. I basically worry that this is
the case here.

> Also, there is LSM on top of all of this to override and control how
> the BPF subsystem is used, regardless of BPF token. It can override
> any of the privileges mechanism, capabilities, BPF token, whatnot.

If this mechanism needs an LSM to be used safely, that's not incredibly
confidence-inspiring. Security mechanisms should fail safe, which this
one does not.

I'm also worried that an LSM policy is the only way to disable the
ability to create a token; with this in the kernel, I suddenly have to
trust not only that all applications with BPF privileges will not load
malicious code, but also that they won't (accidentally or maliciously)
conveys extra privileges on someone else. Seems a bit broad to have this
ability (to issue tokens) available to everyone with access to the bpf()
syscall, when (IIUC) it's only a single daemon in the system that would
legitimately do this in the deployment you're envisioning.

>> If the goal is to enable a privileged application (such as a container
>> manager) to grant another unprivileged application the permission to
>> perform certain bpf() operations, why not just proxy the operations
>> themselves over some RPC mechanism? That way the granting application
>
> It's explicitly what we *do not* want to do, as it is a major problem
> and logistical complication. Every single application will have to be
> rewritten to use such a special daemon/service and its API, which is
> completely different from bpf() syscall API. It invalidates the use of
> all the libbpf (and other bpf libraries') APIs, BPF skeleton is
> incompatible with this. It's a nightmare. I've got feedback from
> people in another company that do have BPF service with just a tiny
> subset of BPF functionality delegated to such service, and it's a pain
> and definitely not a preferred way to do things.

But weren't you proposing that libbpf should be able to transparently
look for tokens and load them without any application changes? Why can't
libbpf be taught to use an RPC socket in a similar fashion? It basically
boils down to something like:

static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
			  unsigned int size)
{
	if (!stat("/run/bpf.sock")) {
		sock =3D open_socket("/run/bpf.sock");
                write_to(sock, cmd, attr, size);
                return read_response(sock);
        } else {
		return syscall(__NR_bpf, cmd, attr, size);
        }
}

> Just think about having to mirror a big chunk of bpf() syscall as an
> RPC. So no, BPF proxy is definitely not a good solution.

The daemon at the other side of the socket in the example above doesn't
*have* to be taught all the semantics of the syscall, it can just look
at the command name and make a decision based on that and the identity
of the socket peer, then just pass the whole thing to the kernel if the
permission check passes.

>> can perform authentication checks on every operation and ensure its
>> origins are sound at the time it is being made. Instead of just writing
>> a blank check (in the form of a token) and hoping the receiver of it is
>> not compromised...
>
> All this could and should be done through LSM in much more decoupled
> and transparent (to application) way. BPF token doesn't prevent this.
> It actually helps with this, because organizations can actually
> dictate that operations that do not provide BPF token are
> automatically rejected, and those that do provide BPF token can be
> further checked and granted or rejected based on specific BPF token
> instance.

See above re: needing an LSM policy to make this safe...

-Toke

