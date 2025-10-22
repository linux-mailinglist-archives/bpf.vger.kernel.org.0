Return-Path: <bpf+bounces-71665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB262BF9CBA
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 05:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC29189A0AF
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 03:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761D722F74A;
	Wed, 22 Oct 2025 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecU5J8UT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F372288F7
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 03:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761102701; cv=none; b=i8pLemLgO8Zzrv1auV1g2qf0Nc+iBrsjd0t0XCOqBO3atmAXMgNGoveJsy2hgNpSq2/a8uTP3HENV4I1Ra0PcNmgl8KSx80J64ljGDNnEPlwgh6nN2eaKKrJ55X6JFLSXe+v00HzLkzEy137jAmnGfesp6TEyeNv6RPgMTy/f74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761102701; c=relaxed/simple;
	bh=vo4X/k8QJ+NxqbcWxXdeO1gco1FXAXIvNeqYsVUxN+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQ0dJ9/V+qQk8E0Px0d+WdmhSZbLEPm8Nh32FMjzMnZ6FduLQJUTNdcy5JIi3oFGRx4KBg0Oth+RWu1OH4hB+1wFadyx4R9jeT6YSGewGM2ZMHOWMnj9fowOtJczSvglRNR3dXzjzm5si2y3cLDY4M4Lk+pW0ygyZZ5jpW10YuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecU5J8UT; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-93e89a59d68so160548239f.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 20:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761102698; x=1761707498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1w81N5UwqCcLk9lzNRuUpjETqoES8d1bFB+ZdpugPTA=;
        b=ecU5J8UT2Bwg8ULPydtna8dAQMF62PFne2fmf1Y9Ag8gK6uy29cNT/9sEC0fepMoUR
         zxGvA9KDaX+D52B/boKTWnBLfg5u2nbMp3jj2VSm5DmxVfgxsjNTvul8Bq6n+oi4IHUG
         o51N065I48yH3pYK1LeJafJCxj2cRlUhJwnxSwdnXFp0iwqvzKrzwJXqFtZiR8q6v90w
         1/PcZ5EBGpqvawUyH3eTTS+i+QH5kDq0f3SJJtZCWP1dIKRRjNbDbnD+ArQZFEDjyl4h
         QaEbDbvMFBBcNxAEuqjKjeDq20z1s5v9bpJvAiT/e1nDxqDYrrdUW7DPUZVuu5bPnAqd
         TPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761102698; x=1761707498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1w81N5UwqCcLk9lzNRuUpjETqoES8d1bFB+ZdpugPTA=;
        b=Z03wFJTFt0c5cSK6y5VDYOyWa6dLO0fNk0/1i/dBAEPdm1ZdCHErfDQkhYHl6RkBu/
         b6UllLNoiw8HSXDhwMXFuHxtgO2HsZcvrN7mKYmbmRG14CNR2j7PkQXfugdPpR8YZtQ2
         wL8qpJJucGhuB8iPyjDo4HuhFUzBbFtFn0gjqPRjtUK1Dr/e79CUoWQG/19OwDeTWC/w
         DAz2tDcscDVK+hZB7pYO7Po4Yf0L2KFZztXk3/ZTMg05y+G2uoh0SAXd156Q7z/kLXtp
         0MXmqlub0ckxZFpdIHkmL8AvQatgDxrUeNs/Fuq06BfcL60ML352aKaScJ/nVWgWslYv
         eGpA==
X-Forwarded-Encrypted: i=1; AJvYcCVaGZyUuMIkjYxV+pRtf5VxXKQ2mqgMhJWqvzKcPM2pyTnS5tGiILlzM0qZnDKAzm7FAxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9gxSx7X/GI9PYxOvbWgQ9EwrO6ZuUTzgvfVagNNSydPQAU0zk
	fN3uZvB7x8DzhStDV316umhx60ClnFOdggh6G8dzsNGo+uOBZLfAOOSnfvzoDuvA9pQmz0ICj5x
	fttbVw8fFjDfG8zXWoZ3H83YsxG3LRV4=
