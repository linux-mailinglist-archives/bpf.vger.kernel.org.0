Return-Path: <bpf+bounces-55047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F36A775FD
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 10:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5443716672B
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 08:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E931E991D;
	Tue,  1 Apr 2025 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYBPKsZS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C880132103;
	Tue,  1 Apr 2025 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743495148; cv=none; b=j9kEcltvf9ZQrWUZHlpdN3r9Y/elnx3T1FVljNmhfRczK2whhpxXISM6MzsynR1kKYxwIpxUwKjOFYWUDJt10Oo4jNHBfJrevCViZ/PUs1Jxs7gtelVJEbOCQt7S+DqNmt+OhKcfXIKACg8F1zUMS8GlTgE6wqLz/2f/8xdVKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743495148; c=relaxed/simple;
	bh=/waPTM4xPD4317aDJ0hxEkq/rYW4h1hSGRbxP3lbXHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtvaoKea39H7y59wYvOBtDcl35Mk1KqDRx0a5dfTAHN4Xf3tMgWmfwAHZeBhnnc4Ol1KPm5b3npeCBQyEP9Tad6UoS/IGE5HYWDDjclm57K2r1peDhV8GEBKbeycYf4mqsBjCOt0oWvSWFuU38Uj5W/kHm5akWgh94w41fGigy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYBPKsZS; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5b2472969so533858985a.1;
        Tue, 01 Apr 2025 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743495145; x=1744099945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N921zeEVObbyyzXGZX+/L4SVyesPmMbWZMrfrZMAMZI=;
        b=gYBPKsZSZuncc84FAmAB2dTrZW1TMTPrBSnol3BqvCM/JZuuRikBU6koP40hXj2P+F
         Z6r5dIVfwDjT6W2z98EtOVQwoX8W9j61NWtxRQtRdkKiEO4MD6n6KMUUttexDP0W9WKH
         ty0o3Wcl9E179vHC/FUiRfeHlw93crfZlEbS5g6/3AOwPTf7Zv1065Gd1CPwaWjfdSuO
         SbWl1a+WnG++DoqKAaycIbWix4izPMLXXlOyFQr43vPgDk6A+QxkiKplUD2cjwxDVE2p
         KN8aNK8h7qRienEIFWsdCcXG73feEc8JMC2qUrebTHEVWqd3N9AbCCEpxi6u+V7H4AzD
         zAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743495145; x=1744099945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N921zeEVObbyyzXGZX+/L4SVyesPmMbWZMrfrZMAMZI=;
        b=OHHPNV08ZuS+5ogeL3xwdcebtwhs1MjIkv0vKL9VOxEyrzUFdqbJTrQQ7dxHbHAang
         feeXEIocvZg2IpbdBgEYy2P6Zl4RP+zqoLp8hmhEfpqBPz3DoAuBTs1Nj7KieLTQvA93
         CTIfk2i2NC4kNSDuzOC2b3E7h1WyntLzo9PbxoK9Iit8LaSy33d+o/O/6LGJfWl0823E
         sdXXwfK/JYHxX7m44B79Eatx+Gcv0LvxjQk/9mkA7JHr+HkM3p5iHtmpTtYx7g7OiKMs
         52gK93oyt54DRCa1W3Dug0ocJ60p0cWjujmFR8a9F21Y2Hg6nFHjWsHtwVmKAhFUppOP
         NkdA==
X-Forwarded-Encrypted: i=1; AJvYcCU5wrIe3Qp9ror/PWd0XpDeV00tTmM+pXoMx7l/BFyNM+lxFs8EEAnI3uYfFmxuxuDgb/PenrEn@vger.kernel.org, AJvYcCWO2+Hk3UWVuXyEZo3SEkcVkGFqDo6iOjDJ4ERDrb5gIPD3b55ZldurDuOPetyHddWO/AY=@vger.kernel.org, AJvYcCWSLZKUnQE4Vq71PK5RL9F7stPASD8e7BlgcPeLrP5LYU+3SjT1/YKFJcu0HNmvZr8uYQXi+XJZZ26wxKkT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+j8C3juxLDc8uit6/SYtsBZDA479akCpUwHscLhmJQHatVMYd
	+BUk73JhO06yss2ahL9thFohQrcR1s/MYs+5h4+81GWkf9neQlK1eKn1lil+ghL/2qqnF7rrUkV
	YS9yw2JP6cY2ClHKfoNKiOZcQKUo=
