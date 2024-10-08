Return-Path: <bpf+bounces-41283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9B199570B
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 20:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0231C2506D
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 18:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273EE213ED8;
	Tue,  8 Oct 2024 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5c3/a3c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2858A212D14;
	Tue,  8 Oct 2024 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413068; cv=none; b=Kjfs1/hPju/pib/9GppYoKlxco143nYvce9DISiih9co/cvmQzQRYovFpqEiHk+tT0CNEuxWtw9NAFHpXogdCTCCuBLbs2oe6L3UNu+c4kv6iTu4rEtZKZ4jCIltamVP4xeY14arnlk/VbhztSnOd29H0+GB9LRZLChe8KOQ4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413068; c=relaxed/simple;
	bh=TivTezLE8LhIRj9m2G4XBM4yS5WMN6WH66vTO/wWrPg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EMfzBKPyAC4i6l70WkAxObKPipVOX0S5v8JlyOBFSYfi7RBLdVmJta8Gp1P2OH5fhR/doBife6dE+Z1VPVTl5Kh4UIMQa2b+vmOaZY6XRmqMIsUEj3U1vvyRl74aWNAtJSTJ8PV7Kw2ClURxLGg6UyOOrKs44OU1Nl8+onu/pzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5c3/a3c; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7acdd65fbceso470176485a.3;
        Tue, 08 Oct 2024 11:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728413066; x=1729017866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InAOaQCuGl/0vp9ync+X8CL0PtBa+VoZt94jzIJDvUo=;
        b=H5c3/a3cwJtt0SzuEsZKjRgRu2cW4/OQVTVr65x9KMuMAVIgGT/t4405QAodahhSxP
         CAg0kyyf2vK8MNaD69gY0KQohHinda4lPNwdTc8FHhYz+u+rFP4m+qm5lIRRJsbRAh31
         w4YmGxkNpoptAnh/Owkhym3tsip3cM9lBDvELLA8VP8ln7GBadSHM4eiDEc0lLbSvsEB
         ITPfQ2WSadbPyXwTJ0KJMdaktJoYLqqtTCyViJ3hyuBhWF2Xy10asStMCxCKtmj7UWD2
         UwPxwJtPjPEZ8ojK/8h7ns7A1llcsW+67BkaVxvFygBkmfSEcu560GXotdunTnXErdTc
         Jjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728413066; x=1729017866;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=InAOaQCuGl/0vp9ync+X8CL0PtBa+VoZt94jzIJDvUo=;
        b=YkjVT4Po5uK63PCsgIgM+YwCcK5vOcn51eWDn17Lj5gszuTay7QBM3t0iwJ9Om8nj6
         DZTLqcaDueM8aIpaN3jJxbBCV67R5zlnP3EKc0/FovTz7Ym7AvHWlZXjBNdrUOT1Rlbd
         WzwLkJERpRyUXp0kG+CZ76YoMejCk13HcMEJEP6FwNauwOZFYNh7WFVzxDQ68o2/KOtT
         0MvEWS2eUF5la2l/uAFvyDOST2Zsb87YiDuUBrBRz6N7u0lMLdFW5TS4g1g2gsi9fMVS
         pENILV4fWczNNXqkhhlQq6AoRbIHBETh2dSBZQ+fRflKX7D9A3dfB+V7zDBbacZt7MnK
         78mg==
X-Forwarded-Encrypted: i=1; AJvYcCUrKZwIYKARHuxmJjTCOSwpgsJ7PnK3PdkM77W9w3s9wNQ/0Um8zFAGZHGiR1vJkX/oO9650O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMf+Tjzu+1VTOu8mpkM+eeoyhDca8nhpjzV5Bo6cd1/CSBKcvD
	+BCNvUmPFZE3dbUSFxhokmPtWy9M7CXKQAc5s7WAbZzctsFJ6SmT
X-Google-Smtp-Source: AGHT+IE3ItsYp6v8I+okEk5EedzTcSLYsNeVWrI2go3bRqoBTbXE3G5JE0piChtGUBamLKOd8O1jIg==
X-Received: by 2002:a05:620a:28cf:b0:7a6:674d:a32c with SMTP id af79cd13be357-7ae6f42174dmr2367985485a.10.1728413065956;
        Tue, 08 Oct 2024 11:44:25 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7afcf404084sm19557185a.132.2024.10.08.11.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:44:25 -0700 (PDT)
Date: Tue, 08 Oct 2024 14:44:25 -0400
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
 jolsa@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <67057d89796b_1a41992944c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241008095109.99918-1-kerneljasonxing@gmail.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next 0/9] net-timestamp: bpf extension to equip
 applications transparently
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
> From: Jason Xing <kernelxing@tencent.com>
> 
> A few weeks ago, I planned to extend SO_TIMESTMAMPING feature by using
> tracepoint to print information (say, tstamp) so that we can
> transparently equip applications with this feature and require no
> modification in user side.
> 
> Later, we discussed at netconf and agreed that we can use bpf for better
> extension, which is mainly suggested by John Fastabend and Willem de
> Bruijn. Many thanks here! So I post this series to see if we have a
> better solution to extend. 
> 
> This approach relies on existing SO_TIMESTAMPING feature, for tx path,
> users only needs to pass certain flags through bpf program to make sure
> the last skb from each sendmsg() has timestamp related controlled flag.
> For rx path, we have to use bpf_setsockopt() to set the sk->sk_tsflags
> and wait for the moment when recvmsg() is called.

As you mention, overall I am very supportive of having a way to add
timestamping by adminstrators, without having to rebuild applications.
BPF hooks seem to be the right place for this.

There is existing kprobe/kretprobe/kfunc support. Supporting
SO_TIMESTAMPING directly may be useful due to its targeted feature
set, and correlation between measurements for the same data in the
stream.
 
> After this series, we could step by step implement more advanced
> functions/flags already in SO_TIMESTAMPING feature for bpf extension.

My main implementation concern is where this API overlaps with the
existing user API, and how they might conflict. A few questions in the
patches.

Also, I'm not the best person to give in-depth BPF feedback.

> Here is the test output:
> 1) receive path
> iperf3-987305  [008] ...11 179955.200990: bpf_trace_printk: rx: port: 5201:55192, swtimestamp: 1728167973,670426346, hwtimestamp: 0,0
> 2) xmit path
> iperf3-19765   [013] ...11  2021.329602: bpf_trace_printk: tx: port: 47528:5201, key: 1036, timestamp: 1728357067,436678584
> iperf3-19765   [013] b..11  2021.329611: bpf_trace_printk: tx: port: 47528:5201, key: 1036, timestamp: 1728357067,436689976
> iperf3-19765   [013] ...11  2021.329622: bpf_trace_printk: tx: port: 47528:5201, key: 1036, timestamp: 1728357067,436700739


