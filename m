Return-Path: <bpf+bounces-37228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2AE952662
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 01:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F69EB24164
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 23:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB4514EC56;
	Wed, 14 Aug 2024 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hihThF2w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6720514A098
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723679903; cv=none; b=U4oFakL8dLVmtmCT8WNSrQgVpzntTN8GiNI8QKA1fxYei59qxST/DXs4SNjCvE0048euZOg3F0hnjaqNvkN7+Wa9gM3Bh0ERCPS+EvnNcpqHY76QLpk/KkNPSjJqeS/fIA4vR+QdbntGNr8CX03azefXtRzW5HbQPB37BTUcb30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723679903; c=relaxed/simple;
	bh=ygnGkXNWAfbX5NTow5gBPgrGR/h2UZp8xbt21r4B3Vg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rSTr6ibzTJlbux6sLwxcWn4GkXC4yRvxY1WtTVn0ocofS2rt56EdLWDTCVWLIR0FEzBN+QnJGvRArNzS2j2KNZMB6B8R+uCxo81w2nzvdvL8066BDgjoiOyo93zAz6NIBxs2xHkRlctpvXoC4JApzStuuwGGqzl2ZGeuqWlyAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hihThF2w; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so320002b3a.1
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 16:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723679902; x=1724284702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSqu8OeNuxn3tN8jIyFa4CdW9m4z7M2Y49YFPAM/Ff0=;
        b=hihThF2wNs+A91cgGlkBrH9yx25mCnTgFNJ28itRwAU91Tzs+WIwpyS7t43XmHuMXS
         1mcCCAQIeyXsyOz4qDs+8ysb+efZvZQBTJFKVi3m2HqCNoTUZsSaiAfZhn3x+Wwg+9hz
         7eMUgavDfyd5lOhGjC1i2e0EciTwzDqlbOQqyNTt5Qn1ebmbaYt3BPDVXeyeAkOJdauq
         WLO8h7Akd5PfXuHKdXQNWyrwc/bf9gsEqAQxhNoW9sCCdIxrXkhTOznbm+1pDE2vU6qz
         Gzr+sJS+T+KJi2bf2KIJrOSAvoguI3jpPAnjCbmn9G8NwqbhKdgm347+SAZIDkcb9wvt
         uruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723679902; x=1724284702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSqu8OeNuxn3tN8jIyFa4CdW9m4z7M2Y49YFPAM/Ff0=;
        b=JDnL+VKUIIXy4BYsaC8URVIavP22qxYOs2/UQxBO1XvLLFbU+1BfrCQ98avWsMWTVh
         /UACOqBH//Oulr9K9mSGOrUu+UDi88YeOHfAr9IZuc/ydlFwOc4yl3HfbXdG34B5ljmT
         AApjbbrgdZl+eFjkKJH+TtdnWSsPHqShe2zoMV2yV6/XkFZDLiajm7KfFeD41LYvziAQ
         uO3gC1q0vJgX7FFo7WnBpFwQXTupZUxHrH8/+rRDfFOkHiyAlNZZMaVJ6y8yAThP6tDw
         8iXwIEbo//YqLg4zIsedTOfHuysfZMNLAqkzDgKLuPVNDUM2QbW9onn+ZFUXwxcTW0g2
         OpHg==
X-Forwarded-Encrypted: i=1; AJvYcCX5IJKtxlZRjdADGNs2zwW/BAyZaNIBaZR9RX0F3fWSOf6P53FLmpn/OBOmF6L6sz6gTiiCdCoRXBZcqH4m/PYQjukv
X-Gm-Message-State: AOJu0YziBCkFfUElHAtcJ0kHWXPJoTbH9sE6wwoPJ4O1/M68IxviX7RM
	ndLud8cTbm5wbOh7g5GBX7Nf+U0R7rXiMTh5Vj3u6/tsYzADCzugZzbsXw==
X-Google-Smtp-Source: AGHT+IEB1BIVZ3DTvcOD8IjyeKEQBFMz7Twjk08cRfMQmlRy8F/kNd7Pv9BhBIylq6WecBSnCiAAYQ==
X-Received: by 2002:a05:6a21:b85:b0:1c4:aedd:7b97 with SMTP id adf61e73a8af0-1c8eae97e74mr5726659637.32.1723679901623;
        Wed, 14 Aug 2024 16:58:21 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef5229sm127264b3a.107.2024.08.14.16.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 16:58:21 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/2] allow calling kfuncs in normal tracepoint programs
Date: Wed, 14 Aug 2024 16:57:58 -0700
Message-ID: <20240814235800.15253-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible to call a kfunc within a raw tp_btf program but not
possible within a normal tracepoint program. Currently, it seems the
verifier receives -EACCESS from fetch_kfunc_meta() as a result of not
finding any hook within btf_kfunc_id_set_contains().

The first patch exposes the issue (as a selftest) while the second patch
updates the kfunc hook lookup to account for tracepoint programs.

Pre-submission CI run: https://github.com/kernel-patches/bpf/pull/7539

JP Kobryn (2):
  bpf/selftests: coverage for calling kfuncs within tracepoint
  bpf: allow kfuncs within normal tracepoint programs

 kernel/bpf/btf.c                              |  1 +
 .../selftests/bpf/prog_tests/kfunc_in_tp.c    | 34 ++++++++++++++++++
 .../selftests/bpf/progs/test_kfunc_in_tp.c    | 35 +++++++++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_in_tp.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_kfunc_in_tp.c

-- 
2.46.0


