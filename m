Return-Path: <bpf+bounces-42800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5664B9AB4F9
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 19:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CE0284CAE
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241631BE250;
	Tue, 22 Oct 2024 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2qUSiQr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B9B1BE87E
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617848; cv=none; b=A3GrabtXPZLLKFa4kfy0Py1XG767TPTvq8/RmZ4I/Ja7w2GQQVDmIdtIuh52ksZ7g4AbI8DfTKlX/QuFmqiHIuT3xuD6/nu2isjtTjzxXEqzK956x1dRZ96mJ2sYSS+tXEirhU8yBYhwdd4+YzDDGADPmkCCQYnCtv0RuX4rxjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617848; c=relaxed/simple;
	bh=JmAPWXy5Vw82/y6UIjvkoXH3JKleNwrq4qEmYsUb6Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uid9WzNCruZyOlPl9a8WNwYMaTCtaD/Y1XHc2Skfc5c7QtSGr9C6FOlPgAbwJZ065tdwK3Ad+5tuzDAMM6CTNP0n/pR5Hd6LFfS2AsyNuNtmpCapcHcIdIfrMBj1Ivh8LW9vj8xzEUKmxuLLUGllVpdjcOI9DUlfPozIq0kz9TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2qUSiQr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729617846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYRR3poErCjI6KOljjS6hUlitC7Nqrgyj2rhxhner44=;
	b=E2qUSiQrNdtZt6w3p1G6MMouGOoUp+wJJzB6Vz2f1dL7G73726h7QzZxNmWKXgPwvVKAue
	MAJd5gaD1crWAR4QALOEjrkUOnqzSo2EhP8N++Ecy4+NI800ANo+3IsALdQBvAIFcm5TxG
	gxcuH46qVJoQcGB3CJ38PHVF9mSmadM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-33VY614oMV2Pruptxc8tHA-1; Tue,
 22 Oct 2024 13:24:02 -0400
X-MC-Unique: 33VY614oMV2Pruptxc8tHA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FDFA1955F3C;
	Tue, 22 Oct 2024 17:24:00 +0000 (UTC)
Received: from f39.redhat.com (unknown [10.39.192.92])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F4BD19560B2;
	Tue, 22 Oct 2024 17:23:55 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	acme@redhat.com,
	vmalik@redhat.com,
	williams@redhat.com
Subject: [PATCH v2 2/3] libbpf: Prevent compiler warnings/errors
Date: Tue, 22 Oct 2024 19:23:28 +0200
Message-ID: <20241022172329.3871958-3-ezulian@redhat.com>
In-Reply-To: <20241022172329.3871958-1-ezulian@redhat.com>
References: <20241022172329.3871958-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Initialize 'new_off' and 'pad_bits' to 0 and 'pad_type' to  NULL in
btf_dump_emit_bit_padding to prevent compiler warnings/errors which are
observed when compiling with 'EXTRA_CFLAGS=-g -Og' options, but do not
happen when compiling with current default options.

For example, when compiling libbpf with

  $ make "EXTRA_CFLAGS=-g -Og" -C tools/lib/bpf/ clean all

Clang version 17.0.6 and GCC 13.3.1 fail to compile btf_dump.c due to
following errors:

  btf_dump.c: In function ‘btf_dump_emit_bit_padding’:
  btf_dump.c:903:42: error: ‘new_off’ may be used uninitialized [-Werror=maybe-uninitialized]
    903 |         if (new_off > cur_off && new_off <= next_off) {
        |                                  ~~~~~~~~^~~~~~~~~~~
  btf_dump.c:870:13: note: ‘new_off’ was declared here
    870 |         int new_off, pad_bits, bits, i;
        |             ^~~~~~~
  btf_dump.c:917:25: error: ‘pad_type’ may be used uninitialized [-Werror=maybe-uninitialized]
    917 |                         btf_dump_printf(d, "\n%s%s: %d;", pfx(lvl), pad_type,
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    918 |                                         in_bitfield ? new_off - cur_off : 0);
        |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  btf_dump.c:871:21: note: ‘pad_type’ was declared here
    871 |         const char *pad_type;
        |                     ^~~~~~~~
  btf_dump.c:930:20: error: ‘pad_bits’ may be used uninitialized [-Werror=maybe-uninitialized]
    930 |                 if (bits == pad_bits) {
        |                    ^
  btf_dump.c:870:22: note: ‘pad_bits’ was declared here
    870 |         int new_off, pad_bits, bits, i;
        |                      ^~~~~~~~
  cc1: all warnings being treated as errors

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 tools/lib/bpf/btf_dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 8440c2c5ad3e..468392f9882d 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -867,8 +867,8 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
 	} pads[] = {
 		{"long", d->ptr_sz * 8}, {"int", 32}, {"short", 16}, {"char", 8}
 	};
-	int new_off, pad_bits, bits, i;
-	const char *pad_type;
+	int new_off = 0, pad_bits = 0, bits, i;
+	const char *pad_type = NULL;
 
 	if (cur_off >= next_off)
 		return; /* no gap */
-- 
2.46.2


