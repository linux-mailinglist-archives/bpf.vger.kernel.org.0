Return-Path: <bpf+bounces-21164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C098D848FF7
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 19:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA041C21382
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 18:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8F124A0E;
	Sun,  4 Feb 2024 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="StsuPc0P"
X-Original-To: bpf+bounces-21161-xuanzhuo=linux.alibaba.com@vger.kernel.org
Received: from out0-177.static.mail.aliyun.com (out0-177.static.mail.aliyun.com [59.82.0.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D88250EB
	for <bpf+bounces-21161-xuanzhuo=linux.alibaba.com@vger.kernel.org>; Sun,  4 Feb 2024 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.82.0.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707072070; cv=none; b=JNKYsEdYVi8sa+tvlaf/f58fDe3HO00//gWzUG4fAsA2Qlw5zJWcALGrCG3ePTs8ywRZcfbqfJAPSDxwIHbrk3SHQW3h4lPHffTaS8AIV+WeD8EoSx2iHL/gBx1+tEMwh3QrvFYJ2hQ6elkQtSOK2R1cej0C3LhrgUz0BMDhBWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707072070; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=SlmJ6jOHn09fVMlX6iySZ129Cuju6P503IW8P4K34iIE+yfhum/G2gQJyGV59KdrtkJ8EI5E0ltH4VcbyVmL8HwkOMHi5CYI6BQdSCZfbNQXG4VNyzY2zK0IEsfCw8r1b7FscjYi6bbiquGVucuzEhYoxggDJyUVVutQV9vc4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=StsuPc0P; arc=none smtp.client-ip=59.82.0.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707072062; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=StsuPc0P9eZyRIah60bKoNKQiEqxkT0lqOmZ8B5A4vQNIGb9s1FPjpe5rlVOOG+6Hk+jL3menapl0cFa9KTVd9SgSL8W62L2ttS94Tc7YSMc9jb7/TamZR0LM3jKPz59nk51cIAMZn19APj8zNtlepyqJchLRwygAMJp/2nLKhs=
auto-submitted:auto-replied
date:Mon, 05 Feb 2024 02:41:02 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6W1BBVENIIGR3YXJ2ZXMgdjQgMC8yXSBwYWhvbGU6IEluamVjdCBrZnVuYyBkZWNsIHRhZ3MgaW50byBCVEY=?=
to:bpf@vger.kernel.org
message-id: 8562d31a-3d21-48d0-a883-81f702088b6b
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version:1.0
Content-Type:text/plain;
	charset="utf-8"

Hi, I'm on vacation. I'll get back to you when I'm done with this vacation.
I'll be back on 2.18.

Thanks.

