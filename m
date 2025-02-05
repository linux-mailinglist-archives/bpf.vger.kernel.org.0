Return-Path: <bpf+bounces-50491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2695A2838A
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 06:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7E93A624E
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 05:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C5321D591;
	Wed,  5 Feb 2025 05:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZYTbZe2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463025A638;
	Wed,  5 Feb 2025 05:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738732425; cv=none; b=VyqxqEPfeKDYwxsa4ujmga/9eD5cM58gDHlkVLw3441J7+/GGhWHotVnCiQMvQtkulaFzNtM2uFmJ4c7HBMzRHUpfaZabck2oR7pSUs6yUQKFQCunRh5OCP3p+IrYuTIBWbL2FxpDb8q3PI5j53unTe0wPYv/WGog+qn/KKdflI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738732425; c=relaxed/simple;
	bh=NnUyLGd0J5HP1qkVQ2irVv/Ke+Av9/j8d6x87t+V09c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKfYTDQw+eFgOmRbYYK1AF7DhE7NjKeLTH5f1fP/vgvFEp6jH3F3Waf+LE80yIgABZxrptmKXcYziV5xYSxbbr3h6M0IOSQHlsp9FL7SKUULNmw5njbMeDWHpKuZwCjtc0/RgZSb4egxcC+01IlPrHmVpDg83FTuPhKLr3Cf3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZYTbZe2; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3cfae81ab24so20316285ab.3;
        Tue, 04 Feb 2025 21:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738732422; x=1739337222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09LBenV5RdUiRWqwecYlsSGYpMdBrlv60A9ABrvh5+w=;
        b=GZYTbZe27sdppxd1VsoBubNSM71loY3ytCkCe6jZlydncwq0PC/CBFxvpYfNK+pU1F
         KVbrrSwmsyqk+a7iy0+3/z/V3vSWokcJfMTKCW1BAAWGffxs2unuXMDamF0+Hg2fj52T
         rYjrnV/QQ0mwO3sulZ16OpBu4wqlzdPs6uKdIp9BNO6udWkK4if0b8PC7fWdQ3eKjaTC
         iYqzY50Gre28d1FsfTX3ViUYt6mLYAHb+OH2CbmXmcH325vBZB6vbw3hVBVXUZUWUmUV
         lUl+cAlso5Sl2jmy20oxMajEYaegEMr+2JLicTfw2ntYVbccfZ2FmfA93MrkJMrVS9/d
         SQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738732422; x=1739337222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09LBenV5RdUiRWqwecYlsSGYpMdBrlv60A9ABrvh5+w=;
        b=YCLgN9CJs96IllbgtK0+JYgV8KNdMlTMAPf7uSdZ5qZCeJqIKLD+RH7LrCYSu3jp8U
         fEOQUC5fjcsugOuCls5W81oMeMUcRkx71AICKT9Fo9ClKCKOY8sm1fLI82n/UKdtv1vt
         JUzMAfqjP5uk0DoTFUrlr21bQph/Do6NooHsPQQEPIKHJt1U3bnt4gxvGXly/Aj3k6ef
         IbZK25nFNrzQoARlt/D5uv/dFHiOcyDbzgtvTm2FFtszRMPjgWropXFtYbiX7Fdd2ZL1
         Ix9nxZT2FgGhKvctHtA9IIXPQq39HhNjXfaNutS4EtAnrGBGRJ3paXX4moVd1wYvQnfP
         1WZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVevGnopNOIXO7vLtIaleiMVZ32atOXtSy58+6AxpeDM6H/7kceekEL87+PVrr9gvWwCpLNbJHj@vger.kernel.org, AJvYcCWv+YiVgeJY+cM61zV4hDlo2njsUtxDj8yvL3RwS7fu2l6n4WdxJn/WPfctjJ7tZPnzUHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+M4utgxyzzYqODFfvJP96ZwDQxNLHpP+87Eoy2f87YVEHUZfr
	6NCHhhM3r6iHpPqaiTs0dCT11K+OufT7oP2EPC38BRGuYNhpz6Jkbbjn5dOIvCt3nvnP6ZVrSov
	fr5GFnTOgdy+nz+38NRcsayXoIRs=
