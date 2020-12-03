Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659A52CDE96
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 20:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgLCTPV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 14:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgLCTPV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 14:15:21 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DBFC061A4E
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 11:14:41 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 3so4971129wmg.4
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 11:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQPN1CQ0uv0EzILFjhtAO7ReV+HbSWCRjIn7E6hwKtE=;
        b=CByeqOlZbFICIOErP0ctBZK6xTQJhVoeLt1cxSoRdCxut19mpPhdRUACLmZdHqQlQd
         TYNbXbCd+8ULhN+prkH0AYUL0Ed2Mtb5KtA48+F49ZAMvBhu1nn3ZlnhggnWpZ8VQNQ5
         cfjD2GwjxrOkLsr26VOxHCi7vNyDQceVX4tKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQPN1CQ0uv0EzILFjhtAO7ReV+HbSWCRjIn7E6hwKtE=;
        b=ms6334O1r1AcsWr1qxoYcMMr7yv6exAnaNe7D6DLTgnZE6B+POE8xBruEdp2ZMrZuL
         seXKw74yJ0UNL8N6D8qBzXZl9zTOxZEaZbUIVd7wHoBH1GulB6uK069R34OO+K1FTFK2
         xgK0qOENjiAuWz9G6YP6UIhBVWYBz6LREa82Z+DVRUEokzxPp7u3BVRRUkF2f6j6kCq2
         VtMMOPdu/j1Hq3gB9pBs31moj76ZaSu3MiZusnLLs5iCkp93VmGEgmzaEyz1LPLufVXw
         opDmu4a/InbxRkg8P7NoQkHwC+2bjER2fbsreoeFbTuP69EFEH3Tv2Mut6nVU50Fgg0u
         gX5w==
X-Gm-Message-State: AOAM53286L1J3cGbi90sMAceX/aXhTM+8HmINjAkHFmJK9gedrp3Wnjg
        MmWdLTfPqqcPs7b8OdM5ilGFmtN+1tgzmF+e
X-Google-Smtp-Source: ABdhPJwi4fvR3OxpDJxVA1ISY3dwzBHNVd9f6NE4c7ZrkI3LgrjGh2WmhZxfkSL82J1rB7m8FCYaug==
X-Received: by 2002:a7b:c154:: with SMTP id z20mr320454wmi.160.1607022879507;
        Thu, 03 Dec 2020 11:14:39 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id q17sm516480wro.36.2020.12.03.11.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:14:38 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v4 0/4] Fixes for ima selftest
Date:   Thu,  3 Dec 2020 19:14:33 +0000
Message-Id: <20201203191437.666737-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

# v3 -> v4

* Fix typos.
* Update commit message for the indentation patch.
* Added Andrii's acks.

# v2 -> v3

* Added missing tags.
* Indentation fixes + some other fixes suggested by Andrii.
* Re-indent file to tabs.

The selftest for the bpf_ima_inode_hash helper uses a shell script to
setup the system for ima. While this worked without an issue on recent
desktop distros, it failed on environments with stripped out shells like
busybox which is also used by the bpf CI.

This series fixes the assumptions made on the availablity of certain
command line switches and the expectation that securityfs being mounted
by default.

It also adds the missing kernel config dependencies in
tools/testing/selftests/bpf and, lastly, changes the indentation of
ima_setup.sh to use tabs.

KP Singh (4):
  selftests/bpf: Update ima_setup.sh for busybox
  selftests/bpf: Ensure securityfs mount before writing ima policy
  selftests/bpf: Add config dependency on BLK_DEV_LOOP
  selftests/bpf: Indent ima_setup.sh with tabs.

 tools/testing/selftests/bpf/config       |   1 +
 tools/testing/selftests/bpf/ima_setup.sh | 107 +++++++++++++----------
 2 files changed, 64 insertions(+), 44 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog

