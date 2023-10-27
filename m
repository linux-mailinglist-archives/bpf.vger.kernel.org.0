Return-Path: <bpf+bounces-13385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613097D8DCB
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 06:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A63A1C20FE0
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 04:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115E31FD3;
	Fri, 27 Oct 2023 04:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rp+pPP+B"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE02D61E
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 04:38:09 +0000 (UTC)
X-Greylist: delayed 42221 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 21:38:07 PDT
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [IPv6:2001:41d0:203:375::b3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE3891
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 21:38:07 -0700 (PDT)
Message-ID: <fbaf1218-e8a4-4e50-bf38-b5615111c8de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698381485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxoshSOnuzVnnJNzG4zAtKHpo3o6ur1S9Zdl6sB7kjw=;
	b=Rp+pPP+BXNFt15VLlVd+eY3XJgtVBar5v0z+cH9JMGpTfbz9k30XpNsfnwbRjd2Coaj1m4
	krLocHMWBbFgGqsrtk8tzkCtMEoo2GnyBDwBSDkBH2BCJarAlg8gO+jMOIzSiX2mheWn1e
	Na9mTnIeWKkzDVF7NrJZmifu1oSXUqo=
Date: Thu, 26 Oct 2023 21:37:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add malloc failure checks
 in bpf_iter
Content-Language: en-GB
To: Yuran Pereira <yuran.pereira@hotmail.com>, bpf@vger.kernel.org
Cc: sinquersw@gmail.com, shuah@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, brauner@kernel.org, iii@linux.ibm.com, kuifeng@meta.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231026020319.1203600-1-yuran.pereira@hotmail.com>
 <DB3PR10MB6835A2CBEE0EBE31D07FABFAE8DDA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DB3PR10MB6835A2CBEE0EBE31D07FABFAE8DDA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/25/23 7:03 PM, Yuran Pereira wrote:
> Since some malloc calls in bpf_iter may at times fail,
> this patch adds the appropriate fail checks, and ensures that
> any previously allocated resource is appropriately destroyed
> before returning the function.
>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


