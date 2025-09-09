Return-Path: <bpf+bounces-67923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE79B503E7
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CC354356C
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AD031D376;
	Tue,  9 Sep 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="YsEuNfd5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FE4362081
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437249; cv=none; b=ExdaItFNf4GLUxxfk/DCpCK5Hf2/RHb9mbS2HN7UGuWIgJoa5ysZcaslYojMkuPOUMhfllmHQIfdcHSRztRsWhkImA5ZefFCiGdGRuhWqpql2a2bKzqy6HEdM5xbAo4kByKgg1VVdda1V7W/QZOcIDQjXJmAUY0wCaLWaTR1iJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437249; c=relaxed/simple;
	bh=XSIeSj830pAxnCxixhDk0Nl5CbpbAkt71UxFRmTYnKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+fnpOCieKOuIB5pHtgp/sB4u+/7kSQ80qbpWe2Mr/R1JxfJwdFecgOfngQ2ojElk6BUFCnjLi9SrOXRcvOBPqnnszIGPgDO202gWNT5P6k7m21tanC74BrkmYhvIJGhoZqfTTovnlLcdcE8LB0TfJOr7sqH5LIzXN4BGNG7ebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=YsEuNfd5; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4741e1cde5so641834a12.3
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 10:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437247; x=1758042047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsHf+mfrEqPsUFC8Nq/mEkzd6OpkJSukzvgBl3SUnPY=;
        b=YsEuNfd5Xl3sQ3UN0RQtd1FviFcyiwTZXD9+8tJmB24+YVYISX/CvcAJm5aueoSqSB
         H/qH+Ilw4zGOslIcKqluzYXAX9mgKsd5MkLTdmGbMnQyBa12Ye86Zq8XsAWfXS2+m0sx
         uQC1UfWOXnaZSa/US16Rzp6b60glCvHJEYTe7WUwhFnk/tf1siFVp2RZpPyZbLZNHzF0
         r4nPQdeCu/A2/U5m5SzWjV0wvXy9QMoJE45Zqy8UnBkO01XJB1JxdKZt+OW3Is+Aj6AK
         eZAtm3ksKT94HqFv4rGPV9/AOLEex8Y3Bd00Nqereqwykf1IzU97alcJI9YuTbR+35GP
         rwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437247; x=1758042047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsHf+mfrEqPsUFC8Nq/mEkzd6OpkJSukzvgBl3SUnPY=;
        b=HoMcWEP/1CnnGB98QWDVWAYvOtodglimyRa9M23Rgy43eR0Ttcf5r1rxWzcPiY63Kg
         HKfb6Je8duUH1cxjA8/QYeUKCHTMJvq33tr58HL4LjlMOroyULPeqH3gJslyrJJ+r+sC
         LqtDeQYYva2+2e+QSTe8LjAJjVKFulr8faevDc+F9+F7xVGSLeNHgzEBfAVrqiZytb9v
         tNilwIc9lZKhpRSnCqUPN5zpOwvd5b8veSt9rMglLKEtsKnxmm5bBvskQcAuSztydaXL
         7N3sbmnS6VljPmKHAAGrffii1l5p1TjUFea+zfILYzPfoC6rHfi/oS3lSQUhHhwZ4wyb
         79Ug==
X-Gm-Message-State: AOJu0Yw/tsbC68QG6xtZ8a5dFH+sKbvCgBoyXWWo1AMYQ53WWOXZI9/9
	k9KheovB1257WmqvGe9a/ALIq2S/k0Au0J1dWRcPjmb2qy4MnTMKNlWP7fWb9lrikLkKITT3yia
	7ZNTO
X-Gm-Gg: ASbGncujPgzhDmKCU8Z65aTNuWPgxLx49WaCbIe1CHcEXd1Ovs+V76hlH1Jo308zyjf
	3BYZOaY8lSP09cmxl47wLNj+D1lciK7znplSPDuBOkgm4j/khwLsmZdm7Lo6TqLcKx8GmlRAAT0
	GsKnIXwbvcsdRxfYKDkdREZe6xuEWaKCIxFodOzfEYloXmxuAHMxQxwemBE3Umcnd9zB52DzYfP
	UmGR2aQkmmyicL/7E1rTKwuR4Rc85lI+xJezmcN80bVsCv4ea+d9a+rP8Xg2hX8AT6yxn8ZQKr0
	EaYlfkZAfvA511Or/Me3k6ZfvjicGFxuZokzG1LuYpeeLKhItiG0C8Lf/8pm8TMyLy/spByOBL/
	9ixqfvispWRDeKaRIcge3766G
X-Google-Smtp-Source: AGHT+IF3E9uQjdLgpvgZaYRlWuAMi8DPv43HfG9lBWajz8EXFCmchbRVuFfhILqZNgr5NxDQ7IMBUw==
X-Received: by 2002:a05:6a20:4322:b0:24a:3b34:19cb with SMTP id adf61e73a8af0-2534441f6cdmr11018360637.3.1757437246794;
        Tue, 09 Sep 2025 10:00:46 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:46 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 14/14] bpf, doc: Document map_extra and key prefix filtering for socket hash
Date: Tue,  9 Sep 2025 10:00:08 -0700
Message-ID: <20250909170011.239356-15-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation explaining how to use map_extra with
a BPF_MAP_TYPE_SOCKHASH to control bucketing behavior and how to iterate
over a specific bucket using a key prefix filter.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 Documentation/bpf/bpf_iterators.rst | 11 +++++++++++
 Documentation/bpf/map_sockmap.rst   |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_iterators.rst
index 189e3ec1c6c8..135bf6a6195c 100644
--- a/Documentation/bpf/bpf_iterators.rst
+++ b/Documentation/bpf/bpf_iterators.rst
@@ -587,3 +587,14 @@ A BPF task iterator with *pid* includes all tasks (threads) of a process. The
 BPF program receives these tasks one after another. You can specify a BPF task
 iterator with *tid* parameter to include only the tasks that match the given
 *tid*.
+
+---------------------------------------------
+Parametrizing BPF_MAP_TYPE_SOCKHASH Iterators
+---------------------------------------------
+
+An iterator for a ``BPF_MAP_TYPE_SOCKHASH`` can limit results to only sockets
+whose keys share a common prefix by using a key prefix filter. The key prefix
+length must match the value of ``map_extra`` if ``map_extra`` is used in the
+``BPF_MAP_TYPE_SOCKHASH`` definition; otherwise, it must match the map key
+length. This guarantees that the iterator only visits a single hash bucket,
+ensuring efficient iteration over a subset of map elements.
diff --git a/Documentation/bpf/map_sockmap.rst b/Documentation/bpf/map_sockmap.rst
index 2d630686a00b..505e02c79feb 100644
--- a/Documentation/bpf/map_sockmap.rst
+++ b/Documentation/bpf/map_sockmap.rst
@@ -76,6 +76,12 @@ sk_msg_buff *msg``.
 
 All these helpers will be described in more detail below.
 
+Hashing behavior is configurable for ``BPF_MAP_TYPE_SOCKHASH`` using the lower
+32 bits of ``map_extra``. When provided, ``map_extra`` specifies the number of
+bytes from a key to use when calculating its bucket hash. This may be used
+to force keys sharing a common prefix, e.g. an (address, port) tuple, into the
+same bucket for efficient iteration.
+
 Usage
 =====
 Kernel BPF
-- 
2.43.0


