Return-Path: <bpf+bounces-78986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8151D22692
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 06:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF0CD302A384
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 05:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2DC2D7DD3;
	Thu, 15 Jan 2026 05:06:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F144D2D1F64
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 05:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768453574; cv=none; b=XHEqzamIGuZKAA9VwkijwSqf8BZnu+TL6G3u07u3J73HrXLvYjzWXMmNnRcvawNSnsHrxvp+xtEAAZgSKFxjnpEJB4RQjskjSHUBaT6OXunQoYAnxMpaPXSD0YIM7rXtIInyDJ//ZaFmfy82OIDZlhZ9QjGbGHUXxq8j6+yKbCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768453574; c=relaxed/simple;
	bh=8tWNTwQvtqjLqO2v75ZFapPR632EShxjs9GYNiFYLH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTFUUBST1PzpA4wUXgPWvEt74ADX6fzpOV0ffouUfpjqRdDgGEsNVWrzkfNcTxP945hSGgzi1EQPjJfO78ylM6BVbyEXRmlQukQtG6DHcaCLnkPFPVP0gI2HSASrZEIHfkf8I9ZUSVbJ46uhEFlTsueIWxN9xjFJC/I75dvUjas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.146.110])
	by mtasvr (Coremail) with SMTP id _____wDXmFGjdWhpZ9XHAQ--.916S3;
	Thu, 15 Jan 2026 13:05:40 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.146.110])
	by mail-app4 (Coremail) with SMTP id zi_KCgBn_IGhdWhpZ2WkBA--.63324S2;
	Thu, 15 Jan 2026 13:05:37 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	shenghaoyuan0928@163.com,
	song@kernel.org,
	syzbot@syzkaller.appspotmail.com,
	tangyazhou518@outlook.com,
	tangyazhou@zju.edu.cn,
	yonghong.song@linux.dev,
	ziye@zju.edu.cn
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Add range tracking for BPF_DIV and BPF_MOD
Date: Thu, 15 Jan 2026 13:05:37 +0800
Message-ID: <20260115050537.492661-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAADnVQL-V68YSTjg0N-yTqQmJcy562S9on3AEWgSHWLoEYQDFg@mail.gmail.com>
References: <CAADnVQL-V68YSTjg0N-yTqQmJcy562S9on3AEWgSHWLoEYQDFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgBn_IGhdWhpZ2WkBA--.63324S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgAMCmln8YUQwQAAsr
X-CM-DELIVERINFO: =?B?OtZFOAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9NzBcyQ47QZ1yp+DDFmdOuYJEs09yU+y82xwUWDkjNmLYNXk/ip095uA8CK8GE6JOGOG
	cf69OV7kKGeZFGsyqcyK43J7vFLGoBTt+nFptXMW/aNDTMJ9f5lUAuf3dXdPdQ==
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww1kKw18JrW7tF4xXFy3WrX_yoW8tFW5pr
	s8tryjvr4kGa92ya4xuw4xurn5urs5J3W5ArykK3srA3s8KFnavF4fKF1UWasxGrs2qFW2
	kayj9FZ8Za4qkFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8YFAJUUUUU==

Hi Alexei,

On 1/15/26 11:53 AM, Alexei Starovoitov wrote:
> 1.
> Think of ways to reduce copy paste. Some of it is unavoidable,
> but 'easy to copy' shouldn't be a default mode of operation.
>
> 2.
> Use proper kernel comment style. We don't use networking anymore
> for any new code.
>
> 3.
> The 'bool changed' is a bit difficult to follow.
> It seem you've tried to share the code, but it seem doing 'void'
> return BPF_MOD and using two helpers that do:
> __mark_reg64/32_unbounded(dst_reg);
> dst_reg->var_off = tnum_unknown;
> would be easier to follow, since all assignments will be in one place,
> instead of split between scalar[32|64]_min_max_[su]mod()
> and adjust_scalar_min_max_vals().
> Or even explicitly doing:
> +       dst_reg->u32_min_value = 0;
> +       dst_reg->u32_max_value = U32_MAX;
> //+       return true;
> +       __mark_reg64_unbounded(dst_reg); and tnum_unknown
>
> would make the intent more clear.
>
> 4.
> smod64/32 have 3 supported combinations depending on the sign of smin/smax,
> I couldn't find where selftests cover them all.
>
> It seem the tests do:
> +       if w1 s< -8 goto l0_%=;                         \
> +       if w1 s> 10 goto l0_%=;                         \
> (or the same thing with r1)
>
> so only this part is tested?
>
> +       } else {
> +               *dst_smin = -res_max_abs;
> +               *dst_smax = res_max_abs;
> +       }

Thank you for the detailed feedback. I agree with all your points.

For v4, I have refactored the code to improve readability and coverage:

1. Refactoring: I changed the scalar*_min_max_*mod functions to return void.
   The logic for resetting var_off and marking the other bit-width as unbounded
   is now explicitly handled inside these helpers, rather than splitting it
   between the helper and the caller. This removes the confusing bool changed logic.

2. Comments: I updated all multi-line comments to follow the standard kernel style.

3. Tests: You are right that the previous tests only covered the "mixed sign"
   case for SMOD. I have added new test cases to explicitly cover:
   - Strictly positive dividend (e.g., [10, 12] s% 3)
   - Strictly negative dividend (e.g., [-12, -10] s% 3)
   - Mixed sign dividend (existing tests)
   Additionally, for consistency, I have also added similar "strictly positive"
   and "strictly negative" test cases for SDIV.

I will send v4 shortly.

Best regards,

Yazhou


