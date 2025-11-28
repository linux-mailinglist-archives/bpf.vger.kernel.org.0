Return-Path: <bpf+bounces-75679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E667EC90F00
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 07:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8ACD64E281B
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 06:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108212C3278;
	Fri, 28 Nov 2025 06:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqcafEuI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91ED168BD
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764311174; cv=none; b=E6jt8d91rjjmPvoMt58v8PNfWaPWOjR5+oxk+ib1D52dC4xuEEBRd7M3apVpKgPj+7ZyjobxUby60ChMIVcEiWoiPEmzcq1xy/xldE/3XDLWsYOKOff7KPEtOPELwwZlZHfI69gWjgGAtcaZpOoTwpnpPqXjciuLvPM4jcuXX5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764311174; c=relaxed/simple;
	bh=bZT49ydu77wgwjmQNQdiRQaDD8Nx0YJxO+IAgauzRSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gTJGULrMYJAfn/WHcrObXM4+C/vXrt9kVe+A7coSWB79jRANpWjr5FM9FzNqNwg62lk4Ep2gtM3ZUxybl/REOENfoYH4RwGVWbwaVs1TozecYZh8P5pCsG3fQhIIAy8uDLdH61WsOjwza/X7eikRm8Vq4S57+R6taRH7qX8CHn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqcafEuI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso5990505e9.2
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 22:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764311170; x=1764915970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbDzoWYMXv2tQPdvVF9qBCi+WsV6MWBsivjlCPgz2/4=;
        b=AqcafEuIglfOaolB+FycS+rWBBJW+oTW2Y+POqeYNuIhcHvqy/05EF4pGzCVzVrDy6
         Q1CpPKzAQ/Cjj281puoLjnFLUBYG4UH2SPwYbyf5YyW8H8jCjz6pwrJdyD2/QE3g1KFO
         9sxqWVq1vL6T488xZH7wVPXotJJ/ElA2mhZhLkAdtozTJ4iH8HDb6TXGMzJLgPlruVGx
         ZmiM4aspG3GVjgqAUsvjpQ8xXcEtrYx23D884CbtbKcBqMB9pnpwSZtWvRg0qGZLQVv4
         S5qJyNKqgrqgbPmtM3dXN0gE3ukVv69OQ+rJJqEOQ9LQCLK/cwqMp5nmUzdqcAgSLFig
         l4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764311170; x=1764915970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbDzoWYMXv2tQPdvVF9qBCi+WsV6MWBsivjlCPgz2/4=;
        b=soMoef9RE/iZ5wzLzIo9KDqASf2UAz0AM56CeQbxyN4ugUe5mDfD7P7NttMQmXikRl
         HqIgsbI1Ap+PI2v99ir13xBPlAneIeTzwuif4PRutmNyIhaTniGHbgOlbgs/XlnBan5/
         V6gh6Clw/8fcQbWh01UKnIEixdjL4xGqsli+aByjGO3xqiW6KzTmVbyviQVJwS8NEaep
         kVA/wzqeFdRGJarhaBhWKBw2uIhDaafNIB78MgHY8JAEbW2pNCFGwZCbgxoA55JtQZOA
         pHzdQg/lLdytOkNSIeYZU/y+W0m0XGUQRpgeCdZXD3EVmAPJJ/EFW7KNsKzihR2RrvCv
         /NvA==
X-Gm-Message-State: AOJu0YxMJaXOnqDJKtgOjPsyQ94blsAD+NY0ooZLDKJ85K+mTh5DktyB
	DH5mU9jrwoxruC/aTZdhCZrQ/aIs6EaA2kRxzCE0dN684TXnR3voOV4141RD6Q==
X-Gm-Gg: ASbGnctU5NjodfHttV5uUZ7mM5tJBDE/TDury0Zjyn5GcvSfv0UCTdqfbUv+QZVv8c3
	ee/eP0MAFcOkUDCkUlsUrd+/qckKZHX0Yjbntu4aEYYr9GnAbEIlh4Nb13SkWV9QHmKUKz2Z3bY
	JzNTRq4gbMs10VJvG9WL8pk5vqO6uF7+GEn8XqrkGzcp3DsagQ/yPLKsxfh5uQdVKe2sjeuDHf/
	C77iLLf3ZNHnCGOu5AUOtpdjq7Y0/BMmtMKSbFcbwCETTWmAm+W/YVo+v73KkOXp8jr8mtSM258
	33V8MJGnbx0fQyeG8UUGSASVaWxMc0/R2UYwVCF7lqvlGt1RoN4QT3EDKMlocHywpZ2tyOB53cl
	c5Sikw2ITzTi/c+sSdON4XSMaHLSvOBBalWRpFfjpnHBspFdO1GLLgfDbbAv4w5kGwgNk6kU5xQ
	Tt+7J4ttNGwjR3/isvgxqu1pE2SPlrZw==
X-Google-Smtp-Source: AGHT+IHrjwZcNwq09Q6grIQ6N4P/MeihlBkNfbAJIstkb7DYSM0iD2VvExEF/8ds6zoe9tTzxCeltQ==
X-Received: by 2002:a05:600c:358d:b0:477:55c9:c3ea with SMTP id 5b1f17b1804b1-477c01f0b32mr264448665e9.35.1764311169767;
        Thu, 27 Nov 2025 22:26:09 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47906cb9715sm84784575e9.2.2025.11.27.22.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 22:26:09 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 0/2] A pair of follow ups for indirect jumps
Date: Fri, 28 Nov 2025 06:32:22 +0000
Message-Id: <20251128063224.1305482-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fixes suggested by Alexei in [1]. Resending as a series,
as the second patch depends on the first.

  [1] https://lore.kernel.org/bpf/CAADnVQK3piReoo1ja=9hgz7aJ60Y_Jjur_JMOaYV8-Mn_VyE4A@mail.gmail.com/#R

Anton Protopopov (2):
  bpf: force BPF_F_RDONLY_PROG on insn array creation
  bpf: check for insn arrays in check_ptr_alignment

 kernel/bpf/bpf_insn_array.c                   |  3 +++
 kernel/bpf/verifier.c                         | 19 +++++++++----------
 .../selftests/bpf/progs/verifier_gotox.c      |  2 +-
 3 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.34.1


