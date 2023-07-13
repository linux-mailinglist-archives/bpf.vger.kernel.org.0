Return-Path: <bpf+bounces-4974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3570752DCC
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 01:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BA11C214AA
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 23:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105486AA6;
	Thu, 13 Jul 2023 23:09:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0BD6AA2
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 23:09:42 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F555212B
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 16:09:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c64521ac8d6so1071244276.1
        for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 16:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689289776; x=1691881776;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGMZoz6whYjXdqk/wGsV9WkuKG/WAMVqGba2z1MltiQ=;
        b=3bUq5/zJvjRH6b0ngwMiaDvxSSVDZUlwbTsixX2UC58xd7EUNsPXje71ELY6wqDdaL
         PYqMZtniw44BS3YUiH8e1RNcC3yPPeR4saKpR9X0itTxs5T/Jo/U33SlFCEnxehOoVXo
         JPACn5BDJUQvZKVzuf5z8hW2USeTx2at+VPGl/CPlDY2VYSSdPz5gfriGQhFNyAMGX8u
         aje5FQffIJK462WHjQjf07OewqiFwxKQBokIPRT7syTwzcYYxmCUCKXYvIaDwB4R8p1S
         64PEokuaZ9BBmMBZdGGm/8zYCh2VXV1dLv/lGZtqQ0HqxQbvw5E9Mg0LphVcEi0zsHtB
         +bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689289776; x=1691881776;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XGMZoz6whYjXdqk/wGsV9WkuKG/WAMVqGba2z1MltiQ=;
        b=CUOYUAW5J9xs5CCCvu3U7T865m8XgEfE7q/juBcjoxCT3mSZ4Z/n+YF8Ujs5EBPCzx
         AdcoNbw/yz63JRQOuYbcnuVCRlW54zMJCDVR5L0/ZcREkjIA6hPhhoAvQhDjdJCxraNr
         A6X1ymu6DNbcsj8gfd7NYYs0ydYrgkZJP0IIDFc3byVdSJl7XeYO/6DSj3Q26paFMjfn
         vcsRZWZJSYIGCaV79hoR+04W2CkAh8YdiZxVjdvGU3189/yL0m6tlooHenWZhSOmTKqe
         k23pKja8PMiBpE57If5/RynPoGnyGnJ0zqkmzgma/M5vDU7kkLCVWheMYreyecvJ65ka
         21Yw==
X-Gm-Message-State: ABy/qLZULsjiB10rRcQvvzXegpvsDefZDxJNuGA2H+RwCJlmwpIZvjGJ
	o8pHt82WF4Hen9VhUFDvsO+RuhE=
X-Google-Smtp-Source: APBJJlERmRex7eNmfCjJjc2VoMprsGKtNh740qIDq+wwpm66k3aLooXQbx+grL5ZuyUJPmPik91nJ2s=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:ca57:0:b0:c67:632d:d55b with SMTP id
 a84-20020a25ca57000000b00c67632dd55bmr15504ybg.8.1689289776386; Thu, 13 Jul
 2023 16:09:36 -0700 (PDT)
Date: Thu, 13 Jul 2023 16:09:34 -0700
In-Reply-To: <CAADnVQ+aPyWea4QUD9TFNpr43u052zuqOXzGaqmM8-EeMrW6rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1688616142.git.geliang.tang@suse.com> <ZKbzs7foUw+eeNnn@google.com>
 <20230713054716.GA18806@localhost.localdomain> <ZLAxAc1/UXcbIJBo@google.com> <CAADnVQ+aPyWea4QUD9TFNpr43u052zuqOXzGaqmM8-EeMrW6rg@mail.gmail.com>
Message-ID: <ZLCELtTGksxGwaFZ@google.com>
Subject: Re: [RFC bpf-next 0/8] BPF 'force to MPTCP'
From: Stanislav Fomichev <sdf@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Geliang Tang <geliang.tang@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/13, Alexei Starovoitov wrote:
> On Thu, Jul 13, 2023 at 10:14=E2=80=AFAM Stanislav Fomichev <sdf@google.c=
om> wrote:
> >
> > On 07/13, Geliang Tang wrote:
> > > On Thu, Jul 06, 2023 at 10:02:43AM -0700, Stanislav Fomichev wrote:
> > > > On 07/06, Geliang Tang wrote:
> > > > > As is described in the "How to use MPTCP?" section in MPTCP wiki =
[1]:
> > > > >
> > > > > "Your app can create sockets with IPPROTO_MPTCP as the proto:
> > > > > ( socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); ). Legacy apps can=
 be
