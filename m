Return-Path: <bpf+bounces-76563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2960CBBA9E
	for <lists+bpf@lfdr.de>; Sun, 14 Dec 2025 13:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DC0330052A5
	for <lists+bpf@lfdr.de>; Sun, 14 Dec 2025 12:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DEA2FE042;
	Sun, 14 Dec 2025 12:36:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B028834;
	Sun, 14 Dec 2025 12:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765715783; cv=none; b=XLJERlzkpwQkqBquGJIst+wCoTFokJ4jsLMxDGrR/yoE+uNwArk3M2+PB2kJ3RXCdWGAi6UVKbZlpLw4BOdh8kWsc2CZbW6hvFAnpzt7kKS2mpfKoPfVX9Dh90Z9nojITYsPZDm9TDxzCXSOsHqzPXhO+vcC6kZ0mZpgCHdacdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765715783; c=relaxed/simple;
	bh=KtSX7xSMDpi8HxduNHgb8hMxv4BwkprSIHnf4t0iwhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7m4+TYg54AlcICg9Q0SVVqBIedg2cPPkrpc3fDais9MJ8w5bMBQFei6VoQbHi6bjyw3lobEvXjv6A51uW9+dJBxnY1xKgSNWH5Lh2pyo/MufG0V/ijLhTXFOhnP7/2sba/c7zXuDes+2iyFQXxjq5n4sVTnInANiYAMuaNJQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [117.22.160.58])
	by gateway (Coremail) with SMTP id _____8Dx+tE5rz5plQkuAA--.34840S3;
	Sun, 14 Dec 2025 20:36:09 +0800 (CST)
Received: from [192.168.0.111] (unknown [117.22.160.58])
	by front1 (Coremail) with SMTP id qMiowJDx_8Mzrz5pdD5JAQ--.64818S3;
	Sun, 14 Dec 2025 20:36:07 +0800 (CST)
Message-ID: <c6c385b0-60cf-b0c4-1962-974e783b131a@loongson.cn>
Date: Sun, 14 Dec 2025 20:36:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 3/4] LoongArch: BPF: Enhance trampoline support for
 kernel and module tracing
Content-Language: en-US
To: Chenghao Duan <duanchenghao@kylinos.cn>, hengqi.chen@gmail.com,
 chenhuacai@kernel.org
Cc: kernel@xen0n.name, zhangtianyang@loongson.cn, masahiroy@kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, youling.tang@linux.dev, jianghaoran@kylinos.cn,
 vincent.mc.li@gmail.com
References: <20251212091103.1247753-1-duanchenghao@kylinos.cn>
 <20251212091103.1247753-4-duanchenghao@kylinos.cn>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <20251212091103.1247753-4-duanchenghao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJDx_8Mzrz5pdD5JAQ--.64818S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1fGw1kAFW3AF4UCw18CrX_yoW8Cw1kpa
	yrKF98KFsIgr1jkFs7Gw4xXFyfua9xWrZ8Gr4jqw1rC3Z8Jr1SkF4fKw4Yva48Cr4fC34I
	vr1jyr43K3Z0vFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=

On 12/12/25 17:11, Chenghao Duan wrote:
> This patch addresses two main issues in the LoongArch BPF trampoline
> implementation:
> 
> 1. BPF-to-BPF call handling:
>   - Modify the build_prologue function to ensure that the value of the
>   return address register ra is saved to t0 before entering the
>   trampoline operation.
>   - This ensures that the return address handling logic is accurate and
>   error-free when a BPF program calls another BPF program.
> 
> 2. Enable Module Function Tracing Support:
>   - Remove the previous restrictions that blocked the tracing of kernel
>   module functions.
>   - Fix the issue that previously caused kernel lockups when attempting
>   to trace module functions
> 
> 3. Related Function Optimizations:
>   - Adjust the jump offset of tail calls to ensure correct instruction
>     alignment.
>   - Enhance the bpf_arch_text_poke() function to enable accurate location
>   of BPF program entry points.
>   - Refine the trampoline return logic to ensure that the register data
>   is correct when returning to both the traced function and the parent
>   function.
> 
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>

As described in the commit message, your changes include many kinds
of contents, thanks for the fixes and optimizations.

In order to avoid introducing bugs in the middle, please separate each
logical change into a separate patch, each patch should make an easily
understood change that can be verified by reviewers, each patch should
be justifiable on its own merits.

The current patch #4 can be put after the current patch #2 as a
preparation for the bpf patches.

Furthermore, it would be better to put the related test cases in the
commit message of each patch rather than in the cover letter, so that
it can be verified easily to know what this patch affected and can be
recorded in the git log.

And also please add Fixes tag for each patch if possible.

Thanks,
Tiezhu