X-Gm-Gg: ASbGncsA01Md+byUNnXfU1ZiTTVNw4dNhEe1F56hSMrPARfgGPCA1lFVTm2vreXjXR3
	Sc4Gdq8UYnsbNkbBUO+N8SO9YpGil6Av7nEM9YJGFyoyh9gvpNcmkKyOHTfc5XIsouJQB9UEn
X-Google-Smtp-Source: AGHT+IFOuNBLGLMg6CePjetYHglzt/3zLqFdGfLGGVjYbL+iFpd91o7KB6frYSjLXmtoT1KjaYPcnbG9BOcnP5/Bub8=
X-Received: by 2002:a05:6e02:2610:b0:3cf:ba5:1ea3 with SMTP id
 e9e14a558f8ab-3d04f42562amr17150305ab.7.1738732422500; Tue, 04 Feb 2025
 21:13:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-12-kerneljasonxing@gmail.com> <d2605829-d5c2-4ce2-ac27-9f1df0398ccc@linux.dev>
 <CAL+tcoDZXc56BsO9tYvb1EFDdMHhv3OcBsPwY3ctJ85rvb+OHA@mail.gmail.com>
 <67a24989d7202_bb56629425@willemb.c.googlers.com.notmuch> <CAL+tcoA7Efzxg9c-CBn3S0JEQZLUHBaCA+dL=mgWbVh26SukgA@mail.gmail.com>
 <CAL+tcoAeBJ=F8cZ9qYwGF6jmc+DwA2byrrzAZjcpNYzrjT541g@mail.gmail.com>
