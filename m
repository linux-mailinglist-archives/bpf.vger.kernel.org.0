Return-Path: <bpf+bounces-49495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A77A19725
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DEC53A3E94
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CF121519F;
	Wed, 22 Jan 2025 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0ll15UP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D888C215187;
	Wed, 22 Jan 2025 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737565593; cv=none; b=k683dKvmS6S2ZrEYa0QnTnSitUWG1UwBra0rt6vqMnuZXsozdHXvOmHu7KoeJRN1ii0lGfr/Qq4NSJ1HHZA+MJnDBskuriDpltezafnZ+mUwJbLLlhtPilJXYBKjMx0qvVHXxp0AV3NgsjrBtJz810KGP83Wla4Epv8l1iJvH0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737565593; c=relaxed/simple;
	bh=/soEHN2xtVU1gtwSpLHJpj49L3qPGrxuc0AMAZvmUNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g5RNGSX4BFKTZ+v1UMXFsG8T9w5jwgU2yyu99/2MSRDZY6JTfASuVHaQKb4eLVsuHAanhkXdvm5+uGN4RckwZiAWtfZ6kz5II83gZCLFU8eG6c5rDbZyUZwgGkM35yJIcZAmrGRwNjicXCoX8VCFRLtMhJfhu9IvUClip/lyHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0ll15UP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21644aca3a0so162783885ad.3;
        Wed, 22 Jan 2025 09:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737565590; x=1738170390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nE070qqGZGw6mDAzzE1IWQug1apufvChvMUY0TYHWLU=;
        b=b0ll15UPaJGhVPth0Ckj18c32mXmgYY1xoLh5LO1MdCeBafVesTZwpjeLG3eY0EUdN
         3G/PNoIpNlHrhSNcfCMLGU35RBRUkubt9/gGIZ/8jykv92qXXVEo1H18X30yB4SDAZXV
         GP/a/1LcgxfWbUPQpbpf3kHlc72n1v6LYwswzA/syTc/tZJV9YrmzNqSSbW9pn65Wp2D
         m0Q8pt3xVBf/Ag+UTgIteN7P/Io981fw8J/Hp/WOeIjTsMLTGA4xb6Ug0SkH2gJllfVy
         cdi84aQP+y7nRuSfVmSIHZo2QXgBSlHFxCy9Z4z6WcJhqmMBZtClcfbKqE7QW6gM3O9h
         jIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737565590; x=1738170390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nE070qqGZGw6mDAzzE1IWQug1apufvChvMUY0TYHWLU=;
        b=Nsp2fslRQ9YFWOKuFTp8ZSoYo6uRJ7qxN6Fitxnu/8rb8ayN0fExrmr1bSs7pB5hit
         k5+bOkjD1dLeMEBSWz3MGBpuDFHUlFXA9/sjc0drVR2XYwomzHl3e7blkfMDO8ImkZPk
         5d4GSFXn35+zej2yKrTR7lFGl3mqJjPmt1xy/hE7pZjHVywVtANwPoyUTyComZN6/l+S
         HQYedxDLMpO0Bte7Q/TEo4zeF5QAikrxGZl1djBYTUyNR/oEETMfWWAKOiezvfV+jPoO
         YPK9qfh7ZvStUZWDPHdqfES4zas9leLoXBAQEF5NqAdCNmUmEZqIomzRKvs1N4GRJqzL
         KFWA==
X-Forwarded-Encrypted: i=1; AJvYcCU/AfQOSZcWpn6MORxNTgZMa2VT4Lazp0NItDo628+VcyopXwDAKqW2GpZ/o5J6sWxhCvPSKf8WCfDzpUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3tn24Bw14sa3IEFmluvvI0YEpU6+tuDiRRQuwTA3LJg0FZhl9
	IGOhWYELWSVe1sqH6a3cPxwfcKhzD+6HRs+B5tquP13AjiD2rJon
X-Gm-Gg: ASbGnct6Y1VRuU/cMust4GrqeGJf10Y56BDWTdAvRRVNxJIi7oyUODguPjLvHgq5w8h
	bb4hK/L/vYMpfYvHknBh3vBnBGi3ZeEULSwL38YLiV/j/o/V3w8+RyQiU3Ts9wOIdbMi7ZZttPw
	l2DDMEXGdAUnm1oH8rLpsBlIVjbzzrb9vUvHzFYGUmwCVPtC+UaI3Hcctq+m/eBYfit4uFvGsiw
	Irp6E60JWiPCqVJoMK4OdnVPL3DZRBbCkerJkvo7Y8sLWlotJA88lrQFYlRHENTliRlvQ+8V4lG
	oA0=
X-Google-Smtp-Source: AGHT+IFxZD3NktlcVqlPbYhvkdn0e2XKdX2sMWbGGl017NrBrEyPBDieaEKaujdEJBB/94PYb0Nwzg==
X-Received: by 2002:a05:6a20:d49a:b0:1e1:adcd:eae5 with SMTP id adf61e73a8af0-1eb2160ff91mr27669159637.42.1737565589779;
        Wed, 22 Jan 2025 09:06:29 -0800 (PST)
Received: from localhost ([117.147.90.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aa2b3969117sm9440634a12.6.2025.01.22.09.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 09:06:29 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [RFC PATCH bpf-next 2/2] selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests
Date: Thu, 23 Jan 2025 01:06:20 +0800
Message-Id: <20250122170620.218533-2-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122170620.218533-1-chen.dylane@gmail.com>
References: <20250122170620.218533-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for prog_kfunc feature probing.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 4ed46ed58a7b..5f94971649db 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -126,3 +126,33 @@ void test_libbpf_probe_helpers(void)
 		ASSERT_EQ(res, d->supported, buf);
 	}
 }
+
+void test_libbpf_probe_kfuncs(void)
+{
+	int ret, kfunc_id;
+	char kfunc[64] = "bpf_cpumask_create";
+	struct btf *btf;
+
+	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
+	if (!ASSERT_OK_PTR(btf, "btf_parse"))
+		return;
+
+	kfunc_id = btf__find_by_name_kind(btf, kfunc, BTF_KIND_FUNC);
+	if (!ASSERT_GT(kfunc_id, 0, kfunc))
+		goto cleanup;
+	/* prog BPF_PROG_TYPE_SYSCALL supports kfunc bpf_cpumask_create */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, NULL);
+	ASSERT_EQ(ret, 1, kfunc);
+
+	/* prog BPF_PROG_TYPE_KPROBE does not support kfunc bpf_cpumask_create */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, kfunc_id, NULL);
+	ASSERT_EQ(ret, 0, kfunc);
+
+	/* invalid prog type */
+	ret = libbpf_probe_bpf_kfunc(100000, kfunc_id, NULL);
+	if (!ASSERT_LE(ret, 0, "invalid prog type:100000"))
+		goto cleanup;
+
+cleanup:
+	btf__free(btf);
+}
-- 
2.43.0


