Return-Path: <bpf+bounces-75013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D42C6C082
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 00:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8194B358A72
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 23:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CBA30F939;
	Tue, 18 Nov 2025 23:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsnqR8Xy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD2F21D3CC
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 23:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763509097; cv=none; b=eyBk+xAx/sdI4/ODK+RLCV8OTH4KD7ro7sx02ZuyJY3t5x96ASdNFe1y9fQckde5U7yZvJLdgBuBZ+SKaRPSCsHVFHZ/RZ2IK37R0huYdrLHI6uyRPh73qGoZbXX6HnWGIVrhXVNvA1bFWUUC2hBw9cUy9uvAP8/t2Gay1MRCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763509097; c=relaxed/simple;
	bh=T+zE9tC0+9/RzE83+fR9RhN5PdYRP4xogC/p47KDNOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d94jMqj2e/Q7z2QTAMvHelUFEDmfLWekFpbZR5Wp8buccvMLOtfo12QDLlbzFSDaKQSsgdM+KdAjazLO8m37IGuN8eV+Y0Sdqa6kEWQMXY+KPUX7qPVylJ0hBn0GB0MGhUScU4KXF355fQN0ABYczyUKNBNanCchPG9VbtnKkX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsnqR8Xy; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-43470d98f77so25854275ab.2
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 15:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763509094; x=1764113894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFjQ2vPzAvkJKAgDbruzY9Z39R/Mf/p/TdajyHm14oI=;
        b=MsnqR8XyVh1uCS/9apZuwnPL9fQXVpU0ez7u4AWhra70G5VpCciHsHWoqndVSy6ZDI
         rBg8MiYlJBEiLoEaYrE+5o4pe91hb4u9WPbR1XkV4fyMt6FLWiorANWNSgzqP7ey544U
         Rt/UaAqWk7xpu3iL2SQ7rbTUfyYaMQGnp/oZFtIKuXK9098UTpfAxqMGfm8p1vbiddJj
         WdKV3wZ+V28IYW2nwekJYCm0KLXKEN6U722nxzWBd6nxBYnfHm85nYr9nKNevbHxzHfo
         cCa+e5SXSHqHuoA2Hk1gUvo7xqDAjofkiqmo7jh3oqQnbjM6sctltdd4c3UNjY67z30P
         aIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763509094; x=1764113894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JFjQ2vPzAvkJKAgDbruzY9Z39R/Mf/p/TdajyHm14oI=;
        b=Zwq9UjifDwRo7PVP9iCZq0Qt7z5WSo5386ecDBJw650Mgbocz2Vwb/ZILfxi0YMEgD
         CE8MZdcOXdNvUYC3qygeMtrITXYwnRxplZ3VzBoNBsPOklMhj8ozBpaUegX6Oe9QTHDC
         p6qERm3s24Avy8S4J3ojKIW9NWCJ1S46Hdqsiw+7OkxKYXCXbvZ4B+bJ1n2Xy/cAbP85
         +Xa23mj+k1fYaYIOlCOWTjFoFS3FmDC+9BWKsMLP9387nz0EkRkdSfhzhB33wcPWISg+
         11OIAX/z+biYYcJScixBAD35AwaHILs/diAg1qVbZry/NE5+QGeJEcp+Ov97y2JNe5Rn
         WK1A==
X-Forwarded-Encrypted: i=1; AJvYcCU63sWpaeE6QqglWKuHJhHa+KyY05BxPXxqQEMyS7mdZKtG1xi/bF/FdERzLfqjK/hlQo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9nGlUxn+/q1P7bQ7Ktn1+AG2cVNhZREC6PRf1LhwgdtkBshyh
	ob31jwWPvX9IzM6fcKOl09POVl2CaUtbbk/A2VcfkCEpb47NUCQ4rHvX4haflq9XJp56IF38fmt
	OOZnuR9iOl0+5GBSJExec/b4J07P06OU=
X-Gm-Gg: ASbGncsuZ7TPkLTW17B0a5uaRG+3ONwc+6r8YA7IfH8H8V1NaLkoiZsLEhMsuoqmTuM
	BT1kDQMBFPhuaIUUnYal3TnRzz3qXMDnZEIBqCrVxo33PmKfdj8zcFKlwunQQ/ED6xtTa8YCowb
	nJ+kEPEOdHbxTG27h+v/+HaX3RpWK0zjEDZf+tXxNYyVHP9BWKwtThGKiCIL7WS5+fYH965Ecpv
	5bZ4X0ZTn0aakrFptUN2Yz/3VlAttyX1xUH/ufLr55xctJsma2+yoaE3C4NJJsKoa3IlgHNkZ6z
	ugTbOWMVRQ==
