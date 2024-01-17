Return-Path: <bpf+bounces-19710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 451AA82FF7F
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 05:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE501F25672
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 04:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79645CBC;
	Wed, 17 Jan 2024 04:16:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1364522E;
	Wed, 17 Jan 2024 04:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705465014; cv=none; b=pFXsoStpSE5VkasQ1HDNm73yNXHrSBH3dE6h+sexuZaA2QubG1Ef5EtFOSAVA3A851fEMWRxjUOo+FMkT92sKFzjgpwBJ/tmo42Nf3y55tt4NY/XhSn4d914B9qnLdk5f00qF4klc0OE+0B7MNznKTpdyqBcxtS9ze40QPGUDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705465014; c=relaxed/simple;
	bh=UjBgP1/h3DRyPoAPBNnSr0/jtAiU7iaOd8ATf56ctUo=;
	h=Received:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Content-Language:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=r+lNKav9ZgBaLYcG8yuuSWaUrj7hgFhYWpF3m6UabkThy3qKgeWCfsrGz8JPHq0L+wbrxx7YBGmBA4FNl9ul7V4JP8ZmgMtEjFZuR3FVDQyZW4cc8DsZpMiJckwN7RE7u/IWZoTE5sDExCNUoQl4fPme8DOoQQc+kugVp+7h8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TFCHz1Gfxz4f3k6G;
	Wed, 17 Jan 2024 12:16:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4ED6B1A016E;
	Wed, 17 Jan 2024 12:16:49 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDHGm2wVKdlDMZVBA--.33496S2;
	Wed, 17 Jan 2024 12:16:49 +0800 (CST)
Subject: Re: [PATCH AUTOSEL 5.4 11/31] bpf: Add map and need_defer parameters
 to .map_fd_put_ptr()
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, daniel@iogearbox.net,
 andrii@kernel.org, bpf@vger.kernel.org
References: <20240116200310.259340-1-sashal@kernel.org>
 <20240116200310.259340-11-sashal@kernel.org>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <5b3c2a41-2347-f8d5-2901-2287b350c536@huaweicloud.com>
Date: Wed, 17 Jan 2024 12:16:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240116200310.259340-11-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDHGm2wVKdlDMZVBA--.33496S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1DWw17WFWDKFW8JryxKrg_yoW8WrykpF
	WfXF4Utw4kJayvganxAanrZrWFywn3Jr90kr40qw1rZFZ8X34fKrWxta1a9Fy5CryF9Fy7
	XwnFy3WIywn5Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07Upyx
	iUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi Sasha,

On 1/17/2024 4:02 AM, Sasha Levin wrote:
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


