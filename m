Return-Path: <bpf+bounces-67181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4832BB4048A
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 15:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3726B4E3DB9
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 13:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E1831197D;
	Tue,  2 Sep 2025 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbVj+c5V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F34261593;
	Tue,  2 Sep 2025 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820359; cv=none; b=EekG/JVaqMvJNf/RIoUPs1DDo7lPYX6Lo7sTYaRRkMG8B65JFhdnVFTlZK1+XQDvyb6AP7oNrgQQZQSPt5L43Kw16Euo2+C5V6HRwg9ZOjp8ux16/An3tOboI3sccMQIFs3y3iNLodyTEVV8fyC3BfzkR10tlP5287t/U3OM43k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820359; c=relaxed/simple;
	bh=PQ0Pgo1ptWVhCQFI4t7jgtohrDWSDauWxH8+/TI3uSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rF3RwCzUmHGCtH85992khXWfa9TtzHnOA8C8tm78Q4J+Ehn+TNg1/fgLO6IsnUYVa3lt/TnFWqW0lOdn6opqCGcTMsEumxPrWaB7gHu9ha5XpZpTHdOPzAaWf9JWemBlkfKZ2cBrPU491RnGfa2XO8H3SxCU8FohA2Rp6g5r7xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbVj+c5V; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-88432e29adcso178037639f.2;
        Tue, 02 Sep 2025 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756820356; x=1757425156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm0i6cLmDYL1qv1teKoUVA7Oadkpt2JqAprTnUrssZs=;
        b=bbVj+c5VYRVrjSsiKlG2aiIL92k94tHjzPw5kwCFV/kCRrdc0yfYRQadLES/y2Rw7r
         QlDde/eMn40Geqj5dIfnG5WQWFL39mvTy0714J72bphaFCF+h7HR3Ea+pcp/mxfENLkc
         EM2SvTWU2T+Ha5eKEukYcK74LK6GQ1axq4wtJFzUUs9SGF7tyaeuS+hFXxNhNrQMSAAl
         gK60TBUIV07oZk8zo4LLk/n/ki7XgGE3iGT1qCl0ZOtRvzGfxEttcwlJAULuSEdcgAmp
         zMDkvFpVg29iHFwVSxYYBmq8dQXlO0crnq4CrfeVmIeFNp28kfsW0uX3eIWxv13hv6On
         NYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756820356; x=1757425156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jm0i6cLmDYL1qv1teKoUVA7Oadkpt2JqAprTnUrssZs=;
        b=QQk0QrR+iTpqkuQCXXm4vNZEVjBpR1j6H4iAqTP9JDP3MZD0JbbHPAf6GB4F3m0tqZ
         5a+uUT5DVjhYXt0ZsXNSzaF1i/brDSitUNnYIMNEC4YcTZ+Z+Wsd4qatP1Y5VEX564rn
         Sbxnc4iqYnDvV2aKapFjSerXj++/PSTkOkYaZPSt7FFSAtqJCy/Mt5psYUKdnSACY3XT
         vNaYIL08URAWOa6rKRvuJPCBIdJegwQl/hdYGuO+WAHF612kz+ccWOapUKzdmmLvXgw0
         CC6yUil2b3cxXQB0Qts+CGud7n8oG4l2QrMj2Tq8UCof8XNKr4BeK1EEXKRruDMpNC7U
         QP+A==
X-Forwarded-Encrypted: i=1; AJvYcCX5SlFwDUyfM8KC39Qq9FWCVzBi2dKJRmwwM14HOymwBp1d1sCFFkog/1/1loyYbKCUbyvRWS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLg10TEvPr4jje/+0RwCLEMSlBXbJKSIkitsHkI9J7LRHs3Y+P
	uKDPUvLxVAsccbJy1Yg/PihSKN3F46Eg6VHcPmDfjiIQ3uRKOR4jeXc77/DyKlbmMLxBAAfTyt2
	uCK28FQDtgEcLeYAOvia/OTdAgtTulkc=
X-Gm-Gg: ASbGnctEShBjneK002L8lMMNOFMEjWWdkwCA8NCI3tm8W3SLv+7vKbXsc6lPSIxJ1T0
	Wf8eunJmKYKenEV3dy6NyUUvEccQfxUdlVhIHqTZPyBXXb+NJSQC9fcAVZxdJJr4BB4WYTmgOAr
	TX8anUXnKVH6KQsk+uNhqC4mA0LZXoK4WzOqEz1OK3KyJJfY/Rc7T5KvlLDSv4uZbcBcmIta0qT
	rW73ccNZmo/HZNu
