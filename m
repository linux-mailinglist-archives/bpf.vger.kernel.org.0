Return-Path: <bpf+bounces-55067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9C6A77936
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 13:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7F73A9837
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 11:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271811F1511;
	Tue,  1 Apr 2025 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXCrPygz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A688926AE4;
	Tue,  1 Apr 2025 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743505254; cv=none; b=CKxSozBMHxGXli/FyMVT8rV+85N5vs8vJ4F7fGSl0mUgPJYiYsYAYSCr2VbV29YURQV+QK5QvnbwGW8iURoRIrOIwAjVyW1HYosogH0tc8A6TfIkya8wRRPbyH1y4r1rerhkkGYV5Ggx1QEJ4hmX3hI2kzhkrrL8p35YOgkX4gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743505254; c=relaxed/simple;
	bh=bTiJ78JbeOMDcZQX/uIbIFXh2P+1V9ywUirG6sG5vR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4UOX/hpdZ7CzR/OqBx0SjkNmDKx0de1NNdoBvs+IM5yLdVJMtafQqy4tl3YxrMFNcX7wkSDf/FQj+jpahUBFTN9xWIlHLHlR72ezlPYDmowKKq9BwiXm3bumd1amuFRC6vGgRq1pEmJ7A7b0zeNWpFKDnsUxAzQkP1mcbFNQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXCrPygz; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso55870626d6.2;
        Tue, 01 Apr 2025 04:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743505250; x=1744110050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Y1SHtLZ5xBQTVg2DqgLWxnEjq7LoaCecytPGBCq3l0=;
        b=bXCrPygzeW3jAtve1WRIt1uUp42X0PQzBl1+bMH30dz2qZeUKTrgoR1k7OODtU2moN
         n3I9eyqfxgrtKW7fOjJcb3txxFMHTpiC4vjn+kH3jIW+vDxz7M+iym5QqVduKlA4/1Ue
         2H/T2JsLSmw70z0qbUFmbxw/rlyEgLxUDlwQMYAEc38yCAjdUfEi6BmUdhw97uyEXTf8
         Tn46DkCiyrr+KwijRYEe6h4mWob2HPEjBJKlDnGbWqGmKdlkGYIVP/p2x9dVTWdHxnM7
         jXC69W8gPGsWJJGTbnhfMVtQEfFJwTBVBIZLXXFBDobaP0h/qYb36Z+ok+gZHckHLor4
         Aa0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743505250; x=1744110050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Y1SHtLZ5xBQTVg2DqgLWxnEjq7LoaCecytPGBCq3l0=;
        b=ffV6lP4xOMOdpm+CyW2G4yzU0iv9ZkRUldPM1mBPuHQaicJHxwfnTg0J2Qa2Fn/m4J
         rxVEOUAKwXYN1XjAqN/M8oh4r0DmYR0UUmUd1O1giQXac6+rgwn7pvpc6YKhQSoyYQ24
         6tYVt9i0v4Y1GNxOF4NfRQRDIlZ7SQghKZyVECtZXMP+MX5dcBXiUpV9033waorSeqm/
         Ovkc3fvUZkVAbn98mnWITcAoYM/+ZiMPFUZdpUIYI57PWo8tipOKuokLxSui+up764wL
         1EBwxve1dROzRX8zcmUEHzVbdjktswBvO9488gkufu1WGO5hFvqSY8OY0DZ87PBh2KM3
         /Yhw==
X-Forwarded-Encrypted: i=1; AJvYcCVY2qvXzyXrZ7JpOgG1Yfe33f6lSqwfBhD4GS7QNFFSyPgz2j7s29nVNLxCVQfFnLuMIJQq820B@vger.kernel.org, AJvYcCWZ1sKjfs2Edpt6Ljoj6Xr4rRcAOeluTy2tebbW8SI3qNH6mtKaJUy2ABW8cBkh3mp6w8Y=@vger.kernel.org, AJvYcCX/yaFDq/VdNkhWObkWlGOxFn+X8+onuMxbyPsaerbwhIuJ5Ta5WbixQlv1OMhCTvC7ZXfsMG4I7gUmU8pn@vger.kernel.org
X-Gm-Message-State: AOJu0Yymx66NfXeV33FJwpRwDBBjklDzOFx9Wq30YXVd8nmm0epfSBU/
	hkafUBa6HhCJo0TYgGW1V/hi67J4/4DOk7bBOxRktY88a2HoYmG9FomcfAyYeT8Av7oONYtG8DM
	PW0G3GJ1DyDySuKvUkPNnnWiqZo0=
