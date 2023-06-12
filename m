Return-Path: <bpf+bounces-2454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E7F72D428
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 00:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821D61C20AA6
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 22:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345A923437;
	Mon, 12 Jun 2023 22:08:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46918AE0
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 22:08:26 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09651EC;
	Mon, 12 Jun 2023 15:08:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-977c72b116fso733117566b.3;
        Mon, 12 Jun 2023 15:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686607701; x=1689199701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKlFpCsgGRBSEpcvA8goXTCdE7SxfBhfKUPSSPN+Oik=;
        b=KervkGOD8sKHnhI3vis2lD8d4MrSt1ieqJvhTppaEqLOHp81zwpvaP9Zhyz0ir3HAg
         Tku8/M31Wu6zFu8jQD9RB6fXNcUn6Fmiyn27ZZQvq07ayP00u5RdOciMvsIoe81S/E2g
         zqqZIv0y1pJbGSEYGqv+yd/onfsuXE/JU1zH9ODWpWqdB+edMYdSZxnev5GDsuARVHnf
         wou29nLpecnIq0sw1tI3y7Yb6YD4uALnjiSKZlhulC/lCTunvMND1utd1Iqdj++6b1la
         Os83Jl1R02KuO61q/1j+ePwXQKex50cak6RPzY8IrqCK9lsXzgC8p24nhwwwPVsfGuw/
         a1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686607701; x=1689199701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKlFpCsgGRBSEpcvA8goXTCdE7SxfBhfKUPSSPN+Oik=;
        b=l/CWBOyyGll4z7y2vyKTfAvD6MQ90w+pUUi8JkUC3OfRe8NFsprLkgTQVPHCGMoweN
         wYWXfWCfOHrJ+pKFGJ+gTkJ3neEbgtAtAKr9DdC/fAKhIDEJVUrHHOrB4bw0KjwiItIQ
         1FfNIuVHSXF354ESbUk9ULV9vgUQwn5H18F+4ehGcsC544xJXYwOtRroNiQdN5qoQgrN
         ZJc+1a168cOoS2bs4Pp2REmootd2/NT+H9yBp6Azrq5qV7FR+nUYZ9qyTPzK7h7wRSTc
         Z9PtCmh2Y7qCbjutbgGSzH6wbQ+YgZQ25qEtMheyI4nKZ3YP8wnIrHp5yiaPast26tRr
         okhg==
X-Gm-Message-State: AC+VfDyLqqELz0hZPeC1oJtH7msnfK6xXJl3/8XHvh+IaYMTd/eVW4kg
	iVxa52/qzqFLghhU5MngMdxGOD05m0E9C1SAF3I=
X-Google-Smtp-Source: ACHHUZ6U+TrlErpCwXzkkeyLYsRzS49lBX/LhfBNuOPBAI3CrcAjOZxw1K+SI1KrIDm5G+996Y7jESoUU/yUiX+NMpA=
X-Received: by 2002:a17:907:a40f:b0:978:ae78:a77f with SMTP id
 sg15-20020a170907a40f00b00978ae78a77fmr9636784ejc.21.1686607701151; Mon, 12
 Jun 2023 15:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <871qik28bs.fsf@toke.dk>
 <CAEf4BzYin==+WF27QBXoj23tHcr5BeezbPj2u9RW6qz4sLJsKw@mail.gmail.com>
 <87h6rgz60u.fsf@toke.dk> <CAEf4Bzasz_1qRXh4b7B8V1mOfyD++mVNYnhm6v__-cc7cU_33w@mail.gmail.com>
 <87bkhlymyk.fsf@toke.dk>
In-Reply-To: <87bkhlymyk.fsf@toke.dk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Jun 2023 15:08:08 -0700
Message-ID: <CAEf4BzZRKgMjOQhxdC_fvn1SPwPh-GXhy_1TJVB6eVpZ8k04vw@mail.gmail.com>
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

On Mon, Jun 12, 2023 at 3:49=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@kernel.org> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Fri, Jun 9, 2023 at 2:21=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@kernel.org> wrote:
> >>
> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >>
> >> > On Fri, Jun 9, 2023 at 4:17=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgen=
sen <toke@kernel.org> wrote:
> >> >>
> >> >> Andrii Nakryiko <andrii@kernel.org> writes:
> >> >>
> >> >> > This patch set introduces new BPF object, BPF token, which allows=
 to delegate
