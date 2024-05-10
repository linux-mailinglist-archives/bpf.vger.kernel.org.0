Return-Path: <bpf+bounces-29388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E915C8C1B3F
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2693F1C2040E
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C0213C3EA;
	Fri, 10 May 2024 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDr/juiT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3A13BAD7
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299886; cv=none; b=d1QJpdAV79MlI0Cpuc1coPJ9suVRqnSa1V8LJi1R5h69RCkVMfcrN8R9lpDLSKkPN+L3vMBswUJqz3mTTeQHHKWJynUfSjjGvZ8WTMVP6VeNcbV7NcYr9pYVdvL3ipwHqnucf4d5biwDMZci9BHrF3kONXJsDyQVsESTecPQtgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299886; c=relaxed/simple;
	bh=2Hd7RVO2oQyAycS+cMBSvHkXH+GbjR8gypYKXDXO3so=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IgFx04UjHIInCq4z6Wn9HtYH4IEOC8MVi7Vlw+A1bC8P+P294hE4tz13G74gwHIG1/gA5cUWnyyOLD8wVyqoai9KKvZyBGiWP3ByZXbvj1DqYbi+GXz+RovZloEKncN6AeHZhw9krBlKGtWDjEsbkCv9/cHyKNFD2n1hObpfBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nDr/juiT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b2a06c0caeso1434894a91.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299884; x=1715904684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hhc5ZT51Bf+X0xh3itiryFkYQiK1VIkMBG+josVXNL0=;
        b=nDr/juiT9/zNodX5yvr5pUwsI3rUbPg8efciwqnMYworN8aFFupTmfNPrC9w/nXRrB
         SFIjAC9YRGovqgXyC1118ywtXhI7rFvSnD57uYVSZ6NLRyXEFnSMaze0+D8X7ktQ4Fzs
         DqhB6JXvOh6nBPnac7EqAKoRyszx/wiNEdGlHzOLBK89cHp/2P0Ud7NQY9lIsXG2l+yV
         JS+ve2b0rAd5qgdhHmJGkCUjBPfa1wViiYKcHoAx2YryidsBDbLXZa2DvEkOUMOw2qLk
         FniSHwOVIe79bQD7f93Q15yY0p7PNQ6dYKLXXvtnre4VGz+ny6qZzHR87Y0h8HeJDgNe
         Qc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299884; x=1715904684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hhc5ZT51Bf+X0xh3itiryFkYQiK1VIkMBG+josVXNL0=;
        b=af63uN/ZcGwdZSRX+Lu20FGtKal0J1j88uI5YER9P/NskFejQCc0z0jYxcjvF/6+tt
         yXya6qlQLzJGjbzcbhzQKo97Mn9ZDOEItpVqIsKwn6b58/sGZdjX62hJ6MkEmUGh+njk
         6tUrNUBvSwRfysfeC0LVLL+C6RWrqby/wLNbNna3GiCRTHyTPs208mCgmfa5VKcljXQz
         4vzLGrL45u8xSGkOM8os7Ypub6s8Qb9ASBsGIQSx3GJP6w2gugBTBd2bcK6ZJc01WnUF
         BmmpMBANnuu6W+z/C+9Ih2Q9/6e8/cmP24xSD6on4ljpR/EpM9TOnVnquf+XS2+WfwO3
         vzGg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4WSpw/+mLisEBlqJtMqlx16+IeG4TTK6JrjEcM7DnEx7J6WGawY1NF52j8+fpj6eY+hGQHJC/dLyCbHGmBoLD7u9
X-Gm-Message-State: AOJu0YzAX9Zi1yZPk6J+CMNCW15Mih5+JpwR4fDLt+Bp7pNR8hW9P6uT
	oOnoWNQfgmAa7y1NeB0+iBkmHttAVN4AEuiqd0kRImK71RfwhOHSawZI8ptzDVqZyHOIBUgHnXP
	89Q==
X-Google-Smtp-Source: AGHT+IEeA3HoMtx0riBcurUZp19Bisk3YOU2mcitL9911KMtdK5oYFtWJ3cEeUHag98MrRliuC7lKihL3M8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:c7d1:b0:2b6:c70e:d3b6 with SMTP id
 98e67ed59e1d1-2b6cc44fa2fmr2940a91.2.1715299883775; Thu, 09 May 2024 17:11:23
 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:04 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-48-edliaw@google.com>
Subject: [PATCH v4 47/66] selftests/ptp: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/ptp/testptp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 011252fe238c..ea3c48b97468 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -4,7 +4,6 @@
  *
  * Copyright (C) 2010 OMICRON electronics GmbH
  */
-#define _GNU_SOURCE
 #define __SANE_USERSPACE_TYPES__        /* For PPC64, to get LL64 types */
 #include <errno.h>
 #include <fcntl.h>
-- 
2.45.0.118.g7fe29c98d7-goog


