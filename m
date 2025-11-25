Return-Path: <bpf+bounces-75454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8CDC850E0
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 13:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED7E3B3B79
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 12:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971C23242D1;
	Tue, 25 Nov 2025 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="01qTGh7J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923B83242A9
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075440; cv=none; b=Ay/torOe0BKirugpsH443aEuX90aRnCugUdjEm1qYAwhZdE19sp3sh/BYbiwh+EBKkojx/p4Zp7rWWpYZTEMWVl/v3xcP7p/3pAQzGOwUYXJtDrNDYoQrmbOsZ6Uz+OlCt/p4+sMFr/8kPHSaF+U+rbCitRaBQ0daf9MXN20w8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075440; c=relaxed/simple;
	bh=4FYl5gXWx69xWYRTdou6Mr71bi2lR0OykpPaRKEDtE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fzvKM4Qr7RDigb+qqNgN3w+1f31/yCZ2TSdxxik3XW79knPnm3rL2dKn9AelgLRpUzYn+Wd2uR47ATqIaVJhzZrSl5xYeu5jpJ+ucauJWclgy/UH4oMsW8BjqgiCN4JPtkpZyN2G5grPexmySPZ79dNPkrjuZ9DTakg0n+C0HnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=01qTGh7J; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47778b23f64so29749855e9.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 04:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1764075436; x=1764680236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wm4ZzMzHX2TsgonZis+Sto8sagbGcfn+KsivOYqoBeA=;
        b=01qTGh7J68mqDmR+Snpk5WXVJYO7qQOOy2sCUG1cU4cLb30/8WB9/5+NChyZM+PUAA
         10IIqsL6PxsIkaIzL6y+YMYOizFIWj7j/L+EJHSDftrVKtJGL5iP0zQch352iMXKJFn6
         toC+Gk8XVXQ2lfLeNufq2TlWRf98oxxlHB/4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764075436; x=1764680236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wm4ZzMzHX2TsgonZis+Sto8sagbGcfn+KsivOYqoBeA=;
        b=wjeBtlNFHz9Qq5okMp33Kt2Wnn0hcZL28l0riEi30/4dBiIJG56HArHYqMQqL/dNte
         vMtwaKkrgVAjw2tPKi/JFKSdHrqWLXhmgAlNpPPWG4N/eXmi7m20ZNjMfxuLJL3CZaBO
         L43pvMfHQufe5QTvCaS2jgum5pMcEbkcXn4Wqda9v5Ca+5tX4+fgRmGeJR7klFJ4EYuV
         oZfzm9GWSTFmlfLbBb34dugHqpg1qpZyuBxfJrutC4pWpCKUxbcCJO029FZiI6G7s1ae
         n4xIop3bv5uhR4CqqnMpI9ysoo0bRf9mNVTO5sj1w7UyJXKA+hoBOMqKK1QWykEApH21
         /EqQ==
X-Gm-Message-State: AOJu0YzXwulYB5hykRhvzILEmI8OlA4Qwp3S0q5w+kwZ4sLifu6ODLi+
	s4UUO6xCO+fj1JMsAYC0ctaAFSQcnM1YL0JFsH6oKPYWARpzX+T2ExUQHFkFYBcnaGwk+lljqmj
	3G/REwT9Psw==
X-Gm-Gg: ASbGnctyVN8HKoe8xzm3YoNvTPWnrQhy+6GOsywhi4fCi+6nI1mWxIQyBg0XdsL9cMi
	/snDn/oWjppDMJjrUIc/mv0IGLGWqK7P+hsEKY+ZVQU5YrV0b57XmKUuF6PkuniV4etNvxCjtLu
	RrIESJacnnvkCnqBOEPE0/ns3g9Hyos4jBMeh8FgWw5YhAyEBg4gdgvigk5jpzU9N62j0J+IT+u
	MpPSvOjyoWvo4u61/IDRN0GRqGLp1aGxR2VGmk+np5BO/LYh7bvlBUBQkoLvVknSk4aZ4P5QMEj
	L1Qd/aGZw5Nd5uxu57PikGzeSvMTDxFBOlKo0xjGMg6XGS7nBiCox9r8xWYinsaMi2WxnXJA0ys
	AH70g/BCrZMm4y6YMSdZvyubn0lk0PXTpiVoT/WgSmesqdlxbSKaRCU1cUciIxRGqj/Gjfr8mx4
	DRRB3RRyPGu4EDtjOzqedrIkj52bLKiY6VU+Zw2as2NQjKTWX+pUQXrTdOXbGd2w==
X-Google-Smtp-Source: AGHT+IFZxe69qUelWyN+kdz7NRdHw3+bu/lL/jhs22o7ooSn3S8FzdPR3DHMnsnzoOV2XBxBAxdgeA==
X-Received: by 2002:a05:600c:5491:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-477c110e391mr148193945e9.10.1764075435837;
        Tue, 25 Nov 2025 04:57:15 -0800 (PST)
Received: from Dimitar_Kanaliev.sgnet.lan ([82.118.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1f3e63sm256668925e9.7.2025.11.25.04.57.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Nov 2025 04:57:15 -0800 (PST)
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Subject: [PATCH v1 0/3] Add tnum_scast helper
Date: Tue, 25 Nov 2025 14:56:31 +0200
Message-Id: <20251125125634.2671-1-dimitar.kanaliev@siteground.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch series introduces a new tnum helper function called tnum_scast
which can perform sign extension on tnums. 

The goal of this patch is to help simplify (and unify) sign extension
operations performed on tnums inside the verifier. Additionally,
the changes also improve the precision with which boundaries are tracked
for s64/u64, since we can more accurately deduce said ranges. The patch
removes assignments to worst case {S,U}64_{MIN,MAX}.

There are a bunch of other places in which existing sign extensions can
be replaced with the new primitive, but I thought I'd start off with
register coercion as a minimal self contained example.

The first patch in the series introduces tnum_scast. The second patch
makes use of tnum_scast to simplify the logic in coerce_reg_to_size_sx
and coerce_subreg_to_size_sx. The last patch introduces some more tests
related to sign extension.

Changelog:
	v0 -> v1:
	- Simplified tnum_scast() implementation to use native s64
	arithmetic shifts for sign extension instead of manual bit masking.
	- Refactored coerce_{reg,subreg}_to_size_sx in verifier to rely
	on __update_reg_bounds() instead of the previously introduced
	manual logic. Removed some dead code for set_sext{32,64} values.
	- Removed irrelevant tests, added one that fails at base without
	our changes.

Dimitar Kanaliev (3):
  bpf: Introduce tnum_scast as a tnum native sign extension helper
  bpf: verifier: Simplify register sign extension with tnum_scast
  selftests/bpf: Add verifier bounds checks for sign extension

 include/linux/tnum.h                          |   3 +
 kernel/bpf/tnum.c                             |  13 ++
 kernel/bpf/verifier.c                         | 150 ++++--------------
 .../selftests/bpf/progs/verifier_movsx.c      |  19 +++
 4 files changed, 65 insertions(+), 120 deletions(-)

-- 
2.43.0


