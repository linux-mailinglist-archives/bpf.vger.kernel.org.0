Return-Path: <bpf+bounces-20124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F54839AEB
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E80CAB265F2
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8592C1BC;
	Tue, 23 Jan 2024 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GyIjotTb"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD6442F
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706044602; cv=none; b=tHZHPNvqooEWlSmLTOnshUqj7Gvcl0ScFpOtgwAWGCajHlEFYKxavM13gFQMbxik9fO6nk1uvCQZUylx+U0f/XDzj5q56O5TOFapqyDzZxBQzDT8pn7x3fOxtBSifTVw0vQ5Hglcs6YqNNhUd0OyuOcFAbnlml0Au2NtKJXvHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706044602; c=relaxed/simple;
	bh=Af/PqY1CuXDQI72d8ioQqCCSCr++h3ci+Kn4BIV5y7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZG1nXiMRn3pc56uLl06FKRUKyGuEskYcQhOv940iF/G9EB6EKBjLCFIsrgIZyfNQQFNMGTRDb/hsYW9NbSG+CrwgaebnPEQ/0FAHx+2/tb867EbsVfva1jSLkfZ1Y82zUpCK00DWLwNyLA4wKHKs8OHSCNhiDIA9dUirndynGVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GyIjotTb; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <32c36da1-8a8c-414f-a262-5d82f2275130@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706044597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mUkpeqGQ+QjFRPKtroiozGyL4rUakIVVDx5OvfwwzU=;
	b=GyIjotTbTD4UnznRB/TSctTMPFnq/qbdBm7XX6ZKSSoaKrS3VZXguOSk7zMAwhPfbFHB/P
	fmdL969pIeVpTUJ9/ct9Hqk2oCur/ikR1+4+SFUc0zGK5noxZEm6e2+IDNNnpwi9SIy30F
	T7E77BgBSP68r5e/rJIUkdaCmHy+n3w=
Date: Tue, 23 Jan 2024 13:16:32 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: fix constraint in test_tcpbpf_kern.c
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
 david.faust@oracle.com, cupertino.miranda@oracle.com
References: <20240123205624.14746-1-jose.marchesi@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240123205624.14746-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/23/24 12:56 PM, Jose E. Marchesi wrote:
> GCC emits a warning:
>
>    progs/test_tcpbpf_kern.c:60:9: error: ‘op’ is used uninitialized [-Werror=uninitialized]
>
> when an uninialized op is used iwth a "+r" constraint.  The + modifier
iwth -> with
> means a read-write operand, but that operand in the selftest is just
> written to.
>
> This patch changes the selftest to use a "=r" constraint.  This
> pacifies GCC.
>
> Tested in bpf-next master.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Yonghong Song <yhs@meta.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com

Acked-by: Yonghong Song <yonghong.song@linux.dev>


