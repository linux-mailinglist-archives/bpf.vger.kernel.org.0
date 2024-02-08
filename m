Return-Path: <bpf+bounces-21513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF2484E57F
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 17:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEB9BB287D0
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 16:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5D47C0AA;
	Thu,  8 Feb 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="evKO5/fz"
X-Original-To: bpf+bounces-21512-xuanzhuo=linux.alibaba.com@vger.kernel.org
Received: from out0-239.static.mail.aliyun.com (out0-239.static.mail.aliyun.com [59.82.0.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011D7CF13
	for <bpf+bounces-21512-xuanzhuo=linux.alibaba.com@vger.kernel.org>; Thu,  8 Feb 2024 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.82.0.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411190; cv=none; b=gYerqJ6oqRo07ICplbmf3jOFYtUrisEjsra1pkg5XuNwxzo7VoEM+KjyouaCqC1Kt6/XrZPBjDmYo5BDuMnd1KAVpQvh4xfDTfw3ew8WVadMMItUdRJ9Wk2G03gvtKS0Oxy+xWKBRl8N9dU5okGtBaUV9/5xudFIyf/9j7JHXKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411190; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=ce+UkdJUqVkgw49G2HxNHn5xru+ioulV412USQBVrWE7Zkh6nX/u1Iz3He1/NC30EV38G19qVuzi2+ymTiM/ol9GvN0Y+stu5IuztW4ILXTa/L6o5Je+qRYm9xFeyOcsdHohGPG8GttW2LzTCkIM73UNsnzOE1amZh79GSq6EOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=evKO5/fz; arc=none smtp.client-ip=59.82.0.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707411177; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=evKO5/fzl+9VhQmmHV6jrqtG1u7lmSIYU4tLyWCkDSoSqd8Y+NE74DuU9t/OBSJCtqbuwX75hm1klGJOg3hOfTBupZt0RI1dSwNM0vkSA57dzQKbyxhH/keGl36AcmRdA5Q480Yrp8F8IuDDxpLiTWZ/BiK2K9L7WZyOar0rfQc=
auto-submitted:auto-replied
date:Fri, 09 Feb 2024 00:52:57 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6UmU6IFtQQVRDSCBicGYtbmV4dF0gYnBmOiBhYnN0cmFjdCBsb29wIHVucm9sbGluZyBwcmFnbWFzIGluIEJQRiBzZWxmdGVzdHM=?=
to:bpf@vger.kernel.org
message-id: c9a7cd08-9277-42b0-a6b9-dadb674dcbb0
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

