Return-Path: <bpf+bounces-71197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A39BE7F0E
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 12:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F665E4753
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 10:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE1730F804;
	Fri, 17 Oct 2025 10:05:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39D431197E;
	Fri, 17 Oct 2025 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695519; cv=none; b=GsgnAckKaioihJRd/iycbkXOd/1tAl+tB+ArA33VDmTunPpt0xheYhAkLoCgsHR2E/nkjE+i0MEOoA9My6NiWtDO0okAuIBOI/psKuQ+dWPec66PjKoUOLZch8NcegbAY0pcDEEjd8256SMsedr9+AvGG3IqRp6s4ZYD2pzrd1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695519; c=relaxed/simple;
	bh=6z5qiYejD0Z6XSlHGhdgDanXj77un6wBOUOjfeB4nq0=;
	h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=f/dzP8m7Tnw0IxR8DrqLaLGW9grOv0muiivFbX7K8eA16Q8WMGkk8q7MpJuXGuwLX6O/onELB9Ux5NBwee9CpgndE3kWDrLr8dTQc7NdqHX1QDfVibNsq7M7eWRTEBhTIvXthrmfZ4BzGtfSCFPH6ZZ3hrrnb8FpSWD4u4aUy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxmdHWFPJoUkwXAA--.50505S3;
	Fri, 17 Oct 2025 18:05:11 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxicDWFPJoHdXtAA--.42500S3;
	Fri, 17 Oct 2025 18:05:10 +0800 (CST)
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [selftests/bpf QUESTION] What is the proper way to fix the build
 error
Message-ID: <5ca1d6a6-5e5a-3485-d3cd-f9439612d1f3@loongson.cn>
Date: Fri, 17 Oct 2025 18:05:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJBxicDWFPJoHdXtAA--.42500S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Xw45Ww1fuw18Aw1kJr4fWFX_yoW8Jr4rpw
	4kJ390gFn8tF1xZa1xAw4jgF1qgFs5AFZ5Gw4xZrykuw18tw4vgFZ7Kry5W3s8u395Jwn5
	Zas29w43uF10y3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwmhFDUUU
	U

Hi,

When compiling tools/testing/selftests/bpf, there is a build error:

   CLNG-BPF [test_progs] verifier_global_ptr_args.bpf.o
progs/verifier_global_ptr_args.c:228:5: error: redefinition of 'off' as 
different kind of symbol
   228 | u32 off;
       |     ^
/home/fedora/newfixbpf.git/tools/testing/selftests/bpf/tools/include/vmlinux.h:21409:2: 
note: previous definition is here
  21409 |         off = 0,
        |         ^
1 error generated.

tools/testing/selftests/bpf/tools/include/vmlinux.h:21409

enum i40e_ptp_gpio_pin_state {
         end = -2,
         invalid = -1,
         off = 0,
         in_A = 1,
         in_B = 2,
         out_A = 3,
         out_B = 4,
};

The previous definition of "off" is in
drivers/net/ethernet/intel/i40e/i40e_ptp.c:

enum i40e_ptp_gpio_pin_state {
	end = -2,
	invalid,
	off,
	in_A,
	in_B,
	out_A,
	out_B,
};

CONFIG_I40E is set in the defconfig file to build i40e_ptp.c after the
commit 032676ff8217 (LoongArch: Update Loongson-3 default config file)
in 6.18-rc1.

What is the proper way to fix the build error?
(1) just disable CONFIG_I40E (CONFIG_I40E=n), then no "off" in vmlinux.h
(2) set it as a module (CONFIG_I40E=m), then no "off" in vmlinux.h
(3) modify the variable name "off" in verifier_global_ptr_args.c

Thanks,
Tiezhu