X-Gm-Gg: ASbGncuJW+g1g05JU3HilqvQB5XyeAK7to2x8BWGDmC4b8td9/WFh3FnBMFHoUuZ0Sn
	9z1DoM0S+FRlQniKuZvWI8lExR652DUa3yKj0bEQfxGaHwKa2SyneWQBHmnPGtXRs+G7PMbCjXc
	VbtDVVFASqDpDjFszwbIvAprWbqCPmtKI10ltHCfs=
X-Google-Smtp-Source: AGHT+IErYsKUVjZ/6d91309ojFYwNUdo/Z1MGFCRD5nS6Spzau8We9OZbO/XqDE8PoRtMorgFNEPvsqz4DDo1JhGcz0=
X-Received: by 2002:ad4:5c62:0:b0:6e8:96f4:733 with SMTP id
 6a1803df08f44-6eed5f8913cmr238815656d6.8.1743505250404; Tue, 01 Apr 2025
 04:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329061548.1357925-1-wangliang74@huawei.com>
 <Z-qzLyGKskaqgFh5@mini-arch> <Z-sRF0G43HpGiGwH@mini-arch> <0d1b689c-c0ef-460a-9969-ff5aebbb8fac@huawei.com>
 <CAJ8uoz1JxhXFkzW8n_Dud8SR-4zE7gim5vS_UZHELiA7d0k+wQ@mail.gmail.com>
 <ed10eea2-0bf2-4747-b519-f9b9089e434e@huawei.com> <CAJ8uoz2QXNN4so-EgR8sU8A86E_AeYx1w_b+BSVeCgzr1kaR+g@mail.gmail.com>
 <ffc84696-f9c6-4869-9f1e-7faf45d99060@huawei.com>
