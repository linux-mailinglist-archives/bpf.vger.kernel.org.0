Return-Path: <bpf+bounces-1883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ABE723286
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 23:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39DD1C20DC2
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 21:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1D62770F;
	Mon,  5 Jun 2023 21:48:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85CBE59
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 21:48:05 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBD5FA
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 14:48:02 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-653a1cfb819so1158575b3a.0
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 14:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686001682; x=1688593682;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXqordBSW+E72Vv5K7Ik5RKi6aviC88JG4PkHgz/XIc=;
        b=Ui2kmnvTJ+ZzfVBXi1SZcRLYIQR7aETrrYD7EQEsxOSyWoGXVFvnhaqkE7Xn11Pw96
         iWxLX72uluE+Q1XMoOEFA6EPVTRzDlR0S5WI258n42O9nfIlufpKm9sIkoBTtZ2ujijd
         5N5qZztt67EWQ4usOMlegX7IJeob73A20oKsEM5g0ogeoI5KBp0i8zgf7tfwPsttln8f
         wi7cLSTPhtjXsD2dy8IN9oX6PX+5h6MrFrbJaNcIsnD45PTbORGxp8Fu3TNpzpoA7apk
         MmCdkWozrEqmstIrhQo+9jM2JwA44DLK6DN4GSy3gd+X1NVJkQZXG8xx7yjn1alygtbi
         IYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686001682; x=1688593682;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hXqordBSW+E72Vv5K7Ik5RKi6aviC88JG4PkHgz/XIc=;
        b=YaU+2OZzEyzgVdTAr9RG7WZ3NUHx3eYUWtfmi/DRBoB4u/vxvvJw0Se3KPFLONl2tI
         RKGmq/BrwFD7wBwaFSaBgwn+ki1U3dicCI8RkBGSU/cLGRSi0X5gKlZ9+9pkWVfuIGCe
         /oTZHoEIrHecQejtDSTg7PRAm2PIN6iPsj+RjwCSaYmNmCTTm4FoEXhd/lWkXEHaOtii
         iA6efMZreiJm6XuLLD9DBUkjt/WnowLcXtXfChp+UH8CGSTsmx6KmQeU226QX/R02y+t
         JUpkZ3kGmlHaGrd6zrHevdy7JLyg+ogo3X+eg2XT8DayYomqd+yIrVAX3zqS9MLckEgS
         eTKA==
X-Gm-Message-State: AC+VfDybqkGsNNJU/8uA7I0QGhUT2+32pjMYoJhdvBS4RfK44gO5C1FO
	eRn1bu80JDcLi1tJYosezh+1cmc=
X-Google-Smtp-Source: ACHHUZ6v3Nbl9p9DP4JnnlIGezXZ51JxI9ms94FsHoptJmEuhnkg9YJrbW97ljMmDsPYnx0xN6WMo1g=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1a50:b0:643:78c0:ec65 with SMTP id
 h16-20020a056a001a5000b0064378c0ec65mr407810pfv.5.1686001682221; Mon, 05 Jun
 2023 14:48:02 -0700 (PDT)
Date: Mon, 5 Jun 2023 14:48:00 -0700
In-Reply-To: <CAEf4BzbRduV=HvJYTKLJUy3twDOrrFq+soVAxMmMK_75KaOUEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230602150011.1657856-1-andrii@kernel.org> <20230602150011.1657856-2-andrii@kernel.org>
 <ZHqYG3q34nnt99pM@google.com> <CAEf4BzbRduV=HvJYTKLJUy3twDOrrFq+soVAxMmMK_75KaOUEQ@mail.gmail.com>
