Return-Path: <bpf+bounces-20134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC30839C53
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 23:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE291C26A2F
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF5552F99;
	Tue, 23 Jan 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrN4YBKL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0352D4EB29;
	Tue, 23 Jan 2024 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049378; cv=none; b=XP9im4QnBHdMymsiwBWskIYuh7237PpkFFOXziJxTieDMCSEM6ce+FJz0nDykEHJMhWSVDwP/w/cRYHjrXgetMzUxFFAoUz6qhimjGxlxkTRF/Yeu2DbOUGmGveS6RvLedWE7uKQ0zcg0KHkK98mY3w6UUXU3a5eXQ31a2ZXDzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049378; c=relaxed/simple;
	bh=XhRADuM8gBd46Y8SXTVV82C3pfBEaDsN/9WyfmYhwrM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ptNXvP64lHa2e/mKHp20NT3std/SQeVNMHKWCopvhfmzhLcoTdiKMgM1lGQmefzE6eL0Khz8ZdXPJPIShsXWhtM0pyYPniIm1GO8QUWJ1gAZXXxjezj1GpFCfcSXURDZwrWDe3ghbQ/r/LX8JEJaIduM4qGzMl/fyfNt+J5hNNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrN4YBKL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d746ce7d13so22441135ad.0;
        Tue, 23 Jan 2024 14:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706049375; x=1706654175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dhbRM8v6EvgZG8v8DjHs7xekRRUdQ3giaAo8tKPJeCo=;
        b=hrN4YBKLNVrBFmrPuN8FUro75opvWe8b9GzZfC0cqnDhq8jQMPWMtFXm9htQ0f5UhQ
         irfVMFY2lC12fb6oS5RujOVUE38xL5YtQvDsxMhRLadMnLZHdFs7vIVdi/TINV0+n6L1
         oMe/WOFPwL0KeBB6kyQH2zY/uDHr/NOBvfq8c9MUrTprpIT9PvDnZysjESj8bbiGyGun
         2KV47or38llUOquXFOMYSIj2UZx8pjdl5PKqo40K9fb1QCyCInvD+TUtuc0hhuwq2Bhw
         DjWwZlyvvqReptp+hxGo9c5Wqp5fwHJAfoJABV9edOIC8XaQ72pHbRYkzfYfdEXCxc68
         e30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706049375; x=1706654175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dhbRM8v6EvgZG8v8DjHs7xekRRUdQ3giaAo8tKPJeCo=;
        b=iqa7MHAOl4A+Gi7yKQ3Nd5ae8NU8LNjQlI7Z3aEAYUNeNjfbCjVabij7nw9NXoZGhW
         uucRvTn7nKhTnk/G6h+PctjY10XYza7JDmi0f6dBPpEwZItbQHOWL9ywYPwsjgraaLKI
         5sMas01vORRmZHdmBXHidLHnOe4O/osNK32tXCzAyJ0yeuhkSduqP0nda6OhCmrMWQa3
         j/qENI6+ZqhnIysNxiC/WVbP2NA0+hOxu0gkCmKrdzuubNB7Hh48Z7GmQbQwQXRZvaLi
         aWbiPZxMLt7X+I2bJr/GWdzi/hqdsSSjANLfYQoSd4KiLnr+05siQEiJsXJ4eTizK3VG
         KYew==
X-Gm-Message-State: AOJu0Yx2xo0pW724IVKhLOX6Fg9cE7kpZS+faK+IvK4Zg06xkyx2NmO2
	DPWxMxqNn6fvuRMsN4whVf67lQkxYwSrHgWro1z9K5dkxcna43uGD0ZnIGbh
X-Google-Smtp-Source: AGHT+IFUtHi5R0hZZ7knoeB/5XHLb6CJnbZ68ouHwiyzQVrNr6ecZS3ZeytM8MocSUNy4r+kgh3rvg==
X-Received: by 2002:a17:902:bc43:b0:1d4:4c8c:b138 with SMTP id t3-20020a170902bc4300b001d44c8cb138mr5757532plz.59.1706049375075;
        Tue, 23 Jan 2024 14:36:15 -0800 (PST)
Received: from john.. ([98.97.113.214])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902e04900b001d73f1fbdd9sm4875241plx.154.2024.01.23.14.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:36:14 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: netdev@vger.kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/4] transition sockmap testing to test_progs
Date: Tue, 23 Jan 2024 14:36:08 -0800
Message-Id: <20240123223612.1015788-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Its much easier to write and read tests than it was when sockmap was
originally created. At that time we created a test_sockmap prog that
did sockmap tests. But, its showing its age now. For example it reads
user vars out of maps, is hard to run targetted tests, has a different
format from the familiar test_progs and so on.

I recently thought there was an issue with pop helpers so I created
some tests to try and track it down. It turns out it was a bug in the
BPF program we had not the kernel. But, I think it makes sense to
start deprecating test_sockmap and converting these to the nicer
test_progs.

So this is a first round of test_prog tests for sockmap cork and
pop helpers. I'll add push and pull tests shortly. I think its fine,
maybe preferred to review smaller patchsets, to send these
incrementally as I get them created.

Thanks!

John Fastabend (4):
  bpf: Add modern test for sk_msg prog pop msg header
  bpf: sockmap, add a sendmsg test so we can check that path
  bpf: sockmap, add a cork to force buffering of the scatterlist
  bpf: sockmap test cork and pop combined

 .../bpf/prog_tests/sockmap_helpers.h          |  18 +
 .../bpf/prog_tests/sockmap_msg_helpers.c      | 351 ++++++++++++++++++
 .../bpf/progs/test_sockmap_msg_helpers.c      |  67 ++++
 3 files changed, 436 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c

-- 
2.33.0


