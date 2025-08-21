Return-Path: <bpf+bounces-66213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C709FB2FB8D
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 15:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3688516D4BD
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 13:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636E72EC573;
	Thu, 21 Aug 2025 13:52:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16B52EC56A
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784350; cv=none; b=YyE1kJYxDPUcVTj06Wfy46nwJrFFSiA1kcMPrWXl2ePM9QYn3UXeG5JquFszuePQZoiuBQofEn8IeTFE98LwVYNsD6I5AkzVn4aCQiIRxvma3DR/Q8CkZooU6UE0OfQpGmTm8++7kU+PwnzgTLo4z3ntzvu3MpxpoVka2pcB+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784350; c=relaxed/simple;
	bh=nRoVIFHV/eK+TRh5s6v8ZLdGDcFTurK0WaMx3km/nWM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S5DqnUHpfSojyzktcEBgrmGn4UsQgJtSG1OTxyr9fFbMfVaExsKZ1x0smM8tqseu6MZulpvrWb7SZ8sMnsTmssa+Yv5n5ghuqlTKJTNOk6zvgbzdoNaivqpUMw7kJX6Xx1v7j94jDNO83aYuyQRMHftJT1J293ABPs2QuIdbcbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxqdGWJKdoPHUBAA--.2722S3;
	Thu, 21 Aug 2025 21:52:22 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxQMKUJKdokcFdAA--.20579S3;
	Thu, 21 Aug 2025 21:52:21 +0800 (CST)
Subject: Re: [PATCH 2/3] LoongArch: BPF: Sign extend struct ops return values
 properly
To: Hengqi Chen <hengqi.chen@gmail.com>, chenhuacai@kernel.org,
 jianghaoran@kylinos.cn, duanchenghao@kylinos.cn, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 vincent.mc.li@gmail.com
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev
References: <20250821091003.404870-1-hengqi.chen@gmail.com>
 <20250821091003.404870-3-hengqi.chen@gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b4abb062-f11b-2246-ac9e-02c871e68e86@loongson.cn>
Date: Thu, 21 Aug 2025 21:52:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250821091003.404870-3-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxQMKUJKdokcFdAA--.20579S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GF43JF1fGFWkuw45AFWfXrc_yoWfJFcEkF
	Z3ta4DCr18Ww1rAw40g3s3XF97Z3s0gr18Gw45Xr93K34YgryxAFsYqry5J3yxArZ7Jw4a
	q390yF1SkF4S9osvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa02
	0Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_Wryl
	Yx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI
	0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==

On 2025/8/21 下午5:10, Hengqi Chen wrote:
> The ns_bpf_qdisc selftest triggers a kernel panic:
...

> The bpf_fifo_dequeue prog returns a skb which is a pointer.
> The pointer is treated as a 32bit value and sign extend to
> 64bit in epilogue. This behavior is right for most bpf prog
> types but wrong for struct ops which requires LoongArch ABI.
> 
> So let's sign extend struct ops return values according to
> the return value spec in function model.
> 
> Fixes: 6abf17d690d8 ("LoongArch: BPF: Add struct ops support for trampoline")
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

The following related testcases passed on LoongArch:

   sudo modprobe test_bpf
   sudo ./test_progs -a ns_bpf_qdisc
   sudo ./test_progs -t struct_ops -d struct_ops_multi_pages

Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks,
Tiezhu


