Return-Path: <bpf+bounces-50744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F4CA2BACA
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 06:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0AA1669CD
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 05:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4696A175D5D;
	Fri,  7 Feb 2025 05:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="b1ky/Dop"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596C42070
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 05:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738907119; cv=none; b=SQogf7PZ0zMCLFN3j0FLC0FXwBIwYUPjvM2ETKtvXX712KsBrNbtp7ta7Oolm715rAvTOuitsiq2ZSD7eeN1q8HTzcnghialIzNMj7HLdY4NJPmSL5SeehBPfTagKEh4QQs7Id5xoeUxjp+MPApboTDfp6VlE6SLZdIBmk/Y3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738907119; c=relaxed/simple;
	bh=gGezzYUMXDPK6inJCR26T2eTUq46GlYyJKYRkqpWgx0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b6sOMpJgbGB8mQC7gsr/dusfKUqRJhIk2toEcN9omAfhE3cIjKeM2vilzgIqlJkeSKt3HndQSbCTL8kpCnhkQt8Apbr5aOdGN5uMQipbg7BUMAmrG79YaebVPtpWDfvOFC6xyC0mR7HKvckWUGR2zFJWigknsS6koBCIL4GfH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=b1ky/Dop; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7be3f230436so150970985a.3
        for <bpf@vger.kernel.org>; Thu, 06 Feb 2025 21:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738907116; x=1739511916; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5IiZZm6INZur7VVU7RwSrWYWqBqXxi7mFTnqmXj0pFQ=;
        b=b1ky/Dopd3ZyYLidjqAEjjEtD/pNxHIeEP6hdmIq5KfSj4M3FKwIZFAqROusAUAi6T
         OCDHKTdMcRb8yV1XzEnzByg7XgSxdQlHKnJpokKj85X1MMPYn8sZbJbaQKyUZNgl7h7R
         gXy1uPMgVm960SeUswycb4p6U0yRjtdAWJyQ9rGyat6qdoQma4BLghkTIVUcmSCKLCFJ
         JkMPt/gjly39jtkQfkE3zeawIr2gkCCx1i9TG4ttVwSh2VRhIhs9JAgtI5J5fTiCIY2k
         RIVNlQJdD0WF6QbTWv0xU//PsKajVtHPtNPW18Pp7yFEsebp+KSE2ph9EXOQqWLkTztM
         nBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738907116; x=1739511916;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IiZZm6INZur7VVU7RwSrWYWqBqXxi7mFTnqmXj0pFQ=;
        b=lLA2m1l/eelcqUdWr4JDfxXLW1dx2PIiuTXm3OP5v4FEUavAuQpNEnC3uMti8C4apX
         5ddnR08LnuaVao/ivE19ayMP3G3nMETrkcLAX5xZkJdGOVCEJuIv1YPRLb2/8E2jm02Y
         FqbBzRGe4JFO40foSZdD+9hgWFMyvzW7GCiPGE9CbRDn4CLi+CyWJIy2JksIRkxv1NPl
         3e1FPgcpEXMDNogwN6t4JI9TXqyg+2kHE2nKu8ahjAAnlwjQLgeWLQnEb46BrfyDzJMr
         YMB2E156NOIltCduWB28wDzVGXXNtWAA6MqWs8wmbbidRUIFPIeuz1GASXZPB9jdmzJf
         e1tA==
X-Gm-Message-State: AOJu0YwH+maA1V2Dq5V64J1VimokIMiEMHfpwwCC5OrPU/lt8dRKr74G
	NfaWZmRZR1om1LOKbEJup0MV6/eIy5ZEWwMVSFhZRvjOVRi9p/Z141CaiwqYWi/lz7J3nn75cr+
	k
X-Gm-Gg: ASbGncsW0E/MLZUvXTzmV4o0ISj3D/gfBKDhtKPxObiJmx9WgVc3YqcWi38DV5HguqA
	nhaIDuM94MoaF4EDUn8CS1ZZHxt48wLPmyeC3ISZvkSbG7hBkt6FuFYmKDu5LnIsVAJhEL9qDwe
	ERufMGPd5i8tBxBWcIF+J9IKSbSnfvfDfJtVseiBqGM1fgvq9Qjnrqu0MRbCnuUFmgPj4Fjcb6n
	CKpinKNapLMsKMGs70tfuQzN33eY0SlHH7d22a4Lk8ZTzxOPd/3r4FdI+Xp1Qt9YCrikH5jV1Za
	Z/I=
X-Google-Smtp-Source: AGHT+IHeDFG4PsZo7iKREMUrGLF3htyuKAaLBY80zJViJUgHflhFdo3XRhrHt9jyqehSZE1DfqfxDg==
X-Received: by 2002:a05:620a:290d:b0:7be:8343:df2b with SMTP id af79cd13be357-7c047c34936mr298818285a.10.1738907116412;
        Thu, 06 Feb 2025 21:45:16 -0800 (PST)
Received: from debian.debian ([2a09:bac5:79dd:25a5::3c0:2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e9f9e6sm148107685a.85.2025.02.06.21.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 21:45:14 -0800 (PST)
Date: Thu, 6 Feb 2025 21:45:11 -0800
From: Yan Zhai <yan@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Yan Zhai <yan@cloudflare.com>, Brian Vazquez <brianvv@google.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com, Hou Tao <houtao@huaweicloud.com>
Subject: [PATCH v2 bpf 0/2] bpf: skip non exist keys in
Message-ID: <cover.1738905497.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

generic_map_lookup_batch

The generic_map_lookup_batch currently returns EINTR if it fails with
ENOENT and retries several times on bpf_map_copy_value. The next batch
would start from the same location, presuming it's a transient issue.
This is incorrect if a map can actually have "holes", i.e.
"get_next_key" can return a key that does not point to a valid value. At
least the array of maps type may contain such holes legitly. Right now
these holes show up, generic batch lookup cannot proceed any more. It
will always fail with EINTR errors.

This patch fixes this behavior by skipping the non-existing key, and
does not return EINTR any more.

V1->V2: split the fix and selftests; fixed a few selftests issues.

V1: https://lore.kernel.org/bpf/Z6OYbS4WqQnmzi2z@debian.debian/

Yan Zhai (2):
  bpf: skip non exist keys in generic_map_lookup_batch
  selftests: bpf: test batch lookup on array of maps with holes

 kernel/bpf/syscall.c                          | 16 ++---
 .../bpf/map_tests/map_in_map_batch_ops.c      | 62 +++++++++++++------
 2 files changed, 49 insertions(+), 29 deletions(-)

-- 
2.39.5



