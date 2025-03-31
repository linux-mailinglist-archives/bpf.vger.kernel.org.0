Return-Path: <bpf+bounces-54930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF942A760F4
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 10:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3277E3A27EA
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 08:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2A1D5CD4;
	Mon, 31 Mar 2025 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir8ldP/L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DAC1D5147
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408537; cv=none; b=F4v0Ts/A1JxeG/rZ0odMze/RbGdsdM3OFw1Nm8kNZcbItCmIBZQzIe5TmBHxwPbQjED0ROJmZ48Xj/a8x8xoWUr4pm7A/bUV+lckeSVnIjZE5Q5k1rAws8khih2Ym/Uf891VPrVySEIqw873bMnTthc68m3vHG03qOX1bNvUnMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408537; c=relaxed/simple;
	bh=QkecbmYjBRlW1Vm6hBc++HvIFS5Za/9gBy64lO4KFak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uQVXTu1XCG9pdOIkDu/jiP+09CuBy951sUEGORwbAvmmNBpsNc5E1xCy62IBv3gbvBq2gkoHcssD2T1Q/xpoynnwryAsC8d8sVK6BbqM1XIGHT0KwnVEinabfs9GUkX7yobDJ1B7gFgQX+g5uGK/q1oNa0xgzQ6akYkr0f5z4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir8ldP/L; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394036c0efso26242155e9.2
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 01:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743408534; x=1744013334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v20haoZwHYHlK1plIicQxKbMsERw6eR66WePe+p3yOo=;
        b=Ir8ldP/LC9ODHjyIzVP+ea10oxqDixaNHxT/GlwAGJ0awKEsu9ImVzzyAd4prKaxsf
         TW4Cx5JMOQ569ilZmlh6fyfLFPmZz15MdcIe8h0cQvd7izjkXKoTIEH5Ei9JSLWkEsVU
         LFnNgQbEojDxosom+PlSgMUi3Ufse3M5rY2y/K3WrOhZKXoObxo82quv0lFxOLyM3bz/
         BzYZ5kOV1F215XoHNhsioM4102/E9ttYgs8PA31l7xfCZ/+qxpykjm5PUi4r4pWtS20E
         +5R35zUnfQqDdu0+t9eePCWTSGzqLN1rEmU41q0kegcmdbcfCDL8GDT9QD+wGMttW2ua
         7RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743408534; x=1744013334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v20haoZwHYHlK1plIicQxKbMsERw6eR66WePe+p3yOo=;
        b=GitycTQLqStUIMg8L2Cm8sUVDReOXtEWSZPA9RRBR/ntupFXSCGR/ygHItOzLLrBEd
         oo5/tH4sHBQwGu3CHMTGqRRbvwO1X429QqDUl8wPaRPcqcR4FYcxWegd1208HSDBsrl+
         2wEI9OXuwx75OITu2pN19SqTSfbroyVBNMCjQWUiSPcdLAClP7Rqv3gw8jg86ui0SlwF
         ei6g7nJylsovj64GmgAhN/OStDh2TtwvF84SZAG2HTW18c7KIY+r+nQHMZXbr2x//46I
         TJazLN0AZYNqzF7jfXi8AunqbBa9s0KJocifoY0ia3I0OzzOQp1PfAe2WyLNXCivyVip
         L+dw==
X-Gm-Message-State: AOJu0YxfBnC9hRrT60hTqzLWue7j5eM+Y7MDa5eQLpyocOBZy1I+501V
	Nq2uZ81QU0s03hYisRn5+OyivemSIxfW9WD0cztBFUDEDwfElROKWF7VTRjB
X-Gm-Gg: ASbGncui+B0/4vhIgUolD2ac7edwLZ81ViZplnc+5MZUqV15SChYP4va/xG9b5lDevB
	PQ3zBbvVC6Eu/XgdOr3eC79tddQe8A0vKRXyrnLW3S5NqleHudoKgLSNISo6iuQ3KkHkZSgtwm+
	1ahThU6ow9WWTrh2JnmFNasdeQytwLC7uUWtIqfZ3K7eVeaONmvOR55/gMRwo19mBH7m1OArDeN
	wPG5KXiU+NmcePQWr9/n7nXx94aRK759XkpaWjRWzL3bYI57ywpx+Ht1A8eFQPQZ8nf326O9mbU
	7xM8A8UA6zDmJrae+8Mw1O9BnbxDMZskjzpaZ843bPaT/9Xu68oLsnZEaiMDXh6Q0qqncVLTj20
	=
X-Google-Smtp-Source: AGHT+IG4CXBPH1OK2DswyGXA/36SQKxoCIgVLXZ0QUFbhRQVR9lE1wcOXhv1+VDgCXHQW+V17HD01g==
X-Received: by 2002:a05:6000:178c:b0:391:29f:4f87 with SMTP id ffacd0b85a97d-39c1211c8f4mr5725754f8f.49.1743408533901;
        Mon, 31 Mar 2025 01:08:53 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b658b5dsm10471987f8f.3.2025.03.31.01.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 01:08:53 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 3/4] libbpf: add likely/unlikely macros
Date: Mon, 31 Mar 2025 08:13:07 +0000
Message-Id: <20250331081308.1722343-4-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331081308.1722343-1-a.s.protopopov@gmail.com>
References: <20250331081308.1722343-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few selftests and, more importantly, a consequent changes to the
bpf_helpers.h file use likely/unlikely macros. So define them here.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/lib/bpf/bpf_helpers.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 686824b8b413..a50773d4616e 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -15,6 +15,14 @@
 #define __array(name, val) typeof(val) *name[]
 #define __ulong(name, val) enum { ___bpf_concat(__unique_value, __COUNTER__) = val } name
 
+#ifndef likely
+#define likely(x)      (__builtin_expect(!!(x), 1))
+#endif
+
+#ifndef unlikely
+#define unlikely(x)    (__builtin_expect(!!(x), 0))
+#endif
+
 /*
  * Helper macro to place programs, maps, license in
  * different sections in elf_bpf file. Section names
-- 
2.34.1