X-Google-Smtp-Source: AGHT+IEq4BhPbg0c3j6Uc2UTfHxRi5yfcElxoXEtO/WMD6AFelU0OevjIDIfFfbOJR1BqsTyZrdIq+UZ+MrZtazZ/1c=
X-Received: by 2002:a05:6e02:dc4:b0:434:96ea:ff54 with SMTP id
 e9e14a558f8ab-43496eb0039mr125337815ab.37.1763509093994; Tue, 18 Nov 2025
 15:38:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQjDjaQzv+Y4U6NL@boxer> <CAL+tcoBkO98eBGX0uOUo_bvsPFbnGvSYvY-ZaKJhSn7qac464g@mail.gmail.com>
 <CAJ8uoz2ZaJ5uYhd-MvSuYwmWUKKKBSfkq17rJGO98iTJ+iUrQg@mail.gmail.com>
 <CAL+tcoBw4eS8QO+AxSk=-vfVSb-7VtZMMNfZTZtJCp=SMpy0GQ@mail.gmail.com>
 <aRdQWqKs29U7moXq@boxer> <CAL+tcoAv+dTK-Z=HNGUJNohxRu_oWCPQ4L1BRQT9nvB4WZMd7Q@mail.gmail.com>
 <aRtHvooD0IWWb4Cx@boxer> <CAL+tcoBTuOnnhAUD9gwbt8VBf+m=c08c-+cOUyjuPLyx29xUWw@mail.gmail.com>
 <aRxHDvUBcr+jx49C@boxer> <CAL+tcoCPiDq807u4wmqNx+j_jMmYYzNVA5ySGmp_V5gDLYz02A@mail.gmail.com>
 <aRy64Wr2UBhr4KLF@boxer>
In-Reply-To: <aRy64Wr2UBhr4KLF@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 19 Nov 2025 07:37:37 +0800
X-Gm-Features: AWmQ_bk50KTGzdPVQ3WoKioczFiMU0pCXuGftY_H4eEKjFI80yBH5FAUaaaYQ5s
Message-ID: <CAL+tcoBA-0BZnSTvUJXDEWS4xB-t_eoOW3RgTDOqvP9HP+3rDg@mail.gmail.com>
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

