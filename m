Return-Path: <bpf+bounces-4642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3D274E014
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 23:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A990028110E
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 21:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9AB156D7;
	Mon, 10 Jul 2023 21:14:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DB414AB4
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 21:14:13 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07D418D
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 14:14:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-262cc036fa4so2349384a91.3
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689023648; x=1691615648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aNxsrKe7rBLIn8GxkMJcPYidKyYwo5Opt+k4XiBVfA=;
        b=bZOe5q/CKLTJb9zYL4/4+sz4i3iSKwayfLLBJnTlBo3GZDmE2jOG9KeZ1Rk/zXSINb
         lJdmKkitpU+E83Fm5xGnzS/5pw+aIKDUXRKw/b85GwxL9q1ui88/cMC2trHGrkSrs4BU
         u6g5ncqH3iCE2hIlo9e/Oc/FHOOV9z2r1IPHznwPd2bATdldst9gyd0FSzJYoyRLgPes
         txpUQEUhtCIvOYggdefRBNp4Uld5ysQuzuZvBe7hZ+vsgjEA5D32ei1u34NtfVytTR4Y
         cEz60ufcem2FRB+IaQ4XenTDrcdMKFAw7/m6EBjwkCdr5SZn+ABiyRFkOMLiBx3UFdMX
         th7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023648; x=1691615648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aNxsrKe7rBLIn8GxkMJcPYidKyYwo5Opt+k4XiBVfA=;
        b=hu9kwqOHG2/fzRzSEPt0bCyLAOTCy9Pe7ANti97ehdgrOZHHcyS9//m79fTb9pX+5R
         GXAY+Q8Khfy9IDi3rp02BSwtGRTeCb4D7VTSKG3/JrNqUM5nwJ4CYsnUrnrOy0TvpHpK
         IdJH49ORpn8v/Rq42gnQNVqEsaJoOERwXHZ9tAwgWFcN6DRnlq6KaRxCIzO4LIzugYTp
         9EjUo2hi/nlFDVBNlr9dJdoadtnZAf3OaQh/HwNSa3boxXJ8s7venF9nO0RCW/fpnqz0
         O1kdTwtCVMWHd+3huG8uHZu/6eLnFo6MKqjJ31xIC+RKJma6nnRCzZxP5z+VuZr8op3i
         WsfA==
X-Gm-Message-State: ABy/qLalVjbmiqvkkIv9yrrcTYVmkvvLmW3QHGO4DDFvhx5gk7ivvlF6
	Wub7bac0F3nkqqufgNSgYhla1IRfzgvd6qp1xzxKTQ==
X-Google-Smtp-Source: APBJJlEsU+lk/LJkK6rQfdlVO2Q1+81COqQ4EQDPO0+ipq7tjjU/reFSLQ1ky5nwGT3CvRNXDHcil7qRWnu8jNupQ6o=
X-Received: by 2002:a17:90a:fd01:b0:259:24c4:4dd4 with SMTP id
 cv1-20020a17090afd0100b0025924c44dd4mr10331624pjb.10.1689023647636; Mon, 10
 Jul 2023 14:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707172455.7634-1-daniel@iogearbox.net> <20230707172455.7634-2-daniel@iogearbox.net>
 <ZKiDKuoovyikz8Mm@google.com> <d67ca0f4-4753-e86f-f8ca-dd515f941ea5@iogearbox.net>
 <ZKxLY3onuOHepOxt@google.com> <CAADnVQ+2KUg2mgK6f+4L8gL_DJgx2fV3tbF2kX=yjxorLGQ6SA@mail.gmail.com>
 <CAKH8qBs8gX-K9dzXku9aa4GfB4CGVjsfx05FvDXFuNFPxq+OXQ@mail.gmail.com> <CAADnVQK8ptJ5Gv7Ty2AsZt-58r4UMNfR5PA9QBZAye5iqUGWvQ@mail.gmail.com>