X-Google-Smtp-Source: AGHT+IFM0o4sQxMQ/QhuYwaLuPT+oAMbEic85xvIQ4wg3kxQxPxmd83p+r7ZvU+Z+xmLSocn3gMj+ufSAJyFDARolaU=
X-Received: by 2002:a05:6e02:440a:10b0:3f6:5675:a17b with SMTP id
 e9e14a558f8ab-3f65675a3a3mr42249345ab.27.1756820354821; Tue, 02 Sep 2025
 06:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829180950.2305157-1-maciej.fijalkowski@intel.com>
 <CAL+tcoA2MK72wWGXL-RR2Rf+01_tKpSZo7x6VFM+N4DthBK+=w@mail.gmail.com>
 <aLYD2iq+traoJZ7R@boxer> <CAL+tcoAKVRs9nnAHeOA=2kN3Hf_zSS5z64yUSEVmtiS82zz3-Q@mail.gmail.com>
 <aLbNNInuSjkC5qbI@boxer>
In-Reply-To: <aLbNNInuSjkC5qbI@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 2 Sep 2025 21:38:37 +0800
X-Gm-Features: Ac12FXxHOVLZO9LmiaYGGN5fscqCdBSIAlH_d0uUhKw3dLjswL1JTbyxmjNoJto
Message-ID: <CAL+tcoAiY1_OvVAJwWj-YwWY3_9QOWQ_Dwsn5V4vy+wnOQJJog@mail.gmail.com>
Subject: Re: [PATCH v7 bpf] xsk: fix immature cq descriptor production
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, Eryk Kubanski <e.kubanski@partner.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 6:56=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Tue, Sep 02, 2025 at 08:02:30AM +0800, Jason Xing wrote:
> > On Tue, Sep 2, 2025 at 4:37=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Tue, Sep 02, 2025 at 12:09:39AM +0800, Jason Xing wrote:
> > > > On Sat, Aug 30, 2025 at 2:10=E2=80=AFAM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > Eryk reported an issue that I have put under Closes: tag, related=
 to
