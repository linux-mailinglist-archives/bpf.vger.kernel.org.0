Return-Path: <bpf+bounces-49618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6424A1ACB3
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 23:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25FB716A93F
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 22:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B14A1CDFA6;
	Thu, 23 Jan 2025 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zeaf0PQ7"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910551B4150
	for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737671534; cv=none; b=cP0t8c/h8v4noYtUVIZf+lJmuOv+zg1CShgEFJSZsz0LG5FFMYc5972UlTFN115WcN2/6HAfxV4XtHxidBlrC5Vy4TiUABdH9pn4eeLBjztjc4tKcojx2pR5OT1bQgO9TgI0u2HVDYnGZOGZ11EVwYFFfK9quZrnCrtPCQvZ3EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737671534; c=relaxed/simple;
	bh=FGOuPO+H6o9dOs6lU7snx0iLO684KQtco5iZApuRNHA=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=pL+QQTWI+4lugoMkLfnPBW8KAnFCbjo1vYyKyBX+1flz37GgBLG29LbgMfuU/vgJH9LYCb/GqFhB950BsdsHD+hmKGWHedZNqaEc+iroLqMOHawfe0tbUmo1xdllIJcfnt23GnqSbGVwKwrbBz2mwwBfQZtGtNeVoVIS0J8yfAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zeaf0PQ7; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8a6ee672-26d0-4213-be5a-7660d2bfa868@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737671530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YePAs4AMAqQAOQAtmYiqqvx1YpvkRPTnNXZ/Si3Fv58=;
	b=Zeaf0PQ7J1r7abgpFymFUnGUtoNV7/f7RWn3pdu8tSPunzBc16IAiVIBjmiOSNcXI6d4Pv
	sHCvXtJCgVcav05l1V6zX7bytFt7CcNzmxPkyKbIGl+pDbzemDaqpufa6Yc7Gu2ra5o6QF
	VyxbxnwOS5RtXJ6zbvhF+ISoheJKE1M=
Date: Thu, 23 Jan 2025 14:32:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, bpf <bpf@vger.kernel.org>
Subject: [TEST FAILURE] bpf: s390: missed/kprobe_recursion
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Jiri,

The "missed/kprobe_recursion" fails consistently on s390. It seems to start 
failing after the recent bpf and bpf-next tree ffwd.

An example:
https://github.com/kernel-patches/bpf/actions/runs/12934431612/job/36076956920

Can you help to take a look?

afaict, it only happens on s390 so far, so cc IIya if there is any recent change 
that may ring the bell.

Thanks,
Martin

