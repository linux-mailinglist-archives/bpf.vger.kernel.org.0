Return-Path: <bpf+bounces-61374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EE5AE65B4
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 14:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2E416B140
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE6429B22D;
	Tue, 24 Jun 2025 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGD8liT9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D18D293C6C;
	Tue, 24 Jun 2025 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769668; cv=none; b=hwz4WLvi+Xc5Gttm/1JdKSGIfewxYWzRIyaYHK/IUOEX1hYI37UIj4P+iQdjnfpku9XtxasxeDv1XP34yMA1155XnHF7i6D4USs0AY4jOgCXAivDkuGLR/OR73gFzZLi8xfgM/UncEsASzV0rFL+ai9RNaKFI8Y5/qwtTWiCkvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769668; c=relaxed/simple;
	bh=gKBoaYk7vb2XTZq7rPJb+3NVYtZwvMVFUQmqVN2ZBMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GioQZEeaTOfmIFBDVA0vTI0nyKpBrYy5UAelillRqUug+WnltKBUcNkDJd7v+/wZnHRPO4LgC3l1jLdSL3ckKQS82uCu7x9sZXFWQJdkl/rx4wvavVhX8TxD/7pQo/Y8Vgfdl4aaWRRuD6/+6YKEejYc52eBTtMF95X5HawWyhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGD8liT9; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3df303e45d3so299795ab.0;
        Tue, 24 Jun 2025 05:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750769666; x=1751374466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1mXLVDk+FgPSfnGNgg4NgTw2hQPSDxfgCF5VVvc5Rs=;
        b=JGD8liT95CNZTUhhyKs9QGoMAaXAVRy5rSus/X0NS7zPOrrtkjowPe7FYaroMDo+No
         8UQw5OYSSnbv5HBNsSitctuQqTSUSAvpy5AOO1AJIix7nnUH2FN5UPZLXBcsX8WAVBlD
         Wk6ftS3hn1Jlwo5NiO7583gR3beYfoG+8kdIdVoEDencw1MuZRvQdxiSyxCtk6igureH
         iHIxXjqoeO0m7nIH3smcoRKxGggfsZxa9OQziW1Gt1jt7LpCzUkUe9orl1j/WB3SpqGM
         QgCnMKMlxHXxrCdBaI9D3jFJsS0mDL7ZIV1ZWbpeE/ok/FbgqM1qZh2cmmjbNPzoN0w7
         2zNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750769666; x=1751374466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1mXLVDk+FgPSfnGNgg4NgTw2hQPSDxfgCF5VVvc5Rs=;
        b=u6D9qZuwxGCWzikEzsUuFWgGg/2q9eX6FchzM7EHSFpdHCgilqmv8BXiaD/b8uObQT
         P13fFLTz3EmtEFz4z4QQQOZPi2u2+RdpZcCAiZF3TyoLf52ED1WZKS9fx/7h5t+Yfloa
         pcoO8vKEEyzPy8Wh4QZWesD9Zl3/pTOEMoZpx1oh5czMPBHOl3lePSrDGgGWd4TDJANu
         naqvejprWIQAf0daN2qjesJZJx4q7n6v1PjAUfDF+AK6On5z14S2wbJIxX2OrN+tsVqy
         1M1k6tPyXAKqIfEhsQq40dbdw9VILl23nCqIZWV32nkM7PASsCvMssMbKkMZuctO131X
         kCqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmun7siDeWlucKHp99yVu1uUcxedfrj2mMqTQeO3IaqJ5wsVLBHcigDzx8zF1QsFo3glw=@vger.kernel.org, AJvYcCW5QfCryjsZYn9rCo1jw6VxWopLACSZTGlCFyDIOqTl9Y5ROXYjYpHE1b8+GNYF4nKBJMfNumwc@vger.kernel.org
X-Gm-Message-State: AOJu0YzOsmJkSodjLGH8hU5UfWf9Xb+4Ov9grIAk2LPSVSKaaFI9Aciw
	JR8z+3T4G372jdTdTERORhJtzYxOs+SNd0NIF+O+qRPwcPkOFhYGc1y+rh8J8IS2YlS/8blKa8F
	XMGK3egJcjYbMUYhOPL/WGhU+4nLxbJXskoPB
