Return-Path: <bpf+bounces-42147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B17729A0117
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 08:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06EC1B212CB
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 06:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D857060B8A;
	Wed, 16 Oct 2024 06:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvTyGDOd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD693156E4;
	Wed, 16 Oct 2024 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729058941; cv=none; b=rLBgj2sgd2dmBrLYRwsUhAj/PELHJs7fnzAbQCncAZoVwQcFY/FySWwkY5UeFrBQm2c94VEfpDiT5gs6PAAYQ9eXy+fQA50lSDUWmYERrkkmppxA+kJsv/V25ZaL4WixeDDocEplV3nELajrT+RQX2zQf9hYIMdrg68rS+Fn/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729058941; c=relaxed/simple;
	bh=ebzumEmDzyjF0JoG4K8R+WuweV5IQu3/k3g/AmH5Xl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuCn428z5CeIQO3IdtUE+BmQs/PkN9OBmzfcJJWl3N7Qq1dlFufQvasYHEKvafPAKSDDja8GuGfhDZfxNmzkmG2oncReRmwHUuclpNooOygbMM87mvqhEP03973xhRmk9TmaBm71ecFm/znFKb3Jtq83m1ZuhGAKauqRhpcNZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvTyGDOd; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a3a309154aso22010805ab.2;
        Tue, 15 Oct 2024 23:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729058939; x=1729663739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1UikS0EzH5Q7Y3AmkF1RjpIHDh5aj7sa0kYtYAxZDE=;
        b=dvTyGDOdGAPOQl/DuMA5AOtNj0WzE1zz1/vpll4+ugCJgy3JKY5aDO7sihUfBISTku
         Zcozlt6scYlm3fcrd7ZEX9waVsf8fzkU1zo3shyQ5TKH3OsQMdPj5dedK0jOHlVTirJm
         NoBmBwau0I1rtso5Z2iX2Lq2fQHD1MtqehOkpr+R/wdQZ0pmrJtqPx6J3u+gxFEgnX6j
         Xan6gbyn42GVu6Qtzo/BtfjvIIx6f/bpW918lDUF/P2JfGtx08Clip3md9/wsPTwP+Yd
         aR8I2dnyQ9xb3L9Ma1Vo0P9HNyxbn2Q4VD8y1M+fun6u117v8aOvFZ8NYgP7bq5c7tSB
         c+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729058939; x=1729663739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1UikS0EzH5Q7Y3AmkF1RjpIHDh5aj7sa0kYtYAxZDE=;
        b=MLDwja0wXQml4yiVYXvc7ha1ULqL0a93El45tMnZRQyfFfgzOGOhP1iCCxfKEe4WYX
         pstPx0VY8p+E4JVOPFlK/t+FiloqUh9/vEuVkW43ontonwZWdr2+My1cvrwopFUlWw7h
         irJqv1d/MyEb4STJXvyxiia9LJQWwTgeUwjy0C+Jogjj4pMO5hIfcFm9/VSGL20LJ9MR
         qJPkJ99PSRgbBg3YTA0J+jyAQTXLzmNT+koGYkEqgjI8e7H4sCUjbZM4PmSI2dC6AJF6
         xEapeW4b6+Nmc6qH7t0URibNokIAoozzjmkAj7IaCIXuQU6fh2ZxpV7IerKMI6fqYX1e
         tuig==
X-Forwarded-Encrypted: i=1; AJvYcCW9ccratULpUtXYQi2wuX3T3wHv/ik5Mnxn+8v8xyUoNUhMPk8LuoftJlidgt3S4CvpVakYgxZJ@vger.kernel.org, AJvYcCWWWLVwemeFmlUtB5taqDNIwgUQJ7Bb+98t64nzFSiMqaDcYdxTEMvN9IrEau/LKL8UEMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz17PAL+LqcQW5SA1vXP7YgoFgkiqIrgbFrSKnVOJ6Up9KkjJE5
	lNxioaJ0Ds5DvCG/me3syZIUDQbrFJfs2/looj3gE8UBrBdhnwsMY5yUdB4bHOp10GRgGE9S7kG
	BW5wcb3VZdo3Xb6QP/8SWoxYnjJY=
X-Google-Smtp-Source: AGHT+IHJRM1q5fRv9cX0UeH9F6Neillbbvr9FRau8xvPKCT4WfK3v7j7OxdZ6y1SEdjto4yp6hq528SDivruOpxXHw8=
X-Received: by 2002:a05:6e02:168e:b0:3a0:451b:ade3 with SMTP id
 e9e14a558f8ab-3a3b5f6b26bmr160402745ab.10.1729058938716; Tue, 15 Oct 2024
 23:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-7-kerneljasonxing@gmail.com> <b4767fab-9c61-49f0-8185-6445349ae30b@linux.dev>
 <CAL+tcoD8OF0LCSFVEN-oEQas1JGfR+HF7Zt+2fqMH5_4eK9X4g@mail.gmail.com> <7c7b2366-074e-48c1-a918-daf0a94c4b55@linux.dev>
