Return-Path: <bpf+bounces-34815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1AB931330
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 13:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0895C1F23B25
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 11:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8FF189F5C;
	Mon, 15 Jul 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7+Q3yu4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8442189F59;
	Mon, 15 Jul 2024 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043432; cv=none; b=koW+T294OiRaGTPGB4K6nXIoLufmVmapDMPfhOundoijZTvYxTrfxlBXdgk5QbYOFEZyGs4iWAi/ENE8yd3CvdSGQh/pkG7Zt9NRROue2EOIi8F2Q27cZvinnkAdgEhG8vCzQCLIoOWdiHErmcW2uqasHYtQGlHoCfshI1wQ5OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043432; c=relaxed/simple;
	bh=hsIU0PZrW12VmWojS0ZNyQ+YcYYS+pERmHvEaQUyfTc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a6Dak7Wc1qtwQsTEc0IsuglA2bgkH+/MsPT0nhpyadqE9t7jwurTQ8qQXTOxoUpipPCtFYCtEWAQ1ZMgSTa5wnqjT0rlHtMIoyFxBgMqkHiw95/r2AJABEq1NbIX6+vS+2W5FNakJxJLAzF4jrywIIKTjXh3xe3+yTkwhZDYUJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7+Q3yu4; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70b07bdbfbcso3805761b3a.0;
        Mon, 15 Jul 2024 04:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721043429; x=1721648229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sP/TRuzcICPGc5HdDcc7PYBBHopttaFBz0c5KUsZhrg=;
        b=T7+Q3yu4Iq4QSl4iNwk9GPKC/fLE4zjLyCS5drsRjjdpKi/LDyxu0aV/VppHr9r7uK
         KIXtaMDMLeHLlbbRJ1uWcAsleWz7wpoR7zIzzYfe9ln7SLBTd7ekZRhO5WYa6gP+r/Ki
         0vZXx9WT1zeKXZJ4cWyf0q2w6V8sCM1ejRVfD2zt9J3OY8rBDb8PP9ojttMLqFPGT+fA
         CApKS1TGsE9l0YQNXxJPYLhnt6sBUNihcsTjEqKPjtk/t0vdumj4fQB+CyXYa14g5Uvz
         INoej226iMgUnZCnn54hVbWpZx1qHAOvkL53IfrLEfgr+ktKYTAIG7WNnavVDJfblqZ7
         jUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721043429; x=1721648229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sP/TRuzcICPGc5HdDcc7PYBBHopttaFBz0c5KUsZhrg=;
        b=FJ3Prqwx2GlWAxSyBl3unqNzH40LcWgvEvm7JH3oC18OM/HUaDVQjIKOSvP4Lahcjh
         s6GmEnr5zJM0n827O9LAEytoII8TkpVM/lZlM0HJp9HgPFijD0Ex0UntAUErHgUeJkML
         Mdq4L6m3Sagkd5pSKtbzHEn2eqhRCQMxDO8sH28+Wyy+noaTC2l46plHKvzH0bFTEeuM
         thKWB7XyZpxhO/rWSB/Se8dbiWwBRp2W8JTeN1bfJPNpFZIh274vZcEtngA5jBTfGGQO
         LSZdXsPeenl7SGP1DC7m3uYXWFZgfiq3aw7W6zmMG2dv6ie835bRZyg8KvyqidNCzvWf
         ap0w==
X-Forwarded-Encrypted: i=1; AJvYcCUe4LjVWx80xxoAWcdgW9OOcrAZgnPAYvbyZUyJ3FYbkamvr512bb22BHoFnmr1CWGkCk2uagSMJi5FiXT+4P2kGjcQXUQOUrJMH8nzLG5J+HIKAu/5zTRGRBXkuAYDU/NZ
X-Gm-Message-State: AOJu0YybieEis1G+EbPxHCKnFpyBRb09Q5aH1A04oqG4DbqPgHvccqLL
	JSGp2IYB1CEqoPP0mbUK1BrBr4W5S4lyDWSHsFv7rHenQrcQz1fo
X-Google-Smtp-Source: AGHT+IHAxJCsWWwrZjIfE1rKDvyhyeziTtM8Le4Ty3xnWkrdNPZJQk4IGh1DboG7YiHjyPl5N97UeA==
X-Received: by 2002:a05:6a20:d503:b0:1c2:a29b:efb4 with SMTP id adf61e73a8af0-1c3bed3227bmr12612270637.24.1721043428725;
        Mon, 15 Jul 2024 04:37:08 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc946dsm4110242b3a.192.2024.07.15.04.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 04:37:08 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	chen.dylane@gmail.com
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 0/3] bpftool: add tcx subcommand in net
Date: Mon, 15 Jul 2024 19:37:01 +0800
Message-Id: <20240715113704.1279881-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XDP prog has already realised with net attach/detach subcommand.
As Qmonnet said [0], tcx prog may also can be added. So this patch set
adds tcx subcommand in net attach/detach.

[0] https://github.com/libbpf/bpftool/issues/124

Tao Chen (3):
  bpftool: add net attach/detach command to tcx prog
  bpftool: add bash-completion for tcx subcommand
  bpftool: add document for net attach/detach on tcx subcommand

 tools/bpf/bpftool/Documentation/bpftool-net.rst | 22 +++++++-
 tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
 tools/bpf/bpftool/net.c                       | 52 ++++++++++++++++++-
 3 files changed, 73 insertions(+), 3 deletions(-)

-- 
2.34.1


