Return-Path: <bpf+bounces-54846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8922CA74623
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 10:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28BAE17291C
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 09:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B50A1D90A9;
	Fri, 28 Mar 2025 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jdh4hzWi"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE05145B27
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743153360; cv=none; b=d4QNNHBfvJC9ExjKSfqdgqCnn97CMjMgdFVjaPGVtGWxcviz03GMA1fHbd9zqlPRmSortWmQikUyRJusKNaeK9UceKnhX/PCowdhEISi4nvReRZ0ZbkozIrb3uWKRkv3KrndMh1aS1Duay04CexiTF/txBuMGu2bwMRSc27/RnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743153360; c=relaxed/simple;
	bh=adf04wGi+9obpoFeO+JGISKn7dPuPF1GbDHgd+fFpNs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=DZd0WTju+B2VwF+UKPjRQIjgCUPMJ71jUJ5Ym2lftDeAMrd+yFgPrBTW8URyub20prBXjAYplt56cGPaLA+BO3J9GC+F+P47udEct1A57H1fGFp+L5xrbI9ArSUbYUgytTZuC8m795iazTXMjdzZAVVsbv8+xxsUi3VFjRTTsdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jdh4hzWi; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743153355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s1ha8nU9rL2AUrvffeNdwwUmS1zgXHAGS16YD/tF7kY=;
	b=jdh4hzWiMAci5QoKp8IyisvglFAMbymI7BfycqBa37RoSr1c1Bd8/Mhi6URgIIUP7GSDJH
	nhF7SSxYW8vsyB0y35ah3NsJMXRvqQcP330aUO0IizqT2l3W1UteNGgdyYtOKelhOXuoRB
	z5SJSHWTgSlQadm23UA/+DaKxXtndN4=
Date: Fri, 28 Mar 2025 09:15:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <17a3bc7273fac6a2e647a6864212510b37b96ab2@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v1] net: Fix tuntap uninitialized value
To: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com,
 bpf@vger.kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, kpsingh@kernel.org, jolsa@kernel.org
In-Reply-To: <67e5be3c65de3_10636329488@willemb.c.googlers.com.notmuch>
References: <20250327134122.399874-1-jiayuan.chen@linux.dev>
 <67e5be3c65de3_10636329488@willemb.c.googlers.com.notmuch>
X-Migadu-Flow: FLOW_OUT

March 28, 2025 at 05:08, "Willem de Bruijn" <willemdebruijn.kernel@gmail.=
com> wrote:

>=20
>=20Jiayuan Chen wrote:
>=20
>=20>=20
>=20> Then tun/tap allocates an skb, it additionally allocates a prepad s=
ize
> >  (usually equal to NET_SKB_PAD) but leaves it uninitialized.
> >  bpf_xdp_adjust_head() may move skb->data forward, which may lead to =
an
> >  issue.
> >  Since the linear address is likely to be allocated from kmem_cache, =
it's
> >  unlikely to trigger a KMSAN warning. We need some tricks, such as fo=
rcing
> >  kmem_cache_shrink in __do_kmalloc_node, to reproduce the issue and t=
rigger
> >  a KMSAN warning.
> >=20
>=20>  Reported-by: syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com
> >  Closes: https://lore.kernel.org/all/00000000000067f65105edbd295d@goo=
gle.com/T/
> >  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  drivers/net/tun.c | 2 ++
> >=20
>=20>  1 file changed, 2 insertions(+)
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >=20
>=20>  index f75f912a0225..111f83668b5e 100644
> >=20
>=20>  --- a/drivers/net/tun.c
> >=20
>=20>  +++ b/drivers/net/tun.c
> >=20
>=20>  @@ -1463,6 +1463,7 @@ static struct sk_buff *tun_alloc_skb(struct =
tun_file *tfile,
> >=20
>=20>  if (!skb)
> >=20
>=20>  return ERR_PTR(err);
> >=20
>=20>=20=20
>=20>=20
>=20>  + memset(skb->data, 0, prepad);
> >=20
>=20>  skb_reserve(skb, prepad);
> >=20
>=20>  skb_put(skb, linear);
> >=20
>=20>  skb->data_len =3D len - linear;
> >=20
>=20
> Is this specific to the tun device?
>=20
>=20This happens in generic (skb) xdp.
>=20
>=20The stackdump shows a napi poll call stack
>=20
>=20 bpf_prog_run_generic_xdp+0x13ff/0x1a30 net/core/dev.c:4782
>=20
>=20 netif_receive_generic_xdp+0x639/0x910 net/core/dev.c:4845
>=20
>=20 do_xdp_generic net/core/dev.c:4904 [inline]
>=20
>=20 __netif_receive_skb_core+0x290f/0x6360 net/core/dev.c:5310
>=20
>=20 __netif_receive_skb_one_core net/core/dev.c:5487 [inline]
>=20
>=20 __netif_receive_skb+0xc8/0x5d0 net/core/dev.c:5603
>=20
>=20 process_backlog+0x45a/0x890 net/core/dev.c:5931
>=20
>=20Since this is syzbot, the skb will have come from a tun device,
>=20
>=20seemingly with IFF_NAPI, and maybe IFF_NAPI_FRAGS.
>=20
>=20But relevant to bpf_xdp_adjust_head is how the xdp metadata
>=20

Thanks.

I'm=20wondering if we can directly perform a memset in bpf_xdp_adjust_hea=
d
when users execute an expand header (offset < 0).

Although the main purpose of bpf_xdp_adjust_head is to write new headers,
it's possible that some users might be doing this to read lower-layer
headers, in which case memset would be inappropriate.

However, I found that when expanding headers, it also involves copying
data meta forward, which would overwrite padding memory, so maybe I'm
overthinking this?

In general, since bpf_xdp_adjust_head can access skb->head, it exposes a
minimum of XDP_PACKET_HEADROOM (256) uninitialized bytes to users, and
I'm not entirely clear if there are any security implications.


diff --git a/net/core/filter.c b/net/core/filter.c
index 2ec162dd83c4..51f3f0d9b4bb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3947,6 +3947,8 @@ BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_buff *, =
xdp, int, offset)
        if (metalen)
                memmove(xdp->data_meta + offset,
                        xdp->data_meta, metalen);
+       if (offset < 0)
+               memset(data, 0, -offset);
        xdp->data_meta +=3D offset;
        xdp->data =3D data;

