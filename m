Return-Path: <bpf+bounces-71700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B119BFB80F
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 13:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F0F408591
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 11:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6E832AACD;
	Wed, 22 Oct 2025 11:00:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B51328B50
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130809; cv=none; b=AOO1aPqZY3tIJcQSOhyfrITHVurYACTnBW+psycaffo6anVTRDp64YizKgQNpRt0JVedcX2uOx+dP00fH3tVa5cK/XIVRKs1fCHePxspsogH3mYu0ekBirS/rYmy6TPj+gjvr46RPgEVcfA0Uo4WnfY9MKJMdaOV33kj17IFC2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130809; c=relaxed/simple;
	bh=OKz+xmkKiE9OVC+4fDjQc95t5WKflma0N2qOQ8z5SZg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k072Q0mztIs1zjKYCe8c4jB+88KHw+rQ9O8zCfCT/OLmupvGCCp63PTgWy0uPwm6FzViUmj9AhUBBhCbGIYDiNH+yqCS1BmA1xYrv3l4dOhRFdtSBV8CQE1fc226ugzEqoIjfJqdkSiLcjZpFKv0AWID11+36rwGrn/1NUAc74w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso6568541f8f.1
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 04:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130803; x=1761735603;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WMhlNDo8ASWwcI8u3mjsBd+rOMePpOl7Ef330eW/SSU=;
        b=vzbUdw/0nIvx/OQawl4JI0ensDLL5EM/OUq5z+wIXydHA1Ij0WX/AQrtcb6G3OJm9I
         /VpaQ6kRqKJ3T4K+LQ4XgxYIFM5I6BcgY1RdxmJUB4yWV6PmpyJLbhVobtZL7+ZcbC1k
         HfsYqrcQHD154b/FMHOJoV2F/Pk2jAOjnm/nmwmzOLTvUZhW4iahxNtdKlE34MFw4DLm
         EwERIbb+zPM6pA2O4AQKTwodwHcynnnpLwWQkOV0NpjvHtn6DfzCudDUYfN6yXJDmv09
         0T793WCXV1mIf/nk+tW1iX63yl/4Xr8YI5MsKcdrVM7nQbrKBdLggXOyKi3vB+PKqFO9
         gfnw==
X-Forwarded-Encrypted: i=1; AJvYcCX0R8cd3qJ3wFYAm7JJ6xoI03TQ5P2FYP96iNCBHmU0B3QIiwog4j4SFGXgBFxe3fqTBQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR/SlhQJEuRFHdBlLLMNsu4SEX3GEribHLQhlZSm8/egAJIDOc
	mcPpVevYPo3aH9JNkK+Nn+N/S41CmUfoHmeq+1kDIuBlAQEihjmVPecK
X-Gm-Gg: ASbGnctIkoQnJhsjvkOlrgeWvg9E9GRQWe1wCTtd4eNDG7Ujcrt2XFuBlQR85TCqpYs
	W4OUjBiFSRc7U6fRWvkjcNoQtJsAcIWwTh2KurwihQRgyLo6GU9EdI7oDbsIZ7EwTUK1wgjNHlC
	fN2o69o60GmCNzdVc+zoNd3GDKKewit+0RBlC9DmCqZtpWIdIJ5qXUO37emt8iU7OkyJEDMPEl8
	G47nv7gzoSejBPzuVSZFArP4eGtupZ3kxoGh8EKyt1r2GtPdV9bUOp7GCa65ppwrxP91Kw/yxmk
	/Wp05ivHCx1aJVq3YPqEjmQNCCtrDG2DNFSvfYW4kFLztR15QJoDt/yF7Fjg21raT2+6+SYX8oz
	Z1l8FWBRdKYOfPkkT8bACDgtCYFlJkgK56Y5ZSHdbQ0vX+Mcx9JQyZuL0+oaqB0j85yB+aEV1bn
	QkHntI4Mh5OYvtpdLYSkRWyMZ0sv2oPUDW4V+EY3BTrX4KdlmaB/YFn181UFnXPaEC
X-Google-Smtp-Source: AGHT+IH5uo+eTYMpftiVH0dhTJ/g13dymxown9/4klXMfyReEafbuUyOsJCDQx0E42CrJS41YtQEjg==
X-Received: by 2002:a05:6000:250a:b0:428:3bb5:5813 with SMTP id ffacd0b85a97d-4283bb55a33mr11110213f8f.59.1761130803127;
        Wed, 22 Oct 2025 04:00:03 -0700 (PDT)
