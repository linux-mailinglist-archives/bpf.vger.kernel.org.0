Return-Path: <bpf+bounces-13581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880CF7DAD67
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 18:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40101C20990
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 17:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622B6DDB4;
	Sun, 29 Oct 2023 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QqvrHR6E"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE49447
	for <bpf@vger.kernel.org>; Sun, 29 Oct 2023 17:07:06 +0000 (UTC)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [IPv6:2001:41d0:203:375::b2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C033BE
	for <bpf@vger.kernel.org>; Sun, 29 Oct 2023 10:07:02 -0700 (PDT)
Message-ID: <60109bfb-1850-4b5b-87fd-c47a1e41bc2b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698599220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PSJtfAzcywTSN0h2+pbhBByrfU8Kesmbq2MGXuuxqmA=;
	b=QqvrHR6EfAO/l9ZobJKx78tUZG0j7a7hKp+5+RNA08JP8g4KGQDF1MaIf8MELXrrjBQK00
	PGkc0Uqw4f1t+v3eafFpPIuKOoNbuiecRfjrHt9PZCxX7MDEQsWbmucFMh5fiGSoFuZIbc
	1slJiryqwRKrPyNbZKd+7olkwCkyu8E=
Date: Sun, 29 Oct 2023 10:06:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] selftests/bpf: Convert CHECK macros to
 ASSERT_* macros in bpf_iter
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
 <DB3PR10MB6835E9C8DFCA226DD6FEF914E8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DB3PR10MB6835E9C8DFCA226DD6FEF914E8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/27/23 10:24 PM, Yuran Pereira wrote:
> As it was pointed out by Yonghong Song [1], in the bpf selftests the use
> of the ASSERT_* series of macros is preferred over the CHECK macro.
> This patch replaces all CHECK calls in bpf_iter with the appropriate
> ASSERT_* macros.
>
> [1] https://lore.kernel.org/lkml/0a142924-633c-44e6-9a92-2dc019656bf2@linux.dev
>
> Suggested-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