> > > > > forced to create and use MPTCP sockets instead of TCP ones via th=
e
> > > > > mptcpize command bundled with the mptcpd daemon."
> > > > >
> > > > > But the mptcpize (LD_PRELOAD technique) command has some limitati=
ons
> > > > > [2]:
> > > > >
> > > > >  - it doesn't work if the application is not using libc (e.g. GoL=
ang
> > > > > apps)
> > > > >  - in some envs, it might not be easy to set env vars / change th=
e way
> > > > > apps are launched, e.g. on Android
> > > > >  - mptcpize needs to be launched with all apps that want MPTCP: w=
e could
> > > > > have more control from BPF to enable MPTCP only for some apps or =
all the
> > > > > ones of a netns or a cgroup, etc.
> > > > >  - it is not in BPF, we cannot talk about it at netdev conf.
> > > > >
> > > > > So this patchset attempts to use BPF to implement functions simil=
er to
> > > > > mptcpize.
> > > > >
> > > > > The main idea is add a hook in sys_socket() to change the protoco=
l id
> > > > > from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.
> > > > >
> > > > > 1. This first solution [3] is using "cgroup/sock_create":
> > > > >
> > > > > Implement a new helper bpf_mptcpify() to change the protocol id:
> > > > >
> > > > > +BPF_CALL_1(bpf_mptcpify, struct sock *, sk)
> > > > > +{
> > > > > + if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP=
) {
> > > > > +         sk->sk_protocol =3D IPPROTO_MPTCP;
> > > > > +         return (unsigned long)sk;
> > > > > + }
> > > > > +
> > > > > + return (unsigned long)NULL;
> > > > > +}
> > > > > +
> > > > > +const struct bpf_func_proto bpf_mptcpify_proto =3D {
> > > > > + .func           =3D bpf_mptcpify,
> > > > > + .gpl_only       =3D false,
> > > > > + .ret_type       =3D RET_PTR_TO_BTF_ID_OR_NULL,
> > > > > + .ret_btf_id     =3D &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
> > > > > + .arg1_type      =3D ARG_PTR_TO_CTX,
> > > > > +};
> > > > >
> > > > > Add a hook in "cgroup/sock_create" section, invoking bpf_mptcpify=
()
> > > > > helper in this hook:
> > > > >
> > > > > +SEC("cgroup/sock_create")
> > > > > +int sock(struct bpf_sock *ctx)
> > > > > +{
> > > > > + struct sock *sk;
> > > > > +
> > > > > + if (ctx->type !=3D SOCK_STREAM)
> > > > > +         return 1;
> > > > > +
> > > > > + sk =3D bpf_mptcpify(ctx);
> > > > > + if (!sk)
> > > > > +         return 1;
> > > > > +
> > > > > + protocol =3D sk->sk_protocol;
> > > > > + return 1;
> > > > > +}
> > > > >
> > > > > But this solution doesn't work, because the sock_create section i=
s
> > > > > hooked at the end of inet_create(). It's too late to change the p=
rotocol
> > > > > id.
> > > > >
> > > > > 2. The second solution [4] is using "fentry":
> > > > >
> > > > > Implement a bpf_mptcpify() helper:
> > > > >
> > > > > +BPF_CALL_1(bpf_mptcpify, struct socket_args *, args)
> > > > > +{
> > > > > + if (args->family =3D=3D AF_INET &&
> > > > > +     args->type =3D=3D SOCK_STREAM &&
> > > > > +     (!args->protocol || args->protocol =3D=3D IPPROTO_TCP))
> > > > > +         args->protocol =3D IPPROTO_MPTCP;
> > > > > +
> > > > > + return 0;
> > > > > +}
> > > > > +
> > > > > +BTF_ID_LIST(bpf_mptcpify_btf_ids)
> > > > > +BTF_ID(struct, socket_args)
> > > > > +
> > > > > +static const struct bpf_func_proto bpf_mptcpify_proto =3D {
> > > > > + .func           =3D bpf_mptcpify,
> > > > > + .gpl_only       =3D false,
> > > > > + .ret_type       =3D RET_INTEGER,
> > > > > + .arg1_type      =3D ARG_PTR_TO_BTF_ID,
> > > > > + .arg1_btf_id    =3D &bpf_mptcpify_btf_ids[0],
> > > > > +};
> > > > >
> > > > > Add a new wrapper socket_create() in sys_socket() path, passing a
> > > > > pointer of struct socket_args (int family; int type; int protocol=
) to
> > > > > the wrapper.
> > > > >
> > > > > +int socket_create(struct socket_args *args, struct socket **res)
> > > > > +{
> > > > > + return sock_create(args->family, args->type, args->protocol, re=
s);
> > > > > +}
> > > > > +EXPORT_SYMBOL(socket_create);
> > > > > +
> > > > >  /**
> > > > >   *       sock_create_kern - creates a socket (kernel space)
> > > > >   *       @net: net namespace
> > > > > @@ -1608,6 +1614,7 @@  EXPORT_SYMBOL(sock_create_kern);
> > > > >
> > > > >  static struct socket *__sys_socket_create(int family, int type, =
int protocol)
> > > > >  {
> > > > > + struct socket_args args =3D { 0 };
> > > > >   struct socket *sock;
> > > > >   int retval;
> > > > >
> > > > > @@ -1621,7 +1628,10 @@  static struct socket *__sys_socket_create=
(int family, int type, int protocol)
> > > > >           return ERR_PTR(-EINVAL);
> > > > >   type &=3D SOCK_TYPE_MASK;
> > > > >
> > > > > - retval =3D sock_create(family, type, protocol, &sock);
> > > > > + args.family =3D family;
> > > > > + args.type =3D type;
> > > > > + args.protocol =3D protocol;
> > > > > + retval =3D socket_create(&args, &sock);
> > > > >   if (retval < 0)
> > > > >           return ERR_PTR(retval);
> > > > >
> > > > > Add "fentry" hook to the newly added wrapper, invoking bpf_mptcpi=
fy()
> > > > > in the hook:
> > > > >
> > > > > +SEC("fentry/socket_create")
> > > > > +int BPF_PROG(trace_socket_create, void *args,
> > > > > +         struct socket **res)
> > > > > +{
> > > > > + bpf_mptcpify(args);
> > > > > + return 0;
> > > > > +}
> > > > >
> > > > > This version works. But it's just a work around version. Since th=
e code
> > > > > to add a wrapper to sys_socket() is not very elegant indeed, and =
it
> > > > > shouldn't be accepted by upstream.
> > > > >
> > > > > 3. The last solution is this patchset itself:
> > > > >
> > > > > Introduce new program type BPF_PROG_TYPE_CGROUP_SOCKINIT and atta=
ch type
> > > > > BPF_CGROUP_SOCKINIT on cgroup basis.
> > > > >
> > > > > Define BPF_CGROUP_RUN_PROG_SOCKINIT() helper, and implement
> > > > > __cgroup_bpf_run_sockinit() helper to run a sockinit program:
> > > > >
> > > > > +#define BPF_CGROUP_RUN_PROG_SOCKINIT(family, type, protocol)    =
                \
> > > > > +({                                                              =
                \
> > > > > + int __ret =3D 0;                                               =
          \
> > > > > + if (cgroup_bpf_enabled(CGROUP_SOCKINIT))                       =
        \
> > > > > +         __ret =3D __cgroup_bpf_run_sockinit(family, type, proto=
col,      \
> > > > > +                                           CGROUP_SOCKINIT);    =
        \
> > > > > + __ret;                                                         =
        \
> > > > > +})
> > > > > +
> > > > >
> > > > > Invoke BPF_CGROUP_RUN_PROG_SOCKINIT() in __socket_create() to cha=
nge
> > > > > the arguments:
> > > > >
> > > > > @@ -1469,6 +1469,12 @@  int __sock_create(struct net *net, int fa=
mily, int type, int protocol,
> > > > >   struct socket *sock;
> > > > >   const struct net_proto_family *pf;
> > > > >
> > > > > + if (!kern) {
> > > > > +         err =3D BPF_CGROUP_RUN_PROG_SOCKINIT(&family, &type, &p=
rotocol);
> > > > > +         if (err)
> > > > > +                 return err;
> > > > > + }
> > > > > +
> > > > >   /*
> > > > >    *      Check protocol is in range
> > > > >    */
> > > > >
> > > > > Define BPF program in this newly added 'sockinit' SEC, so it will=
 be