Message-ID: <ZH5YEMS4Cu3DJVBJ@google.com>
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
> On Fri, Jun 2, 2023 at 6:32=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
> >
> > On 06/02, Andrii Nakryiko wrote:
> > > Add new kind of BPF kernel object, BPF token. BPF token is meant to t=
o
> > > allow delegating privileged BPF functionality, like loading a BPF
> > > program or creating a BPF map, from privileged process to a *trusted*
> > > unprivileged process, all while have a good amount of control over wh=
ich
> > > privileged operation could be done using provided BPF token.
> > >
> > > This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, which
> > > allows to create a new BPF token object along with a set of allowed
> > > commands. Currently only BPF_TOKEN_CREATE command itself can be
> > > delegated, but other patches gradually add ability to delegate
> > > BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.
> > >
> > > The above means that BPF token creation can be allowed by another
> > > existing BPF token, if original privileged creator allowed that. New
> > > derived BPF token cannot be more powerful than the original BPF token=
.
> > >
> > > BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS flag is added to allow application to=
 do
> > > express "all supported BPF commands should be allowed" without worryi=
ng
> > > about which subset of desired commands is actually supported by
> > > potentially outdated kernel. Allowing this semantics doesn't seem to
> > > introduce any backwards compatibility issues and doesn't introduce an=
y
> > > risk of abusing or misusing bit set field, but makes backwards
> > > compatibility story for various applications and tools much more
> > > straightforward, making it unnecessary to probe support for each
> > > individual possible bit. This is especially useful in follow up patch=
es
> > > where we add BPF map types and prog types bit sets.
> > >
> > > Lastly, BPF token can be pinned in and retrieved from BPF FS, just li=
ke
> > > progs, maps, BTFs, and links. This allows applications (like containe=
r
> > > managers) to share BPF token with other applications through file sys=
tem
> > > just like any other BPF object, and further control access to it usin=
g
> > > file system permissions, if desired.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/bpf.h            |  34 +++++++++
> > >  include/uapi/linux/bpf.h       |  42 ++++++++++++
> > >  kernel/bpf/Makefile            |   2 +-
> > >  kernel/bpf/inode.c             |  26 +++++++
> > >  kernel/bpf/syscall.c           |  74 ++++++++++++++++++++
> > >  kernel/bpf/token.c             | 122 +++++++++++++++++++++++++++++++=
++
> > >  tools/include/uapi/linux/bpf.h |  40 +++++++++++
> > >  7 files changed, 339 insertions(+), 1 deletion(-)
> > >  create mode 100644 kernel/bpf/token.c
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index f58895830ada..fe6d51c3a5b1 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -51,6 +51,7 @@ struct module;
> > >  struct bpf_func_state;
> > >  struct ftrace_ops;
> > >  struct cgroup;
> > > +struct bpf_token;
> > >
> > >  extern struct idr btf_idr;
> > >  extern spinlock_t btf_idr_lock;
> > > @@ -1533,6 +1534,12 @@ struct bpf_link_primer {
> > >       u32 id;
> > >  };
> > >
> > > +struct bpf_token {
> > > +     struct work_struct work;
> > > +     atomic64_t refcnt;
> > > +     u64 allowed_cmds;
> > > +};
> > > +
> > >  struct bpf_struct_ops_value;
> > >  struct btf_member;
> > >
> > > @@ -2077,6 +2084,15 @@ struct file *bpf_link_new_file(struct bpf_link=
 *link, int *reserved_fd);
> > >  struct bpf_link *bpf_link_get_from_fd(u32 ufd);
> > >  struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
> > >
> > > +void bpf_token_inc(struct bpf_token *token);
> > > +void bpf_token_put(struct bpf_token *token);
> > > +struct bpf_token *bpf_token_alloc(void);
> > > +int bpf_token_new_fd(struct bpf_token *token);
> > > +struct bpf_token *bpf_token_get_from_fd(u32 ufd);
> > > +
> > > +bool bpf_token_capable(const struct bpf_token *token, int cap);
> > > +bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd=
 cmd);
