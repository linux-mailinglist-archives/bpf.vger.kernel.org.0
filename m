Return-Path: <bpf+bounces-43707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F1E9B8C51
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 08:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE6B1F231EE
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 07:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A15156F55;
	Fri,  1 Nov 2024 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQ9XNH7T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00514EC55;
	Fri,  1 Nov 2024 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730447265; cv=none; b=V0BD3HVtOhpObG2MgDlYQst3ibOXvgxRplYD0DXb/N7QxHH84WrfeaoDM3V/EAgTGOKMA8SBrtF7z5sI37eZoBRheEI9xQqrw6bxGpHRaD+6668zxRzcZfscXxbE6bl0K42wybWzv1I7foftcY0hjmUos++Uke5zqOTPW3mW4O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730447265; c=relaxed/simple;
	bh=Kn6Y4IReo6RyP+ZnuIbkj2Hn35F4Waan5QImJQaOKko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzHHWBYlP8KgiQY702lljqPrZwlHuAktOO7R9RS65ZWQAYCE27AYZYeGJzT0Cl7j1ZZqIC53xFpxnEQ20v03fugUgfQGMnQnfQpzGyHgxpD0+h9N9BYMeV3vQJTuIE8Py3BzameaFpMHVzD+W1zC1a3Yf4q3styY+ATqukNjXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQ9XNH7T; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a6ad7c5827so4583835ab.0;
        Fri, 01 Nov 2024 00:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730447262; x=1731052062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTHec3qfqGmeoMQnsstdVyZ+uts3mJdoDFc6paqCnS8=;
        b=MQ9XNH7Tr8MhLDx6LgG3k24nHefp2PVXhEwy1SXQ/9tozItcZsEc17ehMSCYLMcPBE
         cgj4MbXBwtQNdq7JtLCZVbqITPNdbBHmvLEdETum4b1ARl+JhyfRlMqBHcrToHdZXjXF
         gFPp0yaMQMUfqFEGNdBHO9c7yWzzW0sKhwFuCy6vLne/KVtGXH6HqqthAFXwcMl9F4IM
         AiOYpoh3tm4LAgl398xpoaE923H0aYPlxzbQ1UhhqWhM+Ey17OKmUGMFx6ZQN7uOUGLq
         CzvNZDGGLiv57h0DKIMxrh7NLHVpnY1mD2Z+yZXyiitu6p4yMoi3++Uhj9cufmw7ABHa
         BLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730447262; x=1731052062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTHec3qfqGmeoMQnsstdVyZ+uts3mJdoDFc6paqCnS8=;
        b=j6fceV8C3PncxH6jh2h/9G7cDAli9nUvjEc3w+4PYsW0tiR/OlxE9Cs+IN1weBgFpQ
         FiQCO6pyMCHQM1uB+S/ZpG8Ozk5cnlIcfW0irkh1oNjLxtmKOjgDdQNHx02VydQrB1VJ
         j0M+LOm43OBjv0pVn6lQaPc+H92Pb+5N0bTF4ML7sJnDifP6LbWMQDpZP9wAPBlz14AU
         sA6rUvUC3PxfRMN1kRcGxVPCbLJwnWeZC1ABM4QN6SrjC8kaMXcEy2qA8WwzgT2VpfpW
         09grElmA7+qoZJBNNkIRt69Rwhc9qTmH8aMp3X3UMq+rGTLJnn4vxJ4kzfuVpRRSZ52J
         UffA==
X-Forwarded-Encrypted: i=1; AJvYcCVSoh5gAs9NvghWBjiKz8EoV3eYhpR0dVmKUr75DIl+bdhw5sWK14Dky8qCVehvIvygLz8=@vger.kernel.org, AJvYcCVbjSpK4y8YLDEkUk9OjvhwJg/N+Bz8tpNiQORwRdajo1G8V+mDtHXrr531W9vfLaPFz9uZYySS@vger.kernel.org
X-Gm-Message-State: AOJu0YxNzAIMNS/Sxc/ObKHcOtxG8yNZPZiZgQ/jDAI1JqHkiHx+o9lX
	iZ6ZHasSuce5+YRfVr3ijdtmHDiZeAmY+LWBEAA3seO+L9V03KMlEz/38wkFxdwUJqPSThOlpO0
	/a4MtfPRQXfOTgyT0zPpRODDFPSc=
