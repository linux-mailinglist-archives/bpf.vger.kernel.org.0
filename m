Return-Path: <bpf+bounces-18105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A30D4815CEF
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 02:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B177B232BD
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 01:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0D5522A;
	Sun, 17 Dec 2023 01:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsHJYWDz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2155224
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 01:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-425c54f5842so18560711cf.2
        for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 17:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702775220; x=1703380020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=316ToXGYNX4Cssc5ZP/wsNMGclB5wESEeekStj0mvkA=;
        b=FsHJYWDz/GkPw3MMkn6+NJkvYtwsgTCJnSUIqjNgvhaDqRVww7xnMATeB5u+afOvYD
         BkzdEqkom1B33kAc43BRIg7D7uEjEb9gHPgqYh5PXG7NAHRQXWcESZFxw8etGUMMW+bG
         RRUm3jAoXpiPGG8DKIi0F4xvwrhBNybtdUE3lfvYw5hvqI8IhikxAZca2BhkljZOKfqx
         awWBJEnumSg58HG/yudEfliinC10xEEkifG10i8+B2Z15VViuU0c/SlfXc2m6w98aSus
         4BBpwsvjW7pQhPtV0RZkXFWVHBlcwh2KWZsFcEzjAdQXF58rO9QGq+sX8KREfsX4mUo2
         s2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702775220; x=1703380020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=316ToXGYNX4Cssc5ZP/wsNMGclB5wESEeekStj0mvkA=;
        b=KRKFwz3wiXO+wlhiwKF/ttvM36s6i7uditocjzFcdtQR09J1Y++POMbzuuXGH0F2kF
         g9WJamgdgayAgiAUMSJyTB5CELjvGCCVcOgpCTM+xuZZeLO2WpFL6vBCSo2LiDOFNvEO
         veFBLVUdP36Ofpsoig3BaoYyXsY/czCpGQ3ZoBCAHGZXiJh8OxCett5r4vOCaoWK2JVN
         tDaid8FLwEmzKMt6BliuYLhjFT8/e6iXo7ksX78glRi2ewnnZi25TrHp5U7CLSVSCEBL
         TKdLP54r6sdeYSsA1VU8VRF/VdRt7qzlrbWH0yzMAg196U1qCPH/mspYnAg6EUD1jxf6
         2UEQ==
X-Gm-Message-State: AOJu0YwcnVaQi60Estaaoj/uxgRIzIw4GiE0vd4GSC8RqrQ4f7VVpSax
	LMXVde1ObN+0OWrTIDPQnoUEC9OWfPV8kg==
X-Google-Smtp-Source: AGHT+IFNhFV/UJlEuMKq4OIhOusDaatOiQjyDPGGyOuVoGJDFHjNnN5f6tCYb+iuL6DWyvfv1JRpbA==
X-Received: by 2002:a05:620a:2ad6:b0:77e:fba3:58e3 with SMTP id bn22-20020a05620a2ad600b0077efba358e3mr14973429qkb.116.1702775220516;
        Sat, 16 Dec 2023 17:07:00 -0800 (PST)
Received: from andrei-framework.taildd130.ts.net ([2600:4041:599b:1100:8905:84c7:4c95:beb4])
        by smtp.gmail.com with ESMTPSA id c16-20020a05620a11b000b0076efaec147csm7180242qkk.45.2023.12.16.17.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 17:07:00 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii.nakryiko@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v2 0/1] bpf: Simplify checking size of helper accesses
Date: Sat, 16 Dec 2023 20:06:48 -0500
Message-Id: <20231217010649.577814-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apologies for the slow turn-around.

v1->v2:
- make the error message include more info about the context of the
  zero-sized access (Andrii)

Andrei Matei (1):
  bpf: Simplify checking size of helper accesses

 kernel/bpf/verifier.c                         | 85 +++++++++++++++++--
 .../bpf/progs/verifier_helper_value_access.c  | 45 +++++++++-
 .../selftests/bpf/progs/verifier_raw_stack.c  |  4 +-
 3 files changed, 120 insertions(+), 14 deletions(-)

-- 
2.40.1


