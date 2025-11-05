Return-Path: <bpf+bounces-73681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB399C372AC
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 18:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8375C188E76A
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 17:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4978C1C862E;
	Wed,  5 Nov 2025 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uzFk2wXq"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF1323C50A
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364753; cv=none; b=jTt3E0aQtL9lsXpAI1XXO8j0dLLXFdqwPaaR6Ly85udf7vAOhsFdygcwof3//i5Vx6MdC5Z8Y8u3ou4PzUope0Rf1uKs9FgKvdZJ1TKKL96RC7wGHJv/OyLw66kknFB96+v90F0O4aBWKaTg4WSWoxUWIU8p9rqiuqFKoXksT4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364753; c=relaxed/simple;
	bh=vhWLcgBQrhOBM09s0g/TWSK6nP9AcMae/veeInsHPbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jFIgibqgPr4ptAwYSDoipEUVspnSS4RkAF4BOakc59GJb+o1cQpwLhx05aYhUmoxzCAFcHyv0sYt/f/za5YeUJNOtaPxtoszJ+l8tKDn67hPyeoDIzUzQ9xb52NnmkHBpl55Pus7O+RZ6aR44isE51YOU39gFs+POA+mWrOgPEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uzFk2wXq; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7fa1213c-68b6-450c-b69f-1e8c9eac5250@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762364748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vOaSwX8IN7f1G+Tv/VhoRH9QGpIJo807c5hXiTVwNI=;
	b=uzFk2wXqwDan6JX4cssooLI0tFuaZopZUeaFWFykPze7zAJj0tvxUfhLM1zipErk8phx0k
	3JNPbo6e/807NVy7kPhjt5+sZbcHVlGnJ0PRaV/qjaLDFxKqahlkIbFa8j7SxtwkgBzfYJ
	kb+lqw9zzbdiaTx2rTywvgo+1ywWuy8=
Date: Wed, 5 Nov 2025 09:45:41 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v11 bpf-next 08/12] bpf, x86: add support for indirect
 jumps
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
 <20251105090410.1250500-9-a.s.protopopov@gmail.com>
 <aQszqAyqdQZMlt3p@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <aQszqAyqdQZMlt3p@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/5/25 3:23 AM, Anton Protopopov wrote:
> On 25/11/05 09:04AM, Anton Protopopov wrote:
>> Add support for a new instruction
>> [...]
> 
> Interestingly, AI review is stuck with "Setting up Claude Code..."
> on this and libbpf patches of this series. Robot got tired? :-)

Robot got tired indeed.

Could be network issues during setup. Happens on CI.

Let me try restarting stuck jobs.

