Return-Path: <bpf+bounces-4640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31CB74DF03
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 22:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDB3281308
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 20:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440A0154AF;
	Mon, 10 Jul 2023 20:16:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994514266;
	Mon, 10 Jul 2023 20:16:57 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150DE135;
	Mon, 10 Jul 2023 13:16:56 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so76405841fa.2;
        Mon, 10 Jul 2023 13:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689020214; x=1691612214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ma6kzwelg4wMy/KU62MJ6QXatOu+P9pOtLV37rkpq9s=;
        b=bWQhaAeeBSWn0bOa/S5eOO7/RsDTg2Oh3SXU85CDCxw4Kzkk9HAdvpUKoGyBsZGxVv
         OmV1fSFAEMrM7gNK7VRkBZT8sc3k/ekZGJPRntoBTw2Rl95E22T0vFDVaYL3PPFPwAGx
         sO6wqADXn4KoMervZ60225pBFnNiX3biaYlGFFL6WwH19Dlwiq8dFQ6+XJQFP2X5n2ON
         njJ/sxcLCHx9I/3YnW7f/3mm3gzBV0Ni9tfcQjnU2i19ivEQeebTYwxN3KeFBZbIaBOD
         Pf4043cQiFNcWDAzxzv01/zQG6WiweZkMIY9xwVQJnB2u1WI0apmhqgCN1Vjwyd9rFcn
         gpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689020214; x=1691612214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ma6kzwelg4wMy/KU62MJ6QXatOu+P9pOtLV37rkpq9s=;
        b=hWdvvQ7ZAxy1orSC7XCsJjT8GNgjhzkmDxnN8s6CWA9p8JLMQdJ7mzC2i4tAdwwU+v
         jSnCPnU+2Bl4J5YsV1O9XF5sh77+QMoRTKeTl7Re6VO97IZHOwos+Tk8NlPvGbqU0mpm
         jvyYdwRFInA2HD9SwKMvJWVyVeKIturoTbvudJZRUIWs6BKiley0biYS9hqNZzCBpSnY
         nYFCTmZ/voz9gXSaOYBbE8GVMEVlZjfd7JFIqbVJXrJrOj2lulyHyM7rbsT5nwjDf4qf
         MdXzJV7vFyGXlcCF6jeEsLwbEfEsL7CgYvMxwk4wE7BQzap5Cn1Rfth5BxA73MYlhWoS
         Z0QA==
X-Gm-Message-State: ABy/qLbSsntZM5EV4ZO4RSSy2lFqpELlpFRIly9JPjl1TKAivDFFC2dj
	uHU2jPOTHM+YlIrBiJwNhmheMndSFZAdBrpl8P4=
X-Google-Smtp-Source: APBJJlHaiCrpjJDKDHMKdOAnUUhvp3JFQfFY1NZi2xuNRtrVP5eYqFIObyZzOOrHfsMZ4D2VAcyjmAYABs7RcDUubbI=
X-Received: by 2002:a2e:895a:0:b0:2b6:a19e:5153 with SMTP id
 b26-20020a2e895a000000b002b6a19e5153mr12819513ljk.15.1689020213965; Mon, 10
 Jul 2023 13:16:53 -0700 (PDT)
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
In-Reply-To: <CAKH8qBs8gX-K9dzXku9aa4GfB4CGVjsfx05FvDXFuNFPxq+OXQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jul 2023 13:16:42 -0700
Message-ID: <CAADnVQK8ptJ5Gv7Ty2AsZt-58r4UMNfR5PA9QBZAye5iqUGWvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/8] bpf: Add generic attach/detach/query API
 for multi-progs
