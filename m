Return-Path: <bpf+bounces-46591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F09EC201
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 03:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E27188B170
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 02:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1511FC0FE;
	Wed, 11 Dec 2024 02:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn2IcS2R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D991ACEC2;
	Wed, 11 Dec 2024 02:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733883175; cv=none; b=Ev1t9FRJKnpeJDDCEplfQ/zD8yHZvN23JYQtfFJctwIG7Zp3omv5oaIWVGlpPWQfKuXKkAMOijUi6KZF/oEwpqNxEvxVeW7F9CZlP8LaLHtHTuBjPpQ+dvOGH2WyOzACPe9s+6MGvbEoMWrRv3dIPtxzWik++8vp+7hxdUUEEMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733883175; c=relaxed/simple;
	bh=yv09W4fl+bfMtHO8UCf/vs+fWaeVEc9nQwKGo+Z7+rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIopgXEHoXggTuR151msk/XakBLo021cY5dPSAJClERKVYaJ23OC30KLrA9FJI/xWKVLHU6HBFk90KiUq4061QOyhX3k3QsXyDLjTp/QgZPr6kNiVA4DtPufeKGu8nhwsChD8gyTnIsFhPuZbsDebK1v12Fk0fAzqGWCUoE9hww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn2IcS2R; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2162c0f6a39so2027645ad.0;
        Tue, 10 Dec 2024 18:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733883173; x=1734487973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ENr+oTUFVNcUM072Bx4z+rQtyQML1ZHCxeXHzKI2FE=;
        b=Bn2IcS2RDvpeD7BEMYcZiHRt/PubLix30wIfCbaHX6ZspmZwR8Ria/nifGEscUUGyj
         2QXfFLpnmZFrolQpXsHX5qczT0WQPMruPqaPIRanEpEw4vT3zL/jPNH+phjXiff1VjHn
         /wxHrRedm40rMZFrmS1mGYb0mYDVRRhRquNz2kZ39ZdiQtSM/una8M0kcSVnzq5IBae/
         vnhD5pp7jV93H83HQ3cSSYHOd2sEOL19BRiMjnxd1wl+iq5/IIySjGilwUS10J5BPWUl
         opz70At6VTX0PGbJ4vLv7tRCYH14xKlG2kjacQwkqFaI9+lr4ImXjIWkH89PTWsaM5Wh
         3JaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733883173; x=1734487973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ENr+oTUFVNcUM072Bx4z+rQtyQML1ZHCxeXHzKI2FE=;
        b=pZoClIBCKbbl8/OscL61GOjsMVK50pqAtqzYsv+JWhhGXfVL9p4is4fHbMI3C69o4o
         tUcMH81eLBQYUqS2bl7RDtjvF9tejHyipGf+3AgzWmnVHzSIt17zZMcqb0bc9ACxGBfU
         Il+/rfIBmBm5Jmnh9LWmhwGNItri4PJVGAUSFhKs2fdusQS+onuVEuhJmG2IfhNxDBNV
         u7imHPCRditryVbjavQT+0CzAL0eJWhxliGuldApEXarylR2AcUtxvV6jzMyYxL8T7tK
         0qnwsLOAYkFNkjZLXInuW/00iqg6X/6ufegF01iVuAEp6kely0yIcRIyOaRPJaaMhFz1
         cI9A==
X-Gm-Message-State: AOJu0YzYqjLDA/ww1Otp3118QkAu6N7i9gQVjGLAWJ2ROwqMky7lVR2j
	GAI0HGQ+rJcwINFXtKAQrzewuUHCY7LDlT/gtvL70K3NMD7lfGX49A+CLw==
X-Gm-Gg: ASbGncsfdKaoNNdpJaAgubIxfEifLMIHnuspoG+r+Tk90rSap+MDIqEZ+LKewJ+kFCG
	CRJ2mFTjYLJKXz0Q8dpImkJQlSLqHpgxKYU2BdSpPFpTeHQ4b8DYVwZiNgwDsI++KULXh0ctgZX
	2EklTOvwyjtEItIMinpfkVDMZrr1LUldDKuH6K+tlhyrnImXbqX453/5+9yFSgoABim53uGlpXg
	sJQ1NGxniPR3lYg4FAP02MqGBELy0ZmA1dsbaxYCCTDSeAkFA==
