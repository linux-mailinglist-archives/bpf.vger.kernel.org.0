Return-Path: <bpf+bounces-77812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6CACF3574
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 12:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C827302AFE4
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 11:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B5B3191B0;
	Mon,  5 Jan 2026 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBtImg1N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uq/gqoWu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA63191B1
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613682; cv=none; b=XPiYh5DnyzPeCkA703fsgwiKs/f6fERV1nW2s3vrxcbuFSbeVVs7iUqlXLvgcrwNO9hr+BKf7cp9zWijS3wNRE2CkZoaRDUUtRhmBs4veIzDiMCHLvUX3mTC2bW2cqlmEP3fxry1M1ydiV27xuuqgMt57gzO7iRiuH5uOrafOHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613682; c=relaxed/simple;
	bh=sZVZYXKGi6x0/cNomEW7NL3LhpGZjdik2+xI/ZdAt6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0qFbg5X2fMkAOSVH2s+ih+mgZCD2qqY3P7cXJe/3X2CyGdYogI4ReLrq1Qzb6gjbF+eFzVKuifvmLgtcl2Vk+lQBLaDDIutEbyzNdqp3Y/lpyr9hAxtyyYw5dwBLw2buRHdWPca6yjatI9k+HkHdY/p2iq/k+l3Y5RMMPN2O+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBtImg1N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uq/gqoWu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767613678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4yVc7Fv6KTjwK4Gtk6iZcVFGv62TYxn7ujD99PvmsPk=;
	b=CBtImg1N9b7D0gq4DcCK7I03eHnJ//kp4F4hkeRadWwoB2JCyBLZ+J0z/tAaxg2263MY3N
	zFPg/gj0ibTUSWbF6AQnr6YN8bHylBr1Gta6nsSZ0sntoBmFYb9Paw9i5XmrVMKquBb0ll
	2Nrb1JDmoCG2WkpW4Z1VBlPB1mYD8ic=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-nalrllGSP5S-HP6o0igXtg-1; Mon, 05 Jan 2026 06:47:56 -0500
X-MC-Unique: nalrllGSP5S-HP6o0igXtg-1
X-Mimecast-MFC-AGG-ID: nalrllGSP5S-HP6o0igXtg_1767613675
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7387d9bbb2so1045405266b.0
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 03:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767613675; x=1768218475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yVc7Fv6KTjwK4Gtk6iZcVFGv62TYxn7ujD99PvmsPk=;
        b=Uq/gqoWu5sz0+kM0gQ2AKZLImyqocLSMwvGdj01wCLkxw7mUBET96VM7Xuevdj0Apg
         QwzB6o/e2vBtebblp4Gcnb/A9dw2Al37TselWVwaTp6SpIXh7gib4fagZBbhf/lWpzua
         GyjbPzT5V0E9OP4qIf0Vh7ofiPMceSfCl9NLnNsWY/UmChgMqZQML1N/o0PhSmJMW3vn
         ZlUnRPMmOjRwsrEwweaPJ+Fkof8HhAENLpppyLcD5sirU6vlyxmYoYpNfEFljHC3aLhq
         b8Jz7uoS0I2jRwQhk5oXWfIXkK04dEWvPTS8spWeHS6i5vzSQTpfRETreDDmUx35yA06
         /APg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767613675; x=1768218475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4yVc7Fv6KTjwK4Gtk6iZcVFGv62TYxn7ujD99PvmsPk=;
        b=VdL6OPCd5IpkQ8lsxsIoGQJm3LzMN7qZeDfY0easBheJ0Kbt7Q6fr7mkPh9F1Hgkz0
         sp0zjUzJvM//73xfgghnfhYM8pA3+9FlTkEnAojuBQMFi7ZTa3f9SNXHstvQIY5hH7dF
         MjYDdywbr5FT4VO+Medz8uKeewP9T9dDvg925jwI3PXRGFKL3OxO5mgDd+eJ5Joz4AYk
         XkWShee71vbrefM0WNDIHic0WfRwU0jROdegH19HQiaRBRy/4u8vqX4sJ/FHqrTUzHcP
         4Vn/NojvzN7r11XHvyR2CvZqxtyI82rey23jXB0DJfsSTqwf0Q7XGvyZjPc2VHAsCewt
         uOWA==
