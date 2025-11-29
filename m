Return-Path: <bpf+bounces-75756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E30CDC93568
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 01:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2BB46348433
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822B91946AA;
	Sat, 29 Nov 2025 00:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtCYJ9NV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969E315624B
	for <bpf@vger.kernel.org>; Sat, 29 Nov 2025 00:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764377782; cv=none; b=rgvDE2Jqttssdr+KB0GXx4unTbzYu3W7xYNqVG7SpngPVzOLj3wBcMZN0z3t40i6iqRZpKJkRQ7yclu29yVaIee3wTTDEiMuSwdwGfhmoyctxs5ytkV/NCQmxtlq8aKhM26+VdABfnXl33K0OHyJthH9D3hpHefBP2QztA4xA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764377782; c=relaxed/simple;
	bh=4MTjHcSRUlbHrOJ+f9Ulvhi4iA2FkdPdg3sEPmZy/jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUxF39G7/DW0T4bM8xyElep3B/AiD4dTt/qE3vxq0toASRMpt8CWgwbcTnyLJHfgNQiscSRu+PynE4kBCL8WSCnmQBIIDl4WvDieR3ErjwlXWAWyxGq/v/BUOqq6Kf49p42IXclLejTH4nj0bgXKjZOCN6mPh9vHFN4FmgwMg6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtCYJ9NV; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-433217b58d9so11964545ab.1
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 16:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764377780; x=1764982580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MTjHcSRUlbHrOJ+f9Ulvhi4iA2FkdPdg3sEPmZy/jo=;
        b=MtCYJ9NV6OJlVgIqy/QbqPEU21+oOQM824YkZNIFao6qTp2iiRjFeNh/i7/BGtK/YB
         i61xQfqJlhOcl2j/+T28s4j2B/kL86Hs8jy6Oflmk0wlYlP7y7eZnwkLiSJC47H3Q6rN
         IS9H2jAeYxFAm/XXtqfPF/dCVwiM2NuvE1tE9oKx8K0mfuntMS4KbD1VBq2DYeqxHxfl
         j2jFBSDaS/Urxd1qM++LiCcuGU9H3P5DFjYpIfWezeCpG4tNmedxqSirXqW56jwNbihl
         FaDdcQ9KSTdEjQ6XmRmjf1U8aP25JBOj0oRjw0upB24WPKsvF5WcQdzbtnbsTcO41PRm
         1jOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764377780; x=1764982580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4MTjHcSRUlbHrOJ+f9Ulvhi4iA2FkdPdg3sEPmZy/jo=;
        b=wymCkBGWFjjmp3YDF8mxwc70hmAwb5YseQSnFHSu4Rw9Bm2WpgLJSlcaMorKz2q/03
         GsNnifWDrE72SmhrPnv+/aYJ9C5YVqSXCAMzQBxWuqkHW66JFsQem3ma49/5HD5n2DDa
         40HuvPFerBOKIhFFbqvmbDaDFbhbU6wsdPITpJl/tuKjOSHaA0CeTrjbTwdufa2Q+lfo
         09LbjJzqUXc028a6eq4VAsHMs/J8H5QWdnULUEqfByFdnGFljD2zuh0SFVI0XaPnSb/K
         gIhhT+dkQlm4av/3iLcMOIEwYc5Pm0q9ejnvKUXXwhCZrtz0WkmxX24YC9I4FMcE7Z74
         Rf+w==
X-Forwarded-Encrypted: i=1; AJvYcCWybrULMwYqAV6F8rFXAKbeS9E+rFOvItYHj4+uzSuiHxaLlE06zLwMpg80RBA36xUkbdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+mwE977MdiL6CDQFopKQUomzJ4ixjFsdkAeKqDt7PEv0TnKPT
	zjzf2uMwQIVXewvJanQH9JJrPASdNSSpOKwtVAKirEEANv20FOZiJIgV897R9t7Yr3lXnYwnrm9
	FU3E0CFaIm/i32Aj8u8dKtG03Wi7exuU=
X-Gm-Gg: ASbGncsODny7KmMIS9GN+novgXTjglQjN7obCYwOS3D81k5rZThBHhzrPaGfMHbGePi
	rifF+RKyDBZangM/rphI5liBBv9iUq5W7ke5Lb9nXGfz8y5ergj6t+FnW//pFQz6AGS3SmIjfWU
	DOvd2Yfzy3mzfZF2cJwb6J3dz7vQf+23Cklc2NgwmRfyANmzxmpweS6H35kYt290t6h7fYHfbYI
	oHcir/8inqko74+ngjOXTgtjKu2iU49ZRWPO0hl226I4EB769wkg8cYbBKS57nIGcD3SXE=
X-Google-Smtp-Source: AGHT+IHPjbVAykb9MFmYGfmY7NmyQ1c7NjGqXVwVjBgP4bb5koTULIIqFOMtmlAggPYv8GKzUVTstIoTjsVyXn2Czp4=
X-Received: by 2002:a05:6e02:1521:b0:433:8347:2e80 with SMTP id
 e9e14a558f8ab-435dd06e961mr119740435ab.10.1764377779669; Fri, 28 Nov 2025
 16:56:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128134601.54678-1-kerneljasonxing@gmail.com>
 <20251128134601.54678-3-kerneljasonxing@gmail.com> <8fa70565-0f4a-4a73-a464-5530b2e29fa5@redhat.com>
In-Reply-To: <8fa70565-0f4a-4a73-a464-5530b2e29fa5@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 29 Nov 2025 08:55:43 +0800
X-Gm-Features: AWmQ_bl2KUotuXts1CzGyhn6XYDGMJ3tNHO-0829YWUwnVp1JfoAvn-7jJwUIqE
Message-ID: <CAL+tcoDk0f+p2mRV=2auuYfTLA-cPPe-1az7NfEnw+FFaPR5kA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] xsk: use atomic operations around
 cached_prod for copy mode
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 10:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 11/28/25 2:46 PM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Use atomic_try_cmpxchg operations to replace spin lock. Technically
> > CAS (Compare And Swap) is better than a coarse way like spin-lock
> > especially when we only need to perform a few simple operations.
> > Similar idea can also be found in the recent commit 100dfa74cad9
> > ("net: dev_queue_xmit() llist adoption") that implements the lockless
> > logic with the help of try_cmpxchg.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > Paolo, sorry that I didn't try to move the lock to struct xsk_queue
> > because after investigation I reckon try_cmpxchg can add less overhead
> > when multiple xsks contend at this point. So I hope this approach
> > can be adopted.
>
> I still think that moving the lock would be preferable, because it makes
> sense also from a maintenance perspective.

I can see your point here. Sure, moving the lock is relatively easier
to understand. But my take is that atomic changes here are not that
hard to read :) It has the same effect as spin lock because it will
atomically check, compare and set in try_cmpxchg().

> Can you report the difference
> you measure atomics vs moving the spin lock?

No problem, hopefully I will give a detailed report next week because
I'm going to apply it directly in production where we have multiple
xsk sharing the same umem.

IMHO, in theory, atomics is way better than spin lock in contended
cases since the protected area is small and fast.

>
> Have you tried moving cq_prod_lock, too?

Not yet, thanks for reminding me. It should not affect the sending
rate but the tx completion time, I think.

I'll also test this as well next week :)

Thanks,
Jason

