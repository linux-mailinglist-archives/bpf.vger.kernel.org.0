Return-Path: <bpf+bounces-18568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D854381C1E3
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 00:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785B31F26293
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 23:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E176D79499;
	Thu, 21 Dec 2023 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4sjFA9I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3748C79463;
	Thu, 21 Dec 2023 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so9628655ad.1;
        Thu, 21 Dec 2023 15:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703201009; x=1703805809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=44efa604H7dap1Uoz4pi8g2Yhc0/Ub6AzcNX/ixcVz8=;
        b=Z4sjFA9I0AN8dbeQHtQ5emqZi4CGYyBMYt+OPQnnTV4eRfL+R1ezF+qnCwTi5+YrOy
         /F7S/wnW7R3L11hbYjs64rfhGhxUommIAkmspqyjL/8hLKL5NN8jq7hm/lPjnUSZTsdV
         lzk4RZsZEpeWYD4lxPLo+AybyGXeKPETToDUmBVMn2WDoljiXc8qZV5icPvHMsXtGCZh
         0aEpFZieMboteIAPVTCBUhEVrdLNDWN5QIZH2b10ethWu+UMq2/AdLpcnyZH9fc7M23T
         3zOZMqpO3z3zssrbbiCGPT7isw+pthorReaaSEHrUZWOzUMyqT+Mv7+V/IEuU/0tkrWY
         si0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703201009; x=1703805809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44efa604H7dap1Uoz4pi8g2Yhc0/Ub6AzcNX/ixcVz8=;
        b=g/vBn5qaKPm6spY3xGJ5jypu64cdDXDLOSL8UpfFrbP1JprgpM8FltuMF3vGJmp5uK
         CFGD8A++Y8NcHuKjQ9NJQtZD22A2bcA6GnGYOMOZ/ZiQafG5hyqz0nqt1JTM0UAYJB3u
         p92guDICMtbNyzvXxS20zBcSMSFB392h+DtBEgD5NRvTelCj5Ip7e4cvmPlwD812VmGz
         qjJCpqfV47zTndi22ml7FDtfVhq8kXy3sLARUX7ysA7dpIna+qdhVIlCeGsd31TauRQC
         Q97RchsRfNnxIS0lRQCtHhPk0E5dfuGq3pDB2XYngEP4cuAjhcFcmGC3x7h0Xhfo9II+
         e3Qg==
X-Gm-Message-State: AOJu0Yx6Zvoior5Wsr2OSSHhmkt9A7R+t5LVNkoVMt56+e/igYrxBorH
	OgLi7FgtgioS7ljA3LQydxU=
X-Google-Smtp-Source: AGHT+IGGYY3FOustE/KZZ9HpLjvya6H59DLAclwpPQTUzTjk6ZGYzcGX+k6ZOp2OTIaoQet3pb0QwQ==
X-Received: by 2002:a17:903:41c8:b0:1d3:efbe:6033 with SMTP id u8-20020a17090341c800b001d3efbe6033mr357171ple.81.1703201009474;
        Thu, 21 Dec 2023 15:23:29 -0800 (PST)
Received: from john.rmac-pubwifi.localzone (fw.royalmoore.com. [72.21.11.210])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001d3e33a73d5sm2139641plq.279.2023.12.21.15.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 15:23:28 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: jakub@cloudflare.com,
	rivendell7@gmail.com,
	kuniyu@amazon.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf 0/5] fix sockmap + stream  af_unix memleak
Date: Thu, 21 Dec 2023 15:23:22 -0800
Message-Id: <20231221232327.43678-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a memleak when streaming af_unix sockets were inserted into
multiple sockmap slots and/or maps. This is because each insert would
call a proto update operatino and these must be allowed to be called
multiple times. The streaming af_unix implementation recently added
a refcnt to handle a use after free issue, however it introduced a
memleak when inserted into multiple maps.

This series fixes the memleak, adds a note in the code so we remember
that proto updates need to support this. And then we add three tests
for each of the slightly different iterations of adding sockets into
multiple maps. I kept them as 3 independent test cases here. I have
some slight preference for this they could however be a single test,
but then you don't get to run them independently which was sort of
useful while debugging.

John Fastabend (5):
  bpf: sockmap, fix proto update hook to avoid dup calls
  bpf: sockmap, added comments describing update proto rules
  bpf: sockmap, add tests for proto updates many to single map
  bpf: sockmap, add tests for proto updates single socket to many map
  bpf: sockmap, add tests for proto updates replace socket

 include/linux/skmsg.h                         |   5 +
 net/unix/unix_bpf.c                           |  21 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 199 +++++++++++++++++-
 3 files changed, 221 insertions(+), 4 deletions(-)

-- 
2.33.0


