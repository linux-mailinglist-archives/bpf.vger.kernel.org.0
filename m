Return-Path: <bpf+bounces-27182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CA88AA5AD
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 01:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54882B21C1B
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 23:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBDE6A8D2;
	Thu, 18 Apr 2024 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EO4vCHu8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE32E41C
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482426; cv=none; b=r0W8cjMtYheh6z6od/1r46HXg0mqomuUvwMXR/U0HNwTS78QVnVFTawME+kjAJPFHFS+GmEzxPLcUjWqOrDV8RRi6uMxxbklYJ/qDeQE4aKCmfsidX/T2vPk/K0p5wzwQtPoMT6CqUACSBQX9CIfRqpN4oibhYcb8CVzysuxPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482426; c=relaxed/simple;
	bh=h4Z5MLdi8J9t3gzna+fG2ThqFUoIZcOZaNd46qMwcq4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WKavZ67AC4CXF7vYjWmdEyj4Ja4tNakhRxA5HZ2kNI2w9/uSEUS6lX2A9jMr+JGk9llDTYU7NCX5gO5hbmb3igQn4JNkM8y2z+UrBLPaRhL3wmX/3mthlsmN3Zi5TWG3vkwlgUbYGi/RaCLrHxxK20bbpM81nbRGn3PMPIDhPNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EO4vCHu8; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ed2f4e685bso1540054b3a.0
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 16:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713482424; x=1714087224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=26meAcCrC16s/TSKv+80D/MrO7azFsmm58EfNKygcv8=;
        b=EO4vCHu8HBfTVlRaYF4hN4ngr9nr3qbtyKtJSUkHJQHdegu/AvaB3O7kAYVbXAM6aB
         YCRXQ7RuhsFyro6my4lIq3h8He2yZFsksiBhqXUnuMIXzPlA4RVuIMNtCirEBhyAujDQ
         7GlKkYYzh7Qhiyucq7m2hV7dGqW2God9C5jIUVNGxjfHOau3nlgGEZcRX6YlFt6W3sF7
         K5X2ppIpoURVfuISZ92jNfzCe3RuQLl/31K+KvK4gkVvAMCHtayzG0z+GNS+Uq2Di9Jy
         pHMKiaYk7joykLG6ArEPWuRVHozL0Y6vEsC7ehWppYWJhN+zsfvgEmS4jMCxRQicVKgU
         z3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713482424; x=1714087224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26meAcCrC16s/TSKv+80D/MrO7azFsmm58EfNKygcv8=;
        b=EeMYoeuasKoMTrvYn3ddaO2hPWAYePD0kst5FZ/uqD2iexiwyoXek45Qfyrs6AJlV1
         AGujVEPPz60V1JzADac8eDBrqi/+qJHpkI4dOp+6+i8py8ECr86jLE9E1IVZ0smkI9cs
         nA2vsXpduL74S4s4Ubn6GluLKTuNDFozR8ujyTddpqmE56/mFQKt4ScizqOazpCUyYbi
         hFN63o95dT+S3kckuqYkj1mbybNVmu4h8Aoq3DAfrs6Ruz3uEKNAcSw/tNg0NsIYrBiR
         KNJPdnyiC9jpn7w1MkogeJ6YEJ3qnX7JIgp84HY+ctP2794C2O7sQ8GXmQ77Rqeb1HPe
         wwag==
X-Gm-Message-State: AOJu0YzrHntdlqVNFJTzf6/6bqMlLtt1J2bLuZXI2rzMg2chFzGj4Ww3
	+H8H0OfjlgBfrwEMAqPoJIDJGO38WLrhNnZlUlLMbQD9qIR82Rz0oMY5HwW8LGq8VE6YuXIKZsy
	ozg==
X-Google-Smtp-Source: AGHT+IFCT+LD8L7Ydyey8ugQxfC4hQL7hz4SeRVez+Chgb/ZmrwQpoWBky8hs4o0JI2AHzcCAT53BPCTo9c=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3998:b0:6ea:f425:dba2 with SMTP id
 fi24-20020a056a00399800b006eaf425dba2mr50612pfb.0.1713482424349; Thu, 18 Apr
 2024 16:20:24 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:19:46 +0000
In-Reply-To: <16430256912363@kroah.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418232005.34244-1-edliaw@google.com>
Subject: [PATCH 5.15.y v3 0/5] Backport bounds checks for bpf
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These backports fix CVE-2021-4204, CVE-2022-23222 for 5.15.y.

This includes a conflict resolution with 45ce4b4f9009 ("bpf: Fix crash
due to out of bounds access into reg2btf_ids.") which was cherry-picked
previously.
Link: https://lore.kernel.org/all/20220428235751.103203-11-haoluo@google.com/

They were tested on 5.15.156 to pass LTP test bpf_prog06 with no
regressions in test_verifier in bpf selftests.

v2:
Made a mistake of not including the out of bounds reg2btf_ids fix
v3:
Merged in prog_type fix from f858c2b2ca04 ("bpf: Fix calling global
functions from BPF_PROG_TYPE_EXT programs") and rebased to 5.15.156


Daniel Borkmann (4):
  bpf: Generalize check_ctx_reg for reuse with other types
  bpf: Generally fix helper register offset check
  bpf: Fix out of bounds access for ringbuf helpers
  bpf: Fix ringbuf memory type confusion when passing to helpers

Edward Liaw (1):
  bpf: Extend kfunc with PTR_TO_CTX, PTR_TO_MEM argument support

 include/linux/bpf.h          |  9 +++-
 include/linux/bpf_verifier.h |  4 +-
 kernel/bpf/btf.c             | 93 ++++++++++++++++++++++++++++--------
 kernel/bpf/verifier.c        | 66 +++++++++++++++++--------
 4 files changed, 129 insertions(+), 43 deletions(-)

--
2.44.0.769.g3c40516874-goog


