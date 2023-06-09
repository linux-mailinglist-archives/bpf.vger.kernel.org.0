Return-Path: <bpf+bounces-2273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8227272A61B
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 00:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BF3281AB7
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 22:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F69823D7E;
	Fri,  9 Jun 2023 22:03:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE723403
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 22:03:35 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB863A87;
	Fri,  9 Jun 2023 15:03:32 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51478f6106cso3836269a12.1;
        Fri, 09 Jun 2023 15:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686348210; x=1688940210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVufI5rWvl0Jy+fSVpPKqUvL4eBzUMcsL2E33jVqJoM=;
        b=pmvWT5K2yGV/tDh+md2AS8tUEh1N5qZ1D6NVonTxeRRB9/AR6UH3yGJ9lfeCygpa4h
         xD75sNlqEGe4NpGzTdqP+0FeUkphlAfrpyVpSGnpLk8D7Drd2teY3fJKTqSefk9N2Sj6
         sizpjtYXlvO/vewiE/gdMRbZSVcGTdi9XsjCO7cebw+kTCvGRN3fpHlUoiYOxB71GPqd
         R4IkIdfbusttyU8BmvF5/Wz4tpP45biXZ6XQKydnZGbyDpb+mqJyqISrlczJHY11Fxu6
         OZuStfe4XO4d5UDoBXrtKz4X/xLfWIN3MZJkZK2iFr7oxPV1y5mI5AZOJ2kQuJTlwka/
         Yomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686348210; x=1688940210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVufI5rWvl0Jy+fSVpPKqUvL4eBzUMcsL2E33jVqJoM=;
        b=QpD/9e6IgyqWrKzQ+mqVJyCyBqlBYjcLZ2mMFNc6m4TkP81vih7TeCY47UffZHlOVm
         OnLBzc5cs0B0O8cGkRv4BsPk/IEtTuDgyvYwka6ydakLLtCrNJJcyn8Y36LUA9CHXwKs
         Q1d6rkAbzYhpoBI5WTPF09kwma3ncJY+l7gc0036wPofTtlIYE299+j1nB12rCl3KVKv
         0Xl1pKJ+D3a3ttMrJIiXLBGxh2kY85e9aYPAluI7+nLoutw7Ww+GcIV9oZNKXsTuRsmn
         Qz/nZEepy0+MjcKBIRWfUro1FXeI4s3f6DsLpQewrqBoJiAAtpoaA2DKWkf+hJf7TBX2
         59lw==
X-Gm-Message-State: AC+VfDxeYkQjvTXFFVhtF1CcnBTF1urKj+rocDTqMJ9lKpd+uhPkgKgK
	nG+kYkUcQGy2kxwqLJ0nlHD9pXLJ88vgknCrMGk=
X-Google-Smtp-Source: ACHHUZ4u9yTYqF8Q5Jaumqoq6a9o9zZRw3JMmJ7vNLlexqsQ77YFoeEZUdZRTKSlGhfGtksiBiXFJ1ZtehYAd9+0j6I=
X-Received: by 2002:a17:907:d15:b0:96f:4fc4:f5ab with SMTP id
 gn21-20020a1709070d1500b0096f4fc4f5abmr3739104ejc.18.1686348210216; Fri, 09
 Jun 2023 15:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <871qik28bs.fsf@toke.dk>
 <CAEf4BzYin==+WF27QBXoj23tHcr5BeezbPj2u9RW6qz4sLJsKw@mail.gmail.com> <87h6rgz60u.fsf@toke.dk>
In-Reply-To: <87h6rgz60u.fsf@toke.dk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jun 2023 15:03:18 -0700
Message-ID: <CAEf4Bzasz_1qRXh4b7B8V1mOfyD++mVNYnhm6v__-cc7cU_33w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com, 
	luto@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 9, 2023 at 2:21=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@kernel.org> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Fri, Jun 9, 2023 at 4:17=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@kernel.org> wrote:
> >>
> >> Andrii Nakryiko <andrii@kernel.org> writes:
> >>
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
> >> > would create a BPF token.
> >>
> >> I am not convinced that this token-based approach is a good way to sol=
ve
> >> this: having the delegation mechanism be one where you can basically
> >> only grant a perpetual delegation with no way to retract it, no way to
> >> check what exactly it's being used for, and that is transitive (can be
> >> passed on to others with no restrictions) seems like a recipe for
> >> disaster. I believe this was basically the point Casey was making as
> >> well in response to v1.
> >
> > Most of this can be added, if we really need to. Ability to revoke BPF
> > token is easy to implement (though of course it will apply only for
> > subsequent operations). We can allocate ID for BPF token just like we
> > do for BPF prog/map/link and let tools iterate and fetch information
> > about it. As for controlling who's passing what and where, I don't
> > think the situation is different for any other FD-based mechanism. You
> > might as well create a BPF map/prog/link, pass it through SCM_RIGHTS
> > or BPF FS, and that application can keep doing the same to other
> > processes.
>
> No, but every other fd-based mechanism is limited in scope. E.g., if you
> pass a map fd that's one specific map that can be passed around, with a
> token it's all operations (of a specific type) which is way broader.

