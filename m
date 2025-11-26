Return-Path: <bpf+bounces-75576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA18AC896D3
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 12:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7333AEC12
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 11:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E8231DD86;
	Wed, 26 Nov 2025 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJrn+lBk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9FC29BD85
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764154851; cv=none; b=Zn4VT+j17+awDFl5RK2xWv149vZ9JVJNwD5XYSqxqC3ZEP6sRje9vAeeRblWqgh8SpNW+0uAZTs/NVZt3d/V/wL9zKBzPHBSVvM1lUQ3l2WOPvo4v5WlczZCjt4FlHAKWmCfz30vjH6NiXVPrNTK6YUReU2EingR4eoHZ1VtV+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764154851; c=relaxed/simple;
	bh=msoYboerQ9GyfrtFtKxaOgrGBy5crqNw31fDrjzoNaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAGGcQdpKhqBrWPVxQkHUfPXhsoeqTVuSLuLyrbBFB6hj5YzuW4AnavdIb+2u3/k7qgMF+yb3aRuEMv6Ko20VpN021MDeduRQEFq12UjiJQHGSj/KkIceFIFgWeIiIRRPydr8pXnnp8qK5qvvQKa9X137UJRWbiuOag+F7tiA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJrn+lBk; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-43320651e53so25214975ab.3
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 03:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764154849; x=1764759649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiVfog/xOrvqP7cd7C9oJ6i+ydH+RPdRpxqOC6g1mA0=;
        b=aJrn+lBkQx2Mk6LBp83qhr0qGMAAM+kj5u0m1yAoJHE4eW23mJAJpAlYDffXG86cI5
         rHoxBTt3fug0veGYpUzl+aER7EG0vFyEbQula3G+kQ9qpyOLCM2UJJ66vDhSVFE86wcn
         C/M+/8YQZU1+qmEZPT1VXAT4NlpaVLpOFoapwMhtO8mjadrC44rYOMGrDBgQhHNtbSDZ
         /zhQ3UB9nuLTsg1jrNI6M83WTmV/TI/jQJuBOdy/ntu36/iLENEXYVpoqL1ewa2AmVfq
         ++00jlIx74SloJwNXB5yvqFOti6+B6sZ2wV3dJA1M/PpmdFqKfK9xm7OsBPBEBF+a/q/
         JIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764154849; x=1764759649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uiVfog/xOrvqP7cd7C9oJ6i+ydH+RPdRpxqOC6g1mA0=;
        b=O3cM3u6ID480GfsBwawr4pxwxkxHX6mlOcxZUzTY9vsvZUUxQ7CLmq9h/KRxka5B80
         CYDN+a9V4SWjNQ838XdXiKZ4h5zmOBlaqJrrdH7oHQ2nV/JGxXXAPv2m5ZjCZfAN3147
         qznG1bRXfva5ce7sMRs7sR9LxsIhM8IttEZYvEq/sQyPDvQYZM5gg3sSDc85tIrS/5aE
         YWmcSRJH40wHOSV7GKslMHcNSdtLsIf57UQy5kEF3imRDYQabf4KQ6ExSpnIp1OpRI0q
         gP6oyugFhNqWyufW3jZ1wCqBb9Mius5NGyGDfITsRpcWlKnift+TK+gpm5GMcHIworMF
         82iA==
X-Forwarded-Encrypted: i=1; AJvYcCWwvkCcSXowHcLO3SgN+7Y/0WO94cW8TECQ5XuRVgY/S7sAcgnJ66qfd7/Z4YB5qNSsItE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8hvdRLDHSS8QY67srijjaMrvr7bQ7dz91gXyC5mEAa+TyIQkm
	RY2Fforjph+5y0+jkPvaE9Oc+x2aG3YLyGb7BOETRWfJDEG3s+2PkdSvaam3anr04FCJjj4sHSh
	n1nThvcPoqoUJrh+qJOob2mQrOUPeV/k=
