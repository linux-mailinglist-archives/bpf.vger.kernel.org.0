Return-Path: <bpf+bounces-66014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C9EB2C628
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 15:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03FA37AC2C1
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 13:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726F6340DA4;
	Tue, 19 Aug 2025 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4sPaNes"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB4532255F;
	Tue, 19 Aug 2025 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611514; cv=none; b=FYQW4Xz0y8hZ3kWV/3gIFQhFDC2o5fCNklOacO+OZx4DyB3pCDwulESzLhYGEPYuxMvCQ45DFHP/jZKxWVEBpER6vMpwhAQo6pDc5jxqOOHUqimGZT7nVxoxTIh6xoA3gW+3uRqD2dlK7qimmdhKu6g7ppYQY3EV8T7ffjAQgDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611514; c=relaxed/simple;
	bh=E5/P6oW34qz+lMuuiFUWc9lIaO81GwPhbKeDrpqklrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AejUvsEsrD8TzQvm/NiZOx5X29w1Qd+vzrNtYqurtLsDNQtQ+hkusNQv/HRSi6IYaQ6k0EEHBU5ijjUAgA51tOx40/MappvhoIx6OcOAp0Xv/2G7a0oGWq23vRRpo6XyO3mOlGN+0Nk09rMYP3uGMdR1YADjL1QZvIrBi8iq6G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4sPaNes; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70a92aec278so41713006d6.2;
        Tue, 19 Aug 2025 06:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755611511; x=1756216311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F102jfoaFIbtEFCYKDz319XWn9qlG4FhjuvyRC3EQI0=;
        b=C4sPaNessSuYfc5uyZ/qj1F1Mf/D075oei3PQXeu77qjnEp4bme78cGwFbHybZqoQR
         sYPKZyspC6z43DE3TASGn6RXYa7TnO3mdcEy0Mf2Nqi7lRSSDMUZGBwn3PWTUpZ7mXZO
         8TKFkdMBO46zXsF3hBtq2+wiHe5di795cJ99Y80/pvBI/9PQelU1qtaH0dDUSGz73LJT
         JBGzD9QA4iV8fpo95i2ojM/DY0lKQqb74Q9eCt1zyuLW5kc1sSNpL/VmyDM3O2/l/R8i
         5Foty+au/IDaJAJQ/u4phZ42ASNoXi1z9/Kva77Rj3azpicWlHu1E0Pj5cg5XkmEyEMr
         U95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755611511; x=1756216311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F102jfoaFIbtEFCYKDz319XWn9qlG4FhjuvyRC3EQI0=;
        b=LChsNpHl5eZS2f+psFOSW2P70o/GJndZSE2DzNxJB/jkdy5ceqbFYxDSsvFQ6Du2wZ
         +Jaqtn5jjbNQ5rUglnsQXVt25h9mcsbX0UKWTHh4NrpRNB4GzoKHvYw0xlmd3B9Hg3Gn
         Q4xuXAoRtMAop9FtrOOIVwhVyZwlQSdZ2qPy5s1O+7+6BkxyzGCCyAGNPdKEOVL/troD
         RtbtjJfEbd9PBmH7Dm7VrTKs5AgUBdDa+Y2vtDAsnmFAQsYlB1zgi9TMcQeM0xJcxz4b
         Sn4re3r0f+hIwCtLrIDhMZQqZ0asT31uXMLOhsVUIEgloP5fjd13ZhhWYOmB/BSf9qFz
         OvLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvePUKpXh2lWGCn3Q9SCBIxLH2+UCjPlS0wjdNbsVE15nVo8BZLiFeUv6wod4D1raOIg0=@vger.kernel.org, AJvYcCVckLrVaRVvQdmOj6HxARcmPfxlUQlG2b62y/DnJSTB4hIo6hsRqb3WWkvlkc09NGnYunIlA7/oUUS+MSBC@vger.kernel.org, AJvYcCWvetMOJ2cqf6/7LasKSp8uUBNfrOo71hYvh7hjsU9ahsG9aQe03REXcj02RXFy/gWFD1j3f3ia@vger.kernel.org
X-Gm-Message-State: AOJu0YyWjIfg3aPp5txST0TeMYWFzFlnrFB3LmCBVHyCwxzYVYdScD9D
	au7T5h6GXZV5iAOWa8T1h+n3V9JXPXKVQPQRQF/zhtBtJqg4nU6LP33v9/+6gF+X5GWQNYLD4GR
	Q+TaxxL9yZrtVBpMgnc9EIKkwzzxQigc=
X-Gm-Gg: ASbGncuU0nVbiL7Q/hJxltq5tDP62CZ1Sb7HLIDFujYZiD4Hpj0Bg8YiqON48Gv5NDa
	vOUvkN2FIdi1plbU+4dBWNkNBrWuorLt/nPbDUVlkZQ8g3Dk2yZNEJxULS54M5h5KaSUHCL/xl1
	KWqvaiKwPYSMmrTgiWe3v/BfZ6N70HVT24WLldEd1o1hZW5Bfd5bIxEbOcdKX5gfd3S3BgENh0D
	uiEIOxC
