Return-Path: <bpf+bounces-50704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E278DA2B6B0
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 00:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D1B97A25AB
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 23:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C3C22CBF0;
	Thu,  6 Feb 2025 23:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmifzu4y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3209121504A
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738885389; cv=none; b=tQo+uIJlJ+2sU2qE17uWEOGAruYbww/U5DKzAQ+xm1nZMQxALe6NZbNYJ2PNdZSBgSuuasHq2t4tiXvqu0dio8q5K6VDy+CXcHPcg9zjGL8Wp6Ecb7vND4+koE/+LpfniBgBbhI0lVV1dzznI/mntKRdXuWo2xg4c0WMjDpaxDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738885389; c=relaxed/simple;
	bh=RvvwIbUtlaFO7CGmM9b4TBLnCunHEMqXx3qp9yOT6N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOSiR1yJy/ayI+AJ49wWgJGuj17LNKMRde1Ch8gMDOECAOQZTlJ4jMwbxug85TGlBGSia9IaXjrR8tKGBE8ha4Tb1bem6+nYou+qn6sO9P6XgoCWSaco/8RXmhjwAG3JtnNEl2imO+wo64P+EZS79mANu/kILZAcs3vwuzHrz8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmifzu4y; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3eb9bbcc936so977668b6e.0
        for <bpf@vger.kernel.org>; Thu, 06 Feb 2025 15:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738885387; x=1739490187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvvwIbUtlaFO7CGmM9b4TBLnCunHEMqXx3qp9yOT6N8=;
        b=kmifzu4yoy2gS8ogzqSn4mZfrtA4pY7cuZkCwRqE2ZfH4zry8OR4ZeFQh6tWovj+cC
         NV7vo6qwsJ5/LczZ0P99OFsVd61o55xlrQTpSzdhgceqz85YcMMjOKDYHjiH31/nO0rm
         v3tVW4M7KK9UF4wK+ol9KXDZ1K79PTfu4K53r3L+I26D0c1iAS2hZyRfbagcYYA16QGo
         8tLt3ZzHUtlGllT5Ewi5MCpZC7x9mM8JTnR2hio6H1ik6/2kpVxnRx5j+8ADKsDX8t6f
         COsPdEDJwIOO43tBztCcBdGPKTi9NyicrrZVi80DeekBhphZ+fxLEgw5AwvmAEA0nZEY
         n9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738885387; x=1739490187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvvwIbUtlaFO7CGmM9b4TBLnCunHEMqXx3qp9yOT6N8=;
        b=lzkYj1fLxTnYXbiS2+HHRlqYentAlZr1rdmz74G+gLu90LoLsHysCtoRXMxG4MPOjN
         AkOaujf/yaaAsCOJGvFV7B4QUOtsgzVdeJTyS6oCADY2Kfvu6miZlVxn0J0doFc8XHCG
         nDw15K4T7XcsFmepGyn2mLn9EKiSWYix0xypJFJuaaXSNwOhEQWu5w0+TWv9cUrPIdgr
         JEimvgTMvXLbbj9z5L9gA1LT0pF8tBxRu6rnR6U4f1V4+5nV83aW0lbFsN1scU7ZMsjI
         v0V8XRTLpZYTjPN3jhrLAPzxxBXfOG0urxSaXOpLyyUQzPm4bDhmeB179ALqtCAPJN3Z
         5Mbg==
X-Gm-Message-State: AOJu0YyAIKuYBV+2/6rHKWk8FjtI+/KcEZbtVkw8QcbYsNbihDFoW7Ob
	HSycNOhj2MneL2h86LUrTkT75lH1YwR9j1BKhwbAN2le1mFQqqOIQSWfzK3009CgvRO/57pVPpt
	mxzQ0/2TqYauP1OvTnDCHkkJCYDQ=
X-Gm-Gg: ASbGnctuZ+hAz9PBhJVgB96H9FdV3mI+YvR9Tu4OiORqhDJ9qQzduEnrWrQMEBuIbhc
	whR7XoMFiGNWH3waHHpY5TjXh6Dk9vLzXK7DAwmvCOohoz7BtHknpKM5Rv17yyUp+MUQhkt7HuJ
	yAKyG3Us6rwmg7ca1UUeoxJzxXxsI7Ug==
