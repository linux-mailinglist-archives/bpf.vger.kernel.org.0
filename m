Return-Path: <bpf+bounces-74823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D71C669CF
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B3114E481B
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CA81DE4C2;
	Tue, 18 Nov 2025 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMY2YsHC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A625478D
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 00:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763424152; cv=none; b=RBhv8Tffc+5GSiW0o+fpMHkIaoqjUqot+mTDSzk7QGaHxrpuTdZGKXthGVVOt+Ypql5C+kUc6mYD51dsrlhxjSIp/42kibDuXIsyKCEB3EKKoYap+Zac0Rll9BFMZUyKTYfIlZkYxSwmKpSUD9KNI1FkenEurYRLAYnjvPkeQJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763424152; c=relaxed/simple;
	bh=oJUUTdkH34Q21nC4n9VVlkwnucwmVWEVjCLA3+XPpss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Com8jmY+VTSoYszDFsKj14HOyobxAvRhMBTtpcpVaynPYb/moWDg1w7tvUZ84+EZD3qncRIg2Sw6wn9AMgpx7eVnWQ4Tlzwc+3TQiim4bsZ4RZ38dmNaI91qBVog/n9TbFoqT9dExwrio7cVLKGZlJG631JXwYtmBuy7u8IcZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMY2YsHC; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-9491604d00fso37509839f.2
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763424149; x=1764028949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=270VGl7SYGUoL8mTqWQkOrUTrdbm9V+OBP7UFLbQR6Q=;
        b=OMY2YsHCHz89qmbWeDvPpX1QcEkpendEkffEqdl3jNGlEN7y08XtmxjPPOHgUOmuAv
         1WKQLYF52U4VEMFUa1FaFBPDscmCQD007OEUj0t1F0OQ5P70vz3FDIg5gNRcvKlFWl1S
         ao1frkrE5C46WQczvollgW5M0HkkKad4FG/eEAlN6Tt1KsIDGXxQR3kPWHEjxRclHPZP
         KE5EHZ33fHQNRGc/5PfW1QojWefzK0XP2+O8uIBGYN6bPJMWTbex1T0au0CFTO18kqVF
         a4g3RNUZQGadCiFlnVOpZzlwAzI7ejAcdfkRH6u8oJ445m02PPSOGFCA/YNdnhQaW3+e
         +dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763424149; x=1764028949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=270VGl7SYGUoL8mTqWQkOrUTrdbm9V+OBP7UFLbQR6Q=;
        b=N0pc9ryDipQsaGHwC0F5UfVtVsOc4k+6iccSX0ajYvvn4lqzBEH9VoZ0VEtFiJfJEQ
         iy85dudJsBQ1njyGhSBd8vuFVqs2YGdVflnuOw3MM+FQzDdH/+5vlWiO1RPksIvj5mfX
         fkzIpsVgOdGnKPcjS1UlSPg57fjwepht5eDhZF/ITnZgLfRyEUASbQMul7tfJ3kTaHth
         X63BAFZ2/zVYI8V8yexPcNbXtGRThlszhumljTbUO0EIwuP1E4JEARbHzU29rLp07EL4
         1GTAks2wPXsrnVKuQOoLc0MhALFKjsZaXrEd8pIwtA5CimVabdUbYxY6A83PaBIGyAGQ
         NIOA==
X-Forwarded-Encrypted: i=1; AJvYcCXH2//BLAknzZJG8l7MPrA+ygmiTH5/Ec7fO3Ox6zpBdDjqpbT+Y+Mx2E/d0uPeXu98ebI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqvAzRSm96NxNB7UwMg5GkOzBoecrlDLa8TsAnvfP4Vwg4P28i
	ncwGJFSJoEuhHmzYhut+EOBrjFBkDLO96/4Zc0qPvCc6zJ43iIlFLCAMqbunzkLlR/uoCEckZda
	YSf5YlmR6EFf8ktM9cKJl52XuxFHW8Hs=
