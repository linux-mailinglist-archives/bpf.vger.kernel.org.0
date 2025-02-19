Return-Path: <bpf+bounces-51911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F44DA3B1A7
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 07:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29FB3A8CD4
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 06:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F711BBBFD;
	Wed, 19 Feb 2025 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiXWuejv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9B1188915;
	Wed, 19 Feb 2025 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946626; cv=none; b=ZAMXt6QRbrHmyxLXEctPRqBjI8VToac1HsPnC/0/kbcr7ydHmvOLmtueUuBi5A3q8eq1t2eHkZ5XnjGjJJ6xjK+cD4GRjv20Ffcu+dRcN5DymDIc90zSOKZe4rTsuPv3lyaEOi2nyku2jLd+ev5QhDhp321U9VJQm3PE1OBXAG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946626; c=relaxed/simple;
	bh=44r/7/J0bYiZfl/ejMpN/rV2NOsdxLAx1HCS8iNLImc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ea37VL7GXsLCBkbI27q8BQENpR2H34xYAt6/LmSLX/LYCP/6D5Xq5gLkGtS+Ez2KtB5mT+NjgpBC1nhRXlKVNR4Jkap5lyVNyMB8Ek0V0VTWZmByla921iuHupswsTZECP1F9akp5svXFJfftK/GMDFs+vyhKTB1Tp1ZGOz6iok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiXWuejv; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d03d2bd7d2so55998035ab.0;
        Tue, 18 Feb 2025 22:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739946624; x=1740551424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wC+sP3GrxT46GnFkrfd4YKhdbFDIzyMeO+J1YGAXJ1Q=;
        b=LiXWuejvVfsvZltca1lbUSWlAbTxPp/Rdnc2kW2Q+5pQwhc7pysRKifWHRPK4o7rH4
         JU9XkyDKHSmrRxVhN+SplwuJJ4vO49Ijuux+ejux3Vkpc0XeT6TW7cYKcceEy84UrAN3
         zDhTLM1ygLrJunXUrdBU2c6+Pn9Cgf1IW7bELO33qfuVct95L4aXjsOih/2oHkn5Dbxl
         BpvGREOPe3kJBq2xO1OM3w+hXrN8t4t6YSlgXwJXZ/VR5sQsDTxNotqmL/Y07mSIMznS
         06xLy0CB+ZHnRf7LKcG1T9Ipb/i4PcEnGGgOjTPoZqaP9JFErOyVr1k/2sPoq8kG485I
         IiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739946624; x=1740551424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wC+sP3GrxT46GnFkrfd4YKhdbFDIzyMeO+J1YGAXJ1Q=;
        b=JmMrjW8MNWetA+dUeHCbRttE5V3wRm5KnV8KrNDHk/BE1ANZnoZys/2Qe0axl21bhI
         8geV0kXqrgNzlOir9u5JgiXa6RAhjUBcNMPxqQcY+K/1dpLSm4POOmY+pKnSukn0S77d
         /q5aXtcb2+bpC8CE8wrW83Co+8UNuBfio6yQQQLT1FzCHLIZK8qvUFjRcX3DaBQqg1YX
         pzkd734wMIdyiicdvTVWBsHwn56XMmUCBSXgaGFc8G4ZUCQIZEoiSqsTU90sZ9qDd1bq
         wwN82Rd32uVn/foBk0SnfM0HqNZbBKXJ3E1YFJd0WhKmn2xL+amTG80opFctAOFLAQbG
         JUDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqK2CKgeiwPILOSy4LxFKTI7Wk45qmo+VcQaT4ATAZ6UPQ+SrIuqnYEt5a9rJSRUazuhk=@vger.kernel.org, AJvYcCXHHUVaLw8Tw15k61h8q4UcJqLUaq5AGOAVWxbKxGc4QMs9D9x2n/i09F7PfZIz9Bv35FNAzh4j@vger.kernel.org