X-Gm-Gg: ASbGncupL+ijCpDzT4FAVw6ZUxJksDP+JqAnMSdn3E7z7wrpERcijXGwpVIXOVNzyDh
	vW9S+dXHKd2djsbkgRowGG3OOwXo0eQwH66ng4/mhvb6PUyqS4rv8+/6nW1XlD5Ey1dHe4qI8ri
	/jQ+zDXdDbcga2DObIzz5e/GwzTdSJ7a0U9b+zAL51710A1svBkn3CpOYM764Wg+oZxL/alXK5b
	k0g1Y+KWAl31EWC75e1d8vagPmuG1SIDthDaBLoi6/c0+l3+urvBm51vQsXc0Pm5YkBaPcbl5IR
	2Nk8aA==
X-Google-Smtp-Source: AGHT+IHp5PB4YF4CDBA7GD5vFoLYmpIgo3uW2CCz98agh7AlBdh1hmpzzolECmczJSfEExIwt2TcVwuaSB3TiVAzXsQ=
X-Received: by 2002:a05:6e02:250d:b0:433:78fa:8000 with SMTP id
 e9e14a558f8ab-435dd0e8d2fmr50409875ab.24.1764154848993; Wed, 26 Nov 2025
 03:00:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124171409.3845-1-fmancera@suse.de> <CAL+tcoBKMfVnTtkwBRk9JBGbJtahyJVt4g8swsYRUk1b97LgHQ@mail.gmail.com>
 <955e2de1-32f6-42e3-8358-b8574188ce62@suse.de> <CAL+tcoD83=UXpDaLZZFU2_EDKJS9ew2njLmoH9xeXcg5+E3UDQ@mail.gmail.com>
 <aSXZ37i5CgGKn2RF@boxer> <CAL+tcoBw9OuMcpjy7eQq2=SDWRr+OGszbC+HNgbc_CVw6S=bWQ@mail.gmail.com>
 <23b56ddb-f5a3-4b2b-bf75-e93aa39ab63f@suse.de>
In-Reply-To: <23b56ddb-f5a3-4b2b-bf75-e93aa39ab63f@suse.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 26 Nov 2025 19:00:11 +0800
X-Gm-Features: AWmQ_bmnlv1bwnmLYnfM-vDf9qbtgGp9o7tMAVnedZ4Pq6mx4O3jLlLZ1Vobq1w
Message-ID: <CAL+tcoC+MzURCCuPQ2DJ2YpmAftNfm1WOrGrCzsL1MOnkBscgw@mail.gmail.com>
Subject: Re: [PATCH net v6] xsk: avoid data corruption on cq descriptor number
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org, csmate@nop.hu, 
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	john.fastabend@gmail.com, magnus.karlsson@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 5:15=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> On 11/26/25 2:14 AM, Jason Xing wrote:
> > On Wed, Nov 26, 2025 at 12:31=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> >>
> >> On Tue, Nov 25, 2025 at 08:11:37PM +0800, Jason Xing wrote:
> >>> On Tue, Nov 25, 2025 at 7:40=E2=80=AFPM Fernando Fernandez Mancera
> >>> <fmancera@suse.de> wrote:
> >>>>
> >>>> On 11/25/25 12:41 AM, Jason Xing wrote:
> >>>>> On Tue, Nov 25, 2025 at 1:14=E2=80=AFAM Fernando Fernandez Mancera
> >>>>> <fmancera@suse.de> wrote:
> >>>>>>
> >>>>>> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> >>>>>> production"), the descriptor number is stored in skb control block=
 and
