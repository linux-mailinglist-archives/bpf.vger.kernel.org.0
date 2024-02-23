Return-Path: <bpf+bounces-22623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A099086207B
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 00:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FA51F24FFA
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 23:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BBF604D0;
	Fri, 23 Feb 2024 23:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIq1OGgu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA3814DFC6
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708729572; cv=none; b=e4SPVsUVDFW/K3cZLjqqsQBwJO2RrlXPmouNJJ7YCWS0RHDPKrGwvoJWShBAvHEwyZEHGClMUw/JhPDIVuyrMSm9LBCWSJl/hKbHi90EeeP3SancTLwGwYy4xoip4fZjHwdNH7vL//EoCNSqmFsFwQjIjzyytPpKa/+j/r4qRWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708729572; c=relaxed/simple;
	bh=IUr132Pk6eJ50K80IPLj6eF4575nQ2pN5B5uCokP2vI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ra6bD0J80b6zMBA9X7o7IZURzddlMHuXI/bstxjPxQLA5ecMvyLhJ+ewCHmR2wyTjIZeZIz2gZOJ3UmonLVSi/w8GVYqJhCJf7s324scuIAc9AslKG6hduWXXPmMzn4EwLPjKQ/LivYh9WKJZB0CoAIjSSGrrBUwCIERZGP9tYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIq1OGgu; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-599f5e71d85so925628eaf.3
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 15:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708729570; x=1709334370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IUr132Pk6eJ50K80IPLj6eF4575nQ2pN5B5uCokP2vI=;
        b=ZIq1OGguWb0p75zbYx1SOwtMO0j907GJpCvb08iyn1pe6XUS9e0m72kQtAYIcu2HEx
         Rt1uK6ifJnLQsT/yruN6pftpkJ3bUQoWJVbCALn0ip69cq3kj4vW0MFOYqvzOQoFBLSp
         unCUtv10f4sbWQaLWK48AF8aXiieoVWpB0U7d8392XXjrA7QDag7K7qtkXiin6fX7dIq
         RsIIwL9olNclsrkde4paiCgzv5fD5CwzR4bc1VfmMIrNoxFQcVCNqrwSwcrWr+yvvXnZ
         g2hRvq/8j3ArnmOQouquOg6GI6ehI7DzZcozrBV9338o7kYlwmqa5aFLBpwVfquYyTZF
         n7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708729570; x=1709334370;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUr132Pk6eJ50K80IPLj6eF4575nQ2pN5B5uCokP2vI=;
        b=mW8rGkV+TEz+tUFwkPu70pPP6MeFVgMLFxpgqyJ+ypMRf7X4H+L6PjDSmf0pvWxKHh
         KB3wG5pMVCKC/MoxKjdABXmFjhcGlz8tog7gSuuAPk3zFHa6UA0n/vX4GrVT6UM2mEF8
         p1TnHpD88ce7+SUwi+Ad0635RVdMdsVqyzB81BFzevuWoGBiNXv7Sqkb4Jr+21Qrr4lz
         Z++EoLr8wCIf788J1j2rklwwES5cKWimSpGexx0HwJHYld4Pul0R5ZUE5J9nOc3wV1Vl
         UBC/BeEXu+s+P/GK2pRJjPSPBbqlW7mfvASXHxzICWCtZ/oYcID1gLeMfoSOL0FvK3YE
         9ekA==
X-Gm-Message-State: AOJu0Yz6SBpB1O4dBwgQusQPtegqsyfYtT/wswaU8gcvK0kHlpi4WyAz
	ApFjUakLrVjjHnsSHP90dSBIskjOcSscHki4QblZdGFw5AGO7J+hsv560uEazjEvBA3InUyMRZB
	iJephlK4WEwRi6fqV1jgxxmyWuOA=
X-Google-Smtp-Source: AGHT+IFY+uh3ZwiigjmJFfFCdZ1h+IuEgIxIK1Gj/u54yGcB4Fi6/FU7v9/SHulsi5rdgS9PBRM2jVNlDSah+jsAOCk=
X-Received: by 2002:a05:6870:4c1b:b0:21e:b125:d363 with SMTP id
 pk27-20020a0568704c1b00b0021eb125d363mr1520128oab.56.1708729569929; Fri, 23
 Feb 2024 15:06:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Fri, 23 Feb 2024 15:05:59 -0800
Message-ID: <CAM_iQpXzAYFES62Cbj8PoGqr_OW=R+Y-ac=6s3kmp5373R7RzQ@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Inter-VM Shared Memory Communications with eBPF
To: lsf-pc@lists.linux-foundation.org
Cc: bpf <bpf@vger.kernel.org>, "a.mehrab@bytedance.com" <a.mehrab@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

Hi, all

We would like to discuss our inter-VM shared memory communications
proposal with the BPF community.

First, VMM (virtual machine monitor) offers significant advantages
over native machines when VMs co-resident on the same physical host
are non-competing in terms of network and computing resources.
However, the performance of VMs is significantly degraded compared to
that of native machines when co-resident VMs are competing for
resources under high workload demands due to high overheads of
switches and events in host/guest domain and VMM. Second, the
communication overhead between co-resident VMs can be as high as the
communication cost between VMs located on separate physical machines.
This is because the abstraction of VMs supported by VMM technology
does not differentiate whether the data request is coming from
co-resident VMs or not. More importantly, when using TCP/IP as the
communication method, the overhead of the Linux networking stack
itself is also significant.

Although vsock already offers an optimized alternative of inter-VM
communications, we argue that lack of transparency to applications is
the reason why vsock is not yet widely adopted. Instead of introducing
more socket families, we propose a novel solution using shared memory
with eBPF to bypass the TCP/IP stack completely and transparently to
bring co-resident VM communications to optimal.

We would like to discuss:
- How to design a new eBPF map based on IVSHMEM (Inter-VM Shared Memory)?
- How to reuse the existing eBPF ring buffer?
- How to leverage the socket map to replace tcp_sendmsg() and
tcp_recvmsg() with shared memory logic?


Thanks.
Cong