> > > +
> > >  int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathna=
me);
> > >  int bpf_obj_get_user(int path_fd, const char __user *pathname, int f=
lags);
> > >
> > > @@ -2436,6 +2452,24 @@ static inline int bpf_obj_get_user(const char =
__user *pathname, int flags)
> > >       return -EOPNOTSUPP;
> > >  }
> > >
> > > +static inline void bpf_token_inc(struct bpf_token *token)
> > > +{
> > > +}
> > > +
> > > +static inline void bpf_token_put(struct bpf_token *token)
> > > +{
> > > +}
> > > +
> > > +static inline struct bpf_token *bpf_token_new_fd(struct bpf_token *t=
oken)
> > > +{
> > > +     return -EOPNOTSUPP;
> > > +}
> > > +
> > > +static inline struct bpf_token *bpf_token_get_from_fd(u32 ufd)
> > > +{
> > > +     return ERR_PTR(-EOPNOTSUPP);
> > > +}
> > > +
> > >  static inline void __dev_flush(void)
> > >  {
> > >  }
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 9273c654743c..01ab79f2ad9f 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -846,6 +846,16 @@ union bpf_iter_link_info {
> > >   *           Returns zero on success. On error, -1 is returned and *=
errno*
> > >   *           is set appropriately.
> > >   *
> > > + * BPF_TOKEN_CREATE
> > > + *   Description
> > > + *           Create BPF token with embedded information about what
> > > + *           BPF-related functionality is allowed. This BPF token ca=
n be
> > > + *           passed as an extra parameter to various bpf() syscall c=
ommand.
> > > + *
> > > + *   Return
> > > + *           A new file descriptor (a nonnegative integer), or -1 if=
 an
> > > + *           error occurred (in which case, *errno* is set appropria=
tely).
> > > + *
> > >   * NOTES
> > >   *   eBPF objects (maps and programs) can be shared between processe=
s.
> > >   *
> > > @@ -900,6 +910,7 @@ enum bpf_cmd {
> > >       BPF_ITER_CREATE,
> > >       BPF_LINK_DETACH,
> > >       BPF_PROG_BIND_MAP,
> > > +     BPF_TOKEN_CREATE,
> > >  };
> > >
> > >  enum bpf_map_type {
> > > @@ -1169,6 +1180,24 @@ enum bpf_link_type {
> > >   */
> > >  #define BPF_F_KPROBE_MULTI_RETURN    (1U << 0)
> > >
> > > +/* BPF_TOKEN_CREATE command flags
> > > + */
> > > +enum {
> > > +     /* Ignore unrecognized bits in token_create.allowed_cmds bit se=
t.  If
> > > +      * this flag is set, kernel won't return -EINVAL for a bit
> > > +      * corresponding to a non-existing command or the one that does=
n't
> > > +      * support BPF token passing. This flags allows application to =
request
> > > +      * BPF token creation for a desired set of commands without wor=
rying
> > > +      * about older kernels not supporting some of the commands.
> > > +      * Presumably, deployed applications will do separate feature
> > > +      * detection and will avoid calling not-yet-supported bpf() com=
mands,
> > > +      * so this BPF token will work equally well both on older and n=
ewer
> > > +      * kernels, even if some of the requested commands won't be BPF
> > > +      * token-enabled.
> > > +      */
> > > +     BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS           =3D 1U << 0,
> > > +};
> > > +
> > >  /* When BPF ldimm64's insn[0].src_reg !=3D 0 then this can have
> > >   * the following extensions:
> > >   *
> > > @@ -1621,6 +1650,19 @@ union bpf_attr {
> > >               __u32           flags;          /* extra flags */
> > >       } prog_bind_map;
> > >
> > > +     struct { /* struct used by BPF_TOKEN_CREATE command */
> > > +             __u32           flags;
> > > +             __u32           token_fd;
> > > +             /* a bit set of allowed bpf() syscall commands,
> > > +              * e.g., (1ULL << BPF_TOKEN_CREATE) | (1ULL << BPF_PROG=
_LOAD)
> > > +              * will allow creating derived BPF tokens and loading n=
ew BPF
> > > +              * programs;
> > > +              * see also BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS for its eff=
ect on
> > > +              * validity checking of this set
> > > +              */
> > > +             __u64           allowed_cmds;
> > > +     } token_create;
> >
> > Do you think this might eventually grow into something like
> > "allow only lookup operation for this specific map"? If yes, maybe it
>=20
> If it was strictly up for me, then no. I think fine-granular and
> highly-dynamic restrictions are more the (BPF) LSM domain. In practice
> I envision that users will use a combination of BPF token to specify
> what BPF functionality can be used by applications in "broad strokes",
> e.g., specifying that only networking programs and
> ARRAY/HASHMAP/SK_STORAGE maps can be used, but disallow most of
> tracing functionality. And then on top of that LSM can be utilized to
> provide more nuanced (and as I said, more dynamic) controls over what
> operations over BPF map application can perform.

In this case, why not fully embrace lsm here?

Maybe all we really need is:
- a BPF_TOKEN_CREATE command (without any granularity)
- a holder of the token (passed as you're suggesting, via new uapi
  field) would be equivalent to capable(CAP_BPF)
- security_bpf() will provide fine-grained control
- extend landlock to provide coarse-grained policy (and later
  finer granularity)

?

Or we still want the token to carry the policy somehow? (why? because
of the filesystem pinning?)

> If you look at the final set of token_create parameters, you can see
> that I only aim to control and restrict BPF commands that are creating
> new BPF objects (BTF, map, prog; we might do similar stuff for links
> later, perhaps) only. In that sense BPF token controls "constructors",
> while if users want to control operation on BPF objects that were
> created (maps and programs, for the most part), I see this a bit
> outside of BPF token scope. I also don't think we should do more
> fine-grained control of construction parameters. E.g., I think it's
> too much to enforce which attach_btf_id can be provided.
>=20
> It's all code, though, so we could push it in any direction we want,
> but in my view BPF token is about a somewhat static prescription of
> what bpf() functionality is accessible to the application, broadly.
> And LSM can complement it with more dynamic abilities.

Are you planning to follow up with the other, non-constructing commands?
Somebody here recently was proposing to namespacify CAP_BPF, something
like a read-only-capable token should, in theory, solve it?

> > makes sense to separate token-create vs token-add-capability operations=
?
> >
> > BPF_TOKEN_CREATE would create a token that can't do anything. Then you
> > would call a bunch of BPF_TOKEN_ALLOW with maybe op=3DSYSCALL_CMD
> > value=3DBPF_TOKEN_CREATE.
> >
> > This will be more future-proof plus won't really depend on having a
> > bitmask in the uapi. Then the users will be able to handle
> > BPF_TOKEN_ALLOW{op=3DSYSCALL_CMD value=3DSOME_VALUE_NOT_SUPPORTED_ON_TH=
IS_KERNEL}
> > themselves (IOW, BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS won't be needed).
>=20
> So I very much intentionally wanted to keep the BPF token immutable
> once created. This makes it simple to reason about what BPF token
> allows and guarantee that it won't change after the fact. It's doable
> to make BPF token mutable and then "finalize" it (and BPF_MAP_FREEZE
> stands as a good reminder of races and complications such model
> introduces), creating a sort of builder pattern APIs, but that seems
> like an overkill and unnecessary complication.
>=20
> But let me address that "more future-proof" part. What about our
> binary bpf_attr extensible approach is not future proof? In both cases
> we'll have to specify as part of UAPI that there is a possibility to
> restrict a set of bpf() syscall commands, right? In one case you'll do
> it through multiple syscall invocations, while I chose a
> straightforward bit mask. I could have done it as a pointer to an
> array of `enum bpf_cmd` items, but I think it's extremely unlikely
> we'll get to >64, ever. But even if we do, adding `u64 allowed_cmds2`
> doesn't seem like a big deal to me.
>=20
> The main point though, both approaches are equally extensible. But
> making BPF token mutable adds a lot of undesirable (IMO)
> complications.
>=20
>=20
> As for BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS, I'm thinking of dropping such
> flags for simplicity.

Ack, I just hope we're not inventing another landlock here. As mentioned
above, maybe doing simple BPF_TOKEN_CREATE + pushing the rest of the
policy into lsm/landlock is a good alternative, idk.