In-Reply-To: <7c7b2366-074e-48c1-a918-daf0a94c4b55@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 16 Oct 2024 14:08:22 +0800
Message-ID: <CAL+tcoBU1FSVvhiTmapX=Byhv8W0T1f8oFR4sAZ1g4xONgSPrg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 06/12] net-timestamp: introduce
 TS_SCHED_OPT_CB to generate dev xmit timestamp
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 1:35=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/15/24 6:24 PM, Jason Xing wrote:
> > On Wed, Oct 16, 2024 at 9:01=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 10/11/24 9:06 PM, Jason Xing wrote:
> >>> From: Jason Xing <kernelxing@tencent.com>
> >>>
> >>> Introduce BPF_SOCK_OPS_TS_SCHED_OPT_CB flag so that we can decide to
> >>> print timestamps when the skb just passes the dev layer.
> >>>
> >>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >>> ---
> >>>    include/uapi/linux/bpf.h       |  5 +++++
> >>>    net/core/skbuff.c              | 17 +++++++++++++++--
> >>>    tools/include/uapi/linux/bpf.h |  5 +++++
> >>>    3 files changed, 25 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >>> index 157e139ed6fc..3cf3c9c896c7 100644
> >>> --- a/include/uapi/linux/bpf.h
> >>> +++ b/include/uapi/linux/bpf.h
> >>> @@ -7019,6 +7019,11 @@ enum {
> >>>                                         * by the kernel or the
> >>>                                         * earlier bpf-progs.
> >>>                                         */
> >>> +     BPF_SOCK_OPS_TS_SCHED_OPT_CB,   /* Called when skb is passing t=
hrough
> >>> +                                      * dev layer when SO_TIMESTAMPI=
NG
> >>> +                                      * feature is on. It indicates =
the
> >>> +                                      * recorded timestamp.
> >>> +                                      */
> >>>    };
> >>>
> >>>    /* List of TCP states. There is a build check in net/ipv4/tcp.c to=
 detect
> >>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >>> index 3a4110d0f983..16e7bdc1eacb 100644
> >>> --- a/net/core/skbuff.c
> >>> +++ b/net/core/skbuff.c
> >>> @@ -5632,8 +5632,21 @@ static void bpf_skb_tstamp_tx_output(struct so=
ck *sk, int tstype)
> >>>                return;
> >>>
> >>>        tp =3D tcp_sk(sk);
> >>> -     if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT=
_CB_FLAG))
> >>> -             return;
> >>> +     if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT=
_CB_FLAG)) {
> >>> +             struct timespec64 tstamp;
> >>> +             u32 cb_flag;
> >>> +
> >>> +             switch (tstype) {
> >>> +             case SCM_TSTAMP_SCHED:
> >>> +                     cb_flag =3D BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> >>> +                     break;
> >>> +             default:
> >>> +                     return;
> >>> +             }
> >>> +
> >>> +             tstamp =3D ktime_to_timespec64(ktime_get_real());
> >>> +             tcp_call_bpf_2arg(sk, cb_flag, tstamp.tv_sec, tstamp.tv=
_nsec);
> >>
> >> There is bpf_ktime_get_*() helper. The bpf prog can directly call the
> >> bpf_ktime_get_* helper and use whatever clock it sees fit instead of e=
nforcing
> >> real clock here and doing an extra ktime_to_timespec64. Right now the
> >> bpf_ktime_get_*() does not have real clock which I think it can be add=
ed.
> >
> > In this way, there is no need to add tcp_call_bpf_*arg() to pass
> > timestamp to userspace, right? Let the bpf program implement it.
> >
> > Now I wonder what information I should pass? Sorry for the lack of BPF
> > related knowledge :(
>
> Just pass the cb_flag op in this case.

I see. I saw one example just passing a NULL parameter:
tcp_call_bpf(sk, BPF_SOCK_OPS_BASE_RTT, 0, NULL);.

>
> A bpf selftest is missing in this series to show how it is going to be us=
ed.

Sorry, I didn't implement a standard selftest, but I wrote a full BPF
program in patch[0/12]. I planned to write a selftests after every
expert agrees the current approach.

> Yes, there are existing socket API tests on time stamping but I believe t=
his
> discussion has already shown some subtle differences that warrant a close=
r to
> real world bpf prog example first.
>
> >
> >>
> >> I think overall the tstamp reporting interface does not necessarily ha=
ve to
> >> follow the socket API. The bpf prog is running in the kernel. It could=
 pass
> >> other information to the bpf prog if it sees fit. e.g. the bpf prog co=
uld also
> >> get the original transmitted tcp skb if it is useful.
> >
> > Good to know that! But how the BPF program parses the skb by using
> > tcp_call_bpf_2arg() which only passes u32 parameters.
>
> "struct skbuff *skb" has already been added to "struct bpf_sock_ops_kern"=
. It is
> only assigned during the "BPF_SOCK_OPS_PARSE_*HDR_CB". It is not exposed
> directly to bpf prog but it could be. However, it may need to change some
> convert_ctx code in filter.c which I am not excited about. We haven't add=
ed
> convert_ctx changes for a while since it is the old way.
>
> Together with the "u32  bpf_sock_ops_cb_flags;" change in patch 9 which i=
s only
> for tcp_sock and other _CB flags are also tcp specific only. For now, I a=
m not

Right, the first move I made is to make TCP work.

> sure carrying this sockops to the future UDP support is desired.

I hope so. But it's not an urgent thing that needs to be done recently.

>
> Take a look at tcp_call_bpf(). It needs to initialize the whole "struct
> bpf_sock_ops_kern" regardless of what the bpf prog is needed before calli=
ng the
> bpf prog. The "u32 args[4]" is one of them. The is the older way of using=
 bpf to
> extend kernel.

I see.

>
> bpf has struct_ops support now which can pass only what is needed and wit=
hout
> the need of doing the convert_ctx in filter.c. The "struct tcp_congestion=
_ops"
> can already be implemented in bpf. Take a look at
> selftests/bpf/progs/bpf_cubic.c. All the BPF_SOCK_OPS_*_CB (e.g.
> BPF_SOCK_OPS_TS_SCHED_OPT_CB here) could just a "ops" in the struct_ops.

Interesting, but it seems this way is much more complex than the
current approach.

>
> That said, I think the first thing needs to figure out is how to enable b=
pf time
> stamping without having side effect on the user space.

In the next version, I will avoid affecting the cmsg case, so no more
side effects I think.

> Continue the sockops approach first

I'm a little hesitant to do so because it looks like we will introduce
more codes. Please let me investigate more :)

> and use it to create a selftest bpf prog example. Then we can decide.

I copy the BPF program from patch [0/12], please take a look and help
me review this:
---
Here is the test output:
1) receive path
iperf3-987305  [008] ...11 179955.200990: bpf_trace_printk: rx: port:
5201:55192, swtimestamp: 1728167973,670426346, hwtimestamp: 0,0
2) xmit path
iperf3-19765   [013] ...11  2021.329602: bpf_trace_printk: tx: port:
47528:5201, key: 1036, timestamp: 1728357067,436678584
iperf3-19765   [013] b..11  2021.329611: bpf_trace_printk: tx: port:
47528:5201, key: 1036, timestamp: 1728357067,436689976
iperf3-19765   [013] ...11  2021.329622: bpf_trace_printk: tx: port:
47528:5201, key: 1036, timestamp: 1728357067,436700739

Here is the full bpf program:
#include <linux/bpf.h>

#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>
#include <uapi/linux/net_tstamp.h>

int _version SEC("version") =3D 1;
char _license[] SEC("license") =3D "GPL";

# define SO_TIMESTAMPING         37

__section("sockops")
int set_initial_rto(struct bpf_sock_ops *skops)
{
        int op =3D (int) skops->op;
        u32 sport =3D 0, dport =3D 0;
        int flags;

        switch (op) {
        //case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
        case BPF_SOCK_OPS_TCP_CONNECT_CB:
        case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
                flags =3D SOF_TIMESTAMPING_RX_SOFTWARE |
                        SOF_TIMESTAMPING_TX_SCHED |
SOF_TIMESTAMPING_TX_ACK | SOF_TIMESTAMPING_TX_SOFTWARE |
                        SOF_TIMESTAMPING_OPT_ID | SOF_TIMESTAMPING_OPT_ID_T=
CP;
                bpf_setsockopt(skops, SOL_SOCKET, SO_TIMESTAMPING,
&flags, sizeof(flags));
                bpf_sock_ops_cb_flags_set(skops,
BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG|BPF_SOCK_OPS_RX_TIMESTAMPING_OPT_C=
B_FLAG);
                break;
        case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
        case BPF_SOCK_OPS_TS_SW_OPT_CB:
        case BPF_SOCK_OPS_TS_ACK_OPT_CB:
                dport =3D bpf_ntohl(skops->remote_port);
                sport =3D skops->local_port;
                bpf_printk("tx: port: %u:%u, key: %u, timestamp: %u,%u\n",
                            sport, dport, skops->args[0],
skops->args[1], skops->args[2]);
                break;
        case BPF_SOCK_OPS_TS_RX_OPT_CB:
                dport =3D bpf_ntohl(skops->remote_port);
                sport =3D skops->local_port;
                bpf_printk("rx: port: %u:%u, swtimestamp: %u,%u,
hwtimestamp: %u,%u\n",
                           sport, dport, skops->args[0],
skops->args[1], skops->args[2], skops->args[3]);
                break;
        }
        return 1;
}
---

What is your opinion on the above?

Thanks,
Jason

