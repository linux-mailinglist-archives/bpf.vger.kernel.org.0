Return-Path: <bpf+bounces-43740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF4A9B94F7
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 17:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB151C216C8
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDC31C9B71;
	Fri,  1 Nov 2024 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV1KUAZA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143213D893;
	Fri,  1 Nov 2024 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477343; cv=none; b=ZdrDAPcaI4WQTwoenrABggvawNmSmIJ/GcJISiQWlLd5d9B5qvDRokJo6FxEM9FlLJXMzTtBjFjJfNePgL3QPvyErDp25OZHazxHuzAIJEEyeNK4+cp29L3qntqHNNMvvuVJ9BsARaR4ktZqm+sRR4HF4d6Hs2xxqY/w9Xj/XFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477343; c=relaxed/simple;
	bh=DuJvo8Yva15bmGKXj45TxpTCAbD3oqzYnfzTgaO54DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdjaNznydP/+vIShrMlgC6BJv/u6SInJTkEVasbOHj+/ALAdrWuUz64x4S/25k1KzaPwssjUF4AjYHtVppQcSkSHS0ZhjQ4DzDe8xGRu7udnqvaBs9bn81M0MoAmcQHkUQpVb5/nb9ECfM2LDMb5MRiv2RhBI7IOeTttTK5v2Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iV1KUAZA; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a3b463e9b0so7994035ab.3;
        Fri, 01 Nov 2024 09:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730477339; x=1731082139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ4NHM16bbIRrVd9VqhHjGsKf/Jn4VNPbsUSmm5pHA0=;
        b=iV1KUAZAcfA+wyqh7bRW/QBwLrPMB23GKWCNUvp20vNWJXKom17R6xnzuQhXHrOjBl
         7baZNBxfQzU6j0LRMvLyoxa3+2Zg7r3J4NrUxJWwHwkmoFqaesSdagAxHGJatumOvZWf
         +3u/BhdThsRF4WpBS+64wrYzJml55zbNbECh1b6GYwJi0zNFRLTtfc+FxGRfALbBHYxp
         M0YtK7IbB0Zls7x7k7mC6ieRMImKflhHcMGRrsdpkDLvN8Np6CFcsgYG1LRHYmK1wekY
         gjfXocP17K3vtCNKK3+H5pLGxXMf8mEtdlxMxPAptfuQvV/C+gKnZNtdgEM0FRPnB8Vk
         VYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730477339; x=1731082139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ4NHM16bbIRrVd9VqhHjGsKf/Jn4VNPbsUSmm5pHA0=;
        b=b2vU6dgGY7sAZQLyaoEVg2Zq8vnvlJQDTjpvM5Bw/cS7PTz8esrg4u9Ok8L9CX00bc
         63nCQmq2ikvRnFh2exXVCIg86GEBiHzHWDIZ7PngC+lOrm1Uacx0x6N4yqMF5X5t/iU8
         2uogPjbz96axT791lfNAhjLz+Tvqpjzu2lQ62cJJeLPzFtzrDqOmQ1pF/kW/UWlsYTCJ
         P7AmqkI13bgggI8nwBXAalGeAPeJA8DN92Trz+2w2nga2K51JXPFWqalb6UJquwVZVtD
         HDWbZciCicmJuKyRX2CyCID0AbAXI8C88ItoD8vy+0vX3QxS8mtSR3BVaNNtPhuxk2cO
         UYNA==
X-Forwarded-Encrypted: i=1; AJvYcCVSUMsHjMM8bk/H40z4vOJrzuHUdKH1SOYh9eL2GjbEucFzoWdOt6Gs74QEdJW1N7OnGEI=@vger.kernel.org, AJvYcCWdv8Da4Swb11/bn3iclbF0FJntDid1QOwJHqc/fKXqEbjZhv5gcHYV6rh5Fr/9yQx26fFg92V/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs0A612vTTSBfal4YVOV4nDY40d/px7sd/Kr6QwCKq5gEtoAzl
	JpSewrhm01PyQSIjIrEn6lezAqSMBo89sUdiIVO4WA9COKtl9x0FkhKLBOvC2eqX++AH+RbmaE5
	oLQUJO05d+aZDA9PBpap8U5Ld8qs=