X-Gm-Gg: ASbGnctlRnNrSjvI7mwQC7OJNwftfqxfBDUI4ay8aWkVO5e6Xzwk8qIUBUSREer6voo
	PM6VUP5vkM9LvSBHxSr1JH89EY4i96RmjQKzxL9n6bbmQhZFE9Ew/C/UcLMpVm97L0xMLFe2QGS
	wxEEWnZkUNAL52xkT9aKvhmmYh1Dypcu1Kf+BWZUo=
X-Google-Smtp-Source: AGHT+IHHhqW7g5N8MXmKeQ3ZdpNS4nfu3IJeiO8IjKHPXDxhW5RCauWGQn75EU0rmHifckbfG9wIri5Wmu8NJ1eEBmc=
X-Received: by 2002:a05:620a:17a0:b0:7c5:3e22:6167 with SMTP id
 af79cd13be357-7c69073366amr1734893785a.23.1743495145058; Tue, 01 Apr 2025
 01:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329061548.1357925-1-wangliang74@huawei.com>
 <Z-qzLyGKskaqgFh5@mini-arch> <Z-sRF0G43HpGiGwH@mini-arch> <0d1b689c-c0ef-460a-9969-ff5aebbb8fac@huawei.com>
 <CAJ8uoz1JxhXFkzW8n_Dud8SR-4zE7gim5vS_UZHELiA7d0k+wQ@mail.gmail.com> <ed10eea2-0bf2-4747-b519-f9b9089e434e@huawei.com>
In-Reply-To: <ed10eea2-0bf2-4747-b519-f9b9089e434e@huawei.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 1 Apr 2025 10:12:14 +0200
X-Gm-Features: AQ5f1JpJTLxGpoXFk_gCek9AD6xD42I4RGHs3jBV7-49f2FG1SOBDoEkHyywjuI
Message-ID: <CAJ8uoz2QXNN4so-EgR8sU8A86E_AeYx1w_b+BSVeCgzr1kaR+g@mail.gmail.com>
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

On Tue, 1 Apr 2025 at 09:44, Wang Liang <wangliang74@huawei.com> wrote:
>
>
> =E5=9C=A8 2025/4/1 14:57, Magnus Karlsson =E5=86=99=E9=81=93:
> > On Tue, 1 Apr 2025 at 04:36, Wang Liang <wangliang74@huawei.com> wrote:
> >>
> >> =E5=9C=A8 2025/4/1 6:03, Stanislav Fomichev =E5=86=99=E9=81=93:
> >>> On 03/31, Stanislav Fomichev wrote:
> >>>> On 03/29, Wang Liang wrote:
> >>>>> The tx_ring_empty_descs count may be incorrect, when set the XDP_TX=
_RING
> >>>>> option but do not reserve tx ring. Because xsk_poll() try to wakeup=
 the
