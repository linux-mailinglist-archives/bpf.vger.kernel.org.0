Return-Path: <bpf+bounces-19343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0373C82A3BE
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 23:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F7A1F22495
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 22:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19054F887;
	Wed, 10 Jan 2024 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he8V2gTH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B52AE69;
	Wed, 10 Jan 2024 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cedfc32250so2255123a12.0;
        Wed, 10 Jan 2024 14:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704924087; x=1705528887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EWX6HT71Fg8EgVnHIVuLfpRMWa1QMUimycoriITT4Yc=;
        b=he8V2gTHwMG+m/s/HkLSbNqPwRba3hNDYqOjHqX9L7deGnm7IzVsKpYfp0tZQ0z8dP
         IdRIjSPTIWo9UxJ7OVHkk215ZeT1trAEBwkNCs0/UKGI/5txVlZ0OuSUQtW8Wwd63QMq
         0n2+rd6xsftIipkhQaC3Cq/cth4bBM2pBcIPN8iFzXzqzYmoFzn/1WXbNXuniNpt5uXg
         e93q0CcisClCXK4vGirX5SIv71HjRV1x4Bk6vO3UureD7TSyOG9jKtFrYht937g2126b
         ccNatSiMBQnPWQ043TVmdX4kxlSY9KFMj/XdeSVeac0KngHlkPwVwNC3cCjncHXVpz2C
         ZKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704924087; x=1705528887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWX6HT71Fg8EgVnHIVuLfpRMWa1QMUimycoriITT4Yc=;
        b=lE+HoGrYtVDWyga56sNwp+PtCvX+pzRkQ7/Y3EQp/0cKvBdxbNrGZMqzXXVy7/JYov
         ud6juG48ZRmdw1ptvpAywSVRebyJSKAySQhteyHA8gm8Sq0dNm1YtuWiqL0/6ZElxS55
         FbMVgSeibHsKic2viLDR2P7VdGZYAfApMBdjyjdxAMPsCXGUb3+BEqqrgI+2zWdSpzIr
         B1p5PqrUIthQENfd5j1C+z9eBJ46XGN4JY/9q9eKOjUX0uuFRNOB9sxYjUIFMzKBXwnf
         jKkt3oHLM54Qf2ZAr1Th44madrsGwPLQUFyoUabMZPyLRaZzMF+VlIqGVupEejPfiKax
         I9Ug==
X-Gm-Message-State: AOJu0YwobJ+BqMckrfNPM5b/pzygGq2Irzp8XmdUbQuIb7hebRjRFiyn
	jntNO8FI+SLVsAGTIUll1V1LrLNK2lE=
X-Google-Smtp-Source: AGHT+IFUjFBXIofm03RCpesGeBoEdI4Js66XZVmpreOsbx0IkFkwoQilq1fVh9ix8K+qZVHFb4iK0Q==
X-Received: by 2002:a05:6a21:999e:b0:19a:1656:bc5f with SMTP id ve30-20020a056a21999e00b0019a1656bc5fmr127925pzb.2.1704924087290;
        Wed, 10 Jan 2024 14:01:27 -0800 (PST)
Received: from john.. ([98.97.116.12])
        by smtp.gmail.com with ESMTPSA id jk5-20020a170903330500b001d05433d402sm4130130plb.148.2024.01.10.14.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:01:26 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: netdev@vger.kernel.org,
	eadavis@qq.com,
	kuba@kernel.org
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	borisp@nvidia.com
Subject: [PATCH net 0/2] tls fixes for SPLICE with more hint 
Date: Wed, 10 Jan 2024 14:01:22 -0800
Message-Id: <20240110220124.452746-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot found a splat where it tried to splice data over a tls socket
with the more hint and sending greater than the number of frags that
fit in a msg scatterlist. This resulted in an error where we do not
correctly send the data when the msg sg is full. The more flag being
just a hint not a strict contract. This then results in the syzbot
warning on the next send.

Edward generated an initial patch for this which checked for a full
msg on entry to the sendmsg hook.  This fixed the WARNING, but didn't
fully resolve the issue because the full msg_pl scatterlist was never
sent resulting in a stuck socket. In this series instead avoid the
situation by forcing the send on the splice that fills the scatterlist.

Also in original thread I mentioned it didn't seem to be enough to
simply fix the send on full sg problem. That was incorrect and was
really a bug in my test program that was hanging the test program.
I had setup a repair socket and wasn't handling it correctly so my
tester got stuck.

Thanks. Please review. Fix in patch 1 and test in patch 2.


John Fastabend (2):
  net: tls, fix WARNIING in __sk_msg_free
  net: tls, add test to capture error on large splice

 net/tls/tls_sw.c                  |  6 +++++-
 tools/testing/selftests/net/tls.c | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.33.0


