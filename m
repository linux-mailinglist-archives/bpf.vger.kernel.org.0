Return-Path: <bpf+bounces-68027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C68B51CBB
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 18:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021651C851A8
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 16:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05691327A07;
	Wed, 10 Sep 2025 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgUmFl8F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1541A840A
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520001; cv=none; b=KT2rhXrr8Qn29sDzjKr43RXIxCw+FBW1Dp+YcBuWfCqRaLZSD2lDncWrEI+aLOifCGRJrG0tkWYE872jLZmctZgOofxAyMTM+UaQkr82hkwQhuXbBtmqAKt/npuTdygEEyeOFI98G+xt+/uUdRcWsVhKrY1DnxojiBwV+VJOwwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520001; c=relaxed/simple;
	bh=3DNsJ0kUCOxp3DJEANhhxdD39H7uqItAYoS9GzBOQrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBgZTdzqhsL36FUtBaqpcmJLAlqC5D+ef53tvpYKJkcpmu+JeQOsIaymbmHuqX8OyilgQsxT821rV7/SOv6/qPTDB0spRPaRr+AwX+0XRnHCJurokfgQl69vgEoXwTSsHxKmBjzj3ZxKlk6DsA5u2hHz/arMhVWvUV9tF1POCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cgUmFl8F; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-25669596955so36910765ad.0
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757519999; x=1758124799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQsYbUCPH+TWyI0Bl3IG/T9WYND8kzghnp2qrB7wPv8=;
        b=cgUmFl8F1IvWsyO+YI/FhLDJunA/UMbjq6jIbncg5izRDh0Mi68ayPaS1QH+j92oDY
         +nntq3Ba5EyoPnx3ebmAuT/7YGxlXlCgqjeyKuhN38YeZeBAzwk9Z5ZZkaf4iVgQOkSf
         XYlbtAQ7sLpZbSxhLePkMDMvf5FxU6q1Bs+fAly4o99PJY7iIdFaUnM/FUwh6xSpvWnL
         IBH6rjLmsnQo/UTyimjtu0Ies8nQKoYEySqk8puJU5nFYeEErb9vYyl1nEZvkJJAnElP
         cgHOVXWxp8BVlOMmmPvIonX07Oyylli4mXyn7jPkpyD8ttTAWe1oz53XQjmCCydgom5a
         3XeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757519999; x=1758124799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQsYbUCPH+TWyI0Bl3IG/T9WYND8kzghnp2qrB7wPv8=;
        b=UiRiJErT/8wPf4Vo8FNKMCsQRnMgmxXAoZnRjqHUfrhDt4PAmwMfK73Piwbu1lE4OL
         0I0IYopp3TwPZNb9n4AehD0HVNcdN1b+T2lBcBgzAJ8wYIF6mu41D839ajF8FA7mdcfr
         9pndfVztG2OziGGDVd81e6KuLN1NCTMb0ccH3QglJdcvQaNi12MpIeX7xq3mfzf7pED4
         dsMPHPgXCk1BgdJjt/1h2HCyTGOD6x/oIBBrLLKO66STwRXU/lyANaEwh6b3IKJGA5Q4
         a3af+0omucuXYLFQZU9AcgQC8Sf8WcH8sUZa4FQgJ8hjzI/BKW4ISf6cdI2vNcIy4FHT
         7yWA==
X-Forwarded-Encrypted: i=1; AJvYcCXyT5oLbtpUK1l10ViLsB45WIw55ZpN5oXHr5l/IkbnU0ij2mKGBYDHBNsg/nrrxjzOP5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjdtdH3i1qfHBlGcg33Tkxba2dz6yfJbZDumiWxi/hW662R6du
	H9vPNv//JYpEdTGqZXFALuz08I5RCGnoRng8YSiz3XfQXiYR+L9wg1hm+7Zc24NzphRBswNlbx3
	4ohTynKX8RHf3b8/WDLCa+ksm1kl/ltFvRjmYzvGY
X-Gm-Gg: ASbGnctXpwjRHr7o8IFrXJW5a1rzL24RUYjn/5L+n6NB1ScSo40vIZagd2BWdUzSPfs
	W8xCdIyqQLdgDbqTBY01us8K3PJJzYKu6waxDUdYrGxeO/u1uK966KcXYviFuNUvB9qDu3qacWH
	u9fO0Cr/p9EinSG8OqOxNyVDnjHz1SgxoIU0feYWykE4bXwUyozdIif2e3d28nG3RgoPZ4kpK/D
	SMDykywM2YSYSn6vnyJmNWfTK1xnMYyEfb/lFOQDyC+68TrU8IRydTBhw==
X-Google-Smtp-Source: AGHT+IHxWzDGOBmD4lYcKcTBEMz+Y/U4NW70DiT1xvfpe6LQ9dZF3t9varpKfzrKh+SHkrYjfEC1zJ/ekPCXvf4TnOs=
X-Received: by 2002:a17:903:46cb:b0:24d:f9f:de8f with SMTP id
 d9443c01a7336-2516fbdcc8amr243402455ad.17.1757519999058; Wed, 10 Sep 2025
 08:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909232623.4151337-1-kuniyu@google.com> <a29689e0-cabc-4fdb-a030-443f0ccfb468@linux.dev>
 <CAAVpQUDeaiGUdxGQHSMRU3=zwJy7a0hMWXjoRkfdYPqaZLU09Q@mail.gmail.com> <effcf89d-925a-4bf6-9c6c-39a9b6731409@linux.dev>
