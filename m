Return-Path: <bpf+bounces-49982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521AEA213A8
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 22:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95E316762E
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 21:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7301E0B74;
	Tue, 28 Jan 2025 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pc5gwYTe"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F901B0405
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738100518; cv=none; b=TQqOoQ+3NccSyDMr2AppLVO0QhoBYrjvaW1GQICJu4UR7pMfbwjE81QSWAO8ncNNJPNYjII823RjrJfb0GnB2GqguD1FDqfYzmsHEqN2u+uTEOQEbSxjdyXQZ4GlHIM+yfc/cMk3jbGHnZbr5MAXuxLW+08bdaB7cl8ErqB8vnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738100518; c=relaxed/simple;
	bh=g8VbjfLaiQtVrQDR63dCzVTEx/VJY+Dgxc2kqiyg6/o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sa/cseHwcByozlkbdevXefncYYn3hf4N+hjhtkUO8OYhKokRGhcJWYyjmVNruLNWdTXRa+pZjv6ewLk0SDUzrciT5cIaCmfldB8oDL+WpCBh4aMYUchZ1DcPSdc8GGoY7AmT7wal98eZEvtJgEj0BFxnIDYb5J5bzw6GlnVf/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pc5gwYTe; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eac5f55f-8aeb-4a6d-9aca-820c5ad4c3a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738100512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7xdX/PQyv1xwLBe613gLabNAZGYkUFPDRn+pT2nOBUI=;
	b=Pc5gwYTeNcQ0/Pfx961Zxvuzh+0MOyVuGJLXQAlcWhQO8ZPhWWTRlLPVMjCrJhmxnQxv/0
	MWCR4gH+2ebiGDTHn3YxUpziSok0Izgi4BHBZC5A7eEKAM+sdVNAMR+dsmq3PKFFDyeb7b
	bm4bYuLKQwIp5NCAqrIyoOKr0rO/wgQ=
Date: Tue, 28 Jan 2025 13:41:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: lsf-pc <lsf-pc@lists.linux-foundation.org>
Cc: bpf <bpf@vger.kernel.org>, Eddy Z <eddyz87@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?TWFyYyBTdcOxw6k=?=
 <marc.sune@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
Subject: [LSF/MM/BPF TOPIC] Uninitialized Variable In BPF Programs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

If bpf program has an uninitialized variable, clang compiler
may take advantage of it to do some optimization. The resulted
bpf program may still survive verification but get wrong result.
Users then may take quite some time to understand the real
reason by inspecting asm codes.

The compiler flags '-Wall -Werror' are supposed to issue errors
if an uninitialized variable impacts the final result. But in
reality, since compiler may not be 100% sure a variable is
uninitalized due to limited analysis, the error may not be emitted.
gcc has '-Wmaybe-uninitialized' flag to issue warnings for some
possible uninit variables but still may miss some others.
clang does not support '-Wmaybe-uninitialized' flag.

There are already some discussion in llvm community for this ([1]).
I would like to elaborate more with some examples, e.g. how llvm
internal handle uninit variables, and discuss how we could do
something to expose harmful uninit variable earlier.

   [1] https://discourse.llvm.org/t/detect-undefined-behavior-due-to-uninitialized-variables-in-bpf-programs/84116?u=yonghong-song


