Return-Path: <bpf+bounces-39262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DAF970F5E
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 09:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF39B1F22A3D
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 07:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5E31AE055;
	Mon,  9 Sep 2024 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcEHPB9x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E344E749C;
	Mon,  9 Sep 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866064; cv=none; b=YGkwc+7Cr+mz43LC+n4PvRpYupyCUbMZOMfwCsMOXGKZf6ZCQlOCJtIx9Ca6VfhbLoSIBMVEXKy3J8q8C/V0h/tK/7B8eWk3ODveMYGcuoOTzqiCe8AZYTC9n3ocp8Hue2dRRYq8wtMoZkE/dW89oSIiwwD87J7tZSvvbMj4Z2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866064; c=relaxed/simple;
	bh=CBPUPDOVpzx6z0r/nl7mM7J2sfWwKNsZg0v2ospXTv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BRvxfxagSD3D2+bzTFCKEEOhkOCoCkYtJOLI3KSU+RGzViWdYiSvGzFL96esPr7Ck/JXnUhjQfHs6DrFBmbk477aGna7ZVwjZq1VEIgZGeB9YiCnfa4yTFsyvR4HeO5Q1sjSLza+Y6w/k5ijwSuI/jAKyhUs2eb+kQZzAAma6dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcEHPB9x; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d50b3a924bso1047248a12.0;
        Mon, 09 Sep 2024 00:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725866062; x=1726470862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0Jnk7guILOVk0UM9YilEhJX10GeNSESAwsusvAnavo=;
        b=PcEHPB9x9qnGYZMwj55sOcE5EZLt4G0rQQJuz7SVrYLNiKJDbpmFPY6k6ejd1J/zYG
         X6yrLIadd56OmgrQ9LJ7tNQh5xxWDqP0qRrl+Qc+qnoQmlU+7LoPmb8wVB6rdgdu7Vln
         GzSTOGXuS77hK9gdlfuV/VDMu+ZuWD8VCM6ZCYa7TnR4SOPyewfwrAyJTBI73ye3jlC3
         NT41Ae43e7j6SMSzJqSGJHFuGXmWqA183gr2V3ZD/OyjbamJ1a95jtiWEcESbE+/QFjr
         dkc4Zzw1YsNr5u7IhdO4+xmmdFqzriu3R3XMuGP5oKp8ksra/DhA5W1OMtlJYCkP9Tin
         qX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866062; x=1726470862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0Jnk7guILOVk0UM9YilEhJX10GeNSESAwsusvAnavo=;
        b=mNCCIZqKic8x0NX1bMQeGs81wAftrKCNxnUjQ2tmU3RAPWUjlVhBj7XsgJi2nq0pHi
         TG60GUyfeMQ4fgCiQSGwSHkNeVAZDoOnFOSj8D+E3nYalLJypJUADO7oEFbFBfDLeQSD
         eEmbtP3ebOKWmJtdvDCNN7jDgfVZVZVnmQHYEin48A7oSZTSnC4vwntocpsWfZ9LB6sw
         HNWV5mLXpTzsB9mDEu+p9pOOotZmvRzML08AC757aFmAYg0fTgBwTi8V1BJWw5QmmD0S
         lITbL2a4+EIOLKq5/iM3M1g+ECXyav4lTyFh9V2Dyl8ec+YZuOs78w2ZqJaWueKEgeJL
         ZjZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpqdQidTlFyLfGj7pKfJBdBhUpKIvIglEdfMGm8kbUgs76bkWsSF+4ew2ZbdrFFvznS4m1C9IkhhVBJEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyz1oU1Y4iJ0jgSAitjZktOefUKhh3bIc/TnL92tqO4Bz04t3K
	jRTBOoZHm1KkIy5eU/S0+ktkd6qojd4PuzI7gm0FBnjx7vj/9um+
X-Google-Smtp-Source: AGHT+IF4uNErT+/HzeKd8MW/9gUo6eVz3u8EnWX2vHWp73GVONz70XuCTGceuKX1OUPPuqtC63sj7g==
X-Received: by 2002:a05:6a21:6b0b:b0:1cf:2df6:453f with SMTP id adf61e73a8af0-1cf2df6485amr3777126637.0.1725866061881;
        Mon, 09 Sep 2024 00:14:21 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e11e19sm28397705ad.34.2024.09.09.00.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:14:21 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@gmail.com>
Subject: [v2 PATCH bpf-next 0/2] bpf: Add percpu map value size check
Date: Mon,  9 Sep 2024 15:13:44 +0800
Message-Id: <20240909071346.1300093-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check percpu map value size first and add the test case in selftest.

Change list:
- v1 -> v2:
    - round up map value size with 8 bytes in patch 1
    - add selftest case in patch 2

Tao Chen (2):
  bpf: Check percpu map value size first
  bpf/selftests: Check errno when percpu map value size exceeds

 kernel/bpf/arraymap.c                         |  3 ++
 kernel/bpf/hashtab.c                          |  3 ++
 .../selftests/bpf/prog_tests/map_init.c       | 32 +++++++++++++++++++
 .../selftests/bpf/progs/test_map_init.c       |  6 ++++
 4 files changed, 44 insertions(+)

-- 
2.25.1


