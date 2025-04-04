Return-Path: <bpf+bounces-55329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C21EAA7BF22
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 16:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 435B37A888C
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 14:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14CF1F3BB2;
	Fri,  4 Apr 2025 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G15l8zk+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1646D19DF4C;
	Fri,  4 Apr 2025 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743776799; cv=none; b=iP74e1G6KxopmyOUQaLawYcZ7poE/JT5ORiI4jcy3zpA3UMWsPCqF+KucCxUKGfPuRQ9zCRcaMRYj+E7pJ1mVl/bxzkBaNmdT2ow+SXXKtRQqg679lgbhzHD+08yLtlBOZzkHtq8ySCMlTwJG+qg2Zr9W+zmFIHASTM1xZPaoGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743776799; c=relaxed/simple;
	bh=E3MOBE15ihA3RzbIFckLshAHU4sW6QDFhHPPLvmG15Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b32qW0mH/fKSo43gX75jsvG+TfNz7wzS12eVDRzE2BFxV9XcSctZa9c4SakLUzSYBVhSQ7uwjvWam/NZUUYQrcF3T8SdjrGTRlBhH/ZBeJoI1y5Ge4pOH08Oh3oc8GPMzS0j8RGSYLYSSc9ITOmAJ073Zcfs8Ag8j9ENwBw2UfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G15l8zk+; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ecfa716ec1so21083886d6.2;
        Fri, 04 Apr 2025 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743776797; x=1744381597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3iBWqpwxxCwuh+HBOz83W4z7+qmXC6S8nay2Mh9xAvU=;
        b=G15l8zk+64ZuhNQdnMyesWHxRFbyG3ycxTkam6fb0stXXBh6P3rMHMhk3RP4hfFM3+
         LM6b6LdgXsRyT4aPihXodTDt+xUa3wFXedtroksjO1LNNLloHlpMS5qfSC6JUjWdLZSA
         354F6HbWeOb+3027RwYVLN9v/bwvcJQu/tA8jLW/nLf1AUnCO8Ux6fcokWw+9ep2wDkY
         mBS8AWktZS/A+kaDQ+DKugI2UqCXkB0RGR6VXb11Ba7VgT2z/9GmAjyrEKbbSH9w4WyA
         2sqRNAWiemwJdY8pOxxo5ZwvpQ1ITBDYybL6/w+o2QHDzdPj4EnD4Pc0y5b1FpdmQC8k
         Lc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743776797; x=1744381597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3iBWqpwxxCwuh+HBOz83W4z7+qmXC6S8nay2Mh9xAvU=;
        b=ZgvkBW3pQA1O3Y/D0GpytNDXQT/vKvn1+qQqmcGc7VH3tWLZLca+Qmrfp18XB7h8/k
         3wtlkvC84mbDtL5OgJVkZ0ROJIjQ85xN6X3sh0s7MuAOf6VqKNRZweYkxEp+7OkOYFgh
         etQ1ury1avnCY36m+5/25S7kSjbxPqQBYj7PVdXqHXGCf4kF6O1Gjr4XQftZwc3xEt1l
         yb/rwDE+OMJxCnwDEz8iX9+jMa7NhPT0FoxqvO5ik85AMclJ5KICy/aLwNnciAuHHNoI
         f/Le2pMO6BHKftCUQ0n48PjkjFatzj9EAL4CcAkfDg1CIvluIFDVmjXFZpNyMnPXloqO
         PZUQ==
X-Gm-Message-State: AOJu0YyrnjKHVAcrZKlvohrA1PRKFLnsrRzwlCyT7j2hc/CZ/hG5BWMr
	gB8JuhNG332WHdz0IAY9dFjr9lWokn0hzTXVrPt1Ym4Pudx83lhjeVD3WA==
X-Gm-Gg: ASbGncsmqTBduqNeaJMEzGPeoDRRwPeV5GcLra9UmwpJEg3ydA1FGr5Q2sfPeZzCr9p
	gjPsaZLGnl2bjDmVICg+EOrkGzMWNYhUwWDoZc/zLAPPZByifDh4v15CaO/LYXbppsj8LYX7vBn
	cT+KbUDd3S0AvS6qSjHewZdUlFi1rdKXGapU1u35Kswztqidj+gZFlEtCzspeZRtotrUFoyJo4l
	lQXO0a4hHQ6OObQ4wH+ap/IZOrP0p77RhSovDgy813HcYV/zxgIEADBMUhGgKarsxZxawbhYhym
	LXBRKXAkMbvcDdi9S4XdX7S5ctrwTIQgs1oC9EdjLy73PXMP65/G/PUz1AVlpgO3zFseoe4PZ0C
	T70Bhy+NoRPP2GIIveilNfwESz+34GpHQHg1ANEhBuV8FgmvXzf2O4kk=
X-Google-Smtp-Source: AGHT+IFxYA+uhr1wAjhORYSRM7+oUVCJDzvHDIO2wIoqkpovYJBxHwIU3f1nl2C1ytDdU1IfRySkBA==
X-Received: by 2002:ad4:5f46:0:b0:6e8:f9a9:397b with SMTP id 6a1803df08f44-6f00df58788mr48643246d6.15.1743776796914;
        Fri, 04 Apr 2025 07:26:36 -0700 (PDT)
Received: from willemb.c.googlers.com.com (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0efc060asm22043466d6.1.2025.04.04.07.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 07:26:36 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH bpf v2 0/2] support SKF_NET_OFF and SKF_LL_OFF on skb frags
Date: Fri,  4 Apr 2025 10:23:38 -0400
Message-ID: <20250404142633.1955847-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Address a longstanding issue that may lead to missed packets
depending on system configuration.

Ensure that reading from packet contents works regardless of skb
geometry, also when using the special SKF_.. negative offsets to
offset from L2 or L3 header.

Patch 2 is the selftest for the fix.

Willem de Bruijn (2):
  bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags
  selftests/net: test sk_filter support for SKF_NET_OFF on frags

 include/linux/filter.h                     |   3 -
 kernel/bpf/core.c                          |  21 --
 net/core/filter.c                          |  80 ++++---
 tools/testing/selftests/net/.gitignore     |   1 +
 tools/testing/selftests/net/Makefile       |   2 +
 tools/testing/selftests/net/skf_net_off.c  | 244 +++++++++++++++++++++
 tools/testing/selftests/net/skf_net_off.sh |  30 +++
 7 files changed, 321 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/net/skf_net_off.c
 create mode 100755 tools/testing/selftests/net/skf_net_off.sh

-- 
2.49.0.504.g3bcea36a83-goog


