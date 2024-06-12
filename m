Return-Path: <bpf+bounces-31983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F107905EDA
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 00:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A25284309
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 22:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2328712CDBF;
	Wed, 12 Jun 2024 22:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u57bf7kA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFB1A34
	for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 22:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718232819; cv=none; b=Dxfdjc0TCfKmyB6jS9qrnSPT/zGB5vovzub4PBO3m9N043sOnXOdPId1z2kGz6ytXl+qim5HgyoJqEmqX8q5HG0O3vmybWz+a08oqnhtwlUM2R5IBqNaze4B5FtoqkeoJnhO4W67Czq5YUsXJ2rv0k0B3fdqj0FmpAvT829aVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718232819; c=relaxed/simple;
	bh=pszCrOuQo1Fik91J9ix5S0BpO+yhZF7qRmzWg7dMzpU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RedGAan40WhhihzcgHZnlq4aBXwYJPU3oH8gECaOUKCKG72rsUy2TF9n/xLzX6t5jkvGSh0knYodK3W3gNEa7OmRtRw6cVHjTRNc4mQ1X8n0SKWZ5T4v9pSHTZUJJ9gHaqjo1tjhDG3Bm+PIzcJcTZpIubYyQiLRhrVGwPhLUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u57bf7kA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6fd42bf4316so157041a12.2
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 15:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718232817; x=1718837617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pfjN7rYQ+IFW4/NQWBv0A+y8SOtSIoXaKYSj1kXpulY=;
        b=u57bf7kAjWwTEekTQQ1T9osGu4M/V7k/L/F6mccMKz0Zk2WAMfI+rnvUkxX1T7p6ZY
         I0C5mTf+U/C0UF3FtH4awdWthn7loJwcB29rss2sDHNQGAXNxKY2M5eMmJWY917nF3eT
         W1wYJpVjfz/79T65zoYV+LTcpbmlEcc5yt8hEF2pb9zfZeeZ6wL9Kovwiyc+b3bd+u0L
         8uvjTgqKfAjMmpdVmZHIQX2rxqo93Dkqd6tL/lyIhrM9QeYVYuaJKiac9TyPQtlOprBt
         PQpx0Cpnx7xih7gH6LcRDGBOYU/ChcTMGJ2YMU8S3Dj7Vrs3k51G/X7VtDVB85NjqQCd
         jd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718232817; x=1718837617;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfjN7rYQ+IFW4/NQWBv0A+y8SOtSIoXaKYSj1kXpulY=;
        b=NqXBHglyJ/qA2JLwPxKhilCv+b+GqsRDXAv6KJ8skmrZ5pUgrNheZfVUxp4ZAIPO5u
         +ELmm9T5WUG5Gn8ZaU++o16WTplhZ+kAmANA39+GAxd/56su5/fBxtkjRQuW7rGOdDGn
         UYzd13BCqjCHctrzYN+sDqgMHzEPyDABYKwrkLUEVCuqzwKhyuIlPbhlmrHylWj1Qh7J
         LOt9PIe/LbkFIOAGQnI1yQ66BO9HjwV9GXG2ynqhe9i4qcaCgWzl7sGj84Hxtn2us/MX
         j5Fw9HG8bJpGY37NbWJC6UQNMbfg5tH6lKuvo6l47MY9Q7aiO6MkVOMo9dG/d+0lkmyJ
         /SrQ==
X-Gm-Message-State: AOJu0YxpW4KwpishURKbjNZIyCitZuVO7WxwpGjk1b3Ib+JBRSY03ImW
	0c+9iKVpT/bQ38S/7KH3tgzroxXwmVTdjYmU97E9XzwUuS/Bs8zFTymasL7OqKIQUsnG/JJlMPy
	NyNK3lnjNo827gEalQ0ON7QKYaOtl3uERLmM7q7VLRRtDGnWDS2b4lr7lZ2MRoZRWVBJdCdcEU1
	gNAKm1XhoLpCGE
X-Google-Smtp-Source: AGHT+IF02DGIaR+GIFi1y2P81ozs1UNwFUk+gYrRQb7B31ZSsg4ekHdJy8EPVLDXr5ZJwQ8ozyOCHDE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:7d51:0:b0:6f2:e267:443b with SMTP id
 41be03b00d2f7-6fae1059604mr6893a12.1.1718232816470; Wed, 12 Jun 2024 15:53:36
 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:53:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240612225334.41869-1-sdf@google.com>
Subject: [PATCH bpf-next] MAINTAINERS: mailmap: Update Stanislav's email address
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Moving to personal address for upstream work.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index efd9fa867a8e..909ed91003b5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -605,6 +605,7 @@ Simon Kelley <simon@thekelleys.org.uk>
 Sricharan Ramabadhran <quic_srichara@quicinc.com> <sricharan@codeaurora.or=
g>
 Srinivas Ramana <quic_sramana@quicinc.com> <sramana@codeaurora.org>
 Sriram R <quic_srirrama@quicinc.com> <srirrama@codeaurora.org>
+Stanislav Fomichev <sdf@fomichev.me> <sdf@google.com>
 Stefan Wahren <wahrenst@gmx.net> <stefan.wahren@i2se.com>
 St=C3=A9phane Witzmann <stephane.witzmann@ubpmes.univ-bpclermont.fr>
 Stephen Hemminger <stephen@networkplumber.org> <shemminger@linux-foundatio=
n.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index cd3277a98cfe..cc38da3510ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3980,7 +3980,7 @@ R:	Song Liu <song@kernel.org>
 R:	Yonghong Song <yonghong.song@linux.dev>
 R:	John Fastabend <john.fastabend@gmail.com>
 R:	KP Singh <kpsingh@kernel.org>
-R:	Stanislav Fomichev <sdf@google.com>
+R:	Stanislav Fomichev <sdf@fomichev.me>
 R:	Hao Luo <haoluo@google.com>
 R:	Jiri Olsa <jolsa@kernel.org>
 L:	bpf@vger.kernel.org
--=20
2.45.2.505.gda0bf45e8d-goog


