Return-Path: <bpf+bounces-62289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9956AF7720
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 16:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BAF1CA0AF6
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AEC2E7BB8;
	Thu,  3 Jul 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUjrmYwL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ADF1AF0B4;
	Thu,  3 Jul 2025 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552241; cv=none; b=Ouigj2Hu5IR3K+4LFiH88w766/pEDVNNELUSDeaChMiANPu5hX9KtEwUzjINpYWueGOXGVVfWfdQiOib/Vwcr8DgSEbMLsA32UQvoyVqnQUBgkx2AkGzRZBJrcbTCjkIYWv3K5rjn+w75U4qq3wY+CKInR0in1tek+ztxEdTPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552241; c=relaxed/simple;
	bh=reBhGGUgnrJ139gpendbTey/6SeXB3WwExAdYkRGRZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JD9bi8lEh08hcTuewzLgQt7Z2I7MEr9R+QWOISJN4QBPhrl4syBhjX19K5XYan+ulCa0tDoKIa/0VDiBe2A+F0HkZ3H1p6FMIYETrgQY0kqudMJgpDm8B2PX4r0tLNTOChWyRW5QLSNHYHiXDdH1EFNur7z4dObBBQutaZ7v7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUjrmYwL; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b31befde0a0so4028653a12.0;
        Thu, 03 Jul 2025 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751552240; x=1752157040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yl+pCOUgN8IvUzWEVj5uD0HOSNZhBVyVLHBB+osf1V4=;
        b=XUjrmYwLWTPxrzGpIizGR6cq84Yy2kwtvhKvJ5Xg/QlcYqeJ8dTThqFwUWKiaxcRQR
         wr400tpL5Da+CCFDVhJQRjasJp2xgIOoNOdDszQNdIo5tuRVWuiyAdSGJ4NNIjhGE3FX
         Wi3Wd+CGMQkol+WEG4c72HWWfrVjXirTqe6YF5syIjl7QvlDU1OdHkmuRTCyaRo2vtiT
         YV0Z0EZl9UqzJ8Gbbf74kvXLtRbLH6Cs2tyv4+aNvHJaSOvJjvDZ1o8VT08Ja6DKUH//
         zvuBuLVe/81uHYPXIlRxkfI1gl2bOk23H9Zdw8PdaID6qNaIlVwxknR810COCp7SzVlu
         plKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751552240; x=1752157040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yl+pCOUgN8IvUzWEVj5uD0HOSNZhBVyVLHBB+osf1V4=;
        b=rV7V6xCR0lDIICykiO+TKAGnEpwaYMNxtJtrMrFaZnRTElYAduxVXVUt9Y2DMl0bgz
         zjY5qWT9TrIO6lR0d27VdaL0fzCYsXt7RzRLuddYncuYHDs1mHEG4i4kR/dFoxdSUx83
         Qp4OUW24L6PhnZlmfBEuWReOb1dvelVDi+bmkZ9w0Ph3VsYVwrYoYsLQ+rHormxwQckB
         ZXvEST1otfX8slLwrADIrwIPungCp9jUxEpyLEBFee1tsQQhEYRNBfQ6+jcyzIP4Plv9
         5oWJFKWt8zJ8EVBwv6kjC3+Yc+xS75G4UKyceSgtIFgGRJUlmQ0mQuLdpMh5dKafOiNg
         ikpg==
X-Forwarded-Encrypted: i=1; AJvYcCVqRAzN76XslfIcBHLIfgQRF69s+kAl67QrNQCuaNnXorFfzhfNDw6qOESg+5ae2yzKedh/uGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUHgCzs7gvXEQf78FMu4JO3mdrBoTAEzQuZGaA0jLAjnAPVvoW
	yqcwm2Lm5+QWIACvHmSd9HxsuZjA1vozS4Qab3WR25EU1+avuIyVRw4I
X-Gm-Gg: ASbGncuKOn73jcREQSCtd3rwXDRcP5XXcK2ZueFGGQE8iSvolhkYQNhZnkddkjc6dOP
	9IP735bpsAE2oLqEis+Hbt7vq0ZsjCD6KNjpFYtA4QE9JO9z9lpYO3sGK5NiyLJuXxsyLRvTTXJ
	c8QOkjxpUQ4WSpyt3LkslWIdsyg4uabY+29AmBk3JdFcwXlcWiCdx4zT7dtml1VPOb2Dvqnp0y7
	OoYuo4xax8xzKlDhnzruEFOybSTPN6SxYM5bbSaxeF6SxmPH2d+QmGlWUbd/t+5w2DT6bQ0Krme
	XZCoNGiz1d+e2wms3r+NVfpMISncHmFoBnaNxr6ilz8tO627Q4F/NIlUZtrC0v+o6CVsk8nkRJJ
	SKg9cBSeRANIw506DZWmufQ==
X-Google-Smtp-Source: AGHT+IErrxkRFJTq7kH9uZXcG89aUQoUNBB16RTH+HXvcSml9cXuMyhQn6QZH4smqKQ8rsY2cTnndw==
X-Received: by 2002:a05:6a21:6e8a:b0:1f5:95a7:8159 with SMTP id adf61e73a8af0-222d7de0c2amr12113792637.10.1751552239552;
        Thu, 03 Jul 2025 07:17:19 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.26.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31da818sm13800150a12.61.2025.07.03.07.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 07:17:19 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v6 0/2] net: xsk: update tx queue consumer
Date: Thu,  3 Jul 2025 22:17:10 +0800
Message-Id: <20250703141712.33190-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Patch 1 makes sure the consumer is updated at the end of generic xmit.
Patch 2 adds corresponding test.

Jason Xing (2):
  net: xsk: update tx queue consumer immediately after transmission
  selftests/bpf: add a new test to check the consumer update case

 net/xdp/xsk.c                            | 17 ++++---
 tools/testing/selftests/bpf/xskxceiver.c | 56 +++++++++++++++++++++++-
 tools/testing/selftests/bpf/xskxceiver.h |  1 +
 3 files changed, 66 insertions(+), 8 deletions(-)

-- 
2.41.3


