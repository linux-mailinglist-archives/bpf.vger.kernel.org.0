Return-Path: <bpf+bounces-74598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA0AC5F9F1
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 00:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CDD3BF0E2
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39AC30E0D1;
	Fri, 14 Nov 2025 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5vIV5Pi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF42E0904
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763164040; cv=none; b=HEV97iyCTPBzvK68xA1YpvC7yEaCRjYPNkqnX7CEe6gNX9ZgOgFECWV/ivse0weSS75W/VQ4ok3jG0U8vUGEjZ2RpFJ1bDMGA92KuVIbHUezaMyIuwlkRp/UywSLOjl25hX7k9tG69CNC/mRkzpZE8ius53DzpYw+lSZFZVOkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763164040; c=relaxed/simple;
	bh=rRiNUuD82Njtw9Az/Jlw5gsSX+Uoa10hCquppI1qFlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEaQa9QuvTSw57Wrtb4YXpnp6eLr7Xhgb5zggwxzcLo71r2gANfocHQnk9TVrFBn4gE3Nr/OQRS3dvDBS9+amC/1eqr+3fOrE7NqPRSBxzUqzuOBEmWpGOtGuHrACkoa4QZsiDqccu63oY5C32o1uZFs21ucA/8SjB1+3esZnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5vIV5Pi; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-43376624a8fso21920775ab.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 15:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763164037; x=1763768837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+dHTSELWOX4g1S+bypOQNMHFzVUwDSPYwKAJt/DTjk=;
        b=R5vIV5Pi1nGiXwtnF6lYM4RNg3+csju9S8Yf+Nnxk99U6D9poXMISAukJBwFTYHiEw
         7YGJsnihEa8AsTWEKvB5oQQlgkv2B5/Gk0T0jyewUSFoSPqxhrlCRO1rBz12zqoAFvsR
         KOUNQKGc4jpOQX/Jzte+4IqovA+GMyxKhP9XGsbNcg8J39FTnTRaUeHd6ZY7+jED7hoo
         tPszwvHZ+XYq2tBe9LIyJ6D1XO6qsUpxVCIhMUDQV/sQC6gS4gUsKi0if61XvukIHHnt
         ZEPirGMrUlZ4FkkwF9XHx7Yc6XJnBnM+BE2pnXMkcA0Ad+BQZkltG+6GVyN+rg1omrfi
         Rnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763164037; x=1763768837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f+dHTSELWOX4g1S+bypOQNMHFzVUwDSPYwKAJt/DTjk=;
        b=wFhm0pI7OhaLMS7Wg3oKK4o6VoVLBemhQm6hBOOvuUGrXlRPWeCTNgcm6rBlyF1F65
         at4CK/cr9xhD/FjIQMY6dwihY8G4TS8CNrodBs5/uxA+NShyNpH+O2dZT/qISEqR4BRl
         yQ0Hk2KZIhX5Z6D2Qm+d/YaZJpTgc732VT08kVbg3NGdfS58E0bhOoTolZERoOwaRijT
         UEcV9nCiyWx36LEemxuaGIWfjMlnylg9ATg/ABR/sXFfDuQerIwEvhQLWMcPRkkxQgWc
         zgauVU3W3l8jghRBF+lHH4ra70FXcDRIVW9tWpkYj8E2WtVYAHlB+yLVhCDmPeqYJaYt
         F+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWs9mSJfBc5jHVwp6CD2udIrCF9f6BfvFAEGsauRFct4DyXBXZEXu/o3gbGyHJSHqAtf9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye4TU4FxTl4PXjPnjKKim+Cu1FOZLB4Ry+lidkBWh+p0efBh9y
	7+Aef649NWjr6YuctRsei2eidnwrWS3prKv/d6QAzp1Hwsn1c/ny7kw/ncXvQ+A7ITfOxZGxsMN
	ovXVHWF3PmYvzzmccXbFL4t85gQYx8K4=
X-Gm-Gg: ASbGncugSePKYNzXRRBBjSnFAw2mCQe2V7ZCHBfdx6a+GZQrNHhp0MOBcz6KorrJMDZ
	Co90Hl3af3HWFPWi4C1Nzs1wIO4MrWSL7ahmy1i+ieL4WkJ/CBHV2li65cPhx+eeHJY/GMkmOBp
	Of8ji66VLFkyex1UpDkEuEAJfVFT+hJv7ORzwPrnfXKNnvSyNm1ZZ/wGCdEHwF6KxzuVrQ3h4Sf
	DD0JZQ5BkCXr6A6/7hJZRd1whai6FbF1uNpObObOGLRvQQzbqBX7T9SqIfrhvL6KrI87pzyfq8=
