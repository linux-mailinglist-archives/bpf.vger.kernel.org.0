Return-Path: <bpf+bounces-44521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 312139C407F
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 15:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DAD1F236B0
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 14:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F3C19CCFC;
	Mon, 11 Nov 2024 14:15:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E91132122
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334550; cv=none; b=TRU2PqH7UuC8z/vgj5Y2G2pa8hGhCTLY+McGNu/s5PFjvPS9jtZemenrcxSPiEr2Xr/P0OoGYizcEKViFfg+mndA1jSFgE/eYmkAgXC8/+9dx14Xsr1yj86aMf5iMGUTpNXwdwTYDI0Ak+Zb4vs5680i3xZhQbyMISiNyQfUu+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334550; c=relaxed/simple;
	bh=DT2tmzCajuA5SsgAnm/Kx8W+P7wgnceVvm2NSWZig2s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VNo3THmFd5ycYYZX6T2fDYaGTXadKgyJbWBCQ6HI7B0Rryix/1zUkkISwQMDwXaPQKoJ6NuPH5vEpuYcE9lFNLdMVl6RiEWauT+XWyhR79bJFZ0+0WGbjd37aGb4Hq8rjD4YUscWaAFIWbXmwFSQWZJsKf2oKpc08o24vyI3R8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XnBQj0vThz4f3nVF
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 22:15:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2CDC01A0359
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 22:15:44 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgD3662LETJne0jSBQ--.25020S2;
	Mon, 11 Nov 2024 22:15:43 +0800 (CST)
Subject: Re: [bpf-next 0/2] bpf: Add flag for batch operation
To: Florian Lehner <dev@der-flo.net>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, aspsk@isovalent.com,
 kees@kernel.org, quic_abchauha@quicinc.com, martin.kelly@crowdstrike.com,
 mykolal@fb.com, shuah@kernel.org, yikai.lin@vivo.com
References: <20241110112905.64616-1-dev@der-flo.net>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a917cefe-28d5-ceeb-5cfa-4fbb8f9a3c9d@huaweicloud.com>
Date: Mon, 11 Nov 2024 22:15:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241110112905.64616-1-dev@der-flo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgD3662LETJne0jSBQ--.25020S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFW5Cw1rCw1rCryrKry7Awb_yoWDJwb_ur
	W0yr97Jw48ZFW3tFyfKw4rZrW5G3yUKr1jq3WDtr4Utw15ZrsxJFsYyF9rJrW5W34UCr9a
	qr1DXrWrtr1fujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07jIksgUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 11/10/2024 7:29 PM, Florian Lehner wrote:
> Introduce a new flag for batch operations that allows the deletion process
> to continue even if certain keys are missing. This simplifies map flushing
> by eliminating the requirement to maintain a separate list of keys and
> makes sure maps can be flushed with a single batch delete operation.

Is it expensive to close and recreate a new map instead ? If it is
expensive, does it make more sense to add a new command to delete all
elements in the map ? Because reusing the deletion logic will make each
deletion involve an unnecessary lookup operation.
>
> Florian Lehner (2):
>   bpf: Add flag to continue batch operation
>   selftests/bpf: Add a test for batch operation flag
>
>  include/uapi/linux/bpf.h                      |  5 +++++
>  kernel/bpf/syscall.c                          | 14 ++++++++++---
>  tools/include/uapi/linux/bpf.h                |  5 +++++
>  .../bpf/map_tests/htab_map_batch_ops.c        | 20 ++++++++++++++++++-
>  4 files changed, 40 insertions(+), 4 deletions(-)
>


