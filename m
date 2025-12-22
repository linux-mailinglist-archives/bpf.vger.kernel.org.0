Return-Path: <bpf+bounces-77284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED5DCD4EBF
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 09:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8250300BBB2
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 08:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D8E30AD0B;
	Mon, 22 Dec 2025 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ2yaeAi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF3E3043C9
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766390498; cv=none; b=A6VxxD0ncWaOTZBGY7M1TY04uc8zggUtuLZ2uSaovCyIcH8D1AKvHdJbxEbgdik1mWxtGvJlOdDTOfTY0sdxbF1MQDVqDKn9cO5ZxJnLk7pDAdRwB/O8HZSlFHMCoTXVfaGYnbi8hEPtkmKOyzq4+JRbPRHI++Q/gwAt0heZjuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766390498; c=relaxed/simple;
	bh=U0b6/RRZoU9PJ37clj0ubioxb/HZFHSbQmsQdaqPnwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z2aX5Hn74QhX+LEXZPgUUfYZT/83s6zFNpvAwNYT10jK4aVKCXiSrjSPgA36CkFJbRrK7wG8Tm5+StO2qdJb7KEf9uOr3TZSLmm6PyOpQ3Vn0HEI5o4RmC5lWqb6wDI0YUM9keaHB9AYNWhpkw/REgcHNDeJPzJUeToR/pA7FNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZ2yaeAi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0f3f74587so51344235ad.2
        for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 00:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766390496; x=1766995296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8zLCGtUEy59h/vvTVaYiE4AnuVfZ6wIueUdzudE/X8=;
        b=kZ2yaeAi7bum9MaKKD6+88hp9OejiTKJvt2flckbDXlMDwgbAkhTPRcRPoaQQffp5A
         t+lZfZTzlXk4XcdBXOCIOGb72h8YZ7uPkEt1FxEJ2GkyPijU9EQtxp849bgsoqUngANc
         yE7khI9UkQgavPH+iy0ZfZR0F9ArXi0SSXNODjZ6yA3Vo+CJrPRsCJbjcN03fyidiziq
         LUnpEfepppGUtnJenhtmjIyKHr7tJ/kNIm+AMtcPStYtFXEq2OgUQ2VGGRhS32j90GQS
         Nt+RlEvWU5vqW9gflHA8fE/lo7076PSWaDS12T7e00lQlPyh+uyaEdrc0ems+Rd4o7Qr
         bHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766390496; x=1766995296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v8zLCGtUEy59h/vvTVaYiE4AnuVfZ6wIueUdzudE/X8=;
        b=t93s059fniN2JqsQt+rcRL32s+vPGIyjynRJye0kunnctxgEQ/R8SDf5V84Z6xtYW6
         XXmbrVsmRlpAow8/V1C/3MhONj1Px4cFrfal3W4saAXNQPvjncl0RURZsTRNFhnIbNuF
         wCRrKKZLJauWiHsqJgESQ2Qq8/YgdcHhbAjDTk7fG7CphMW17MNol9eZnPGtPWNEmm8q
         3MCkSjho2SV+vMk3LvDBgEPBf4OTCw/3u2mCse+rLbD3EFhQdV1pp784LznaDqvevNjk
         acG2eW3aRJgFvofy7F4BeIzhRAPbSSKNEtaPI0jxLdY96iBl6iDo5SO/f7AAxoykghp5
         ZZJg==
X-Forwarded-Encrypted: i=1; AJvYcCXtDsO4Kk2gzLOmCJkH9RMJXxMLtlE63bhkia/LjnGyfAxAbiY+AJBuU275DrHxaZR3Ne4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZCJRre6ZYrtl+zcHNzcJWZdWCpDU/DIvAZjEypf/9k0tQW48G
	jmXXvsa2xHuBlqqCy+xWv8OwzxHxyY01t8+M00oJebsbUDLtirbnmhmh
X-Gm-Gg: AY/fxX6NgnbPv3bd+c0GWYv9CAAS/0JJiySFWdbMtJLE7AUF4TsdbdaNU82VfNquTVg
	r6ooS1T+vwMzIbj4lu6N6GKxOANR9nidMJx496Np43RcG2Slq2jWNkBVDDTpfByEEUz4RcCZj4h
	pZFBFUWx4CGp0zoECOkwMHf8qfN3pbTkC/NeEprCijTegXd25iEiXMTm6vM1fVtdCnmB4vSXQMW
	9wmBJ7xRPMDDGR1u6NRkAtiHKqxOTw5RI7//CiYZ8oSGtvTzLfMyQCTadVAFft3zLbV+FVHbHTp
	h43+iczaUcfadUl2MibAthiwzmdKvXX8wxcGMCeZRC3kiirTj8tOAMPBE3twYPfdIHMhN6Fbukd
	GD4xzwZcDioYt/OEsHlZRvqMC70KyWSEbeQtZanS5pnnYVBaKB8lTJwdeP9+DYeQmBWF37HJXOs
	dXQSCUdaZ2SewgsZ2DnVlCAYhv5z5cLuzJYHM=
X-Google-Smtp-Source: AGHT+IGRVyFERy7XokCmRRlYiNa0pF4cWj/sV618kkaysFWs1qFh/tkntU/7uvjqRuWTOwS1Q9Ei1g==
X-Received: by 2002:a17:903:fad:b0:271:479d:3dcb with SMTP id d9443c01a7336-2a2f2212bc9mr111129865ad.6.1766390495794;
        Mon, 22 Dec 2025 00:01:35 -0800 (PST)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c82ab4sm89961165ad.32.2025.12.22.00.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 00:01:35 -0800 (PST)
From: liujing40 <liujing.root@gmail.com>
X-Google-Original-From: liujing40 <liujing40@xiaomi.com>
To: rostedt@goodmis.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	liujing.root@gmail.com,
	liujing40@xiaomi.com,
	martin.lau@linux.dev,
	mhiramat@kernel.org,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH 2/2] bpf: Implement kretprobe fallback for kprobe multi link
Date: Mon, 22 Dec 2025 16:00:46 +0800
Message-Id: <20251222080046.2312024-1-liujing40@xiaomi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251218160925.3c02a721@gandalf.local.home>
References: <20251218160925.3c02a721@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Dec 2025 16:09:25 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 18 Dec 2025 09:53:16 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > > +static void bpf_kprobe_unregister(struct bpf_kprobe *kps, u32 cnt)
> > > +{
> > > +       for (int i = 0; i < cnt; i++)
> > > +               unregister_kretprobe(&kps[i].rp);
> > > +}  
> > 
> > Nack.
> > This is not a good idea.
> > unregister_kretprobe() calls synchronize_rcu().
> > So the above loop will cause soft lockups for sure.
> 
> Looks like it could be replaced with:
> 
> 	unregister_kretprobes(kps, cnt);
> 
> Which unregisters an array of kreptrobes and does a single
> synchronize_rcu().
> 
> -- Steve

Thanks for the suggestion. I will refactor the loop to use
unregister_kretprobes() for a single RCU sync.