X-Google-Smtp-Source: AGHT+IGjxGDpylUhD4H15y1sXE9Da+4lAPuUV8p09QpDzb1wC0FtsMIgVaCJT5YLn1xuxFKV7DJaqis12R1X1hOck5M=
X-Received: by 2002:a05:6e02:214e:b0:433:6f20:32cc with SMTP id
 e9e14a558f8ab-4348c93e8d2mr68092675ab.16.1763164037337; Fri, 14 Nov 2025
 15:47:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031093230.82386-1-kerneljasonxing@gmail.com>
 <20251031093230.82386-3-kerneljasonxing@gmail.com> <aQTBajODN3Nnskta@boxer>
 <CAL+tcoDGiYogC=xiD7=K6HBk7UaOWKCFX8jGC=civLDjsBb3fA@mail.gmail.com>
 <aQjDjaQzv+Y4U6NL@boxer> <CAL+tcoBkO98eBGX0uOUo_bvsPFbnGvSYvY-ZaKJhSn7qac464g@mail.gmail.com>
 <CAJ8uoz2ZaJ5uYhd-MvSuYwmWUKKKBSfkq17rJGO98iTJ+iUrQg@mail.gmail.com>
 <CAL+tcoBw4eS8QO+AxSk=-vfVSb-7VtZMMNfZTZtJCp=SMpy0GQ@mail.gmail.com> <aRdQWqKs29U7moXq@boxer>
