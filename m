Return-Path: <bpf+bounces-4623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0578974DD53
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 20:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27EE21C20B70
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 18:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08F614AA3;
	Mon, 10 Jul 2023 18:27:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA5113AF9;
	Mon, 10 Jul 2023 18:27:08 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F082C197;
	Mon, 10 Jul 2023 11:27:01 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6a084a34cso72905051fa.1;
        Mon, 10 Jul 2023 11:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689013620; x=1691605620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPbPbpxBuP7MXSJj64zO3i9Xqo/GriMysSatFQ+eIg4=;
        b=KVFOzIUygn7LZjAV1J34nMqXmpF1JXG0D3gn4zG269e5hq6a4nxtmvItTjpaweRDFB
         05a1quaaMZ9kh8A37/M350eBtgSEbVEbSRl+7lY2RuEkaXTdq08JK3c3/zbdJrH1jpLa
         L/3w9xxvUoBu0IK7d8472NKgqmLXsPy2sbcbIfK3asTXqsWsndlaiUh7mJ/76Zsh3D/G
         a+pvyFsEHSw2aKGV0yQTnHxo2YJfmLJ56l+MactD6JYcM12vSsoUSjWXc5diDMTKAKxX
         lzJSbN9vkywh4ydOtb9gSDC9B7oKwSe0QAngdlKHZdeIKnZJK305ItbFSiX57TQKZ9G0
         oSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689013620; x=1691605620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPbPbpxBuP7MXSJj64zO3i9Xqo/GriMysSatFQ+eIg4=;
        b=lL3k3ImjUZie6EB5yjrR0YpNANEL/PiShidsWV1wC/CfuBnS+zinp0k4NZ6u/JVoBk
         bd1xVDjW8Lds2x1KVv6gKZ77cNoVKEOg3obz02/zvGFIvkp2k4SvBjEfAfVP3HgIGuMi
         5Uoil5/K48NiYCfKmiPK5qDFvAC2ux7mpH6Qf1vSG4S3auLKxSYXqXcFbMT3oBpE1Jfj
         W8S5D2bVNcgtFS5dEw1ypk4oioGqdDmILkGzHcL9Rhft9T6j2ESbrklx6HvVp+p3+HBP
         9DB5l3t/985V7iq0kdDAX9jWAx6SZ84c1zSrVhn55GkJ4XYB06gCnfXicPCQEyuQUUYf
         n5VQ==
X-Gm-Message-State: ABy/qLYW/rqA5x+y/iKWvTdlPQx8CJ/pbUrCEzSQB/K5K+cfOu9iydaR
	j5OlB1JZqg6LdK4IIXokaBbnVyf7l7TQsdSKu8E=
X-Google-Smtp-Source: APBJJlFLMQxTfIsQZU9xYgghhtkliN4vtbmT3N4qaVyC4Ew/0eLInNuRWE09z64ZawnfAqTYytwNOflItyYKj3iyEhQ=
X-Received: by 2002:a2e:9c4a:0:b0:2b4:8168:2050 with SMTP id
 t10-20020a2e9c4a000000b002b481682050mr10368186ljj.29.1689013619722; Mon, 10
 Jul 2023 11:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707172455.7634-1-daniel@iogearbox.net> <20230707172455.7634-2-daniel@iogearbox.net>
 <ZKiDKuoovyikz8Mm@google.com> <d67ca0f4-4753-e86f-f8ca-dd515f941ea5@iogearbox.net>
 <ZKxLY3onuOHepOxt@google.com>
In-Reply-To: <ZKxLY3onuOHepOxt@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jul 2023 11:26:48 -0700
Message-ID: <CAADnVQ+2KUg2mgK6f+4L8gL_DJgx2fV3tbF2kX=yjxorLGQ6SA@mail.gmail.com>
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

On Mon, Jul 10, 2023 at 11:18=E2=80=AFAM Stanislav Fomichev <sdf@google.com=
> wrote:
>
> On 07/10, Daniel Borkmann wrote:
> > On 7/7/23 11:27 PM, Stanislav Fomichev wrote:
> > > On 07/07, Daniel Borkmann wrote:
> > [...]
> > > > +static inline struct bpf_mprog_entry *
> > > > +bpf_mprog_create(const size_t size, const off_t off)
> > > > +{
> > > > + struct bpf_mprog_bundle *bundle;
> > > > + void *ptr;
> > > > +
> > > > + BUILD_BUG_ON(size < sizeof(*bundle) + off);
> > > > + BUILD_BUG_ON(sizeof(bundle->a.fp_items[0]) > sizeof(u64));
> > > > + BUILD_BUG_ON(ARRAY_SIZE(bundle->a.fp_items) !=3D
> > > > +              ARRAY_SIZE(bundle->cp_items));
> > > > +
> > > > + ptr =3D kzalloc(size, GFP_KERNEL);
> > > > + if (ptr) {
> > > > +         bundle =3D ptr + off;
> > > > +         atomic64_set(&bundle->revision, 1);
> > > > +         bundle->off =3D off;
> > > > +         bundle->a.parent =3D bundle;
> > > > +         bundle->b.parent =3D bundle;
> > > > +         return &bundle->a;
> > > > + }
> > > > + return NULL;
> > > > +}
> > > > +
> > > > +void bpf_mprog_free_rcu(struct rcu_head *rcu);
> > > > +
> > > > +static inline void bpf_mprog_free(struct bpf_mprog_entry *entry)
> > > > +{
> > > > + struct bpf_mprog_bundle *bundle =3D entry->parent;
> > > > +
> > > > + call_rcu(&bundle->rcu, bpf_mprog_free_rcu);
> > > > +}
> > >
> > > Any reason we're doing allocation here? Why not do
> > > bpf_mprog_init(struct bpf_mprog_bundle *) instead that simply initial=
izes
> > > the fields? Then we can move allocation/free part to the caller (tcx)=
 along