> > > > > hooked in BPF_CGROUP_RUN_PROG_SOCKINIT() in __socket_create().
> > > > >
> > > > > @@ -158,6 +158,11 @@  static struct sec_name_test tests[] =3D {
> > > > >           {0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT=
},
> > > > >           {0, BPF_CGROUP_SETSOCKOPT},
> > > > >   },
> > > > > + {
> > > > > +         "cgroup/sockinit",
> > > > > +         {0, BPF_PROG_TYPE_CGROUP_SOCKINIT, BPF_CGROUP_SOCKINIT}=
,
> > > > > +         {0, BPF_CGROUP_SOCKINIT},
> > > > > + },
> > > > >  };
> > > > >
> > > > > +SEC("cgroup/sockinit")
> > > > > +int mptcpify(struct bpf_sockinit_ctx *ctx)
> > > > > +{
> > > > > + if ((ctx->family =3D=3D AF_INET || ctx->family =3D=3D AF_INET6)=
 &&
> > > > > +     ctx->type =3D=3D SOCK_STREAM &&
> > > > > +     (!ctx->protocol || ctx->protocol =3D=3D IPPROTO_TCP)) {
> > > > > +         ctx->protocol =3D IPPROTO_MPTCP;
> > > > > + }
> > > > > +
> > > > > + return 1;
> > > > > +}
> > > > >
> > > > > This version is the best solution we have found so far.
> > > > >
> > > > > [1]
> > > > > https://github.com/multipath-tcp/mptcp_net-next/wiki
> > > > > [2]
> > > > > https://github.com/multipath-tcp/mptcp_net-next/issues/79
> > > > > [3]
> > > > > https://patchwork.kernel.org/project/mptcp/cover/cover.1688215769=
.git.geliang.tang@suse.com/
> > > > > [4]
> > > > > https://patchwork.kernel.org/project/mptcp/cover/cover.1688366249=
.git.geliang.tang@suse.com/
> > > >
> > > > cgroup/sock_create being weird and triggering late and only for af_=
inet4/6
> > > > was the reason we added ability to attach to lsm hooks on a per-cgr=
oup
> > > > basis:
> > > > https://lore.kernel.org/bpf/20220628174314.1216643-1-sdf@google.com=
/
> > > >
> > > > Unfortunately, using it here won't help either :-( The following
> > > > hook triggers early enough but doesn't allow changing the arguments=
 (I was
> > > > interested only in filtering based on the arguments, not changing t=
hem):
> > > >
> > > > LSM_HOOK(int, 0, socket_create, int family, int type, int protocol,=
 int kern)