X-Google-Smtp-Source: AGHT+IGSnbSqxDDsGi3A+nZ8EAi1lbQp8ca5FHritB76Q+WZUughbLGzgck1oxzE+DwTYTZTH2ZEcU69POaS+tLQbjw=
X-Received: by 2002:a05:6e02:154a:b0:3a6:acdf:1a19 with SMTP id
 e9e14a558f8ab-3a6acdf1e12mr57236425ab.18.1730477339481; Fri, 01 Nov 2024
 09:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <61e8c5cf-247f-484e-b3cc-27ab86e372de@linux.dev> <CAL+tcoDB8UvNMfTwmvTJb1JvCGDb3ESaJMszh4-Qa=ey0Yn3Vg@mail.gmail.com>
 <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
 <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com>
 <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
 <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
 <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev> <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
 <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
 <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com>
 <d138a81d-f9f5-4d51-bedd-3916d377699d@linux.dev> <CAL+tcoBfuFL7-EOBY4RLMdDZJcUSyq20pJW13OqzNazUP7=gaw@mail.gmail.com>
 <67237877cd08d_b246b2942b@willemb.c.googlers.com.notmuch> <CAL+tcoBpdxtz5GHkTp6e52VDCtyZWvU7+1hTuEo1CnUemj=-eQ@mail.gmail.com>
 <65968a5c-2c67-4b66-8fe0-0cebd2bf9c29@linux.dev> <6724d85d8072_1a157829475@willemb.c.googlers.com.notmuch>
In-Reply-To: <6724d85d8072_1a157829475@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 2 Nov 2024 00:08:23 +0800
Message-ID: <CAL+tcoDyvAcwxdsOWfWoJ-ZJ=kMXdw-XM2BDC+_tJO+Eudg3jg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, willemb@google.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 9:32=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Martin KaFai Lau wrote:
> > On 10/31/24 6:50 AM, Jason Xing wrote:
> > > On Thu, Oct 31, 2024 at 8:30=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > >>
> > >> Jason Xing wrote:
> > >>> On Thu, Oct 31, 2024 at 2:27=E2=80=AFPM Martin KaFai Lau <martin.la=
u@linux.dev> wrote:
> > >>>>
> > >>>> On 10/30/24 5:13 PM, Jason Xing wrote:
> > >>>>> I realized that we will have some new sock_opt flags like
> > >>>>> TS_SCHED_OPT_CB in patch 4, so we can control whether to print or
> > >>>>> not... For each sock_opt point, they will be called without carin=
g if
> > >>>>> related flags in skb are set. Well, it's meaningless to add more
> > >>>>> control of skb tsflags at each TS_xx_OPT_CB point.
> > >>>>>
> > >>>>> Am I understanding in a correct way? Now, I'm totally fine with t=
his great idea!
> > >>>> Yes, I think so.
> > >>>>
> > >>>> The sockops prog can choose to ignore any BPF_SOCK_OPS_TS_*_CB. Th=
e are only 3:
> > >>>> SCHED, SND, and ACK. If the hwtstamp is available from a NIC, I th=
ink it would
> > >>>> be quite wasteful to throw it away. ACK can be controlled by the
> > >>>> TCP_SKB_CB(skb)->bpf_txstamp_ack.
> > >>>
> > >>> Right, let me try this:)
> > >>>
> > >>>> Going back to my earlier bpf_setsockopt(SOL_SOCKET, BPF_TX_TIMESTA=
MPING)
> > >>>> comment. I think it may as well go back to use the "u8
> > >>>> bpf_sock_ops_cb_flags;" and use the bpf_sock_ops_cb_flags_set() he=
lper to
> > >>>> enable/disable the timestamp related callback hook. May be add one
> > >>>> BPF_SOCK_OPS_TX_TIMESTAMPING_CB_FLAG.
> > >>>
> > >>> bpf_sock_ops_cb_flags this flag is only used in TCP condition, righ=
t?
> > >>> If that is so, it cannot be suitable for UDP.
> > >>>
> > >>> I'm thinking of this solution:
> > >>> 1) adding a new flag in SOF_TIMESTAMPING_OPT_BPF flag (in
> > >>> include/uapi/linux/net_tstamp.h) which can be used by sk->sk_tsflag=
s
> >
> > probably not in include/uapi/linux/net_tstamp.h. This flag can only be =
used by a
> > bpf prog (meaning will not be used by user space syscall). More below.
> >
> > >>> 2) flags =3D   SOF_TIMESTAMPING_OPT_BPF;    bpf_setsockopt(skops,
> > >>> SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));
> > >>> 3) test if sk->sk_tsflags has this new flag in tcp_tx_timestamp() o=
r
> > >>> in udp_sendmsg()
> > >>> ...
> >
> > Not sure how many churns/audits is needed to ensure the user space cann=
ot
> > set/clear the SOF_TIMESTAMPING_OPT_BPF bit in sk->sk_tsflags. Could be =
not much.
>
> Stores are limited to defined bits with the following in
> sock_set_timestamping
>
>         if (val & ~SOF_TIMESTAMPING_MASK)
>                 return -EINVAL;
>
> > May be it is cleaner to leave the sk->sk_tsflags for user space only an=
d having
> > a separate field in "struct sock" to track bpf specific needs. More lik=
e your
> > current sk_tsflags_bpf approach but I was thinking to reuse the
> > bpf_sock_ops_cb_flags instead. e.g. "BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
> > BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG)" is used to check if it needs to ca=
ll a bpf
> > prog to decide if it needs to add tcp header option. Here we want to te=
st if it
> > should call a bpf prog to make a decision on tx timestamp on a skb.
> >
> > The bpf_sock_ops_cb_flags can be moved from struct tcp_sock to struct s=
ock. It
> > is doable from the bpf side.
> >
> > All that said, but, yes, it will add some TCP specific enum flag (e.g.
> > BPF_SOCK_OPS_RTO_CB_FLAG) to the struct sock which will not be used by
> > UDP/raw/...etc, so may be keep your current sk_tsflags_bpf approach but=
 rename