> >> >> > a subset of BPF functionality from privileged system-wide daemon =
(e.g.,
> >> >> > systemd or any other container manager) to a *trusted* unprivileg=
ed
> >> >> > application. Trust is the key here. This functionality is not abo=
ut allowing
> >> >> > unconditional unprivileged BPF usage. Establishing trust, though,=
 is
> >> >> > completely up to the discretion of respective privileged applicat=
ion that
> >> >> > would create a BPF token.
> >> >>
> >> >> I am not convinced that this token-based approach is a good way to =
solve
> >> >> this: having the delegation mechanism be one where you can basicall=
y
> >> >> only grant a perpetual delegation with no way to retract it, no way=
 to
> >> >> check what exactly it's being used for, and that is transitive (can=
 be
> >> >> passed on to others with no restrictions) seems like a recipe for
> >> >> disaster. I believe this was basically the point Casey was making a=
s
> >> >> well in response to v1.
> >> >
> >> > Most of this can be added, if we really need to. Ability to revoke B=
PF
> >> > token is easy to implement (though of course it will apply only for
> >> > subsequent operations). We can allocate ID for BPF token just like w=
e
> >> > do for BPF prog/map/link and let tools iterate and fetch information
> >> > about it. As for controlling who's passing what and where, I don't
> >> > think the situation is different for any other FD-based mechanism. Y=
ou
> >> > might as well create a BPF map/prog/link, pass it through SCM_RIGHTS
> >> > or BPF FS, and that application can keep doing the same to other
> >> > processes.
> >>
> >> No, but every other fd-based mechanism is limited in scope. E.g., if y=
ou
> >> pass a map fd that's one specific map that can be passed around, with =
a
> >> token it's all operations (of a specific type) which is way broader.
> >
> > It's not black and white. Once you have a BPF program FD, you can
> > attach it many times, for example, and cause regressions. Sure, here
> > we are talking about creating multiple BPF maps or loading multiple
> > BPF programs, so it's wider in scope, but still, it's not that
> > fundamentally different.
>
> Right, but the difference is that a single BPF program is a known
> entity, so even if the application you pass the fd to can attach it
> multiple times, it can't make it do new things (e.g., bpf_probe_read()
> stuff it is not supposed to). Whereas with bpf_token you have no such
> guarantee.

Sure, I'm not claiming BPF token is just like passing BPF program FD
around. My point is that anything in the kernel that is representable
by FD can be passed around to an unintended process through
SCM_RIGHTS. And if you want to have tighter control over who's passing
what, you'd probably need LSM. But it's not a requirement.

With BPF token it is important to trust the application you are
passing BPF token to. This is not a mechanism to just freely pass
around the ability to do BPF. You do it only to applications you
control.

You can initiate BPF token from under CAP_SYS_ADMIN only. If you give
CAP_SYS_ADMIN to some application that might pass BPF token to some
random application, you should probably revisit the whole approach.
You can do a lot of harm with that CAP_SYS_ADMIN beyond the BPF
subsystem.

On the other hand, the more correct comparison would be whether to
give some unprivileged application a BPF token versus giving it
CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN+CAP_SYSADMIN (or the necessary
subset of it). With BPF token you can narrow down to what exact types
of programs and maps it can use, if at all. BPF token applies to BPF
subsystem only. With caps, you are giving that application way more
power than you'd like, but that's ok in practice, because a) you need
that application to do something useful with BPF, so you take that
risk, and b) you normally would control that application, so you are
mitigating this risk even without any LSM or something like that on
top.

We do the latter all the time because we have to. BPF token gives us
more well-scoped alternatively.

With user namespaces, if we could grant CAP_BPF and co to use BPF,
we'd do that. But we can't. BPF token at least gives us this
opportunity.

So while I understand your concerns in principle, I think they are a
bit overblown in practice.

