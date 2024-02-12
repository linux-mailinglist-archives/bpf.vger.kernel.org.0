Return-Path: <bpf+bounces-21782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC618520C3
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3FFEB2208A
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8DA4CE19;
	Mon, 12 Feb 2024 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sm5sQijd"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E84DA11
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 21:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774575; cv=none; b=hNEHUW1KvXq4mfSfTsQ/Dr6jzrYlRT9xY/EcacoGUz/yE/rA48HrIJB0OPWCHIwXT+r/MvJEi1AS6L5CMVERnaW6KSgiu0HUHdBnSOQ9bnpvc7Z4CpcmrBlNFPjmWqSIz6A1vN8kSymUIi/FDJOdx5ZdppSpGvZK+2IVH5nAjbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774575; c=relaxed/simple;
	bh=XlzUixEuXYz9mCgAq/PNYC1k2GN0rRx2q5KJh2JDiig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Znmrtw4OijcfiZ7+hl2POZERDFRRxE22zs9Up/xNTU8UEcfTtI+m9Z/NgPytMtOOOi3GOzwseeEvsPi51vSUDkzy2K8FvCrNcER31FmEymD7slO9r0Awxd0J2UujLvIdIv8g0v8m8T6ffTEMH482m4ekGdjIs/fkVBmNGkbUuWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sm5sQijd; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b5072dfb-ab2b-40eb-891e-630a02c58fe8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707774570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ap1xWTc/JyGMV9BZNY9zs9iX8inBtlXuNSX6jI2pAQ=;
	b=Sm5sQijdO2ME4NFMpW68reuZ7zVqLA9jHeVuGgDpTmvDTwSDiQ4xC3MJA8hHg2R5o5hP78
	eoN9Vbek4+buXyqXuGWeInz/qxgDeBaQjDMJL3qAVbEGOMNZRw1Az+xBnFhgCD0GeYMyYY
	gvyjwZAhopN2v4Qy6TuTklRDf2sHG/Y=
Date: Mon, 12 Feb 2024 13:49:23 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx instructions in
 new conformance group
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
References: <20240212211310.8282-1-dthaler1968@gmail.com>
 <87le7ptlsq.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87le7ptlsq.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/12/24 1:28 PM, Jose E. Marchesi wrote:
>> +BPF_CALL  0x8    0x1  call PC += reg_val(imm)          BPF_JMP | BPF_X only, see `Program-local functions`_
> If the instruction requires a register operand, why not using one of the
> register fields?  Is there any reason for not doing that?

Talked to Alexei and we think using dst_reg for the register for callx 
insn is better. I will craft a llvm patch for this today. Thanks!


