Return-Path: <bpf+bounces-78842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 069A2D1C9C5
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 06:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CAD8C300BF92
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 05:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0548352C2B;
	Wed, 14 Jan 2026 05:48:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7512367B8
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 05:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768369730; cv=none; b=MrMy+rILuRa8f11291BPePZ2anKnGhmF5SL8RmBtA7hM1SKT9cIBHsHtr/O0sScp/bm42StLbvClXMPF9g99eTsku253cHY5pKVAFOpFycMV2kVZh2oWt5xiqMDTezgvlvbcsuPv7AzgOWwkGv/HLAYBgEDIQsc01QmNTk1av8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768369730; c=relaxed/simple;
	bh=ynrrA+B7xZrB5Q8eiPcvMu9Gs2QDctSmBgygfdHBeTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3B/eIyzYB8hbtyThTCxmJBADDSiqh/oe7IsNvASElPKCDJVY9j4csXuBXqrJfxuuci9l47vqNeQmylw5Z+YDxIqsQGdE4NidZgWIni7gtWhTuIL9uRxyuLUUMkS9pDQdFbg/+Sbi5hNDvkdLh3Iv/OyIi3+MVwkZKGYvlevoIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.14.28.207])
	by mtasvr (Coremail) with SMTP id _____wDXKBANLmdp6VbAAQ--.2721S3;
	Wed, 14 Jan 2026 13:47:58 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.14.28.207])
	by mail-app3 (Coremail) with SMTP id zS_KCgDX2GsILmdpGCaYBQ--.18593S2;
	Wed, 14 Jan 2026 13:47:52 +0800 (CST)
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
Date: Wed, 14 Jan 2026 13:47:52 +0800
Message-ID: <20260114054752.3908998-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAADnVQL3gGe4iK8FZWnT3frRjAHtnNwGp8m5J8OSVcX0BCorUA@mail.gmail.com>
References: <CAADnVQL3gGe4iK8FZWnT3frRjAHtnNwGp8m5J8OSVcX0BCorUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgDX2GsILmdpGCaYBQ--.18593S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAhELCmlmoAUPiwABs9
X-CM-DELIVERINFO: =?B?M+zb6QXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9PYE3aGw2rE94YMgVJ48l7odRxp2Py1N85nb5MG497aFz3EpVzrmJfXEwZbrRGCyJXlu
	WCLebdUgXrlV/5+WvlGlx14IXtF5jwHia3Ra9hviey2O99tnX5kLFPFmlsir3Q==
X-Coremail-Antispam: 1Uk129KBj9xXoWrZr43Wr1rJryUCFWftF1kWFX_yoWktrg_ur
	Wvgr92kw4vvFsrtF45KFsrZFZIqF1kWryrAayUXry7Ga4kXFnxAF97ur9xC348J3yrur98
	Wr1qqrWayr9F9osvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
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

> The whole thing looks very much AI generated.
> It can spit out a lot of code, but submitter (YOU) must
> think it through before submitting.
> In the above... 4 almost equivalent helpers don't bother you?!
> 
> and b==0 check... isn't it obvious that might be
> easier to read and less verbose to do it once before all that?
> 
> You need to step up the quality of this patchset.
> AI is NOT your friend.
> 
> pw-bot: cr

I accept the criticism regarding the code verbosity and the redundant
helpers.

To clarify: I assure you that every line of code in this patch was
written by hand.

The verbosity and the redundant helpers were not generated by AI,
but were remnants from my v2 implementation where I handled full
interval-based divisors. When I simplified the logic for v3 to handle
constants only, I failed to clean up the structure sufficiently.
I apologize for this oversight.

I will clean this up in v4 by removing the helpers and hoisting the
zero-checks as suggested.

Before I submit v4, could you please let me know if there are any other
issues you see in the current logic or structure? I want to ensure the
next version meets the quality standards.

Best regards,

Yazhou