> > > > > umem addrs being prematurely produced onto pool's completion queu=
e.
> > > > > Let us make the skb's destructor responsible for producing all ad=
drs
> > > > > that given skb used.
> > > > >
> > > > > Commit from fixes tag introduced the buggy behavior, it was not b=
roken
> > > > > from day 1, but rather when XSK multi-buffer got introduced.
> > > > >
> > > > > In order to mitigate performance impact as much as possible, mimi=
c the
> > > > > linear and frag parts within skb by storing the first address fro=
m XSK
> > > > > descriptor at sk_buff::destructor_arg. For fragments, store them =
at ::cb
> > > > > via list. The nodes that will go onto list will be allocated via
> > > > > kmem_cache. xsk_destruct_skb() will consume address stored at
> > > > > ::destructor_arg and optionally go through list from ::cb, if cou=
nt of
> > > > > descriptors associated with this particular skb is bigger than 1.
> > > > >
> > > > > Previous approach where whole array for storing UMEM addresses fr=
om XSK
> > > > > descriptors was pre-allocated during first fragment processing yi=
elded
> > > > > too big performance regression for 64b traffic. In current approa=
ch
> > > > > impact is much reduced on my tests and for jumbo frames I observe=
d
> > > > > traffic being slower by at most 9%.
> > > > >
> > > > > Magnus suggested to have this way of processing special cased for
> > > > > XDP_SHARED_UMEM, so we would identify this during bind and set di=
fferent
> > > > > hooks for 'backpressure mechanism' on CQ and for skb destructor, =
but
> > > > > given that results looked promising on my side I decided to have =
a
> > > > > single data path for XSK generic Tx. I suppose other auxiliary st=
uff
> > > > > such as helpers introduced in this patch would have to land as we=
ll in
> > > > > order to make it work, so we might have ended up with more noisy =
diff.
> > > > >
> > > > > Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for sup=
porting multi-buffer in Tx path")
> > > > > Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> > > > > Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.k=
ubanski@partner.samsung.com/
> > > > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > > ---
> > > > >
> > > > > Jason, please test this v7 on your setup, I would appreciate if y=
ou
> > > > > would report results from your testbed. Thanks!
> > > > >
> > > > > v1:
> > > > > https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijal=
kowski@intel.com/
> > > > > v2:
> > > > > https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijal=
kowski@intel.com/
> > > > > v3:
> > > > > https://lore.kernel.org/bpf/20250806154127.2161434-1-maciej.fijal=
kowski@intel.com/
> > > > > v4:
> > > > > https://lore.kernel.org/bpf/20250813171210.2205259-1-maciej.fijal=
kowski@intel.com/
> > > > > v5:
> > > > > https://lore.kernel.org/bpf/aKXBHGPxjpBDKOHq@boxer/T/
> > > > > v6:
> > > > > https://lore.kernel.org/bpf/20250820154416.2248012-1-maciej.fijal=
kowski@intel.com/
> > > > >
> > > > > v1->v2:
> > > > > * store addrs in array carried via destructor_arg instead having =
them
> > > > >   stored in skb headroom; cleaner and less hacky approach;
> > > > > v2->v3:
> > > > > * use kmem_cache for xsk_addrs allocation (Stan/Olek)
> > > > > * set err when xsk_addrs allocation fails (Dan)
> > > > > * change xsk_addrs layout to avoid holes
> > > > > * free xsk_addrs on error path
> > > > > * rebase
> > > > > v3->v4:
> > > > > * have kmem_cache as percpu vars
> > > > > * don't drop unnecessary braces (unrelated) (Stan)
> > > > > * use idx + i in xskq_prod_write_addr (Stan)
> > > > > * alloc kmem_cache on bind (Stan)
> > > > > * keep num_descs as first member in xsk_addrs (Magnus)
> > > > > * add ack from Magnus
> > > > > v4->v5:
> > > > > * have a single kmem_cache per xsk subsystem (Stan)
> > > > > v5->v6:
> > > > > * free skb in xsk_build_skb_zerocopy() when xsk_addrs allocation =
fails
> > > > >   (Stan)
> > > > > * unregister netdev notifier if creating kmem_cache fails (Stan)
> > > > > v6->v7:
> > > > > * don't include Acks from Magnus/Stan; let them review the new
> > > > >   approach:)
> > > > > * store first desc at sk_buff::destructor_arg and rest of frags i=
n list
> > > > >   stored at sk_buff::cb
> > > > > * keep the kmem_cache but don't use it for allocation of whole ar=
ray at
> > > > >   one shot but rather alloc single nodes of list
> > > > >
> > > > > ---
> > > > >  net/xdp/xsk.c       | 99 ++++++++++++++++++++++++++++++++++++++-=
------
> > > > >  net/xdp/xsk_queue.h | 12 ++++++
> > > > >  2 files changed, 97 insertions(+), 14 deletions(-)
> > > > >
>
> (...)
>
> > > > >  {
> > > > > -       long num =3D xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
> > > > > -
> > > > > -       skb_shinfo(skb)->destructor_arg =3D (void *)num;
> > > > > +       INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> > > > > +       XSKCB(skb)->num_descs =3D 0;
> > > > > +       skb_shinfo(skb)->destructor_arg =3D (void *)addr;
> > > > >  }
> > > > >
> > > > >  static void xsk_consume_skb(struct sk_buff *skb)
> > > > >  {
> > > > >         struct xdp_sock *xs =3D xdp_sk(skb->sk);
> > > > > +       u32 num_descs =3D xsk_get_num_desc(skb);
> > > > > +       struct xsk_addr_node *pos, *tmp;
> > > > > +
> > > > > +       if (unlikely(num_descs > 1)) {
> > > >
> > > > I suspect the use of 'unlikely'. For some application turning on th=
e
> > > > multi-buffer feature, if it tries to transmit a large chunk of data=
,
> > > > it can become 'likely' then. So it depends how people use it.
> > >
> > > This pattern is used in major of XDP multi-buffer related code, for
> > > example:
> > > $ grep -irn "xdp_buff_has_frags" net/core/xdp.c
> > > 553:    if (likely(!xdp_buff_has_frags(xdp)))
> > > 641:    if (unlikely(xdp_buff_has_frags(xdp))) {
> > > 777:    if (unlikely(xdp_buff_has_frags(xdp)) &&
> > >
> > > Drivers however tend to be mixed around this.
> >
> > I see. And I have no strong opinion on this.
> >
> > >
> > > >
> > > > > +               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->a=
ddrs_list, addr_node) {
> > > >
> > > > It seems no need to use xxx_safe() since the whole process (from
> > > > allocating skb to freeing skb) makes sure each skb can be processed
> > > > atomically?
> > >
> > > We're deleting nodes from linked list so we need the @tmp for further=
 list
> > > traversal, I'm not following your statement about atomicity here?
> >
> > I mean this list is chained around each skb. It's not possible for one
> > skb to do the allocation operation and free operation at the same
> > time, right? That means it's not possible for one list to do the
> > delete operation and add operation at the same time. If so, the
> > xxx_safe() seems unneeded.
>
> _safe() variants are meant to allow you to delete nodes while traversing
> the list.
> You wouldn't be able to traverse the list when in body of the loop nodes
> are deleted as the ->next pointer is poisoned by list_del(). _safe()
> variant utilizes additional 'tmp' parameter to allow you doing this
> operation.

Sure, this is exactly how _safe() works. My take is we don't need to
use _safe() to keep safety because it's not possible for one reader
traversing the entire addr list while another one is trying to delete
node. If it can happen, then _safe() does make sense.

>
> I feel like you misunderstood these macros as they would provide some kin=
d
> of serialization mechanism.
>
> >
> > >
> > > >
> > > > > +                       list_del(&pos->addr_node);
> > > > > +                       kmem_cache_free(xsk_tx_generic_cache, pos=
);
> > > > > +               }
> > > > > +       }
> > > > >
> > > > >         skb->destructor =3D sock_wfree;
> > > > > -       xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
> > > > > +       xsk_cq_cancel_locked(xs->pool, num_descs);
> > > > >         /* Free skb without triggering the perf drop trace */
> > > > >         consume_skb(skb);
> > > > >         xs->skb =3D NULL;
> > > > > @@ -623,6 +668,8 @@ static struct sk_buff *xsk_build_skb_zerocopy=
(struct xdp_sock *xs,
> > > > >                         return ERR_PTR(err);
> > > > >
> > > > >                 skb_reserve(skb, hr);
> > > > > +
> > > > > +               xsk_set_destructor_arg(skb, desc->addr);
> > > > >         }
> > > > >
> > > > >         addr =3D desc->addr;
> > > > > @@ -694,6 +741,8 @@ static struct sk_buff *xsk_build_skb(struct x=
dp_sock *xs,
> > > > >                         err =3D skb_store_bits(skb, 0, buffer, le=
n);
> > > > >                         if (unlikely(err))
> > > > >                                 goto free_err;
> > > > > +
> > > > > +                       xsk_set_destructor_arg(skb, desc->addr);
> > > > >                 } else {
> > > > >                         int nr_frags =3D skb_shinfo(skb)->nr_frag=
s;
> > > > >                         struct page *page;
> > > > > @@ -759,7 +808,19 @@ static struct sk_buff *xsk_build_skb(struct =
xdp_sock *xs,
> > > > >         skb->mark =3D READ_ONCE(xs->sk.sk_mark);
> > > > >         skb->destructor =3D xsk_destruct_skb;
> > > > >         xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta=
);
> > > > > -       xsk_set_destructor_arg(skb);
> > > > > +
> > > > > +       xsk_inc_num_desc(skb);
> > > > > +       if (unlikely(xsk_get_num_desc(skb) > 1)) {
> > > > > +               struct xsk_addr_node *xsk_addr;
> > > > > +
> > > > > +               xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cac=
he, GFP_KERNEL);
> > > > > +               if (!xsk_addr) {
> > > >
> > > > num of descs needs to be decreased by one here? We probably miss th=
e
> > > > chance to add this addr node into the list this time. Sorry, I'm no=
t
> > > > so sure if this err path handles correctly.
> > >
> > > In theory yes, but xsk_consume_skb() will not crash without this by a=
ny
> > > means. If we would have a case where we failed on second frag, @num_d=
escs
> > > would indeed by 2 but addrs_list would just be empty.
> >
> > I wasn't stating very clearly. If the second frag fails on the above
> > step, next time in xsk_consume_skb() the same skb will try to revisit
>
> you meant xsk_build_skb() I assume?

Oh, yes.

>
> > the second frag/desc because of xsk_cq_cancel_locked(xs->pool, 1); in
> > xsk_build_skb(). Then it will try to re-allocate the page for the
> > second desc by calling alloc_page() in xsk_consume_skb()? IIUC, it
> > will be messy around this skb. Finally, the descs of this skb will be
> > increased to 3, which should be 2 actually if the skb only needs to
> > carry two frags/descs?
>
> You're correct here! Even though it would not hurt later successful send
> case, other paths that use xsk_get_num_desc() would be broken - say that
> you failed at one point with kmem_cache_zalloc() and then you succeed, yo=
u
> have your full skb that is passed to ndo_start_xmit() but it ends with
> NETDEV_TX_BUSY - then even xskq_cons_cancel_n() is fed with wrong value.
> And regarding alloc_page - skb would carry doubled frag in
> skb_shared_info.
>
> This is rather unlikely to happen, but needs to be addressed of course.
> There are two approaches, either we do the allocations upfront or free
> whole skb when kmem cache allocation fails.
>
> I'll send a v8 with this fixed, but overall this path needs a refactor...

Looking forward to your update version:)

Thanks,
Jason

