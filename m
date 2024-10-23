Return-Path: <bpf+bounces-42884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE839AC73A
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 12:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A94B8B240E8
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 10:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56F19EEA1;
	Wed, 23 Oct 2024 10:00:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146414A639;
	Wed, 23 Oct 2024 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677605; cv=none; b=IEakDAt8sbzlo4Kwug/Yk7Hxzpb9cyG8BB9F8V5BPfkEGeElbGC7lZNvdov53liMXt68c/jfh2piokjj8pZTwCNlll+7qtEXu7ZNHQLSAx21wjTazckRCn4yJ9s3hnyPJqIAoCFD1OfrsZ0u6277W6DQtzjHpyUnUMwZWOHYBQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677605; c=relaxed/simple;
	bh=cYHwdl7GiBuJyzXrL6PqXsctrIZRoxCK9WuL3+RXjgI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OnsfetwzMG9+d00jD016BNWnSg5cakA10QJ0iwtU1YEG7TVj9+DszGr75AE1hZkVZoXMOx7AxwJ7QoaTzDhzl7R9UZ0hiHep0R2K+MWEUHg75qmLgWBgpfyselTi/3LgirjmjlF68yTSp9sSR5eQgb0s1Mmi8GoAVROwffkR/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XYPfL2nh3z4f3nKT;
	Wed, 23 Oct 2024 17:59:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9C18F1A0568;
	Wed, 23 Oct 2024 17:59:56 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgC34i4ZyRhn+owEEw--.59896S2;
	Wed, 23 Oct 2024 17:59:56 +0800 (CST)
Subject: Re: [PATCH] bpf: Fix out-of-bounds write in trie_get_next_key()
To: Byeonguk Jeong <jungbu2855@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZxcDzT/iv/f0Gyz0@localhost.localdomain>
 <26f04a6b-4248-6898-8612-793e02712017@huaweicloud.com>
 <Zxil/uyqq5qDHuRX@localhost.localdomain>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <da89a4cb-1824-2228-31ef-ad33ad6099cd@huaweicloud.com>
Date: Wed, 23 Oct 2024 17:59:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zxil/uyqq5qDHuRX@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgC34i4ZyRhn+owEEw--.59896S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr15GFyrZw18Gr1xKF1rJFb_yoWkuFX_ur
	4Dur97WwsFkw1qgFs2yrn8JFyDGFW0kFyjv3yrur1xX34rta13XFn7Cr90vFy3GF4fu34a
	yF98u3y5ta4avjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7
	UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/23/2024 3:30 PM, Byeonguk Jeong wrote:
> On Wed, Oct 23, 2024 at 10:03:44AM +0800, Hou Tao wrote:
>> Without the fix, there will be KASAN report as show below when dumping
>> all keys in the lpm-trie through bpf_map_get_next_key().
> Thank you for testing.

Alexei suggested adding a bpf self-test for the patch.  I think you
could reference the code in lpm_trie_map_batch_ops.c [1] or similar and
add a new file that uses bpf_map_get_next_key to demonstrate the
out-of-bound problem. The test can be run by ./test_maps. There is some
document for the procedure in [2].

[1]:  tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
[2]:
https://github.com/torvalds/linux/blob/master/Documentation/bpf/bpf_devel_QA.rst
>
>> However, I have a dumb question: does it make sense to reject the
>> element with prefixlen = 0 ? Because I can't think of a use case where a
>> zero-length prefix will be useful.
> With prefixlen = 0, it would always return -ENOENT, I think. Maybe it is
> good to reject it earlier!
>
> .

Which procedure will return -ENOENT ? I think the element with
prefixlen=0 could still be found through the key with prefixlen = 0.


