Return-Path: <bpf+bounces-60873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E6CADDF79
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 01:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3CE189A2EB
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 23:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136942980A5;
	Tue, 17 Jun 2025 23:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4tlmChr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCFB1F5847;
	Tue, 17 Jun 2025 23:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750202321; cv=none; b=LIZEC4zGxAZqoWgRXTmfgX+qF4CdW2toUL8hwDOklarNYk4opzsJiYTpCWXz6WYVz+jap2lmCiRXu1zS8eBDNLDyCp8XFvFPm8G/xO4dT4+sAiyBKO3VzjOQ4Fp6rjXaDPMYsxk2oe7DuC4g9TfYIdSXzfobJDTr14NTVL7gub0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750202321; c=relaxed/simple;
	bh=tPLaqT0XJ8nrfzkBU9nkA2Wy+xH1RGEkXtskrER6iOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jXUFVrKUEmeLXdpchfdpkBiY9b65daYO4h6NK8zL/8nu3JbFhQnyCuTbrKNJinoyF6CW6S5XtcUSLVMr/XrdjwsZ3zRXKpRzxGQXGnp5OG8xMtnvN3fUO7wCPZ83EYBoukRcNO+Njo+NoD+k7RGpN1jw02ld6rGMR4mZOT7oqAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4tlmChr; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6face367320so61517266d6.3;
        Tue, 17 Jun 2025 16:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750202318; x=1750807118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uAavNtXTEy/ItbwFLsjFRgKmKMcqXHSbnjX4Bu11eac=;
        b=A4tlmChrTTbZzzpCJsEDQ1TZRQR1C4jkUDHEKYSB0IDAK0Mh3of4rSYr5rIbdqKiGa
         5QV5wHJz0qIGucczHalQPtfHnJBjmhRW7+xYuusiwTZiYDQC1XHPVMWbEtmtah5X2oPc
         /lp2jIj+6Feohq//OHHEbapAwbhX+FMGFpJC4TZaGFx5my3cIqDhIz8N2TAvF49Z/YQu
         oKZ/8n31e1qTcKW3xfvP1KVQm631Wk4wYpBF1zuHjs0QYdCgDocNkzm9jzKguo5Sq9FU
         A3mzjl2aJw14segFvpcibrF3U4suCJD8sHNK5w9jZD/Qc9aguYkIIvjBQ4TRfx+f2736
         c5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750202318; x=1750807118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAavNtXTEy/ItbwFLsjFRgKmKMcqXHSbnjX4Bu11eac=;
        b=KWqu40s2MjaGLqb3B4/d+DXAJsj8lzrQzPxVYFWxexdcIJMSs4RgtQqRSr2BEsnJG3
         gEPmsngWNnA53Yu8YIBMR0bRWZzTy6JgUJw/OZrnrGZw30AKjTHyUDs1uH05cEQT7hfo
         Pnuzkreg1wRvQmCp8XXlSfizz2IijFVALagUYFm11jdqKRhPBQmB8GrQ4D5zsRh9oliR
         4fkFLd2ZeLIRCPuUk7I+LyHkwCJhEna0wRBXm5JBJN+qwE7wTOcrdhvn9d/NRVRv5RBj
         UqdvWyFdaGxvaHMEytw9shzT6VK6YbDoX/SPbdo1FUb25nP1S4u/EIq1py/AWERJZhyc
         3IFA==
X-Forwarded-Encrypted: i=1; AJvYcCUObJohC2mIcM9jLIh5i6M4cdr1MVj4ib8nU2fDGtODkGUw1YiVKLgyX0fctxpyD8xB5yHW/pb3vnf2uaCz@vger.kernel.org, AJvYcCWryGeWLQML0/AreeMY0iDMMTUBCr9NuLNjE+UzzCCf2wZWmBXc8tVlbWB2kbjJ0bSIXIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4foD36I3e+EQ9Pywhz+xWR/U8IgtyUMB0AaKbMuAuXXySWEjW
	IgazP5Jp+eUWZy9gkZDIY/dheChKYMrS9WP/YnVuhEnVfLhkBS0MHUqd
X-Gm-Gg: ASbGncuJMv5h013ybS5cg1ciKrNGIsZBELWf0T1QYhRiBhf00onCJXpbgSb5jxXAt3p
	TdnEo/WYZwjkgQC87oE6MLNmhbreu4JG6OtoOI20rRYgU9rQsNisgLHuZplpRHvioXyI15/fwWP
	D0CXAiZHvdqDFjNioZJ2S0OIO7q5kmIbImxQAb4h0rLe4qVBVYaVrSN3iVzvw63Z/MlrvK5SNHX
	RuwZQE7KS3ukP+RkfwhFJ1NUBZB7QK7gnLT4PE9wHjFsLjtBVZfwBNxaX9AfBeFbavVhul+PJnC
	FM7lgJhUoHCoxDq68iuoI+exnKh8SjNJxXQDBI9wyVxTyiYsZX+4Zu78rdqW/SV9kz4gsGLBSPk
	EpZOoYkY63VHPieJwZtKJaeEI6ujUUz4kkptNEVIsnnK18++wWhwqH/fjRjklicFeB9R5PA==
X-Google-Smtp-Source: AGHT+IFmTufse5jxjgAZrCveK9CG5cYsrI0uZkITry7qkqBaYJ+m6Yb+OTtXCXcGcDjsHfV1ORx4Aw==
X-Received: by 2002:a05:6214:5014:b0:6fa:fddf:7343 with SMTP id 6a1803df08f44-6fb477784fbmr235285266d6.23.1750202317910;
        Tue, 17 Jun 2025 16:18:37 -0700 (PDT)
Received: from lima-default.. (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb5db9f173sm12992576d6.14.2025.06.17.16.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 16:18:37 -0700 (PDT)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: ast@kernel.org
Cc: m.shachnai@rutgers.edu,
	srinivas.narayana@rutgers.edu,
	santosh.nagarakatte@rutgers.edu,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] bpf, verifier: Improve precision of BPF_ADD and BPF_SUB
Date: Tue, 17 Jun 2025 19:17:30 -0400
Message-ID: <20250617231733.181797-1-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset improves the precision of BPF_ADD and BPF_SUB range
tracking, and also adds selftests that exercise the precision
improvement.

Changelog:

v2:
* Add clearer example of precision improvement in the commit message for
  verifier.c changes.
* Add selftests that exercise the precision improvement to
  verifier_bounds.c (suggested by Eduard Zingerman).

v1:
  https://lore.kernel.org/bpf/20250610221356.2663491-1-harishankar.vishwanathan@gmail.com/

Harishankar Vishwanathan (2):
  bpf, verifier: Improve precision for BPF_ADD and BPF_SUB
  selftests/bpf: Add testcases for BPF_ADD and BPF_SUB

 kernel/bpf/verifier.c                         | 76 ++++++++++++-----
 .../selftests/bpf/progs/verifier_bounds.c     | 85 +++++++++++++++++++
 2 files changed, 141 insertions(+), 20 deletions(-)

-- 
2.45.2