X-Google-Smtp-Source: AGHT+IFjoPoxKBmPG4zonEaWLFotQt0payQrx/o6Jp5R0hNF61uEwSnR96nwNaPP622rIFJDuRMEpQw7Iayx9N/lr30=
X-Received: by 2002:a05:6808:158d:b0:3e7:a201:dc31 with SMTP id
 5614622812f47-3f3922b94b4mr1036355b6e.23.1738885387105; Thu, 06 Feb 2025
 15:43:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHnJ_vj-bbZhUqoDrf0wXEh8gEUVwq34WMXfHRo5=nx5FAL4OA@mail.gmail.com>
 <CAHnJ_vhEwtqFtjjEX3DN03e1_vKSBu4e2cOAdinzgtrs2aPjUw@mail.gmail.com> <Z6TsyIDwfkvsJdsn@pop-os.localdomain>
In-Reply-To: <Z6TsyIDwfkvsJdsn@pop-os.localdomain>
From: Aryan Kaushik <aryankaushik666@gmail.com>
Date: Thu, 6 Feb 2025 23:42:56 +0000
X-Gm-Features: AWEUYZnG6dtWoinPkPjVWm4mB-UF0gKPzywfJD-BsUZcBT-2MZUkYifCPTzx10A
Message-ID: <CAHnJ_vi8wTerw3oaN0Pqzh5CWCcNK3dq7d3Z_CgvV-VHH_O1Qg@mail.gmail.com>
Subject: Re: Fwd: LSF/MM + BPF ATTEND - Topic 1 for discussion
To: Cong Wang <xiyou.wangcong@gmail.com>, alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Folks

Thanks for sharing your feedback.

I am currently pursuing my Master=E2=80=99s degree in Computer Science at B=
ITS
Pilani, India=E2=80=94one of the best & leading institutions for research a=
nd
academic excellence.
As someone deeply passionate about systems research, I am eager to
contribute to areas that are both technically challenging and
underexplored, where meaningful impact can be made.

Attending LSF/MM/BPF 2025 would be an invaluable opportunity for me to
engage with leading maintainers and innovators in the field.
I am particularly excited about the prospect of finding a research
direction and mentorship, as well as exploring potential contribution
areas that align with my expertise and interests.

I would be incredibly grateful for the opportunity to participate in
this conference and would appreciate any guidance on how I can best
engage with the community.

Please let me know if any additional information is required.

Please help to attend this conference.

Best
Aryan

On Thu, 6 Feb 2025 at 17:09, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> Hi Aryan,
>
> On Tue, Feb 04, 2025 at 02:00:19AM +0000, Aryan Kaushik wrote:
> > Hi Team
> >
> > Hope this mail find you well.
> >
> > Topic 1: Practical Applications of WebAssembly (WASM) in Filesystems,
> > Memory Management, and eBPF
> >
> > Description: WebAssembly (WASM) is emerging as a powerful technology
> > for secure, efficient execution in various computing environments.
> > This session will focus on how WASM can be leveraged in filesystems,
> > memory management, and eBPF.
> >
> > Key discussion points include:
> >
> > 1. WASM=E2=80=99s lightweight execution model and its impact on memory =
efficiency
> > 2. How WASM interacts with filesystems and operates within sandboxed
> > environments
> > 3. Potential synergies between WASM and eBPF for secure, efficient
> > execution in cloud-native and kernel-space applications
> > 4. Real-world examples of WASM implementations in security and
> > performance-critical environments
> > 5. Challenges and opportunities in integrating WASM into Linux subsyste=
ms
>
> I assume you mean https://github.com/wasmerio/kernel-wasm ?
>
> It is indeed a very interesting topic, we discussed it before internally
> as well. IMHO, the major concern would be that we already have a
> run-time sandbox for eBPF, so it would be difficult to have another one.
> Nevertheless, I think this topic is worth discussion.
>
> Thanks!

