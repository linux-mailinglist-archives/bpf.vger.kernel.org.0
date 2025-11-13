Return-Path: <bpf+bounces-74398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF44C57758
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3889E34C8BF
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E63A34F24A;
	Thu, 13 Nov 2025 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUkQWyzG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4741A86352
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037603; cv=none; b=D/mUEVLxyn2wNio9FPgckK1VeJo1SiCfsq0oWl+iddkqleJjCm3u+51jVMREFy3PwYaGujxPvgwXPY9/sI80mkBVvBWoY813Dq0PmjD89q8hTr6clUCtXe5oM0D1e2k2Ub7V25ajAUQNrwNGLRRRUv5vagZX+14CMPkX2UryMgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037603; c=relaxed/simple;
	bh=zPxQZq6swDm7cDZrcHpyHFJLp+QXnuSI6H2xrgOhuug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qN7H2Op/xYv7e+Py8kNnBi4R48AYuBXxzekaLz2QlG1MQWmM9ZwOPKfvoECG1Xx+7J1lGfSPHE8rXmlWnA1C57ZZLwEmExdaGao27OOwrARD3hkEtKgYstI3pHLJnlm2YBAS3Pd8niWqCj5EygqtCGNJd5I6x8HKyAcyV+B92lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUkQWyzG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b427cda88so525844f8f.0
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 04:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763037600; x=1763642400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wa4Z5vcyVHYCi6FZLrrSakjhFJDnPUnns7XV2UHv/wQ=;
        b=hUkQWyzG/XrseNZdjDH4Nab5qx84In6X0lgfOmPDZU3bBlwzbyG5X8sZifrjnIUL2q
         ISd/0Cj4gPhEdTzgulajy896RuirBzHWc9Nnf9TBRclb3sXRt5QUa8n+mOqEDCZBOl0V
         2EpQkAqXsPtmb4M4sygfTnSESXsVm1KkZRNwsHtR9BDPJw4aDPGYFUe+4fy1AU/QmCc9
         zvJbfbrjnWJIJQpg7ucj2mfpk/YnZGJav5OT2qTBEZAkCwEryGg4xo1ad9SzEn0c6SeV
         vziz+fA9/mVLhnlMDaNpe/7sDvGaiFJaeI6hrMeip/MDs6GHhDDFCnO/m2tB7QuZqMvA
         mukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763037600; x=1763642400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa4Z5vcyVHYCi6FZLrrSakjhFJDnPUnns7XV2UHv/wQ=;
        b=GWimYAYmuuz+e8armESU2EuwzwyC7zhyYl0cPl9s/VaBGfFv24Ue7i2nHPyej2iVuz
         5BbYjSozv5KKtkMt6TXqurrGbMUqDAhEp0uP/l/PJiwLUYzPLY8v6t1VyXAPqlOoTV08
         9AsT9irj+k2frfTR+nsCbr1LYAeq9+sNBU3+aqZCgHE6zRCOHhNwzajf386/1sqM5C/u
         WG/GDYw1R4HPAzHuoyzd3L7ioziVIwOf2bV4hROspI4wLc3q0sj7sd11NvDVYYJc657w
         kNa/L4Td+L2uaPC5I+jftRT2oBy6M48eg2F/1yf330VMjcohT73/WRKlhuZpwoqcgDjl
         Lh1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMzgOsFui3kF5YOFZ42Kc8FB5/7Li/8YgFtFjeVBg+ksj78K8HcNbR/a1ETiS65EhvyKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymHs/FLcI15x4CDXOwAOIVhQpAKddnpsLov5swf1lkQzsKzudg
	pfOR//PLM5BcBE9oj49WZaJSBOFwYRP1mTHsDHEhlXNRhGwJgy0OD337
