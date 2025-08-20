Return-Path: <bpf+bounces-66061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66B2B2D3ED
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 08:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D49624B96
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 06:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7B22206B8;
	Wed, 20 Aug 2025 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUYRV74J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8221494A8
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755670516; cv=none; b=o/msbHnQc6gcN3P207VJmiIcqSnbVAdmCC3mvp17DxIfIp5/GaJYL8iWuYeQxdKGu0V3lz3yYEH+TPIkfWPlThwwLSpSt/EVV4CgQ11vlNGUPoBUrbyAZYAc+zq1ldxJo+iZEX7Uj6Pr6KKGQRcaAXU0CSvPwbm0fRXsmpz8TGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755670516; c=relaxed/simple;
	bh=B8PLH0ZnuDuuqaYAjdnjxH0qwa/OfmFo1atIWuSA+bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxU84YAwVuKTj0FC8NOIUTpzWyJtV0Ns+hsLX3+63vJDtuUCST+PNukHhYMf2mwviM0xfxBgeDL46woFpMUz2WeEDGaob299ETNdjt60ZuUtRws3H/7FtrehIK2dFwnzg4qbQRspGuJXcxrpXDoad1b1jK7/GJYLnWGU0I8RPxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUYRV74J; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70a9282f475so51822886d6.1
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 23:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755670514; x=1756275314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4oMcn5iy61UyATDxzcNaZTql1PIn7vnqrhFvNcKYpA=;
        b=BUYRV74J+t7gp9loQFskRq6zwcWZV5iA9ra5VUBEzt7hyStfEIUuqEhanL99I2X+Nw
         mpmLMg5oiiD1Gn/OZ0f87BPourls6IJFCdSJa0gUIbRD2/AH0AlvOMWlR9pg0yyUuZyG
         B1UGe/Sv8q7R03FeE4G7AUuGlUI5VnbOBAqKHph8VBoLc5nIrdNk4o1mUfxfP1gihUIF
         M6Fv8ftLMzyu9YcwoohV6xEZ8V4Ssr2roUurgaZwUek6FCtxoG5+wqywdTsa+eCxD12U
         6RM4gEo+4tQzpWjv9Se+aiZQX25SFzJXdnukn/CZecNRcELPROqjI2kIiAz7Iho1g8+f
         h60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755670514; x=1756275314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4oMcn5iy61UyATDxzcNaZTql1PIn7vnqrhFvNcKYpA=;
        b=L/3OcnxnMcASVxOFOGdZirjOERcBTPRNB/p2jqI40hMhN3dQ0TuNziI0bMWzXwMQcP
         x/UBOTP6+Y81J/fQoCHjsuDiSJ7ziH2fRKVluKp+H0DYps/j4MZaX0QXZqt6mIAe5R1V
         779RORMhjzck0qCAH2jOoAYEhkLuYrRXeGB9GLaxnrkpr1uSBlRZNAPrnruvgNlkJijd
         920kIz2FxR1uCnaCA2yoe3WEI9wfTwZls7CwP7O04u6KFG3jZYG2bRt5GyxZJTVZ/93G
         SjhZQgOTWDtjSJCQl7LxEEVuN+HkPefqTp3Icj3tXZiOAJJRudelKxzWccerVzSGW1Wp
         h1EA==
X-Forwarded-Encrypted: i=1; AJvYcCU0ovFX+YTiem8HLLdcmJ0ZtX1xHxREMyVUcxcZX09AzrzF05FdGO8u0y03QhvjQFAmUnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2AEX2JnZvRhfySTF7XXKZKrtqNxZKAOwBsg0wWQxJYbBrxJR
	d7XrYxlsfFgye3fxcfHtnbV29KeQxrqn0y9FYUxBvu+hDcTSECh0sWcF
X-Gm-Gg: ASbGncsg5vcuxt+yIIVl+MuPktBKkuW7M3azfPu+A8+t6or4/+PbqVTmyBz4zhfMzRy
	cxVDb+fr/joC52/p6c8ejxjlOuwWP5iIUiXRfOkGWoGfCn3flRrFFkc3jFnROM91StrRSeN3bN0
	w5OqM+OcrT1lYrzcNeDvq3TKVMEnOVjszN0yxBAzq/YvUPshPezJGD9ktKD7vbGaJTguZnzaXAZ
	UBIwCABR295ex4UrKUM7pV0EM7JcmakOASaMoB/3vzrha+PfItTiNOZyglBCpXXItvGCAutgFOi
	COboepe2TZSkiJIATCnEBBO2Bpl5ZRbDq48ip99n1iyU//ntQW+Ld1q01JP2UM6mG+AKuw4KdIJ
	8p+UNhSYb3SFrQonhymtbPKMvyuRWnZt1XMJpG8f3gY+9aBOZKLyeQxwNNJXvlnvLox9NHoQAY+
	OyhlsFw9cX+MPu3j1UgoTIOE54/lrRJQ==