X-Google-Smtp-Source: AGHT+IGcSUew2Dn7Zg3ipvwLjKZJC7Lz7Ztxse4QgovWNLxPlL5Aayh37ibDK/HtRSGp/Pe8AL4qQg==
X-Received: by 2002:a17:902:ea08:b0:215:7287:67bb with SMTP id d9443c01a7336-21779d60d08mr14230605ad.0.1733883172682;
        Tue, 10 Dec 2024 18:12:52 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3e5f2sm96573975ad.13.2024.12.10.18.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 18:12:52 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: dwarves@vger.kernel.org,
	arnaldo.melo@gmail.com,
	alan.maguire@oracle.com
Cc: bpf@vger.kernel.org,
	kernel-team@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH dwarves v1 2/2] tests: verify that pfunct prints btf_decl_tags read from BTF
Date: Tue, 10 Dec 2024 18:12:27 -0800
Message-ID: <20241211021227.2341735-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211021227.2341735-1-eddyz87@gmail.com>
References: <20241211021227.2341735-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using BTF as a source, pfunct should now be able to print
btf_decl_tags for programs like below:

  #define __tag(x) __attribute__((btf_decl_tag(#x)))
  __tag(a) __tag(b) void foo(void) {}

This situation arises after recent kernel changes, where tags 'kfunc'
and 'bpf_fastcall' are added to some functions. To avoid dependency on
a recent kernel version test this by compiling a small C program using
clang with --target=bpf, which would instruct clang to generate .BTF
section.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tests/pfunct-btf-decl-tags.sh | 65 +++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100755 tests/pfunct-btf-decl-tags.sh

diff --git a/tests/pfunct-btf-decl-tags.sh b/tests/pfunct-btf-decl-tags.sh
new file mode 100755
index 0000000..7e7f547
--- /dev/null
+++ b/tests/pfunct-btf-decl-tags.sh
@@ -0,0 +1,65 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+# Check that pfunct can print btf_decl_tags read from BTF
+
+tmpobj=$(mktemp /tmp/pfunct-btf-decl-tags.sh.XXXXXX.o)
+
+cleanup()
+{
+	rm $tmpobj
+}
+
+trap cleanup EXIT
+
+CLANG=${CLANG:-clang}
+if ! command -v $CLANG > /dev/null; then
+	echo "Need clang for test $0"
+	exit 1
+fi
+
+(cat <<EOF
+#define __tag(x) __attribute__((btf_decl_tag(#x)))
+
+__tag(a) __tag(b) __tag(c) void foo(void) {}
+__tag(a) __tag(b)          void bar(void) {}
+__tag(a)                   void buz(void) {}
+
+EOF
+) | $CLANG --target=bpf -c -g -x c -o $tmpobj -
+
+# tags order is not guaranteed
+sort_tags=$(cat <<EOF
+{
+match(\$0,/^(.*) (void .*)/,tags_and_proto);
+tags  = tags_and_proto[1];
+proto = tags_and_proto[2];
+split(tags, tags_arr ,/ /);
+asort(tags_arr);
+for (t in tags_arr) printf "%s ", tags_arr[t];
+print proto;
+}
+EOF
+)
+
+expected=$(cat <<EOF
+a b c void foo(void);
+a b void bar(void);
+a void buz(void);
+EOF
+)
+
+out=$(pfunct -P -F btf $tmpobj | awk "$sort_tags" | sort)
+d=$(diff -u <(echo "$expected") <(echo "$out"))
+
+if [[ "$d" == "" ]]; then
+	echo "Ok"
+	exit 0
+else
+	echo "pfunct output does not match expected:"
+	echo "$d"
+	echo
+	echo "Complete output:"
+	echo "$out"
+	exit 1
+fi
-- 
2.47.0