X-Gm-Gg: ASbGnctIU0rDwLekyBqJDYf+y5N09KrSfbQJr7Hd+pquaz8wZFy2aQgQs3hxO0Ey+jR
	M/RZNt5iV2TBxZpoDBi+EgbZpJ2TGIPfaIwe2th9SHSdEKNXBuylyn6ZjKEdtFW+LgA/Eu49e6/
	1Qx8Jd2sTmZ2Zb64VhGfaopcDvP9br+ZgbpeJxEcfxj9UNH3EHYnAaZkgBjoMhUj0CdEK36YqB7
	r0NmmTWhgsJtoheSIyc+DeaGzYoSMwfQzLjnCgszEw3kX67gUJhi//0ETni
X-Google-Smtp-Source: AGHT+IEPaJsn4whbsrrHi5RQMpQc10aGlgiXqwejfFwkCkhl4w9/E9OgTW9XMPcx+huI9pYeCtyQ918XwJeLIdLXkz0=
X-Received: by 2002:a05:6e02:1d87:b0:433:7b22:c2b5 with SMTP id
 e9e14a558f8ab-4348c86aa77mr159220795ab.13.1763424149275; Mon, 17 Nov 2025
 16:02:29 -0800 (PST)
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
 <CAL+tcoBw4eS8QO+AxSk=-vfVSb-7VtZMMNfZTZtJCp=SMpy0GQ@mail.gmail.com>
 <aRdQWqKs29U7moXq@boxer> <CAL+tcoAv+dTK-Z=HNGUJNohxRu_oWCPQ4L1BRQT9nvB4WZMd7Q@mail.gmail.com>
 <aRtHvooD0IWWb4Cx@boxer>
In-Reply-To: <aRtHvooD0IWWb4Cx@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 18 Nov 2025 08:01:52 +0800
X-Gm-Features: AWmQ_bmT3PN_aUMvpDNTCoIEGHFjkV1nd8DeEOVO6QoEXP5nEOlQ40le1xQl3XM
Message-ID: <CAL+tcoBTuOnnhAUD9gwbt8VBf+m=c08c-+cOUyjuPLyx29xUWw@mail.gmail.com>
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

