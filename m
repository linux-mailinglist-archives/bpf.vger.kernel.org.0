Return-Path: <bpf+bounces-1942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0A07249A3
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 18:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A45128100F
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3954D1ED34;
	Tue,  6 Jun 2023 16:58:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF86119915
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 16:58:50 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC7B10F4
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 09:58:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-568ab5c813eso102950137b3.2
        for <bpf@vger.kernel.org>; Tue, 06 Jun 2023 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686070727; x=1688662727;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxXSwvh87fVVIhfSjNLF8UyXQRGaNi74ONwzpf4bwMM=;
        b=qFAYxcnk8byARJC4uTsoR7G0We1lTvYHUb/qKtz8jrbkt6YNWhWxjJi6k8gtgvDgm0
         CClRP7Uvd5ZhPg8hIoFE6+knKbcsTxMU3AbC57fpyTDNa6HW2wTuxBNkVgzMqfAiQuIg
         z1vpnlzRois2a/4z6L0RY7pMpXApJwaOO3FG2tmMvvnQrwHtcfq5rAuMA+VbkR33x4uE
         NkpucN+DSh4OFv4UVGt6JXJDSvKIel3spn18d3VP/JZqZSp7gj5kW8XTdUDuLPQkPY9o
         smKylSWhnSwOKGCCmyBV6CrmajXi/XS65DjiMDNwDi7cRPUFztpinPHa/CyEbalw2B8f
         hRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686070727; x=1688662727;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hxXSwvh87fVVIhfSjNLF8UyXQRGaNi74ONwzpf4bwMM=;
        b=lbCJy7Btp2MLJwhsxwj9Bel1XaaSOgL/C2h0CI5WTu0ihnJI4TE7lbRJA+Uw8wLTxo
         zvSCwHFCUHEVnKsbmhhzS/arKm4JbXcun/TQYjxDMtQLT8JYsXXxbGVmZ4FeO1FCnGOV
         0vBgPmODlSfgI+zrj9AspQsdl/S8v9hWrS2ZguUzHjXqGUgiGyY9p29uelk6p9iT0raQ
         3TnOsCDnUeKxlg3r0GNgCDZRwTM37lSWztFgHGozrmJu2qH2sDV9P98MhaDjoqEPexwy
         J8LrLveOeFip92gKahoXwzPfpmcpM5teNL896n0ikE0B4e5NGI2t4hZUFlnGmCrjob8R
         wTyA==
X-Gm-Message-State: AC+VfDxtr3ZLoRWMCXMU1siXhpI44Fm3HQR7v5lQJYE7AvXJtkRanL1u
	SlcZ0ZK17g0HCU64tLyuK4XsKjU=
X-Google-Smtp-Source: ACHHUZ7DSB66JIJPlEXF465gPDpTgEBltIe0DJ/8BvSi4Dagj1QEkm4ZE+6glYx4siB4DCOGp1mcNQY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:ac4a:0:b0:55d:ea61:d8e9 with SMTP id
 z10-20020a81ac4a000000b0055dea61d8e9mr1346441ywj.7.1686070727459; Tue, 06 Jun
 2023 09:58:47 -0700 (PDT)
Date: Tue, 6 Jun 2023 09:58:45 -0700
In-Reply-To: <CAEf4BzbHv5NrmteDiNe4sGHKR1N04Fc+t=EQuZYLkzTrBAbRNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230602150011.1657856-1-andrii@kernel.org> <20230602150011.1657856-2-andrii@kernel.org>
 <ZHqYG3q34nnt99pM@google.com> <CAEf4BzbRduV=HvJYTKLJUy3twDOrrFq+soVAxMmMK_75KaOUEQ@mail.gmail.com>
 <ZH5YEMS4Cu3DJVBJ@google.com> <CAEf4BzbHv5NrmteDiNe4sGHKR1N04Fc+t=EQuZYLkzTrBAbRNg@mail.gmail.com>
