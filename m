Return-Path: <bpf+bounces-21195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 591958492B8
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 04:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139F2280EAB
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 03:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F3C8C09;
	Mon,  5 Feb 2024 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gBTeOYcH"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1E711183
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 03:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707102842; cv=none; b=p+gBjm8z4g/8ApnomROjzPc1uoTZqbZ4gb5mtw11nIXWdwVBrTWJa/V0z0DkBI8J/Iyeq4fi0WKWuqcRp306vGnwII0XkfEZkvmG2X7uSoxw0GhmIekI5FiXr5AfqNt0/Z1xDMjBal3V4WFQhpAVhz+EQ87C/zI2lWWwk+yKMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707102842; c=relaxed/simple;
	bh=d3ZHcSBk4KsQWQsH8aqNUzygFAclIrredacqxBqgLZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mjey1fjShfapsvE+BmGXco+BiQpwayaS/vWhgXeaSfdT/4ONU+SaaXmu5SSxWxXD8zIuBk9lk0xHAOWObPicQvwOWlhTgSf0X3lI/7IxMi3o++5bLX3mhUKQxouS/c9TqcVijRXgomdxbwNt9FBxE2ol+jNGRAZXJfbeqf9UWNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gBTeOYcH; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f42c46b5-752d-4b4c-b334-7578b5ad89d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707102838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d3ZHcSBk4KsQWQsH8aqNUzygFAclIrredacqxBqgLZs=;
	b=gBTeOYcHkbhaNp9l3d5t9W4YcJhdLdhxLONLap0NafBk5p7peF43OW8SXNivE6v7RFuP4C
	xUDE3LzdQk6zc9ZWLGJO4I65YyTFDOImEdQwNRrXKGaLFMV+Q8eyr5Kta9oMlq/LHoMYU0
	gITVbWuCkock1z2Hjx51Bq40gSBdO1g=
Date: Sun, 4 Feb 2024 19:13:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for RCU lock
 transfer between subprogs
Content-Language: en-GB
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>,
 Tejun Heo <tj@kernel.org>
References: <20240204230231.1013964-1-memxor@gmail.com>
 <20240204230231.1013964-3-memxor@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240204230231.1013964-3-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/4/24 3:02 PM, Kumar Kartikeya Dwivedi wrote:
> Add selftests covering the following cases:
> - A static subprog called from within a RCU read section works
> - A static subprog taking an RCU read lock which is released in caller works
> - A static subprog releasing the caller's RCU read lock works
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


