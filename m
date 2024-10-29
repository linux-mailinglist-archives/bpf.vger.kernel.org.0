Return-Path: <bpf+bounces-43360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D0F9B3FCA
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 02:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781691C21FA8
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439E35589B;
	Tue, 29 Oct 2024 01:32:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8067D168B1;
	Tue, 29 Oct 2024 01:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730165565; cv=none; b=UQgMXW9rTu+EzmX4tGyB3JeUnSuhcHJxy3RoJMfyM6IcMj+oe+NBGF06WiqQGv1Vp3wT5s+xcfoqgpX01wDjTl7Ant2kBo5SC+T/4Vh/0MWL6tl8TYx3oXuf8IBKyrLsaHgp3YmL0QXULmXFHS9PQcBaw47HjauDVYE1MX7pIEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730165565; c=relaxed/simple;
	bh=jy2ZWRukvY64J3l5n3bcnNWbTtLwKOFBWV+nQy/pSgY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ey3pxblHDojIBVIjtTPVs32WcYrSOQzRwQU+mkMx04cMmB7IeFftvCogFEJsT0Zxbi+l1xCmGcaN54swhTp6s41WgA/l40ZH1R4t1t/T8qDpZVbJUT3Vw/cz6kKea8UJ364YTYnITkc61izMTu81E88hkarunrQkeAqTdSxVTTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xct6B1KRkz4f3lVp;
	Tue, 29 Oct 2024 09:32:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A0F2F1A0197;
	Tue, 29 Oct 2024 09:32:36 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBH8LEwOyBneQDrAA--.24551S2;
	Tue, 29 Oct 2024 09:32:36 +0800 (CST)
Subject: Re: [PATCH v2 bpf 1/2] bpf: Fix out-of-bounds write in
 trie_get_next_key()
To: Byeonguk Jeong <jungbu2855@gmail.com>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <Zxx384ZfdlFYnz6J@localhost.localdomain>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a90fcf65-05be-1cd9-8b42-9367474c1a49@huaweicloud.com>
Date: Tue, 29 Oct 2024 09:32:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zxx384ZfdlFYnz6J@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBH8LEwOyBneQDrAA--.24551S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw45CryDuw18Gw4ruw4kZwb_yoW3CFcE9F
	98CwnIkw48Arn7t397Ar1fXFW3CF18WF1DXws8WFn3ZF1kWws5Ars8AFn5Zr48WF4kCa45
	uw1aqF4qqF98WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 10/26/2024 1:02 PM, Byeonguk Jeong wrote:
> trie_get_next_key() allocates a node stack with size trie->max_prefixlen,
> while it writes (trie->max_prefixlen + 1) nodes to the stack when it has
> full paths from the root to leaves. For example, consider a trie with
> max_prefixlen is 8, and the nodes with key 0x00/0, 0x00/1, 0x00/2, ...
> 0x00/8 inserted. Subsequent calls to trie_get_next_key with _key with
> .prefixlen = 8 make 9 nodes be written on the node stack with size 8.
>
> Fixes: b471f2f1de8b ("bpf: implement MAP_GET_NEXT_KEY command for LPM_TRIE map")
> Signed-off-by: Byeonguk Jeong <jungbu2855@gmail.com>
> Reviewed-by: Toke Høiland-Jørgensen <toke@kernel.org>
> Tested-by: Hou Tao <houtao1@huawei.com>
> ---

Acked-by: Hou Tao <houtao1@huawei.com>