Message-ID: <ZH9lxfqhzZ8iR+rl@google.com>
Subject: Re: [PATCH RESEND bpf-next 01/18] bpf: introduce BPF token object
From: Stanislav Fomichev <sdf@google.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com, 
	luto@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06/05, Andrii Nakryiko wrote:
> On Mon, Jun 5, 2023 at 2:48=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
> >
> > On 06/05, Andrii Nakryiko wrote:
> > > On Fri, Jun 2, 2023 at 6:32=E2=80=AFPM Stanislav Fomichev <sdf@google=
.com> wrote:
> > > >
> > > > On 06/02, Andrii Nakryiko wrote:
> > > > > Add new kind of BPF kernel object, BPF token. BPF token is meant =
to to
> > > > > allow delegating privileged BPF functionality, like loading a BPF
> > > > > program or creating a BPF map, from privileged process to a *trus=
ted*
> > > > > unprivileged process, all while have a good amount of control ove=
r which
> > > > > privileged operation could be done using provided BPF token.
> > > > >
> > > > > This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, wh=
ich
> > > > > allows to create a new BPF token object along with a set of allow=
ed
> > > > > commands. Currently only BPF_TOKEN_CREATE command itself can be
> > > > > delegated, but other patches gradually add ability to delegate
> > > > > BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.
> > > > >
> > > > > The above means that BPF token creation can be allowed by another
> > > > > existing BPF token, if original privileged creator allowed that. =
New
> > > > > derived BPF token cannot be more powerful than the original BPF t=
oken.
> > > > >
> > > > > BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS flag is added to allow applicatio=
n to do
> > > > > express "all supported BPF commands should be allowed" without wo=
rrying
> > > > > about which subset of desired commands is actually supported by
> > > > > potentially outdated kernel. Allowing this semantics doesn't seem=
 to
> > > > > introduce any backwards compatibility issues and doesn't introduc=
e any
> > > > > risk of abusing or misusing bit set field, but makes backwards
> > > > > compatibility story for various applications and tools much more
> > > > > straightforward, making it unnecessary to probe support for each
> > > > > individual possible bit. This is especially useful in follow up p=
atches
> > > > > where we add BPF map types and prog types bit sets.
> > > > >
> > > > > Lastly, BPF token can be pinned in and retrieved from BPF FS, jus=
t like
> > > > > progs, maps, BTFs, and links. This allows applications (like cont=
ainer
> > > > > managers) to share BPF token with other applications through file=
 system
