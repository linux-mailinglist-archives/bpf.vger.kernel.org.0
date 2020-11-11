Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29602AFC0D
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 02:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgKLBcD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 20:32:03 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:51535 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726843AbgKKWqf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Nov 2020 17:46:35 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 372409CC;
        Wed, 11 Nov 2020 17:46:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 11 Nov 2020 17:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=6XDxQ89oRUt1iCVzejeWV7bDGk
        D9oU06u/1vqsZYoCc=; b=BpFVoSHsXp3GMmadYOv+KSkU3buF/32Ixsl0uSV/jL
        zNoleE/Q4VGIsyKHebLfAGbuXcQg5rL3d3fqLzrQQbfUTC3Vdg4tk3Bm9DI+bD1+
        l829bsePCL7qOOcUHWZH/jA2w0l/OZswkdK0RLdYPjX6ZO19UkK3T/wpEH/Vkeqe
        czJ9XQ1uVx46YkUPvVjutQvLsCVPYVSdZWB3u19Ph9AOEbdTLnmbhm1Kb4pracap
        LWqTkSEGwzGgYDReROxeZa4RUHF7vPCgVbqpD1nx9+ubtq5zaZX3F9CdXy+ltkIn
        Ahb2G5O5RPuCff3DAGGBGc8/yanaHEKiVY0FAmMpHRwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=6XDxQ89oRUt1iCVze
        jeWV7bDGkD9oU06u/1vqsZYoCc=; b=UNDDyyEsq3sMO3rVZr0tBGnvWcyaYIByZ
        Z1cIMzyjVzuxpqOWqDe1p0ZjSNCPo4qBw4k5EkaxVUvu6fyfrajA4xhk0oEXE6Mn
        WvAqRVHiOz3Mq9N4KjahZReT4sDyGryOa97iqayuC7Ef5a3vaWTWavEsbVPM7b76
        HtA6sqvGjaK+HfqgjvePw+3Kg1PcQWV5TgI0M3OqArDveA9hLqvr+25WGZDVNh0k
        lSEU+0UT5II7MGOauF26uIQ6Q5aUQ2VWIgqHPavAVLJoGOXswOsVXzUIzt5G3DML
        M7Mg9pRwUxIDdp0czfWoopaTVzT1erfxpAYy4Aa2Xg1WEhZTDL4AA==
X-ME-Sender: <xms:yWmsXzm4eo55H9neZ318KjBg_dou9qZnN-MJgsmuAS7vaxr0JXs_6Q>
    <xme:yWmsX23CRXYEn1GN0oZn9xJsdFGcZ47im9fEXT651vpPEDB_SbXOAp1jrKW5fsMIE
    zoWXikpFrC4iseojw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvuddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeifffgledvffeitdeljedvte
    effeeivdefheeiveevjeduieeigfetieevieffffenucfkphepieelrddukedurddutdeh
    rdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:yWmsX5oOPsI_mWXZYxmK6MQw4TrnxyAVgNnbbPqvvSDnN-8S9pYAmA>
    <xmx:yWmsX7n_ZbyO-yT3dgCeIhGtt5YONnUenqvNgY0pq7RlZriQzNseNQ>
    <xmx:yWmsXx3c_UNzRMPio7661CTi_en5PjSvBMgc45bQs5eMmiMmoK4a-w>
    <xmx:yWmsX5-zW1E4yMHd6YRNszXyY3pBszBe9sxjmz55geoKDXjnp8nDBQ>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 85254306301C;
        Wed, 11 Nov 2020 17:46:32 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        andrii.nakryiko@gmail.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH bpf v5 0/2] Fix bpf_probe_read_user_str() overcopying
Date:   Wed, 11 Nov 2020 14:45:53 -0800
Message-Id: <cover.1605134506.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

6ae08ae3dea2 ("bpf: Add probe_read_{user, kernel} and probe_read_{user,
kernel}_str helpers") introduced a subtle bug where
bpf_probe_read_user_str() would potentially copy a few extra bytes after
the NUL terminator.

This issue is particularly nefarious when strings are used as map keys,
as seemingly identical strings can occupy multiple entries in a map.

This patchset fixes the issue and introduces a selftest to prevent
future regressions.

v4 -> v5:
* don't read potentially uninitialized memory

v3 -> v4:
* directly pass userspace pointer to prog
* test more strings of different length

v2 -> v3:
* set pid filter before attaching prog in selftest
* use long instead of int as bpf_probe_read_user_str() retval
* style changes

v1 -> v2:
* add Fixes: tag
* add selftest

Daniel Xu (2):
  lib/strncpy_from_user.c: Don't overcopy bytes after NUL terminator
  selftest/bpf: Test bpf_probe_read_user_str() strips trailing bytes
    after NUL

 lib/strncpy_from_user.c                       |  9 ++-
 .../bpf/prog_tests/probe_read_user_str.c      | 71 +++++++++++++++++++
 .../bpf/progs/test_probe_read_user_str.c      | 25 +++++++
 3 files changed, 100 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_probe_read_user_str.c

-- 
2.29.2