In-Reply-To: <CAADnVQK8ptJ5Gv7Ty2AsZt-58r4UMNfR5PA9QBZAye5iqUGWvQ@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 10 Jul 2023 14:13:56 -0700
Message-ID: <CAKH8qBu0u_HuuGCW=vjQp4nsMB4QFtgza7A9VAdbPFzAvAyorg@mail.gmail.com>
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
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 1:16=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 10, 2023 at 12:00=E2=80=AFPM Stanislav Fomichev <sdf@google.c=
om> wrote:
> >
> > On Mon, Jul 10, 2023 at 11:27=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Jul 10, 2023 at 11:18=E2=80=AFAM Stanislav Fomichev <sdf@goog=
le.com> wrote:
> > > >
> > > > On 07/10, Daniel Borkmann wrote:
> > > > > On 7/7/23 11:27 PM, Stanislav Fomichev wrote:
> > > > > > On 07/07, Daniel Borkmann wrote:
> > > > > [...]
> > > > > > > +static inline struct bpf_mprog_entry *
> > > > > > > +bpf_mprog_create(const size_t size, const off_t off)
> > > > > > > +{
> > > > > > > + struct bpf_mprog_bundle *bundle;
> > > > > > > + void *ptr;
> > > > > > > +
> > > > > > > + BUILD_BUG_ON(size < sizeof(*bundle) + off);
> > > > > > > + BUILD_BUG_ON(sizeof(bundle->a.fp_items[0]) > sizeof(u64));
> > > > > > > + BUILD_BUG_ON(ARRAY_SIZE(bundle->a.fp_items) !=3D
> > > > > > > +              ARRAY_SIZE(bundle->cp_items));
> > > > > > > +
> > > > > > > + ptr =3D kzalloc(size, GFP_KERNEL);
> > > > > > > + if (ptr) {
> > > > > > > +         bundle =3D ptr + off;
> > > > > > > +         atomic64_set(&bundle->revision, 1);
> > > > > > > +         bundle->off =3D off;
> > > > > > > +         bundle->a.parent =3D bundle;
> > > > > > > +         bundle->b.parent =3D bundle;
> > > > > > > +         return &bundle->a;
> > > > > > > + }
> > > > > > > + return NULL;
> > > > > > > +}
> > > > > > > +
> > > > > > > +void bpf_mprog_free_rcu(struct rcu_head *rcu);
> > > > > > > +
> > > > > > > +static inline void bpf_mprog_free(struct bpf_mprog_entry *en=
try)
> > > > > > > +{
> > > > > > > + struct bpf_mprog_bundle *bundle =3D entry->parent;
> > > > > > > +
> > > > > > > + call_rcu(&bundle->rcu, bpf_mprog_free_rcu);
> > > > > > > +}
> > > > > >
> > > > > > Any reason we're doing allocation here? Why not do
> > > > > > bpf_mprog_init(struct bpf_mprog_bundle *) instead that simply i=
nitializes
> > > > > > the fields? Then we can move allocation/free part to the caller=
 (tcx) along
> > > > > > with rcu_head.
> > > > > > Feels like it would be a bit more conventional/readable? bpf_mp=
rog_free{,_rcu}
> > > > > > will also become tcx_free{,_rcu}..
> > > > > >
> > > > > > I guess current approach works, but it took me awhile to figure=
 it out..
