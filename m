Return-Path: <bpf+bounces-75225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 092FDC77D13
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 09:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B6C6B31935
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 08:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FC733858B;
	Fri, 21 Nov 2025 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EyzrxId6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A139302CD1
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763712844; cv=none; b=F49fa4sIRfYhitKoVVCEA7uDEtNvVy5wNdUpEaCQDJGZ3wAWQkZSctQ5kA9ddKam7TPiVSvVrGUKA/j9h47xCfALX/S3gFMvKoJiDgfRTDWenoKqgXCTRke4T9D+RLAU4OG8/2LJRAvMOTi3MU792cBcLjL0ebXVvSK/+Tw6BUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763712844; c=relaxed/simple;
	bh=RqqYaj/cII106aSecrlvsfFGSQuqUqKxZMEY4rHQo74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z+8yaYobZR5djLMbZ7VwT+4a+dXVua/dwlLJCLegVE4EliD2nfqvBLaa7vm7wch0FJqGkgKHcclZQAs68R8nbrfR7qg6ZDD9m1khGo9XCuWLEGpsIQKXtRaZYW6B2e3Lg3O8rBpQ+HtSpTiFvnur1pLPI4aSFdNz1waHpcAtPrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EyzrxId6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so16315765e9.1
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 00:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763712841; x=1764317641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu5P69WeH5TqqdvETNRSaYlqcEnkauKwjQ1PQ+ysJsc=;
        b=EyzrxId6WhrCTLwQFiuHP1SpKJ4m2QQV55iTbQrWs+iMllpgvmPdI9syf80h7AQo3Y
         etwLBK5qmS2F4256iiutDAcqRY+GYwpMW02apXC5v8L40ol03Oz/0JN0sO5eufbqkNl0
         Sf9rurYU4OkL/F2mPWF/wcS7UzNWrRMTYjPXMyaTdNgTUjErYrboFkuRAyGC8zMOvECq
         77nmgnCfA3rcSfRKJVSDSlNM6fY2sJEVvMbzwrXi+TqbmmjEWhy6a4f6Y1XJe+WKmJ/I
         Sfv5Od2NSW26hsCYchRG2wRtPHRP83c8poviWD2vc+zpaJNtaQHmjSCthCZcoWxNXKgg
         CMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763712841; x=1764317641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pu5P69WeH5TqqdvETNRSaYlqcEnkauKwjQ1PQ+ysJsc=;
        b=GnaHoUcjI4Nm02YSF4dHPPUx70r9BS9nDRtbny/2Ix8B9FYcJRRkMQQhdGmLVYPgaN
         eqieqrdcT/S5u/dPaogXkHP6zhRXKk/quftuZChlHTVmoVPidaGE+9b8EI9AzcEWV/BP
         cGZCofA0HDb1viMfDwzjDwEsd5c+kHUnDChKnJRP2CKum0c095O7L37naR0aObA1WsFu
         sT3sHvAEA0v7hZOkcyc4ldWjqmAaIaHPUKLyte1AUFXY3u6p5BF3iwxiksoyl9PsYGi9
         WUVqhYYGS65qMhBRQ468JQ4nPRovrASvnFQIImIQRd51TePcrvFvewjETOdo2MTrXA3/
         G4vw==
X-Gm-Message-State: AOJu0YzmRzJ88t6/aDVW7RXrYwValzlk1bSril/I/6UCOp52ZXWjDpF+
	ukMSvhxiSp1T8+z/+9wUMBhdFn+B6MvHJYbU+F69USBfalcf+Bzc2BcacYjf80ziOiH02iSZwGq
	fWWOO
X-Gm-Gg: ASbGncubPVTtLjZ4oqfs2i0KTtnUL+TYQG1eHfIIg5wegZwdpdIfgatD7HRiwd1iRuX
	udw0atPwELFnSxvnLrbceruyfHbrBMp0m0mmLGGi1VSStWiLQs7ie/jeA42h3R04+RAQ58ZkJmw
	sfI7kiS+B4XuEzXylSdKXGJdUXuab1VINSMKfNQ105SisoLxVwF5pcuBnsJxwb8WqRDEftOq8rk
	krQhMOkFmJbESGZujuT/XKpSlgwjEN+BwpYHRIWSfg9p/5yrUkmdk/K+dtve8MPGWBcIPDlQxla
	5lUZDdIFtjOnB2rc/eyUUQJwuwAyHMiHfO8Zkh6kNPQ8sfqoeyzBuDJFFWuGrUphsfIIk0LcikS
	47tv8io/wX05JSyf9nmz755oKk0kfW1hVPbFVBOqnRmu0n6JHkwKg7yZd3UNXdzTLtjQflJZqER
	fXfoFlGBbIzp7IrJo51r0Xy8jZZDS8P5ORVpGgBeqxTOo5+BvB+A==
X-Google-Smtp-Source: AGHT+IExo6P9yEJxV6Vu6XQYQ244uwk4Ca8NVmBGcVEgufQTNwqM6oCVjIDV6Wd4M5GDUo839dB7+Q==
X-Received: by 2002:a05:600c:1381:b0:477:7a95:b971 with SMTP id 5b1f17b1804b1-477c01f55damr13632975e9.31.1763712840705;
        Fri, 21 Nov 2025 00:14:00 -0800 (PST)
Received: from F15.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75def6314sm4722370a12.7.2025.11.21.00.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:14:00 -0800 (PST)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	hoyeon.lee@suse.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: networking test cleanups
Date: Fri, 21 Nov 2025 17:13:30 +0900
Message-ID: <20251121081332.2309838-1-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series finishes the sockaddr_storage migration in the networking
selftests by removing the remaining open-coded IPv4/IPv6 wrappers
(addr_port/tuple in cls_redirect, sa46 in select_reuseport). The tests
now use sockaddr_storage directly. No other custom socket-address
wrappers remain after this series, so the churn stops here and behavior
is unchanged.

---
Changes in v2:
- Drop the tuple wrapper entirely in cls_redirect and rely on ss_family
- Limit the series to patches 1/2 (3/4 applied; 5 sent separately)

Hoyeon Lee (2):
  selftests/bpf: use sockaddr_storage directly in cls_redirect test
  selftests/bpf: use sockaddr_storage instead of sa46 in
    select_reuseport test

 .../selftests/bpf/prog_tests/cls_redirect.c   | 122 ++++++------------
 .../bpf/prog_tests/select_reuseport.c         |  67 +++++-----
 2 files changed, 77 insertions(+), 112 deletions(-)

-- 
2.51.1


