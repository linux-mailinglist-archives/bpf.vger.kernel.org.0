Return-Path: <bpf+bounces-40111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD22697CF91
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 02:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6013A1F2572A
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 00:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9755EC4;
	Fri, 20 Sep 2024 00:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2TyFKWB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C632636D
	for <bpf@vger.kernel.org>; Fri, 20 Sep 2024 00:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726791220; cv=none; b=fHDxdS2w+tTcmlZbGugzCHsy53gajXVbaBZoyWad/5Ggat9SGHhWBWcNG7Ou1MsWVbXJ6JZH0VfVXyNk+vU2ke1h/5pBEdRMPpd5uptMkuU7qF3J5bnnwakT7qoN48DfzGWDGK+qyHPqz8NJNAIAg/ImWHb+7xmbCrKZXypROwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726791220; c=relaxed/simple;
	bh=cgW+dFKC/xkYkFIpODmEaKl+l7c0FKHGOEhU4Nr5eqs=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=Y67RpnB+wBYCCqvsFu2Mb+CK+LiqudGE/o2FuztnrnXnOGSGSCl+vfHLEo1e9i63z/1adfT4zTwymRobRJmMTE3N4jpfRSt3Sd1XMDgcREjBfsW3L39YEQ7VEFRemeHm5tQ2mKVtzPcZkDBaHeI8pN1b1YEUjP/o6I231U29QXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2TyFKWB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso11493225e9.2
        for <bpf@vger.kernel.org>; Thu, 19 Sep 2024 17:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726791217; x=1727396017; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:mime-version:subject
         :message-id:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fEizFaqqVm2V8DQJk8ULPTfOPs94QeCIfJgPSVXTRCI=;
        b=H2TyFKWB0hux8iS5UuN/4WWaPErtEUdkqvGoYfrEBLNKwC8SQRrm5q3hJfss6T7tJe
         g6H1lS/hj2iXjDJI3713V3GAk/i1lOhj7r6ugonIoClGgFx6iKbQKPiWJP7Ja5etVekv
         ttLRvHN8QwAgizqoaVaCyGBqbr2FROaiUdfwDrT+iBW4S71LKDCUw7HkZYzhKpipac+N
         8jzXoeXYpHRpY/iA5Ga26uahZs07tNFi5aRX6TRTqm0ETbp6/5DPb8XOTNbXPDX8vtlY
         hhPtMN1qtVKPaW4T4stYD2FuWRtq98p+yGxqoyBvqCpUg3Ur2ApRW6B6EVI+kK+M/o9r
         xRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726791217; x=1727396017;
        h=content-disposition:content-transfer-encoding:mime-version:subject
         :message-id:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEizFaqqVm2V8DQJk8ULPTfOPs94QeCIfJgPSVXTRCI=;
        b=J2SPGnSN7F5g7zQT1FscISuqN8H9EXlfchbsSBEwvMf6NFyupT7UAxQAdjvFw+YyjH
         amdkrN+dWm/TcH+hsXzQVxN2KRD6PBWOqpvo9v8KEswYtXiKMyTVkkknYNodd1/tnOIX
         Pve5Iorq5CctYqO4m+SwP1LqOXtZzjCpJI+S8tePAhsxhAgLVlaqjDw8aCBDlJhWpSd6
         2CK63uLFih8hai6iwtgpFNyTR/WEWayhdRFlAFfbCdmndpUZ46276O5uAAj72Zn3EzP8
         OXKZkUOBJyOhrduhYQ4W1Qo9NqR9cMf/JtXhdK0mRXnZnHk4pCQbunRxzT5o1oRcFlxL
         d7uQ==
X-Gm-Message-State: AOJu0YwTcNqzZbIXECFXc8O2zCF0yoMQp50+kni+GvlmZ1Qo2PxNtbuT
	n7vLs2b863iJ/sNGi2zXU+uoE2gRizVKaHz7wG6Rwty1pFPwRigNMO6Www==
X-Google-Smtp-Source: AGHT+IEoyx85GPAfXVwPI60mt73nyeeEOgLqw7SSmp+2IofwSYtdP6gzq/3tTpc1kNj+AZeiYdxGSA==
X-Received: by 2002:a05:600c:4f55:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-42e7c193efbmr3591255e9.26.1726791216865;
        Thu, 19 Sep 2024 17:13:36 -0700 (PDT)
Received: from laptop (a95-93-247-17.cpe.netcabo.pt. [95.93.247.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7ae5fce0sm8020835e9.10.2024.09.19.17.13.36
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Sep 2024 17:13:36 -0700 (PDT)
Date: Fri, 20 Sep 2024 01:13:35 +0100
From: =?utf-8?Q?Sebasti=C3=A3o_Amaro?= <sebassamaro97@gmail.com>
To: "=?utf-8?Q?bpf=40vger.kernel.org?=" <bpf@vger.kernel.org>
Message-ID: <0102A73F-5317-4412-8E74-921CF146531E@getmailspring.com>
Subject: Maximum amount of uprobes and uprobe and uprobe_ret relation
X-Mailer: Mailspring
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everyone=21
I have two questions related to user function probes:
=46irstly, I am trying to have a process attach more than 1024 uprobes,
however, I am getting the error: =22failed to create BP=46 link for
perf=5Fevent =46D 1023: -24 (Too many open files)=22 even after changing
ulimit -n to 4096  github issue=5B1=5D.
Secondly, I am running some tests with uprobe and uprobe=5Fret in multipl=
e
functions in the redis binary, but I am noticing that when counting the
times the uprobes and uprobes=5Fret are called, in the end they do not
match 1 to 1. Either individually (a uprobe/uprobe=5Fret in the same
function), or the total sum. Is this a predictable behaviour=3F
I am tracing several functions in such as =5B2=5D.

=5B1=5Dhttps://github.com/libbpf/libbpf-rs/issues/942
=5B2=5Dhttps://github.com/redis/redis/blob/3a3cacfefabf8ced79b448169319ce=
49cca2bfb7/src/rdb.c=23L1782

Thank you, and Best Regards,
Sebasti=C3=A3o Amaro

