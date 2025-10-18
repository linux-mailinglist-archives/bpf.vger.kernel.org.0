Return-Path: <bpf+bounces-71284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEAEBED799
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 20:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E05F34AB90
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 18:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BE5261B75;
	Sat, 18 Oct 2025 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2jwp8wm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E1517BED0
	for <bpf@vger.kernel.org>; Sat, 18 Oct 2025 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760811146; cv=none; b=CdEVwyigW61+LYk4sb/G61teLMpS/Yya3z/3cm+A89aggF5jarhKlmtLWnFETebEp6TNQQ+xETVn+g5492Tw030+0ziI2exnHoe1NzUjUM8Q2TAVltB9rfZr+KrDITSQckEbIbTvFTUJHhBe4gQK4mnFh0J/T/zyrNas7E/JYNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760811146; c=relaxed/simple;
	bh=NbePi+IahQbSkjH9l4oUjZqDWZYGDLqO0mT3Tj52yNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSNgey1wRLtqGY7QyNVRN8YAUH2tVcXImLaO/231aU3rx5ReH9jcxRJiwcF+7/hFP6FPIabHE1vZwzybHV/YtRzxhspz9sU+yYcT6GF/0G4nehaGNBIJgcOjnmd1L1IbCu3OY7OBAqdr4gwFlFkiVrHsOOK9gGvqvlkDBk3swc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2jwp8wm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29091d29fc8so31526585ad.0
        for <bpf@vger.kernel.org>; Sat, 18 Oct 2025 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760811144; x=1761415944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NNz7x8ijdaSKfJZxmVzdQGgD/aRBaTgM298y1Bdrq7s=;
        b=T2jwp8wmTHXWY2NkbQnZClV1+dp4IVji0B+6atraPsZLZ63slY4j7Ea+FQYiIX8GfR
         KOGGIUuv5icC7s6b8vwSoYKkiZNNt3KYetIg6AJTlfQ1tYoTKGLxgqaE5vma70RGXNud
         J0tbQ/CjnYau6C9q6MjXIgvJe8aCBkdOqkm7rlX4eJYxPsqY1uVc8DgUVrum6s5dB54w
         5Vw7NDNIiTjlOqshxxQxJ+U3Kmadft9+33VzseABmxuvdRvg24S8S5F3J561ogl6tZUV
         NChD57jiOw55jl9sT1J9uhGhB3/Iq0Msg0TKe+fLlzPW0Rlg90Vat0WFrxYZwcB9SJpL
         44Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760811144; x=1761415944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNz7x8ijdaSKfJZxmVzdQGgD/aRBaTgM298y1Bdrq7s=;
        b=ZHUz2eAJbp5i4Rg16/fd3V5bCSExhXM2qsufI0P5zd/JQhdhFGdxhWtDyMEpG6jkh4
         lAXIuXccrnosRr9KsKgpwJGdpQ3tYpwcjApqHjs0CxApxRySV2773t1vxXIE/kOioyij
         AYaRPWusEUZH0mJtH029vo/xHInEAet8burS9LzxRZHfACFI8K8EAgPoi1JoArTrMYZE
         4/PkpYhEPOPVh64k+zmrKMu9vy1FtUUstEcqGIVmNmM6T8Y/cvH14P7ufm6y47xCYsLq
         E0yuXBDLsbxI085vXANQe/mxHmabA7fJIKw0QgfSK/g3bT0IKg+Y3yifEBckGnV4hCNU
         5kSw==
X-Forwarded-Encrypted: i=1; AJvYcCWl8VVxVIIHGSj43zDkaKr1Pcp34DRv/h0MnqGL3cDE9fpHKNRUUl7ynz2FgrCEURxxkgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPYwmrpaSIvNMlQeyG+bC9DZLLUFUtU+s6/Er4WFFDspeaY/PM
	gkTwCj0j9Q9lBQvPK/AK7cUd+BolknPIEhDE761nPM7npQJbYKjVRrRs
X-Gm-Gg: ASbGncvw53VbzmlVlsq/qila7or3geUPNFFH8HDUgnLjCIkvIl8V5qRlvqrHOAqmklR
	0G0agNuEYcoxnFy8Q49M6apjhbTqcsvHDLyyb2XmWPyOuZtccftp6YLtUJiQbD0RiPdKhF/bXwg
	/ZMuMiCNI/igrHOACCkZKGnMh1Vr70QpsA/Ci0TDz8QLBR47wv/0o+DktE9QDFf7RVPmqwqpbME
	P3EMKUyBjOEZFbkoxDqSgfcUL0nov4RPIuZRiae4B7guw5CyCzPuWGksCddTtfS7KyJf2vRvvdH
	B+HY9wI0uWJfS1x7c41yNsGiAFriY1Kj7Kxen4K1+SpF6dPGFvsJN+Zl31n6gbq3C7YcjZ6ptYB
	Efh5EU0TZH6fV2+si7Ek5cAuwKvsBWUQRfv3+EzDz51U9CFXYN/EZFHl9pFTwlyiTQhuKKAgtyQ
	yb5IJTuIE=
X-Google-Smtp-Source: AGHT+IEM2As5xd01T9MyhOsY7Jq/vUwDCLwwpWmhJm9mhyk+XJJ2oR4QOLSxSgbrOM2CG4/v7kn10g==
X-Received: by 2002:a17:903:46cd:b0:272:dee1:c133 with SMTP id d9443c01a7336-290c9cbc210mr90330765ad.22.1760811144160;
        Sat, 18 Oct 2025 11:12:24 -0700 (PDT)
Received: from fedora ([45.112.145.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5deaed0csm3220410a91.22.2025.10.18.11.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 11:12:23 -0700 (PDT)
From: neqbal <nooraineqbal@gmail.com>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter@linuxfoundation.org,
	syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com,
	linux-kernel-mentees@lists.linux.dev,
	neqbal <nooraineqbal@gmail.com>
Subject: [PATCH] bpf: sync pending IRQ work before freeing ring buffer
Date: Sat, 18 Oct 2025 23:41:56 +0530
Message-ID: <20251018181156.59907-1-nooraineqbal@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a possible vmalloc out-of-bounds access caused by pending IRQ work
by ensuring all pending IRQ work completes before freeing.

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Reported-by: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2617fc732430968b45d2
Tested-by: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com
Signed-off-by: neqbal <nooraineqbal@gmail.com>
---
 kernel/bpf/ringbuf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 719d73299397..d706c4b7f532 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -216,6 +216,8 @@ static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
 
 static void bpf_ringbuf_free(struct bpf_ringbuf *rb)
 {
+	irq_work_sync(&rb->work);
+
 	/* copy pages pointer and nr_pages to local variable, as we are going
 	 * to unmap rb itself with vunmap() below
 	 */
-- 
2.51.0


