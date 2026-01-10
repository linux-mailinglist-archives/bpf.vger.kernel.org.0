Return-Path: <bpf+bounces-78473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3109BD0D71A
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 15:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DAD5C301CA1B
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 14:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6C9346ACE;
	Sat, 10 Jan 2026 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwTu+i8v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A57346797
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768054409; cv=none; b=aevdzd7VbQ/dfcrNos67ycbYyLHuJSxLU8Vm6Xp/q34ZmSO8e+xpc15+uQOSFMR7Zpz9XEbmdED9j/Nxd03mJFbQMVjP7kTVAji9reglbnjLn71zNyhH60M4ou/3Hxnz0qIGuII94a379Wm9LkpVebUlZjRc9wGxjXJvtq8IKqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768054409; c=relaxed/simple;
	bh=agW6uKNys5gOeoTrVORTjBOaAxozAsYVc4VUeEIRBqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzpDkneaxvmK9l+JCV5OMzDjndf1sE662LS60qpO5ryBUJlpmpmxe5kFCP/O01931YlTtZ9hGdiwpfDIdRk4+A88w7JMY6dRlDljGzA3jLBtByOO0lHG6p43KJ4c2Fu1/kznquzfP6XsZwZUjohOPTMatUwj5f2Hyk8SXlkkzyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwTu+i8v; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-81f223c70d8so694762b3a.1
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 06:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768054407; x=1768659207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft9yy1vLUwNJD7u+x5LfWhJWNGjlertbzF816wc1jaU=;
        b=KwTu+i8vVe4PjPzD2MKoi/yFtVnu3zAxaXFSXwm7eO8SoL0aSTamAdrmPLoPOMQ4K6
         0TEJ2F8hs0q9fvTBikL2RsWZwgrbr8ipb3hPfRZXeL7fzOZMMofCs9sswusdXD6d6pFk
         RtB5MACqzQt+/ewRh62x7dy0HDBPp+BlkQqvdJU40VOi7rpnzCZx5cTK7mka90xPylJD
         YDPxAIfoHElX6TUTETfYStS59e8VgRKW4QEveUhZFOv8DmFtoEOgtUKPf9oX0Z6jkRoh
         70kLf3LHLzW9zc9MHEuSumoas0OmuJjdUHzl5rZMaSntJJsQcW+2DMQ7pTrXLrdX1I74
         UjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768054407; x=1768659207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ft9yy1vLUwNJD7u+x5LfWhJWNGjlertbzF816wc1jaU=;
        b=PhX5PKA8+aegiDTU1awi5XOB3vI2LHA8QOdBWNh995DdENuJZ5TFIy9f2bjlVhWidW
         PQv2N45XxkHStqXGLbkDC07B3i2lxqFVaaIwwge+yqHKxnkVFKM99JHPBv4UQEZnxOrQ
         ruMZHuWnEltC8bs3ccX8etda2qKV/KA1WozFThlI0ehCXC+/sqf10bZvBiSamxrASrEZ
         ZEp9eRJugz7LZjChhO4ZxQsPFYVEbswFKgH6hNU7f5/rloS0YQemin44C/4ge2LWyraU
         FS0AB8nfCefKbAYX0K3Unbk5f/bhsTWohCmDBbLzrOUJPaGxO05AxOQO3as4cRq8zZj/
         SqOg==
X-Forwarded-Encrypted: i=1; AJvYcCUp75MzvgNvG5T8TD2ySEEYKp06Vsxn/pF/+MxgjhZlz6khNIoW0tEVrCTfWenZOo6AS10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7WxuaYGD/vdxtLW2973P2+aR+xe5ZOwA9vnrIt5grFg40H9+7
	5j+Ji/crJPZ5VyX6cYS79D6+zC6INWQ63U11BKh1Wyd0yY5vKcXb4xDm
X-Gm-Gg: AY/fxX4Ph2b2KTWlgaPnuyyKvKP1y1RYSzS6j12L4JUgxxSI+5H2dpsCm244utAAZqY
	kXRYEjGUvi7iurdssvu/jiLBKkC7xK8LCDPBthuy1FXTyOWDeGpPxfAF9jDZAYPQdnCRIXvAEw7
	UvgJ8vRJQzkNvXO3PYpDlxqKM+DkAhJPP9yrX9NUszLydaNxWGr172zSbkIjIe2Rc4eoWpYbJ0q
	OIJpdukNVPgG0ux4h6Kf9D2HLQXLldvdKa2XxSGRfAONIHY7TV9lS747ibT15/BwYjgFDZqJddL
	f9tsRrtyISCg3TQTn61V9Byr9t+KJGQzUVdC4wuD0DEtu1K0zmHwNzNQXNzAlYk7qCbfmTt82uc
	rQty60sEeXwiGeMISxp4pjy/Yz2yIr7JJN2K9Aw89wil/RG1WSXwZD7UGeCOAZ2aY3JliyzlNd9
	3CAB9kiUY=
X-Google-Smtp-Source: AGHT+IGlvr7nkz2s+OAg6Cq422OLetEIPAeEPAoKEzaZnt/qGoDTuQsWGmx5xIko0mpEb8nDogHi4w==
X-Received: by 2002:a05:6a00:ab85:b0:81f:1a4b:bf55 with SMTP id d2e1a72fcca58-81f1a4bc2a9mr3208433b3a.39.1768054406977;
        Sat, 10 Jan 2026 06:13:26 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f42658f03sm1481079b3a.20.2026.01.10.06.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:13:26 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
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
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v9 11/11] selftests/bpf: test fsession mixed with fentry and fexit
Date: Sat, 10 Jan 2026 22:11:15 +0800
Message-ID: <20260110141115.537055-12-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110141115.537055-1-dongml2@chinatelecom.cn>
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the fsession when it is used together with fentry, fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../testing/selftests/bpf/progs/fsession_test.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 85e89f7219a7..c14dc0ed28e9 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -180,3 +180,19 @@ int BPF_PROG(test11, int a, int ret)
 	*cookie = 0;
 	return 0;
 }
+
+__u64 test12_result = 0;
+SEC("fexit/bpf_fentry_test1")
+int BPF_PROG(test12, int a, int ret)
+{
+	test12_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test13_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test13, int a)
+{
+	test13_result = a == 1;
+	return 0;
+}
-- 
2.52.0