X-Google-Smtp-Source: AGHT+IEXDNKKel5E5ZS0flY6x2DlCC7M4iQ77kUnXPNSGoIZ8ueWC66RNMxKHCXi+Zc0BYIohIJTgx6Vj85oP5Nbj8E=
X-Received: by 2002:a92:c544:0:b0:3a0:8d60:8ba7 with SMTP id
 e9e14a558f8ab-3a6b02f128cmr28910695ab.14.1730447261970; Fri, 01 Nov 2024
 00:47:41 -0700 (PDT)
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
 <65968a5c-2c67-4b66-8fe0-0cebd2bf9c29@linux.dev>
In-Reply-To: <65968a5c-2c67-4b66-8fe0-0cebd2bf9c29@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 1 Nov 2024 15:47:05 +0800
Message-ID: <CAL+tcoD6fqrDhYDCFkuSuy-HgORo-qxLLwm+=WQqdQA1=C_S3w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, willemb@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 7:26=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 10/31/24 6:50 AM, Jason Xing wrote:
> > On Thu, Oct 31, 2024 at 8:30=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> >>
> >> Jason Xing wrote:
> >>> On Thu, Oct 31, 2024 at 2:27=E2=80=AFPM Martin KaFai Lau <martin.lau@=
linux.dev> wrote:
> >>>>
> >>>> On 10/30/24 5:13 PM, Jason Xing wrote:
> >>>>> I realized that we will have some new sock_opt flags like
> >>>>> TS_SCHED_OPT_CB in patch 4, so we can control whether to print or
> >>>>> not... For each sock_opt point, they will be called without caring =
if
> >>>>> related flags in skb are set. Well, it's meaningless to add more
> >>>>> control of skb tsflags at each TS_xx_OPT_CB point.
> >>>>>
> >>>>> Am I understanding in a correct way? Now, I'm totally fine with thi=
s great idea!
> >>>> Yes, I think so.
> >>>>
> >>>> The sockops prog can choose to ignore any BPF_SOCK_OPS_TS_*_CB. The =
are only 3:
> >>>> SCHED, SND, and ACK. If the hwtstamp is available from a NIC, I thin=
k it would
> >>>> be quite wasteful to throw it away. ACK can be controlled by the
> >>>> TCP_SKB_CB(skb)->bpf_txstamp_ack.
> >>>
> >>> Right, let me try this:)
> >>>
> >>>> Going back to my earlier bpf_setsockopt(SOL_SOCKET, BPF_TX_TIMESTAMP=
ING)
> >>>> comment. I think it may as well go back to use the "u8
> >>>> bpf_sock_ops_cb_flags;" and use the bpf_sock_ops_cb_flags_set() help=
er to
> >>>> enable/disable the timestamp related callback hook. May be add one
> >>>> BPF_SOCK_OPS_TX_TIMESTAMPING_CB_FLAG.
> >>>
> >>> bpf_sock_ops_cb_flags this flag is only used in TCP condition, right?
> >>> If that is so, it cannot be suitable for UDP.
> >>>
> >>> I'm thinking of this solution:
> >>> 1) adding a new flag in SOF_TIMESTAMPING_OPT_BPF flag (in
> >>> include/uapi/linux/net_tstamp.h) which can be used by sk->sk_tsflags
>
> probably not in include/uapi/linux/net_tstamp.h. This flag can only be us=
ed by a
> bpf prog (meaning will not be used by user space syscall). More below.
>
> >>> 2) flags =3D   SOF_TIMESTAMPING_OPT_BPF;    bpf_setsockopt(skops,
> >>> SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));
> >>> 3) test if sk->sk_tsflags has this new flag in tcp_tx_timestamp() or
> >>> in udp_sendmsg()
> >>> ...
>
> Not sure how many churns/audits is needed to ensure the user space cannot
> set/clear the SOF_TIMESTAMPING_OPT_BPF bit in sk->sk_tsflags. Could be no=
t much.
>
> May be it is cleaner to leave the sk->sk_tsflags for user space only and =
having
> a separate field in "struct sock" to track bpf specific needs. More like =
your
> current sk_tsflags_bpf approach but I was thinking to reuse the
> bpf_sock_ops_cb_flags instead. e.g. "BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
> BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG)" is used to check if it needs to call=
 a bpf
