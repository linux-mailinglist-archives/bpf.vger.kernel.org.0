Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D984A5EB8
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 15:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbiBAO6d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 09:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiBAO6c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 09:58:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861C1C061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 06:58:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23A5161650
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 14:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD42C340EB;
        Tue,  1 Feb 2022 14:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643727511;
        bh=JpjaBMHXFgHyHzvRB+XGx5xKkiJsLmT9QSev2Ctj4B0=;
        h=From:To:Cc:Subject:Date:From;
        b=LTbaJpvzTLUxAsS877lKC9jNaW3T84ZOiDGp1UrDp2eZFwlNakrNoKjOw9pvkAMk5
         riIHN5b8u6t4tgnW5+Z5um9EyU0s9E9t0D6j6UJRH/KJadELYG3Uvljty6obSxZwws
         RT4dbX89Sr2v0f4G1WPms8XeR5ENLekNx0ujOva7YX8wcbj2alI761djP2feUanzrm
         y2weNvNmbodOShTzpH1k2gFdQbPZrBBpC7Y/R+itgVLmj3+wj5gI+V4ucMqlsT3k4R
         x8drAoob+8XnzPR4S9nBl1+5mwxzK36Mo+KiwBpYSGkz7EtdL5D4qerk99FiExaXZW
         qMRzvMMbmeuTQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, dsahern@kernel.org,
        brouer@redhat.com, toke@redhat.com, lorenzo.bianconi@redhat.com,
        andrii@kernel.org, john.fastabend@gmail.com
Subject: [PATCH v3 bpf-next 0/3] libbpf: deprecate xdp_cpumap, xdp_devmap and classifier sec definitions
Date:   Tue,  1 Feb 2022 15:58:07 +0100
Message-Id: <cover.1643727185.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Deprecate xdp_cpumap, xdp_devmap and classifier sec definitions.
Update cpumap/devmap samples and kselftests.

Changes since v2:
- update warning log
- split libbpf and samples/kselftests changes
- deprecate classifier sec definition

Changes since v1:
- refer to Libbpf-1.0-migration-guide in the warning rised by libbpf

Lorenzo Bianconi (3):
  libbpf: deprecate xdp_cpumap, xdp_devmap and classifier sec
    definitions
  selftests/bpf: update cpumap/devmap sec_name
  samples/bpf: update cpumap/devmap sec_name

 samples/bpf/xdp_redirect_cpu.bpf.c                 |  8 ++++----
 samples/bpf/xdp_redirect_map.bpf.c                 |  2 +-
 samples/bpf/xdp_redirect_map_multi.bpf.c           |  2 +-
 tools/lib/bpf/libbpf.c                             | 14 +++++++++++---
 .../bpf/progs/test_xdp_with_cpumap_frags_helpers.c |  2 +-
 .../bpf/progs/test_xdp_with_cpumap_helpers.c       |  2 +-
 .../bpf/progs/test_xdp_with_devmap_frags_helpers.c |  2 +-
 .../bpf/progs/test_xdp_with_devmap_helpers.c       |  2 +-
 .../selftests/bpf/progs/xdp_redirect_multi_kern.c  |  2 +-
 9 files changed, 22 insertions(+), 14 deletions(-)

-- 
2.34.1

