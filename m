Return-Path: <bpf+bounces-5078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015E9755D49
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 09:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320FB1C20A14
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 07:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B229455;
	Mon, 17 Jul 2023 07:45:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB484848A
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 07:45:26 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680631980
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 00:44:56 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTP id 4R4Dcx0gBwzBQt1h
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 15:44:49 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
	content-transfer-encoding:content-type:message-id:user-agent
	:references:in-reply-to:subject:to:from:date:mime-version; s=
	dkim; t=1689579888; x=1692171889; bh=xD/8DnT+MOxry9zA+leSfn3NtFT
	WtrPFC1eCKVqXrz8=; b=RaHuPvZwbZ9zns6vKGSet+bLzKr7wNEjHBVvdkmGOb8
	mZYiif/wR1yD1rpRAaEhFdZUc3weng+xFePmG/JGKHs9CVhd+K7MTNsO01pahp8d
	yTtLpjDEV+GUsWgXWMVF+K3xCa4emZvv1Cec9U3H5iYVMHGYglsoY7aqu58yBwzb
	JVxOghThFtjtdv9H56IQE3vd+c+gbbDh01aMZe6HtSGY1RJWpkMB6dVPET+Z8Vvz
	PBGPw00blSiyG1x1538yaVn8seJVIKWJEoSUivTWKynlU7V/cOHK1wUHYWEw5ZvA
	m8ZNvMdhEXc5JQkmFtTHLhAEhgJk6v72z0XU4YElLZA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
	by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id M0CIaSh-kYtz for <bpf@vger.kernel.org>;
	Mon, 17 Jul 2023 15:44:48 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTPSA id 4R4Dcw4z7szBHXgm;
	Mon, 17 Jul 2023 15:44:48 +0800 (CST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Jul 2023 15:44:48 +0800
From: shijie001@208suo.com
To: andrii@kernel.org, shuah@kernel.org, daniel@iogearbox.net
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: Fix errors in btf_write.c
In-Reply-To: <tencent_295B25ACBCCB13A3F7B08D2739F90CFFC307@qq.com>
References: <tencent_295B25ACBCCB13A3F7B08D2739F90CFFC307@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <d6c64a42ab574440465b0f593e9f8606@208suo.com>
X-Sender: shijie001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The following checkpatch errors are removed:
ERROR: Bad function definition - void test_btf_add() should probably be 
void test_btf_add(void)
ERROR: Bad function definition - void test_btf_add_btf() should probably 
be void test_btf_add_btf(void)
ERROR: Bad function definition - void test_btf_write() should probably 
be void test_btf_write(void)

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  tools/testing/selftests/bpf/prog_tests/btf_write.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c 
b/tools/testing/selftests/bpf/prog_tests/btf_write.c
index 6e36de1302fc..209a230ffeec 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
@@ -352,7 +352,7 @@ static void gen_btf(struct btf *btf)
               "\t'v1' val=18446744073709551615", "raw_dump");
  }

-static void test_btf_add()
+static void test_btf_add(void)
  {
      struct btf *btf;

@@ -401,7 +401,7 @@ static void test_btf_add()
      btf__free(btf);
  }

-static void test_btf_add_btf()
+static void test_btf_add_btf(void)
  {
      struct btf *btf1 = NULL, *btf2 = NULL;
      int id;
@@ -497,7 +497,7 @@ static void test_btf_add_btf()
      btf__free(btf2);
  }

-void test_btf_write()
+void test_btf_write(void)
  {
      if (test__start_subtest("btf_add"))
          test_btf_add();

