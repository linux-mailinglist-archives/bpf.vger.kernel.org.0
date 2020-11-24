Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E9D2C2AED
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 16:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgKXPMO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 10:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgKXPMN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 10:12:13 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E82FC0613D6
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 07:12:13 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id t4so9735941wrr.12
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 07:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zo/eh4ktsJrvBJDhlleePdIuf6jkuW1NUUnewCNp2aA=;
        b=S32ef2BvvdYvJXT+dX/Sz/zKAStOA6HlrzJx5QZH8K5801QaZ5/FQXnZtciyBb/7Zm
         X3xhA/pIpPCD8MLVwrPc47UFcnmABqySOsW6HgVxn5Rbjk3OIxPn5wVsWSfYCqrrhgxn
         RFEY10+OSbJS2t8gVKAdgBxSABPT1j2NsIFLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zo/eh4ktsJrvBJDhlleePdIuf6jkuW1NUUnewCNp2aA=;
        b=U0nCZyv3qnR5AJl3IRpdyJXqkcjTeZ0AqcZiVJnwXMpUn9+O+vzX/3gcLpaXm9YNuU
         hLU56WfK/QkYpQ1uZ7C1uiS3KBWut41jwgxqwb4DqTVP5rGqmhTkBP10ETsIILuMSpt9
         NCv6xGjF2zi70EJy1EHb3Sf4f0KfFlqNLsaf8U9adPhRyXLuP6mVdsFid/9Q4aDxhdE7
         U7qFToK70ruqqYTd/9Bx7fgqiUkMs0Bdr8TxU+6ustE69Dhq8zAQSprrdjvvYPcJaU2r
         gimHlNTSmkftzELiXLADo0JKF8y6DEV7PZg18WHiF4y3LuXSwIBNzFVVaZgOtutTQ91Q
         78Sg==
X-Gm-Message-State: AOAM531p2vajk5jq9QpRfbmkwPmZfi1druLLbtih5QPPEacZ+GRQHg8s
        usBOa7Puz3KzFpvrS6PVWEX2DQ==
X-Google-Smtp-Source: ABdhPJz7rM/ysBu70throMYID2n092kypArpUlgruAbhh9VP+nhscLS+z5ycOFTueeCRvUwHEWrB1A==
X-Received: by 2002:a5d:5604:: with SMTP id l4mr5677722wrv.127.1606230732372;
        Tue, 24 Nov 2020 07:12:12 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id g131sm6353127wma.35.2020.11.24.07.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 07:12:11 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH bpf-next v3 0/3] Implement bpf_ima_inode_hash
Date:   Tue, 24 Nov 2020 15:12:07 +0000
Message-Id: <20201124151210.1081188-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

# v2 -> v3

- Fixed an issue pointed out by Alexei, the helper should only be
  exposed to sleepable hooks.
- Update the selftests to constrain the IMA policy udpate to a loopback
  filesystem specifically created for the test. Also, split this out
  from the LSM test. I dropped the Ack from this last patch since this
  is a re-write.

KP Singh (3):
  ima: Implement ima_inode_hash
  bpf: Add a BPF helper for getting the IMA hash of an inode
  bpf: Add a selftest for bpf_ima_inode_hash

 include/linux/ima.h                           |  6 ++
 include/uapi/linux/bpf.h                      | 11 +++
 kernel/bpf/bpf_lsm.c                          | 26 ++++++
 scripts/bpf_helpers_doc.py                    |  2 +
 security/integrity/ima/ima_main.c             | 78 ++++++++++++------
 tools/include/uapi/linux/bpf.h                | 11 +++
 tools/testing/selftests/bpf/config            |  4 +
 tools/testing/selftests/bpf/ima_setup.sh      | 80 +++++++++++++++++++
 .../selftests/bpf/prog_tests/test_ima.c       | 74 +++++++++++++++++
 tools/testing/selftests/bpf/progs/ima.c       | 28 +++++++
 10 files changed, 296 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/ima_setup.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_ima.c
 create mode 100644 tools/testing/selftests/bpf/progs/ima.c

-- 
2.29.2.454.gaff20da3a2-goog

