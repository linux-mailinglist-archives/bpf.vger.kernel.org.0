Return-Path: <bpf+bounces-36830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EFF94DC31
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 12:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95865282774
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 10:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425BA153814;
	Sat, 10 Aug 2024 10:14:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F4314D70E
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723284874; cv=none; b=hrukJ6SqVybDVJU5q2XPSqKn7AR4SoAmAw3vXdws99cefT/s3hf3QDUouLjM0APGFlAFJAXsmUmlwlSMFgw8comP540kjVUdgWoyvpqH2Zdrd8Eqnr6kLolclUohWeS+6dd5GluRrgGNwDehh4BhTHJUt+sYLo7fHaoeZYFy2Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723284874; c=relaxed/simple;
	bh=t488Vlp8wDmI5sd/CJ8rGouKIiRusrS5Z2an8VdBAUs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fOlUQxFjoKMPvW2rR7IXdM/RWCruvMmO6by/mqExDPgSjciPzWuXhPIHyrp8rShKeo/JjPSS0Aa13OzxhM1CxTHnna03i9ALgLYxLtJO7GTZSwSvYffZRbNnXwbZOyrY/9hp2wDuIqoGDH/fZdil7bS6RX84r+aBrBESVVR3D0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WgxTK0KFzz4f3jHy
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 18:14:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 881DB1A1556
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 18:14:27 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgBnyrh_PbdmNDf7BA--.7452S2;
	Sat, 10 Aug 2024 18:14:27 +0800 (CST)
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Let callers of btf_parse_kptr()
 track life cycle of prog btf
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, sinquersw@gmail.com, davemarchevsky@fb.com,
 Amery Hung <amery.hung@bytedance.com>
References: <20240809005131.3916464-1-amery.hung@bytedance.com>
 <20240809005131.3916464-2-amery.hung@bytedance.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <954d372d-0c7f-d4e8-2e71-530da853e46f@huaweicloud.com>
Date: Sat, 10 Aug 2024 18:14:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240809005131.3916464-2-amery.hung@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBnyrh_PbdmNDf7BA--.7452S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFykZF1DZr17Cw48Gw1xKrg_yoWfuFc_Ca
	4xA3s7Ww48X3s7K3W09FWFvr4xta1rCw15X34Iyr97GF1UZ395WrWIg3s7Kry2vw47Xw47
	tr95J3W8try7ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsU
	UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 8/9/2024 8:51 AM, Amery Hung wrote:
> btf_parse_kptr() and btf_record_free() do btf_get() and btf_put()
> respectively when working on btf_record in program and map if there are
> kptr fields. If the kptr is from program BTF, since both callers has
> already tracked the life cycle of program BTF, it is safe to remove the
> btf_get() and btf_put().
>
> This change prevents memory leak of program BTF later when we start
> searching for kptr fields when building btf_record for program. It can
> happen when the btf fd is closed. The btf_put() corresponding to the
> btf_get() in btf_parse_kptr() was supposed to be called by
> btf_record_free() in btf_free_struct_meta_tab() in btf_free(). However,
> it will never happen since the invocation of btf_free() depends on the
> refcount of the btf to become 0 in the first place.
>
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>

Acked-by: Hou Tao <houtao1@huawei.com>