X-Google-Smtp-Source: AGHT+IHQ8x13Fs2VpYwcrLonCvPIGY7JB/5zSoWP4O8BvWK6xJ28jo4KlR0Ua9joEyKAwZIpBF8dYQ==
X-Received: by 2002:a05:6214:8093:b0:70d:7a16:60bd with SMTP id 6a1803df08f44-70d7a1662edmr8050476d6.66.1755670513632;
        Tue, 19 Aug 2025 23:15:13 -0700 (PDT)
Received: from lima-default.. (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70bb34e3fa9sm63122206d6.22.2025.08.19.23.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 23:15:13 -0700 (PDT)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: eddyz87@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	nandakumar@nandakumar.co.in
Subject: Re: [PATCH v2 bpf-next] bpf: improve the general precision of tnum_mul
Date: Wed, 20 Aug 2025 02:15:10 -0400
Message-ID: <20250820061512.1072806-1-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <e7cb82ac838e28620324f70907235d2b8c75262f.camel@gmail.com>
References: <e7cb82ac838e28620324f70907235d2b8c75262f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 2025-08-15 at 19:35 +0530, Nandakumar Edamana wrote:

[...]

> This commit addresses a challenge explained in an open question ("How
> can we incorporate correlation in unknown bits across partial
> products?") left by Harishankar et al. in their paper:
> https://arxiv.org/abs/2105.05398

This is nice work on improving the precision of the tnum_mul algorithm
Nandakumar. I had a few questions and comments (below).

> When LSB(a) is uncertain, we know for sure that it is either 0 or 1,
> from which we could find two possible partial products and take a
> union. Experiment shows that applying this technique in long
> multiplication improves the precision in a significant number of cases
> (at the cost of losing precision in a relatively lower number of
> cases).

If I understand the idea correctly, when the multiplier's (i.e. tnum a) bit is
unknown, it can either be 0 or 1. If it is 0, then we add nothing to
accumulator, i.e. TNUM(0, 0). If it is 1, we can add b to the accumulator
(appropriately shifted). The main idea is to take the union of these two
possible partial products, and add that to the accumulator. If so, could we also
do the following?

acc = tnum_add(acc, tnum_union(TNUM(0, 0), b));

[...]

> +		else if (a.mask & 1) {
> +			/* acc += tnum_union(acc_0, acc_1), where acc_0 and
> +			 * acc_1 are partial accumulators for cases
> +			 * LSB(a) = certain 0 and LSB(a) = certain 1.
> +			 * acc_0 = acc + 0 * b = acc.
> +			 * acc_1 = acc + 1 * b = tnum_add(acc, b).
> +			 */
> +
> +			acc = tnum_union(acc, tnum_add(acc, b));

The comments in your algorithm seem different from what the code implements: I
believe the comment should read:
/* acc = tnum_union(acc_0, acc_1), where acc_0 and ... */

[...]

> +struct tnum tnum_union(struct tnum a, struct tnum b)
> +{
> +	u64 v = a.value & b.value;
> +	u64 mu = (a.value ^ b.value) | a.mask | b.mask;
> +
> +	return TNUM(v & ~mu, mu);
> +}

The tnum_union() algorithm itself seems correct. I checked this in z3 [1].

[1] https://github.com/bpfverif/tnums-cgo22/blob/05a51a1af6cb72f9694e5034c263ca442b33b976/verification/tnum.py#L801

I also checked this algorithm for the precision gains myself [2]. While the
numbers were not exactly the same as the ones you shared, the algorithm does
seem to be more precise (echoed by Eduard's tests as well). In the below
"our_mul" is the existing algorithm, and "new_mul" is your new algorithm. There
are two outputs, one for the exhaustive enumeration at 8 bitwidth, and another
for 10M randomly sampled 64-bit tnums.

[2] https://github.com/bpfverif/tnums-cgo22/tree/main/precision-new-mul

$ ./precision 8 64 10000000
number of input tnum pairs where our_mul had better precision: 1420899
number of input tnum pairs where new_mul had better precision: 30063672
number of input tnum pairs where output was the same: 11383710
number of input tnum pairs where output was incomparable: 178440

sampled at bitwidth 64
number of input tnum pairs where our_mul had better precision: 66441
number of input tnum pairs where new_mul had better precision: 241588
number of input tnum pairs where output was the same: 9687187
number of input tnum pairs where output was incomparable: 4784

Finally, what is the guarantee that this algorithm is sound? It will be useful
to have a proof to ensure that we are maintaining correctness.

Best,
Harishankar Vishwanathan

