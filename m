Return-Path: <bpf+bounces-43044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C6E9AE414
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 13:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B541F231C2
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 11:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DC01D096F;
	Thu, 24 Oct 2024 11:44:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907FD1B6D0A;
	Thu, 24 Oct 2024 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729770291; cv=none; b=lZngSJ2YN8vBgk7H2uQJz+YNDMI8Sgnd0zs4u0ZPIjDZjTec3TxVi+sM+n34eGhOIpHWADPjDMMCBlYluiwgVmrDVHfjcFDKPYnfSBqwH1G1Sz+zAmxF7EAxv8bFCLtZYwEwNuvwnpJCKP13DOm565g7GKiO2EMqeJPtAlDNYNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729770291; c=relaxed/simple;
	bh=6xZD9aR5K8pv33h6dVFH+/VkNLlK2SLZ7yjvgz/auFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TR264iEZHkrd5ePB50VU/NteQzx8HPWLvgqyB1A2zFzX+Bf2jF5oHYdi9POH3HW6PwpQMPhzmqkhFb1zMv1o5tQXB7vHvDlUW8oRqwq5JqYObTvoszglhKlHTKrlZjiocR65RXrcZYZLoHdxc96Ph89DCV8mWnN7Fu1EjZiSPbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XZ3LX3yw8z9v7JM;
	Thu, 24 Oct 2024 19:18:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 96F7F14039E;
	Thu, 24 Oct 2024 19:44:33 +0800 (CST)
Received: from [10.45.154.7] (unknown [10.45.154.7])
	by APP1 (Coremail) with SMTP id LxC2BwBXyTkaMxpnxsJYAA--.61984S2;
	Thu, 24 Oct 2024 12:44:33 +0100 (CET)
Message-ID: <35bed95a-3203-43a7-972d-f3fd3c7da6f9@huaweicloud.com>
Date: Thu, 24 Oct 2024 13:44:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Some observations (results) on BPF acquire and release
To: Andrea Parri <parri.andrea@gmail.com>, puranjay@kernel.org,
 paulmck@kernel.org
Cc: bpf@vger.kernel.org, lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Zxk2wNs4sxEIg-4d@andrea>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Zxk2wNs4sxEIg-4d@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwBXyTkaMxpnxsJYAA--.61984S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr1fXryrJr1xtw43GF4rZrb_yoWkGrb_GF
	ZxCryj9as0qFn7XrsrKF1Y93ZakrWUJry7X3yFq34Yv34ktFZ5Xryvkry5ZF18Cwn0yryY
	ga4DA3yjka42gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 10/23/2024 um 7:47 PM schrieb Andrea Parri:
> Hi Puranjay and Paul,
> 
> These remarks show that the proposed BPF formalization of acquire and
> release somehow, but substantially, diverged from the corresponding
> LKMM formalization.  My guess is that the divergences mentioned above
> were not (fully) intentional, or I'm wondering -- why not follow the
> latter (the LKMM's) more closely? -  This is probably the first question
> I would need to clarify before trying/suggesting modifications to the
> present formalizations.  ;-)  Thoughts?
> 

I'm also curious why the formalization (not just in the semantics but 
also how it is structured) is so completely different from LKMM's.

At first glance there are also many semantic differences, e.g., it seems 
coe is much weaker in eBPF and the last axiom also seems a bit like a 
tack-on that doesn't "play well" with the previous axioms.

It would make sense to me to start with the framework of LKMM and maybe 
weaken it from there if it is really necessary. But maybe I don't know 
enough about how eBPF atomics are intended to work...

Best wishes,
   jonas