X-Google-Smtp-Source: AGHT+IERdPyRYtDPxJMOeCsAIqOpGGA5rMrGIpeYli+n0NQZpXLiSW06X5TDVAjEhdLqXF7IKxxWiTnAsKlNVh1uAl8=
X-Received: by 2002:a05:6214:f6f:b0:70b:9b35:4056 with SMTP id
 6a1803df08f44-70c2d5a813dmr27844656d6.15.1755611511051; Tue, 19 Aug 2025
 06:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819093737.60688-1-laoar.shao@gmail.com> <7d2f3767-64c5-4efa-862b-f463751a03bb@iogearbox.net>
In-Reply-To: <7d2f3767-64c5-4efa-862b-f463751a03bb@iogearbox.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 19 Aug 2025 21:51:12 +0800
X-Gm-Features: Ac12FXxuYucJ4v8BwccT0sxXkAZW6WJIMADkRRQCrjoYepi_NlYaZPPbCJ6CBCk
Message-ID: <CALOAHbCKFBVJz1KOyUXrvDu6svTXF3Q-O5boCkMtu-Tsia7aAQ@mail.gmail.com>
Subject: Re: [PATCH] net/cls_cgroup: Fix task_get_classid() during qdisc run
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Graf <tgraf@suug.ch>, 
	Paul McKenney <paulmck@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	"open list:BPF [RINGBUF]" <bpf@vger.kernel.org>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 8:42=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 8/19/25 11:37 AM, Yafang Shao wrote:
> > During recent testing with the netem qdisc to inject delays into TCP
> > traffic, we observed that our CLS BPF program failed to function correc=
tly
> > due to incorrect classid retrieval from task_get_classid(). The issue
> > manifests in the following call stack:
> >
> >          bpf_get_cgroup_classid+5
> >          cls_bpf_classify+507
> >          __tcf_classify+90
> >          tcf_classify+217
> >          __dev_queue_xmit+798
> >          bond_dev_queue_xmit+43
> >          __bond_start_xmit+211
> >          bond_start_xmit+70
> >          dev_hard_start_xmit+142
> >          sch_direct_xmit+161
> >          __qdisc_run+102             <<<<< Issue location
> >          __dev_xmit_skb+1015
> >          __dev_queue_xmit+637
> >          neigh_hh_output+159
> >          ip_finish_output2+461
> >          __ip_finish_output+183
> >          ip_finish_output+41
> >          ip_output+120
> >          ip_local_out+94
> >          __ip_queue_xmit+394
> >          ip_queue_xmit+21
> >          __tcp_transmit_skb+2169
> >          tcp_write_xmit+959
> >          __tcp_push_pending_frames+55
> >          tcp_push+264
> >          tcp_sendmsg_locked+661
> >          tcp_sendmsg+45
> >          inet_sendmsg+67
> >          sock_sendmsg+98
> >          sock_write_iter+147
> >          vfs_write+786
> >          ksys_write+181
> >          __x64_sys_write+25
> >          do_syscall_64+56
> >          entry_SYSCALL_64_after_hwframe+100
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
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Thomas Graf <tgraf@suug.ch>
> > ---
> >   include/net/cls_cgroup.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/net/cls_cgroup.h b/include/net/cls_cgroup.h
> > index 7e78e7d6f015..fc9e0617a73c 100644
> > --- a/include/net/cls_cgroup.h
> > +++ b/include/net/cls_cgroup.h
> > @@ -63,7 +63,7 @@ static inline u32 task_get_classid(const struct sk_bu=
ff *skb)
> >        * calls by looking at the number of nested bh disable calls beca=
use
> >        * softirqs always disables bh.
> >        */
> > -     if (in_serving_softirq()) {
> > +     if (in_softirq()) {
> >               struct sock *sk =3D skb_to_full_sk(skb);
> >
> >               /* If there is an sock_cgroup_classid we'll use that. */
>
> Hm, essentially you only want to use the fallback method of retrieving cg=
roup from
> the socket when the dev_queue_xmit() was triggered via ksoftirqd, rather =
than from
> a process via syscall all the way into dev_queue_xmit(). It gets more fuz=
zy presumably
> when skbs are queued somewhere and then some other kthread calls the dev_=
queue_xmit().

Not only can other kthreads call dev_queue_xmit(), but user tasks can
also invoke it directly.
In the execution path:

  __dev_xmit_skb
  =E2=86=92 __qdisc_run
    =E2=86=92 qdisc_restart
      =E2=86=92 skb =3D dequeue_skb(q, &validate, packets);

The SKB dequeued at this point might have been originally enqueued by
completely different tasks. This creates a scenario where the current
execution context doesn't match the original context that created and
enqueued the SKB.

>
> Looking at in_softirq(), the comment says "the following macros are depre=
cated and
> should not be used in new code", see commit 15115830c887 ("preempt: Clean=
up the
> macro maze a bit"). Maybe Sebastian or Paul has input on whether in_softi=
rq() is
> still supposed to be used.
>
> Side question, did you investigate where the skb->sk association got orph=
aned
> somewhere along the way?

The skb->sk is not orphaned in our observed scenario.

The setup to reproduce this issue are as follows,
1. Add network delay to the network interface:
   tc qdisc add dev bond0 root netem delay 1.5ms
2. Create two distinct net_cls cgroups, each running a network-intensive ta=
sk
3. Initiate parallel TCP streams from both tasks to external servers.
Under this specific condition, the issue reliably occurs.
   The kernel eventually dequeues an SKB that originated from Task-A
while executing in the context of Task-B.

--=20
Regards
Yafang

