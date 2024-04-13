Return-Path: <bpf+bounces-26709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5DF8A3E9E
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 23:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED567B212DB
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 21:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD64555C33;
	Sat, 13 Apr 2024 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="L+3ziR5M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BxcOiVpp"
X-Original-To: bpf@vger.kernel.org
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FD91758B;
	Sat, 13 Apr 2024 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713042792; cv=none; b=LMA98hAA03Qr5+z5edmX9gUBlTYkgkw+apxeY5B/oNoufnTIHr8u+5OvhJSiCS+wi1lTbrVjc437xQ7fKq4v8yZ8MRVdBptYtxaXqwODvQ+dMVgiHatZ+Di7cZk1mpEmPfOsiKSxjH6UorVium7YMV5+sM86WK5BXCvv+of/EEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713042792; c=relaxed/simple;
	bh=JNF5t9XmqxCv4XZMxVJkYpXw2NzoexaqKIvwllIO5Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6IGr1VO1j7PX+SuE5gxFjJL4m5zJLIWuuDExqHNwfnFZMdCHN/DFRmhurDtYWOXyKnVP7R0cps78P5voWxAX0RxIGKr7nN2Fz8q3SYduDP+aFMfB5CR5xvl3qs1Y0UASNqcmrrcKKEnNI28j0GRBdL+XuT24GOjg9PcWHxgTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=L+3ziR5M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BxcOiVpp; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id EED971800123;
	Sat, 13 Apr 2024 17:13:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 13 Apr 2024 17:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1713042785; x=1713129185; bh=AcUdTy9bE+3uK/JKyP4lv
	iW/sR0ay5Ov179BxHD+sbU=; b=L+3ziR5MF9BPCH7DBDw7SaKnJWOALX1tr2bcF
	+xwatLVAzMhELxbxjzMGyzES9oaVnfK99O1NNFMtERdpgk4oEj4TksLSYgei88EK
	aiR6mqdzNVAWJzQe/aS6Jhu7bpdDiAVVDVoJLOWrep9dv2Pnp3bY80hyzoAeffUY
	uh6srQ6DHoWnpRrbJC6O+zqbjEH9GF8lJyb1QcLech/lRe0iAHxEoHVSJJZsF4eW
	RY4D1oBwY9uuxOCHna0w6yVFH8U32GJFpbNOZAjwY4sVfEe7ck11uHNnT/0ZlryL
	N6AJtZvy4+CUDGbFoa293lZhtp1c+Vntny032YY8YhnKX6HjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713042785; x=1713129185; bh=AcUdTy9bE+3uK/JKyP4lviW/sR0a
	y5Ov179BxHD+sbU=; b=BxcOiVpp+Uz6R1uJJsFWaHq31Qojafjjm9VXufy+P/vx
	lnRaBVXkMr6Mk2xVmaJ4uYxRCkEGjwUmtYGAAvCnaW6hut9DCoxwUdrYPjnR4SOt
	fKO5g8yXQopCZRYSoldsYSOIjLmYOd5U/OHeF9CCmfuFdx7PunGvhqSyCHlsag5p
	5cR0xj+ykbIIaQF6IBEmIJWTtG94TsPa7xw1Jl+hbl6zYeM9wzK1RPaz19lPO5fi
	CB9aWz/S1Yl57wCMEeidxrsMMvopV4OePN58cX/1XqRfP74P01WFt7JcDeShWjb7
	GWTn+lIv63WEmlh7EEUgPnRFg+Rtp7KTzHL9tM9vMg==
X-ME-Sender: <xms:YPUaZtSZpQUfCKiOafz5Q3fbrL53kc7FlCLCgeq6tsU61wh2NaAXXA>
    <xme:YPUaZmwTHR-80Bw6pK87lRtNpfkrpWxc-jmBLwLvIbrXVmZgjM3GfPLVWCNSBIWXK
    lBUDk24VmdZRjgFkyk>
X-ME-Received: <xmr:YPUaZi2lxOXQHDBw5B-7jFFCjq3agAShR1H7mthsHYRxxqFLU_DrEawKDSbISTvKGo2VZW40M9i_Kjc3hQ-4LylSa9k4oBMQyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeiiedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefsuhgvnhht
    ihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrghtth
    gvrhhnpefhffeiiedvieehgeeljedtueeijeelgfffjeefheehhfehffeifeegudfhheei
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehqug
    gvsehnrggttgihrdguvg
X-ME-Proxy: <xmx:YPUaZlAugBHHf9IqS_vMybABBKS0t2BvrqmPMSdVJGiN49N2D93_wg>
    <xmx:YPUaZmhcM-ucvPoS_kLAd8mUzfNUYpDXllmwd7fMEHW_M85RG8lqJQ>
    <xmx:YPUaZppkqiocsFo8qc6dlQ5Ej15t-NkkxDMk_D-mg8IyAwyLjucEoA>
    <xmx:YPUaZhjDhP1fUSIOVmtvXRSfqJOFT7rXVP9oJHE29u4uQOmjpLO3GQ>
    <xmx:YfUaZtQmZ3iG9cnyhEYRAdagx6rX9A2V5L4hkqmEjSU6N8HZgZMW0aOt>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Apr 2024 17:13:02 -0400 (EDT)
From: Quentin Deslandes <qde@naccy.de>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH 0/2] libbpf: fixes for character arrays dump
Date: Sat, 13 Apr 2024 23:12:56 +0200
Message-ID: <20240413211258.134421-1-qde@naccy.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch #1 fixes an issue where character arrays in dumps would
have their last bracket misaligned if a '\0' was found in the
array.

Patch #2 fixes an issue where only the first character array
containing '\0' would be printed, the other ones would be
dumped as empty.

Quentin Deslandes (2):
  libbpf: fix misaligned array closing bracket
  libbpf: fix dump of subsequent char arrays

 tools/lib/bpf/btf_dump.c | 5 +++++
 1 file changed, 5 insertions(+)

--
2.44.0

