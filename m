Return-Path: <bpf+bounces-21783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72528520C2
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BA11C21F6C
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3750D4DA18;
	Mon, 12 Feb 2024 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Z+lm8bEs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Z+lm8bEs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sm5sQijd"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D674D9FA
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774581; cv=none; b=bqEptvSc2D1yNTGR6Ol4KA+Px+jMRMSN8BRpx+noOZjuNNKUBgPmfNZ95w7lWuvzPoy3j2RE7C3yd99uT7NpAjcYeDNKgs/WVz7u4jqmLDncK7BRraA6Mt8ZvsZwmgYZj0ql1wQLFjrEX5Gt5gdyrcoG8/MjAOgycIT1VdIzZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774581; c=relaxed/simple;
	bh=9PJixthd5124M79bglDN7cb3jYjL8GT1/8nk5m+zhS4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Subject:Content-Type; b=iaPmYwp1NxeoGZ6LCR4ByaC0g52CtODtLb+25AfjRhjbtozRFiaNA08Aq30Dj/x2aZTZtkf9vb3P2MrlNDLcxn0FgxC/a/rPYTkyw+wVENSm5VMYcDt8HSPhEGgA/YMtli1D4u2V6fmJXTHymEH7UImkL0kYM7N9KaDpA3ZvX0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Z+lm8bEs; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Z+lm8bEs; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sm5sQijd reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 35E26C151996
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 13:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707774579; bh=9PJixthd5124M79bglDN7cb3jYjL8GT1/8nk5m+zhS4=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Z+lm8bEsZ22U8v4/DcwMHAgZKPzslmAKFWv6IrVwvs760Z37Ry/3KYTZey5Rw2N8J
	 2JAo+Ls3zEInAK2BGkBpuDt8VN5Wn4MiyfQVv9JbGQXoO2kAct+R5BUxssbrCf7vIl
	 33HmlGgOotsjKeRg9ICh9IBMraMaeBisy7kNRGqw=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Feb 12 13:49:39 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 04CC8C151701;
	Mon, 12 Feb 2024 13:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707774579; bh=9PJixthd5124M79bglDN7cb3jYjL8GT1/8nk5m+zhS4=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Z+lm8bEsZ22U8v4/DcwMHAgZKPzslmAKFWv6IrVwvs760Z37Ry/3KYTZey5Rw2N8J
	 2JAo+Ls3zEInAK2BGkBpuDt8VN5Wn4MiyfQVv9JbGQXoO2kAct+R5BUxssbrCf7vIl
	 33HmlGgOotsjKeRg9ICh9IBMraMaeBisy7kNRGqw=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 0E812C1516EB
 for <bpf@ietfa.amsl.com>; Mon, 12 Feb 2024 13:49:38 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.107
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p-8BO93a0asb for <bpf@ietfa.amsl.com>;
 Mon, 12 Feb 2024 13:49:33 -0800 (PST)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com
 [IPv6:2001:41d0:203:375::ac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id C58A0C151701
 for <bpf@ietf.org>; Mon, 12 Feb 2024 13:49:33 -0800 (PST)
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
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
References: <20240212211310.8282-1-dthaler1968@gmail.com>
 <87le7ptlsq.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87le7ptlsq.fsf@oracle.com>
X-Migadu-Flow: FLOW_OUT
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/cWSvnZrLeNSPLUFvu8tw6k-8B1U>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf,
 docs: Add callx instructions in new conformance group
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


On 2/12/24 1:28 PM, Jose E. Marchesi wrote:
>> +BPF_CALL  0x8    0x1  call PC += reg_val(imm)          BPF_JMP | BPF_X only, see `Program-local functions`_
> If the instruction requires a register operand, why not using one of the
> register fields?  Is there any reason for not doing that?

Talked to Alexei and we think using dst_reg for the register for callx 
insn is better. I will craft a llvm patch for this today. Thanks!

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