> > > with rcu_head.
> > > Feels like it would be a bit more conventional/readable? bpf_mprog_fr=
ee{,_rcu}
> > > will also become tcx_free{,_rcu}..
> > >
> > > I guess current approach works, but it took me awhile to figure it ou=
t..
> > > (maybe it's just me)
> >
> > I found this approach quite useful for tcx case since we only fetch the
> > bpf_mprog_entry for tcx_link_prog_attach et al, but I can take a look t=
o
> > see if this looks better and if it does I'll include it.
> >
> > > > +static inline void bpf_mprog_mark_ref(struct bpf_mprog_entry *entr=
y,
> > > > +                               struct bpf_tuple *tuple)
> > > > +{
> > > > + WARN_ON_ONCE(entry->parent->ref);
> > > > + if (!tuple->link)
> > > > +         entry->parent->ref =3D tuple->prog;
> > > > +}
> > > > +
> > > > +static inline void bpf_mprog_inc(struct bpf_mprog_entry *entry)
> > > > +{
> > > > + entry->parent->count++;
> > > > +}
> > > > +
> > > > +static inline void bpf_mprog_dec(struct bpf_mprog_entry *entry)
> > > > +{
> > > > + entry->parent->count--;
> > > > +}
> > > > +
> > > > +static inline int bpf_mprog_max(void)
> > > > +{
> > > > + return ARRAY_SIZE(((struct bpf_mprog_entry *)NULL)->fp_items) - 1=
;
> > > > +}
> > > > +
> > > > +static inline int bpf_mprog_total(struct bpf_mprog_entry *entry)
> > > > +{
> > > > + int total =3D entry->parent->count;
> > > > +
> > > > + WARN_ON_ONCE(total > bpf_mprog_max());
> > > > + return total;
> > > > +}
> > > > +
> > > > +static inline bool bpf_mprog_exists(struct bpf_mprog_entry *entry,
> > > > +                             struct bpf_prog *prog)
> > > > +{
> > > > + const struct bpf_mprog_fp *fp;
> > > > + const struct bpf_prog *tmp;
> > > > +
> > > > + bpf_mprog_foreach_prog(entry, fp, tmp) {
> > > > +         if (tmp =3D=3D prog)
> > > > +                 return true;
> > > > + }
> > > > + return false;
> > > > +}
> > > > +
> > > > +static inline bool bpf_mprog_swap_entries(const int code)
> > > > +{
> > > > + return code =3D=3D BPF_MPROG_SWAP ||
> > > > +        code =3D=3D BPF_MPROG_FREE;
> > > > +}
> > > > +
> > > > +static inline void bpf_mprog_commit(struct bpf_mprog_entry *entry)
> > > > +{
> > > > + atomic64_inc(&entry->parent->revision);
> > > > + synchronize_rcu();
> > >
> > > Maybe add a comment on why we need to synchronize_rcu here? In genera=
l,
> > > I don't think I have a good grasp of that ->ref member.
> >
> > Yeap, will add a comment. For the case where we delete the prog, we mar=
k
> > it in bpf_mprog_detach, but we can only drop the reference once the use=
r
> > swapped the bpf_mprog_entry and ensured that there are no in-flight use=
rs
> > hence both in bpf_mprog_commit.
> >
> > [...]
> > > > +static int bpf_mprog_prog(struct bpf_tuple *tuple,
> > > > +                   u32 object, u32 flags,
> > > > +                   enum bpf_prog_type type)
> > > > +{
> > > > + bool id =3D flags & BPF_F_ID;
> > > > + struct bpf_prog *prog;
> > > > +
> > > > + if (id)
> > > > +         prog =3D bpf_prog_by_id(object);
> > > > + else
> > > > +         prog =3D bpf_prog_get(object);
> > > > + if (IS_ERR(prog)) {
> > >
> > > [..]
> > >
> > > > +         if (!object && !id)
> > > > +                 return 0;
> > >
> > > What's the reason behind this?
> >
> > If an fd was passed which is 0 and this was not a program fd, then we d=
on't error
> > out and treat it as if no fd was passed.
>
> Is this new api an opportunity to fix that fd=3D=3D0? And always treat it=
 as
> valid. Or we have some other constrains elsewhere?

No. There is nothing to fix.

