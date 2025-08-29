Return-Path: <bpf+bounces-66930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B068B3B18F
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 05:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D299879C7
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 03:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266E7224891;
	Fri, 29 Aug 2025 03:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGbksbo5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D8633985;
	Fri, 29 Aug 2025 03:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756437825; cv=none; b=cK524+0mrvGb9YSI9OsU+71kqcnUIFEu7yusIG8QRhalynBpJLDCq4rDBeTsdmhJL7M5LeFY98RNeVE3vBL60xVqakI/F5wGlWf/I++oq/Od7tDWDKLimBFsRHLPM5xlvAJUFeMR3OLEYpdvzZDE1OuDkuyAAsXa+CFi0mDRyh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756437825; c=relaxed/simple;
	bh=YoFnaj2R52DEMURj9+8Mt8Ba4gPA5zr9toYIVwzwq6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jww+rGepRTlAwcPXeFsre1r20gPr7Npo0F5ZZuC4S6duPzI+dGX0y74h0gwaq4dK5cmlsi4QhKIuUrqUBEwhdCxYkamJO5B74klTigAsYU6StSe0CohKl7PqiJ9txmnPtXynIA3eoGNPRfVrnf91aiezEMxjo4lWtNn0j7PGcPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGbksbo5; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70dfe0ff970so9479776d6.1;
        Thu, 28 Aug 2025 20:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756437823; x=1757042623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBwKZeJm8+PLSTc5GaQR46o59GpAHHXYl6cKoKBhl4U=;
        b=gGbksbo58QAbuZIN34Qyl1vMLfQ/VUn/c77QbzqAneWqKshlzTXFmHSvovAFMz6yD9
         XlzEqs5ekY8ArOLZr4ZecfDJrl5juyk6GfHRGHS74HkosrDZQ2gs+x2OUhx2mVaNGDQL
         EaAFy0M0BJdtBfI/kZNOIGIOqT8U+oFQ+Q7d5YwJJlFOxWcG7cPqVSpVZdvh2pYOVcmN
         Mx6JIs1D6nsFi3V+6QO6nj+bJrp1RguyMbVdQvRu/CpalC3Kn80DZt3sgKbJkWT5hHuY
         jjeXPIijnraRAXp71Nns7zE/j0ByB0i31yNFVH12fhq8tlQ2dhtizMzuSlplBOFx8X78
         kn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756437823; x=1757042623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBwKZeJm8+PLSTc5GaQR46o59GpAHHXYl6cKoKBhl4U=;
        b=GrGqrzCxGugQhTF/Ee9iW7FaPX9mPlmdmrml61jQv7lNoUE2NfC4PEEtXY8h9uwSPl
         pVsZh8F/Ft6f2IYnqPYQRKzD62cNqqU6r1yrLJdcHtxOrcsmuTVc3/rMWw7NeqZRlZEF
         qNMXuclXATS2wOuUMBTrytWXjMMwt4OuDKiZDkhUtV9LhvBsGfNSbSCGeuAxmrbrcvLD
         hbmAXXGyED1bbMN0iGEIme+wa3lOYIAYLIlemtzTB0YvaZyB3wxfhi9bF0mdg+3hzzu0
         OdhCkCmkXI2qS139+4rVISZ4QerMHW58BklUAjHA/HdkarTm/790qdVtkBNXY/2uCHcu
         g6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN8EIC9Wb5JuuYpRSr7NM2rjQ2paj1m3uZLYgNGbebv83Rj+dgjKTVkGdTXyi6kYv3f+dTgurK@vger.kernel.org, AJvYcCWp3HT3EzejM0iSiCCWDs5G+uwu+P5BzxzVWEpXjE/N1+jY/JjZO7fYpRUEb1Nf8DQU1vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhfLRBrojEq1TQpwFrKnPAP6X/MvLor3b1/Jh3hhzqiin0Gwb
	4gfsOxw68veX71CqEIP+fjV7hXWZ5p+CMOszxsx8F5kF8g+RKRzJNzsVGZAO7acA4ykgU6La5hE
	75QoSxB61LKjJ+spAqaK8aMHkgjsqUYU=
X-Gm-Gg: ASbGnctfYJWwc29HY0mGdF8Lh2XWDltwfsYmwaENEgKdFgpu2AmIlu29BlhuvZsDOXo
	fjTHy1ip3RhbXIvWEDAG1BfXmvP1jc07PD8qXTDI/G5m9nCc5gLpn4rS8gL8VpQAm2Cx1caJLFg
	q8c/ToNzlDrlyxAmTJYPjq9To1gz6IwYdIG8BeqjKql58gqO4E0gAj5XldzprohFhJidmgfQg0M
	WyuaRXKoqdCaDIxFg6ek5Kn4gFZ456bQoaOA6/t
X-Google-Smtp-Source: AGHT+IGkkoqEo9wRk1HXqDDpieUuFAiPbb9GLF6LskXtOn7rJguvG6jtCDpmzQRVNEf+0KqXz1OAZ5XJeiYCW3FqyGQ=
X-Received: by 2002:a05:6214:cae:b0:70e:782e:b23b with SMTP id
 6a1803df08f44-70e782f22bamr14021246d6.3.1756437822785; Thu, 28 Aug 2025
 20:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822064200.38149-1-laoar.shao@gmail.com> <1d3ba6ba-5c1e-4d3f-980a-8ad75101f04d@redhat.com>
