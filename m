Return-Path: <bpf+bounces-39079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6AB96E5CA
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 00:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D1AB23364
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 22:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5E31AAE16;
	Thu,  5 Sep 2024 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLjhHwZI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBC715532A
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575900; cv=none; b=Bj93OFTOmUvJ+Qj5V50SqnUen9q9uzLdh/PmPrluo5pQL4SAPktktOgl+B53cU0xrIt9DW65PcGDYVqmBKbGzlC2uoBTvVb65Vv0e3SzeBF6GjfXdRybKdd6nSF8zeuUJ0ikuSaNpY1yR+PXNrkKby9Mvq5upAMqdeINOPN/D50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575900; c=relaxed/simple;
	bh=R8U6oYUudxfwqAglE38UDDUBAj6lA/FWvnVEQK37M54=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ID1c6VB7EZHf9/awog99uoIw+XzNZpo1+nzUftSwgZe1NWUCtgAym/emEAhMXIkbK42DELM3V0ekeT3y5/mjqOquM3QeFanNRYYDylvfjfoBLoiy7J18wg3uSyMOLRjs7jxcQ8Rw1J7VGClUqBN3coFzb8o2mNaYZwgvgZA5cdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLjhHwZI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2059112f0a7so13710815ad.3
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2024 15:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725575899; x=1726180699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=guipb99u+E6gozOCiJWSrZq6zZ9eTuGBg4QvA3ywags=;
        b=jLjhHwZItE7pC0m1Cx4ZUhQ0WLq8MVaLn3wlvkkPGw3hPNjep1p9+dcAs0p3FiR0pA
         REcLyBM/A+5PDn983HB9/4UTiXyAGdrIu/cOgvIyHrd4ACe8X6GN1fEKlycMXJbugJQV
         8hnijGytL11vBsGnbZceGoa3jCuycj6CiYqiyANc6ypkSU296VL/D0rXl9WnQ+y7CS/W
         07TbAufG/gL3Vp1Lfq2+tFZ/3bjmElmOYOFSCmGzh1xlbbX1Dw4EcORS6kLJzEAqR89L
         c2NintdiaNsCmZ8WYuSkz2ROcoiscCdgKm7uuAVuh7PwM2PBbO/qgnWsgfIMjhyOQats
         xlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725575899; x=1726180699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guipb99u+E6gozOCiJWSrZq6zZ9eTuGBg4QvA3ywags=;
        b=LsSK9pdLKtDf8Emmy8nkKQZZkcfnlKVlAnAuiDXK+BmKzBXtuQT4d16AO+fSWhC3TJ
         Br7rcnc3whs3j1cOTau82SxwUx14ZWB//3FAhzNqjiyb/c9686ZDpKlxTwOAi8wdeYto
         +uaEXykZNJud3ANVWrsIL6wwa0Hh5jXiTCkontwdxTLn/PvoqI1BbNRCSkLxzIzvdmhT
         bKLN+uSiuYUCDyofoFxri7kmk5VyfYZWns2wUPNEfwH81c4ZbOIaFaG159Xi4FvorYO/
         SIb8U9xTbZBbahn9wFSXwaj471n+hlFb88CrBrHZpHhFlN+6Gt98aYEi/LZzXVCxtty9
         iEiw==
X-Forwarded-Encrypted: i=1; AJvYcCWm68WSoRAw7aAFYh0lTTx+otCm4VSzFacJItWunTMkQSLu5208xk3y9FsgxmsKTXC0JJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzztRbMSrn0AaXEGbXKethK2jHKLN+nYuQys2KNV362QeGbYTyy
	wJsVM8RCmmb1xR0fDOCfCOGsyQc0oKP6uw4F0kkFDmiGOS38zheCUKn0DQ==
X-Google-Smtp-Source: AGHT+IExwiER2Kqq1N3q8PeO3uUKqbLsEQzzh5qqold6J8HFZX2SvII7+N+qSTY5FhApAa/ImFXBHg==
X-Received: by 2002:a17:902:fc8e:b0:205:8275:768 with SMTP id d9443c01a7336-2058275084emr156645445ad.21.1725575898761;
        Thu, 05 Sep 2024 15:38:18 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae9505acsm33067225ad.66.2024.09.05.15.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 15:38:18 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 0/2] allow kfuncs in tracepoint and perf event
Date: Thu,  5 Sep 2024 15:38:10 -0700
Message-ID: <20240905223812.141857-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible to call a cpumask kfunc within a raw tp_btf program but not
possible within tracepoint or perf event programs. Currently, the verifier
receives -EACCESS from fetch_kfunc_meta() as a result of not finding any
kfunc hook associated with these program types.

This patch series associates tracepoint and perf event program types with
the tracing hook and includes test coverage.

Pre-submission CI run: https://github.com/kernel-patches/bpf/pull/7674

v3:
	- map tracepoint and perf event progs to tracing kfunc hook
	- expand existing verifier tests for kfuncs
	- remove explicit registrations from v2
	- no longer including kprobes
v2:
	- create new kfunc hooks for tracepoint and perf event
	- map tracepoint, and perf event prog types to kfunc hooks
	- register cpumask kfuncs with prog types in focus
	- expand existing verifier tests for cpumask kfuncs
v1:
	- map tracepoint type progs to tracing kfunc hook
	- new selftests for calling cpumask kfuncs in tracepoint prog
---
JP Kobryn (2):
  bpf: allow kfuncs within tracepoint and perf event programs
  bpf/selftests: coverage for new program types using cpumask kfuncs

 kernel/bpf/btf.c                                 |  2 ++
 .../bpf/progs/verifier_kfunc_prog_types.c        | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

-- 
2.46.0


