Return-Path: <bpf+bounces-1874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B907231CA
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 22:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F071C20988
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 20:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCC3261EC;
	Mon,  5 Jun 2023 20:56:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B618A261C8
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 20:56:56 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF29AF;
	Mon,  5 Jun 2023 13:56:54 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b1af9ef7a9so46734981fa.1;
        Mon, 05 Jun 2023 13:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685998612; x=1688590612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcm0cmOa+vbxMelxJi7kTmNkwlQMN4pFvkTRW9qIazI=;
        b=EZO17p2wHhwVc4HQaxD7w2wvN3mPyboQeXAI2PEkQv5uu1xezRg6853NZgLcCpbOIo
         T/cUIlnMj0QWfndXsWHOjeWFuG/Osl6pOO2Wz72QiS1EFrQfhXZRhb7MaOXmaGs1ZBm3
         zvu0eIu2zB73MlpqWzCBNKl47Rd3d3DJ6JPCxPZOYJJjXQwfVUIf+dIRPVwKPyBpXSWv
         tlaKLA/x/MFMP+lE6/gWCDIBTvO0+HNUK028IQKwO7/6tmE0qqkDztuMKeD+s7/HjTCt
         G9IqClo+DiJZQH0E8n46ZhJP8DEreJrOW14RsFvRT3bJD3zd1Eu0Zn0Mqsv1+1kVYDWD
         7+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685998612; x=1688590612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcm0cmOa+vbxMelxJi7kTmNkwlQMN4pFvkTRW9qIazI=;
        b=XhiESjNSt8B5TzpE8YSmztWm5sQq+WVGfROLW11MARbL24zCQPveR/6iw6vS5LKF2O
         PCgBC0iTboNq3+Z1JnfDqgKb9NeqrfOB7jidTeEQz4VCLKWcibU1VNLKEEY63vTEnDaj
         QsYUpI9fuyaKJqkV2drQvG26LxMa8gRoTsugxvphSb3SiEjfR3DoI2kOCp+EfDdiq32E
         zz0AT8peJNdQovQNGjRJ54ZGmn0wcFpKmqfP1vM3f8AA8SUb3m4YKJjuvenj8Dhz/7xD
         jBn7WVNvsuLELi43HMoOHtmi7THxS9piv5roYRHnjuODBI0qxcaqUSkcB6IndSVHiX3W
         ftvw==
X-Gm-Message-State: AC+VfDx1FlhwTNrieQmQNNWK/H/ARQqLtOQL4rseB3m7gLUW6WQBG+BI
	6M1qWuurFOa/39BxF3JAJ7v6aus3ieFo6a8yGYE=
X-Google-Smtp-Source: ACHHUZ7x+zFB0SQ9cHMrkIit10Vk89NwIrVdAciXQyZzdUlSlcLJq8PMH7O1oKv/U1JJioMb6vxCBu/UZIcABX9pRMQ=
X-Received: by 2002:a2e:994e:0:b0:2b1:eb62:ffc8 with SMTP id
 r14-20020a2e994e000000b002b1eb62ffc8mr264408ljj.6.1685998612127; Mon, 05 Jun
 2023 13:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602150011.1657856-1-andrii@kernel.org> <20230602150011.1657856-2-andrii@kernel.org>
 <ZHqYG3q34nnt99pM@google.com>
In-Reply-To: <ZHqYG3q34nnt99pM@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jun 2023 13:56:40 -0700
Message-ID: <CAEf4BzbRduV=HvJYTKLJUy3twDOrrFq+soVAxMmMK_75KaOUEQ@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next 01/18] bpf: introduce BPF token object
To: Stanislav Fomichev <sdf@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com, 
	luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 2, 2023 at 6:32=E2=80=AFPM Stanislav Fomichev <sdf@google.com> =