In-Reply-To: <CAL+tcoAeBJ=F8cZ9qYwGF6jmc+DwA2byrrzAZjcpNYzrjT541g@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Feb 2025 13:13:06 +0800
X-Gm-Features: AWEUYZmEz1iGFd_6PPKlmf26vpGNnkcpEsxZtllyK3tICyJjNaHpxurKIR9tR5c
Message-ID: <CAL+tcoDZyB8FX1=zMZq5vgB_DWc=qpmJ0xQP7N2T90a4wamFjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 11/13] net-timestamp: add a new callback in tcp_tx_timestamp()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 11:05=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Feb 5, 2025 at 2:09=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Wed, Feb 5, 2025 at 1:08=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Tue, Feb 4, 2025 at 9:16=E2=80=AFAM Martin KaFai Lau <martin.lau=
@linux.dev> wrote:
> > > > >
> > > > > On 1/28/25 12:46 AM, Jason Xing wrote:
> > > > > > Introduce the callback to correlate tcp_sendmsg timestamp with =
other
> > > > > > points, like SND/SW/ACK. We can let bpf trace the beginning of
> > > > > > tcp_sendmsg_locked() and fetch the socket addr, so that in
> > > > >
> > > > > Instead of "fetch the socket addr...", should be "store the sendm=
sg timestamp at
> > > > > the bpf_sk_storage ...".
> > > >
> > > > I will revise it. Thanks.
> > > >
> > > > >
> > > > > > tcp_tx_timestamp() we can correlate the tskey with the socket a=
ddr.
> > > > >
> > > > >
> > > > > > It is accurate since they are under the protect of socket lock.
> > > > > > More details can be found in the selftest.
> > > > >
> > > > > The selftest uses the bpf_sk_storage to store the sendmsg timesta=
mp at
> > > > > fentry/tcp_sendmsg_locked and retrieves it back at tcp_tx_timesta=
mp (i.e.
> > > > > BPF_SOCK_OPS_TS_SND_CB added in this patch).
> > > > >
> > > > > >
> > > > > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > > > ---
> > > > > >   include/uapi/linux/bpf.h       | 7 +++++++
> > > > > >   net/ipv4/tcp.c                 | 1 +
> > > > > >   tools/include/uapi/linux/bpf.h | 7 +++++++
> > > > > >   3 files changed, 15 insertions(+)
> > > > > >
> > > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.=
h
> > > > > > index 800122a8abe5..accb3b314fff 100644
> > > > > > --- a/include/uapi/linux/bpf.h
> > > > > > +++ b/include/uapi/linux/bpf.h
> > > > > > @@ -7052,6 +7052,13 @@ enum {
> > > > > >                                        * when SK_BPF_CB_TX_TIME=
STAMPING
> > > > > >                                        * feature is on.
> > > > > >                                        */
> > > > > > +     BPF_SOCK_OPS_TS_SND_CB,         /* Called when every send=
msg syscall
> > > > > > +                                      * is triggered. For TCP,=
 it stays
> > > > > > +                                      * in the last send proce=
ss to
> > > > > > +                                      * correlate with tcp_sen=
dmsg timestamp
> > > > > > +                                      * with other timestampin=
g callbacks,
> > > > > > +                                      * like SND/SW/ACK.
> > > > >
> > > > > Do you have a chance to look at how this will work at UDP?
> > > >
> > > > Sure, I feel like it could not be useful for UDP. Well, things get
> > > > strange because I did write a long paragraph about this thing which
> > > > apparently disappeared...
> > > >
> > > > I manage to find what I wrote:
> > > >     For UDP type, BPF_SOCK_OPS_TS_SND_CB may be not suitable becaus=
e
> > > >     there are two sending process, 1) lockless path, 2) lock path, =
which
> > > >     should be handled carefully later. For the former, even though =
it's
> > > >     unlikely multiple threads access the socket to call sendmsg at =
the
> > > >     same time, I think we'd better not correlate it like what we do=
 to the
> > > >     TCP case because of the lack of sock lock protection. Consideri=
ng SND_CB is
> > > >     uapi flag, I think we don't need to forcely add the 'TCP_' pref=
ix in
> > > >     case we need to use it someday.
> > > >
> > > >     And one more thing is I'd like to use the v5[1] method in the n=
ext round
> > > >     to introduce a new tskey_bpf which is good for UDP type. The ne=
w field
> > > >     will not conflict with the tskey in shared info which is genera=
ted
> > > >     by sk->sk_tskey in __ip_append_data(). It hardly works if both =
features
> > > >     (so_timestamping and its bpf extension) exists at the same time=
. Users
> > > >     could get confused because sometimes they fetch the tskey from =
skb,
> > > >     sometimes they don't, especially when we have cmsg feature to t=
urn it on/
> > > >     off per sendmsg. A standalone tskey for bpf extension will be n=
eeded.
> > > >     With this tskey_bpf, we can easily correlate the timestamp in s=
endmsg
> > > >     syscall with other tx points(SND/SW/ACK...).
> > > >
> > > >     [1]: https://lore.kernel.org/all/20250112113748.73504-14-kernel=
jasonxing@gmail.com/
> > > >
> > > >     If possible, we can leave this question until the UDP support s=
eries
> > > >     shows up. I will figure out a better solution :)
> > > >
> > > > In conclusion, it probably won't be used by the UDP type. It's uAPI
> > > > flag so I consider the compatibility reason.
> > >
> > > I don't think this is acceptable. We should aim for an API that can
> > > easily be used across protocols, like SO_TIMESTAMPING.
> >
> > After I revisit the UDP SO_TIMESTAMPING again, my thoughts are
> > adjusted like below:
> >
> > It's hard to provide an absolutely uniform interface or usage to users
> > for TCP and UDP and even more protocols. Cases can be handled one by
> > one. The main obstacle is how we can correlate the timestamp in
> > sendmsg syscall with other sending timestamps. It's worth noticing
> > that for SO_TIMESTAMPING the sendmsg timestamp is collected in the
> > userspace. For instance, while skb enters the qdisc, we fail to know
> > which skb belongs to which sendmsg.
> >
> > An idea coming up is to introduce BPF_SOCK_OPS_TS_SND_CB to correlate
> > the sendmsg timestamp with tskey (in tcp_tx_timestamp()) under the
> > protection of socket lock + syscall as the current patch does. But for
> > UDP, it can be lockless. IIUC, there is a very special case where even
> > SO_TIMESTAMPING may get lost: if multiple threads accessing the same
> > socket send UDP packets in parallel, then users could be confused
> > which tskey matches which sendmsg. IIUC, I will not consider this
> > unlikely case, then the UDP case is quite similar to the TCP case.
> >
> > The scenario for the UDP case is:
> > 1) using fentry bpf to hook the udp_sendmsg() to get the timestamp
> > like TCP does in this series.
> > 2) insert BPF_SOCK_OPS_TS_SND_CB into __ip_append_data() near the
> > SO_TIMESTAMPING code snippets to let bpf program correlate the tskey
> > with timestamp.
> > Note: tskey in UDP will be handled carefully in a different way
> > because we should support both modes for socket timestamping at the
> > same time.
> > It's really similar to TCP regardless of handling tskey.
> >
>
> To be more precise in case you don't have much time to read the above
> long paragraph, BPF_SOCK_OPS_TS_SND_CB is mainly used to correlate
> sendmsg timestamp with corresponding tskey.
>
> 1. For TCP, we can correlate it in tcp_tx_timestamp() like this patch doe=
s.
>
> 2. For UDP, we can correlate in __ip_append_data() along with those
> tskey initialization, assuming there are no multiple threads calling
> locklessly ip_make_skb(). Locked path
> (udp_sendmsg()->ip_append_data()) works like TCP under the socket lock
> protection, so it can be easily handled. Lockless path
> (udp_sendmsg()->ip_make_skb()) can be visited by multiple threads at
> the same time, which should be handled properly. I prefer to implement
> the bpf extension for IPCORK_TS_OPT_ID, which should be another topic,
> I think. This might be the only one corner case, IIUC?
>
> Overall I think BPF_SOCK_OPS_TS_SND_CB can work across protocols to do
> the correlation job.
>
> To be on the safe side, I can change the name BPF_SOCK_OPS_TS_SND_CB
> to BPF_SOCK_OPS_TS_TCP_SND_CB just in case this approach is not the
> best one. What do you think about this?
>
> [1]
> commit 4aecca4c76808f3736056d18ff510df80424bc9f
> Author: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Date:   Tue Oct 1 05:57:14 2024 -0700
>
>     net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
>
>     SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate T=
X
>     timestamps and packets sent via socket. Unfortunately, there is no wa=
y
>     to reliably predict socket timestamp ID value in case of error return=
ed
>     by sendmsg. For UDP sockets it's impossible because of lockless
>     nature of UDP transmit, several threads may send packets in parallel.=
 In
>     case of RAW sockets MSG_MORE option makes things complicated. More
>     details are in the conversation [1].
>     This patch adds new control message type to give user-space
>     software an opportunity to control the mapping between packets and
>     values by providing ID with each sendmsg for UDP sockets.
>     The documentation is also added in this patch.
>
>     [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1S=
D_B9Eaa9aDPfgHdtA@mail.gmail.com/
>

Oh, I came up with a feasible approach for UDP protocol:
1. introduce a field ts_opt_id_bpf which works like ts_opt_id to allow
the bpf program to fully take control of the management of tskey.
2. use fentry hook udp_sendmsg(), and introduce a callback function
like BPF_SOCK_OPS_TIMEOUT_INIT in kernel to initialize the
ts_opt_id_bpf with tskey that bpf prog generates. We can directly use
BPF_SOCK_OPS_TS_SND_CB.
3. modify the SCM_TS_OPT_ID logic to support bpf extension so that the
newly added field ts_opt_id_bpf can be passed to the
skb_shinfo(skb)->tskey in __ip_append_data().

In this way, this approach can also be extended for other protocols.

Thanks,
Jason

