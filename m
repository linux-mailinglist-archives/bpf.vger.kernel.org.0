Return-Path: <bpf+bounces-4652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA8874E18E
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 00:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90742281485
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 22:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE4A168B2;
	Mon, 10 Jul 2023 22:47:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17368168AD
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 22:47:13 +0000 (UTC)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0940BDF
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 15:47:11 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-345e55a62d8so19150585ab.3
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 15:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689029230; x=1691621230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzfSUJE+FKHw2BKr2CjHMjab5FLJa3DdwHIBIgzs8Fw=;
        b=lnXQWrU+zz440pkrQ5dDXQpk0Az/eis+Ua+9p835mhOWsP74cQcL3CrqPtWz1pjrwe
         dNNxBNM8O90ROJ/eWxJ+g/Pgxj1KiTHnSYXD64Ptauoe+9Tb7SSr4AFauZ48rJra2wrI
         BkvOinlAMNc5M+U7xXw532DOd87++f1gOqWZwFqK8dXsruP/YxMCY7W56IYtu/MOvTmG
         oaPX/EoDh6u0eXA6JsawZ/Hgl5V/UZbD+1fw+1qtSxfkO9KpJr9SEe/z5MLdPdvdFIS8
         16t4dfXklaazH6e9aQ5M6lnvEZlXYdSVXFiKOvvyk+vkdCfVwgdG4V0qgdICzo0u3Y5q
         umzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689029230; x=1691621230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzfSUJE+FKHw2BKr2CjHMjab5FLJa3DdwHIBIgzs8Fw=;
        b=lEEPq19Zo4UUQbvl+IemE3zvl+EAX7cKlDPKvFamfZrXotk9AeFyqNlw4iES71ObFR
         0ueMW7IoWgjlMWmmTkQzIU7tzORXHvgpGeQYghNyEL98xKkAv5TQD0vaI0NBNXILdEIN
         fs1dVnkR2WFjsPljAD4n69IRnefe34JgdMrSjqw+lCv+T/L35qptjubr8pqlpo1OVrYW
         +nO/MWB32AWeLsOWghqbP3u2PA4/FfIC8GQAbkNiya3+S2Iy5SuqY3ONy91ySmWaBntZ
         VndWSzN3fjtOfIOJhcS0eJeem1KS200kIrPzoARt9DBMdkT3nalaLfP9QpgkCi3baEyX
         2oog==
X-Gm-Message-State: ABy/qLYmKC3A05d2PvVzlvvEVMGEI0MczWNwb28+LQVT89TgJbkmlIjk
	vH8wr4tG4pra9Q2y05WbEFj5YO/INhlZEL50zr3pXw==
X-Google-Smtp-Source: APBJJlFGfDaWzVqslRhM9rMc5y0+Q4iPwGnl6xJJ7rrpBB9jW16wuzYVA3GjKslMJaovwlaZVj/c/5ayFb2DI7Cmh7E=
X-Received: by 2002:a05:6e02:66d:b0:346:624e:29eb with SMTP id
 l13-20020a056e02066d00b00346624e29ebmr3863966ilt.6.1689029230289; Mon, 10 Jul
 2023 15:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707172455.7634-1-daniel@iogearbox.net> <20230707172455.7634-2-daniel@iogearbox.net>
 <ZKiDKuoovyikz8Mm@google.com> <d67ca0f4-4753-e86f-f8ca-dd515f941ea5@iogearbox.net>
 <ZKxLY3onuOHepOxt@google.com> <CAADnVQ+2KUg2mgK6f+4L8gL_DJgx2fV3tbF2kX=yjxorLGQ6SA@mail.gmail.com>
 <CAKH8qBs8gX-K9dzXku9aa4GfB4CGVjsfx05FvDXFuNFPxq+OXQ@mail.gmail.com>
 <CAADnVQK8ptJ5Gv7Ty2AsZt-58r4UMNfR5PA9QBZAye5iqUGWvQ@mail.gmail.com>
 <CAKH8qBu0u_HuuGCW=vjQp4nsMB4QFtgza7A9VAdbPFzAvAyorg@mail.gmail.com> <CAADnVQ+g=7EdpHK5U4u_JSsGBgNXSq63Dbh84dQKiWGpqMX6qg@mail.gmail.com>
In-Reply-To: <CAADnVQ+g=7EdpHK5U4u_JSsGBgNXSq63Dbh84dQKiWGpqMX6qg@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 10 Jul 2023 15:46:58 -0700
Message-ID: <CAKH8qBsr5vYijQSVv0EO8TF7zfoAdAaWC8jpVKK_nGSgAoyiQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/8] bpf: Add generic attach/detach/query API
 for multi-progs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Nikolay Aleksandrov <razor@blackwall.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Joe Stringer <joe@cilium.io>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 3:38=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 10, 2023 at 2:14=E2=80=AFPM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > On Mon, Jul 10, 2023 at 1:16=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Jul 10, 2023 at 12:00=E2=80=AFPM Stanislav Fomichev <sdf@goog=
