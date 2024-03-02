Return-Path: <bpf+bounces-23255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C47086F27C
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 22:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48E17B2264A
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 21:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906F140C09;
	Sat,  2 Mar 2024 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7y9RMpA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEB22B9DC
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709413747; cv=none; b=RVYffZefCHKp23P+IKVcsSltTBIip+sRtetMBdsVKeK9j+jrG2HgeFvsHbu4THg6vZTnic6Xk5gugZKVemsBLPLkLk8T8XjVBHex21XoaReJ1++JCm+pLrTR2yf+Ki8YPN2cxpRIZw1BxKXKLUv0Rb7jTFdHfyuQgyDFrt/qB+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709413747; c=relaxed/simple;
	bh=rmsTypg1mYVn/ff91ahp1LXvBBB4eKZZcBNR5sJ284U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/4FC61ivY8YSs/rhdiESCaXoQ88d2rgRy6/nBYIkuWU3HJLzeKrkGKDhLD+grGNgTCVPe01L8RBfuLhVHvI8BOmvR74tZC1RkX7Ci0DwG5x2hGC1T87ItJM+CgpkWYSW6LztzJ2U89tUiv6+MS06Gp2RYbRvfm8qJNflEzYNmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7y9RMpA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e2774bdc7so879586f8f.0
        for <bpf@vger.kernel.org>; Sat, 02 Mar 2024 13:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709413744; x=1710018544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmsTypg1mYVn/ff91ahp1LXvBBB4eKZZcBNR5sJ284U=;
        b=Y7y9RMpABzx5gVPmGHLp2j5zgJCigsfRJU7Ct0N2nr7bUE/Qh9aAhyM/Z4uBE367aM
         P26xQvT/L3QmQd49HxJMWqV14Lc3EGdhl0e6++RxiO4V+hMOmSibfmAoo3xmjy+Uirno
         knQ1wCOXTICHREcYsOyyC5Zs9haNY1LNns6YP27ahYvB4qXOgRLBNW08V36blkT2tuIL
         VeME+K+3ut76TxGJBcvvDxvrJmyP5QN6BNG/ShKIMkSZhIsi361Vi7mPP8kKwCCu8FBG
         na9DgWy2DmO4ABnCj4rcdv7Zhvx2G3lWYfekKkw4QzSMOGN+voTW6ZvJ/WYdPx33ib2N
         enxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709413744; x=1710018544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmsTypg1mYVn/ff91ahp1LXvBBB4eKZZcBNR5sJ284U=;
        b=OMKo52kY7SuxBdfgDi+riYErezgTMzPX+KsVow9hgdWjUzOTH0L/XpP7nIq1hklX+a
         /8hZFaWR9oBD6PshHtDW4GkoV5FE9B53Sc1C/yyO89G0KFtaaM2t0A07C9tJoJ84aoqF
         FDYJEVwjTdjxBgX0Nsce9X342VTThogG9CbeS+wCz0OKKfpJMdYIg1TM14dmTUSXjKTt
         PWKbNd8JAXGLnQQ5VUbATQcaoYDJM9yLG2KTqp+Osd8kK5UKq6pV2w3zq5T+qLFWweXM
         7EOj14R8BDJbcg6V3WyNEsRE6eR4mUaMuQwYM4hcZR8W/0Ea87OIW1oDJNn9Ydh9sKmE
         Em0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRQ6xx6Y7IDokWiuRsin0XXgs+zdJGllX2PQlrGXS3G2w674yRFOQGCjhRSKBoCSP+j2o+Q25B5ZTx2JETfouHL5ng
X-Gm-Message-State: AOJu0YyvY5PSgnr1riQnucjAN9pP3aZW18UMrbIZ4u++76/QtsAqf6Hp
	iLa/8tkrllHyAiaV1A8oE9c7kGopZxLCWH1qDoQ2c2wOdaaKgUEfh0H2Q6zmVClykue7ImNxzDH
	qxRl8K4ErSc4t1uYtTn+zOnLnI/g=
X-Google-Smtp-Source: AGHT+IGfO2pJun/3VaXEGR/cSUgDbyi2BB3bR5woAlii6atjXA/ViMnSQv+bSKMNGkd5smTOdNi443z5JMS0cuxDOgM=
X-Received: by 2002:adf:ed43:0:b0:33d:409b:5738 with SMTP id
 u3-20020adfed43000000b0033d409b5738mr3887358wro.26.1709413743549; Sat, 02 Mar
 2024 13:09:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeCXHKJ--iYYbmLj@krava> <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
 <ZeGPU8FRqwNuUJwd@krava> <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
 <ZeOQOE08x0fUpA7d@krava>
In-Reply-To: <ZeOQOE08x0fUpA7d@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 2 Mar 2024 13:08:52 -0800
Message-ID: <CAADnVQKPmJxya14T=BPTK3rfy9sOYMQQ6-oaNHcBtJa5z2nQ=g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: yunwei356@gmail.com, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Oleg Nesterov <oleg@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 12:46=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
>
> I'm bit in the dark in here, but uprobe_write_opcode stores the int3
> byte by allocating new page, copying the contents of the old page over
> and updating it with int3 byte.. then calls __replace_page to put new
> page in place
>
> should that be enough also for 5 bytes update? the cpu executing that
> exact page will page fault and get the new updated page? I discussed
> with Oleg and got this understanding, I might be wrong
>
> hm what if the cpu is just executing the address in the middle of the
> uprobe's original instructions and the page gets updated.. I need to
> check more on this ;-)

I suspect it's all working fine already.
Only x86 is using single byte uprobe.
All other archs are using 2 or 4 byte.
So replacing an insn or two with a call should work.

> I saw this as generic uprobe enhancement, should it be sys_bpf syscall,
> not a some generic one? we will call all the uprobe's handlers/consumers

yeah. If we can make all uprobes faster without relying on nop5 usdt
then it's certainly better.
But if "replace any insn" turns out to be too complex
we can limit it to replacing nop5 or replacing simple insns
in the prologue like push, mov.

