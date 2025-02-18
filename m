Return-Path: <bpf+bounces-51835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7562CA39EB1
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 15:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54823A9E52
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 14:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABC926A0B9;
	Tue, 18 Feb 2025 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf7WanvY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E79269D1E;
	Tue, 18 Feb 2025 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888634; cv=none; b=ZD130P54QN3TccABtPkhb9Mgan1PQxPCrXE2Wg8JKaFe2QriiOFXoZhfoNPzNCqJoAx7Cg9j/8ahHuFu1Gc4nrzFZfIFXv5gy3am4rjP3xw+q+YR1a3sNc2SW+rUwiYNVX/IJEEgNA79+tWU5BMYVumkIq6rwkP8rLA1wdJYl8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888634; c=relaxed/simple;
	bh=Fc4q2dPmm2rmgBkiZZBJNkeBDX7FqdFxkxZ2xDYv9zM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ph1nPkKEZtgLSMTnurW53VisOmi6KWbej4XoA5Y+vAC/lof82kGCMOWHD5HPsvKiZxcp6aHpvy0fdj5Pq90hsoeHnGxq1B4QP+b97jM8AI1sx/UdCB+rIhX/LmrEiKriYnQB6AJzvbth3fs3KyQabap6DhTq7Za0hg2G4UES7RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kf7WanvY; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c04df48a5bso470432685a.2;
        Tue, 18 Feb 2025 06:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739888631; x=1740493431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsS6leCR00jwku8Y0sXRsktKF8hhSwpuVjE0bMKPMG4=;
        b=kf7WanvY/mM0mwgLsh8i1VIkgH9E34JagmvGegnGcThLMTTwgkBHjgWOrL/RY0Z6Kz
         IPTAlwJ+sAVLRnQ+unKFb3NXZh1N5TWz8kVNsbVKq0p1eF7zU3UtOdp02NtkfveeDqUO
         B3EaApkzfa1mEEwGLLcGamj1+yfssyPnvIa0Lhy9lnAmh/fcMAzjm1fR/eN6qA608Zr2
         F1N2fBhm83gfXDoSm1Zyg0byOWYJaXF4v5DRz89HQPRXsGGJtlNMoBmfSjN0H0DHTLMx
         YrAILpUH95qONBFD4nHSYVWj/7pSeIhrdBvXPGcS04wqOf77XaMqEXtNgGnR28M0h656
         9PbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739888631; x=1740493431;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zsS6leCR00jwku8Y0sXRsktKF8hhSwpuVjE0bMKPMG4=;
        b=Mkao5tdEJj7uNEYY7UPHpPMJYVXt6tzVK3/niozOtP80CP6oZXXCdVJtTEsQ/BaLsQ
         crXgMjiiBml1XY1dgIkztuz8I7YVfmZqb0R4Ntj3O0+DqNu/NzWgPe64E/O04G2dXlzo
         BWf1xlGgpdcr/BTNUMax+r4t9wxJqkk2CslXzzERMAt+KEJBu7PgndCgjlVs6bwhlIYq
         6+WcNVhDuyy1+c2FVtqBnYpflyqC0Eo2g8ZI6hvZ7wAte+IPhkZqneIoXJgKhlzAmlJk
         LKrH2ry6DexFWy4RKhEdMr2t7eqadpgK1J6XP9EGl5LBCDzVdnJAMvry8+mrcv2D0bPT
         At0A==
X-Forwarded-Encrypted: i=1; AJvYcCVYTAkHzvsesCuOogfhbBx+t22HoisLiG0QS5AUMZwFAWrplQkszWH3EN8i3c+A+uuRvZvTiSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66UU9weZwqyr58Dw3SICC97/ccx4SlGRSY1C3Wt1L3g0Gpiwp
	FBA8nIcBDeyUmIR5Cns9Ig0rY091fRjVvXrJoeI5xOvZDRvXlaeK
X-Gm-Gg: ASbGncsj9QmMIc9HpQLKupHU4JQHrXaHYFvyp+jveU1yJ7a9kswJ1cay0ZZuRNcTgsq
	IyWdXxj5GwMX3wU6RhKX0ejdGlfk6fj4NplYNZ8jGPglPlhknmzDX1/a1s3pEkgtQZVU6WzpDzZ
	54nH7x1EK2dzytNIT+wvLeoxtPHoZYpkybpFNdAp59vm2HFjtS8q5B5SJwQpoX9Ef+ILNKmdCSU
	WHpDpwnDbqtoM3x3Oxd5jTiOrCHbdJcM4Gi67HbYF7811c+q9lYQEAP5k6xUaxwefie1SYmTJno
	f14tZi2nH4E4TjBVdouHvRjwF5Ijv8dmr9zpIG7jPv3s3SVV/YXVO0xp+Tg6zYY=
X-Google-Smtp-Source: AGHT+IGvkSfAuMWXwIdWOAssMx0EwVamRsvQa8444B29QcdEIa1+ZijEKXuvl5Y3J7tEmFJpwvkc4w==
X-Received: by 2002:a05:620a:3905:b0:7c0:87e1:6596 with SMTP id af79cd13be357-7c08a9f83dbmr2068350385a.34.1739888631366;
        Tue, 18 Feb 2025 06:23:51 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ac61574bsm103636585a.112.2025.02.18.06.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:23:50 -0800 (PST)
Date: Tue, 18 Feb 2025 09:23:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67b497f662c8a_10d6a32949f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250218050125.73676-9-kerneljasonxing@gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-9-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v12 08/12] bpf: add BPF_SOCK_OPS_TS_HW_OPT_CB
 callback
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> Support hw SCM_TSTAMP_SND case for bpf timestamping.
> 
> Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. This
> callback will occur at the same timestamping point as the user
> space's hardware SCM_TSTAMP_SND. The BPF program can use it to
> get the same SCM_TSTAMP_SND timestamp without modifying the
> user-space application.
> 
> To avoid increasing the code complexity, replace SKBTX_HW_TSTAMP
> with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous callers
> from driver side using SKBTX_HW_TSTAMP. The new definition of
> SKBTX_HW_TSTAMP means the combination tests of socket timestamping
> and bpf timestamping. After this patch, drivers can work under the
> bpf timestamping.
> 
> Considering some drivers don't assign the skb with hardware
> timestamp, this patch does the assignment and then BPF program
> can acquire the hwstamp from skb directly.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