In-Reply-To: <aRdQWqKs29U7moXq@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 15 Nov 2025 07:46:40 +0800
X-Gm-Features: AWmQ_bmE0Z-PLAEtPZn1VZOb_K3RvYs9-GPON81ZsU8OyeGoKWJSSfERxIMSg_M
Message-ID: <CAL+tcoAv+dTK-Z=HNGUJNohxRu_oWCPQ4L1BRQT9nvB4WZMd7Q@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 2/2] xsk: introduce a cached cq to
 temporarily store descriptor addrs
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	fmancera@suse.de, csmate@nop.hu, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 11:53=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Tue, Nov 11, 2025 at 10:02:58PM +0800, Jason Xing wrote:
> > Hi Magnus,
> >
> > On Tue, Nov 11, 2025 at 9:44=E2=80=AFPM Magnus Karlsson
> > <magnus.karlsson@gmail.com> wrote:
> > >
> > > On Tue, 11 Nov 2025 at 14:06, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
> > > >
> > > > Hi Maciej,
> > > >
> > > > On Mon, Nov 3, 2025 at 11:00=E2=80=AFPM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > On Sat, Nov 01, 2025 at 07:59:36AM +0800, Jason Xing wrote:
> > > > > > On Fri, Oct 31, 2025 at 10:02=E2=80=AFPM Maciej Fijalkowski
> > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > >
> > > > > > > On Fri, Oct 31, 2025 at 05:32:30PM +0800, Jason Xing wrote:
> > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > >
> > > > > > > > Before the commit 30f241fcf52a ("xsk: Fix immature cq descr=
iptor
> > > > > > > > production"), there is one issue[1] which causes the wrong =
publish
> > > > > > > > of descriptors in race condidtion. The above commit fixes t=
he issue
> > > > > > > > but adds more memory operations in the xmit hot path and in=
terrupt
> > > > > > > > context, which can cause side effect in performance.
> > > > > > > >
> > > > > > > > This patch tries to propose a new solution to fix the probl=
em
> > > > > > > > without manipulating the allocation and deallocation of mem=
ory. One
> > > > > > > > of the key points is that I borrowed the idea from the abov=
e commit
> > > > > > > > that postpones updating the ring->descs in xsk_destruct_skb=
()
> > > > > > > > instead of in __xsk_generic_xmit().
> > > > > > > >
> > > > > > > > The core logics are as show below:
> > > > > > > > 1. allocate a new local queue. Only its cached_prod member =
is used.
> > > > > > > > 2. write the descriptors into the local queue in the xmit p=
ath. And
> > > > > > > >    record the cached_prod as @start_addr that reflects the
> > > > > > > >    start position of this queue so that later the skb can e=
asily
> > > > > > > >    find where its addrs are written in the destruction phas=
e.
> > > > > > > > 3. initialize the upper 24 bits of destructor_arg to store =
@start_addr
> > > > > > > >    in xsk_skb_init_misc().
> > > > > > > > 4. Initialize the lower 8 bits of destructor_arg to store h=
ow many
> > > > > > > >    descriptors the skb owns in xsk_update_num_desc().
> > > > > > > > 5. write the desc addr(s) from the @start_addr from the cac=
hed cq
> > > > > > > >    one by one into the real cq in xsk_destruct_skb(). In tu=
rn sync
> > > > > > > >    the global state of the cq.
> > > > > > > >
> > > > > > > > The format of destructor_arg is designed as:
> > > > > > > >  ------------------------ --------
> > > > > > > > |       start_addr       |  num   |
> > > > > > > >  ------------------------ --------
> > > > > > > > Using upper 24 bits is enough to keep the temporary descrip=
tors. And
> > > > > > > > it's also enough to use lower 8 bits to show the number of =
descriptors
> > > > > > > > that one skb owns.
> > > > > > > >
> > > > > > > > [1]: https://lore.kernel.org/all/20250530095957.43248-1-e.k=
ubanski@partner.samsung.com/
> > > > > > > >
> > > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > > ---
> > > > > > > > I posted the series as an RFC because I'd like to hear more=
 opinions on
> > > > > > > > the current rought approach so that the fix[2] can be avoid=
ed and
> > > > > > > > mitigate the impact of performance. This patch might have b=
ugs because
> > > > > > > > I decided to spend more time on it after we come to an agre=
ement. Please
> > > > > > > > review the overall concepts. Thanks!
> > > > > > > >
> > > > > > > > Maciej, could you share with me the way you tested jumbo fr=
ame? I used
> > > > > > > > ./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but the xdpsock ut=
ilizes the
> > > > > > > > nic more than 90%, which means I cannot see the performance=
 impact.
> > > > > >
> > > > > > Could you provide the command you used? Thanks :)
> > > > > >
> > > > > > > >
> > > > > > > > [2]:https://lore.kernel.org/all/20251030140355.4059-1-fmanc=
era@suse.de/
> > > > > > > > ---
> > > > > > > >  include/net/xdp_sock.h      |   1 +
> > > > > > > >  include/net/xsk_buff_pool.h |   1 +
> > > > > > > >  net/xdp/xsk.c               | 104 ++++++++++++++++++++++++=
++++--------
> > > > > > > >  net/xdp/xsk_buff_pool.c     |   1 +
> > > > > > > >  4 files changed, 84 insertions(+), 23 deletions(-)
> > > > > > >
> > > > > > > (...)
> > > > > > >
> > > > > > > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_poo=
l.c
> > > > > > > > index aa9788f20d0d..6e170107dec7 100644
> > > > > > > > --- a/net/xdp/xsk_buff_pool.c
> > > > > > > > +++ b/net/xdp/xsk_buff_pool.c
> > > > > > > > @@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_create_and_assig=
n_umem(struct xdp_sock *xs,
> > > > > > > >
> > > > > > > >       pool->fq =3D xs->fq_tmp;
> > > > > > > >       pool->cq =3D xs->cq_tmp;
> > > > > > > > +     pool->cached_cq =3D xs->cached_cq;
> > > > > > >
> > > > > > > Jason,
> > > > > > >
> > > > > > > pool can be shared between multiple sockets that bind to same=
 <netdev,qid>
> > > > > > > tuple. I believe here you're opening up for the very same iss=
ue Eryk
> > > > > > > initially reported.
> > > > > >
> > > > > > Actually it shouldn't happen because the cached_cq is more of t=
he
> > > > > > temporary array that helps the skb store its start position. Th=
e
> > > > > > cached_prod of cached_cq can only be increased, not decreased. =
In the
> > > > > > skb destruction phase, only those skbs that go to the end of li=
fe need
> > > > > > to sync its desc from cached_cq to cq. For some skbs that are r=
eleased
> > > > > > before the tx completion, we don't need to clear its record in
> > > > > > cached_cq at all and cq remains untouched.
> > > > > >
> > > > > > To put it in a simple way, the patch you proposed uses kmem_cac=
hed*
> > > > > > helpers to store the addr and write the addr into cq at the end=
 of
> > > > > > lifecycle while the current patch uses a pre-allocated memory t=
o
> > > > > > store. So it avoids the allocation and deallocation.
> > > > > >
> > > > > > Unless I'm missing something important. If so, I'm still convin=
ced
> > > > > > this temporary queue can solve the problem since essentially it=
's a
> > > > > > better substitute for kmem cache to retain high performance.
>
> Back after health issues!

Hi Maciej,

Hope you're fully recovered:)

>
> Jason, I am still not convinced about this solution.
>
> In shared pool setups, the temp cq will also be shared, which means that
> two parallel processes can produce addresses onto temp cq and therefore
> expose address to a socket that it does not belong to. In order to make
> this work you would have to know upfront the descriptor count of given
> frame and reserve this during processing the first descriptor.
>
> socket 0                        socket 1
> prod addr 0xAA
> prod addr 0xBB
>                                 prod addr 0xDD
> prod addr 0xCC
>                                 prod addr 0xEE
>
> socket 0 calls skb destructor with num desc =3D=3D 3, placing 0xDD onto c=
q
> which has not been sent yet, therefore potentially corrupting it.

Thanks for spotting this case!

Yes, it can happen, so let's turn into a per-xsk granularity? If each
xsk has its own temp queue, then the problem would disappear and good
news is that we don't need extra locks like pool->cq_lock to prevent
multiple parallel xsks accessing the temp queue.

Hope you can agree with this method. It borrows your idea and then
only uses a _pre-allocated buffer_ to replace kmem_cache_alloc() in
the hot path. This solution will direct us more to a high performance
direction. IMHO, I=E2=80=98d rather not see any degradation in performance
because of some issues.

Thanks,
Jason

>
> For now, I think we should move forward with Fernando's fix as there have
> been multiple reports already regarding broken state of xsk copy mode.
>
> > > > >
> > > > > I need a bit more time on this, probably I'll respond tomorrow.
> > > >
> > > > I'd like to know if you have any further comments on this? And shou=
ld
> > > > I continue to post as an official series?
> > >
> > > Hi Jason,
> > >
> > > Maciej has been out-of-office for a couple of days. He should
> > > hopefully be back later this week, so please wait for his comments.
> >
> > Thanks for letting me know. I will wait :)
> >
> > Thanks,
> > Jason

