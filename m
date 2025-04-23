Return-Path: <bpf+bounces-56473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2311EA97C17
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 03:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FE517FEE3
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 01:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC2325D550;
	Wed, 23 Apr 2025 01:28:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C22E1EA7FD;
	Wed, 23 Apr 2025 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745371694; cv=none; b=p2GTG+kvF0cq/44F0vwYJDruYbRV0o0vbt6PDK71HAd9gFAnXSESKBC7yV2zCvTzOxwt2F24HLVnuBQPVf9uhnvC7A87g1Qoy2ZcDIsKCnk/fYy6WXCRYAD0ezARhu6hAFd7CbSQbGF6/taADFvQX5T3abb0bqg522o9V+najDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745371694; c=relaxed/simple;
	bh=raHCsdM6p0oc+ERO+qqhoYKMKdxIncSRd/5/ilrt4Vs=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=n/4cfOPPVCChgqXENBCe6ZjhrttS5JCushruqSukOI1Ni5zmiLbqdPFVq9gyXRa5aydNsY6hVcX0j8BY3fAQEKwX4Bxo7CsbyOA2Ob3QuBZCf2jJ2b/RlZzN/xQV9pFeCD0KYWQ+9IBF4QpXVoB2tr7hHP7LiUooRtx02c7QmqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxQK0pQghoAl_EAA--.46287S3;
	Wed, 23 Apr 2025 09:28:09 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxvhsmQghoROaQAA--.46948S3;
	Wed, 23 Apr 2025 09:28:06 +0800 (CST)
Subject: Re: BUG: bpf test case fails to run on LoongArch
To: bibo mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>
References: <32989acf-93ef-b90f-c3ba-2a3c07dee4a3@loongson.cn>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <8cd87100-88f3-687d-6704-f4fec0ca48b3@loongson.cn>
Date: Wed, 23 Apr 2025 09:28:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <32989acf-93ef-b90f-c3ba-2a3c07dee4a3@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMDxvhsmQghoROaQAA--.46948S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JrWDWr4Uuw1fCr13Cw47WrX_yoWkXFg_ua
	4kWFWktr90vrs8tr4Ykw4DZrZxCFsrtryUXr1DX3yUG3yxJ3Z8Zr4UXFZxWayDW393Wrnr
	WrnIg3s8K3WjkosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F4
	0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_
	Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbI
	xvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU
	=

On 04/21/2025 10:52 AM, bibo mao wrote:
> Hi,
>
> When I run built-in bpf test case with lib/test_bpf.c,
> it reports such error, I do not know whether it is a problem.
>
>  test_bpf: #843 ALU32_RSH_X: all shift values jited:1 239 PASS
>  test_bpf: #844 ALU32_ARSH_X: all shift values jited:1 237 PASS
>  test_bpf: #845 ALU64_LSH_X: all shift values with the same register
>  ------------[ cut here ]------------
>  kernel BUG at lib/test_bpf.c:794!

This is a known issue I have ever encountered.
I guess your GCC version is 14.1, this is a bug of GCC,
it has been fixed in the higher version, you can update
you GCC version (14.2+).

$ gcc --version | head -1
gcc (GCC) 14.2.1 20241104
$ dmesg -t | grep Summary
test_bpf: Summary: 1053 PASSED, 0 FAILED, [0/1041 JIT'ed]
test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [0/10 JIT'ed]
test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
test_bpf: Summary: 1053 PASSED, 0 FAILED, [1041/1041 JIT'ed]
test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED

Thanks,
Tiezhu