X-Gm-Message-State: AOJu0YxJN/oeIFLWVQnZ9y+1vZEDTWRkTN3Irk7gV2EpJa75Gs7x/gcW
	AwSHWujeVbEJ7thpffOmirHZSaZQ8qJ1hnAbibWuW7dFd+xn/Fu5+CsRxfNPfpaalXv4DPUeE+c
	k2pMIm0rgqPieaAGeStm9XEd/5k4=
X-Gm-Gg: ASbGncvxnyO7cS9D/F5QX9SKg8n2dc6OgP7msZjm68jeEMsno5wk8LuLKPxVz3ilARL
	pr+XvGqDOT7cdIbVK35AgysxzqNckZMevSDmYeV0c//yK/LIbM3OQgOucCAp7dEokUcZf3nEz
X-Google-Smtp-Source: AGHT+IGxsd57F8tg1tbGToU1Wa6EBkPBgub+I4jmApzFzz4j0GR8cEyYaMeu20pwEFd5GZ0YVfnExqo7K3Q8R+EL2Wc=
X-Received: by 2002:a05:6e02:4514:b0:3d2:b2d0:f845 with SMTP id
 e9e14a558f8ab-3d2b2d0fac0mr33998495ab.1.1739946624019; Tue, 18 Feb 2025
 22:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-2-kerneljasonxing@gmail.com> <67b497b974fc3_10d6a32948b@willemb.c.googlers.com.notmuch>
 <03553725-648d-467f-9076-0d5c22b3cfb3@linux.dev> <CAL+tcoA==aPOmBjDTOi2WgZ7HEE4OJiZ+4Z-OD_yGn_XN2Onqw@mail.gmail.com>
 <67b542b9c4e3d_1692112944@willemb.c.googlers.com.notmuch>
In-Reply-To: <67b542b9c4e3d_1692112944@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 19 Feb 2025 14:29:47 +0800
X-Gm-Features: AWEUYZlnz9SoKTRDPccM6tGq0cFvqiZgGEsgmJbdcznhY7mLm-3OSINvoBlAeRw
Message-ID: <CAL+tcoCHsJ9KQf5w6TLHmQy9DrkhPHChRPQb=+9L_WKTTd8FQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 01/12] bpf: add networking timestamping
 support to bpf_get/setsockopt()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 10:32=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Wed, Feb 19, 2025 at 5:55=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> > >
> > > On 2/18/25 6:22 AM, Willem de Bruijn wrote:
> > > > Jason Xing wrote:
> > > >> The new SK_BPF_CB_FLAGS and new SK_BPF_CB_TX_TIMESTAMPING are
> > > >> added to bpf_get/setsockopt. The later patches will implement the
> > > >> BPF networking timestamping. The BPF program will use
> > > >> bpf_setsockopt(SK_BPF_CB_FLAGS, SK_BPF_CB_TX_TIMESTAMPING) to
> > > >> enable the BPF networking timestamping on a socket.
> > > >>
> > > >> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > >> ---
> > > >>   include/net/sock.h             |  3 +++
> > > >>   include/uapi/linux/bpf.h       |  8 ++++++++
> > > >>   net/core/filter.c              | 23 +++++++++++++++++++++++
> > > >>   tools/include/uapi/linux/bpf.h |  1 +
> > > >>   4 files changed, 35 insertions(+)
> > > >>
> > > >> diff --git a/include/net/sock.h b/include/net/sock.h
> > > >> index 8036b3b79cd8..7916982343c6 100644
> > > >> --- a/include/net/sock.h
> > > >> +++ b/include/net/sock.h
> > > >> @@ -303,6 +303,7 @@ struct sk_filter;
> > > >>     *        @sk_stamp: time stamp of last packet received
> > > >>     *        @sk_stamp_seq: lock for accessing sk_stamp on 32 bit =
architectures only
> > > >>     *        @sk_tsflags: SO_TIMESTAMPING flags
> > > >> +  * @sk_bpf_cb_flags: used in bpf_setsockopt()
> > > >>     *        @sk_use_task_frag: allow sk_page_frag() to use curren=
t->task_frag.
> > > >>     *                           Sockets that can be used under mem=
ory reclaim should
> > > >>     *                           set this to false.
> > > >> @@ -445,6 +446,8 @@ struct sock {
> > > >>      u32                     sk_reserved_mem;
> > > >>      int                     sk_forward_alloc;
> > > >>      u32                     sk_tsflags;
> > > >> +#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (F=
LAG))
> > > >> +    u32                     sk_bpf_cb_flags;
> > > >>      __cacheline_group_end(sock_write_rxtx);
> > > >
> > > > So far only one bit is defined. Does this have to be a 32-bit field=
 in