In-Reply-To: <ffc84696-f9c6-4869-9f1e-7faf45d99060@huawei.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 1 Apr 2025 13:00:39 +0200
X-Gm-Features: AQ5f1JofBG8n90XzSIs_Hwdmznp7MT2d6l4fbpyGTawGS0bPjc0azhU2h0HqNmA
Message-ID: <CAJ8uoz127WoEFbm1Gg7OquYJCLigg03N1XrKDcXejsUmVuQ3PA@mail.gmail.com>
Subject: Re: [PATCH net] xsk: correct tx_ring_empty_descs count statistics
To: Wang Liang <wangliang74@huawei.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Apr 2025 at 11:33, Wang Liang <wangliang74@huawei.com> wrote:
>
>
> =E5=9C=A8 2025/4/1 16:12, Magnus Karlsson =E5=86=99=E9=81=93:
> > On Tue, 1 Apr 2025 at 09:44, Wang Liang <wangliang74@huawei.com> wrote:
> >>
> >> =E5=9C=A8 2025/4/1 14:57, Magnus Karlsson =E5=86=99=E9=81=93:
> >>> On Tue, 1 Apr 2025 at 04:36, Wang Liang <wangliang74@huawei.com> wrot=
e:
> >>>> =E5=9C=A8 2025/4/1 6:03, Stanislav Fomichev =E5=86=99=E9=81=93:
> >>>>> On 03/31, Stanislav Fomichev wrote:
> >>>>>> On 03/29, Wang Liang wrote:
> >>>>>>> The tx_ring_empty_descs count may be incorrect, when set the XDP_=
TX_RING
> >>>>>>> option but do not reserve tx ring. Because xsk_poll() try to wake=
up the
> >>>>>>> driver by calling xsk_generic_xmit() for non-zero-copy mode. So t=
he
> >>>>>>> tx_ring_empty_descs count increases once the xsk_poll()is called:
> >>>>>>>
> >>>>>>>      xsk_poll
> >>>>>>>        xsk_generic_xmit
> >>>>>>>          __xsk_generic_xmit
> >>>>>>>            xskq_cons_peek_desc
> >>>>>>>              xskq_cons_read_desc
> >>>>>>>                q->queue_empty_descs++;
> >>> Sorry, but I do not understand how to reproduce this error. So you
> >>> first issue a setsockopt with the XDP_TX_RING option and then you do
> >>> not "reserve tx ring". What does that last "not reserve tx ring" mean=
?
> >>> No mmap() of that ring, or something else? I guess you have bound the
> >>> socket with a bind()? Some pseudo code on how to reproduce this would
> >>> be helpful. Just want to understand so I can help. Thank you.
> >> Sorry, the last email is garbled, and send again.
> >>
> >> Ok. Some pseudo code like below:
> >>
> >>       fd =3D socket(AF_XDP, SOCK_RAW, 0);
> >>       setsockopt(fd, SOL_XDP, XDP_UMEM_REG, &mr, sizeof(mr));
> >>
> >>       setsockopt(fd, SOL_XDP, XDP_UMEM_FILL_RING, &fill_size,
> >> sizeof(fill_size));
> >>       setsockopt(fd, SOL_XDP, XDP_UMEM_COMPLETION_RING, &comp_size,
> >> sizeof(comp_size));
> >>       mmap(NULL, off.fr.desc + fill_size * sizeof(__u64), ...,
> >> XDP_UMEM_PGOFF_FILL_RING);
> >>       mmap(NULL, off.cr.desc + comp_size * sizeof(__u64), ...,
> >> XDP_UMEM_PGOFF_COMPLETION_RING);
> >>
> >>       setsockopt(fd, SOL_XDP, XDP_RX_RING, &rx_size, sizeof(rx_size));
> >>       setsockopt(fd, SOL_XDP, XDP_TX_RING, &tx_size, sizeof(tx_size));
> >>       mmap(NULL, off.rx.desc + rx_size * sizeof(struct xdp_desc), ...,
> >> XDP_PGOFF_RX_RING);
> >>       mmap(NULL, off.tx.desc + tx_size * sizeof(struct xdp_desc), ...,
> >> XDP_PGOFF_TX_RING);
> >>
> >>       bind(fd, (struct sockaddr *)&sxdp, sizeof(sxdp));
> >>       bpf_map_update_elem(xsk_map_fd, &queue_id, &fd, 0);
> >>
> >>       while(!global_exit) {
> >>           poll(fds, 1, -1);
> >>           handle_receive_packets(...);
> >>       }
> >>
> >> The xsk is created success, and xs->tx is initialized.
> >>
> >> The "not reserve tx ring" means user app do not update tx ring produce=
r.
> >> Like:
> >>
> >>       xsk_ring_prod__reserve(tx, 1, &tx_idx);
> >>       xsk_ring_prod__tx_desc(tx, tx_idx)->addr =3D frame;
> >>       xsk_ring_prod__tx_desc(tx, tx_idx)->len =3D pkg_length;
> >>       xsk_ring_prod__submit(tx, 1);
> >>
> >> These functions (xsk_ring_prod__reserve, etc.) is provided by libxdp.
> >>
> >> The tx->producer is not updated, so the xs->tx->cached_cons and
> >> xs->tx->cached_prod are always zero.
> >>
> >> When receive packets and user app call poll(), xsk_generic_xmit() will=
 be
> >> triggered by xsk_poll(), leading to this issue.
> > Thanks, that really helped. The problem here is that the kernel cannot
> > guess your intent. Since you created a socket with both Rx and Tx, it
> > thinks you will use it for both, so it should increase
> > queue_empty_descs in this case as you did not provide any Tx descs.
> > Your proposed patch will break this. Consider this Tx case with the
> > exact same init code as you have above but with this send loop:
> >
> > while(!global_exit) {
> >         maybe_send_packets(...);
> >         poll(fds, 1, -1);
> > }
> >
> > With your patch, the queue_empty_descs will never be increased in the
> > case when I do not submit any Tx descs, even though we would like it
> > to be so.
> >
> > So in my mind, you have a couple of options:
> >
> > * Create two sockets, one rx only and one tx only and use the
> > SHARED_UMEM mode to bind them to the same netdev and queue id. In your
> > loop above, you would use the Rx socket. This might have the drawback
> > that you need to call poll() twice if you are both sending and
> > receiving in the same loop. But the stats will be the way you want
> > them to be.
> >
> > * Introduce a new variable in user space that you increase every time
> > you do poll() in your loop above. When displaying the statistics, just
> > deduct this variable from the queue_empty_descs that the kernel
> > reports using the XDP_STATISTICS getsockopt().
> >
> > Hope this helps.
>
>
> Thank you for the advices.
>
>  From user view, queue_empty_descs increases when the app only receive
> packets and call poll(), it is some confusing.

