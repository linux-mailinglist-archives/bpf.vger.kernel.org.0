Return-Path: <bpf+bounces-55768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0724A864D7
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD21546064F
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 17:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37143239797;
	Fri, 11 Apr 2025 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="EAjHYXWs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A2C23237A
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392974; cv=none; b=OgZHg+nR7xOKFijkq3SnXUxG4bi76BlM3QWnSpbXiGyEG4KnkcAaZibceB6SNUxWyTI8Ry81pgyC9Kl3EkIz0u9FjBqhbiTV98MPu/YleY0E/8JT4zffGy31ZXJ/DtEUj2RWqWVKOjSEnqFvY9gmkaufL0Nk4mE20eKe1BEyW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392974; c=relaxed/simple;
	bh=4PQWKQhuFoEkUrYkIBOyAh45CPPAxPU1Y7NpU7sobEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjBVvtuRVVSz0R4K70lJpsujjpuhjd9MjfoGJ9wRXRjgUH1j99dycwNYvXfLq3uCklIvbJgKFYJVAajD3Wm/zY2+s2sfBJKezZ21+TuZc4wxKbTfJ2iSWTBbHDeysAUUp0b22LzdYs4AAO/B1sU+92ZzOk10npFsAMsSowTTowM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=EAjHYXWs; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af8cb6258bcso163354a12.3
        for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 10:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744392972; x=1744997772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBcBIX3JQ8GQQdeXRVl8BYiF3TsEhn82t3tctSMoA2M=;
        b=EAjHYXWsturkEu5QpXGCK9SIDzPPZendoXQpkaOjIGfq0DJhFcn9q4xQnIbdwQiWpy
         BthemN/isiZxJv6inC0OPQCo/bAX6Aj8OVp44hlkFd0sw0n0Q7lwDpQEPV+olBrUDRtC
         a/LEK9hbTDSV8h6hXaQ0FSa0sWM5lnwGneAXfwIwjjKe8Y9N6RcyNFWl7L1Ejem+J/Kk
         KQxmpPHv2s8EAoeWZU7iSoDOOJK0wzKpB8MNVgv96lldKWjXWeOzp3VWxWgyhbD13xiL
         Lh4m08z1PqGJ+deZL6wnC6zv6xUMZeLoxcmAvwb1UbKwHBoH8zy87P5010KtPaYGAWhy
         15lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744392972; x=1744997772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBcBIX3JQ8GQQdeXRVl8BYiF3TsEhn82t3tctSMoA2M=;
        b=Zb3iE33C6OSg8HbXahlgyc5x3mFrs8CRADeYQ16m2TIrsV3b43DiTECqangR6moKsF
         8zsZ5lwnZiTu2G/3MyHHSoWcBiT5tNlqp7ODdEDcggHuGPfXOn+x+0l56aAvC87SneCY
         KPsLbTLnA5lfbQVj5IVWjnMwda9RAQa/yC1FN8qHXSRkV/RDTYvefZ4m5tgsNa0BKDPe
         h0Y5kGPFXm0r8LlpzEWGZcFOgxyz7K0PLmxzt0/I7qKoHd/QmVSjcD/VqFdSXFPxVFCQ
         kFRvkVVnUzzA/cr00gFCewwA3cd+xo7E2NIVoTltcvP3/dHgbWjOkoxEiBxWT/sCzAu7
         PPDw==
X-Forwarded-Encrypted: i=1; AJvYcCU5kmZUKMtrU1aMQWUqIxZ7m8SEJKSMPxmB0ueZS41qDus122FFTs66/Bhbt6vcoKHSGRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYq1DWpMHIURf5u0mgHq6nLXyZwJS5sNT9xbFtWUK2m7w1MLC2
	CynPuG/FRZ8DaWNheBqEh6BZqtl1iyiy43WZ0Zqpm3MvspO8pNnHgY85OHUJprM=
X-Gm-Gg: ASbGnctxbaosMR3bOXf8Cgpo78mWQ93/ZCfct6esEHc7mTxpCX89/LoAwwOF28V6d9I
	zfpl07bBt79BWWZAF32kJXAcSimywC18TF0NxDTQkhSOvpxpDLug75UL1ewAhmFPTGPsou8UkQF
	G67ffesqaVn5kUncE6OFZIitpBCGMKzUpNd+omzhZzl5qsyg48sjhxQvr1OrCIOnix3sjMplm2h
	hY5YimQPv9kspv3JwFefYG2+dIrX04LKYxNYYHWjMfrKVJBWAlz1fXjoZESlHwYEfMrSUxsav5/
	XiYZf/5IikllDchY8vIdU8QdPuT+2w==
X-Google-Smtp-Source: AGHT+IEu4ySQucLjZTAosKj7hSH92jdMANqWvb5el3ORTT+M8uia+P8A3IX1NOAfnrQPNDtzLK7DfQ==
X-Received: by 2002:a17:902:ea01:b0:220:cddb:5918 with SMTP id d9443c01a7336-22becc4da03mr13386755ad.9.1744392972477;
        Fri, 11 Apr 2025 10:36:12 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:fd98:4c7f:39fa:a5c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb6a50sm52317725ad.205.2025.04.11.10.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:36:12 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v2 bpf-next 2/5] bpf: udp: Propagate ENOMEM up from bpf_iter_udp_batch
Date: Fri, 11 Apr 2025 10:35:42 -0700
Message-ID: <20250411173551.772577-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411173551.772577-1-jordan@jrife.io>
References: <20250411173551.772577-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop iteration if the current bucket can't be contained in a single
batch to avoid choosing between skipping or repeating sockets. In cases
where none of the saved cookies can be found in the current bucket and
the batch isn't big enough to contain all the sockets in the bucket,
there are really only two choices, neither of which is desirable:

1. Start from the beginning, assuming we haven't seen any sockets in the
   current bucket, in which case we might repeat a socket we've already
   seen.
2. Go to the next bucket to avoid repeating a socket we may have already
   seen, in which case we may accidentally skip a socket that we didn't
   yet visit.

To avoid this tradeoff, enforce the invariant that the batch always
contains a full snapshot of the bucket from last time by returning
-ENOMEM if bpf_iter_udp_realloc_batch() can't grab enough memory to fit
all sockets in the current bucket.

To test this code path, I forced bpf_iter_udp_realloc_batch() to return
-ENOMEM when called from within bpf_iter_udp_batch() and observed that
read() fails in userspace with errno set to ENOMEM. Otherwise, it's a
bit hard to test this scenario.

Link: https://lore.kernel.org/bpf/CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com/

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/udp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 59c3281962b9..1e8ae08d24db 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3410,6 +3410,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	unsigned int batch_sks = 0;
 	bool resized = false;
 	struct sock *sk;
+	int err = 0;
 
 	resume_bucket = state->bucket;
 	resume_offset = iter->offset;
@@ -3475,7 +3476,11 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		iter->st_bucket_done = true;
 		goto done;
 	}
-	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
+	if (!resized) {
+		err = bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2);
+		if (err)
+			return ERR_PTR(err);
+
 		resized = true;
 		/* After allocating a larger batch, retry one more time to grab
 		 * the whole bucket.
-- 
2.43.0


