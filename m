Return-Path: <bpf+bounces-40405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57529882F9
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 13:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB461F22900
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 11:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767E718660D;
	Fri, 27 Sep 2024 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPYqwTyC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0702A185E7A
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727434889; cv=none; b=TTsmXQoS0gbqtmQXumNLklXmapaccPQbpohevpEJ3lD+SazZfg/DaBAMd14KF7eW/JI9EZNartJmwnD1RCQVds6UADdVVf3+S7SevzHkPS5+fK9d/vsTi0Qrp+J86a+xAWCgMyEMdoqwVdWqyF4PyJcCv/8+Ceeejfu4z6LgLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727434889; c=relaxed/simple;
	bh=CWmvpzhaW4DtQzVrx5o+jQ5uplnK/v+wfPzUsePYm70=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=rajy9FHEdolQV+0Fg85csADnAA1FSg/c2NfiBkp/Osa0oTGvhtujXPjzLJHEa4t1K/uKkOXGRbu9+A3cnuD7x86IZc1wEfT0tenWzpuD5WNt2sL9dpkFqA/nOHdSFR+m1+HIwGkBo/P3RReBAwk32UYXQb3rgwJvTkvsgpdhmkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPYqwTyC; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5365aa568ceso2484153e87.0
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 04:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727434884; x=1728039684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CIZze0CeQE4xVMZqZAfzc7Y8Xfi0VbWwb75BpeDtVPc=;
        b=cPYqwTyCUv6t8kBuJgjo6fcB+0xD7uKxJ1+mLKqT0zwvQ6gHI9+w84gdA6NYs+kXCJ
         7DXMv4qFwrxS92KaMp6JXN9XPeAg1whRcqo5fE2tXqZWgmZtgYnc+JMGwcTLKuwj1NkT
         hA8JRXO71iRzNtv2sG5lC0OHv+Nt+1JO/E2Q68k/GEk+SOfTViq2Hbrsb8mMx4M/sSkQ
         xA177nuNrdMEUPK0UVZeeAtFA4Lguiv4lUE/ELvEc9vwddHwGxQgs0X2GCVgu9eiBRz7
         2i7XK1V5TuxCO2p/MFeSqnq9ueu0hUJ1ZOvepZ2f3U809Q3P/P2TdMF3BJqGOxVkMQzr
         6RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727434884; x=1728039684;
        h=content-transfer-encoding:mime-version:user-agent:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIZze0CeQE4xVMZqZAfzc7Y8Xfi0VbWwb75BpeDtVPc=;
        b=ngTroBAcdOP+joDqjVntYe+UDbG2edNlxeGqxoRNqkli7gY+QZI7wHMMUeUL1aBuUI
         75PNurFnAD1S0kqi5VPo5621BNxhZJ4gdFVl6RlzDLJNvajJEYw/0GyJ0M9FTJrOqNX7
         gF9KnWMIZCVil9233U39eUMjeCBVilCqCI2POdLYdAHzUKl6tN+1dPfjvLTaVyzC9XrP
         UjCoxkmGYoyXTkuI//fnfYIKHaqHqGvm9y+k0Cnsg4dZou44XYal4QbmqTswvUbA5GP6
         iYMJZuVWMA6CIJ2hfdeibok/k7wzYX3TAY7DFwKHZaGuGF2UQoqKy0TEyUn09dyxRbJ4
         wtSQ==
X-Gm-Message-State: AOJu0YxVgXmXxwdfif6SQR91jXtbsTsE+JPRVsvWT1be9aDCzbMG6mRx
	2Qfyo6zUXsAVFxXzGw0+L9slznGKAhN5gCBHGWITr0hyEyqznoZrpFlOhg==
X-Google-Smtp-Source: AGHT+IEAbsy/QNDPvC+fjQeRv8BSNhvRwOMeTz71QAh3xcILFTOmS5bpRGVKM37wDG2+4adtnEsoYQ==
X-Received: by 2002:a05:6512:2207:b0:537:aba1:16be with SMTP id 2adb3069b0e04-5389fc7d1a0mr2559516e87.46.1727434883369;
        Fri, 27 Sep 2024 04:01:23 -0700 (PDT)
Received: from gadelshin-ri-nb ([195.112.121.13])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a043ee88sm265821e87.242.2024.09.27.04.01.05
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 04:01:08 -0700 (PDT)
Message-ID: <3aa5a79c15420a836cb60b6eeb090a11399146f7.camel@gmail.com>
Subject: How to read tcp_payload from kprobe/inet_sendmsg
From: Rinat Gadelshin <rgadelsh@gmail.com>
To: bpf@vger.kernel.org
Date: Fri, 27 Sep 2024 14:01:03 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hello there!

I'm trying to read DNS queries from kprobe/inet_sendmsg and
kprobe/inet_recvmsg.

I just copy data by

bpf_probe_read(&memory_in_my_map,
               size_from_kprobe_arg,
               msg>msg_iter.iov->iov_base);

It works fine for UDP (I'm checking by `dig @8.8.4.4 google.com`)
Buf for TCP (`dig @8.8.4.4 google.com +tcp`) the payload isn's a valid
DNS request.

I'm using the same method for reading DNS response from
kretprobe/inet_recvmsg (arguments are stored by kprobe/inet_recvmsg).
Receiving DNS responses works well for UDP and TCP.

I've found some related but unanswered topics:
- 
https://www.reddit.com/r/eBPF/comments/15fh3n4/accessing_the_content_of_tcp_packages_in_an_ebpf/

- 
https://stackoverflow.com/questions/76782000/linux-tcp-packet-sniffing-with-ebpf-kprobe-reading-package-content-from-iov-ite

-https://github.com/replicatedhq/exfilter/issues/8

Please, tell me, what I'm doing wrong.


