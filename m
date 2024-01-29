Return-Path: <bpf+bounces-20624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C0584120F
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 19:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B353328B7B9
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 18:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9B42AEFE;
	Mon, 29 Jan 2024 18:34:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640911F5F3;
	Mon, 29 Jan 2024 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553245; cv=none; b=R1X6c85EHObT2ELZxkmIHzmCTg6bxRXo79bikuTXcLbas56rFQ8KSCNzCEukU35uprZHCdbo/gG6sJU9c3GsIte9hCYeJNy6VVB8u/gpZd2cXFhamkip10OxX5vx5aTIdfNI+p0NbzC55RRPTkd/Pq8a9p8rIF/88/lFmW5x56w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553245; c=relaxed/simple;
	bh=ORkeZWLFQ9ycMvgJfUxmGqowOG9g7Z2OntLQycdITVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmoWc5FSHxTw13Q7zruM3hkT1XftHAWPmvb5rsnl/DSi7L2tX6/L6bIf3DdOYia9xRmy9bFUu3Ot3Drzk/m/QIcxRRh4FGYrcyp8BLQ22azjlIDnOZkWuJTUNcSObtztY54lBr+iL323M77X8K4QQt/vmWhs1eHvJ/l3aY44qZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id AF7592F2023D; Mon, 29 Jan 2024 18:34:01 +0000 (UTC)
X-Spam-Level: 
Received: from [10.88.144.178] (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 3CBBA2F2022A;
	Mon, 29 Jan 2024 18:33:59 +0000 (UTC)
Message-ID: <87f74eab-ae51-08a4-5b7e-261f437146f4@basealt.ru>
Date: Mon, 29 Jan 2024 21:33:59 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.10.y 0/1] bpf: fix warning ftrace_verify_code
Content-Language: en-US
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, kpsingh@kernel.org,
 john.fastabend@gmail.com, yhs@fb.com, songliubraving@fb.com, kafai@fb.com,
 andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 nickel@altlinux.org, oficerovas@altlinux.org, dutyrok@altlinux.org
References: <20240129091746.260538-1-kovalev@altlinux.org>
 <2024012954-disfigure-barbell-21b9@gregkh>
From: kovalev@altlinux.org
In-Reply-To: <2024012954-disfigure-barbell-21b9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

29.01.2024 19:20, Greg KH wrote:
> On Mon, Jan 29, 2024 at 12:17:45PM +0300, kovalev@altlinux.org wrote:
>> Syzkaller hit 'WARNING in ftrace_verify_code' bug.
>>
>> This bug is not a vulnerability and is reproduced only when running
>> with root privileges on stable 5.10 kernel.
> What about 5.15.y?  We can't take a patch for older kernels and not for
> newer ones, right?

Indeed, this patch was not backported at 5.15.

I fixed it, successfully tested it on the 5.15.148 kernel and sent the 
patch [1]

However, at the time of the kernel build, I noticed a compiler warning 
about an unused "*tmp" variable,

that I fixed in the patch for 5.15, but remained in this patch 5.10:

...

+	void *new, *tmp;
...
need to fix on
...
+	void *new;
...

Therefore, I resend the patch with a fix (deleted the unused tmp 
pointer). [2]

[1] 
https://lore.kernel.org/bpf/20240129180108.284057-1-kovalev@altlinux.org/T/#u

[2] 
https://lore.kernel.org/bpf/20240129183120.284801-1-kovalev@altlinux.org/T/#u

-- 

Regards,
Vasiliy Kovalev


