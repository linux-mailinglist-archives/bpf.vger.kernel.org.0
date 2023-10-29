Return-Path: <bpf+bounces-13582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC97DAD6C
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 18:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1728BB20D0F
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 17:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113C2DDB5;
	Sun, 29 Oct 2023 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XQbDmpBO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1CC9447
	for <bpf@vger.kernel.org>; Sun, 29 Oct 2023 17:07:52 +0000 (UTC)
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [IPv6:2001:41d0:203:375::af])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6FAD6
	for <bpf@vger.kernel.org>; Sun, 29 Oct 2023 10:07:51 -0700 (PDT)
Message-ID: <1b463b8a-eac0-4894-b265-da1d3e51c674@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698599269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CwjmesJBPd77RraX0VXEJ5fpmp3TmiDHUFN/EhxgGxI=;
	b=XQbDmpBOLN53bjspOhw7G4X/xCSZRhmYT6bEkgzQPOdJunYr9MryJGIPcEh+IqVd7xcMBO
	yQDcR7W+7lzew3Fqf6oH1O8YsfSoVeHubyMyd8WtA58cBWSly5DedTyPSSpnnhx4LiaCCZ
	wuToRNnwdmOb4VSSDe+mmdFeStEb5JI=
Date: Sun, 29 Oct 2023 10:07:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add malloc failure checks
 in bpf_iter
Content-Language: en-GB
To: Yuran Pereira <yuran.pereira@hotmail.com>, bpf@vger.kernel.org
Cc: sinquersw@gmail.com, ast@kernel.org, brauner@kernel.org,
 daniel@iogearbox.net, haoluo@google.com, iii@linux.ibm.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 kuifeng@meta.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mykolal@fb.com, sdf@google.com,
 shuah@kernel.org, song@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <cover.1698461732.git.yuran.pereira@hotmail.com>
 <DB3PR10MB6835F0ECA792265FA41FC39BE8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DB3PR10MB6835F0ECA792265FA41FC39BE8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/27/23 10:24 PM, Yuran Pereira wrote:
> Since some malloc calls in bpf_iter may at times fail,
> this patch adds the appropriate fail checks, and ensures that
> any previously allocated resource is appropriately destroyed
> before returning the function.
>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