> > > >
> > > > So maybe another alternative might be to change its definition to i=
nt *family,
> > > > int *type, int *protocol and use lsm_cgroup/socket_create to rewrit=
e the
> > >
> > > Thanks Stanislav, this lsm_cgroup/socket_create works. The test patch
> > > is attached.
> > >
> > > > protocol? (some verifier changes might needed to make those writabl=
e)
> > >
> > > But I got some verification errors here:
> > >
> > >    invalid mem access 'scalar'.
> > >
> > > I tried many times but couldn't solve it, so I simply skipped the
> > > verifier in the test patch (I marked TODO in front of this code).
> > > Could you please give me some suggestions for verification?
> >
> > Right, that's the core issue here, to add support to the verifier
> > to let it write into scalar pointer arguments. I don't have a good sugg=
estion,
> > but we've discussed it multiple times elsewhere that maybe we
> > should do it :-)
> >
> > Can we use some new btf_type_tag("allow_write") to annotate places
> > where we know that it's safe to write to them? Then we can extend
> > the verifier to check for this condition hopefully. Maybe other BPF
> > folks have better suggestions here?
> >
> > We should also CC LSM people to make sure it's not a no-no to
> > change LSM_HOOK(s) in a way to allow changing the arguments. I'm
> > not sure how rigid those definitions are :-(
>=20
> imo all 3 options including this 4th one are too hacky.
> I understand ld_preload limitations and desire to have it per-cgroup,
> but messing this much with user space feels a little bit too much.
> What side effects will it cause?

Maybe all that is really needed is some new per-netns sysctl to automatical=
ly
upgrade from IPPROTO_TCP to IPPROTO_MPTCP? Or is it too broad of a
brush?

I've also CC'd netdev for visibility...

> Meaning is this enough to just change the proto?
> Nothing in user space later on needs to be aware the protocol is so diffe=
rent?

IIUC, if you use IPPROTO_MPTCP, you just get regular TCP until you start
adding extra routes (via netlink). That's why their current
unconditional IPPROTO_TCP->IPPROTO_MPTCP rewrite via ld_preload also somewh=
at
works.

> I feel the consequences are too drastic to support such thing
> through an official/stable hook.
> We can consider an fmod_ret unstable hook somewhere in the kernel
> that bpf prog can attach to and tweak the ret value and/or args,
> but the production environment won't be using it.
> It will be a temporary gap until user space is properly converted to mptc=
p.

Asking every app to do s/IPPROTO_TCP/IPPROTO_MPTCP/ might be annoying
though? (don't have a horse in this race, but have some v4->v6 migration
vibes from this)