wrote:
>
> On 06/02, Andrii Nakryiko wrote:
> > Add new kind of BPF kernel object, BPF token. BPF token is meant to to
> > allow delegating privileged BPF functionality, like loading a BPF
> > program or creating a BPF map, from privileged process to a *trusted*
> > unprivileged process, all while have a good amount of control over whic=
h
> > privileged operation could be done using provided BPF token.
> >
> > This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, which
> > allows to create a new BPF token object along with a set of allowed
> > commands. Currently only BPF_TOKEN_CREATE command itself can be
> > delegated, but other patches gradually add ability to delegate
> > BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.
> >
> > The above means that BPF token creation can be allowed by another
> > existing BPF token, if original privileged creator allowed that. New
> > derived BPF token cannot be more powerful than the original BPF token.
> >
> > BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS flag is added to allow application to d=
o
> > express "all supported BPF commands should be allowed" without worrying
> > about which subset of desired commands is actually supported by
> > potentially outdated kernel. Allowing this semantics doesn't seem to
> > introduce any backwards compatibility issues and doesn't introduce any
> > risk of abusing or misusing bit set field, but makes backwards
> > compatibility story for various applications and tools much more
> > straightforward, making it unnecessary to probe support for each
> > individual possible bit. This is especially useful in follow up patches
> > where we add BPF map types and prog types bit sets.
> >
> > Lastly, BPF token can be pinned in and retrieved from BPF FS, just like
> > progs, maps, BTFs, and links. This allows applications (like container
> > managers) to share BPF token with other applications through file syste=
m
> > just like any other BPF object, and further control access to it using
> > file system permissions, if desired.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h            |  34 +++++++++
> >  include/uapi/linux/bpf.h       |  42 ++++++++++++
> >  kernel/bpf/Makefile            |   2 +-
> >  kernel/bpf/inode.c             |  26 +++++++
> >  kernel/bpf/syscall.c           |  74 ++++++++++++++++++++
> >  kernel/bpf/token.c             | 122 +++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  40 +++++++++++
> >  7 files changed, 339 insertions(+), 1 deletion(-)
> >  create mode 100644 kernel/bpf/token.c
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index f58895830ada..fe6d51c3a5b1 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -51,6 +51,7 @@ struct module;
> >  struct bpf_func_state;
> >  struct ftrace_ops;
> >  struct cgroup;
> > +struct bpf_token;
> >
> >  extern struct idr btf_idr;
> >  extern spinlock_t btf_idr_lock;
> > @@ -1533,6 +1534,12 @@ struct bpf_link_primer {
> >       u32 id;
> >  };
> >
> > +struct bpf_token {
> > +     struct work_struct work;
> > +     atomic64_t refcnt;
> > +     u64 allowed_cmds;
> > +};
> > +
> >  struct bpf_struct_ops_value;
> >  struct btf_member;
> >
> > @@ -2077,6 +2084,15 @@ struct file *bpf_link_new_file(struct bpf_link *=
link, int *reserved_fd);
> >  struct bpf_link *bpf_link_get_from_fd(u32 ufd);
> >  struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
> >
> > +void bpf_token_inc(struct bpf_token *token);
> > +void bpf_token_put(struct bpf_token *token);
> > +struct bpf_token *bpf_token_alloc(void);
> > +int bpf_token_new_fd(struct bpf_token *token);
> > +struct bpf_token *bpf_token_get_from_fd(u32 ufd);
> > +
> > +bool bpf_token_capable(const struct bpf_token *token, int cap);
> > +bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd c=
md);
> > +
> >  int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname=
);
> >  int bpf_obj_get_user(int path_fd, const char __user *pathname, int fla=
gs);
> >
> > @@ -2436,6 +2452,24 @@ static inline int bpf_obj_get_user(const char __=
user *pathname, int flags)
> >       return -EOPNOTSUPP;
> >  }
> >
> > +static inline void bpf_token_inc(struct bpf_token *token)
> > +{
> > +}
> > +
> > +static inline void bpf_token_put(struct bpf_token *token)
> > +{
> > +}
> > +
> > +static inline struct bpf_token *bpf_token_new_fd(struct bpf_token *tok=
en)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +
> > +static inline struct bpf_token *bpf_token_get_from_fd(u32 ufd)
> > +{
> > +     return ERR_PTR(-EOPNOTSUPP);
> > +}
> > +
> >  static inline void __dev_flush(void)
> >  {
> >  }
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 9273c654743c..01ab79f2ad9f 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -846,6 +846,16 @@ union bpf_iter_link_info {
> >   *           Returns zero on success. On error, -1 is returned and *er=
rno*
> >   *           is set appropriately.
> >   *
> > + * BPF_TOKEN_CREATE
> > + *   Description
> > + *           Create BPF token with embedded information about what
> > + *           BPF-related functionality is allowed. This BPF token can =
be
> > + *           passed as an extra parameter to various bpf() syscall com=
mand.
> > + *
> > + *   Return
> > + *           A new file descriptor (a nonnegative integer), or -1 if a=
n
> > + *           error occurred (in which case, *errno* is set appropriate=
ly).
> > + *
> >   * NOTES
> >   *   eBPF objects (maps and programs) can be shared between processes.
> >   *
> > @@ -900,6 +910,7 @@ enum bpf_cmd {
> >       BPF_ITER_CREATE,
> >       BPF_LINK_DETACH,
> >       BPF_PROG_BIND_MAP,
> > +     BPF_TOKEN_CREATE,
> >  };
> >
> >  enum bpf_map_type {
> > @@ -1169,6 +1180,24 @@ enum bpf_link_type {
> >   */
> >  #define BPF_F_KPROBE_MULTI_RETURN    (1U << 0)
> >
> > +/* BPF_TOKEN_CREATE command flags
> > + */
> > +enum {
> > +     /* Ignore unrecognized bits in token_create.allowed_cmds bit set.=
  If
> > +      * this flag is set, kernel won't return -EINVAL for a bit
> > +      * corresponding to a non-existing command or the one that doesn'=
t
> > +      * support BPF token passing. This flags allows application to re=
quest
> > +      * BPF token creation for a desired set of commands without worry=
ing
> > +      * about older kernels not supporting some of the commands.
> > +      * Presumably, deployed applications will do separate feature
> > +      * detection and will avoid calling not-yet-supported bpf() comma=
nds,
> > +      * so this BPF token will work equally well both on older and new=
er
> > +      * kernels, even if some of the requested commands won't be BPF
> > +      * token-enabled.
> > +      */
> > +     BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS           =3D 1U << 0,
> > +};
> > +
> >  /* When BPF ldimm64's insn[0].src_reg !=3D 0 then this can have
> >   * the following extensions:
> >   *
> > @@ -1621,6 +1650,19 @@ union bpf_attr {
> >               __u32           flags;          /* extra flags */
> >       } prog_bind_map;
> >
> > +     struct { /* struct used by BPF_TOKEN_CREATE command */
> > +             __u32           flags;
> > +             __u32           token_fd;
> > +             /* a bit set of allowed bpf() syscall commands,
> > +              * e.g., (1ULL << BPF_TOKEN_CREATE) | (1ULL << BPF_PROG_L=
OAD)
> > +              * will allow creating derived BPF tokens and loading new=
 BPF
> > +              * programs;
> > +              * see also BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS for its effec=
t on
> > +              * validity checking of this set
> > +              */
> > +             __u64           allowed_cmds;
> > +     } token_create;
>
> Do you think this might eventually grow into something like
> "allow only lookup operation for this specific map"? If yes, maybe it

If it was strictly up for me, then no. I think fine-granular and
highly-dynamic restrictions are more the (BPF) LSM domain. In practice
I envision that users will use a combination of BPF token to specify
what BPF functionality can be used by applications in "broad strokes",
e.g., specifying that only networking programs and
ARRAY/HASHMAP/SK_STORAGE maps can be used, but disallow most of
tracing functionality. And then on top of that LSM can be utilized to
provide more nuanced (and as I said, more dynamic) controls over what
operations over BPF map application can perform.

If you look at the final set of token_create parameters, you can see
that I only aim to control and restrict BPF commands that are creating
new BPF objects (BTF, map, prog; we might do similar stuff for links
later, perhaps) only. In that sense BPF token controls "constructors",
while if users want to control operation on BPF objects that were
created (maps and programs, for the most part), I see this a bit
outside of BPF token scope. I also don't think we should do more
fine-grained control of construction parameters. E.g., I think it's
too much to enforce which attach_btf_id can be provided.

It's all code, though, so we could push it in any direction we want,
but in my view BPF token is about a somewhat static prescription of
what bpf() functionality is accessible to the application, broadly.
And LSM can complement it with more dynamic abilities.


> makes sense to separate token-create vs token-add-capability operations?
>
> BPF_TOKEN_CREATE would create a token that can't do anything. Then you
> would call a bunch of BPF_TOKEN_ALLOW with maybe op=3DSYSCALL_CMD
> value=3DBPF_TOKEN_CREATE.
>
> This will be more future-proof plus won't really depend on having a
> bitmask in the uapi. Then the users will be able to handle
> BPF_TOKEN_ALLOW{op=3DSYSCALL_CMD value=3DSOME_VALUE_NOT_SUPPORTED_ON_THIS=
_KERNEL}
> themselves (IOW, BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS won't be needed).

So I very much intentionally wanted to keep the BPF token immutable
once created. This makes it simple to reason about what BPF token
allows and guarantee that it won't change after the fact. It's doable
to make BPF token mutable and then "finalize" it (and BPF_MAP_FREEZE
stands as a good reminder of races and complications such model
introduces), creating a sort of builder pattern APIs, but that seems
like an overkill and unnecessary complication.

But let me address that "more future-proof" part. What about our
binary bpf_attr extensible approach is not future proof? In both cases
we'll have to specify as part of UAPI that there is a possibility to
restrict a set of bpf() syscall commands, right? In one case you'll do
it through multiple syscall invocations, while I chose a
straightforward bit mask. I could have done it as a pointer to an
array of `enum bpf_cmd` items, but I think it's extremely unlikely
we'll get to >64, ever. But even if we do, adding `u64 allowed_cmds2`
doesn't seem like a big deal to me.

The main point though, both approaches are equally extensible. But
making BPF token mutable adds a lot of undesirable (IMO)
complications.


As for BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS, I'm thinking of dropping such
flags for simplicity.

