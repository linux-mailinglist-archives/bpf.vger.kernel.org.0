Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29769494D64
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 12:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiATLux (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 06:50:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34758 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiATLur (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 06:50:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BE40B81D38
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 11:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB7FC340E0;
        Thu, 20 Jan 2022 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642679444;
        bh=lt0dwbBFun8JqFcuyUTMlqkaWffRd9DjH5aAIex1XGM=;
        h=From:To:Cc:Subject:Date:From;
        b=S5H0r3uJlV0ivgKXnbi1zPQaRarWXCme2mcqFL7h8hiYSwCn4Bm2ZVUCc9P/SLA7d
         9V2YXTNkeAQixE+7f3TcQ3OjX3q/MbuUsBO+viDP2R1QVuYmOqaFKq6axliCa2L7f0
         zQWWdIz0CFaQBu2TYUmbekh+SKJb7zdmO3pRQOkNkSwieK3W1uzhaKfcb6/CvogaXE
         oFR3KtMCF0ORlyHpua7EOuDPu9FPi3+NE6lTBLdpyGXZXq8t20z+wvgLYcy/u2wHIZ
         6mnilUQArx3Ewf3npG/7faYCX4NbHAg9S7cVUVRtY+vKUpJUfTRpJ2X5C1oBLJPgqt
         kF2MjdZEAfnzg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii.nakryiko@gmail.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH v2 bpf-next 0/2] rely on ASSERT marcos in xdp_bpf2bpf.c/xdp_adjust_tail.c
Date:   Thu, 20 Jan 2022 12:50:25 +0100
Message-Id: <cover.1642679130.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rely on ASSERT* macros and get rid of deprecated CHECK ones in xdp_bpf2bpf and
xdp_adjust_tail bpf selftests.
This is a preliminary series for XDP multi-frags support.

Changes since v1:
- run each ASSERT test separately
- drop unnecessary return statements
- drop unnecessary if condition in test_xdp_bpf2bpf()

Lorenzo Bianconi (2):
  bpf: selftests: get rid of CHECK macro in xdp_adjust_tail.c
  bpf: selftests: get rid of CHECK macro in xdp_bpf2bpf.c

 .../bpf/prog_tests/xdp_adjust_tail.c          | 68 ++++++++-----------
 .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    | 60 ++++++----------
 2 files changed, 48 insertions(+), 80 deletions(-)

-- 
2.34.1

