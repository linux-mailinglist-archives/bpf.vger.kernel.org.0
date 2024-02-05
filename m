Return-Path: <bpf+bounces-21234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB28849F39
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 17:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A721F23B91
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2019332C8E;
	Mon,  5 Feb 2024 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dpE3nboe"
X-Original-To: bpf+bounces-21233-xuanzhuo=linux.alibaba.com@vger.kernel.org
Received: from out199-22.us.a.mail.aliyun.com (out199-22.us.a.mail.aliyun.com [47.90.199.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453872C6B4
	for <bpf+bounces-21233-xuanzhuo=linux.alibaba.com@vger.kernel.org>; Mon,  5 Feb 2024 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149052; cv=none; b=gyzz/j6P7I+F+9uaauiOeWHpd9CG2DZymqFbL/U6cdLrY5rpMag0ZH6hXmxn6ARzULARcXU80vMgQJvCagiakZTQGcmH4qzAQ4937wRoa2fmZZLBe2aGdyUNhB3ougTGJfELwTr1ofIXE+sE2yzVF6nfLhDvMq+W29RLXDONpf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149052; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=UjZhd4LSww7FPmWMPsqP9d5C1eUINzu1c2QRkcH5FkcDCTsw16Y0/9/RQvnyhyJ+7B5hmfb9p7ztZ5X2Lunrv+H8hqvkOHmnVPiRxN5XEDElWtArt3x0jDM2kS7hexQeGxklOppN9UAqvgIsxMVdTLTSTKGDar8by47v7vD0iAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dpE3nboe; arc=none smtp.client-ip=47.90.199.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707149038; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=dpE3nboeHeqHhY9b/I195OLTXJEiLkjj9kp0ugjruFFpGzNQtqqlwuLLhWz5jqefVXmG3zWXLfOsqPI+v/+s+f+6QbaBqKux5MfZ83Ivf0aTvFiLKnD/cTom9nUtOdwwwqoB9A77YlXGpBo8dOmdmJoToTHyvmkdbInAlqs5n6g=
auto-submitted:auto-replied
date:Tue, 06 Feb 2024 00:03:58 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6UmU6IFtQQVRDSCBicGYtbmV4dF0gc2VsZnRlc3RzL2JwZjogRml4IGZsYWt5IHNlbGZ0ZXN0IGx3dF9yZWRpcmVjdC9sd3RfcmVyb3V0ZQ==?=
to:bpf@vger.kernel.org
message-id: e13f2ea7-83fa-47f2-b195-f56704019e3e
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