Received: from [10.148.83.128] (business-89-135-192-225.business.broadband.hu. [89.135.192.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9f71sm24812193f8f.37.2025.10.22.04.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:00:02 -0700 (PDT)
Message-ID: <f708a1119b2ad8cf2514b1df128a4ef7cf21c636.camel@fejes.dev>
Subject: Re: [PATCH RFC DRAFT 00/50] nstree: listns()
From: Ferenc Fejes <ferenc@fejes.dev>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, Zbigniew
 =?UTF-8?Q?J=C4=99drzejewski-Szmek?=	 <zbyszek@in.waw.pl>, Lennart
 Poettering <mzxreary@0pointer.de>, Daan De Meyer	
 <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, Amir
 Goldstein	 <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
	 <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, Alexander Viro
	 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org,
  Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Arnd Bergmann	 <arnd@arndb.de>
Date: Wed, 22 Oct 2025 13:00:01 +0200
In-Reply-To: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
References: 
	<20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-5 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 13:43 +0200, Christian Brauner wrote:
> Hey,
>=20
> As announced a while ago this is the next step building on the nstree
> work from prior cycles. There's a bunch of fixes and semantic cleanups
> in here and a ton of tests.
>=20
> I need helper here!: Consider the following current design:
>=20
> Currently listns() is relying on active namespace reference counts which
> are introduced alongside this series.
>=20
> The active reference count of a namespace consists of the live tasks
> that make use of this namespace and any namespace file descriptors that
> explicitly pin the namespace.
>=20
> Once all tasks making use of this namespace have exited or reaped, all
> namespace file descriptors for that namespace have been closed and all
> bind-mounts for that namespace unmounted it ceases to appear in the
> listns() output.
>=20
> My reason for introducing the active reference count was that namespaces
> might obviously still be pinned internally for various reasons. For
> example the user namespace might still be pinned because there are still
> open files that have stashed the openers credentials in file->f_cred, or
> the last reference might be put with an rcu delay keeping that namespace
> active on the namespace lists.
>=20
> But one particularly strange example is CONFIG_MMU_LAZY_TLB_REFCOUNT=3Dy.
> Various architectures support the CONFIG_MMU_LAZY_TLB_REFCOUNT option
> which uses lazy TLB destruction.
>=20
> When this option is set a userspace task's struct mm_struct may be used
> for kernel threads such as the idle task and will only be destroyed once
> the cpu's runqueue switches back to another task. So the kernel thread
> will take a reference on the struct mm_struct pinning it.
>=20
> And for ptrace() based access checks struct mm_struct stashes the user
> namespace of the task that struct mm_struct belonged to originally and
> thus takes a reference to the users namespace and pins it.
>=20
> So on an idle system such user namespaces can be persisted for pretty
> arbitrary amounts of time via struct mm_struct.
>=20
> Now, without the active reference count regulating visibility all
> namespace that still are pinned in some way on the system will appear in
> the listns() output and can be reopened using namespace file handles.
>=20
> Of course that requires suitable privileges and it's not really a
> concern per se because a task could've also persist the namespace
> recorded in struct mm_struct explicitly and then the idle task would
> still reuse that struct mm_struct and another task could still happily
> setns() to it afaict and reuse it for something else.
>=20
> The active reference count though has drawbacks itself. Namely that
> socket files break the assumption that namespaces can only be opened if
> there's either live processes pinning the namespace or there are file
> descriptors open that pin the namespace itself as the socket SIOCGSKNS
> ioctl() can be used to open a network namespace based on a socket which
> only indirectly pins a network namespace.
>=20
> So that punches a whole in the active reference count tracking. So this
> will have to be handled as right now socket file descriptors that pin a
> network namespace that don't have an active reference anymore (no live
> processes, not explicit persistence via namespace fds) can't be used to
> issue a SIOCGSKNS ioctl() to open the associated network namespace.
>=20
> So two options I see if the api is based on ids:
>=20
> (1) We use the active reference count and somehow also make it work with
> =C2=A0=C2=A0=C2=A0 sockets.
> (2) The active reference count is not needed and we say that listns() is
> =C2=A0=C2=A0=C2=A0 an introspection system call anyway so we just always =
list
> =C2=A0=C2=A0=C2=A0 namespaces regardless of why they are still pinned: fi=
les,
> =C2=A0=C2=A0=C2=A0 mm_struct, network devices, everything is fair game.
> (3) Throw hands up in the air and just not do it.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Add a new listns() system call that allows userspace to iterate through
> namespaces in the system. This provides a programmatic interface to
> discover and inspect namespaces, enhancing existing namespace apis.
>=20
> Currently, there is no direct way for userspace to enumerate namespaces
> in the system. Applications must resort to scanning /proc/<pid>/ns/
> across all processes, which is:
>=20
> 1. Inefficient - requires iterating over all processes
> 2. Incomplete - misses inactive namespaces that aren't attached to any
> =C2=A0=C2=A0 running process but are kept alive by file descriptors, bind=
 mounts,
> =C2=A0=C2=A0 or parent namespace references
> 3. Permission-heavy - requires access to /proc for many processes
> 4. No ordering or ownership.
> 5. No filtering per namespace type: Must always iterate and check all
> =C2=A0=C2=A0 namespaces.
>=20
> The list goes on. The listns() system call solves these problems by
> providing direct kernel-level enumeration of namespaces. It is similar
> to listmount() but obviously tailored to namespaces.

I've been waiting for such an API for years; thanks for working on it. I mo=
stly
deal with network namespaces, where points 2 and 3 are especially painful.

Recently, I've used this eBPF snippet to discover (at most 1024, because of=
 the
verifier's halt checking) network namespaces, even if no process is attache=
d.
But I can't do anything with it in userspace since it's not possible to pas=
s the
inode number or netns cookie value to setns()...

extern const void net_namespace_list __ksym;
static void list_all_netns()
{
    struct list_head *nslist =3D=C2=A0
	bpf_core_cast(&net_namespace_list, struct list_head);

    struct list_head *iter =3D nslist->next;

    bpf_repeat(1024) {
        const struct net *net =3D=C2=A0
		bpf_core_cast(container_of(iter, struct net, list), struct
net);

        // bpf_printk("net: %p inode: %u cookie: %lu",=C2=A0
	//	net, net->ns.inum, net->net_cookie);

        if (iter->next =3D=3D nslist)
            break;
        iter =3D iter->next;
    }
}

>=20
> /*
> =C2=A0* @req: Pointer to struct ns_id_req specifying search parameters
> =C2=A0* @ns_ids: User buffer to receive namespace IDs
> =C2=A0* @nr_ns_ids: Size of ns_ids buffer (maximum number of IDs to retur=
n)
> =C2=A0* @flags: Reserved for future use (must be 0)
> =C2=A0*/
> ssize_t listns(const struct ns_id_req *req, u64 *ns_ids,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 size_t nr_ns_ids, unsigned int flags);
>=20
> Returns:
> - On success: Number of namespace IDs written to ns_ids
> - On error: Negative error code
>=20
> /*
> =C2=A0* @size: Structure size
> =C2=A0* @ns_id: Starting point for iteration; use 0 for first call, then
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use the last retu=
rned ID for subsequent calls to paginate
> =C2=A0* @ns_type: Bitmask of namespace types to include (from enum ns_typ=
e):
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0: Re=
turn all namespace types
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MNT_N=
S: Mount namespaces
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NET_N=
S: Network namespaces
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 USER_=
NS: User namespaces
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 etc. =
Can be OR'd together
> =C2=A0* @user_ns_id: Filter results to namespaces owned by this user name=
space:
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0: Return all namespaces (subject to permission checks)
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 LISTNS_CURRENT_USER: Namespaces owned by caller's user
> namespace
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Other value: Namespaces owned by the specified user namespace
> ID
> =C2=A0*/
> struct ns_id_req {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 size;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* sizeof(struct ns_id_req) */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 spare;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* Reserved, must be 0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u64 ns_id;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* Last seen namespace ID (for pagination) */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 ns_type;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* Filter by namespace type(s) */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 spare2;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* Reserved, must be 0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u64 user_ns_id;=C2=A0=C2=A0 =
/* Filter by owning user namespace */
> };
>=20

After this merged, do you see any chance for backports? Does it rely on rec=
ent
bits which is hard/impossible to backport? I'm not aware of backported sysc=
alls
but this would be really nice to see in older kernels.

Ferenc

