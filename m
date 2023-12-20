Return-Path: <bpf+bounces-18401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A53881A5F5
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 18:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC47D283FA0
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 17:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F9D4777F;
	Wed, 20 Dec 2023 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYLSFEEO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7023D47771
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4257ba1bc5fso51771511cf.0
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 09:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703092001; x=1703696801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=27dETV1l43C3Vfu9tV/UlCvvr7wnqIUj5OSm2dMT79Y=;
        b=MYLSFEEOp3rZ1A4nLAqGTw+IFgMnGitLeG9oUF1r9b9fOOlmbjljUbBjyFtQz1snzA
         HzB24k4g3iEZu3fFtCrQnA+/4quIBEkUtS45Q10t41ZywWvB7iZA6F2FrlmBljf48oSJ
         U8tO7BTyFKpONnA+MBR7iBokzMGVY23fKSp+nsv7ces2ACf9JCpcMfKJP2XFGzgRLYKo
         d7C2PVNHnDhfjATqLdK6Wv1/WKmxvhXxK3IHtbjylIiSKCrY4cCvybRTvJpP5MVjHNBV
         DBAb3jxw59FF1/mBBceTEMbzdxS4sRgsq/Vv3AQY6SsDP/dUIulERtZ6tWpi1iYBxlKg
         PuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703092001; x=1703696801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27dETV1l43C3Vfu9tV/UlCvvr7wnqIUj5OSm2dMT79Y=;
        b=ZBite/jUZ2WI9ANwuWkBL9BfmWSA0lIqLu9jR27aPnoQD6F+9pAwnx4kdtRCVyw39b
         fIeRh2qXKuk/ml75bk/vMp8gpVqFOVesvgW3w+62wbjzT5UoqgYItLnHakMZ10hCYPz/
         pzgheZrv7wDRUMJflnmfQD9DRzTk1Q8f3lRrwsFGR6rPLB8Z89uM+iwfNE3znqaqbXfk
         TCsfMPPrTFvSbZK5Gfdy2j5V5+MJhxHUt3Wxt0x15RcWEPcYAPs8Zn+BxzKnApMKgQAb
         odnqhpR5CO5QYb0PSwdIypqtcmexgAkGwgPwCMFnq7Au4u7J+GCBGft7k9/8nwH3uNY2
         z7Qg==
X-Gm-Message-State: AOJu0Yx5TIliatv59KqYl/TddeG9goXML0DMAike8bDQx5o0J9FxFI7V
	KAMULuFCziPgCssfc4laSu66+c6T1aE=
X-Google-Smtp-Source: AGHT+IHIjovzIw8AwsZSxAB4fKHi6V9f2u9unn79/SlpMGtJNL6orX+P22xS8Cp2SSssFnJsbc3M+g==
X-Received: by 2002:a05:6214:202f:b0:67f:2a02:7f34 with SMTP id 15-20020a056214202f00b0067f2a027f34mr10487318qvf.112.1703092001376;
        Wed, 20 Dec 2023 09:06:41 -0800 (PST)
Received: from andrei-framework.taildd130.ts.net (098-030-123-082.res.spectrum.com. [98.30.123.82])
        by smtp.gmail.com with ESMTPSA id lg6-20020a056214548600b0067f08081c08sm37492qvb.12.2023.12.20.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 09:06:40 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v3 0/2] bpf: Simplify checking size of helper accesses
Date: Wed, 20 Dec 2023 12:06:01 -0500
Message-Id: <20231220170604.183380-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2->v3:
- split the error-logging function to a separate patch (Andrii)
- make the error buffers smaller (Andrii)
- include size of memory region for PTR_TO_MEM (Andrii)
- nits from Andrii and Eduard

v1->v2:
- make the error message include more info about the context of the
  zero-sized access (Andrii)

Andrei Matei (2):
  bpf: Simplify checking size of helper accesses
  bpf: Improve error logging for zero-sized accesses

 kernel/bpf/verifier.c                         | 89 +++++++++++++++++--
 .../bpf/progs/verifier_helper_value_access.c  | 45 +++++++++-
 .../selftests/bpf/progs/verifier_raw_stack.c  |  4 +-
 3 files changed, 123 insertions(+), 15 deletions(-)

-- 
2.40.1