In-Reply-To: <1d3ba6ba-5c1e-4d3f-980a-8ad75101f04d@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 29 Aug 2025 11:23:05 +0800
X-Gm-Features: Ac12FXxGcJbvNy6x5NbB2DPgxqf3OtUtB2FLEiGqm8-XrSO-pIi6n5ehQ2sAELY
Message-ID: <CALOAHbBdiPZ_YVhBJeV517Xqz8=cuGo6jhhta_QXy5-eQ6EN4g@mail.gmail.com>
Subject: Re: [PATCH v2] net/cls_cgroup: Fix task_get_classid() during qdisc run
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, daniel@iogearbox.net, bigeasy@linutronix.de, tgraf@suug.ch, 
	paulmck@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 3:55=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/22/25 8:42 AM, Yafang Shao wrote:
> > During recent testing with the netem qdisc to inject delays into TCP
> > traffic, we observed that our CLS BPF program failed to function correc=
tly
> > due to incorrect classid retrieval from task_get_classid(). The issue
> > manifests in the following call stack:
> >
> >         bpf_get_cgroup_classid+5
> >         cls_bpf_classify+507
> >         __tcf_classify+90
> >         tcf_classify+217
> >         __dev_queue_xmit+798
> >         bond_dev_queue_xmit+43
> >         __bond_start_xmit+211
> >         bond_start_xmit+70
> >         dev_hard_start_xmit+142
> >         sch_direct_xmit+161
> >         __qdisc_run+102             <<<<< Issue location
> >         __dev_xmit_skb+1015
> >         __dev_queue_xmit+637
> >         neigh_hh_output+159
> >         ip_finish_output2+461
> >         __ip_finish_output+183
> >         ip_finish_output+41
> >         ip_output+120
> >         ip_local_out+94
> >         __ip_queue_xmit+394
> >         ip_queue_xmit+21
> >         __tcp_transmit_skb+2169
> >         tcp_write_xmit+959
> >         __tcp_push_pending_frames+55
> >         tcp_push+264
> >         tcp_sendmsg_locked+661
> >         tcp_sendmsg+45
> >         inet_sendmsg+67
> >         sock_sendmsg+98
> >         sock_write_iter+147
> >         vfs_write+786
> >         ksys_write+181
> >         __x64_sys_write+25
> >         do_syscall_64+56
> >         entry_SYSCALL_64_after_hwframe+100
> >
> > The problem occurs when multiple tasks share a single qdisc. In such ca=
ses,
> > __qdisc_run() may transmit skbs created by different tasks. Consequentl=
y,
> > task_get_classid() retrieves an incorrect classid since it references t=
he
> > current task's context rather than the skb's originating task.
> >
> > Given that dev_queue_xmit() always executes with bh disabled, we can sa=
fely
> > use in_softirq() instead of in_serving_softirq() to properly identify t=
he
> > softirq context and obtain the correct classid.
> >
> > The simple steps to reproduce this issue:
> > 1. Add network delay to the network interface:
> >   such as: tc qdisc add dev bond0 root netem delay 1.5ms
> > 2. Create two distinct net_cls cgroups, each running a network-intensiv=
e task
> > 3. Initiate parallel TCP streams from both tasks to external servers.
> >
> > Under this specific condition, the issue reliably occurs. The kernel
> > eventually dequeues an SKB that originated from Task-A while executing =
in
> > the context of Task-B.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Thomas Graf <tgraf@suug.ch>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >
> > ---
> >
> > v1->v2: use softirq_count() instead of in_softirq()
> > ---
> >  include/net/cls_cgroup.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/net/cls_cgroup.h b/include/net/cls_cgroup.h
> > index 7e78e7d6f015..668aeee9b3f6 100644
> > --- a/include/net/cls_cgroup.h
> > +++ b/include/net/cls_cgroup.h
> > @@ -63,7 +63,7 @@ static inline u32 task_get_classid(const struct sk_bu=
ff *skb)
> >        * calls by looking at the number of nested bh disable calls beca=
use
> >        * softirqs always disables bh.
> >        */
> > -     if (in_serving_softirq()) {
> > +     if (softirq_count()) {
> >               struct sock *sk =3D skb_to_full_sk(skb);
> >
> >               /* If there is an sock_cgroup_classid we'll use that. */
>
> AFAICS the above changes the established behavior for a slightly
> different scenario:

right.

>
> <sock S is created by task A>
> <class ID for task A is changed>
> <skb is created by sock S xmit and classified>
>
> prior to this patch the skb will be classified with the 'new' task A
> classid, now with the old/original one.
>
> I'm unsure if such behavior change is acceptable;

The classid of a skb is only meaningful within its original network
context, not from a random task.

> I think at very least
> it should be mentioned in the changelog and likely this change should
> target net-next.

Will add this to the commit log and tag it for net-next in the next version=
.

--=20
Regards
Yafang