In-Reply-To: <effcf89d-925a-4bf6-9c6c-39a9b6731409@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 10 Sep 2025 08:59:46 -0700
X-Gm-Features: Ac12FXzir08fghnZsZResbK59XEExlsCjOH6FkCZViQ7TUm_ZgO_CqtCgK8V34I
Message-ID: <CAAVpQUDPDr83HOQQTDR4DuGeeAFyQ-G_6E=TwyZNN5MnaBHSqQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] tcp_bpf: Call sk_msg_free() when
 tcp_bpf_send_verdict() fails to allocate psock->cork.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+4cabd1d2fa917a456db8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 7:05=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/9/25 11:56 PM, Kuniyuki Iwashima wrote:
> > On Tue, Sep 9, 2025 at 10:15=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 9/9/25 4:26 PM, Kuniyuki Iwashima wrote:
> >>> syzbot reported the splat below. [0]
> >>>
> >>> The repro does the following:
> >>>
> >>>     1. Load a sk_msg prog that calls bpf_msg_cork_bytes(msg, cork_byt=
es)
> >>>     2. Attach the prog to a SOCKMAP
> >>>     3. Add a socket to the SOCKMAP
> >>>     4. Activate fault injection
> >>>     5. Send data less than cork_bytes
> >>>
> >>> At 5., the data is carried over to the next sendmsg() as it is
> >>> smaller than the cork_bytes specified by bpf_msg_cork_bytes().
> >>>
> >>> Then, tcp_bpf_send_verdict() tries to allocate psock->cork to hold
> >>> the data, but this fails silently due to fault injection + __GFP_NOWA=
RN.
> >>>
> >>> If the allocation fails, we need to revert the sk->sk_forward_alloc
> >>> change done by sk_msg_alloc().
> >>>
> >>> Let's call sk_msg_free() when tcp_bpf_send_verdict fails to allocate
> >>> psock->cork.
> >>>
> >>> [0]:
> >>> WARNING: net/ipv4/af_inet.c:156 at inet_sock_destruct+0x623/0x730 net=
/ipv4/af_inet.c:156, CPU#1: syz-executor/5983
> >>> Modules linked in:
> >>> CPU: 1 UID: 0 PID: 5983 Comm: syz-executor Not tainted syzkaller #0 P=
REEMPT(full)
> >>> Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 07/12/2025
> >>> RIP: 0010:inet_sock_destruct+0x623/0x730 net/ipv4/af_inet.c:156
> >>> Code: 0f 0b 90 e9 62 fe ff ff e8 7a db b5 f7 90 0f 0b 90 e9 95 fe ff =
ff e8 6c db b5 f7 90 0f 0b 90 e9 bb fe ff ff e8 5e db b5 f7 90 <0f> 0b 90 e=
9 e1 fe ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 9f fc
> >>> RSP: 0018:ffffc90000a08b48 EFLAGS: 00010246
> >>> RAX: ffffffff8a09d0b2 RBX: dffffc0000000000 RCX: ffff888024a23c80
> >>> RDX: 0000000000000100 RSI: 0000000000000fff RDI: 0000000000000000
> >>> RBP: 0000000000000fff R08: ffff88807e07c627 R09: 1ffff1100fc0f8c4
> >>> R10: dffffc0000000000 R11: ffffed100fc0f8c5 R12: ffff88807e07c380
> >>> R13: dffffc0000000000 R14: ffff88807e07c60c R15: 1ffff1100fc0f872
> >>> FS:  00005555604c4500(0000) GS:ffff888125af1000(0000) knlGS:000000000=
0000000
> >>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> CR2: 00005555604df5c8 CR3: 0000000032b06000 CR4: 00000000003526f0
> >>> Call Trace:
> >>>    <IRQ>
> >>>    __sk_destruct+0x86/0x660 net/core/sock.c:2339
> >>>    rcu_do_batch kernel/rcu/tree.c:2605 [inline]
> >>>    rcu_core+0xca8/0x1770 kernel/rcu/tree.c:2861
> >>>    handle_softirqs+0x286/0x870 kernel/softirq.c:579
> >>>    __do_softirq kernel/softirq.c:613 [inline]
> >>>    invoke_softirq kernel/softirq.c:453 [inline]
> >>>    __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
> >>>    irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
> >>>    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052=
 [inline]
> >>>    sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:=
1052
> >>>    </IRQ>
> >>>
> >>> Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor=
 socket TX/RX data")
> >>> Reported-by: syzbot+4cabd1d2fa917a456db8@syzkaller.appspotmail.com
> >>> Closes: https://lore.kernel.org/netdev/68c0b6b5.050a0220.3c6139.0013.=
GAE@google.com/
> >>> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> >>> ---
> >>>    net/ipv4/tcp_bpf.c | 4 +++-
> >>>    1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> >>> index ba581785adb4..ee6a371e65a4 100644
> >>> --- a/net/ipv4/tcp_bpf.c
> >>> +++ b/net/ipv4/tcp_bpf.c
> >>> @@ -408,8 +408,10 @@ static int tcp_bpf_send_verdict(struct sock *sk,=
 struct sk_psock *psock,
> >>>                if (!psock->cork) {
> >>>                        psock->cork =3D kzalloc(sizeof(*psock->cork),
> >>>                                              GFP_ATOMIC | __GFP_NOWAR=
N);
> >>> -                     if (!psock->cork)
> >>> +                     if (!psock->cork) {
> >>> +                             sk_msg_free(sk, msg);
> >>
> >> Nothing has been corked yet, does it need to update the "*copied":
> >>
> >>                                  *copied -=3D sk_msg_free(sk, msg);
> >
> > Oh exactly, or simply *copied =3D 0 ?
>
> Make sense. I made the change and updated the commit message for this fix=
 also.
> Applied. Thanks.

Thank you Martin!