> > > > > just like any other BPF object, and further control access to it =
using
> > > > > file system permissions, if desired.
> > > > >
> > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > ---
> > > > >  include/linux/bpf.h            |  34 +++++++++
> > > > >  include/uapi/linux/bpf.h       |  42 ++++++++++++
> > > > >  kernel/bpf/Makefile            |   2 +-
> > > > >  kernel/bpf/inode.c             |  26 +++++++
> > > > >  kernel/bpf/syscall.c           |  74 ++++++++++++++++++++
> > > > >  kernel/bpf/token.c             | 122 +++++++++++++++++++++++++++=
++++++
> > > > >  tools/include/uapi/linux/bpf.h |  40 +++++++++++
> > > > >  7 files changed, 339 insertions(+), 1 deletion(-)
> > > > >  create mode 100644 kernel/bpf/token.c
> > > > >
> > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > index f58895830ada..fe6d51c3a5b1 100644
> > > > > --- a/include/linux/bpf.h
> > > > > +++ b/include/linux/bpf.h
> > > > > @@ -51,6 +51,7 @@ struct module;
> > > > >  struct bpf_func_state;
> > > > >  struct ftrace_ops;
> > > > >  struct cgroup;
> > > > > +struct bpf_token;
> > > > >
> > > > >  extern struct idr btf_idr;
> > > > >  extern spinlock_t btf_idr_lock;
> > > > > @@ -1533,6 +1534,12 @@ struct bpf_link_primer {
> > > > >       u32 id;
> > > > >  };
> > > > >
> > > > > +struct bpf_token {
> > > > > +     struct work_struct work;
> > > > > +     atomic64_t refcnt;
> > > > > +     u64 allowed_cmds;
> > > > > +};
> > > > > +
> > > > >  struct bpf_struct_ops_value;
> > > > >  struct btf_member;
> > > > >
> > > > > @@ -2077,6 +2084,15 @@ struct file *bpf_link_new_file(struct bpf_=
link *link, int *reserved_fd);
> > > > >  struct bpf_link *bpf_link_get_from_fd(u32 ufd);
> > > > >  struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
> > > > >
> > > > > +void bpf_token_inc(struct bpf_token *token);
> > > > > +void bpf_token_put(struct bpf_token *token);
> > > > > +struct bpf_token *bpf_token_alloc(void);
> > > > > +int bpf_token_new_fd(struct bpf_token *token);
> > > > > +struct bpf_token *bpf_token_get_from_fd(u32 ufd);
> > > > > +
> > > > > +bool bpf_token_capable(const struct bpf_token *token, int cap);
> > > > > +bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf=
_cmd cmd);
> > > > > +
> > > > >  int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pa=
thname);
> > > > >  int bpf_obj_get_user(int path_fd, const char __user *pathname, i=
nt flags);
> > > > >
> > > > > @@ -2436,6 +2452,24 @@ static inline int bpf_obj_get_user(const c=
har __user *pathname, int flags)
> > > > >       return -EOPNOTSUPP;
> > > > >  }
> > > > >
> > > > > +static inline void bpf_token_inc(struct bpf_token *token)
> > > > > +{
> > > > > +}
> > > > > +
> > > > > +static inline void bpf_token_put(struct bpf_token *token)
> > > > > +{
> > > > > +}
> > > > > +
> > > > > +static inline struct bpf_token *bpf_token_new_fd(struct bpf_toke=
n *token)
> > > > > +{
> > > > > +     return -EOPNOTSUPP;
> > > > > +}
> > > > > +
> > > > > +static inline struct bpf_token *bpf_token_get_from_fd(u32 ufd)
> > > > > +{
> > > > > +     return ERR_PTR(-EOPNOTSUPP);
> > > > > +}
> > > > > +
> > > > >  static inline void __dev_flush(void)
> > > > >  {
> > > > >  }
> > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > > index 9273c654743c..01ab79f2ad9f 100644
> > > > > --- a/include/uapi/linux/bpf.h
> > > > > +++ b/include/uapi/linux/bpf.h
> > > > > @@ -846,6 +846,16 @@ union bpf_iter_link_info {
> > > > >   *           Returns zero on success. On error, -1 is returned a=
nd *errno*
> > > > >   *           is set appropriately.
> > > > >   *
> > > > > + * BPF_TOKEN_CREATE
> > > > > + *   Description
> > > > > + *           Create BPF token with embedded information about wh=
at
> > > > > + *           BPF-related functionality is allowed. This BPF toke=
n can be
> > > > > + *           passed as an extra parameter to various bpf() sysca=
ll command.
> > > > > + *
> > > > > + *   Return
> > > > > + *           A new file descriptor (a nonnegative integer), or -=
1 if an
> > > > > + *           error occurred (in which case, *errno* is set appro=
priately).
> > > > > + *
> > > > >   * NOTES
> > > > >   *   eBPF objects (maps and programs) can be shared between proc=
esses.
> > > > >   *
> > > > > @@ -900,6 +910,7 @@ enum bpf_cmd {
> > > > >       BPF_ITER_CREATE,
> > > > >       BPF_LINK_DETACH,
> > > > >       BPF_PROG_BIND_MAP,
> > > > > +     BPF_TOKEN_CREATE,
> > > > >  };
> > > > >
> > > > >  enum bpf_map_type {
> > > > > @@ -1169,6 +1180,24 @@ enum bpf_link_type {
> > > > >   */
> > > > >  #define BPF_F_KPROBE_MULTI_RETURN    (1U << 0)
> > > > >
> > > > > +/* BPF_TOKEN_CREATE command flags
> > > > > + */
> > > > > +enum {
> > > > > +     /* Ignore unrecognized bits in token_create.allowed_cmds bi=
t set.  If
> > > > > +      * this flag is set, kernel won't return -EINVAL for a bit
> > > > > +      * corresponding to a non-existing command or the one that =
doesn't
> > > > > +      * support BPF token passing. This flags allows application=
 to request
> > > > > +      * BPF token creation for a desired set of commands without=
 worrying
> > > > > +      * about older kernels not supporting some of the commands.
> > > > > +      * Presumably, deployed applications will do separate featu=
re
> > > > > +      * detection and will avoid calling not-yet-supported bpf()=
 commands,
> > > > > +      * so this BPF token will work equally well both on older a=
nd newer
> > > > > +      * kernels, even if some of the requested commands won't be=
 BPF
> > > > > +      * token-enabled.
> > > > > +      */
> > > > > +     BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS           =3D 1U << 0,
> > > > > +};
> > > > > +
> > > > >  /* When BPF ldimm64's insn[0].src_reg !=3D 0 then this can have
> > > > >   * the following extensions:
> > > > >   *
> > > > > @@ -1621,6 +1650,19 @@ union bpf_attr {
> > > > >               __u32           flags;          /* extra flags */
> > > > >       } prog_bind_map;
> > > > >
> > > > > +     struct { /* struct used by BPF_TOKEN_CREATE command */
> > > > > +             __u32           flags;
> > > > > +             __u32           token_fd;
> > > > > +             /* a bit set of allowed bpf() syscall commands,
> > > > > +              * e.g., (1ULL << BPF_TOKEN_CREATE) | (1ULL << BPF_=
PROG_LOAD)
> > > > > +              * will allow creating derived BPF tokens and loadi=
ng new BPF
> > > > > +              * programs;
> > > > > +              * see also BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS for its=
 effect on
> > > > > +              * validity checking of this set
> > > > > +              */
> > > > > +             __u64           allowed_cmds;
> > > > > +     } token_create;
> > > >
> > > > Do you think this might eventually grow into something like
> > > > "allow only lookup operation for this specific map"? If yes, maybe =
it
> > >
> > > If it was strictly up for me, then no. I think fine-granular and
> > > highly-dynamic restrictions are more the (BPF) LSM domain. In practic=
e
> > > I envision that users will use a combination of BPF token to specify
> > > what BPF functionality can be used by applications in "broad strokes"=
,
> > > e.g., specifying that only networking programs and
> > > ARRAY/HASHMAP/SK_STORAGE maps can be used, but disallow most of
> > > tracing functionality. And then on top of that LSM can be utilized to
> > > provide more nuanced (and as I said, more dynamic) controls over what
> > > operations over BPF map application can perform.
> >
> > In this case, why not fully embrace lsm here?
> >
> > Maybe all we really need is:
> > - a BPF_TOKEN_CREATE command (without any granularity)
> > - a holder of the token (passed as you're suggesting, via new uapi
> >   field) would be equivalent to capable(CAP_BPF)
> > - security_bpf() will provide fine-grained control
> > - extend landlock to provide coarse-grained policy (and later
> >   finer granularity)
> >
> > ?
>=20
> That's one option, yes. But I got the feeling at LSF/MM/BPF that
> people are worried about having a BPF token that allows the entire
> bpf() syscall with no control. I think this coarse-grained control
> strikes a reasonable and pragmatic balance, but I'm open to just going
> all in. :)

Sg, let's see what the rest of the folks think.

> > Or we still want the token to carry the policy somehow? (why? because
> > of the filesystem pinning?)
>=20
> I think it's nice to be able to say "this application can only do
> networking programs and no fancy data structures" with purely BPF
> token, with no BPF LSM involved. Or on the other hand, "just tracing,
> no networking" for another class of programs.
>=20
> LSM and BPF LSM is definitely a more logistical hurdle, so if it can
> be avoided in some scenarios, that seems like a win.

Agreed, although it's pretty hard to define what networking program
really is nowadays. Our networking programs have a bunch of tracepoints
in them. That's why I'm a bit tilting towards pushing all this policy
stuff to lsm.

> > > If you look at the final set of token_create parameters, you can see
> > > that I only aim to control and restrict BPF commands that are creatin=
g
> > > new BPF objects (BTF, map, prog; we might do similar stuff for links
> > > later, perhaps) only. In that sense BPF token controls "constructors"=
,
> > > while if users want to control operation on BPF objects that were
> > > created (maps and programs, for the most part), I see this a bit
> > > outside of BPF token scope. I also don't think we should do more
> > > fine-grained control of construction parameters. E.g., I think it's
> > > too much to enforce which attach_btf_id can be provided.
> > >
> > > It's all code, though, so we could push it in any direction we want,
> > > but in my view BPF token is about a somewhat static prescription of
> > > what bpf() functionality is accessible to the application, broadly.
> > > And LSM can complement it with more dynamic abilities.
> >
> > Are you planning to follow up with the other, non-constructing commands=
?
> > Somebody here recently was proposing to namespacify CAP_BPF, something
> > like a read-only-capable token should, in theory, solve it?
>=20
> Maybe for LINK_CREATE. Most other commands are already unprivileged
> and rely on FD (prog, map, link) availability as a proof of being able
> to work with that object. GET_FD_BY_ID is another candidate for BPF
> token, but I wanted to get real production feedback before making
> exact decisions here.

Yeah, I was mostly talking about GET_FD_BY_ID, let's follow up
separately.

>=20
> >
> > > > makes sense to separate token-create vs token-add-capability operat=
ions?
> > > >
> > > > BPF_TOKEN_CREATE would create a token that can't do anything. Then =
you
> > > > would call a bunch of BPF_TOKEN_ALLOW with maybe op=3DSYSCALL_CMD
> > > > value=3DBPF_TOKEN_CREATE.
> > > >
> > > > This will be more future-proof plus won't really depend on having a
> > > > bitmask in the uapi. Then the users will be able to handle
> > > > BPF_TOKEN_ALLOW{op=3DSYSCALL_CMD value=3DSOME_VALUE_NOT_SUPPORTED_O=
N_THIS_KERNEL}
> > > > themselves (IOW, BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS won't be needed).
> > >
> > > So I very much intentionally wanted to keep the BPF token immutable
> > > once created. This makes it simple to reason about what BPF token
> > > allows and guarantee that it won't change after the fact. It's doable
> > > to make BPF token mutable and then "finalize" it (and BPF_MAP_FREEZE
> > > stands as a good reminder of races and complications such model
> > > introduces), creating a sort of builder pattern APIs, but that seems
> > > like an overkill and unnecessary complication.
> > >
> > > But let me address that "more future-proof" part. What about our
> > > binary bpf_attr extensible approach is not future proof? In both case=
s
> > > we'll have to specify as part of UAPI that there is a possibility to
> > > restrict a set of bpf() syscall commands, right? In one case you'll d=
o
> > > it through multiple syscall invocations, while I chose a
> > > straightforward bit mask. I could have done it as a pointer to an
> > > array of `enum bpf_cmd` items, but I think it's extremely unlikely
> > > we'll get to >64, ever. But even if we do, adding `u64 allowed_cmds2`
> > > doesn't seem like a big deal to me.
> > >
> > > The main point though, both approaches are equally extensible. But
> > > making BPF token mutable adds a lot of undesirable (IMO)
> > > complications.
> > >
> > >
> > > As for BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS, I'm thinking of dropping such
> > > flags for simplicity.
> >
> > Ack, I just hope we're not inventing another landlock here. As mentione=
d
> > above, maybe doing simple BPF_TOKEN_CREATE + pushing the rest of the
> > policy into lsm/landlock is a good alternative, idk.
>=20
> The biggest blocker today is incompatibility of BPF usage with user
> namespaces. Having a simple BPF token would allow us to make progress
> here. The rest is just something to strike a balance with, yep.

