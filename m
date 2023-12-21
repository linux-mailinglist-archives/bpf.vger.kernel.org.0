Return-Path: <bpf+bounces-18565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DBE81C1DF
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 00:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFD5287B1A
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 23:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94BD7AE60;
	Thu, 21 Dec 2023 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfmQdQ/V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1847A229
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7811c58ee93so67604285a.0
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 15:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703200961; x=1703805761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=grGayM0flOjBzWfwP1j8KHMA36G0yGw2YCm7lrNFMs0=;
        b=RfmQdQ/V8O1fw0zrbYj81GZUVx0gvuc7K2OEaYwNHzN58gun3Etel7Reyrwt2Gi3Ga
         QLUbrnTvHRGWqlwmQeT5f0+13LkiP9y3tdM7oSn3My/4cjKfJSSA1vuOM3i1Qx+X2nvR
         u+mtjOcTTYCj+zT+QrcZLoqVItrCuEdO+dYDhMOw3kOpN8JedFMCnCAtQ568iZ1kYPFN
         m1QzbWbSJntPRQzSiME0hB9yUBvQ1TBZodUKojkt9TUwsj5uaPlQLFFBhddZpioX5vPs
         VBCluhmgbNnYXymC5d+XgyFdcRlonwB15RbUI7ronp2pSEKJOO8AXPkuq9ey9QXhhI/l
         jm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703200961; x=1703805761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grGayM0flOjBzWfwP1j8KHMA36G0yGw2YCm7lrNFMs0=;
        b=umsZIfBFvzmkSGr2JvnPcUCyJ3+T1NyXQ0qEl1kHUxtWMeMIcwb6kveAqblygxaZ5j
         7RkSXLycHnURwRZgi3TP3Y19PRe9i1gK3Un814KiySlxFl8gUFkDpV8dRlhzX3RnRZcs
         YFIJL52czLFHbVrHM1GbZjDe1HhhL+WBQjCTmL4YjIdZfEk/iizjtZbuD9t9nbogC+zN
         FUBr0s+3FB6L7zAVUIdh4LG8tYlNcOglL++OQF/4sGYQQQx2KhgHE7l9fk7BZyjExB9+
         iiZ06C17agNu0tJAPnlgOpTLRS6BZu3ps8uncQOxp7cDCFi34e9Wbi5rhNZk0epsttCz
         v8TA==
X-Gm-Message-State: AOJu0YxQhxf03Z+5a4VikB/ye4FQiefUQaqMnF8QvNI97GNlCcIeO8Jh
	LpAdUbDJOg9+DRaUh4UMmcuSNu6Cikw=
X-Google-Smtp-Source: AGHT+IGXHtZMPZUIoLWiLsrNFrw0EpIizoQZkkQ19iZefHc0tWHsiNQQfOBbY4+xXZrrkqlRBXygDg==
X-Received: by 2002:a05:620a:a4c:b0:781:2bd7:58b with SMTP id j12-20020a05620a0a4c00b007812bd7058bmr179105qka.38.1703200960898;
        Thu, 21 Dec 2023 15:22:40 -0800 (PST)
Received: from andrei-framework.taildd130.ts.net (098-030-123-082.res.spectrum.com. [98.30.123.82])
        by smtp.gmail.com with ESMTPSA id l12-20020a05620a0c0c00b00781121dcc24sm981281qki.119.2023.12.21.15.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 15:22:40 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v4 0/2] bpf: Simplify checking size of helper accesses
Date: Thu, 21 Dec 2023 18:22:23 -0500
Message-Id: <20231221232225.568730-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3->v4:
- kept only the minimal change, undoing debatable changes (Andrii)
- dropped the second patch from before, with changes to the error
  message (Andrii)
- extracted the new test into a separate patch (Andrii)
- added Acked by Andrii

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
  bpf: add a possibly-zero-sized read test

 kernel/bpf/verifier.c                         | 10 ++---
 .../bpf/progs/verifier_helper_value_access.c  | 45 +++++++++++++++++--
 .../selftests/bpf/progs/verifier_raw_stack.c  |  2 +-
 3 files changed, 46 insertions(+), 11 deletions(-)

-- 
2.40.1


