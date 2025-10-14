Return-Path: <bpf+bounces-70929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A95F2BDB6C7
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 23:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C463E2CBA
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 21:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3006E239E7D;
	Tue, 14 Oct 2025 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cQMrjpHd"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C00F1FC3
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760477796; cv=none; b=PkuyVAuNfFm9uXNry1Gi19evwmnH/b/e/ngD3kRtz1qnYai4Lss4XNruSImXqiwuUrVXawIOw/jkzeZMul5CyH08V/3DS4a+wuZZ/5oDZRPIvWiOF6yD8/7yo1tpGboqc4ET21h4uwCPPb9pcY4qprw+MSKh+Gmri9XRWArXQm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760477796; c=relaxed/simple;
	bh=ZUIRdYZQRcwfhCH+Vlc/JdR4M8zeOQmTDhaf33rvWfk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XsEQBOCjZwcFrbUM2GS1W3MCpi6gC3yFhcUopOFyz7EutgRZx7khjXM3U+boLJjbZFQ4PbUeBDC6ggG6e8cLtTLfZi5md5Aivz9z3gtob0trezb1RVhbvPKBop0/Qf27VNaQWU6/DalXLSBln4mwZ2up9GCPDPgXmEAWBjJtHzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cQMrjpHd; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d0ca5bfb-5ead-4f67-8716-d44485a8d8f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760477789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=26qtT9ADxKfqtKOtsTo9Te2deMC1DhOohsQsJvZmWD4=;
	b=cQMrjpHd5fVUOaAy9Bw8d0GteIDTRsz39kfZp5Kuy+r/3eXFhyQM7VntZyZHjx1YppaLkx
	EMRvAUg0HYYGtIhXwBLmZ3km4QnYo4p/kAs2T8PzvY8jJdzV9l13EOaaMCZAX9UIQXFVgA
	U7jI8Y6JaamEQc7on4CSm+vWlqyrpH8=
Date: Tue, 14 Oct 2025 14:36:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: helpdesk@kernel.org
Cc: bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Requests to git.kernel.org return 502
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi, 

Today we started seeing frequent 502 errors on attempts to fetch from
git.kernel.org in BPF CI jobs, which causes many of them to fail.

Kernel Patches Daemon instance is also down because of this. 

Example [1]:

+ git remote add origin https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
Initialized empty Git repository in /tmp/work/vmtest/vmtest/.kernel/.git/
+ git fetch --depth=64 origin master
fatal: unable to access 'https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/': The requested URL returned error: 502
Error: Process completed with exit code 128.

https://github.com/kernel-patches/vmtest/actions/runs/18510075579/job/52750495992?pr=404

Any recent changes on kernel.org side? Is this a known issue?

Please let me know. Thanks.