>
> >>
> >> > Ultimately, currently we have root permissions for applications that
> >> > need BPF. That's already very dangerous. But just because something
> >> > might be misused or abused doesn't prevent us from making a good
> >> > practical use of it, right?
> >>
> >> That's not a given. It's always a trade-off, and if the mechanism is
> >> likely to open up the system to additional risk that's not a good
> >> trade-off even if it helps in some case. I basically worry that this i=
s
> >> the case here.
> >>
> >> > Also, there is LSM on top of all of this to override and control how
> >> > the BPF subsystem is used, regardless of BPF token. It can override
> >> > any of the privileges mechanism, capabilities, BPF token, whatnot.
> >>
> >> If this mechanism needs an LSM to be used safely, that's not incredibl=
y
> >> confidence-inspiring. Security mechanisms should fail safe, which this
> >> one does not.
> >
> > I proposed to add authoritative LSM hooks that would selectively allow
> > some of BPF operations on a case-by-case basis. This was rejected,
> > claiming that the best approach is to give process privilege to do
> > whatever it needs to do and then restrict it with LSM.
> >
> > Ok, if not for user namespaces, that would mean giving application
> > CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN+CAP_SYS_ADMIN, and then restrict it
> > with LSM. Except with user namespace that doesn't work. So that's
> > where BPF token comes in, but allows it to do it more safely by
> > allowing to coarsely tune what subset of BPF operations is granted.
> > And then LSM should be used to further restrict it.
>
> Right, I do understand the use case, my worry is that we're creating a
> privilege escalation model that is really broad if it is *not* coupled
> with an LSM to restrict it. Which will be the default outside of
> controlled environments that really know what they are doing.

Look, you are worried that you gave some process root permissions and
that process delegated a small portion of that (BPF token) to an
unprivileged process, which abuses it somehow. Beyond the question of
"why did you grant root permissions to something you can't trust to do
the right thing", isn't there a more dangerous stuff (I don't know,
setuid, chmod/chown, etc) that root process can perform to grant
unprivileged process unintended and uncontrolled privileges?

Why BPF token is the one singled out that would have to require
mandatory LSM to be installed?

>
> So I dunno, maybe some way to restrict the token so it only grants
> privilege if there is *also* an explicit LSM verdict on it? I guess
> that's still too close to an authoritative LSM hook that it'll pass? I
> do think the "explicit grant" model of an authoritative LSM is a better
> fit for this kind of thing...
>

I proposed an authoritative LSM, it was pretty plainly rejected and
the model of "grant a lot + restrict with LSM" was suggested.

> >> I'm also worried that an LSM policy is the only way to disable the
> >> ability to create a token; with this in the kernel, I suddenly have to
> >> trust not only that all applications with BPF privileges will not load
> >> malicious code, but also that they won't (accidentally or maliciously)
> >> conveys extra privileges on someone else. Seems a bit broad to have th=
is
> >> ability (to issue tokens) available to everyone with access to the bpf=
()
> >> syscall, when (IIUC) it's only a single daemon in the system that woul=
d
> >> legitimately do this in the deployment you're envisioning.
> >
> > Note, any process with real CAP_SYS_ADMIN. Let's not forget that.
> >
> > But would you feel better if BPF_TOKEN_CREATE was guarded behind
> > sysctl or Kconfig?
>
> Hmm, yeah, some way to make sure it's off by default would be
> preferable, IMO.
>
> > Ultimately, worrying is fine, but there are real problems that need to
> > be solved. And not doing anything isn't a great option.
>
> Right, it would be good if some of the security folks could chime in
> with their view of how this is best achieved without running into any of
> the "bad ideas" they are opposed to.

agreed

