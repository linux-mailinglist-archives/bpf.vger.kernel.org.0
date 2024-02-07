Return-Path: <bpf+bounces-21420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8117284CF4C
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 17:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37157286F3D
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 16:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC60D823A8;
	Wed,  7 Feb 2024 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qQm/XvSX"
X-Original-To: bpf+bounces-21419-xuanzhuo=linux.alibaba.com@vger.kernel.org
Received: from out0-197.static.mail.aliyun.com (out0-197.static.mail.aliyun.com [59.82.0.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1C823A5
	for <bpf+bounces-21419-xuanzhuo=linux.alibaba.com@vger.kernel.org>; Wed,  7 Feb 2024 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.82.0.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324894; cv=none; b=gKF2b24ZzwQ/ySOv+e/5q37BhPc+oIg+fkhqgLAN2u79KBkP3II7lK+dxYoXqVfns30Z4qEdYkt5blJJoXsASzn4WI7YdfD2t7aghzV1bcCmClL0HyDRfmTYDI/BjtApgtor9xK0dQzURnHLt77RcR1eL/BAH/5UHXRZz8lXJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324894; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=u7ErEu3yJLeqI/yLzKeq/ros+VSJJsJl2+QN8jaooV3GKQPxI3Jsz9vZ+ZK5UeWnKojkZNATTUshKKPLqvw59YnU0dpEZWYdg/7HnBdKixI/FuwfprVq/MTjatn3zPk9y09fsT0GB8tfRY1vAuEevbGxf+v1jPwU3HLTDUkGm1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qQm/XvSX; arc=none smtp.client-ip=59.82.0.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707324889; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=qQm/XvSX/Ji1tc5Ysxp60nE0mtWWBEnxkJSpFk8A4Fq8JKrsPng2bGA2TBnZMvVMnM0tUns91/wQf4JZxVBTb030HdMzPavn+kBS+7VsLiZKcG0zcICMgEzaShL4WN1iWxBpaZv10avAj2Nrjx+AAzp/4eiJx/Aw+dIV+ZeyyFc=
auto-submitted:auto-replied
date:Thu, 08 Feb 2024 00:54:49 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6UmU6IFtQQVRDSCB2MSAwLzZdIG1hcHMgbWVtb3J5IGltcHJvdmVtZW50cyBhbmQgZml4ZXM=?=
to:bpf@vger.kernel.org
message-id: 0d523a5c-06f9-4842-b183-1e318090f9d9
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

