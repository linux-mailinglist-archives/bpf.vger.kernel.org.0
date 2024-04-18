Return-Path: <bpf+bounces-27094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B911B8A9047
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 03:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C4E6B21715
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 01:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4747FC139;
	Thu, 18 Apr 2024 01:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F9+yefgp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4B5CB0
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 01:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402449; cv=none; b=dJ3gRC0OHP+DE4enLcHR3z28Z6q0NBUcb72ihmCBwz8qkEVkrwmRfk30O/MKGWSSvZtMcR2atQuPpR74rt5fowGifQmdfjr9Ph3GaxYecI66ft5cHQixO6m2gE4qltsuKkWWkErDYY7kg4/SGbkzMjFhfGp2ICsE9F8q0Up5okI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402449; c=relaxed/simple;
	bh=ugT74PoHd8kn03j1TJX7vb14OkXu1n5AwTPK5v5aCCg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ws9fpDLUzXt5I/UHxOeGNNb1mthSsnwV2BuMSWZukfFQiHhrK0Rdek+ZgEZWe9ljhtze0aU31Lg9BB2y9rZzSfvGyk1n/77mANbH1RX7BKHFpa6hJvGhI7P0ZXWHyBmVzu/DP7iYfECwdCQTgVV9KvRIObZewOrYjfY8z5oe4m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F9+yefgp; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so606113276.0
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 18:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713402446; x=1714007246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MdSRxrDWVrTdyXc/SZ7hHOG18QRAIlMKQeP4juS8/a4=;
        b=F9+yefgp1nl7+IS9tccDVRKISTF7ti0wHBoZYtO5xeMClW5IeoRjUIg5mnKy2wExkQ
         7IbHtLW1LvUwFLNr702k+80yPJoTL2wvcjGc7w4aoQB0uCLCQBMcvDobMNegIIn+wLW7
         i+0VrBR9if43i1lQt3ByjE35ojYTmwQkt7LxhHklhh2euRfj0DewgA7/nkzpUxMQWTJf
         0kQ7G2bMk2CsqcxHhr4dJ+GcEogX1fjeIuTcLD92z5ymnSotq2S97GjY3bZhTDc+8IEN
         KtBvH3Yzl91CCV3Bh3lh46x90600Bp3cjixEu6y9opcMcmgW3TuIuEElSYbCFdSLRLb9
         Ye/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713402446; x=1714007246;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdSRxrDWVrTdyXc/SZ7hHOG18QRAIlMKQeP4juS8/a4=;
        b=CVTogFcpoKTjQCW0ybng8PCdY27lJpCoAU5Rd25F+4D8/o/eHqpEjERTS3BP4JuBGt
         jbT785SEIQyzM8kPL17wb3XBhOBXyXX9W77hSKDUXgJy2ExYSDsIx635wNQZaeT/ujKy
         Ct+moqNzXU+AfOmCqzXnxqi9wb7SV2m+KDLcuJE5AXzt/yeIt1OiXnlzw7n1p4rL0G5Z
         QVZuHrXk56BfV6SUyTWCv9y+d/bY3p71bTjl+h9bkd2itRjk9HSLjpGVTG98gzjXs07A
         6NmDG6wFR8nJS+GLXBjEL8nRqgAuk8AZhyuWT9lt7GsLpydb9LkEZn0XFgQsGEthJqLN
         UlZg==
X-Gm-Message-State: AOJu0YzApxZ8lAlBx0NwcGnvoIjUKopk9T7B+96WKHfpEHko+ecKh5iM
	S9mydBCWszzf7JjzyY7fjkRTxWW2YY2zZYlIVzUZ3WYH06ajwUvw/niCiP7hX8LS/sITnLEKATp
	eOQ==
X-Google-Smtp-Source: AGHT+IG38wIupQEk9EdfJseXhTp62aHkse9umTarR8j0kkObuskwYS0w1aDzglzbg09ZRXU2Ys2DSXgm74o=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:18cc:b0:dc6:b982:cfa2 with SMTP id
 ck12-20020a05690218cc00b00dc6b982cfa2mr116831ybb.8.1713402446546; Wed, 17 Apr
 2024 18:07:26 -0700 (PDT)
Date: Thu, 18 Apr 2024 01:07:09 +0000
In-Reply-To: <16430256912363@kroah.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418010723.3069001-1-edliaw@google.com>
Subject: [PATCH 5.15.y v2 0/5] Backport bounds checks for bpf
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These backports fix CVE-2021-4204, CVE-2022-23222 for 5.15.y.

This includes a conflict resolution with 45ce4b4f9009 ("bpf: Fix crash
due to out of bounds access into reg2btf_ids.") which was cherry-picked
previously.
Link: https://lore.kernel.org/all/20220428235751.103203-11-haoluo@google.com/

They were tested on 5.15.94 to pass LTP test bpf_prog06 with no
regressions from the bpf selftests.

v2:
Made a mistake of not including the out of bounds reg2btf_ids fix

Daniel Borkmann (4):
  bpf: Generalize check_ctx_reg for reuse with other types
  bpf: Generally fix helper register offset check
  bpf: Fix out of bounds access for ringbuf helpers
  bpf: Fix ringbuf memory type confusion when passing to helpers

Kumar Kartikeya Dwivedi (1):
  bpf: Extend kfunc with PTR_TO_CTX, PTR_TO_MEM argument support

 include/linux/bpf.h          |  9 +++-
 include/linux/bpf_verifier.h |  4 +-
 kernel/bpf/btf.c             | 93 ++++++++++++++++++++++++++++--------
 kernel/bpf/verifier.c        | 66 +++++++++++++++++--------
 4 files changed, 129 insertions(+), 43 deletions(-)

--
2.44.0.769.g3c40516874-goog


