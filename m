Return-Path: <bpf+bounces-42347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E709A30FD
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 00:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0721F22FAD
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 22:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29231D79A6;
	Thu, 17 Oct 2024 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isTp59gd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA271D6DB5
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729205449; cv=none; b=cc2IXe8frB8ExBtH4cfwJIz2kgZyWlYPis+w36OminejqUQreCHZig6TRdV4nVAObRC81MCuA/wUTqi6VW0NypDc0LVlqnUbvMP5+HZHzhSQFNGF3SaklXAWTZ/SCyw2oSSNRkU4y2+EeiPUmHQqfgThH58OlFE1gyd4xzs6T6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729205449; c=relaxed/simple;
	bh=02J+V8NG6bHla3E+1N/RlJCPVCy1MnSIM4FUtfDgQJs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qkneTU9nLWUrJopkhJc2WNP1Avz0od2MHG3J+R6tySScw0ovJLgj3k+3SODbYXAcF6cgT0QEyvJolQ1BAHSKmUeCR8GuaNLVnXR60cHjBB/QBXjqF0s2kUHMUGRpL2S9MYA/UAEWqH68NDkKxTov7BrDZ2Svl0bpH8Z96OkP9Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=isTp59gd; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e51a31988so1465256b3a.1
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 15:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729205447; x=1729810247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DO0xZfjMAK5plEQzAxj01KmG25qszPmEMxhmNCqVL1w=;
        b=isTp59gdCpJjF8SSQnodauGOyxvyWSIKx5ZhU4RO3LCXkbEjumCheeRsqSHZsaDpUK
         6C0lOiK4XwqdYzP4kZTzJyVVobvtRd1boy2FHfs2Cf54aK4LqquLXytPob2ut6r/kdsS
         b/DUY7lfSkYwgH3I4bOW2ubxS59m2Nb1PWUnOVqaqa6yYT6arJ3R7eF+Fz80Mic5HMmx
         XTn1PHZXgVPAReohYE9v/q5tR+KrpOgnxKaVUjD6ZWsy6QKZP3T+CXgniR+DvLw03/aG
         Crrdm71mskNjdUHV43vcxmhjhrX5C5iN89jbNwNQRO+ISoWTvjXaMqCrIRncqNUjIqZw
         F6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729205447; x=1729810247;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DO0xZfjMAK5plEQzAxj01KmG25qszPmEMxhmNCqVL1w=;
        b=dSZsd6a3lYEcUfLviAiOnOQ9eNZ+PCHWtDPhUxeZhvlo2lt+bixmVI+UxKJf99ZZ+j
         xRKVjle2P1r1SgMqXpQl+W4jIWey8FAnIkXg1FdwXow6DvZw0eUV/4sPg+Lrjn4yRjAn
         L2ztlRIOkzLHCqr2SQ3jRCgwuxdG01YlNBF9HdrFBmblb+pQdEgOEEQ0nvVTajTGLhDB
         3nA+Es+CopX7zsoqz/9fmkmX78sJeCbX4XqWlCAw6fhAS/2nKiOfkUdTl/gt9VCaZ/Gh
         ZoW7hMQxbfyowY9zZ5VjEZS3kLyPo5KjIURGUwubgrvATgZPpmOhL0F7Mx4dC19OGf9A
         bq9w==
X-Gm-Message-State: AOJu0Yy55jVPETd7w7+EUHKWhbavKeDkwRpOJn3KUqY+yxhNCr2DcAKI
	4nbCflRKTKYEvvNtC2jRzXBW1+qm5KZ4A0YmnP/X0QtTebC6FX4HkA6J6aXmZb5LZ+DHFbmkS9v
	/1opcXERbrLDCr67mctJt/q1WMtO1/uqOJPz2w+Hqgzuf7qPKPEEzMtqLvE6BWntov47h09XRBq
	MtLT/8K1wqDqD80WemQ3qonCo=
X-Google-Smtp-Source: AGHT+IGLK73eHVwoR0z/+pgC+vpmYoUvPITR59cWQylZjVbBb0ETIKY7OpoqslSyts6mQbSbnvHR2NSLGQ==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:aa7:81d8:0:b0:71e:5879:68a1 with SMTP id
 d2e1a72fcca58-71ea31884a8mr863b3a.2.1729205444547; Thu, 17 Oct 2024 15:50:44
 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:49:18 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241017225031.2448426-1-jrife@google.com>
Subject: [PATCH bpf-next v1 0/4] Retire test_sock.c
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Daniel T. Lee" <danieltimlee@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series migrates test cases out of test_sock.c to
prog_tests-style tests. It moves all BPF_CGROUP_INET4_POST_BIND and
BPF_CGROUP_INET6_POST_BIND test cases into a new prog_test,
sock_post_bind.c, while reimplementing all LOAD_REJECT test cases as
verifier tests in progs/verifier_sock.c. Finally, it moves remaining
BPF_CGROUP_INET_SOCK_CREATE test coverage into prog_tests/sock_create.c
before retiring test_sock.c completely.

Jordan Rife (4):
  selftests/bpf: Migrate *_POST_BIND test cases to prog_tests
  selftests/bpf: Migrate LOAD_REJECT test cases to prog_tests
  selftests/bpf: Migrate BPF_CGROUP_INET_SOCK_CREATE test cases to
    prog_tests
  selftests/bpf: Retire test_sock.c

 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/prog_tests/sock_create.c    |  35 ++-
 .../sock_post_bind.c}                         | 251 ++++--------------
 .../selftests/bpf/progs/verifier_sock.c       |  60 +++++
 5 files changed, 142 insertions(+), 208 deletions(-)
 rename tools/testing/selftests/bpf/{test_sock.c => prog_tests/sock_post_bind.c} (64%)

-- 
2.47.0.rc1.288.g06298d1525-goog