> prog to decide if it needs to add tcp header option. Here we want to test=
 if it
> should call a bpf prog to make a decision on tx timestamp on a skb.
>
> The bpf_sock_ops_cb_flags can be moved from struct tcp_sock to struct soc=
k. It
> is doable from the bpf side.
>
> All that said, but, yes, it will add some TCP specific enum flag (e.g.
> BPF_SOCK_OPS_RTO_CB_FLAG) to the struct sock which will not be used by
> UDP/raw/...etc, so may be keep your current sk_tsflags_bpf approach but r=
ename
> it to sk_bpf_cb_flags in struct "sock" so that it can be reused for other=
 non
> tstamp ops in the future? probably a u8 is enough.

Thanks so much for the details.

>
> This optname is used by the bpf prog only and not usable by user space sy=
scall.
> If it prefers to stay with bpf_setsockopt (which is fine), it needs a bpf
> specific optname like the current TCP_BPF_SOCK_OPS_CB_FLAGS which current=
ly sets
> the tp->bpf_sock_ops_cb_flags. May be a new SK_BPF_CB_FLAGS optname for s=
etting
> the sk->sk_bpf_cb_flags, like bpf_setsockopt(skops_ctx, SOL_SOCKET,

> SK_BPF_CB_FLAGS, &val, sizeof(val)) and handle it in the sol_socket_socko=
pt()
> alone without calling into sk_{set,get}sockopt. Add a new enum for the op=
tval
> for the sk_bpf_cb_flags:
>
> enum {
>         SK_BPF_CB_TX_TIMESTAMPING =3D (1 << 0),
>         SK_BPF_CB_RX_TIEMSTAMPING =3D (1 << 1),
> };

Then it will involve more strange modification in sol_socket_sockopt()
to retrieve the opt value like what I did in V2 (see
https://lore.kernel.org/all/20241012040651.95616-3-kerneljasonxing@gmail.co=
m/).
It's the reason why I did set and get operation in
sk_{set,get}sockopt() in this series to keep align with other flags.
Handling it in sk_{set,get}sockopt() is not a bad idea and easy to
implement, I feel.

Overall the suggestion looks good to me. I can give it a try :)

I'm thinking of another approach to using bpf_sock_ops_cb_flags_set()
instead of bpf_setsockopt() when sockops like
BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB is triggered. I can modify the
bpf_sock_ops_cb_flags_set like this:
diff --git a/net/core/filter.c b/net/core/filter.c
index 58761263176c..001140067c1a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5770,14 +5770,25 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct
bpf_sock_ops_kern *, bpf_sock,
           int, argval)
 {
        struct sock *sk =3D bpf_sock->sk;
-       int val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
+       int val =3D argval;

-       if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
+       if (!IS_ENABLED(CONFIG_INET))
                return -EINVAL;

-       tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
+       if (sk_is_tcp(sk)) {
+               val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
+               if (!sk_fullsock(sk))
+                       return -EINVAL;
+
+               tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
+
+               val =3D argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
+       } else {
+               sk->bpf_sock_ops_cb_flags =3D val;
+               val =3D argval &
(~(SK_BPF_CB_TX_TIEMSTAMPING|SK_BPF_CB_RX_TIEMSTAMPING));
+       }

-       return argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
+       return val;
 }

The BPF program uses bpf_sock_ops_cb_flags_set(skops,
SK_BPF_CB_FLAGS); to set the flags. Then we can implement a similar
function like BPF_SOCK_OPS_TEST_FLAG() in tcp_tx_timestamp() to check
if we are allowed to set shinfo->tx_flags |=3D SKBTX_BPF.