le.com> wrote:
> > > >
> > > > On Mon, Jul 10, 2023 at 11:27=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Mon, Jul 10, 2023 at 11:18=E2=80=AFAM Stanislav Fomichev <sdf@=
google.com> wrote:
> > > > > >
> > > > > > On 07/10, Daniel Borkmann wrote:
> > > > > > > On 7/7/23 11:27 PM, Stanislav Fomichev wrote:
> > > > > > > > On 07/07, Daniel Borkmann wrote:
> > > > > > > [...]
> > > > > > > > > +static inline struct bpf_mprog_entry *
> > > > > > > > > +bpf_mprog_create(const size_t size, const off_t off)
> > > > > > > > > +{
> > > > > > > > > + struct bpf_mprog_bundle *bundle;
> > > > > > > > > + void *ptr;
> > > > > > > > > +
> > > > > > > > > + BUILD_BUG_ON(size < sizeof(*bundle) + off);
> > > > > > > > > + BUILD_BUG_ON(sizeof(bundle->a.fp_items[0]) > sizeof(u64=
));
> > > > > > > > > + BUILD_BUG_ON(ARRAY_SIZE(bundle->a.fp_items) !=3D
> > > > > > > > > +              ARRAY_SIZE(bundle->cp_items));
> > > > > > > > > +
> > > > > > > > > + ptr =3D kzalloc(size, GFP_KERNEL);
> > > > > > > > > + if (ptr) {
> > > > > > > > > +         bundle =3D ptr + off;
> > > > > > > > > +         atomic64_set(&bundle->revision, 1);
> > > > > > > > > +         bundle->off =3D off;
> > > > > > > > > +         bundle->a.parent =3D bundle;
> > > > > > > > > +         bundle->b.parent =3D bundle;
> > > > > > > > > +         return &bundle->a;
> > > > > > > > > + }
> > > > > > > > > + return NULL;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +void bpf_mprog_free_rcu(struct rcu_head *rcu);
> > > > > > > > > +
> > > > > > > > > +static inline void bpf_mprog_free(struct bpf_mprog_entry=
 *entry)
> > > > > > > > > +{
> > > > > > > > > + struct bpf_mprog_bundle *bundle =3D entry->parent;
> > > > > > > > > +
> > > > > > > > > + call_rcu(&bundle->rcu, bpf_mprog_free_rcu);
> > > > > > > > > +}
> > > > > > > >
> > > > > > > > Any reason we're doing allocation here? Why not do
> > > > > > > > bpf_mprog_init(struct bpf_mprog_bundle *) instead that simp=
ly initializes
> > > > > > > > the fields? Then we can move allocation/free part to the ca=
ller (tcx) along
> > > > > > > > with rcu_head.
> > > > > > > > Feels like it would be a bit more conventional/readable? bp=
f_mprog_free{,_rcu}
> > > > > > > > will also become tcx_free{,_rcu}..
> > > > > > > >
> > > > > > > > I guess current approach works, but it took me awhile to fi=
gure it out..
> > > > > > > > (maybe it's just me)
> > > > > > >
> > > > > > > I found this approach quite useful for tcx case since we only=
 fetch the
> > > > > > > bpf_mprog_entry for tcx_link_prog_attach et al, but I can tak=
e a look to
> > > > > > > see if this looks better and if it does I'll include it.
> > > > > > >
> > > > > > > > > +static inline void bpf_mprog_mark_ref(struct bpf_mprog_e=
ntry *entry,
> > > > > > > > > +                               struct bpf_tuple *tuple)
> > > > > > > > > +{
> > > > > > > > > + WARN_ON_ONCE(entry->parent->ref);
> > > > > > > > > + if (!tuple->link)
> > > > > > > > > +         entry->parent->ref =3D tuple->prog;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static inline void bpf_mprog_inc(struct bpf_mprog_entry =
*entry)
> > > > > > > > > +{
> > > > > > > > > + entry->parent->count++;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static inline void bpf_mprog_dec(struct bpf_mprog_entry =
*entry)
> > > > > > > > > +{
> > > > > > > > > + entry->parent->count--;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static inline int bpf_mprog_max(void)
> > > > > > > > > +{
> > > > > > > > > + return ARRAY_SIZE(((struct bpf_mprog_entry *)NULL)->fp_=
items) - 1;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static inline int bpf_mprog_total(struct bpf_mprog_entry=
 *entry)
> > > > > > > > > +{
> > > > > > > > > + int total =3D entry->parent->count;
> > > > > > > > > +
> > > > > > > > > + WARN_ON_ONCE(total > bpf_mprog_max());
> > > > > > > > > + return total;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static inline bool bpf_mprog_exists(struct bpf_mprog_ent=
ry *entry,
> > > > > > > > > +                             struct bpf_prog *prog)
> > > > > > > > > +{
> > > > > > > > > + const struct bpf_mprog_fp *fp;
> > > > > > > > > + const struct bpf_prog *tmp;
> > > > > > > > > +
> > > > > > > > > + bpf_mprog_foreach_prog(entry, fp, tmp) {
> > > > > > > > > +         if (tmp =3D=3D prog)
> > > > > > > > > +                 return true;
> > > > > > > > > + }
> > > > > > > > > + return false;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static inline bool bpf_mprog_swap_entries(const int code=
)
> > > > > > > > > +{
> > > > > > > > > + return code =3D=3D BPF_MPROG_SWAP ||
> > > > > > > > > +        code =3D=3D BPF_MPROG_FREE;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static inline void bpf_mprog_commit(struct bpf_mprog_ent=
ry *entry)
> > > > > > > > > +{
> > > > > > > > > + atomic64_inc(&entry->parent->revision);
> > > > > > > > > + synchronize_rcu();
> > > > > > > >
> > > > > > > > Maybe add a comment on why we need to synchronize_rcu here?=
 In general,
> > > > > > > > I don't think I have a good grasp of that ->ref member.
> > > > > > >
> > > > > > > Yeap, will add a comment. For the case where we delete the pr=
og, we mark
> > > > > > > it in bpf_mprog_detach, but we can only drop the reference on=
ce the user
> > > > > > > swapped the bpf_mprog_entry and ensured that there are no in-=
flight users
> > > > > > > hence both in bpf_mprog_commit.
> > > > > > >
> > > > > > > [...]
> > > > > > > > > +static int bpf_mprog_prog(struct bpf_tuple *tuple,
> > > > > > > > > +                   u32 object, u32 flags,
> > > > > > > > > +                   enum bpf_prog_type type)
> > > > > > > > > +{
> > > > > > > > > + bool id =3D flags & BPF_F_ID;
> > > > > > > > > + struct bpf_prog *prog;
> > > > > > > > > +
> > > > > > > > > + if (id)
> > > > > > > > > +         prog =3D bpf_prog_by_id(object);
> > > > > > > > > + else
> > > > > > > > > +         prog =3D bpf_prog_get(object);
> > > > > > > > > + if (IS_ERR(prog)) {
> > > > > > > >
> > > > > > > > [..]
> > > > > > > >
> > > > > > > > > +         if (!object && !id)
> > > > > > > > > +                 return 0;
> > > > > > > >
> > > > > > > > What's the reason behind this?
> > > > > > >
> > > > > > > If an fd was passed which is 0 and this was not a program fd,=
 then we don't error
> > > > > > > out and treat it as if no fd was passed.
> > > > > >
> > > > > > Is this new api an opportunity to fix that fd=3D=3D0? And alway=
s treat it as
> > > > > > valid. Or we have some other constrains elsewhere?
> > > > >
> > > > > No. There is nothing to fix.
> > > >
> > > > Care to elaborate? Do we want to preserve it for consistency? Or is
> > > > there some concern with asking people to put relative_fd=3D-1 when =
doing
> > > > the call?
> > > > I'm fine either way; trying to understand where it's coming from. I
> > > > remember it was discussed briefly at lsfmmbpf, but don't remember t=
he
> > > > details..
> > >
> > > 0 is invalid bpf object (prog, map, link). There is nothing to "fix".
> >
> > It's more like it's a conditionally invalid bpf object (fd in this case=
) :-)
> >
> > bpf_program__attach_tcx(..., { ..., relative_fd =3D 0, ... }); //
> > returns ok and doesn't use relative_fd
> > dup2(prog_fd, 0);
> > bpf_program__attach_tcx(..., { ..., relative_fd =3D 0, ... }); // this
> > will use prog_fd duped at 0
>
> It shouldn't. I haven't checked the code, but if the patch does that
> it's a bug.

Daniel, am I misreading the code? It looks like it does try to resolve
relative_fd=3D0. If it succeeds - it's being used, if not, we don't
error out (that last part is ok).

So probably better to change it to:
if (id)
  <resolve id>
else if (object)
  <resolve fd>
else
  return -EINVAL;

?

