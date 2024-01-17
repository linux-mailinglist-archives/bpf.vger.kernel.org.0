Return-Path: <bpf+bounces-19709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 689E782FF7B
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 05:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA9E4B24066
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 04:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D31A567D;
	Wed, 17 Jan 2024 04:16:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E046BB;
	Wed, 17 Jan 2024 04:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705464972; cv=none; b=VbMyvjPIZjgbq2FVL1kxxmfDMxvrEAlxZUEZFkzY67MSkLcjxYAuYuJ3X+xjVCbk2Dt1H+Fy2h49JSQzdK/TBheN1rbJ7SxRAJe5wABoOKaiW7UwioDm1B0zQcvVsGiRKtNQ3wbw8c8h1e09k4sVVPv2Av33DyYe2zKHwERscis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705464972; c=relaxed/simple;
	bh=feAlLSG9OsTk/C5TuxkqX6cYf+9wY1DNEhQwJHnt4eg=;
	h=Received:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Content-Language:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=fUqBnb+/b2az9v8jbKqyOrPynH8Twz0AaU5L4h36jG+3YH7adCxYx/iqPpaHs0206Ir9SPMjl1TlFRli8dNEXU8bSLoLLL58ZavqiNj1XSP/tkKvt7xQc3+oQYInT7OBQF4zpb2WTk8iTSeLw4jvXzRk77Afk1TsY7hCjxpxxDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TFCH41dq4z4f3lg3;
	Wed, 17 Jan 2024 12:16:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5487C1A084D;
	Wed, 17 Jan 2024 12:16:06 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDHGm2AVKdlhLZVBA--.33385S2;
	Wed, 17 Jan 2024 12:16:03 +0800 (CST)
Subject: Re: [PATCH AUTOSEL 4.19 07/22] bpf: Add map and need_defer parameters
 to .map_fd_put_ptr()
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, daniel@iogearbox.net,
 andrii@kernel.org, bpf@vger.kernel.org
References: <20240116200432.260016-1-sashal@kernel.org>
 <20240116200432.260016-7-sashal@kernel.org>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <aa7ce9ae-cba1-120c-a5d3-851c4e4d1fb2@huaweicloud.com>
Date: Wed, 17 Jan 2024 12:16:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240116200432.260016-7-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDHGm2AVKdlhLZVBA--.33385S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1DWw17WFWDKFW8JryxKrg_yoW8Wry8pF
	WfXF4Utw4kJ3yvgwsxAanrZrWFywn3Jr90kr48Xw1rZFZ8J34fKrWxta1avFy5CryF9Fy7
	XwnFy3WIywn5Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 1/17/2024 4:04 AM, Sasha Levin wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> [ Upstream commit 20c20bd11a0702ce4dc9300c3da58acf551d9725 ]
>
> map is the pointer of outer map, and need_defer needs some explanation.
> need_defer tells the implementation to defer the reference release of
> the passed element and ensure that the element is still alive before
> the bpf program, which may manipulate it, exits.
>
> The following three cases will invoke map_fd_put_ptr() and different
> need_defer values will be passed to these callers:
>
> 1) release the reference of the old element in the map during map update
>    or map deletion. The release must be deferred, otherwise the bpf
>    program may incur use-after-free problem, so need_defer needs to be
>    true.
> 2) release the reference of the to-be-added element in the error path of
>    map update. The to-be-added element is not visible to any bpf
>    program, so it is OK to pass false for need_defer parameter.
> 3) release the references of all elements in the map during map release.
>    Any bpf program which has access to the map must have been exited and
>    released, so need_defer=false will be OK.
>
> These two parameters will be used by the following patches to fix the
> potential use-after-free problem for map-in-map.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Link: https://lore.kernel.org/r/20231204140425.1480317-3-houtao@huaweicloud.com
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

The patch is just a preparatory patch for fix, please drop it.


