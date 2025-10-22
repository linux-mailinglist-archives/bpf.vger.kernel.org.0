Return-Path: <bpf+bounces-71835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A742BFDCAF
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 20:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 037C14F8596
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 18:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4C92EDD62;
	Wed, 22 Oct 2025 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EP15c+8Z"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA34B2EAB7D
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156909; cv=none; b=PGUBQuWXTribbxtxMMKsZKtNuvzVdJYyIeLKafJm3Nigc8nyIR93OxjL/NHjD/bhlxrj/4RUUmQhNUk7ZeRpQvX7QT7tFXMAk7ZrWUuBKmhlPQGRhZTCdOQg6lhEKZQv0KdmoAMd252qC6M7N4ggp7ld45vo2sTWpjOCYCBH7Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156909; c=relaxed/simple;
	bh=MXeNLNddQ4jvxUTQVwovWtDMVHVwhiulywOctMNy2mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMYZsdUWu+/zcaZOEkcqFiv1EeEOZRy/lhQQndEgW234CfxZtAWNEgGgkX2oTMP2M+P5HYoREWsTxLWwr2ew2zHFdDECpV1xPYdbU4FjytEEonsG4PSVqhYf/usF+DqEVTj0rDbOMw6Gw23Nc29o93Bz3vSJh7LgNIDCFgOXH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EP15c+8Z; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761156904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjqzvxTmikL5FOmQCQrIY1gpsRGBxx0jwN7oqp/m/lM=;
	b=EP15c+8ZpJlE8r0PhiZNqT3KJdeNs+10Yt6iGptu13afiLnb8HFR7i6FnQZKdTn4yZU/ZI
	GUEGrDxO+YOSrVKQLKbYI6Epo2v5K2jLVJKhXhWWLAtyYNByFC6uZVrBEzzT1CJh3P2ozD
	gU48vjKCer659VKfH4kJpnTTrf/oibU=
Date: Wed, 22 Oct 2025 11:14:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Skip bounds adjustment for conditional
 jumps on same register
Content-Language: en-GB
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 paul.chaignon@gmail.com, m.shachnai@gmail.com, luis.gerhorst@fau.de,
 colin.i.king@gmail.com, harishankar.vishwanathan@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Kaiyan Mei <M202472210@hust.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>
References: <20251022164457.1203756-1-kafai.wan@linux.dev>
 <20251022164457.1203756-2-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251022164457.1203756-2-kafai.wan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/22/25 9:44 AM, KaFai Wan wrote:
> When conditional jumps are performed on the same register (e.g., r0 <= r0,
> r0 > r0, r0 < r0) where the register holds a scalar with range, the verifier
> incorrectly attempts to adjust the register's min/max bounds. This leads to
> invalid range bounds and triggers a BUG warning:
>
> verifier bug: REG INVARIANTS VIOLATION (true_reg1): range bounds violation u64=[0x1, 0x0] s64=[0x1, 0x0] u32=[0x1, 0x0] s32=[0x1, 0x0] var_off=(0x0, 0x0)
> WARNING: CPU: 0 PID: 93 at kernel/bpf/verifier.c:2731 reg_bounds_sanity_check+0x163/0x220
> Modules linked in:
> CPU: 0 UID: 0 PID: 93 Comm: repro-x-3 Tainted: G        W           6.18.0-rc1-ge7586577b75f-dirty #218 PREEMPT(full)
> Tainted: [W]=WARN
> Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:reg_bounds_sanity_check+0x163/0x220
> Call Trace:
>   <TASK>
>   reg_set_min_max.part.0+0x1b1/0x360
>   check_cond_jmp_op+0x1195/0x1a60
>   do_check_common+0x33ac/0x33c0
>   ...
>
> The issue occurs in reg_set_min_max() function where bounds adjustment logic
> is applied even when both registers being compared are the same. Comparing a
> register with itself should not change its bounds since the comparison result
> is always known (e.g., r0 == r0 is always true, r0 < r0 is always false).
>
> Fix this by adding an early return in reg_set_min_max() when false_reg1 and
> false_reg2 point to the same register, skipping the unnecessary bounds
> adjustment that leads to the verifier bug.
>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Closes: https://lore.kernel.org/all/1881f0f5.300df.199f2576a01.Coremail.kaiyanm@hust.edu.cn/
> Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---
>   kernel/bpf/verifier.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6d175849e57a..420ad512d1af 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16429,6 +16429,10 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
>   	if (false_reg1->type != SCALAR_VALUE || false_reg2->type != SCALAR_VALUE)
>   		return 0;
>   
> +	/* If conditional jumps on the same register, skip the adjustment */
> +	if (false_reg1 == false_reg2)
> +		return 0;

Your change looks good. But this is a special case and it should not
happen for any compiler generated code. So could you investigate
why regs_refine_cond_op() does not work? Since false_reg1 and false_reg2
is the same, so register refinement should keep the same. Probably
some minor change in regs_refine_cond_op(...) should work?

> +
>   	/* fallthrough (FALSE) branch */
>   	regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_jmp32);
>   	reg_bounds_sync(false_reg1);


