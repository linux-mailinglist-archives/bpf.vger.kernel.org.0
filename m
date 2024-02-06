Return-Path: <bpf+bounces-21356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 049F184BA92
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 17:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E361F22CD6
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CB7134CC6;
	Tue,  6 Feb 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="afdpApfF"
X-Original-To: bpf+bounces-21355-xuanzhuo=linux.alibaba.com@vger.kernel.org
Received: from out199-22.us.a.mail.aliyun.com (out199-22.us.a.mail.aliyun.com [47.90.199.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8013475E
	for <bpf+bounces-21355-xuanzhuo=linux.alibaba.com@vger.kernel.org>; Tue,  6 Feb 2024 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235440; cv=none; b=KXZYykm702GsqlPNeOnTWKh2uBcNF4NDn+gOQqObNULIJ/WcWeIC5aIGUz8S7IDlxF1nrQd5Ud91xTFOzYOzFMXZlRmeOaq7SQ1qKuHe4rE6W/dDKdRn6D/DvrKP35oAoIe5aLgAh8nrNi31rHtWEPAIq8U/MclTt9aSgcwLWRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235440; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=N9oK9jVxeQcXhS8Nq48cGkJw2AS0yN4uGOkB1fBVGv04gN7WW7nhPYeKctya1YwXESUbC05K6HiAQoXHrlX59wd8x71IKBtRaFDsyWN1ZREx6YK3BgFqy3bN7w1cGxMs4HvnnwPNHz9QQlYbtA0sq53ivs/z25ycssW47nboUCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=afdpApfF; arc=none smtp.client-ip=47.90.199.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707235421; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=afdpApfFsFM1ZMnZXKjHqwFmLCzzW4+KnxBxyfo2fb4JNkTo4omi8EBZZ6aPvppoq5cxOWmgkxfwzJVx9UKXpfPVxbnOPWKpjzSo7vFOaf+OoIjyRLwhL/8LH/i0EqWfjgdO73OqqjjFtE3c0LfPkrTPnInjeelo567mHQIfKwQ=
auto-submitted:auto-replied
date:Wed, 07 Feb 2024 00:03:41 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6UmU6IFtQQVRDSCBicGYtbmV4dCB2MiAxLzJdIGJwZjogSGF2ZSBicGZfcmRvbmx5X2Nhc3QoKSB0YWtlIGEgY29uc3QgcG9pbnRlcg==?=
to:bpf@vger.kernel.org
message-id: 5b667156-8281-4fb4-8847-26b6ec062174
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

