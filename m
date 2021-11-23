Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551EF45A792
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 17:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhKWQ1m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 11:27:42 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:42109 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231582AbhKWQ1j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 11:27:39 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 019922B0147A;
        Tue, 23 Nov 2021 11:24:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 23 Nov 2021 11:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=xBsMwdxJivfuD
        sKWwk3lW/DROqO3mg9/RPVY9GufXhY=; b=yVdCz6wUzhRLKL4ECyrisxxpqIw1j
        FuWgtRjbc/SbSiiTZ8QyOnsy2MuSFfZg9+G+rOoUIxYqecjjoABsOg8BXoCrxsix
        5ehe7VNEkF/hWlJz2EwRXwalrc3zCnMhjIeDvmnTdWXhimE2jR2MO7oMNMi6PCAI
        WkuoL/koyoWT/72Z56sna5WeS7Ic72i3n1GWuSnUY/GrcY5/h/Dj1nEUasXCmAHv
        3RAXdjQFxARzHv7SijzulDOiHTP6lzmRFRPwS+U82nFHxV120HB8/FTnGpBJi41Q
        9TxtjnFc3pJSlCHhmh8RMlgGcjdnODAlsGm7UmBYI3aJEAWH/I/6ZGKsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=xBsMwdxJivfuDsKWwk3lW/DROqO3mg9/RPVY9GufXhY=; b=GNbpSMqr
        HKJx9KNcXlB1I4SLulaL7ICtYif/QQ+kJmnmX7BnhLV2jC1fz1quV2ni+ojt+H7P
        TqKESo4n4ljdTV43+seydcKy7s8hJpKwa4WiQgVK9VYm1W9KKmUh5mATv83z6MEB
        JZnRk3Y8SlQQV3UWnJOe5OEEWfxjGB8rj/5+mYzSQoEefnVq7/0j4Qwp5jFLPZFa
        c8QQdImi8FcTYChryHzDltX7ho4pFzBPa1XvyThlShD+sdpxsszxGxFk+zV1KjG0
        2MessOVXu67STQCBlRmgIgLIxLWJZe+gRZH+Qdh9Om8KPi4bUIeYP0QPQXgpAEZ9
        9eu6TA4BKbsHRQ==
X-ME-Sender: <xms:vRWdYU8mSGrE3hZk5CrJ4M0Xt8k8_V7oD3dh3KeRZShVH2zqkXsXwQ>
    <xme:vRWdYctl7S33aSBerKTRwRlf9HuStwX9D_qVf-y9IQOOktkd7I_TrHasAAJ5ojzxA
    ZTuSyB2cNAyb-_3tA>
X-ME-Received: <xmr:vRWdYaARDbCi6Im-psgV1-_YI3e-jlMXdo2EqOgmJmf66LlfdqMdzYGBIBMkKiV_tnb34hcuIVuS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeigdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeffrghvvgcuvfhutghkvghruceouggrvhgvseguthhutghkvghr
    rdgtohdruhhkqeenucggtffrrghtthgvrhhnpeevgfdtlefhheetvedtueevkeeuvddtie
    eifefftdeigfevvedukeduvdeiueejgfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegurghvvgesughtuhgtkhgvrhdrtghordhukh
X-ME-Proxy: <xmx:vRWdYUetyfflyqxba7JMNG8FRsPKNdhS8B6qJSie-FZg0ftEJdIOPg>
    <xmx:vRWdYZNVRD4MEQBkASE6E5un-t1BZWpCK1v60LVhqn8i0cJc1MrKdA>
    <xmx:vRWdYekdZcbrSgDbmUwQTj4aErtkygGu7NBEwP92OTvjUKEaXDfrqQ>
    <xmx:vRWdYcqt0L5ZWIOzUwts5hmLuyWM2npJwtFI6dSuHvuLciq9vRPimE39tI0>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Nov 2021 11:24:28 -0500 (EST)
From:   Dave Tucker <dave@dtucker.co.uk>
To:     bpf@vger.kernel.org
Cc:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH v2 bpf-next 1/2] bpf, docs: add kernel version to map_cgroup_storage
Date:   Tue, 23 Nov 2021 16:24:20 +0000
Message-Id: <fb36291f5998c98faa1bd02ce282d940813c8efd.1637684071.git.dave@dtucker.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637682120.git.dave@dtucker.co.uk>
References: <cover.1637682120.git.dave@dtucker.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds the version at which this map became available to use in the
documentation

Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
---
 Documentation/bpf/map_cgroup_storage.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/bpf/map_cgroup_storage.rst b/Documentation/bpf/map_cgroup_storage.rst
index cab9543017bf..b626cb068846 100644
--- a/Documentation/bpf/map_cgroup_storage.rst
+++ b/Documentation/bpf/map_cgroup_storage.rst
@@ -5,6 +5,8 @@
 BPF_MAP_TYPE_CGROUP_STORAGE
 ===========================
 
+.. note:: Introduced in Kernel version 4.19
+
 The ``BPF_MAP_TYPE_CGROUP_STORAGE`` map type represents a local fix-sized
 storage. It is only available with ``CONFIG_CGROUP_BPF``, and to programs that
 attach to cgroups; the programs are made available by the same Kconfig. The
-- 
2.33.1

