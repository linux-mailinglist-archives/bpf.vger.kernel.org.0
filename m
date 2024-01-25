Return-Path: <bpf+bounces-20294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16B383B7A4
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 04:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736D71F25796
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 03:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945C067C6D;
	Thu, 25 Jan 2024 03:13:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7CC6FAE
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152382; cv=none; b=Mj5QmGFWBFY+mq5lJRNysgJiyLWOzGB4Nci94Rs3I01dBRuYDG/AdqtDVWujoPGKdGRbwNx7FmbZ8nqnwPbJIH8au47Kkn22eV382x2SPfDLy7dqfu/xG6yU0LrlEWaMTmPckRnVyjyMJEXZji9aWeUIVyUHgVb0YjD2MHsWuMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152382; c=relaxed/simple;
	bh=z10/XO5ud5A6KIRzXZE/627Eu8QSrHAkuuGTOk2UPLY=;
	h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=S9AiDyyAZkbcLsx/yTfXsYHYo3BE9zj5x/mH4qMAxfdX6KnYRCnqf8YSW11oudDZDFwdkV3V9ctOJ/AjGOHNbF1MDzpT6nJESXdg837lb3OGlOJdiev/3KrFaKwXCfFvMnsFI7gmvqaj71P+ZerjcnR6WQnGqG/s/8T8fvvSUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxaOi60bFlEkkFAA--.737S3;
	Thu, 25 Jan 2024 11:12:58 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX8+z0bFlu1oYAA--.41057S3;
	Thu, 25 Jan 2024 11:12:52 +0800 (CST)
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Add missing line break in test_verifier
Message-ID: <c318466f-ffd7-6bdf-9d95-93a952106bd5@loongson.cn>
Date: Thu, 25 Jan 2024 11:12:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8AxX8+z0bFlu1oYAA--.41057S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF1ktw1kGrWruF43Kr43XFc_yoW8XFykpF
	4kXF1qyFn8XF1jkFn2yr4j9F4FvFWv9w43Ka4rG3sFvFn8X3sFqr1fAFW3Xas5WrWqvw1f
	A3ZrKr1jgw1UWFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9mb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r1j6r4UMcIj6xIIjxv2
	0xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4
	x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4U
	YxBIdaVFxhVjvjDU0xZFpf9x07UMbytUUUUU=

Hi Andrii,

There was a line break at the end of printf() in the original patch [1],
but it is missing with small change in the git tree. Would you be able
to squash below trivial change into the current commit [2]?

diff --git a/tools/testing/selftests/bpf/test_verifier.c 
b/tools/testing/selftests/bpf/test_verifier.c
index e1a1dfe8d7fa..df04bda1c927 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1527,7 +1527,7 @@ static void do_test_single(struct bpf_test *test, 
bool unpriv,
         int i, err;

         if ((test->flags & F_NEEDS_JIT_ENABLED) && jit_disabled) {
-               printf("SKIP (requires BPF JIT)");
+               printf("SKIP (requires BPF JIT)\n");
                 skips++;
                 sched_yield();
                 return;

Otherwise, there are no break lines in the test log, like this:

#106/p inline simple bpf_loop call SKIP (requires BPF JIT)#107/p don't 
inline bpf_loop call, flags non-zero SKIP (requires BPF JIT)#108/p don't 
inline bpf_loop call, callback non-constant SKIP (requires BPF 
JIT)#109/p bpf_loop_inline and a dead func SKIP (requires BPF JIT)#110/p 
bpf_loop_inline stack locations for loop vars SKIP (requires BPF 
JIT)#111/p inline bpf_loop call in a big program SKIP (requires BPF 
JIT)#112/p BPF_ST_MEM stack imm non-zero OK

[1] 
https://lore.kernel.org/bpf/20240123090351.2207-3-yangtiezhu@loongson.cn/
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=0b50478fd877

Thanks,
Tiezhu