It's not black and white. Once you have a BPF program FD, you can
attach it many times, for example, and cause regressions. Sure, here
we are talking about creating multiple BPF maps or loading multiple
BPF programs, so it's wider in scope, but still, it's not that
fundamentally different.

>
> > Ultimately, currently we have root permissions for applications that
> > need BPF. That's already very dangerous. But just because something
> > might be misused or abused doesn't prevent us from making a good
> > practical use of it, right?
>
> That's not a given. It's always a trade-off, and if the mechanism is
> likely to open up the system to additional risk that's not a good
> trade-off even if it helps in some case. I basically worry that this is
> the case here.
>
> > Also, there is LSM on top of all of this to override and control how
> > the BPF subsystem is used, regardless of BPF token. It can override
> > any of the privileges mechanism, capabilities, BPF token, whatnot.
>
> If this mechanism needs an LSM to be used safely, that's not incredibly
> confidence-inspiring. Security mechanisms should fail safe, which this
> one does not.

I proposed to add authoritative LSM hooks that would selectively allow
some of BPF operations on a case-by-case basis. This was rejected,
claiming that the best approach is to give process privilege to do
whatever it needs to do and then restrict it with LSM.

Ok, if not for user namespaces, that would mean giving application
CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN+CAP_SYS_ADMIN, and then restrict it
with LSM. Except with user namespace that doesn't work. So that's
where BPF token comes in, but allows it to do it more safely by
allowing to coarsely tune what subset of BPF operations is granted.
And then LSM should be used to further restrict it.

>
> I'm also worried that an LSM policy is the only way to disable the
> ability to create a token; with this in the kernel, I suddenly have to
> trust not only that all applications with BPF privileges will not load
> malicious code, but also that they won't (accidentally or maliciously)
> conveys extra privileges on someone else. Seems a bit broad to have this
> ability (to issue tokens) available to everyone with access to the bpf()
> syscall, when (IIUC) it's only a single daemon in the system that would
> legitimately do this in the deployment you're envisioning.

Note, any process with real CAP_SYS_ADMIN. Let's not forget that.

But would you feel better if BPF_TOKEN_CREATE was guarded behind
sysctl or Kconfig?

Ultimately, worrying is fine, but there are real problems that need to
be solved. And not doing anything isn't a great option.

>
> >> If the goal is to enable a privileged application (such as a container
> >> manager) to grant another unprivileged application the permission to
> >> perform certain bpf() operations, why not just proxy the operations
> >> themselves over some RPC mechanism? That way the granting application
> >
> > It's explicitly what we *do not* want to do, as it is a major problem
> > and logistical complication. Every single application will have to be
> > rewritten to use such a special daemon/service and its API, which is
> > completely different from bpf() syscall API. It invalidates the use of
> > all the libbpf (and other bpf libraries') APIs, BPF skeleton is
> > incompatible with this. It's a nightmare. I've got feedback from
> > people in another company that do have BPF service with just a tiny
> > subset of BPF functionality delegated to such service, and it's a pain
> > and definitely not a preferred way to do things.
>
> But weren't you proposing that libbpf should be able to transparently
> look for tokens and load them without any application changes? Why can't
> libbpf be taught to use an RPC socket in a similar fashion? It basically
> boils down to something like:
>
> static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
>                           unsigned int size)
> {
>         if (!stat("/run/bpf.sock")) {
>                 sock =3D open_socket("/run/bpf.sock");
>                 write_to(sock, cmd, attr, size);
>                 return read_response(sock);
>         } else {
>                 return syscall(__NR_bpf, cmd, attr, size);
>         }
> }
>

Well, for one, Meta we'll use its own Thrift-based RPC protocol.
Google might use something internal for them using GRPC, someone else
would want to utilize systemd, yet others will use yet another
implementation. RPC introduces more failure modes. While with syscall
we know that operation either succeeded or failed, with RPC we'll have
to deal with "maybe", if it was some communication error.

Let's not trivialize adding, using, and supporting the RPC version of
bpf() syscall.


> > Just think about having to mirror a big chunk of bpf() syscall as an
> > RPC. So no, BPF proxy is definitely not a good solution.
>
> The daemon at the other side of the socket in the example above doesn't
> *have* to be taught all the semantics of the syscall, it can just look
> at the command name and make a decision based on that and the identity
> of the socket peer, then just pass the whole thing to the kernel if the
> permission check passes.

Let's not trivialize the consequences of adding an RPC protocol to all
this, please. No matter in what form or shape.

>
> >> can perform authentication checks on every operation and ensure its
> >> origins are sound at the time it is being made. Instead of just writin=
g
> >> a blank check (in the form of a token) and hoping the receiver of it i=
s
> >> not compromised...
> >
> > All this could and should be done through LSM in much more decoupled
> > and transparent (to application) way. BPF token doesn't prevent this.
> > It actually helps with this, because organizations can actually
> > dictate that operations that do not provide BPF token are
> > automatically rejected, and those that do provide BPF token can be
> > further checked and granted or rejected based on specific BPF token
> > instance.
>
> See above re: needing an LSM policy to make this safe...

See above. We are talking about the CAP_SYS_ADMIN-enabled process.
It's not safe by definition already.

>
> -Toke