X-Forwarded-Encrypted: i=1; AJvYcCVA2+pdjoS8rgH2RnRiDr1XAaIlRhVvIvq6mEwFNOdYYFWcVycnciO4jCjOgup8Pib8uB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdTwd2SW9KeyNYmbPHCzSG1IzTnZhqiRXZ1RukVJHdv+FnF6/F
	24ObeJVm0VsJYs3lv8eR5zSFQC43OBYlL95GjRKYBplQpb0kb2XzMDpu0j+0ackZN7Otp3MMS1e
	2pT25zlR54no/zXnXJ5IdNSo9zmRDQvcAbhlE5mvOz7W6A+8yJPoWYA==
X-Gm-Gg: AY/fxX478ZWeL5ugXCiOwT6SyiCPynjYpG4ljZptiWDhUVSQrmhvnPKzrxQZQAp/b69
	sA0pMJpIrIb/UHBGZlPxklZMLoubUzmR0aB0iwNnfLERq60B72Q/nSlUL+JBWrRuMuUMvm88RDD
	CiWDkkPn7Tegaijjgyjx7fY+X/dWYm/aUkHpN3XNNPWEZN2szqC+CrxbnMV2sS5SWJMm4qZFEBB
	STh3eSSDS7mytyki7sC4UIVyrttXgz/0VMOFTw56bSz1Sh1LMKNTZGUy4AvmMAe/DCySo7RWPR3
	roJWmLjeU+iPtrNjckGdobMg3Zt3GK7RmWtyPR5pPtOV3M1Uu+IkqbzlDHxtGDmAxCKs6TE8Fnh
	ARqr8ItqnsXnAlwPJDXWAZqPduiA2c0awDNGJ
X-Received: by 2002:a17:907:7b9e:b0:b83:f03a:664 with SMTP id a640c23a62f3a-b83f03a080dmr523519766b.49.1767613675486;
        Mon, 05 Jan 2026 03:47:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxl5eOZaA5tkb0SiXmLtUqZuvDTKDYvvMC2EjLr6KOiOyt8Eqh0XpS42ZrtvKeQMhJx1p6cw==
X-Received: by 2002:a17:907:7b9e:b0:b83:f03a:664 with SMTP id a640c23a62f3a-b83f03a080dmr523515866b.49.1767613675017;
        Mon, 05 Jan 2026 03:47:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80426fc164sm5336443066b.30.2026.01.05.03.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:47:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A4FDF407E7F; Mon, 05 Jan 2026 12:47:53 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: Update xdp_context_test_run test to check maximum metadata size
Date: Mon,  5 Jan 2026 12:47:46 +0100
Message-ID: <20260105114747.1358750-2-toke@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105114747.1358750-1-toke@redhat.com>
References: <20260105114747.1358750-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the selftest to check that the metadata size check takes the
xdp_frame size into account in bpf_prog_test_run. The original
check (for meta size 256) was broken because the data frame supplied was
smaller than this, triggering a different EINVAL return. So supply a
larger data frame for this test to make sure we actually exercise the
check we think we are.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index ee94c281888a..24d7d6d8fea1 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -47,6 +47,7 @@ void test_xdp_context_test_run(void)
 	struct test_xdp_context_test_run *skel = NULL;
 	char data[sizeof(pkt_v4) + sizeof(__u32)];
 	char bad_ctx[sizeof(struct xdp_md) + 1];
+	char large_data[256];
 	struct xdp_md ctx_in, ctx_out;
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
 			    .data_in = &data,
@@ -94,9 +95,6 @@ void test_xdp_context_test_run(void)
 	test_xdp_context_error(prog_fd, opts, 4, sizeof(__u32), sizeof(data),
 			       0, 0, 0);
 
-	/* Meta data must be 255 bytes or smaller */
-	test_xdp_context_error(prog_fd, opts, 0, 256, sizeof(data), 0, 0, 0);
-
 	/* Total size of data must be data_end - data_meta or larger */
 	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
 			       sizeof(data) + 1, 0, 0, 0);
@@ -116,6 +114,16 @@ void test_xdp_context_test_run(void)
 	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32), sizeof(data),
 			       0, 0, 1);
 
+	/* Meta data must be 216 bytes or smaller (256 - sizeof(struct
+	 * xdp_frame)). Test both nearest invalid size and nearest invalid
+	 * 4-byte-aligned size, and make sure data_in is large enough that we
+	 * actually hit the cheeck on metadata length
+	 */
+	opts.data_in = large_data;
+	opts.data_size_in = sizeof(large_data);
+	test_xdp_context_error(prog_fd, opts, 0, 217, sizeof(large_data), 0, 0, 0);
+	test_xdp_context_error(prog_fd, opts, 0, 220, sizeof(large_data), 0, 0, 0);
+
 	test_xdp_context_test_run__destroy(skel);
 }
 
-- 
2.52.0


