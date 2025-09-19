Return-Path: <bpf+bounces-68880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D19B87A28
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 03:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D51568530
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 01:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10396231845;
	Fri, 19 Sep 2025 01:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dqv1nSZX"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2EB7E0E8
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758246440; cv=none; b=B0yTNnZjv+eZVGsvgwqA7aJ5x+6tn7VYkm/tAqyti5HE1u+4FbW6T3exDfynmYNMTDvWhX6W0NA2Yg2glPFhsECD4Gk2CK8bm3hqQ80GTVmlgc3P4oXsKXA4Am0IyXqTc4Bp1Ls5wbkJr1RrSNuR+O1C6ZLrRj6vvWhyIW/V3+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758246440; c=relaxed/simple;
	bh=VRemiEBxyqchG48MyzSw1O4/gWTUxbi9BIFvEVxfJnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WiMmtF70vWxyj68PlqcS4hfTExN/JQfW97ZPv9ydn9VNrmklUnrGtK8b6bJro3/sK7MBq1peS5zq5WE0OtqkH8IDrXxWT3+swwrC+bVJp52f+WZjUW+17wj+hLYfGSmjEdAiWZgrAXAvEs/SySaDNQ0dV2KWGgy3aoCLs9MnVts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dqv1nSZX; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bd40f8ce-37ed-48b0-b2ad-69eff76a4c20@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758246435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlHffLgaLFb0z84X4JR238Xng/mvXae7jNvi7faXCPw=;
	b=dqv1nSZXyh3Rx8hfufMvCYY1jROO0lmibNkhYF1pLFX87LZf7sb70ZC7UOG0TQmDooysGy
	yYCwSZ6GrwbghKtCdED4kmZDS/qhkLth3r5/SqEQCwP8RR63WhAOPmVApXVu/rheUWUwC7
	pss1AHooaCGswhhWeFZERwNvzXnlbl4=
Date: Fri, 19 Sep 2025 09:47:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add union argument tests
 using fexit programs
Content-Language: en-US
To: Tao Chen <chen.dylane@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, yatsenko@meta.com, puranjay@kernel.org,
 davidzalman.101@gmail.com, cheick.traore@foss.st.com,
 mika.westerberg@linux.intel.com, ameryhung@gmail.com,
 menglong8.dong@gmail.com, kernel-patches-bot@fb.com
References: <20250916155211.61083-1-leon.hwang@linux.dev>
 <20250916155211.61083-4-leon.hwang@linux.dev>
 <dbea9a14-e010-4e2f-a34d-4e2fd14a31f6@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <dbea9a14-e010-4e2f-a34d-4e2fd14a31f6@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 19/9/25 00:09, Tao Chen wrote:
> 在 2025/9/16 23:52, Leon Hwang 写道:
>> By referencing
>> commit 1642a3945e223 ("selftests/bpf: Add struct argument tests with
>> fentry/fexit programs."),
>> test the following cases for union argument support:
>>
> 
> Can we use ‘commit 1642a3945e22’ with 12 chars, maybe it's minor nit
> anyways or not.
> 
Thank you for pointing this out.

I’ll update my script to generate the commit information in the proper
format.

Thanks,
Leon


