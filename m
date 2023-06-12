Return-Path: <bpf+bounces-2381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C67272C014
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 12:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF681281164
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 10:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F38F11CAD;
	Mon, 12 Jun 2023 10:49:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC577D518
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 10:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D52C433D2;
	Mon, 12 Jun 2023 10:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686566982;
	bh=HJtw935erjIZTx/raLwvInUFUA3nIvHBgNeAp04GhFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=b3SN02j+1k6r/ecNTnFk9Cv/Nev15WDONY1mL17nOvyQE5C0AHmUkrHvt9HmKoMak
	 9gtLkjFj6Bd86nyLjOdkvaVSjSPrAuSCbe7uZvtX9Yv9SAB+qA1A+kshOiAzV9HfRw
	 DJOCG+6tlJFSaAB9rjiXNu17Myx963tG+Vgsz79EEZhCIdm+5L5B52nsDRSLbJSyY+
	 PXQqnR3xm64kGH2riWdl+ELwoAOHNAVa+Vr5qLAQHFl+ytgaugwJKS6jglo4BDdB70
	 NUWn7sDq311SvCAtBCziQdL/uiXeSYWaEvDiWFYwz8QLO7PsrVNVbYXqTk+Rf8ckkf
	 k6fzlEcoxCuNw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CE9A6BBE7DC; Mon, 12 Jun 2023 12:49:39 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, keescook@chromium.org,
 brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com,
 luto@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
In-Reply-To: <CAEf4Bzasz_1qRXh4b7B8V1mOfyD++mVNYnhm6v__-cc7cU_33w@mail.gmail.com>
References: <20230607235352.1723243-1-andrii@kernel.org>
 <871qik28bs.fsf@toke.dk>
 <CAEf4BzYin==+WF27QBXoj23tHcr5BeezbPj2u9RW6qz4sLJsKw@mail.gmail.com>
 <87h6rgz60u.fsf@toke.dk>
 <CAEf4Bzasz_1qRXh4b7B8V1mOfyD++mVNYnhm6v__-cc7cU_33w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 12 Jun 2023 12:49:39 +0200
Message-ID: <87bkhlymyk.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Jun 9, 2023 at 2:21=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@kernel.org> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Fri, Jun 9, 2023 at 4:17=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@kernel.org> wrote:
>> >>
>> >> Andrii Nakryiko <andrii@kernel.org> writes:
>> >>
>> >> > This patch set introduces new BPF object, BPF token, which allows t=
o delegate
>> >> > a subset of BPF functionality from privileged system-wide daemon (e=
.g.,
>> >> > systemd or any other container manager) to a *trusted* unprivileged
>> >> > application. Trust is the key here. This functionality is not about=
 allowing
>> >> > unconditional unprivileged BPF usage. Establishing trust, though, is
>> >> > completely up to the discretion of respective privileged applicatio=
n that
>> >> > would create a BPF token.
>> >>
>> >> I am not convinced that this token-based approach is a good way to so=
lve
>> >> this: having the delegation mechanism be one where you can basically
>> >> only grant a perpetual delegation with no way to retract it, no way to
>> >> check what exactly it's being used for, and that is transitive (can be
>> >> passed on to others with no restrictions) seems like a recipe for
>> >> disaster. I believe this was basically the point Casey was making as
>> >> well in response to v1.
>> >
>> > Most of this can be added, if we really need to. Ability to revoke BPF
>> > token is easy to implement (though of course it will apply only for
>> > subsequent operations). We can allocate ID for BPF token just like we
>> > do for BPF prog/map/link and let tools iterate and fetch information
>> > about it. As for controlling who's passing what and where, I don't
>> > think the situation is different for any other FD-based mechanism. You
>> > might as well create a BPF map/prog/link, pass it through SCM_RIGHTS
>> > or BPF FS, and that application can keep doing the same to other
>> > processes.
>>
>> No, but every other fd-based mechanism is limited in scope. E.g., if you
>> pass a map fd that's one specific map that can be passed around, with a
>> token it's all operations (of a specific type) which is way broader.
>
> It's not black and white. Once you have a BPF program FD, you can
> attach it many times, for example, and cause regressions. Sure, here
> we are talking about creating multiple BPF maps or loading multiple
> BPF programs, so it's wider in scope, but still, it's not that
> fundamentally different.

Right, but the difference is that a single BPF program is a known
entity, so even if the application you pass the fd to can attach it
multiple times, it can't make it do new things (e.g., bpf_probe_read()
stuff it is not supposed to). Whereas with bpf_token you have no such
guarantee.