> > > > every socket?
> > >
> > > iirc, I think there were multiple callback (cb) flags/bits in the ear=
lier
> > > revisions, but it had been simplified to one bit in the later revisio=
ns.
> > >
> > > It's an internal implementation detail. We can reuse some free bits f=
rom another
> > > variable for now. Probably get a bit from sk_tsflags? SOCKCM_FLAG_TS_=
OPT_ID uses
> > > BIT(31). Maybe a new SK_TS_FLAG_BPF_TX that uses BIT(30)? I don't hav=
e a strong
> > > preference on the name.
> > >
> > > When the BPF program calls bpf_setsockopt(SK_BPF_CB_FLAGS,
> > > SK_BPF_CB_TX_TIMESTAMPING), the kernel will set/test the BIT(30) of s=
k_tsflags.
> > >
> > > We can wait until there are more socket-level cb flags in the future =
(e.g., more
> > > SK_BPF_CB_XXX will be needed) before adding a dedicated int field in =
the sock.
> >
> > Sorry, I still preferred the way we've discussed already:
>
> Adding fields to structs in the hot path is a tragedy of the commons.
>
> Every developer focuses on their specific workload and pet feature,
> while imposing a cost on everyone else.
>
> We have a duty to be frugal and mitigate this cost where possible.
> Especially for a feature that is likely to be used sparingly.

Point taken and I agree on this point all along. Don't get me wrong. I
insisted on using sk_bpf_cb_flags only, not the size of this field.
Please see details below.

>
> > 1) Introducing a new field sk_bpf_cb_flags extends the use for bpf
> > timestamping, more than SK_BPF_CB_TX_TIMESTAMPING one flag. I think
> > SK_BPF_CB_RX_TIMESTAMPING is also needed in the next move. And more
> > subfeatures (like bpf extension for OPT_ID) will use it. It gives us a
> > separate way to do more things based on this bpf timestamping.
> > 2) sk_bpf_cb_flags provides a way to let the socket-level use new
> > features for bpf while now we only have a tcp_sock-level, namely,
> > bpf_sock_ops_cb_flags. It's obviously good for others.
> >
> > It's the first move to open the gate for socket-level usage for BPF,
>
> Can you give a short list of bits that you could see being used, to
> get an idea of the count. In my mind this is a very short list, not
> worth reserving 32 bits for. But you might have more developed plans.

RX is one flag that we're going to add. Another new bit might be used
for bpf extension of OPT_ID to handle the udp lockless case, or
tracing every skb (which needs more official discussion) 'm not that
sure.

>
> > just like how TCP_BPF_SOCK_OPS_CB_FLAGS works in sol_tcp_sockopt(). So
> > I hope we will not abandon this good approach :(
> >
> > Now I wonder if I should use the u8 sk_bpf_cb_flags in V13 or just
> > keep it as-is? Either way is fine with me :) bpf_sock_ops_cb_flags
> > uses u8 as an example, thus I think we prefer the former?
>
> If it fits in a u8 and that in practice also results in less memory
> and cache pressure (i.e., does not just add a 24b hole), then it is a
> net improvement.

Probably I didn't state it clearly. I agree with you on saving memory:)