> >>>>> driver by calling xsk_generic_xmit() for non-zero-copy mode. So the
> >>>>> tx_ring_empty_descs count increases once the xsk_poll()is called:
> >>>>>
> >>>>>     xsk_poll
> >>>>>       xsk_generic_xmit
> >>>>>         __xsk_generic_xmit
> >>>>>           xskq_cons_peek_desc
> >>>>>             xskq_cons_read_desc
> >>>>>               q->queue_empty_descs++;
> > Sorry, but I do not understand how to reproduce this error. So you
> > first issue a setsockopt with the XDP_TX_RING option and then you do
> > not "reserve tx ring". What does that last "not reserve tx ring" mean?
> > No mmap() of that ring, or something else? I guess you have bound the
> > socket with a bind()? Some pseudo code on how to reproduce this would
> > be helpful. Just want to understand so I can help. Thank you.
> Sorry, the last email is garbled, and send again.
>
> Ok. Some pseudo code like below:
>
>      fd =3D socket(AF_XDP, SOCK_RAW, 0);
>      setsockopt(fd, SOL_XDP, XDP_UMEM_REG, &mr, sizeof(mr));
>
>      setsockopt(fd, SOL_XDP, XDP_UMEM_FILL_RING, &fill_size,
> sizeof(fill_size));
>      setsockopt(fd, SOL_XDP, XDP_UMEM_COMPLETION_RING, &comp_size,
> sizeof(comp_size));
>      mmap(NULL, off.fr.desc + fill_size * sizeof(__u64), ...,
> XDP_UMEM_PGOFF_FILL_RING);
>      mmap(NULL, off.cr.desc + comp_size * sizeof(__u64), ...,
> XDP_UMEM_PGOFF_COMPLETION_RING);
>
>      setsockopt(fd, SOL_XDP, XDP_RX_RING, &rx_size, sizeof(rx_size));
>      setsockopt(fd, SOL_XDP, XDP_TX_RING, &tx_size, sizeof(tx_size));
>      mmap(NULL, off.rx.desc + rx_size * sizeof(struct xdp_desc), ...,
> XDP_PGOFF_RX_RING);
>      mmap(NULL, off.tx.desc + tx_size * sizeof(struct xdp_desc), ...,
> XDP_PGOFF_TX_RING);
>
>      bind(fd, (struct sockaddr *)&sxdp, sizeof(sxdp));
>      bpf_map_update_elem(xsk_map_fd, &queue_id, &fd, 0);
>
>      while(!global_exit) {
>          poll(fds, 1, -1);
>          handle_receive_packets(...);
>      }
>
> The xsk is created success, and xs->tx is initialized.
>
> The "not reserve tx ring" means user app do not update tx ring producer.
> Like:
>
>      xsk_ring_prod__reserve(tx, 1, &tx_idx);
>      xsk_ring_prod__tx_desc(tx, tx_idx)->addr =3D frame;
>      xsk_ring_prod__tx_desc(tx, tx_idx)->len =3D pkg_length;
>      xsk_ring_prod__submit(tx, 1);
>
> These functions (xsk_ring_prod__reserve, etc.) is provided by libxdp.
>
> The tx->producer is not updated, so the xs->tx->cached_cons and
> xs->tx->cached_prod are always zero.
>
> When receive packets and user app call poll(), xsk_generic_xmit() will be
> triggered by xsk_poll(), leading to this issue.

Thanks, that really helped. The problem here is that the kernel cannot
guess your intent. Since you created a socket with both Rx and Tx, it
thinks you will use it for both, so it should increase
queue_empty_descs in this case as you did not provide any Tx descs.
Your proposed patch will break this. Consider this Tx case with the
exact same init code as you have above but with this send loop:

while(!global_exit) {
       maybe_send_packets(...);
       poll(fds, 1, -1);
}

With your patch, the queue_empty_descs will never be increased in the
case when I do not submit any Tx descs, even though we would like it
to be so.

So in my mind, you have a couple of options:

* Create two sockets, one rx only and one tx only and use the
SHARED_UMEM mode to bind them to the same netdev and queue id. In your
loop above, you would use the Rx socket. This might have the drawback
that you need to call poll() twice if you are both sending and
receiving in the same loop. But the stats will be the way you want
them to be.

* Introduce a new variable in user space that you increase every time
you do poll() in your loop above. When displaying the statistics, just
deduct this variable from the queue_empty_descs that the kernel
reports using the XDP_STATISTICS getsockopt().

Hope this helps.

> >>>>> To avoid this count error, add check for tx descs before send msg i=
n poll.
> >>>>>
> >>>>> Fixes: df551058f7a3 ("xsk: Fix crash in poll when device does not s=
upport ndo_xsk_wakeup")
> >>>>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> >>>> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> >>> Hmm, wait, I stumbled upon xskq_has_descs again and it looks only at
> >>> cached prod/cons. How is it supposed to work when the actual tx
> >>> descriptor is posted? Is there anything besides xskq_cons_peek_desc f=
rom
> >>> __xsk_generic_xmit that refreshes cached_prod?
> >>
> >> Yes, you are right!
> >>
> >> How about using xskq_cons_nb_entries() to check free descriptors?
> >>
> >> Like this:
> >>
> >>
> >> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> >> index e5d104ce7b82..babb7928d335 100644
> >> --- a/net/xdp/xsk.c
> >> +++ b/net/xdp/xsk.c
> >> @@ -993,7 +993,7 @@ static __poll_t xsk_poll(struct file *file, struct
> >> socket *sock,
> >>           if (pool->cached_need_wakeup) {
> >>                   if (xs->zc)
> >>                           xsk_wakeup(xs, pool->cached_need_wakeup);
> >> -               else if (xs->tx)
> >> +               else if (xs->tx && xskq_cons_nb_entries(xs->tx, 1))
> >>                           /* Poll needs to drive Tx also in copy mode =
*/
> >>                           xsk_generic_xmit(sk);
> >>           }
> >>
> >>

