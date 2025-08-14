Return-Path: <bpf+bounces-65631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9FDB262BA
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 12:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B8FAA008A
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 10:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396BA318136;
	Thu, 14 Aug 2025 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="PiDEjthY"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6449B318132
	for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166741; cv=none; b=OHz15xLHkexIji1T/zocaT5/3ITPj+79M4EbP/DFmLRjYaolEXBLUzFRd8I7soK/JGTVgLcNEAnJeMUX9LdPOjAQO7WKtVo1kOLoZSmL/563pSUBG5FSBXlMMUv3/DTKPfKekbn2doZDa+AVnGFWRGNtjhv8pKOk8LFzDfZE6bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166741; c=relaxed/simple;
	bh=cTITet+qH3Yw9eQwwQd9gAKBvrEhLzU4xbC/dYzYTTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Bdt4BKysTFV6jn6lHelg985mo6UHDR0ugyqn9Jlf1zv5O7zmLjS2yyIIziRKptTEJ4pxNyuOd81qzPsxA54pFzbPzcyzNrNOVGuBKG4snfbmw/t9qgmcylU1waboSR2YToNlgXQx2+Ub1eVJ4WIRw7NWP0ryRv7ccDlU0yXW5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=PiDEjthY; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from [10.128.8.2] (unknown [14.139.174.50])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id 52E7444BF6;
	Thu, 14 Aug 2025 10:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1755166734;
	bh=cTITet+qH3Yw9eQwwQd9gAKBvrEhLzU4xbC/dYzYTTo=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=PiDEjthYZwyVrefcc2+/vxNf3h0ctTMlJd4nC6BA+QbvqryYNqD5UhLS3eu79svGu
	 seF7KXZpDbu31IsJN6/g4lSyq9rq5FS7FLc3QWGRAD7OcXRPxB27ki1/cWcQ8QtBcm
	 sOCpTQEp8anigXFCjs6VtKLEaj0hfiscD5igf0oaHybaTztLBgxte65iR90adrsip1
	 cNO9I3p/lpUSUmOe/z/BL20AfSxykaEE4DDKFaqdDBGhFbNDnNeiirY6gmFx5jvOyP
	 QDRp8gjCP5VHFib2zoEgvCJu+lulGeMQWhjPX7NkzlDg51IH2fvFchji19hRc+5CPf
	 V58q2JOYgiZXg==
Message-ID: <c9490535-b50c-4b89-ac69-e4764feaccc7@nandakumar.co.in>
Date: Thu, 14 Aug 2025 15:48:52 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: improve the general precision of tnum_mul
To: Alexei Starovoitov <ast@kernel.org>
References: <20250814055055.1199797-1-nandakumar@nandakumar.co.in>
 <f74b34b5-59dd-46f7-8496-5f16252ad177@nandakumar.co.in>
Content-Language: en-US
Cc: bpf@vger.kernel.org
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
In-Reply-To: <f74b34b5-59dd-46f7-8496-5f16252ad177@nandakumar.co.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The following change seems to simplify the code and improve the precision:

-                       /* In case LSB(a) is 1 */
-                       u64 itermask = b.value | b.mask;
-                       struct tnum iterprod = TNUM(b.value & ~itermask, 
itermask);
-                       struct tnum acc_1 = tnum_add(acc, iterprod);
-
-                       acc = tnum_union(acc, acc_1);
+                       acc = tnum_union(acc, tnum_add(acc, b)); /* 
tnum_union(acc_0, acc_1) */

I'll check if it can be improved further.

-- 
Nandakumar Edamana



