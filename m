Return-Path: <bpf+bounces-35190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B6F9384FA
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 16:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E53281083
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7C516132E;
	Sun, 21 Jul 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqBq3xx4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D981E891;
	Sun, 21 Jul 2024 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721572444; cv=none; b=XxcXDdQ1tGfdSJSnDoF5FS3eM7fTaPSysRkfmsmSVRqRlvTeEPJXxR+igp2AqK7FCiBfk3/1vHa1FXwg7bQ7Gp6vTU9ulq+3LsUe6XbeJqe2Ny7+Vo1K89tNlZO9RjkOAP2GILCBPH67cNZPPu4pzrqjHCpEUj8qD1cXRqeyC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721572444; c=relaxed/simple;
	bh=V9mMrl1SQeYRcTjixA023H3kxUFVVljyRH4JHK3+ZRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QdmujKrNO7UPjirE1HOGhv1KHufxpXNi10DGJBz4vvEFLmRf7gpB+7QJal6nzwUBxQZRxpXy3ynqwspdKd09YYR2dHcBwIzuMULlL01wViC93oMyFXt5uQ6Fgg7jg5AkjWSDomvfxx5Mnp8/l5GnokQfEnvbo9a8qd53UA5Ha4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqBq3xx4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc47abc040so20512835ad.0;
        Sun, 21 Jul 2024 07:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721572442; x=1722177242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8VuaukSOJBcsyGjQ/h9NyKtdCUmfjz+Mj+aHbatfePU=;
        b=GqBq3xx4VfeS8sItU2DYmX4S5Y5hbj8kBGbS0kerfV3fbJTE53F10l979dLXlIFvlW
         nv2CA72pbLpKTwC17xN25sTiv+63LjIJ2If+XHyy3sqiVojcaOcHutwyWmxd5Fg/1aKA
         U5W7QI4lsu0cYM2HAkGZnsmfGSVhWNKyljWAwL5IQEnwaUmjw+Yb/gZA1YIPbRrFcyxH
         e/GdtzenANRrI/SVGMW74wvp9Ew/bm5s6B7f++4JphkV0MBKfnD7ILxUxhmVn7uJ5k1k
         grmmnqEANGAwaed3nZm/pOEKzFmu7YT26UbIgaHZgENTJR0/zKDiSYPda6s5+/LiY2DW
         C8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721572442; x=1722177242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VuaukSOJBcsyGjQ/h9NyKtdCUmfjz+Mj+aHbatfePU=;
        b=n6s3luApnzXNnWEwFQVDVHMbSGnokiAWyPjcMn2tHR3XQjEqIq+BolgTrbT6PFQGKt
         /7HvwyGQ9lAyKKIPst0jFLdwWkb/DA3O4UHrwq6SWt/fREVBHmTuOmZhz5zvrzGARikB
         bCmzithFCeFSKW3g6dJvNv4pQyeVR5PqiYShLdLGdF7gHERxclYBu6sPHyBHCt7vzSI9
         VTOguaeBwiZsFNo7f8pPPONxMTjo0K/DE1MpeVSZ21dEbv44rzNMv7pwAA453vZnWPe4
         CvL97dZXbcrVDMVyRwHOajk+OYvQY6Ssppo+1epDDOHi/nRkXNfIfN2vnzJV2kSdFIcb
         fdww==
X-Forwarded-Encrypted: i=1; AJvYcCWwNs+kUfwa0UoGhm7P3ZYCBpZgrr71c2aIcBsnAKm7sG981t/oo8I/9zWdXepGCpdr4iUITU7J0SO0gyBKyS9XHEBo08Skom54WJk/gd1SyKk8m66oCXZFej01sgevEpYO
X-Gm-Message-State: AOJu0Yy1fCUlHta7xy6FPTEzjANfgfTvmyD5KD09PLkQky8uWiPoRXDs
	kj8TnOaT6UBbyMW29bsQx8NjIN7KMuwyWJwUPYEC2RU1HIGmO/jW
X-Google-Smtp-Source: AGHT+IFkZuSk4yc7ZkQAPlnoo1HaJl8XBG3aswatvy1MDTFAa6qI6RnRadQtwBogcsD2uowE+pH36A==
X-Received: by 2002:a17:902:eccb:b0:1fc:4b4f:68aa with SMTP id d9443c01a7336-1fd74521108mr35579285ad.1.1721572441994;
        Sun, 21 Jul 2024 07:34:01 -0700 (PDT)
Received: from localhost ([117.147.31.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f2a3c7asm37193165ad.112.2024.07.21.07.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 07:34:01 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	chen.dylane@gmail.com
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [v3 PATCH bpf-next 0/4] bpftool: add tcx subcommand in net
Date: Sun, 21 Jul 2024 22:33:49 +0800
Message-Id: <20240721143353.95980-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XDP prog has already realised with net attach/detach subcommand.
As Qmonnet said [0], tcx prog may also can be added. So this patch set
adds tcx subcommand in net attach/detach.

[0] https://github.com/libbpf/bpftool/issues/124

Change list:
- v2 -> v3:
    - fix return value in patch2
    - replace tabs with spaces patch2
- v1 -> v2:
  - As suggested by Quentin, modification as fellows:
    - refactor xdp attach/detach type judgment in patch1
    - err handle fix for xdp in patch2
    - change command tcx* to tcx_* in patch2
    - some code modification for readable in patch2
    - document modification for readable in patch4

Revisions:
- v1 https://lore.kernel.org/bpf/20240715113704.1279881-1-chen.dylane@gmail.com
- v2 https://lore.kernel.org/bpf/20240717174524.1511212-1-chen.dylane@gmail.com

Tao Chen (4):
  bpftool: refactor xdp attach/detach type judgment
  bpftool: add net attach/detach command to tcx prog
  bpftool: add bash-completion for tcx subcommand
  bpftool: add document for net attach/detach on tcx subcommand

 .../bpf/bpftool/Documentation/bpftool-net.rst | 22 +++++-
 tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
 tools/bpf/bpftool/net.c                       | 69 +++++++++++++++++--
 3 files changed, 85 insertions(+), 8 deletions(-)

-- 
2.34.1


