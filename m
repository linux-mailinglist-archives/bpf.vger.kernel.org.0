Return-Path: <bpf+bounces-74644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC6BC60097
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 07:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 973F335FE1A
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 06:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179831FBC92;
	Sat, 15 Nov 2025 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auA50SrN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5B62772D
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 06:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763188548; cv=none; b=IgCgOgUIIzMN/rVfDlLU1761RLtSUw2bCkZEl4l31+FvJ9TKtblpW4xEOhaBYERR5X+SXNwDP43yR9J+JUsXyQqxDoUz1Z4mWd+uxwCY2qrgSZMdyXGeZ9TivxK0rybvtq2nH4zJNJwaIp8Zg3euGp/sko2kqFI0M/41IP9mico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763188548; c=relaxed/simple;
	bh=uqaism/QJbclragkxlE4HR4kpiXL6LTLzjMt2F4uKf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1uk1WJ8IGg9BdiNG1KZWrVB5f9yZR522bqIJjznNtGP6ismetBCul1tyWKONThGj4dZ022p52CLCYaJ/ycgCryKPFQU6INGtn0+lGU/yFJfwGEgwNRLRWdY2T7Vn8cv/JnZRUfAdv3I50HP56XgKzp40S2DTtGbfxJu4mkAJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auA50SrN; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b55517e74e3so2179833a12.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 22:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763188546; x=1763793346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AGui+AdzM7aan5lAJ1kcgBs7yX90mlPwYwEf2onMajU=;
        b=auA50SrNxph5I6CjYSYB63UIbOYXYe4BPzZ0gK1yM/aimi5oY20AF108YAHbTV0OHz
         GVgNrmh4ycmY7WPMXDLUvApu1V2K91v7iIRLlwbYElzRBNeZoqymC8+IQ6lOvSp63vHG
         2OMJrxv9a6yL8LYy5nlUVvq0wp3xgZuA5cK87QWH9Q/LyShoHAvR1sGkZ16rvjhw4X5B
         aopSTcKvQSFBJJN1hLLrNWvwKg7u0u8MYnmdKIK6Q3OKxTdI5I7HKsa+4S2DnfiKN2yJ
         958PdsJtqAMZUZR/jcqNJXLH/LOLYZBhmACWuoOhvk9F4/ygkWD7niB4tsAEsLX+hajn
         rqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763188546; x=1763793346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGui+AdzM7aan5lAJ1kcgBs7yX90mlPwYwEf2onMajU=;
        b=cAXpXGTGJlBvnTAwMRUPspp6t31+ByNXKymlqsLh3gCxnoZzeS9XBgRZggbossuiCL
         MeswILYAvbDiMLXH9t70RIJN5msnCDcWQ2zLz5BUcge0+mtHXY4BxEyX0va42yIUlE4V
         x+HrijtPw0JqTHdS5eF6g4iBgn78zpGYMKfMqudlTVS4VZRxGqTP2RqEnvz6aQewK2yl
         P//bDFF4Z3YSxld7pvqGaBa1DPD6UytemKokvMkiLI62AfdkroJH9oS6qycalzp9Ml3e
         aw1dcUoIiZ69RYbkVSp3QkBBs3EliIfpAALOlp1U5W89MfM1HujrATM6nqfAAMgyE0xS
         S2JA==
X-Forwarded-Encrypted: i=1; AJvYcCU4wNdKvOTSaED35nUDSsy18EgsxFy7LvPmMRfhyvepPp9j/FInTv19As0yT6qWTftE0qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQYVChcyAuwcuITMP0oqzMxmLzC9IGK6MtKXP26VuPdm888Rp3
	By9sK7ANWjPglWU/BqiYs5VLuUKVIOkOQQ5+9WxcEBra81O87pwtPuvk
X-Gm-Gg: ASbGncsiq3OSfgNJ+J7LpcSCxM/ktl870Tgp6SAyF5StucruIPmHNtFaJiJHfzmuE1G
	/E6UdRiWOF5TyqPJSH9ai4vap24UOJaJkl7ElluXekx1jcevxgjFF7rvr55PSCybzapUDjN2/vl
	L3AI6CdzcTVI7Y4LneVFHD3jTqFMXzYefMECGBiUuJ36UQOXoln/euZpJHGRxEJ1a3vdJ1Bhi80
	JKm7YT8Nw2WCl1MWkKT20EAwuzvEEc8fMp/xMUVl6bu6XTzqaVqfecTD6+VrhNLAYRRFtCkhxY8
	MDCz3I6ICIb0i4utvgwxNbir6ZChzyUkm7L9xB7mmaVSOdWfAa/vT1Nx8Bg0v16gpgnaZRFZ5V4
	8TdPmWB4q5G+yzT75KvMG1UJGpl8/oM+K5KY7xeXqB+yaA6SxwLCqMDFQ5DDk6rW8nqFitklktX
	3EvQlGIv1InQk=
X-Google-Smtp-Source: AGHT+IH+R922UmhrzHHqhEhIc4l+mUYiBtLGewqFO+dYoCs3UdZ2ghbwO/7KvLaGEanZEaAkyDOAxQ==
X-Received: by 2002:a05:7300:d80d:b0:2a4:3593:c7d4 with SMTP id 5a478bee46e88-2a4abb32dfdmr1994874eec.20.1763188546369;
        Fri, 14 Nov 2025 22:35:46 -0800 (PST)
Received: from fedora ([172.59.161.218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49da0662dsm19056274eec.2.2025.11.14.22.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 22:35:46 -0800 (PST)
From: Alex Tran <alex.t.tran@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	corbet@lwn.net
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH bpf-next v1] docs: bpf: map_array: specify BPF_MAP_TYPE_PERCPU_ARRAY value size limit
Date: Fri, 14 Nov 2025 22:35:31 -0800
Message-ID: <20251115063531.2302903-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specify value size limit for BPF_MAP_TYPE_PERCPU_ARRAY which
is PCPU_MIN_UNIT_SIZE (32 kb). In percpu allocator (mm: percpu), 
any request with a size greater than PCPU_MIN_UNIT_SIZE is rejected. 

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 Documentation/bpf/map_array.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
index f2f51a53e8ae..fa56ff75190c 100644
--- a/Documentation/bpf/map_array.rst
+++ b/Documentation/bpf/map_array.rst
@@ -15,8 +15,9 @@ of constant size. The size of the array is defined in ``max_entries`` at
 creation time. All array elements are pre-allocated and zero initialized when
 created. ``BPF_MAP_TYPE_PERCPU_ARRAY`` uses a different memory region for each
 CPU whereas ``BPF_MAP_TYPE_ARRAY`` uses the same memory region. The value
-stored can be of any size, however, all array elements are aligned to 8
-bytes.
+stored can be of any size for ``BPF_MAP_TYPE_ARRAY`` and not more than
+``PCPU_MIN_UNIT_SIZE`` (32 kB) for ``BPF_MAP_TYPE_PERCPU_ARRAY``. All
+array elements are aligned to 8 bytes.
 
 Since kernel 5.5, memory mapping may be enabled for ``BPF_MAP_TYPE_ARRAY`` by
 setting the flag ``BPF_F_MMAPABLE``. The map definition is page-aligned and
-- 
2.51.0