>>
>> > Ultimately, currently we have root permissions for applications that
>> > need BPF. That's already very dangerous. But just because something
>> > might be misused or abused doesn't prevent us from making a good
>> > practical use of it, right?
>>
>> That's not a given. It's always a trade-off, and if the mechanism is
>> likely to open up the system to additional risk that's not a good
>> trade-off even if it helps in some case. I basically worry that this is
>> the case here.
>>
>> > Also, there is LSM on top of all of this to override and control how
>> > the BPF subsystem is used, regardless of BPF token. It can override
>> > any of the privileges mechanism, capabilities, BPF token, whatnot.
>>
>> If this mechanism needs an LSM to be used safely, that's not incredibly
>> confidence-inspiring. Security mechanisms should fail safe, which this
>> one does not.
>
> I proposed to add authoritative LSM hooks that would selectively allow
> some of BPF operations on a case-by-case basis. This was rejected,
> claiming that the best approach is to give process privilege to do
> whatever it needs to do and then restrict it with LSM.
>
> Ok, if not for user namespaces, that would mean giving application
> CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN+CAP_SYS_ADMIN, and then restrict it
> with LSM. Except with user namespace that doesn't work. So that's
> where BPF token comes in, but allows it to do it more safely by
> allowing to coarsely tune what subset of BPF operations is granted.
> And then LSM should be used to further restrict it.

Right, I do understand the use case, my worry is that we're creating a
privilege escalation model that is really broad if it is *not* coupled
with an LSM to restrict it. Which will be the default outside of
controlled environments that really know what they are doing.

So I dunno, maybe some way to restrict the token so it only grants
privilege if there is *also* an explicit LSM verdict on it? I guess
that's still too close to an authoritative LSM hook that it'll pass? I
do think the "explicit grant" model of an authoritative LSM is a better
fit for this kind of thing...

>> I'm also worried that an LSM policy is the only way to disable the
>> ability to create a token; with this in the kernel, I suddenly have to
>> trust not only that all applications with BPF privileges will not load
>> malicious code, but also that they won't (accidentally or maliciously)
>> conveys extra privileges on someone else. Seems a bit broad to have this
>> ability (to issue tokens) available to everyone with access to the bpf()
>> syscall, when (IIUC) it's only a single daemon in the system that would
>> legitimately do this in the deployment you're envisioning.
>
> Note, any process with real CAP_SYS_ADMIN. Let's not forget that.
>
> But would you feel better if BPF_TOKEN_CREATE was guarded behind
> sysctl or Kconfig?

Hmm, yeah, some way to make sure it's off by default would be
preferable, IMO.

> Ultimately, worrying is fine, but there are real problems that need to
> be solved. And not doing anything isn't a great option.

Right, it would be good if some of the security folks could chime in
with their view of how this is best achieved without running into any of
the "bad ideas" they are opposed to.

>> >> If the goal is to enable a privileged application (such as a container
>> >> manager) to grant another unprivileged application the permission to
>> >> perform certain bpf() operations, why not just proxy the operations
>> >> themselves over some RPC mechanism? That way the granting application
>> >
>> > It's explicitly what we *do not* want to do, as it is a major problem
>> > and logistical complication. Every single application will have to be
>> > rewritten to use such a special daemon/service and its API, which is
>> > completely different from bpf() syscall API. It invalidates the use of
>> > all the libbpf (and other bpf libraries') APIs, BPF skeleton is
>> > incompatible with this. It's a nightmare. I've got feedback from
>> > people in another company that do have BPF service with just a tiny
>> > subset of BPF functionality delegated to such service, and it's a pain
>> > and definitely not a preferred way to do things.
>>
>> But weren't you proposing that libbpf should be able to transparently
>> look for tokens and load them without any application changes? Why can't
>> libbpf be taught to use an RPC socket in a similar fashion? It basically
>> boils down to something like:
>>
>> static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
>>                           unsigned int size)
>> {
>>         if (!stat("/run/bpf.sock")) {
>>                 sock =3D open_socket("/run/bpf.sock");
>>                 write_to(sock, cmd, attr, size);
>>                 return read_response(sock);
>>         } else {
>>                 return syscall(__NR_bpf, cmd, attr, size);
>>         }
>> }
>>
>
> Well, for one, Meta we'll use its own Thrift-based RPC protocol.
> Google might use something internal for them using GRPC, someone else
> would want to utilize systemd, yet others will use yet another
> implementation. RPC introduces more failure modes. While with syscall
> we know that operation either succeeded or failed, with RPC we'll have
> to deal with "maybe", if it was some communication error.
>
> Let's not trivialize adding, using, and supporting the RPC version of
> bpf() syscall.

I am not trying to trivialise it, I am well aware that it is more
complicated in practice than just adding a wrapper like the above. I am
just arguing with your point that "all applications need to change, so
we can't do RPC". Any mechanism we add along there lines will require
application changes, including the BPF token. And if the way we're going
to avoid that is by baking the support into libbpf, then that can be
done regardless of the mechanism we choose.

Or to put it another way: as you say it may be more *complicated* to add
an RPC-based path to libbpf, but it's not fundamentally impossible, it's
just another technical problem to be solved. And if that added
complexity buys us better security properties, maybe that is a good
trade-off. At least we shouldn't dismiss it out of hand.

-Toke