In the previous response, I was trying to keep the sk_bpf_cb_flags
flag and use a u8 instead. I admit u32 is too large after you noticed
this.

Would the following diff on top of this series be acceptable for you?
And would it be a proper place to put the u8 sk_bpf_cb_flags in struct
sock?
diff --git a/include/net/sock.h b/include/net/sock.h
index 6f4d54faba92..e85d6fb3a2ba 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -447,7 +447,7 @@ struct sock {
        int                     sk_forward_alloc;
        u32                     sk_tsflags;
 #define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
-       u32                     sk_bpf_cb_flags;
+       u8                      sk_bpf_cb_flags;
        __cacheline_group_end(sock_write_rxtx);

        __cacheline_group_begin(sock_write_tx);

The following output is the result of running 'pahole --hex -C sock vmlinux=
'.
Before this series:
        u32                        sk_tsflags;           /* 0x168   0x4 */
        __u8
__cacheline_group_end__sock_write_rxtx[0]; /* 0x16c     0 */
        __u8
__cacheline_group_begin__sock_write_tx[0]; /* 0x16c     0 */
        int                        sk_write_pending;     /* 0x16c   0x4 */
        atomic_t                   sk_omem_alloc;        /* 0x170   0x4 */
        int                        sk_sndbuf;            /* 0x174   0x4 */
        int                        sk_wmem_queued;       /* 0x178   0x4 */
        refcount_t                 sk_wmem_alloc;        /* 0x17c   0x4 */
        /* --- cacheline 6 boundary (384 bytes) --- */
        long unsigned int          sk_tsq_flags;         /* 0x180   0x8 */
...
/* sum members: 773, holes: 1, sum holes: 1 */

After this diff patch:
        u32                        sk_tsflags;           /* 0x168   0x4 */
        u8                         sk_bpf_cb_flags;      /* 0x16c   0x1 */
        __u8
__cacheline_group_end__sock_write_rxtx[0]; /* 0x16d     0 */
        __u8
__cacheline_group_begin__sock_write_tx[0]; /* 0x16d     0 */

        /* XXX 3 bytes hole, try to pack */

        int                        sk_write_pending;     /* 0x170   0x4 */
        atomic_t                   sk_omem_alloc;        /* 0x174   0x4 */
        int                        sk_sndbuf;            /* 0x178   0x4 */
        int                        sk_wmem_queued;       /* 0x17c   0x4 */
        /* --- cacheline 6 boundary (384 bytes) --- */
        refcount_t                 sk_wmem_alloc;        /* 0x180   0x4 */

        /* XXX 4 bytes hole, try to pack */

        long unsigned int          sk_tsq_flags;         /* 0x188   0x8 */
...
/* sum members: 774, holes: 3, sum holes: 8 */

It will introduce 7 extra sum holes if this series with this u8 change
gets applied. I think it's a proper position because this new
sk_bpf_cb_flags will be used in the tx and rx path just like
sk_tsflags, aligned with rules introduced by the commit[1].

I'd like to know your opinion here. Hopefully we can let this series
pass in the next re-spin:)

Thanks in advance.

[1]
commit 5d4cc87414c5d11345c4b11d61377d351b5c28a2
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Feb 16 16:20:06 2024 +0000

    net: reorganize "struct sock" fields

    Last major reorg happened in commit 9115e8cd2a0c ("net: reorganize
    struct sock for better data locality")

    Since then, many changes have been done.

    Before SO_PEEK_OFF support is added to TCP, we need
    to move sk_peek_off to a better location.

    It is time to make another pass, and add six groups,
    without explicit alignment.

    - sock_write_rx (following sk_refcnt) read-write fields in rx path.
    - sock_read_rx read-mostly fields in rx path.
    - sock_read_rxtx read-mostly fields in both rx and tx paths.
    - sock_write_rxtx read-write fields in both rx and tx paths.
    - sock_write_tx read-write fields in tx paths.
    - sock_read_tx read-mostly fields in tx paths.

Thanks,
Jason

