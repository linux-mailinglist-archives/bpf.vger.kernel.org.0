Return-Path: <bpf+bounces-62322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EE7AF80D5
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC795861AC
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 18:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAD42F549E;
	Thu,  3 Jul 2025 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2aLfLHg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019D42F3643;
	Thu,  3 Jul 2025 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568872; cv=none; b=EPJtS3wnrHeVFz54y3krgfwujyeuyJ3JSEO1c0RdBA9Q8FVAjrtSw3FcdmzMF1SMNGUH37IkdrpYM3MP5Mq1JVsU5nkEsGJHAZkmsyBlXllE2MlPiFZc7balniTgk1iuAlL0YnTGH6hbjKzz4/i+oq6io5AwxEaUtKjZAtX9leA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568872; c=relaxed/simple;
	bh=MHLgyIAAlaHzAt1ozfFRMbW86yKnRGFobTpOPBAiBTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OiifTV0w4CQ0fJEAzVU65WV1cp2tTMdRnpWONl9nOIcb3fdzYs5WwN1EAFOt9oF86XpB0j/pXUNJgS++LRxfr0DCTzxM5Mj6u9hYfti0pJCC/RlMbTgPn0TTlXca6pf4hfS1jFW4ynwIcOQmROhKbV+XNzvFrToKOV97R6g5mxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2aLfLHg; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af51596da56so201841a12.0;
        Thu, 03 Jul 2025 11:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568870; x=1752173670; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Je+Kvo1raeo0nO8HQUrtQYmsvZLPldduNj3ulNNfC0w=;
        b=A2aLfLHgRXRn+SITqCY3okeX01qHwnSx7YLVY6hkCwHMdgqNdBAaC0piP+Ew94c6Rd
         H4bJww2K8UGnHm3ybCZ9kvjg2Aw3iXE5kIkyavmDa9elKFUSlXc5KGl3Tea2+jN3vEpE
         nosRfToshY6VSa2vI3fmojpSFqOOkaVTrzJ/DvPDq55Opx8BUlpPmYbrceCePEamUMDa
         isCE/Wyg0MihfFuylI0EJP5sXijvB+SP6S64oQhoU6FGwSThufFIqbc/8cCsF63RWun4
         NjeDNF1QISbGma9YxlPm07GelOmCe7QGT8p+E3GnXRp14ouyOSbTkQzsNKKsVltiff9m
         elFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568870; x=1752173670;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Je+Kvo1raeo0nO8HQUrtQYmsvZLPldduNj3ulNNfC0w=;
        b=Y8iTOou6apzYCCym1jL7zzc5t9GE7YDmqusCgCfeV5ppSmjBIyfTaP1j8iRWQDXRec
         y1iFJpipybOabTLn3AWEgm38D5ksySgDl9d2/TBIvZH/sgHT6wg3wvJ2UbOwzVeoJd+R
         LoWe8LQvcJKGih4IkjCiT1c3jpjEzNLxBSkiTaOoA5VJ+owfOQH5O2sRpq4W4m1IUauG
         u2fX0wb2DWGHJkQ7JLP63LAHbM9lwIgr4jU3aosO7BmU67E9/qrv/F7Im9VJVss7T5ZG
         uWN7s4gkr/bYaQbVjO3HntJMvGwaskil4TekZ8ywhoo4Hd8SRI/oSQOZPSB3o0z5GVjn
         gnVA==
X-Forwarded-Encrypted: i=1; AJvYcCU7ehZ6ivR+Gqx22fooDnRIdvQrCE007MeIzBvxNZqpQ3Nf4E+j+rw+TaWym1j4EI8wBVs=@vger.kernel.org, AJvYcCXNphH7VxywH8rAEKo78h5zs0T7uQ1OVZefoGVzHzkSp8tdG88JPl6V7IKtJJonEd4wRiaUHMsM9NhyDtDS@vger.kernel.org, AJvYcCXwW+VGgmynV6AxDPl1iVgo7etriwi/Hxg794Nv+mTX91VhxWpk5LZxXAmyF74hA84hd9oMBJl7@vger.kernel.org
X-Gm-Message-State: AOJu0YyeN+H4GDYZ9nH9d6kdm2rAVChBM1IURDbhRy1sXz5Oip9xf5BK
	bEngwjS2zRFhkCvfZ4MQhDslZqA2opXBn6oDAMnhgaDzmcQAk8i1C4ot
X-Gm-Gg: ASbGncvUXfht8pj7kgsDhHP1qLZEtzFrN1MnZJiHWSZ6mfZBKUJuF0Q1SxwAt3UzSe3
	Bx6oGRz3wsnUFoIUCH2H70OIV8UNIzBlrCroAl4tPrvnSbY5YknHMU4CSVj0GsOTHSrkCae8PW1
	3tfyqjdiSfqgMqwsH+l/b0BcyCYjPbLpf9xu8jTcCyHHF6LLZcrPQK5vVQWoSZ5Pzs0h7itXcOH
	G62WaxDYnTaz/X/di7X1ozuKF+VzIh1FhkGcj5jipQX43/p7LUQAIJNrQQFC458Ijt4tNnmJZoR
	VGo5ezBb4h3aPXlQpG7OPa/DAFe2aUxmMiK1KMa4XpqnHRJ2LHj1g9Wu0CDKTLdy7Mmn
