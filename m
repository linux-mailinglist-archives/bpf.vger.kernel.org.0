Return-Path: <bpf+bounces-28715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6528BD5F2
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 21:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A3E1F2147A
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 19:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554B515B0E3;
	Mon,  6 May 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aO9wARQv"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD22158873
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025447; cv=none; b=StmX8GwV0inKoo1r/HU9oCdBFqE4Z5e/WwYTQx6dgAD1nsMpyD6X/rlG7co9mX+fuh74e2igjs9oirfwNQuLZGEOEq6gtseBDlGcM5eyfu+egPNML8ImEgeXJ0+UIdExA1/dMBVnQ9QVa5BKRT9v7rmEhX6oa5GO/K57QQ+du2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025447; c=relaxed/simple;
	bh=4ZYTW7Do9GpVCRq9E2zT0gIOEdhhBazZQC++SPqyhjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpH4SKWDSwochMOwA0LXaPZbPc+9qNrjzec1R/GaSXVBTddsZCTfAAfbYjt4rVZrOe2V/IIZWBWaw7rf4sFuns6VFrpiDLVOG8hsPnu6g+AtCPGGQ3da4UFUDseIz3JPINUr1t23biNjT7z67xxYoYfk/kE51ucwrduhsUGYTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aO9wARQv; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <501bb46a-5b87-41f3-9192-01cf8a366a40@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715025443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZYTW7Do9GpVCRq9E2zT0gIOEdhhBazZQC++SPqyhjE=;
	b=aO9wARQvDDtCw3jaoeaq29Z8UNYHvuMKhAqB1PVlAMiRdQ5Xwzl1qVZRzyhbENvAoTIAuQ
	novYF5bi+mjHXpkhUF36ldl+FhXFemXZL8R57QgOiOxeGjd9dWZ6g3wtloTPMKwaQgUkrB
	LMwPHbZAHANmvuW13P/ZAjI9d1IlBbo=
Date: Mon, 6 May 2024 12:57:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Change functions definitions
 to support GCC
Content-Language: en-GB
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>, David Faust <david.faust@oracle.com>,
 Jose Marchesi <jose.marchesi@oracle.com>,
 Elena Zannoni <elena.zannoni@oracle.com>
References: <20240506151829.186607-1-cupertino.miranda@oracle.com>
 <20240506151829.186607-3-cupertino.miranda@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240506151829.186607-3-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/6/24 8:18 AM, Cupertino Miranda wrote:
> The test_xdp_noinline.c contains 2 functions that use more then 5
> arguments. This patch collapses the 2 last arguments in an array.
> Also in GCC and ipa_sra optimization increases the number of arguments
> used in function encap_v4. This pass disables the optimization for that
> particular file.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> Cc: Elena Zannoni <elena.zannoni@oracle.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