But if the only thing you are doing in the app is receive packets, you
should create an Rx only socket.

> In your Tx case, if user app use sendto() to send packets, the
> queue_empty_descs will increase. This is reasonably.
>
> In linux manual, poll() waits for some event on a file descriptor. But
> in af_xdp, poll() has a side effect of send msg.

If I remember correctly, we did this so that zero-copy mode and copy
mode should have the same behavior from an app point of view. But I do
not remember why we implemented this behavior in zero-copy in the
first place. Maybe out of necessity since zero-copy Tx is driven by
the driver.

> Previous commit 77cd0d7b3f25 ("xsk: add support for need_wakeup flag in
> AF_XDP rings") add need_wakeup flag. It mainly work in rx process. When
> the application and driver run on the same core, if the fill ring is
> empty, the driver can set the need_wakeup flag and return, so the
> application could be scheduled to produce entries of the fill ring.
>
> The commit df551058f7a3 ("xsk: Fix crash in poll when device does not
> support ndo_xsk_wakeup") add sendmsg function in xsk_poll(), considering
> some devices donot define ndo_xsk_wakeup.
>
> At present the value of need_wakeup & XDP_WAKEUP_TX is always true,
> except the mlx5 driver. If the mlx5 driver queued some packets for tx,
> it may clear XDP_WAKEUP_TX by xsk_clear_tx_need_wakeup(). So when user
> app use sendto() to send packets, __xsk_sendmsg() will return without
> calling xsk_generic_xmit().

Mellanox is doing it in the correct way. The Intel drivers had it like
this too in the beginning, until we discovered a race condition in the
HW in which the interrupt was not armed at the same time as the
need_wakeup flag was cleared. This would then lead to packets not
being sent and user-space not knowing about it. As to why all other
drivers copied this unfortunate fall-back, I do not know.

> So I have a bold suggestion, how about removing xsk_generic_xmit() in
> xsk_poll()?

That would indeed be bold :-)! But we cannot do this since it would
break existing applications that rely on this. I think you have to use
one of the workarounds I pitched in the previous mail. If you are
really just receiving, you should create an Rx only socket.

> >>>>>>> To avoid this count error, add check for tx descs before send msg=
 in poll.
> >>>>>>>
> >>>>>>> Fixes: df551058f7a3 ("xsk: Fix crash in poll when device does not=
 support ndo_xsk_wakeup")
> >>>>>>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> >>>>>> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> >>>>> Hmm, wait, I stumbled upon xskq_has_descs again and it looks only a=
t
> >>>>> cached prod/cons. How is it supposed to work when the actual tx
> >>>>> descriptor is posted? Is there anything besides xskq_cons_peek_desc=
 from
> >>>>> __xsk_generic_xmit that refreshes cached_prod?
> >>>> Yes, you are right!
> >>>>
> >>>> How about using xskq_cons_nb_entries() to check free descriptors?
> >>>>
> >>>> Like this:
> >>>>
> >>>>
> >>>> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> >>>> index e5d104ce7b82..babb7928d335 100644
> >>>> --- a/net/xdp/xsk.c
> >>>> +++ b/net/xdp/xsk.c
> >>>> @@ -993,7 +993,7 @@ static __poll_t xsk_poll(struct file *file, stru=
ct
> >>>> socket *sock,
> >>>>            if (pool->cached_need_wakeup) {
> >>>>                    if (xs->zc)
> >>>>                            xsk_wakeup(xs, pool->cached_need_wakeup);
> >>>> -               else if (xs->tx)
> >>>> +               else if (xs->tx && xskq_cons_nb_entries(xs->tx, 1))
> >>>>                            /* Poll needs to drive Tx also in copy mo=
de */
> >>>>                            xsk_generic_xmit(sk);
> >>>>            }
> >>>>
> >>>>

