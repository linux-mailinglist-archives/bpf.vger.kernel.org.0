Return-Path: <bpf+bounces-41355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A763E995F47
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 07:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0EE1F225FA
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 05:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DE215CD49;
	Wed,  9 Oct 2024 05:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n8L8uLUz"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76612AF1D
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728453259; cv=none; b=qLIIkuls8z4FTMYQ1tMwjCDf01iNqtJzGOdPCxCgFACMifo+avUMKGy5Tdmg133neeP6XOmxXCnzbH19MOn6jaG/B/yLKoT4SmRJmHPyUhpQMnSkQF4iqXVo4Qx7/JChNImPg+JAYCM+IELEtmZpwzjmTAKIt5qLh6+I7PAWhaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728453259; c=relaxed/simple;
	bh=z0zqza9c34KEtvpsLtFmblAiVDuNYl0cueE1tGxoPX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvWEsGI325grLQow1bPuDxbcFs7F3ziuU6iqIE9SAyUeD4fVAoulFWWLVXB2dWzBOlVHFiXJETkfDlXD7ApBzCW/WE2TbdwnjfknwYVom+dwONJd1psy2w4B0XrCjg9rhZMRn7P6EiqxWSBkRGndP7uIvYdSSHO2ZJVFGfDwrAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n8L8uLUz; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ffe99d20-b134-40f4-8185-ba2dafeb511c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728453253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gtvK4GyTLC5+4whip8kLryhAD+0mD0V+v6rjWH08kYE=;
	b=n8L8uLUzNzJQrrTFmDZQPbMA6uN8uM3i9vV9zqMASvfwNrs2SXajYhcsmWwITsveh20++X
	bFis6sZzMsLw9JwN/sKnEbw4xRb1ppoF9pVNhZo0lqRFXECwM2s52tbFVSF/BZHm8lte+z
	/6fsGCUIMcjvCO4ColNxZHzGzfcEGmY=
Date: Wed, 9 Oct 2024 13:54:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/3] selftests/bpf: Add a test case to confirm
 a tailcall infinite loop issue has been prevented
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 xukuohai@huaweicloud.com, iii@linux.ibm.com, kernel-patches-bot@fb.com,
 lkp@intel.com
References: <20241008161333.33469-1-leon.hwang@linux.dev>
 <20241008161333.33469-3-leon.hwang@linux.dev>
 <fe9c1ce8f015b8faf5fe33c027485dcbef8d7905.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <fe9c1ce8f015b8faf5fe33c027485dcbef8d7905.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 9/10/24 12:37, Eduard Zingerman wrote:
> On Wed, 2024-10-09 at 00:13 +0800, Leon Hwang wrote:
>> cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
>> 335/26  tailcalls/tailcall_bpf2bpf_freplace:OK
>> 335     tailcalls:OK
>> Summary: 1/26 PASSED, 0 SKIPPED, 0 FAILED
> 
> Nit: commit message would be more useful with a small description of
>      the added test.
> 

Sure. The commit message can be:

Add a test case to confirm that it must fail to attach a tail callee
prog with freplace prog, and must fail to update an extended prog to
prog_array map. It's to prevent an infinite loop issue cause by the
combination of tailcall and freplace.

>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]
> 

Thanks,
Leon