> >>>>>> xsk_cq_submit_addr_locked() relies on it to put the umem addrs ont=
o
> >>>>>> pool's completion queue.
> >>>>>>
> >>>>>> skb control block shouldn't be used for this purpose as after tran=
smit
> >>>>>> xsk doesn't have control over it and other subsystems could use it=
. This
> >>>>>> leads to the following kernel panic due to a NULL pointer derefere=
nce.
> >>>>>>
> >>>>>>    BUG: kernel NULL pointer dereference, address: 0000000000000000
> >>>>>>    #PF: supervisor read access in kernel mode
> >>>>>>    #PF: error_code(0x0000) - not-present page
> >>>>>>    PGD 0 P4D 0
> >>>>>>    Oops: Oops: 0000 [#1] SMP NOPTI
> >>>>>>    CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb1=
4-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
> >>>>>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.1=
7.0-debian-1.17.0-1 04/01/2014
> >>>>>>    RIP: 0010:xsk_destruct_skb+0xd0/0x180
> >>>>>>    [...]
> >>>>>>    Call Trace:
> >>>>>>     <IRQ>
> >>>>>>     ? napi_complete_done+0x7a/0x1a0
> >>>>>>     ip_rcv_core+0x1bb/0x340
> >>>>>>     ip_rcv+0x30/0x1f0
> >>>>>>     __netif_receive_skb_one_core+0x85/0xa0
> >>>>>>     process_backlog+0x87/0x130
> >>>>>>     __napi_poll+0x28/0x180
> >>>>>>     net_rx_action+0x339/0x420
> >>>>>>     handle_softirqs+0xdc/0x320
> >>>>>>     ? handle_edge_irq+0x90/0x1e0
> >>>>>>     do_softirq.part.0+0x3b/0x60
> >>>>>>     </IRQ>
> >>>>>>     <TASK>
> >>>>>>     __local_bh_enable_ip+0x60/0x70
> >>>>>>     __dev_direct_xmit+0x14e/0x1f0
> >>>>>>     __xsk_generic_xmit+0x482/0xb70
> >>>>>>     ? __remove_hrtimer+0x41/0xa0
> >>>>>>     ? __xsk_generic_xmit+0x51/0xb70
> >>>>>>     ? _raw_spin_unlock_irqrestore+0xe/0x40
> >>>>>>     xsk_sendmsg+0xda/0x1c0
> >>>>>>     __sys_sendto+0x1ee/0x200
> >>>>>>     __x64_sys_sendto+0x24/0x30
> >>>>>>     do_syscall_64+0x84/0x2f0
> >>>>>>     ? __pfx_pollwake+0x10/0x10
> >>>>>>     ? __rseq_handle_notify_resume+0xad/0x4c0
> >>>>>>     ? restore_fpregs_from_fpstate+0x3c/0x90
> >>>>>>     ? switch_fpu_return+0x5b/0xe0
> >>>>>>     ? do_syscall_64+0x204/0x2f0
> >>>>>>     ? do_syscall_64+0x204/0x2f0
> >>>>>>     ? do_syscall_64+0x204/0x2f0
> >>>>>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>>>>>     </TASK>
> >>>>>>    [...]
> >>>>>>    Kernel panic - not syncing: Fatal exception in interrupt
> >>>>>>    Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation r=
ange: 0xffffffff80000000-0xffffffffbfffffff)
> >>>>>>
> >>>>>> Instead use the skb destructor_arg pointer along with pointer tagg=
ing.
> >>>>>> As pointers are always aligned to 8B, use the bottom bit to indica=
te
> >>>>>> whether this a single address or an allocated struct containing se=
veral
> >>>>>> addresses.
> >>>>>>
> >>>>>> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> >>>>>> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-688=
68474bf1c@nop.hu/
> >>>>>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> >>>>>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> >>>>>
> >>>>> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> >>>>>
> >>>>> Could you also post a patch on top of net-next as it has diverged f=
rom
> >>>>> the net tree?
> >>>>>
> >>>>
> >>>> I think that is handled by maintainers when merging the branches. A
> >>>> repost would be wrong because linux-next.git and linux.git will have=
 a
> >>>> different variant of the same commit..
> >>>
> >>> But this patch cannot be applied cleanly in the net-next tree...
> >>
> >> What we care here is that it applies to net as that's a tree that this
> >> patch has been posted to.
> >
> > It sounds like I can post my approach without this patch on net-next,
> > right? I have no idea how long I should keep waiting :S
> >
> > To be clear, what I meant was to ask Fernando to post a new rebased
> > patch targetting net-next. If the patch doesn't need to land on
> > net-next, I will post it as soon as possible.
> >
>
> My patch landed on net tree and probably soon, net tree changes are
> going to be merged on net-next tree. If there are conflicts when merging
> the patch the maintainer will ask us or they will solve them.

Right, it's a normal routine. I will wait then.

Thanks,
Jason

>
> That was my understanding of how the workflow is.
>
> Thanks,
> Fernando.
>
> > Thanks,
> > Jason
> >
> >>>
> >>>>
> >>>> Please, let me know if I am wrong here.
> >>>
> >>> I'm not quite sure either.
> >>>
> >>> Thanks,
> >>> Jason
> >>>
> >>>>
> >>>> Thanks,
> >>>> Fernando.
>

