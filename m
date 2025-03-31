Return-Path: <bpf+bounces-54927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0342AA760F0
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 10:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D90F1886B7D
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 08:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE921D5165;
	Mon, 31 Mar 2025 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsyuKSS9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3174D1CAA87
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408535; cv=none; b=Caxe/ref06pPoSaLzaXtHRNSNnQ/nNOJeClvsBGsu4tsWdvr/asHzyrQei8UGe7J4ZFYvo2Y99afcAshvfOA3EG6rNfEFOTvkpQhPaPsi6w9JlmzIqpq6tSwcylAKxa91lBZ6aCjWfN3a/gosVfy2xDZ7PAgQ8lh7lhTH1pOpOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408535; c=relaxed/simple;
	bh=R2Ls4WJgZ32YrvTPVG1fI8aV1WMu/ZDTKKfXfM8Tm0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P3dOvIFMgEtV5C+SPNxp9cxXJA32PR38mKPL0HUsOQAH3XOEfbONQDi+kmhTKkZk0oMg2ugVu1xbChwGUHGUuIcEA0XtBKxQrRYHOkF5Eaqeq9XzOfwKsQqrjjsqX+NvHyf1UZwopVPU4ReSXC49X7mSxbBHs3iCwWhnKYV1h3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsyuKSS9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso3987699f8f.0
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 01:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743408531; x=1744013331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PS04p96a+dh4Ckxj1I0Wk7ps7gVmGqqhjmUirGuVAh0=;
        b=DsyuKSS9v62VCWxB/ikVQT5FjJDHkWGdN7RcrNciu/7dh812OIgsNXiMb7UQU8U5zn
         TFpguSVofjvOEVlCLPdvWwUr8Ka7E0bDBawt/Ntq0pCyxDHDNP4JvIjLW7nb/+NOCmVX
         1IMAmrwTQmEzO7Ib0FDBhR6Pkh7a7QraZ//m51/6bdglHdlkH+Mx8aJgScs1Mqcwq2GI
         lxYTnYDsIU8gYDZdeuHk+oNHxUpye00IL6272ZRvyTIaIQmYLkrxG6oT7wSAE9MnD1NH
         +hYttCW/o6o3EojTsBI/ghAC95emsfZlfE0BtiL6+Q+K8jgF0taTOR9selreDVVklD3e
         7vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743408531; x=1744013331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PS04p96a+dh4Ckxj1I0Wk7ps7gVmGqqhjmUirGuVAh0=;
        b=L0MBBBq8S6LxLwUz9aJ3zCQQguTz4Q9zJjQTAQxElPP6Q3OmvY9ANEGPXGXygExJER
         jJkH8DHhSgPVMDfbhsvMuOT8LnEkOldPQP8QF+hhhl3VO1vuDfAva1rlnDzwZSpV8Mrv
         sMngkz7lsh3zqsJ3VmB37korNF+s1MnnMBGjRDdXSHX6slqmPXtj3HAKC5MkFjkHxxp/
         vJtH43bydKJkYgbrNZKti+WftiESr3EwYcNwyjUYvd+lXEK7gmcud57uM5zl0QyZTpWk
         WsCxlx8Qpl+HJnR/qE5BHLkj2RDndXxXsAx0LyC2FCiuRd0qAHxQbwKLHBvToIoNPre3
         EBrA==
X-Gm-Message-State: AOJu0YxGAvDP+gAY0njzNgsqzUj6EMyGfryeCuo8yPuHUIhWF83HNjG8
	cKhGcYPlw4RWvrevy3tYomJRxQSYjJmgib6bo1w5/5nnf/TCUAqP5/qPUnK/
X-Gm-Gg: ASbGncsRwWgMmPl8dkSw2shhM7HzmfSBkPg/rff9jdFd+D0zCylQckli7S0zBEkiz0v
	ECHryXeM+L6gwvOyCC8+IffBtMjXNa9DESBm77xwsr80JLzxbpJu0b1+etTC/k7BYkjDtGW35fH
	+AXpyDE92hltfopuOEmfoVLNBndENNhEmudutrGA855qQpTa6mHcCKqwA6L/jFCeB5cW8bD05TT
	GWPKydSYIo4H5kUuMZPx5laxuQzNlOwLMnDqTaRxKXw1vARvLxeo56TnzWhudu+E4Bh5BKdtH/h
	MzZsadk21qemaZWiGxrN643P8i5gqw3IIXzam+5E6N7XEBhbRu9plRk7NYTSPA4mnbR+5cUgljA
	=
X-Google-Smtp-Source: AGHT+IEd+0hE0v/tdi+ll4BXM572k02oKWBemB1/Fxb/WDtAiSYX6O6N7OMrfnDXlh1oXYh4M28RGw==
X-Received: by 2002:a05:6000:1a8d:b0:391:2a9a:478c with SMTP id ffacd0b85a97d-39c120e3d61mr5051481f8f.23.1743408531551;
        Mon, 31 Mar 2025 01:08:51 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b658b5dsm10471987f8f.3.2025.03.31.01.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 01:08:51 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 0/4] likely/unlikely for bpf_helpers
Date: Mon, 31 Mar 2025 08:13:04 +0000
Message-Id: <20250331081308.1722343-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andrii suggested to send this piece with small fixes
separately from the insn set rfc.

The first patch fixes a comment in <linux/bpf.h>, and the latter
three patches add likely/unlikely macros to <bph/bpf_helpers.h>.
The reason there are three patches and not one is to separate
libbpf changes such that userspace libbpf can be updated more
easily, and the order is such that each commit can be built.

Anton Protopopov (4):
  bpf: fix a comment describing bpf_attr
  selftests/bpf: add guard macros around likely/unlikely
  libbpf: add likely/unlikely macros
  selftests/bpf: remove likely/unlikely definitions

 include/uapi/linux/bpf.h                          | 2 +-
 tools/include/uapi/linux/bpf.h                    | 2 +-
 tools/lib/bpf/bpf_helpers.h                       | 8 ++++++++
 tools/testing/selftests/bpf/bpf_arena_spin_lock.h | 3 ---
 tools/testing/selftests/bpf/progs/iters.c         | 2 --
 5 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.34.1