One advantage of this approach is that the bpf_sock_ops_cb_flags_set()
could be extended for more than only TCP in the future. Admittedly,
this will involve more work.

Which way would you prefer?

>
>
> >>>
> >>>>
> >>>> For tx, one new hook should be at the sendmsg and should be around
> >>>> tcp_tx_timestamp (?) for tcp. Another hook is __skb_tstamp_tx() whic=
h should be
> >>>
> >>> I think there are two points we're supposed to record:
> >>> 1) the moment tcp/udp_sendmsg() is triggered. It represents the sysca=
ll time.
> >>> 2) another point in tcp_tx_timestamp(). It represents the timestamp o=
f
> >>> the last skb in this sendmsg() call.
> >>> Users may happen to send a big packet.
>
> hmm... a big packet and sendmsg is blocked waiting for memory?
>
> >>
> >> Err on the side of fewer measurement points. It's always possible to
> >> add more later, but not possible to remove them (depending on whether
> >> BPF infra is ABI).
>
> I also think it is better to start with tcp_tx_timestamp() alone first to=
 keep
> the patch set simple now. The selftest prog can use a bpf fentry prog to =
trace
> the tcp_sendmsg_locked(). This can be revisited later if the bpf fentry p=
rog is
> not enough.
>
> >>
> >> Overall great suggestion. Thanks a lot for sharing your BPF expertise
> >> on this, Martin.
>
> Thanks!
>
> >>
> >> On using the raw seqno: this data is accessible to anyone root in
> >> namespace (ns_capable) using packet sockets, so as long as it does not
> >> open to more than that, it is logically equivalent to the current
> >> setting.
> >>
> >> With seqno the BPF program has to be careful that the same seqno can
> >> be retransmitted, so for instance seeing an ACK before a (second) SND
> >> must be anticipated. That is true for SO_TIMESTAMPING today too.
>
> Ah. It will be a very useful comment to add to the selftests bpf prog.
>
> >>
> >> For datagrams (UDP as well as RAW and many non IP protocols), an
> >> alternative still needs to be found.
>
> In udp/raw/..., I don't know how likely is the user space having "cork->t=
x_flags
> & SKBTX_ANY_TSTAMP" set but has neither "READ_ONCE(sk->sk_tsflags) &
> SOF_TIMESTAMPING_OPT_ID" nor "cork->flags & IPCORK_TS_OPT_ID" set. If it =
is
> unlikely, may be we can just disallow bpf prog from directly setting
> skb_shinfo(skb)->tskey for this particular skb.
>
> For all other cases, in __ip[6]_append_data, directly call a bpf prog and=
 also
> pass the kernel decided tskey to the bpf prog.

I'm a bit confused here. IIUC, we need to support the tskey like what
we did in this series to handle non TCP cases?

I think I can keep those three patches related to tskey to support
both TCP and non-TCP cases. Then let the bpf program decide to use
tskey.

>
> The kernel passed tskey could be 0 (meaning the user space has not used i=
t). The
> bpf prog can give one for the kernel to use. The bpf prog can store the
> sk_tskey_bpf in the bpf_sk_storage now. Meaning no need to add one to the=
 struct
> sock. The bpf prog does not have to start from 0 (e.g. start from U32_MAX
> instead) if it helps.
>
> If the kernel passed tskey is not 0, the bpf prog can just use that one
> (assuming the user space is doing something sane, like the value in
> SCM_TS_OPT_ID won't be jumping back and front between 0 to U32_MAX). I ho=
pe this
> is very unlikely also (?) but the bpf prog can probably detect this and c=
hoose
> to ignore this sk.
>
> To solve the above unsupported corner cases, I think we can allow the bpf=
 prog
> to store something in the shinfo->hwtstamps at the tx path. The bpf-only =
key
> could be one of the things to store there. Change __ip[6]_append_data to =
handle
> the shinfo->hwtstamps. I think allowing the bpf prog to write to the
> shinfo->hwtsatmps could be considered later when needed.
>
> [ I may be off tomorrow, so reply could be slower. ]

Thanks for your help!

Thanks,
Jason