X-Gm-Gg: ASbGnct4BrlVWMQmOx5DHaeYIc2h/uxAcK6Ygdq/zvSX0Xr9h7XknzPuC9aqbqtXM+y
	Jhl4rQusVwGFHX4HLaEYMCVNl60XdMuWBkx+l6SFr4s09ty6dV8NKRa0koSIdUQuMlUExQGwYgv
	lu/1Iopk3u6YpTG00lBEkNvcc44G6mXywDxBPAvSsLJHS2ckBLm2jLUCOdJnku1B1yENGWJ5rMs
	LjHoG/ucbStZgcbbQq3HOPb3pCI0yde5wWB5qIIJ4jYcGTsUCH+nicP/UporLH4V3iorAipyMLq
	z2OaThreZEwmdI+O1qe6QQabz0enHBxjNLXvKUWK2h8r2MlYxFBRIGPn6iQTLz+lGx8slcShYtd
	+zt1vXjL50Y7LWqO/v5LjG0Bm4Sf62rC2qdxEUTDwyublIooXir7W31pcYXrmT8/f5gBlQsMjIR
	f+C55hZRkzmlju8I7JZ8gL0s0=
X-Google-Smtp-Source: AGHT+IGJEiCSuPDOO3Jx8gHScyRdLNX97D4znVoZz/xNuPgCq2qLems59o3ScwU+fbav/LPhdOQFFg==
X-Received: by 2002:a05:6000:1849:b0:42b:3806:2ba0 with SMTP id ffacd0b85a97d-42b4bb89b8amr5613657f8f.2.1763037599393;
        Thu, 13 Nov 2025 04:39:59 -0800 (PST)
Received: from paul-Precision-5770 ([80.12.41.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b62dsm3697140f8f.24.2025.11.13.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 04:39:59 -0800 (PST)
From: Paul Houssel <paulhoussel2@gmail.com>
X-Google-Original-From: Paul Houssel <paul.houssel@orange.com>
To: Paul Houssel <paulhoussel2@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Martin Horth <martin.horth@telecom-sudparis.eu>,
	Ouail Derghal <ouail.derghal@imt-atlantique.fr>,
	Guilhem Jazeron <guilhem.jazeron@inria.fr>,
	Ludovic Paillat <ludovic.paillat@inria.fr>,
	Robin Theveniaut <robin.theveniaut@irit.fr>,
	Tristan d'Audibert <tristan.daudibert@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Houssel <paul.houssel@orange.com>
Subject: [PATCH v4 0/2] libbpf: fix BTF dedup to support recursive typedef
Date: Thu, 13 Nov 2025 13:39:49 +0100
Message-ID: <cover.1763037045.git.paul.houssel@orange.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pahole fails to encode BTF for some Go projects (e.g. Kubernetes and
Podman) due to recursive type definitions that create reference loops
not representable in C. These recursive typedefs trigger a failure in
the BTF deduplication algorithm.

This patch extends btf_dedup_struct_types() to properly handle potential
recursion for BTF_KIND_TYPEDEF, similar to how recursion is already
handled for BTF_KIND_STRUCT. This allows pahole to successfully
generate BTF for Go binaries using recursive types without impacting
existing C-based workflows.

Changes in v4: fix typo found by Claude-based CI

Changes in v3:
  1. Patch 1: Adjusted the comment of btf_dedup_ref_type() to refer to
  typedef as well.
  2. Patch 2: Update of the "dedup: recursive typedef" test to include a
  duplicated version of the types to make sure deduplication still happens
  in this case.

Changes in v2:
  1. Patch 1: Refactored code to prevent copying existing logic. Instead of
  adding a new function we modify the existing btf_dedup_struct_type()
  function to handle the BTF_KIND_TYPEDEF case. Calls to btf_hash_struct()
  and btf_shallow_equal_struct() are replaced with calls to functions that
  select btf_hash_struct() / btf_hash_typedef() based on the type.
  2. Patch 2: Added tests

v3: https://lore.kernel.org/lkml/cover.1763024337.git.paul.houssel@orange.com/

v2: https://lore.kernel.org/lkml/cover.1762956564.git.paul.houssel@orange.com/

v1: https://lore.kernel.org/lkml/20251107153408.159342-1-paulhoussel2@gmail.com/

Paul Houssel (2):
  libbpf: fix BTF dedup to support recursive typedef definitions
  selftests/bpf: add BTF dedup tests for recursive typedef definitions

 tools/lib/bpf/btf.c                          | 71 +++++++++++++++-----
 tools/testing/selftests/bpf/prog_tests/btf.c | 65 ++++++++++++++++++
 2 files changed, 120 insertions(+), 16 deletions(-)

-- 
2.51.0


