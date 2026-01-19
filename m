Return-Path: <bpf+bounces-79429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB96D3A1AF
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 09:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A8233043920
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 08:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E4733F388;
	Mon, 19 Jan 2026 08:31:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5902DC762
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811494; cv=none; b=Z6AUILuPpJbX5vEMTVxH8YO9V3UCAYWdL0uHDkdORUZxmkDSN8R9Zql+E8vKT58Bv+9czYtd14uB//D1ISoY5JewoJdXDBlNGckHDfXmfWD5csV29wNrQGW4hquh/p0QEDgDZ3aJllKY67msDSsyHrRQBAgfkH6cTHMI4b9pEiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811494; c=relaxed/simple;
	bh=z+jqI5WJfFG08XeERngzl0WSUOPcTrHFKxAaVcD2Kmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9IWG3nPZZ86Rg+Q6frO5JbJXCl8m9L/2sm03/ovkA5QuyaN2UT8EY3e3R1vb3JhxJMmW+uOK95ByY3uZ0XCdJxpXfZyMhYShh4ciw+BwgCUd45j4e6A8h5FqKMydRs+flkpvMoAbVWo6GLeEtyRcqfPBsoGZPSug2p15HYTrYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.146.110])
	by mtasvr (Coremail) with SMTP id _____wDHZGW1621plNoUAA--.883S3;
	Mon, 19 Jan 2026 16:30:46 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.146.110])
	by mail-app4 (Coremail) with SMTP id zi_KCgA38Ia0621pTj7DBA--.21915S2;
	Mon, 19 Jan 2026 16:30:44 +0800 (CST)
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
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Add range tracking for BPF_DIV and BPF_MOD
Date: Mon, 19 Jan 2026 16:30:37 +0800
Message-ID: <20260119083044.163450-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAADnVQJb+bo5Nhzk+YwTh6yx+Du3N3XwF1hQ9xgY3Mg-9WLT4g@mail.gmail.com>
References: <CAADnVQJb+bo5Nhzk+YwTh6yx+Du3N3XwF1hQ9xgY3Mg-9WLT4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgA38Ia0621pTj7DBA--.21915S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAg4OCmlqlIUZGwACsa
X-CM-DELIVERINFO: =?B?1za3RAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9CfJDEaoK/jOYGp5PqpbEWD//CF5BKj6fzEQYfDuaVy0T6cebXqmOdzUC1komobOsd9g
	8hOb8ZI5vxwDKCkXGIaJSQP5r/I7H0Ch+ll2350Cn3LfZttYN1AJODWIZyknIg==
X-Coremail-Antispam: 1Uk129KBj9xXoWrKF1rtrWkKFWxAF47Wr1ruFX_yoWkCwcEkw
	1DWwn3C3yUuw45GanFg3W3u34fA3yDJw4Sg3yjqa17AryfXFWkWrs5C392qFyDta13tFyf
	Kwn0gF4agrZ7ZosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbTAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7ku4UUUUU

Hi Alexei,

Thank you for the review.

On 1/18/26 01:22, Alexei Starovoitov wrote:
> On Fri, Jan 16, 2026 at 2:33 AM Yazhou Tang <tangyazhou@zju.edu.cn> wrote:
>>
>>
>> +static void __reset_reg64_and_tnum(struct bpf_reg_state *reg)
>> +{
>> +       __mark_reg64_unbounded(reg);
>> +       reg->var_off = tnum_unknown;
>> +}
>> +
>> +static void __reset_reg32_and_tnum(struct bpf_reg_state *reg)
>> +{
>> +       __mark_reg32_unbounded(reg);
>> +       reg->var_off = tnum_unknown;
>> +}
>
> Looks good overall. Probably remove __ from two helpers above,
> and fix build errors:
>
>    verifier.c:(.text+0x1f5d4): undefined reference to `__udivdi3'
>
>> +       *dst_umin = *dst_umin / src_val;
>> +       *dst_umax = *dst_umax / src_val;
>
> since plain C division cannot be used in the kernel.
> See how bpf interpreter in core.c does it.
>
> pw-bot: cr

For v5, I will rename the helpers to `reset_reg(32|64)_and_tnum` as suggested.

Regarding the build errors, I will fix them by replacing the plain C division
with div64_u64() and div64_s64() for 64-bit operations, ensuring compatibility
with 32-bit architectures.

I will send v5 shortly.

Best regards,

Yazhou