X-Google-Smtp-Source: AGHT+IGdpHZrdmFyyiymuGdUZOuLjASFow+k09ajyETWvV3/A/VXWNWTSJ+XGvKBWAd2HCh+h8NetQ==
X-Received: by 2002:a17:90b:1c12:b0:31a:947d:6ca1 with SMTP id 98e67ed59e1d1-31a947d71e7mr7816486a91.22.1751568870000;
        Thu, 03 Jul 2025 11:54:30 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:90c4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae80ae0sm160787a91.21.2025.07.03.11.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 11:54:29 -0700 (PDT)
Message-ID: <865f2345eaa61afbd26d9de0917e3b1d887c647d.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, syzbot
	 <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, 	sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, 	yonghong.song@linux.dev
Date: Thu, 03 Jul 2025 11:54:27 -0700
In-Reply-To: <aGa3iOI1IgGuPDYV@Tunnel>
References: <68649190.a70a0220.3b7e22.20e8.GAE@google.com>
	 <aGa3iOI1IgGuPDYV@Tunnel>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-03 at 19:02 +0200, Paul Chaignon wrote:
> On Tue, Jul 01, 2025 at 06:55:28PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    cce3fee729ee selftests/bpf: Enable dynptr/test_probe_re=
ad_..
> > git tree:       bpf-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D147793d4580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D79da270cec5=
ffd65
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc711ce17dd78e=
5d4fdcf
> > compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07=
757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1594e48c5=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1159388c580=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/f286a7ef4940/d=
isk-cce3fee7.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/e2f2ebe1fdc3/vmli=
nux-cce3fee7.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/6e3070663778=
/bzImage-cce3fee7.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds viola=
tion u64=3D[0x0, 0x0] s64=3D[0x0, 0x0] u32=3D[0x1, 0x0] s32=3D[0x0, 0x0] va=
r_off=3D(0x0, 0x0)(1)
> > WARNING: CPU: 1 PID: 5833 at kernel/bpf/verifier.c:2688 reg_bounds_sani=
ty_check+0x6e6/0xc20 kernel/bpf/verifier.c:2682
>
> I'm unsure how to handle this one.
>
> One example repro is as follows.
>
>   0: call bpf_get_netns_cookie
>   1: if r0 =3D=3D 0 goto <exit>
>   2: if r0 & Oxffffffff goto <exit>
>
> The issue is on the path where we fall through both jumps.
>
> That path is unreachable at runtime: after insn 1, we know r0 !=3D 0, but
> with the sign extension on the jset, we would only fallthrough insn 2
> if r0 =3D=3D 0. Unfortunately, is_branch_taken() isn't currently able to
> figure this out, so the verifier walks all branches. As a result, we end
> up with inconsistent register ranges on this unreachable path:
>
>   0: if r0 =3D=3D 0 goto <exit>
>     r0: u64=3D[0x1, 0xffffffffffffffff] var_off=3D(0, 0xffffffffffffffff)
>   1: if r0 & 0xffffffff goto <exit>
>     r0 before reg_bounds_sync: u64=3D[0x1, 0xffffffffffffffff] var_off=3D=
(0, 0)
>     r0 after reg_bounds_sync:  u64=3D[0x1, 0] var_off=3D(0, 0)
>
> I suspect there isn't anything specific to these two conditions, and
> anytime we start walking an unreachable path, we may end up with
> inconsistent register ranges. The number of times syzkaller is currently
> hitting this (180 in 1.5 days) suggests there are many different ways to
> reproduce.
>
> We could teach is_branch_taken() about this case, but we probably won't
> be able to cover all cases. We could stop warning on this, but then we
> may also miss legitimate cases (i.e., invariants violations on reachable
> paths). We could also teach reg_bounds_sync() to stop refining the
> bounds before it gets inconsistent, but I'm unsure how useful that'd be.

Hi Paul,

In general, I think that reg_bounds_sync() can be used as a substitute
for is_branch_taken() -> whenever an impossible range is produced,
the branch should be deemed impossible at runtime and abandoned.
If I recall correctly Andrii considered this too risky some time ago,
so this warning is in place to catch bugs.

Which leaves only the option to refine is_branch_taken().

I think is_branch_taken() modification should not be too complicated.
For JSET it only checks tnum, but does not take ranges into account.
Reasoning about ranges is something along the lines:
- for unsigned range a =3D b & CONST -> a is in [b_min & CONST, b_max & CON=
ST];
- for signed ranged same thing, but consider two unsigned sub-ranges;
- for non CONST cases, I think same reasoning can apply, but more
  min/max combinations need to be explored.
- then check if zero is a member or 'a' range.

Wdyt?

> The number of times syzkaller is currently hitting this (180 in 1.5
> days) suggests there are many different ways to reproduce.

It is a bit inconvenient to read syzbot BPF reports at the moment,
because it us hard to figure out how the program looks like.
Do you happen to know how complicated would it be to modify syzbot
output to:
- produce a comment with BPF program
- generating reproducer with a flag, allowing to print level 2
  verifier log
?

Thanks,
Eduard

