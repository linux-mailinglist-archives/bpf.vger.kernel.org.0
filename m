Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA342CC6F2
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 20:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgLBTrz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 14:47:55 -0500
Received: from mx.der-flo.net ([193.160.39.236]:38386 "EHLO mx.der-flo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbgLBTry (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 14:47:54 -0500
Received: by mx.der-flo.net (Postfix, from userid 110)
        id DBBB344563; Wed,  2 Dec 2020 20:46:56 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mx.der-flo.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=4.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from localhost (unknown [IPv6:2a02:1203:ecb0:3930:1751:4157:4d75:a5e2])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.der-flo.net (Postfix) with ESMTPSA id 2FCA744552;
        Wed,  2 Dec 2020 20:46:15 +0100 (CET)
From:   Florian Lehner <dev@der-flo.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com,
        Florian Lehner <dev@der-flo.net>,
        Krzesimir Nowak <krzesimir@kinvolk.io>
Subject: [PATCH 0/2 v2] Improve error handling of verifier tests
Date:   Wed,  2 Dec 2020 20:45:30 +0100
Message-Id: <20201202194532.12879-1-dev@der-flo.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These patches improve the error handling for verifier tests. With "Test
the 32bit narrow read" Krzesimir Nowak provided these patches first, but
they were never merged.
The improved error handling helps to implement and test BPF program types
that are not supported yet.

v2:
  - Add unpriv check in error validation

Florian Lehner (2):
  selftests/bpf: Print reason when a tester could not run a program
  selftests/bpf: Avoid errno clobbering

 tools/testing/selftests/bpf/test_verifier.c | 30 ++++++++++++++++-----
 1 file changed, 24 insertions(+), 6 deletions(-)

--
2.28.0