On Wed, Nov 19, 2025 at 2:29=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Tue, Nov 18, 2025 at 07:40:52PM +0800, Jason Xing wrote:
> > On Tue, Nov 18, 2025 at 6:15=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Tue, Nov 18, 2025 at 08:01:52AM +0800, Jason Xing wrote:
> > > > On Tue, Nov 18, 2025 at 12:05=E2=80=AFAM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > On Sat, Nov 15, 2025 at 07:46:40AM +0800, Jason Xing wrote:
> > > > > > On Fri, Nov 14, 2025 at 11:53=E2=80=AFPM Maciej Fijalkowski
> > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > >
> > > > > > > On Tue, Nov 11, 2025 at 10:02:58PM +0800, Jason Xing wrote:
> > > > > > > > Hi Magnus,
> > > > > > > >
> > > > > > > > On Tue, Nov 11, 2025 at 9:44=E2=80=AFPM Magnus Karlsson
> > > > > > > > <magnus.karlsson@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, 11 Nov 2025 at 14:06, Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Maciej,
> > > > > > > > > >
> > > > > > > > > > On Mon, Nov 3, 2025 at 11:00=E2=80=AFPM Maciej Fijalkow=
ski
> > > > > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Sat, Nov 01, 2025 at 07:59:36AM +0800, Jason Xing =
wrote:
> > > > > > > > > > > > On Fri, Oct 31, 2025 at 10:02=E2=80=AFPM Maciej Fij=
alkowski
> > > > > > > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, Oct 31, 2025 at 05:32:30PM +0800, Jason X=
ing wrote:
> > > > > > > > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Before the commit 30f241fcf52a ("xsk: Fix immat=
ure cq descriptor
> > > > > > > > > > > > > > production"), there is one issue[1] which cause=
s the wrong publish
> > > > > > > > > > > > > > of descriptors in race condidtion. The above co=
mmit fixes the issue
> > > > > > > > > > > > > > but adds more memory operations in the xmit hot=
 path and interrupt
> > > > > > > > > > > > > > context, which can cause side effect in perform=
ance.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > This patch tries to propose a new solution to f=
ix the problem
> > > > > > > > > > > > > > without manipulating the allocation and dealloc=
ation of memory. One
> > > > > > > > > > > > > > of the key points is that I borrowed the idea f=
rom the above commit
> > > > > > > > > > > > > > that postpones updating the ring->descs in xsk_=
destruct_skb()
> > > > > > > > > > > > > > instead of in __xsk_generic_xmit().
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The core logics are as show below:
> > > > > > > > > > > > > > 1. allocate a new local queue. Only its cached_=
prod member is used.
> > > > > > > > > > > > > > 2. write the descriptors into the local queue i=
n the xmit path. And
> > > > > > > > > > > > > >    record the cached_prod as @start_addr that r=
eflects the
> > > > > > > > > > > > > >    start position of this queue so that later t=
he skb can easily
> > > > > > > > > > > > > >    find where its addrs are written in the dest=
ruction phase.
> > > > > > > > > > > > > > 3. initialize the upper 24 bits of destructor_a=
rg to store @start_addr
> > > > > > > > > > > > > >    in xsk_skb_init_misc().
> > > > > > > > > > > > > > 4. Initialize the lower 8 bits of destructor_ar=
g to store how many
> > > > > > > > > > > > > >    descriptors the skb owns in xsk_update_num_d=
esc().
> > > > > > > > > > > > > > 5. write the desc addr(s) from the @start_addr =
from the cached cq
> > > > > > > > > > > > > >    one by one into the real cq in xsk_destruct_=
skb(). In turn sync
> > > > > > > > > > > > > >    the global state of the cq.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The format of destructor_arg is designed as:
> > > > > > > > > > > > > >  ------------------------ --------
> > > > > > > > > > > > > > |       start_addr       |  num   |
> > > > > > > > > > > > > >  ------------------------ --------
> > > > > > > > > > > > > > Using upper 24 bits is enough to keep the tempo=
rary descriptors. And
> > > > > > > > > > > > > > it's also enough to use lower 8 bits to show th=
e number of descriptors
> > > > > > > > > > > > > > that one skb owns.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > [1]: https://lore.kernel.org/all/20250530095957=
.43248-1-e.kubanski@partner.samsung.com/
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.c=
om>
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > I posted the series as an RFC because I'd like =
to hear more opinions on
> > > > > > > > > > > > > > the current rought approach so that the fix[2] =
can be avoided and
> > > > > > > > > > > > > > mitigate the impact of performance. This patch =
might have bugs because
> > > > > > > > > > > > > > I decided to spend more time on it after we com=
e to an agreement. Please
> > > > > > > > > > > > > > review the overall concepts. Thanks!
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Maciej, could you share with me the way you tes=
ted jumbo frame? I used
> > > > > > > > > > > > > > ./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but th=
e xdpsock utilizes the
> > > > > > > > > > > > > > nic more than 90%, which means I cannot see the=
 performance impact.
> > > > > > > > > > > >
> > > > > > > > > > > > Could you provide the command you used? Thanks :)
> > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > [2]:https://lore.kernel.org/all/20251030140355.=
4059-1-fmancera@suse.de/
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > >  include/net/xdp_sock.h      |   1 +
> > > > > > > > > > > > > >  include/net/xsk_buff_pool.h |   1 +
> > > > > > > > > > > > > >  net/xdp/xsk.c               | 104 ++++++++++++=
++++++++++++++++--------
> > > > > > > > > > > > > >  net/xdp/xsk_buff_pool.c     |   1 +
> > > > > > > > > > > > > >  4 files changed, 84 insertions(+), 23 deletion=
s(-)
> > > > > > > > > > > > >
> > > > > > > > > > > > > (...)
> > > > > > > > > > > > >
> > > > > > > > > > > > > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/=
xsk_buff_pool.c
> > > > > > > > > > > > > > index aa9788f20d0d..6e170107dec7 100644
> > > > > > > > > > > > > > --- a/net/xdp/xsk_buff_pool.c
> > > > > > > > > > > > > > +++ b/net/xdp/xsk_buff_pool.c
> > > > > > > > > > > > > > @@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_crea=
te_and_assign_umem(struct xdp_sock *xs,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >       pool->fq =3D xs->fq_tmp;
> > > > > > > > > > > > > >       pool->cq =3D xs->cq_tmp;
> > > > > > > > > > > > > > +     pool->cached_cq =3D xs->cached_cq;
> > > > > > > > > > > > >
> > > > > > > > > > > > > Jason,
> > > > > > > > > > > > >
> > > > > > > > > > > > > pool can be shared between multiple sockets that =
bind to same <netdev,qid>
> > > > > > > > > > > > > tuple. I believe here you're opening up for the v=
ery same issue Eryk
> > > > > > > > > > > > > initially reported.
> > > > > > > > > > > >
> > > > > > > > > > > > Actually it shouldn't happen because the cached_cq =
is more of the
> > > > > > > > > > > > temporary array that helps the skb store its start =
position. The
> > > > > > > > > > > > cached_prod of cached_cq can only be increased, not=
 decreased. In the
> > > > > > > > > > > > skb destruction phase, only those skbs that go to t=
he end of life need
> > > > > > > > > > > > to sync its desc from cached_cq to cq. For some skb=
s that are released
> > > > > > > > > > > > before the tx completion, we don't need to clear it=
s record in
> > > > > > > > > > > > cached_cq at all and cq remains untouched.
> > > > > > > > > > > >
> > > > > > > > > > > > To put it in a simple way, the patch you proposed u=
ses kmem_cached*
> > > > > > > > > > > > helpers to store the addr and write the addr into c=
q at the end of
> > > > > > > > > > > > lifecycle while the current patch uses a pre-alloca=
ted memory to
> > > > > > > > > > > > store. So it avoids the allocation and deallocation=
.
> > > > > > > > > > > >
> > > > > > > > > > > > Unless I'm missing something important. If so, I'm =
still convinced
> > > > > > > > > > > > this temporary queue can solve the problem since es=
sentially it's a
> > > > > > > > > > > > better substitute for kmem cache to retain high per=
formance.
> > > > > > >
> > > > > > > Back after health issues!
> > > > > >
> > > > > > Hi Maciej,
> > > > > >
> > > > > > Hope you're fully recovered:)
> > > > > >
> > > > > > >
> > > > > > > Jason, I am still not convinced about this solution.
> > > > > > >
> > > > > > > In shared pool setups, the temp cq will also be shared, which=
 means that
> > > > > > > two parallel processes can produce addresses onto temp cq and=
 therefore
> > > > > > > expose address to a socket that it does not belong to. In ord=
er to make
> > > > > > > this work you would have to know upfront the descriptor count=
 of given
> > > > > > > frame and reserve this during processing the first descriptor=
.
> > > > > > >
> > > > > > > socket 0                        socket 1
> > > > > > > prod addr 0xAA
> > > > > > > prod addr 0xBB
> > > > > > >                                 prod addr 0xDD
> > > > > > > prod addr 0xCC
> > > > > > >                                 prod addr 0xEE
> > > > > > >
> > > > > > > socket 0 calls skb destructor with num desc =3D=3D 3, placing=
 0xDD onto cq
> > > > > > > which has not been sent yet, therefore potentially corrupting=
 it.
> > > > > >
> > > > > > Thanks for spotting this case!
> > > > > >
> > > > > > Yes, it can happen, so let's turn into a per-xsk granularity? I=
f each
> > > > > > xsk has its own temp queue, then the problem would disappear an=
d good
> > > > > > news is that we don't need extra locks like pool->cq_lock to pr=
event
> > > > > > multiple parallel xsks accessing the temp queue.
> > > > >
> > > > > Sure, when you're confident this is working solution then you can=
 post it.
> > > > > But from my POV we should go with Fernando's patch and then you c=
an send
> > > > > patches to bpf-next as improvements. There are people out there w=
ith
> > > > > broken xsk waiting for a fix.
> > > >
> > > > Fine, I will officially post it on the next branch. But I think at
> > > > that time, I have to revert both patches (your and Fernando's
> > > > patches)? Will his patch be applied to the stable branch only so th=
at
> > > > I can make it on the next branch?
> > >
> > > Give it some time and let Fernando repost patch and then after applyi=
ng
> > > all the backport machinery will kick in. I suppose after bpf->bpf-nex=
t
> > > merge you could step in and in the meantime I assume you've got plent=
y of
> > > stuff to work on. My point here is we already hesitated too much in t=
his
> > > matter IMHO.
> >
> > I have no intention to stop that patch from being merged :)
> >
> > I meant his patch will be _only_ merged into the net/stable branch and
> > _not_ be merged into the next branch, right? If so, I can continue my
> > approach only targetting the next branch without worrying about his
> > patch which can cause conflicts.
>
> net/bpf branches are merged periodically to -next variants, AFAICT. New
> kernels carry the fixes as well. Purpose of net/bpf branches is to addres=
s
> the stable kernels with developed fixes.

Oh, well. I wonder if we can stop merging that patch in
net-next/bpf-next since I can post my series today? For now, there are
two things to be done: one is to revert only one patch and the other
is to add a temp queue function.

Thanks,
Jason