> > > > > > (maybe it's just me)
> > > > >
> > > > > I found this approach quite useful for tcx case since we only fet=
ch the
> > > > > bpf_mprog_entry for tcx_link_prog_attach et al, but I can take a =
look to
> > > > > see if this looks better and if it does I'll include it.
> > > > >
> > > > > > > +static inline void bpf_mprog_mark_ref(struct bpf_mprog_entry=
 *entry,
> > > > > > > +                               struct bpf_tuple *tuple)
> > > > > > > +{
> > > > > > > + WARN_ON_ONCE(entry->parent->ref);
> > > > > > > + if (!tuple->link)
> > > > > > > +         entry->parent->ref =3D tuple->prog;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static inline void bpf_mprog_inc(struct bpf_mprog_entry *ent=
ry)
> > > > > > > +{
> > > > > > > + entry->parent->count++;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static inline void bpf_mprog_dec(struct bpf_mprog_entry *ent=
ry)
> > > > > > > +{
> > > > > > > + entry->parent->count--;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static inline int bpf_mprog_max(void)
> > > > > > > +{
> > > > > > > + return ARRAY_SIZE(((struct bpf_mprog_entry *)NULL)->fp_item=
s) - 1;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static inline int bpf_mprog_total(struct bpf_mprog_entry *en=
try)
> > > > > > > +{
> > > > > > > + int total =3D entry->parent->count;
> > > > > > > +
> > > > > > > + WARN_ON_ONCE(total > bpf_mprog_max());
> > > > > > > + return total;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static inline bool bpf_mprog_exists(struct bpf_mprog_entry *=
entry,
> > > > > > > +                             struct bpf_prog *prog)
> > > > > > > +{
> > > > > > > + const struct bpf_mprog_fp *fp;
> > > > > > > + const struct bpf_prog *tmp;
> > > > > > > +
> > > > > > > + bpf_mprog_foreach_prog(entry, fp, tmp) {
> > > > > > > +         if (tmp =3D=3D prog)
> > > > > > > +                 return true;
> > > > > > > + }
> > > > > > > + return false;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static inline bool bpf_mprog_swap_entries(const int code)
> > > > > > > +{
> > > > > > > + return code =3D=3D BPF_MPROG_SWAP ||
> > > > > > > +        code =3D=3D BPF_MPROG_FREE;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static inline void bpf_mprog_commit(struct bpf_mprog_entry *=
entry)
> > > > > > > +{
> > > > > > > + atomic64_inc(&entry->parent->revision);
> > > > > > > + synchronize_rcu();
> > > > > >
> > > > > > Maybe add a comment on why we need to synchronize_rcu here? In =
general,
> > > > > > I don't think I have a good grasp of that ->ref member.
> > > > >
> > > > > Yeap, will add a comment. For the case where we delete the prog, =
we mark
> > > > > it in bpf_mprog_detach, but we can only drop the reference once t=
he user
> > > > > swapped the bpf_mprog_entry and ensured that there are no in-flig=
ht users
> > > > > hence both in bpf_mprog_commit.
> > > > >
> > > > > [...]
> > > > > > > +static int bpf_mprog_prog(struct bpf_tuple *tuple,
> > > > > > > +                   u32 object, u32 flags,
> > > > > > > +                   enum bpf_prog_type type)
> > > > > > > +{
> > > > > > > + bool id =3D flags & BPF_F_ID;
> > > > > > > + struct bpf_prog *prog;
> > > > > > > +
> > > > > > > + if (id)
> > > > > > > +         prog =3D bpf_prog_by_id(object);
> > > > > > > + else
> > > > > > > +         prog =3D bpf_prog_get(object);
> > > > > > > + if (IS_ERR(prog)) {
> > > > > >
> > > > > > [..]
> > > > > >
> > > > > > > +         if (!object && !id)
> > > > > > > +                 return 0;
> > > > > >
> > > > > > What's the reason behind this?
> > > > >
> > > > > If an fd was passed which is 0 and this was not a program fd, the=
n we don't error
> > > > > out and treat it as if no fd was passed.
> > > >
> > > > Is this new api an opportunity to fix that fd=3D=3D0? And always tr=
eat it as
> > > > valid. Or we have some other constrains elsewhere?
> > >
> > > No. There is nothing to fix.
> >
> > Care to elaborate? Do we want to preserve it for consistency? Or is
> > there some concern with asking people to put relative_fd=3D-1 when doin=
g
> > the call?
> > I'm fine either way; trying to understand where it's coming from. I
> > remember it was discussed briefly at lsfmmbpf, but don't remember the
> > details..
>
> 0 is invalid bpf object (prog, map, link). There is nothing to "fix".

It's more like it's a conditionally invalid bpf object (fd in this case) :-=
)

bpf_program__attach_tcx(..., { ..., relative_fd =3D 0, ... }); //
returns ok and doesn't use relative_fd
dup2(prog_fd, 0);
bpf_program__attach_tcx(..., { ..., relative_fd =3D 0, ... }); // this
will use prog_fd duped at 0

It seems like it might a bit cleaner to explicitly ask for -1:
bpf_program__attach_tcx(..., { ..., relative_fd =3D -1, ... });

But whatever, it works anyway, and that's how it's been done elsewhere
it seems, so I'm not gonna waste our time on it.

