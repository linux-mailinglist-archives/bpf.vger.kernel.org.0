Return-Path: <bpf+bounces-55194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489B3A798DE
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 01:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C38F3B281B
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 23:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B791F583B;
	Wed,  2 Apr 2025 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mllKh4UH"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1031F2B90
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 23:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636786; cv=none; b=X3elYtZy9ZlGlDIILHMQzhuFQzJwndsrwXJH4hzllRCsaW4wXeXEJ8h6EHXdKrrflbFDCGx0hWOK01JcUwpyzmKz97x2WE+/jV6fQ5nkJbLwdcTCf4rhvvWzgUokcUjEVLlD0/pqVfmm7aQkjNUhp0gR2XkixIK67mMmy6wWpg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636786; c=relaxed/simple;
	bh=+9f0xh9bpu/7FQEc1yyrZuyMy6JfBPpuLuPzy6kUEmc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=C6K9TT28Owi0BdpoV809Wdte9WZe9U2zX2EWgMs30flT92IqUamjU6pUQyw58Ausv724SKv9vofH19UCQ0PrfpvslZzx8lojjh9DYqMVd8EdxQUcVFcM6QTMpXT3NM0wMEA9qKlTLeQb15Q9Y10IrVl5P1p6xhhrSlpQ/Oyzm/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mllKh4UH; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743636779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UESCMlxPt4+JIRa3Qu1C2NXufnZRpQhrOYXEHP5fpf8=;
	b=mllKh4UHS4YIajtS+ukvBMhZJk0tBnJgnUp+VMdaSPVYdpUtWv5JDPEA5ziLb8bcBXxIvV
	qT6xmonW6v3+uum6xqQ3VHSj109JVM2/VdiWZl/SCRm1msbiT5duLFFYVGPpSG1jTb+q8u
	ZiBMymUj8uMTI4xqxmLpCWqtGwVPpkw=
Date: Wed, 02 Apr 2025 23:32:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <ef200416879d61e6e492de7e7c1cae315f63151f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] scripts/sorttable: Fix endianness handling in build-time
 mcount sort
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>,
 "Nathan  Chancellor" <nathan@kernel.org>, "Ilya Leoshkevich"
 <iii@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
In-Reply-To: <20250402192851.0bc6fc77@gandalf.local.home>
References: <patch.git-dca31444b0f1.your-ad-here.call-01743554658-ext-8692@work.hours>
 <6acbc2347a86153c2646a4bfebaa226e9b0e01f7@linux.dev>
 <20250402192851.0bc6fc77@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT

On 4/2/25 4:28 PM, Steven Rostedt wrote:
> On Wed, 02 Apr 2025 23:22:40 +0000
> "Ihor Solodrai" <ihor.solodrai@linux.dev> wrote:
>
>> Hi Vasily,
>>
>> I can confirm that this patch fixes BPF selftests on s390x:
>> https://github.com/kernel-patches/vmtest/actions/runs/14231181710
>>
>> Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>
> Thanks, but I already submitted a pull request that includes this fix, =
as
> it looked pretty obvious (I did run it through all my normal tests, but
> just didn't test the big/little endian case).
>
>   https://lore.kernel.org/all/20250402174449.08caae28@gandalf.local.hom=
e/

Sure, that's fine. I had to test it anyway, so that a revert
fa1518875286 patch could be removed from CI. Just sharing a data
point.

Thank you.

>
> -- Steve

