Return-Path: <bpf+bounces-7859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7727877D7D9
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 03:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4A6281646
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 01:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3EAA50;
	Wed, 16 Aug 2023 01:47:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A780B7F0
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 01:47:25 +0000 (UTC)
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB99710D1;
	Tue, 15 Aug 2023 18:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1692150439;
	bh=BK6RrXMOHnq0creOrmIb5agZk8D1dC+Yg1U4t9PQcsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GDh/4YMZnxK/Cz3qAcKS2/RF8d4jZOlXI0gYngHX75TVtlFkQkaKvo3wxG1Co4hHZ
	 +YcGnN4H1v989A8lz6gBXL1Od5GQ8mymicBZVVNwlqW+KISiQXmKIDe6a4Nj6SYGW5
	 g9TFGsT2U6hv4O4Nz7830kBl7EXofkhbVtg3Q3WE=
Received: from localhost.localdomain ([39.156.73.12])
	by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
	id BCDB1A5D; Wed, 16 Aug 2023 09:47:13 +0800
X-QQ-mid: xmsmtpt1692150433t9zall2if
Message-ID: <tencent_E3B23E2EC954865F61474B10790C7C84E009@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtJSFYZFoLP8e8CGwpg7mImHiK9fNuvkAhFSbOT7+93QomZINSAF
	 +C5r1S270qqBegrcIjOtLUh2+Lyg8dmk40DQ+ElmcxLn1J70681aU2cf8bc40hxyrFq9SoQj4T1K
	 FOA54pM7Z4SoJ2CLNI9DRgvxCU+KW2yE3pXN0ARAUS6ILsCZ/MBc9bdCA1LSRgvETqOSNNglTEiL
	 niKTumRtUsAwmSwgrgjPssWqJaFMjrwRUk36azP9fRdoDifDSvwGjQtjZiDYMKqcchYb8225V5dt
	 OASlFEhwXQQnY2yyPqsXG+1VozjiucSftpQjNRke8i4PKn+mbYgn+9M5OGNlGXkCNDsLXXBEL9TI
	 /NHRIyeFgbT2Ujzfevw2qbfWRKzgqnz1p2kQfV5lFqjQPB8tsjpWKteCO9qMYKz9wKx2wrUvGBwh
	 HPURcyFR8wHwTrEqp5tpY0I3RNVJmWb8KK669X/4Ce9LA5t0tHZD+6WT18hK01NuP2QVzTPz0vSX
	 /j0Ap8nsMA6tsvTHKSvD7L/QzvkmDgSfIGx3E3pXk5aWOsxqvy0J3/l5b2t3MAzAgMAEKOAjiUcS
	 +QpgaN10rogbraKqBOnvt7+8P3WsltKWlqQnJYSN37M95yb1kqgyxjhRkbH0GYMydA11kScXQzmB
	 UGJkC81IMIZZvs4rqjbaVU4t1OMy2wPO00a/3s1AXotGVMMyqAech04ol0WACjkx8WXChPCgpT7m
	 ICeUtfYnKw8RUMzxHIdeQyYhNuwZSWQvE/Ccpns1mnyIgQShoX5yy0daNMQ/gYvZ40UhSySQ5lsS
	 59nf43saW6uTBnI8GQVq4PH/xS8a0hc2LSPRm+O75uXWn+5h8loxb3gmqqLyFXLT40L2ruGPAPwH
	 JN5hWUCl4i/nYxrJmE5CIojqloJvkQk4iTYxrdPaQnoFKQSz7P8QdAGPLeyldMdJZLw9ksJRcLd2
	 DaGYjQfmvjpa5tYwpXbzKC1/yHxkFjKlijgfobogJ9wykFobagM+ic6Dnr4hJMXy1Mq4ifMoHRWN
	 quhZiE7wQBVprkgJit
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Rong Tao <rtoax@foxmail.com>
To: daniel@iogearbox.net
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mykolal@fb.com,
	rongtao@cestc.cn,
	rtoax@foxmail.com,
	sdf@google.com,
	shuah@kernel.org,
	song@kernel.org,
	yhs@fb.com
Subject: Re: [PATCH bpf-next v3] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date: Wed, 16 Aug 2023 09:47:13 +0800
X-OQ-MSGID: <20230816014713.27759-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <d1ad0b4d-574c-15e5-928f-2d9acc30dfe1@iogearbox.net>
References: <d1ad0b4d-574c-15e5-928f-2d9acc30dfe1@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks, Daniel.

I just submit v4[0], make sure most cases we don't need the realloc() path to
begin with, and check strdup() return value.

[0] https://lore.kernel.org/lkml/tencent_59C74613113F0C728524B2A82FE5540A5E09@qq.com/

Rong Tao