> > it to sk_bpf_cb_flags in struct "sock" so that it can be reused for oth=
er non
> > tstamp ops in the future? probably a u8 is enough.
> >
> > This optname is used by the bpf prog only and not usable by user space =
syscall.
> > If it prefers to stay with bpf_setsockopt (which is fine), it needs a b=
pf
> > specific optname like the current TCP_BPF_SOCK_OPS_CB_FLAGS which curre=
ntly sets
> > the tp->bpf_sock_ops_cb_flags. May be a new SK_BPF_CB_FLAGS optname for=
 setting
> > the sk->sk_bpf_cb_flags, like bpf_setsockopt(skops_ctx, SOL_SOCKET,
> > SK_BPF_CB_FLAGS, &val, sizeof(val)) and handle it in the sol_socket_soc=
kopt()
> > alone without calling into sk_{set,get}sockopt. Add a new enum for the =
optval
> > for the sk_bpf_cb_flags:
> >
> > enum {
> >       SK_BPF_CB_TX_TIMESTAMPING =3D (1 << 0),
> >       SK_BPF_CB_RX_TIEMSTAMPING =3D (1 << 1),
> > };
> >
> > >>
> > >> On using the raw seqno: this data is accessible to anyone root in
> > >> namespace (ns_capable) using packet sockets, so as long as it does n=
ot
> > >> open to more than that, it is logically equivalent to the current
> > >> setting.
> > >>
> > >> With seqno the BPF program has to be careful that the same seqno can
> > >> be retransmitted, so for instance seeing an ACK before a (second) SN=
D
> > >> must be anticipated. That is true for SO_TIMESTAMPING today too.
> >
> > Ah. It will be a very useful comment to add to the selftests bpf prog.
> >
> > >>
> > >> For datagrams (UDP as well as RAW and many non IP protocols), an
> > >> alternative still needs to be found.
> >
> > In udp/raw/..., I don't know how likely is the user space having "cork-=
>tx_flags
> > & SKBTX_ANY_TSTAMP" set but has neither "READ_ONCE(sk->sk_tsflags) &
> > SOF_TIMESTAMPING_OPT_ID" nor "cork->flags & IPCORK_TS_OPT_ID" set.
>
> This is not something to rely on. OPT_ID was added relatively recently.
> Older applications, or any that just use the most straightforward API,
> will not set this.
>
> > If it is
> > unlikely, may be we can just disallow bpf prog from directly setting
> > skb_shinfo(skb)->tskey for this particular skb.
> >
> > For all other cases, in __ip[6]_append_data, directly call a bpf prog a=
nd also
> > pass the kernel decided tskey to the bpf prog.
> >
> > The kernel passed tskey could be 0 (meaning the user space has not used=
 it). The
> > bpf prog can give one for the kernel to use. The bpf prog can store the
> > sk_tskey_bpf in the bpf_sk_storage now. Meaning no need to add one to t=
he struct
> > sock. The bpf prog does not have to start from 0 (e.g. start from U32_M=
AX
> > instead) if it helps.
> >
> > If the kernel passed tskey is not 0, the bpf prog can just use that one
> > (assuming the user space is doing something sane, like the value in
> > SCM_TS_OPT_ID won't be jumping back and front between 0 to U32_MAX). I =
hope this
> > is very unlikely also (?) but the bpf prog can probably detect this and=
 choose
> > to ignore this sk.
>
> If an applications uses OPT_ID, it is unlikely that they will toggle
> the feature on and off on a per-packet basis. So in the common case
> the program could use the user-set counter or use its own if userspace
> does not enable the feature. In the rare case that an application does
> intermittently set an OPT_ID, the numbering would be erratic. This
> does mean that an actively malicious application could mess with admin
> measurements.
>

Sorry, I got lost in this part. What would you recommend I should do
about OPT_ID in the next move? Should I keep those three OPT_ID
patches?

Thanks,
Jason