X-Gm-Gg: ASbGncv1tlsob+QOwQSOFxwh6wHncf7l5RetU0WYEEPBUwkLgPPNfds4/W0Qv/pyyjm
	bVeKlIbLcep4tTt9ptRg82gtMG3mfYi0engm1CoSZI82RumaGDD3xbpRgjDL17iQW/1WSYyiXI7
	vfEuzH+YI316x8Ohw5HF/3ZF2PbRoN7+zojXFwl5jbQoDa1y7IKi8+pw==
X-Google-Smtp-Source: AGHT+IHQR9u852cwc20uqrVCaxx8/sHdOZTCToIPu8TmHEQ950fZbo/f6g62hgr8bpSNsV3H/46IzQIBjQ0sAh4fGo4=
X-Received: by 2002:a05:6e02:3e02:b0:3dd:f1bb:da0b with SMTP id
 e9e14a558f8ab-3de38c3173fmr175342595ab.7.1750769665949; Tue, 24 Jun 2025
 05:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623073129.23290-1-kerneljasonxing@gmail.com> <aFlmQ94TeHb9v-OC@mini-arch>
In-Reply-To: <aFlmQ94TeHb9v-OC@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 24 Jun 2025 20:53:47 +0800
X-Gm-Features: Ac12FXwGDtZ25RiELvIz-ZKUDP_831GYX8Y3XPAbgk9x8iA6OWaXEM9agkt0AgI
Message-ID: <CAL+tcoAEQgefeBWeXQmkvLTnbojDfSWbPtJKX3G_=OYNDNdfLg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: xsk: update tx queue consumer
 immediately after transmission
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 10:35=E2=80=AFPM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 06/23, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > For afxdp, the return value of sendto() syscall doesn't reflect how man=
y
> > descs handled in the kernel. One of use cases is that when user-space
> > application tries to know the number of transmitted skbs and then decid=
es
> > if it continues to send, say, is it stopped due to max tx budget?
> >
> > The following formular can be used after sending to learn how many
> > skbs/descs the kernel takes care of:
> >
> >   tx_queue.consumers_before - tx_queue.consumers_after
> >
> > Prior to the current patch, in non-zc mode, the consumer of tx queue is
> > not immediately updated at the end of each sendto syscall when error
> > occurs, which leads to the consumer value out-of-dated from the perspec=
tive
> > of user space. So this patch requires store operation to pass the cache=
d
> > value to the shared value to handle the problem.
> >
> > More than those explicit errors appearing in the while() loop in
> > __xsk_generic_xmit(), there are a few possible error cases that might
> > be neglected in the following call trace:
> > __xsk_generic_xmit()
> >     xskq_cons_peek_desc()
> >         xskq_cons_read_desc()
> >           xskq_cons_is_valid_desc()
> > It will also cause the premature exit in the while() loop even if not
> > all the descs are consumed.
> >
> > Based on the above analysis, using 'cached_prod !=3D cached_cons' could
> > cover all the possible cases because it represents there are remaining
> > descs that are not handled and cached_cons are not updated to the globa=
l
> > state of consumer at this time.
>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > V2
> > Link: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxin=
g@gmail.com/
> > 1. filter out those good cases because only those that return error nee=
d
> > updates.
> > Side note:
> > 1. in non-batched zero copy mode, at the end of every caller of
> > xsk_tx_peek_desc(), there is always a xsk_tx_release() function that us=
ed
> > to update the local consumer to the global state of consumer. So for th=
e
> > zero copy mode, no need to change at all.
> > 2. Actually I have no strong preference between v1 (see the above link)
> > and v2 because smp_store_release() shouldn't cause side effect.
> > Considering the exactitude of writing code, v2 is a more preferable
> > one.
> > ---
> >  net/xdp/xsk.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 5542675dffa9..b9223a2a6ada 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -856,6 +856,9 @@ static int __xsk_generic_xmit(struct sock *sk)
> >       }
> >
> >  out:
> > +     if (xs->tx->cached_prod !=3D xs->tx->cached_cons)
>
> Can we use xskq_has_descs() here instead?

Sure, thanks.

>
> And still would be nice to verify this with a test. Should not be much wo=
rk,
> most of the things (setup/etc) are already there, so you won't have
> to write everything from scratch...

Ah, finally I managed to make it work but a bit ugly... Let me try if
I can find a
better way to write the test patch.

Thanks,
Jason

