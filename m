Return-Path: <bpf+bounces-62980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6510DB00C1E
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 21:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9667BCB94
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 19:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE0A2FCFFE;
	Thu, 10 Jul 2025 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BJD45F24"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C09123E325
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752175809; cv=none; b=qodnqiB8r0SlHo+OqojTmJWm5gtVo4iUIjEEKM/ugzk4IW3BUVJydnozUDEj9585el8/tdvAkXlP8cpihij8kzJ3VF9ofaVFYR40vPWEzjo4Ncsz0pcxLxin/J6lc5VcaVAGq5osKC5Sx4N4jWPZbnadhkNNALaBHstEsGveTns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752175809; c=relaxed/simple;
	bh=TXtAYlcDFdP97i52JhF6EZ0qpAY1eyTtKJ5dzfQeaiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eaYpi691ERzQqvY8oA1pHnepK0jzM/Vhhl2Y6WGz+ChjsOHeUGU3AxqGtH686J88c5rB6Z+w8RENsORJER8qCDDoJgz7BowGVL9Ncu7rXG/GVfMilM9gEamruuCtbNNOfsob2whxYTzOP7CxCUlCGYi+29jD9SZgdm3GF6JV4bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BJD45F24; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <26b2dac0-3cb1-484d-a3d3-87ad06da5b32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752175804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tn0wVxnPchdpcUHO4cc562vmpmX9/c2bsNCVDMf1J24=;
	b=BJD45F2462HAs+xpWlDtWCUrLXa/gZtoMVrE6YGK3VdEQIQyUL3q255lhu07sic1yan/kY
	r1Tm0IoBYiYOc18SQRoitwLKp3pSlyYuddhRyj+3av/SIh/o2OwJTpIYNWWll1FLnj9ep8
	mRdAWSn04vMA11hLpUJgCxuCVtywRQ4=
Date: Thu, 10 Jul 2025 12:29:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Range analysis test case
 for JSET
Content-Language: en-GB
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>
References: <9d4fd6432a095d281f815770608fdcd16028ce0b.1752171365.git.paul.chaignon@gmail.com>
 <c7893be1170fdbcf64e0200c110cdbd360ce7086.1752171365.git.paul.chaignon@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <c7893be1170fdbcf64e0200c110cdbd360ce7086.1752171365.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/10/25 11:21 AM, Paul Chaignon wrote:
> This patch adds coverage for the warning detected by syzkaller and fixed
> in the previous patch. Without the previous patch, this test fails with:
>
>    verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds
>    violation u64=[0x0, 0x0] s64=[0x0, 0x0] u32=[0x1, 0x0] s32=[0x0, 0x0]
>    var_off=(0x0, 0x0)(1)
>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