On Tue, Nov 18, 2025 at 12:05=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sat, Nov 15, 2025 at 07:46:40AM +0800, Jason Xing wrote:
> > On Fri, Nov 14, 2025 at 11:53=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Tue, Nov 11, 2025 at 10:02:58PM +0800, Jason Xing wrote:
> > > > Hi Magnus,
> > > >
> > > > On Tue, Nov 11, 2025 at 9:44=E2=80=AFPM Magnus Karlsson
> > > > <magnus.karlsson@gmail.com> wrote:
> > > > >
> > > > > On Tue, 11 Nov 2025 at 14:06, Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
> > > > > >
> > > > > > Hi Maciej,
> > > > > >
> > > > > > On Mon, Nov 3, 2025 at 11:00=E2=80=AFPM Maciej Fijalkowski
> > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > >
> > > > > > > On Sat, Nov 01, 2025 at 07:59:36AM +0800, Jason Xing wrote:
> > > > > > > > On Fri, Oct 31, 2025 at 10:02=E2=80=AFPM Maciej Fijalkowski
> > > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Oct 31, 2025 at 05:32:30PM +0800, Jason Xing wrot=
e:
> > > > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > > > >
> > > > > > > > > > Before the commit 30f241fcf52a ("xsk: Fix immature cq d=
escriptor
> > > > > > > > > > production"), there is one issue[1] which causes the wr=
ong publish
> > > > > > > > > > of descriptors in race condidtion. The above commit fix=
es the issue
> > > > > > > > > > but adds more memory operations in the xmit hot path an=
d interrupt
> > > > > > > > > > context, which can cause side effect in performance.
> > > > > > > > > >
> > > > > > > > > > This patch tries to propose a new solution to fix the p=
roblem
> > > > > > > > > > without manipulating the allocation and deallocation of=
 memory. One
> > > > > > > > > > of the key points is that I borrowed the idea from the =
above commit
> > > > > > > > > > that postpones updating the ring->descs in xsk_destruct=
_skb()
> > > > > > > > > > instead of in __xsk_generic_xmit().
> > > > > > > > > >
> > > > > > > > > > The core logics are as show below:
> > > > > > > > > > 1. allocate a new local queue. Only its cached_prod mem=
ber is used.
> > > > > > > > > > 2. write the descriptors into the local queue in the xm=
it path. And
> > > > > > > > > >    record the cached_prod as @start_addr that reflects =
the
> > > > > > > > > >    start position of this queue so that later the skb c=
an easily
> > > > > > > > > >    find where its addrs are written in the destruction =
phase.
> > > > > > > > > > 3. initialize the upper 24 bits of destructor_arg to st=
ore @start_addr
> > > > > > > > > >    in xsk_skb_init_misc().
> > > > > > > > > > 4. Initialize the lower 8 bits of destructor_arg to sto=
re how many
> > > > > > > > > >    descriptors the skb owns in xsk_update_num_desc().
> > > > > > > > > > 5. write the desc addr(s) from the @start_addr from the=
 cached cq
> > > > > > > > > >    one by one into the real cq in xsk_destruct_skb(). I=
n turn sync
> > > > > > > > > >    the global state of the cq.
> > > > > > > > > >
> > > > > > > > > > The format of destructor_arg is designed as:
> > > > > > > > > >  ------------------------ --------
> > > > > > > > > > |       start_addr       |  num   |
> > > > > > > > > >  ------------------------ --------
> > > > > > > > > > Using upper 24 bits is enough to keep the temporary des=
criptors. And
> > > > > > > > > > it's also enough to use lower 8 bits to show the number=
 of descriptors
> > > > > > > > > > that one skb owns.
> > > > > > > > > >
> > > > > > > > > > [1]: https://lore.kernel.org/all/20250530095957.43248-1=
-e.kubanski@partner.samsung.com/
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > > > > ---
> > > > > > > > > > I posted the series as an RFC because I'd like to hear =
more opinions on
> > > > > > > > > > the current rought approach so that the fix[2] can be a=
voided and
> > > > > > > > > > mitigate the impact of performance. This patch might ha=
ve bugs because
> > > > > > > > > > I decided to spend more time on it after we come to an =
agreement. Please
> > > > > > > > > > review the overall concepts. Thanks!
> > > > > > > > > >
> > > > > > > > > > Maciej, could you share with me the way you tested jumb=
o frame? I used
> > > > > > > > > > ./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but the xdpsoc=
k utilizes the
> > > > > > > > > > nic more than 90%, which means I cannot see the perform=
ance impact.
> > > > > > > >
> > > > > > > > Could you provide the command you used? Thanks :)
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > [2]:https://lore.kernel.org/all/20251030140355.4059-1-f=
mancera@suse.de/
> > > > > > > > > > ---
> > > > > > > > > >  include/net/xdp_sock.h      |   1 +
> > > > > > > > > >  include/net/xsk_buff_pool.h |   1 +
> > > > > > > > > >  net/xdp/xsk.c               | 104 ++++++++++++++++++++=
++++++++--------
> > > > > > > > > >  net/xdp/xsk_buff_pool.c     |   1 +
> > > > > > > > > >  4 files changed, 84 insertions(+), 23 deletions(-)
> > > > > > > > >
> > > > > > > > > (...)
> > > > > > > > >
> > > > > > > > > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff=
_pool.c
> > > > > > > > > > index aa9788f20d0d..6e170107dec7 100644
> > > > > > > > > > --- a/net/xdp/xsk_buff_pool.c
> > > > > > > > > > +++ b/net/xdp/xsk_buff_pool.c
> > > > > > > > > > @@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_create_and_a=
ssign_umem(struct xdp_sock *xs,
> > > > > > > > > >
> > > > > > > > > >       pool->fq =3D xs->fq_tmp;
> > > > > > > > > >       pool->cq =3D xs->cq_tmp;
> > > > > > > > > > +     pool->cached_cq =3D xs->cached_cq;
> > > > > > > > >
> > > > > > > > > Jason,
> > > > > > > > >
> > > > > > > > > pool can be shared between multiple sockets that bind to =
same <netdev,qid>
> > > > > > > > > tuple. I believe here you're opening up for the very same=
 issue Eryk
> > > > > > > > > initially reported.
> > > > > > > >
> > > > > > > > Actually it shouldn't happen because the cached_cq is more =
of the
> > > > > > > > temporary array that helps the skb store its start position=
. The
> > > > > > > > cached_prod of cached_cq can only be increased, not decreas=
ed. In the
> > > > > > > > skb destruction phase, only those skbs that go to the end o=
f life need
> > > > > > > > to sync its desc from cached_cq to cq. For some skbs that a=
re released
> > > > > > > > before the tx completion, we don't need to clear its record=
 in
> > > > > > > > cached_cq at all and cq remains untouched.
> > > > > > > >
> > > > > > > > To put it in a simple way, the patch you proposed uses kmem=
_cached*
> > > > > > > > helpers to store the addr and write the addr into cq at the=
 end of
> > > > > > > > lifecycle while the current patch uses a pre-allocated memo=
ry to
> > > > > > > > store. So it avoids the allocation and deallocation.
> > > > > > > >
> > > > > > > > Unless I'm missing something important. If so, I'm still co=
nvinced
> > > > > > > > this temporary queue can solve the problem since essentiall=
y it's a
> > > > > > > > better substitute for kmem cache to retain high performance=
.
> > >
> > > Back after health issues!
> >
> > Hi Maciej,
> >
> > Hope you're fully recovered:)
> >
> > >
> > > Jason, I am still not convinced about this solution.
> > >
> > > In shared pool setups, the temp cq will also be shared, which means t=
hat
> > > two parallel processes can produce addresses onto temp cq and therefo=
re
> > > expose address to a socket that it does not belong to. In order to ma=
ke
> > > this work you would have to know upfront the descriptor count of give=
n
> > > frame and reserve this during processing the first descriptor.
> > >
> > > socket 0                        socket 1
> > > prod addr 0xAA
> > > prod addr 0xBB
> > >                                 prod addr 0xDD
> > > prod addr 0xCC
> > >                                 prod addr 0xEE
> > >
> > > socket 0 calls skb destructor with num desc =3D=3D 3, placing 0xDD on=
to cq
> > > which has not been sent yet, therefore potentially corrupting it.
> >
> > Thanks for spotting this case!
> >
> > Yes, it can happen, so let's turn into a per-xsk granularity? If each
> > xsk has its own temp queue, then the problem would disappear and good
> > news is that we don't need extra locks like pool->cq_lock to prevent
> > multiple parallel xsks accessing the temp queue.
>
> Sure, when you're confident this is working solution then you can post it=
.
> But from my POV we should go with Fernando's patch and then you can send
> patches to bpf-next as improvements. There are people out there with
> broken xsk waiting for a fix.

Fine, I will officially post it on the next branch. But I think at
that time, I have to revert both patches (your and Fernando's
patches)? Will his patch be applied to the stable branch only so that
I can make it on the next branch?

>
> >
> > Hope you can agree with this method. It borrows your idea and then
> > only uses a _pre-allocated buffer_ to replace kmem_cache_alloc() in
> > the hot path. This solution will direct us more to a high performance
> > direction. IMHO, I=E2=80=98d rather not see any degradation in performa=
nce
> > because of some issues.
>
> I have to disagree here even though my work was around perf improvements
> in the past. Code has to be correct and we have to respect bug reports. S=
o
> clarity and correctness comes before performance. If we silently accept
> some breakage then in the future nothing would spot syzbot from preparing
> a bug reproducer. Addressing this consumes developer's/maintainer's time.

No no no, I meant we're all striving for high performance direction
under the condition all the bugs are addressed. So the current series
surely brings more complexity but it can be good in the long run. Of
course, I know what you meant here :)

Thanks,
Jason