>
> >> >> If the goal is to enable a privileged application (such as a contai=
ner
> >> >> manager) to grant another unprivileged application the permission t=
o
> >> >> perform certain bpf() operations, why not just proxy the operations
> >> >> themselves over some RPC mechanism? That way the granting applicati=
on
> >> >
> >> > It's explicitly what we *do not* want to do, as it is a major proble=
m
> >> > and logistical complication. Every single application will have to b=
e
> >> > rewritten to use such a special daemon/service and its API, which is
> >> > completely different from bpf() syscall API. It invalidates the use =
of
> >> > all the libbpf (and other bpf libraries') APIs, BPF skeleton is
> >> > incompatible with this. It's a nightmare. I've got feedback from
> >> > people in another company that do have BPF service with just a tiny
> >> > subset of BPF functionality delegated to such service, and it's a pa=
in
> >> > and definitely not a preferred way to do things.
> >>
> >> But weren't you proposing that libbpf should be able to transparently
> >> look for tokens and load them without any application changes? Why can=
't
> >> libbpf be taught to use an RPC socket in a similar fashion? It basical=
ly
> >> boils down to something like:
> >>
> >> static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
> >>                           unsigned int size)
> >> {
> >>         if (!stat("/run/bpf.sock")) {
> >>                 sock =3D open_socket("/run/bpf.sock");
> >>                 write_to(sock, cmd, attr, size);
> >>                 return read_response(sock);
> >>         } else {
> >>                 return syscall(__NR_bpf, cmd, attr, size);
> >>         }
> >> }
> >>
> >
> > Well, for one, Meta we'll use its own Thrift-based RPC protocol.
> > Google might use something internal for them using GRPC, someone else
> > would want to utilize systemd, yet others will use yet another
> > implementation. RPC introduces more failure modes. While with syscall
> > we know that operation either succeeded or failed, with RPC we'll have
> > to deal with "maybe", if it was some communication error.
> >
> > Let's not trivialize adding, using, and supporting the RPC version of
> > bpf() syscall.
>
> I am not trying to trivialise it, I am well aware that it is more
> complicated in practice than just adding a wrapper like the above. I am
> just arguing with your point that "all applications need to change, so
> we can't do RPC". Any mechanism we add along there lines will require
> application changes, including the BPF token. And if the way we're going

Well, it depends on what kinds of changes we are talking about. E.g.,
in most explicit case, it would be something like:

int token_fd =3D bpf_token_get("/sys/fs/bpf/my_granted_token");
if (token_fd < 0)
   /* we can bail out or just assume no token */
LIBBPF_OPTS(bpf_object_open_opts, .token_fd =3D token_fd);

struct my_skel *skel =3D my_skel__open_opts(&opts);


That's literally it. And if we have some convention that libbpf will
try to open, say, /sys/fs/bpf/.token automatically, there will be zero
code changes. And I'm not simplifying this.


> to avoid that is by baking the support into libbpf, then that can be
> done regardless of the mechanism we choose.
>
> Or to put it another way: as you say it may be more *complicated* to add
> an RPC-based path to libbpf, but it's not fundamentally impossible, it's
> just another technical problem to be solved. And if that added
> complexity buys us better security properties, maybe that is a good
> trade-off. At least we shouldn't dismiss it out of hand.

You are oversimplifying this. There is a huge difference between
syscall and RPC and interfaces.

The former (syscall approach) will error out only on invalid inputs
(and highly improbable if kernel runs out of memory, which means your
app is dead anyways). You don't code against syscall interface with
expectation that it can fail at any point and you should be able to
recover it.

With RPC you have to bake in into your application that any RPC can
fail transiently, for many reasons. Service could be down, restarted,
slow, etc, etc. This changes *everything* in how you develop
application, how you write code, how you handle errors, how you
monitor stuff. Everything.

It's impossible to just swap out syscall with RPC transparently
without introducing horrible consequences. This is not some technical
difficulty, it's a fundamental impedance mismatch. One of the early
distributed systems mistakes was to pretend that remote procedure
calls could be reliable and assume errors are rare and could be
pretended to behave like syscalls or local in-process APIs. It has
been recognized many times over how bad such approaches were. It's
outside of the scope of this discussion to go into more details.
Suffice it to say that libbpf is not going to pretend that syscall and
some RPC are equivalent and can be interchangeable in a transparent
way.

And then, even if we were crazy enough to do the above, there is no
way everyone will settle on one single implementation and/or RPC
protocol and API such that libbpf could implement it in its upstream
version. Big companies most probably will go with their own internal
ones that would give them better integration with internal
infrastructure, better overvability, etc. And even in open-source
there probably won't be one single implementation everyone will be
happy with.

>
> -Toke

