Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8116493EAE
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 17:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346539AbiASQ6m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 11:58:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59208 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239673AbiASQ6m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 11:58:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEEA5615B3
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 16:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC7BC004E1;
        Wed, 19 Jan 2022 16:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642611521;
        bh=EDhwY6gsGtb/8+IgFxexWJrRhb4CnHIgLcyqWxxa3yM=;
        h=From:To:Cc:Subject:Date:From;
        b=bXVlKXT9XwBjbhrrGb+E+n9ObV6TJRs9cO/pKVuAm+iQlB+a2136DPIbr64/+iKBE
         V8Rz1v6IkdpQwEe1Z2i/UXmiRNlXIM0PYzlVUuScUNWnFMoEuaApBvxAHHv8g2nJF0
         /d/8SGqW2FsXNx4ieXQI868fYDmNLsu9zLsGwSKgX6Y26p8iZhh0ZG9bdJ9Z+/ex+I
         AlkDbvVsDrEq/8aTDOD7oJcvDLAIRq8vvgThlRPf/JziH6+Ya7aYkSqesawW1m3Jk0
         a0K7ho8TknZXvC0LgkewIhbKjjuHvKQpr/XqIypBcdLJ5PvTp9qLwCq8YIH3K6ptOq
         W/85w3GkTRETA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii.nakryiko@gmail.com
Subject: [PATCH bpf-next 0/2] rely on ASSERT marcos in xdp_bpf2bpf.c/xdp_adjust_tail.c
Date:   Wed, 19 Jan 2022 17:58:25 +0100
Message-Id: <cover.1642611050.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rely on ASSERT* macros and get rid of deprecated CHECK ones in xdp_bpf2bpf and
xdp_adjust_tail bpf selftests.
This is a preliminary series for XDP multi-frags support.

Lorenzo Bianconi (2):
  bpf: selftests: get rid of CHECK macro in xdp_adjust_tail.c
  bpf: selftests: get rid of CHECK macro in xdp_bpf2bpf.c

 .../bpf/prog_tests/xdp_adjust_tail.c          | 62 +++++++------------
 .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    | 43 +++++--------
 2 files changed, 40 insertions(+), 65 deletions(-)

-- 
2.34.1