To: Stanislav Fomichev <sdf@google.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Nikolay Aleksandrov <razor@blackwall.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Joe Stringer <joe@cilium.io>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 12:00=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
>
> On Mon, Jul 10, 2023 at 11:27=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jul 10, 2023 at 11:18=E2=80=AFAM Stanislav Fomichev <sdf@google=
.com> wrote:
> > >
> > > On 07/10, Daniel Borkmann wrote:
> > > > On 7/7/23 11:27 PM, Stanislav Fomichev wrote:
> > > > > On 07/07, Daniel Borkmann wrote:
> > > > [...]
> > > > > > +static inline struct bpf_mprog_entry *
> > > > > > +bpf_mprog_create(const size_t size, const off_t off)
> > > > > > +{
> > > > > > + struct bpf_mprog_bundle *bundle;
> > > > > > + void *ptr;
> > > > > > +
> > > > > > + BUILD_BUG_ON(size < sizeof(*bundle) + off);
> > > > > > + BUILD_BUG_ON(sizeof(bundle->a.fp_items[0]) > sizeof(u64));
> > > > > > + BUILD_BUG_ON(ARRAY_SIZE(bundle->a.fp_items) !=3D
> > > > > > +              ARRAY_SIZE(bundle->cp_items));
> > > > > > +
> > > > > > + ptr =3D kzalloc(size, GFP_KERNEL);
> > > > > > + if (ptr) {
> > > > > > +         bundle =3D ptr + off;
> > > > > > +         atomic64_set(&bundle->revision, 1);
> > > > > > +         bundle->off =3D off;
> > > > > > +         bundle->a.parent =3D bundle;
> > > > > > +         bundle->b.parent =3D bundle;
> > > > > > +         return &bundle->a;
> > > > > > + }
> > > > > > + return NULL;
> > > > > > +}
> > > > > > +
> > > > > > +void bpf_mprog_free_rcu(struct rcu_head *rcu);
> > > > > > +
> > > > > > +static inline void bpf_mprog_free(struct bpf_mprog_entry *entr=
y)
> > > > > > +{
> > > > > > + struct bpf_mprog_bundle *bundle =3D entry->parent;
> > > > > > +
> > > > > > + call_rcu(&bundle->rcu, bpf_mprog_free_rcu);
> > > > > > +}
> > > > >
> > > > > Any reason we're doing allocation here? Why not do
> > > > > bpf_mprog_init(struct bpf_mprog_bundle *) instead that simply ini=
tializes
> > > > > the fields? Then we can move allocation/free part to the caller (=
tcx) along
> > > > > with rcu_head.
> > > > > Feels like it would be a bit more conventional/readable? bpf_mpro=
g_free{,_rcu}
> > > > > will also become tcx_free{,_rcu}..
> > > > >
> > > > > I guess current approach works, but it took me awhile to figure i=
t out..
> > > > > (maybe it's just me)
> > > >
> > > > I found this approach quite useful for tcx case since we only fetch=
 the
> > > > bpf_mprog_entry for tcx_link_prog_attach et al, but I can take a lo=
ok to
> > > > see if this looks better and if it does I'll include it.
> > > >
> > > > > > +static inline void bpf_mprog_mark_ref(struct bpf_mprog_entry *=
entry,
> > > > > > +                               struct bpf_tuple *tuple)
> > > > > > +{
> > > > > > + WARN_ON_ONCE(entry->parent->ref);
> > > > > > + if (!tuple->link)
> > > > > > +         entry->parent->ref =3D tuple->prog;
> > > > > > +}
> > > > > > +
> > > > > > +static inline void bpf_mprog_inc(struct bpf_mprog_entry *entry=
)
> > > > > > +{
> > > > > > + entry->parent->count++;
> > > > > > +}
> > > > > > +
> > > > > > +static inline void bpf_mprog_dec(struct bpf_mprog_entry *entry=
)
> > > > > > +{
> > > > > > + entry->parent->count--;
> > > > > > +}
> > > > > > +
> > > > > > +static inline int bpf_mprog_max(void)
> > > > > > +{
> > > > > > + return ARRAY_SIZE(((struct bpf_mprog_entry *)NULL)->fp_items)=
 - 1;
> > > > > > +}
> > > > > > +
> > > > > > +static inline int bpf_mprog_total(struct bpf_mprog_entry *entr=
y)
> > > > > > +{
> > > > > > + int total =3D entry->parent->count;
> > > > > > +
> > > > > > + WARN_ON_ONCE(total > bpf_mprog_max());
> > > > > > + return total;
> > > > > > +}
> > > > > > +
> > > > > > +static inline bool bpf_mprog_exists(struct bpf_mprog_entry *en=
try,
> > > > > > +                             struct bpf_prog *prog)
> > > > > > +{
> > > > > > + const struct bpf_mprog_fp *fp;
> > > > > > + const struct bpf_prog *tmp;
> > > > > > +
> > > > > > + bpf_mprog_foreach_prog(entry, fp, tmp) {
> > > > > > +         if (tmp =3D=3D prog)
> > > > > > +                 return true;
> > > > > > + }
> > > > > > + return false;
> > > > > > +}
> > > > > > +
> > > > > > +static inline bool bpf_mprog_swap_entries(const int code)
> > > > > > +{
> > > > > > + return code =3D=3D BPF_MPROG_SWAP ||
> > > > > > +        code =3D=3D BPF_MPROG_FREE;
> > > > > > +}
> > > > > > +
> > > > > > +static inline void bpf_mprog_commit(struct bpf_mprog_entry *en=
try)
> > > > > > +{
> > > > > > + atomic64_inc(&entry->parent->revision);
> > > > > > + synchronize_rcu();
> > > > >
> > > > > Maybe add a comment on why we need to synchronize_rcu here? In ge=
neral,
> > > > > I don't think I have a good grasp of that ->ref member.
> > > >
> > > > Yeap, will add a comment. For the case where we delete the prog, we=
 mark
> > > > it in bpf_mprog_detach, but we can only drop the reference once the=
 user
> > > > swapped the bpf_mprog_entry and ensured that there are no in-flight=
 users
> > > > hence both in bpf_mprog_commit.
> > > >
> > > > [...]
> > > > > > +static int bpf_mprog_prog(struct bpf_tuple *tuple,
> > > > > > +                   u32 object, u32 flags,
> > > > > > +                   enum bpf_prog_type type)
> > > > > > +{
> > > > > > + bool id =3D flags & BPF_F_ID;
> > > > > > + struct bpf_prog *prog;
> > > > > > +
> > > > > > + if (id)
> > > > > > +         prog =3D bpf_prog_by_id(object);
> > > > > > + else
> > > > > > +         prog =3D bpf_prog_get(object);
> > > > > > + if (IS_ERR(prog)) {
> > > > >
> > > > > [..]
> > > > >
> > > > > > +         if (!object && !id)
> > > > > > +                 return 0;
> > > > >
> > > > > What's the reason behind this?
> > > >
> > > > If an fd was passed which is 0 and this was not a program fd, then =
we don't error
> > > > out and treat it as if no fd was passed.
> > >
> > > Is this new api an opportunity to fix that fd=3D=3D0? And always trea=
t it as
> > > valid. Or we have some other constrains elsewhere?
> >
> > No. There is nothing to fix.
>
> Care to elaborate? Do we want to preserve it for consistency? Or is
> there some concern with asking people to put relative_fd=3D-1 when doing
> the call?
> I'm fine either way; trying to understand where it's coming from. I
> remember it was discussed briefly at lsfmmbpf, but don't remember the
> details..

0 is invalid bpf object (prog, map, link). There is nothing to "fix".