X-Gm-Gg: ASbGncv1O5mLYjREs2P3VO+HAvqkG15m3AuBl+mQ3Rjj4yC2fDXB32wZWb8s7o2YfSz
	L6483LvpT8IeyRyC+9r5xSP0YD9RgWzvu7lAAyiYTbidTeuqlK+5pRNHWVpbK/S9jDZ/UOQwOXn
	1f1HbewMpikh9gBodZ+THIUTxAiJJXJqEL90YSdNAuwdTr88b2kR0Xm49D4fH37KmjqkO//UjdV
	XIYj4CXgsgjC/+vwY0EuZz1wS8Bt6Yc2RSfcJJgFc4QPj31JheuGgzsVJsAhaauF8tJDUI=
X-Google-Smtp-Source: AGHT+IHsc5L8H41oQ6pWuGlwc/6nz3oXWi8+Bcroke4DapuC5C0EkQMaKnI90LLtcbQ2XDw0xbZs5GobUsx8JgiIzoU=
X-Received: by 2002:a05:6e02:1689:b0:42d:876e:61bd with SMTP id
 e9e14a558f8ab-430c527fb41mr284123945ab.28.1761102697970; Tue, 21 Oct 2025
 20:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021173200.7908-1-alessandro.d@gmail.com> <20251021173200.7908-2-alessandro.d@gmail.com>
In-Reply-To: <20251021173200.7908-2-alessandro.d@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 22 Oct 2025 11:11:01 +0800
X-Gm-Features: AS18NWBBSoMIxcuhS-7Wwy3NqCqJITQFYqxcB1a6KZpfmjK1-38rwvJFwSyOIzY
Message-ID: <CAL+tcoCwGQyNSv9BZ_jfsia6YFoyT790iknqxG7bB7wVi3C_vQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] i40e: xsk: advance next_to_clean on status descriptors
To: Alessandro Decina <alessandro.d@gmail.com>
Cc: netdev@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Tirthendu Sarkar <tirthendu.sarkar@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 1:33=E2=80=AFAM Alessandro Decina
<alessandro.d@gmail.com> wrote:
>
> Whenever a status descriptor is received, i40e processes and skips over
> it, correctly updating next_to_process but forgetting to update
> next_to_clean. In the next iteration this accidentally causes the
> creation of an invalid multi-buffer xdp_buff where the first fragment
> is the status descriptor.
>
> If then a skb is constructed from such an invalid buffer - because the
> eBPF program returns XDP_PASS - a panic occurs:
>
> [ 5866.367317] BUG: unable to handle page fault for address: ffd31c37eab1=
c980
> [ 5866.375050] #PF: supervisor read access in kernel mode
> [ 5866.380825] #PF: error_code(0x0000) - not-present page
> [ 5866.386602] PGD 0
> [ 5866.388867] Oops: Oops: 0000 [#1] SMP NOPTI
> [ 5866.393575] CPU: 34 UID: 0 PID: 0 Comm: swapper/34 Not tainted 6.17.0-=
custom #1 PREEMPT(voluntary)
> [ 5866.403740] Hardware name: Supermicro AS -2115GT-HNTR/H13SST-G, BIOS 3=
.2 03/20/2025
> [ 5866.412339] RIP: 0010:memcpy+0x8/0x10
> [ 5866.416454] Code: cc cc 90 cc cc cc cc cc cc cc cc cc cc cc cc cc cc c=
c 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 48 89 f8 48 89 d1 <=
f3> a4 e9 fc 26 c0 fe 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> [ 5866.437538] RSP: 0018:ff428d9ec0bb0ca8 EFLAGS: 00010286
> [ 5866.443415] RAX: ff2dd26dbd8f0000 RBX: ff2dd265ad161400 RCX: 000000000=
00004e1
> [ 5866.451435] RDX: 00000000000004e1 RSI: ffd31c37eab1c980 RDI: ff2dd26db=
d8f0000
> [ 5866.459454] RBP: ff428d9ec0bb0d40 R08: 0000000000000000 R09: 000000000=
0000000
> [ 5866.467470] R10: 0000000000000000 R11: 0000000000000000 R12: ff428d9ee=
c726ef8
> [ 5866.475490] R13: ff2dd26dbd8f0000 R14: ff2dd265ca2f9fc0 R15: ff2dd2654=
8548b80
> [ 5866.483509] FS:  0000000000000000(0000) GS:ff2dd2c363592000(0000) knlG=
S:0000000000000000
> [ 5866.492600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5866.499060] CR2: ffd31c37eab1c980 CR3: 0000000178d7b040 CR4: 000000000=
0f71ef0
> [ 5866.507079] PKRU: 55555554
> [ 5866.510125] Call Trace:
> [ 5866.512867]  <IRQ>
> [ 5866.515132]  ? i40e_clean_rx_irq_zc+0xc50/0xe60 [i40e]
> [ 5866.520921]  i40e_napi_poll+0x2d8/0x1890 [i40e]
> [ 5866.526022]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.531408]  ? raise_softirq+0x24/0x70
> [ 5866.535623]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.541011]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.546397]  ? rcu_sched_clock_irq+0x225/0x1800
> [ 5866.551493]  __napi_poll+0x30/0x230
> [ 5866.555423]  net_rx_action+0x20b/0x3f0
> [ 5866.559643]  handle_softirqs+0xe4/0x340
> [ 5866.563962]  __irq_exit_rcu+0x10e/0x130
> [ 5866.568283]  irq_exit_rcu+0xe/0x20
> [ 5866.572110]  common_interrupt+0xb6/0xe0
> [ 5866.576425]  </IRQ>
> [ 5866.578791]  <TASK>
>
> Advance next_to_clean to ensure invalid xdp_buff(s) aren't created.
>
> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Signed-off-by: Alessandro Decina <alessandro.d@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/eth=
ernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..dbc19083bbb7 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -441,13 +441,18 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring,=
 int budget)
