Return-Path: <bpf+bounces-77780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 608F6CF0FAF
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 14:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95DF530380E1
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 13:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C0B30171C;
	Sun,  4 Jan 2026 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bf9kh3Y/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2DF30149F
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767532617; cv=none; b=Ew6exoo9s2DI4jBHHkJkCZGSLMuoiAqYF8WYR7u+mBAYkcbKfFV9cC45ii2hXEVqRie6yspqYFWlWScNlTeWcW8KvsF56BzJLPTvvI5ElUBx5JEV1hvT7ykuzN83nX8IpMqpB4oRK/qx0X9KezHYPhiOsCTkPn7Xj6H/gFFa15M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767532617; c=relaxed/simple;
	bh=m1Wr3OPL8/Qr5zlyB2IePNJAo/TwXbcuTLfdufW0ZsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aj70Ix+Bpm03OFbuuFyN/eWEdLXI56K5U9hsAY8Bp62DqBnvl132mc5qYldMc4nvltMHRKNpqZ3a9q/iWKLbHRV1zWCubeeMYVKbg9pQh2k3YO9LcRZkEZxOP8aBXanP+YR9GgXVD/6ZIlndvsVowh2WT9ugjG9NiVUV/H1mITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bf9kh3Y/; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34c902f6845so18756787a91.2
        for <bpf@vger.kernel.org>; Sun, 04 Jan 2026 05:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767532613; x=1768137413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kY1VizcfhsnSYv6g6C9J7o/m18cVK0abRI2+TAwroyU=;
        b=bf9kh3Y/RDgl8ZQZA2m4G0GvwUune41foelNoSpY8r+t+kuChL33j56F76Uim9lLgn
         b0AY5XfUhGp8icxxd5ZSosDVuwwqw2H5rI0iL7DlZPaLSeHeke0+1UTYjtDxl0DRGqqO
         j5jWOVw3jyxpkzXKOMwYeki+pPDpStwugDdQdu+jFCOM2GAedPjWjBVuN7tZmKsTy7+u
         JxgEMuDZZBxcgXg+dORoVEpWeJMqJLOW/gZneqCCmMB3Pf+piTr279sQuboy6jRGhby7
         lrzOFE7K1AQB45XMMlVa92mzxIMscDxbsU3NKKtydet724RgkgKSTDUw7+f7BdQluefU
         Ns+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767532613; x=1768137413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kY1VizcfhsnSYv6g6C9J7o/m18cVK0abRI2+TAwroyU=;
        b=eGN+kTX7eflS/CMHSNxVPz/66cTVCdIdUiad4FXrAePY+gFYL047ERADTacsBJvdAb
         /6JkoRj/Ppwxf4UyIxOaThKCxmPLiieGfnznwq5XTXxcMH8swvuRtx54qNmKal8a1RZ0
         KniTP8yGTHhPLmGYjJvRhltanGL35KCrsuOHXJU/OkE4cAX748/8gN3G/vBXaBNf5/Rp
         Fb2K7FuEWnJLe5gYCpeh6rlR8Gm1uMzeN29my/anSKf+wYnAhN6oI70DFmNak39bObbw
         CYfh5nMoMZPc1KE71+lPvJH+uOGX10sQqkUPd43LzEBW1pIKPYoMFf0mByRKJCEQvh1K
         OtpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkmmSwL9azIj/5YYh0mBOhvyz3nulDnUVtvSx1sPuSqc53zx48yH6AHdRHjOg9xD7UC48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7PxBLA8oyj/Al4Vj5h9qLoBPVWyi8NIiLn4kTkntpPvNlHN+m
	/FLtepflwORUwGvqwoV8mhCyMOtV6G3OOiEP0IS+TcXBW/m+eDdhyspV
X-Gm-Gg: AY/fxX5Xz9shEHiid7NsMknngBKpdJciF5pghD0wVsJ/e3324NRVPo9Q2ycfnO6kmvY
	43+DrgYHfHvYO7zls+DPuXqeU4p0M8mDL2YPxQ5GhNuSiCpuG3c/e5y1y0sOh/dQ+nTGehcL3rl
	SyxdKjNpP+BWKZwzUeDKCLYfcyjsZZhICROenDZ2J8iG9jv0GBClda/NRlJDkyQ+MQysKSpWw9C
	ylimA9Dxh+4HiWij5larT80rZ41BxmEPq0T1CGgju2DtSaIk4w0u/2I+b4JSCveGSmPvsTc/U97
	Noa/Pty9lalKf+r/GViM4wyMXpRXgobWDDTg4q9RvgUhzEVqFF/JGUiYroTJPnqlwyFEL9ogc+l
	TMOqkj1vYgLPrDzZS3gUgGRrzF8/5M5q+b6OztX0zkENr6wPrEEBqVQAoZz7msg1ukAjqBdf9hT
	KqCCFehKU=
X-Google-Smtp-Source: AGHT+IGgT1Wfsjj+Cb7xUcXjdG87p7VIhwzfAmHmsHRk10MVlBAltbjJbksbRxZWurNRKRVj1ChHEg==
X-Received: by 2002:a17:90b:1810:b0:34a:b8fc:f1d8 with SMTP id 98e67ed59e1d1-34e921ec5c8mr42434214a91.37.1767532612854;
        Sun, 04 Jan 2026 05:16:52 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f4777b765sm3701582a91.17.2026.01.04.05.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 05:16:52 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	eddyz87@gmail.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] bpf, x86: inline bpf_get_current_task() for x86_64
Date: Sun,  4 Jan 2026 21:16:33 +0800
Message-ID: <20260104131635.27621-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
to obtain better performance, and add the testcase for it.

Changes since v1:
- add the testcase
- remove the usage of const_current_task

Menglong Dong (2):
  bpf, x86: inline bpf_get_current_task() for x86_64
  selftests/bpf: test the jited inline of bpf_get_current_task

 arch/x86/net/bpf_jit_comp.c                   | 34 ++++++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_jit_inline.c | 35 +++++++++++++++++++
 3 files changed, 71 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_inline.c

-- 
2.52.0