>                 dma_rmb();
>
>                 if (i40e_rx_is_programming_status(qword)) {
> +                       u16 ntp;
> +
>                         i40e_clean_programming_status(rx_ring,
>                                                       rx_desc->raw.qword[=
0],
>                                                       qword);
>                         bi =3D *i40e_rx_bi(rx_ring, next_to_process);
>                         xsk_buff_free(bi);
> -                       if (++next_to_process =3D=3D count)
> +                       ntp =3D next_to_process++;
> +                       if (next_to_process =3D=3D count)
>                                 next_to_process =3D 0;
> +                       if (next_to_clean =3D=3D ntp)
> +                               next_to_clean =3D next_to_process;
>                         continue;
>                 }
>
> --
> 2.43.0
>
>

I'm copying your reply from v1 as shown below so that we can continue
with the discussion :)

> It really depends on whether a status descriptor can be received in the
> middle of multi-buffer packet. Based on the existing code, I assumed it
> can. Therefore, consider this case:
>
> [valid_1st_packet][status_descriptor][valid_2nd_packet]
>
> In this case you want to skip status_descriptor but keep the existing
> logic that leads to:
>
>     first =3D next_to_clean =3D valid_1st_packet
>
> so then you can go and add valid_2nd_packet as a fragment to the first.

Sorry, honestly, I still don't follow you.

Looking at the case you provided, I think @first always pointing to
valid_1st_packet is valid which does not bring any trouble. You mean
the case is what you're trying to handle?

You patch updates next_to_clean that is only used at the very
beginning, so it will not affect @first. Imaging the following case:

     [status_descriptor][valid_1st_packet][valid_2nd_packet]

Even if the next_to_clean is updated, the @first still points to
[status_descriptor] that is invalid and that will later cause the
panic when constructing the skb.

I'm afraid that we're not on the same page. Let me confirm that it is
@first that points to the status descriptor that causes the panic,
right? Could you share with us the exact case just like you did as
above. Thank you.

Thanks,
Jason

