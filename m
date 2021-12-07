Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486E346BCA3
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 14:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbhLGNes (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 08:34:48 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:59097 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232505AbhLGNer (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Dec 2021 08:34:47 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 440A9580164;
        Tue,  7 Dec 2021 08:31:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 07 Dec 2021 08:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=xBsMwdxJivfuD
        sKWwk3lW/DROqO3mg9/RPVY9GufXhY=; b=Isgoe1F2q24KmMIwmIoOnG9gDdapi
        B2Ebf/mHtXBRpDy4HMmBXIzcsSE2RJuqzrh2l2EMJLMoodzB2c46N5SfdTq1+ia+
        2sAF2OLGRvVgfBWSPrge1Qm+/h420Ykn8TF25mFxuniTDEYWZiG6alTMVHC2QkjX
        BiUVOMZW5mnydSRSDKHt+lcDjVM5HTghzVdFuJWOD+zRefWjmW49fk0jUhfb7rsn
        j1oA792/bYrJH/GSJR+IN/Ls2AS8JtRlSDxJqIlvDuyXHUA8N+cFXN+sE3njWlGA
        5YyZbO7ud2MVS19liS+05N8PAg0HoBk8wL69aqBkzrABgnJLrPxRhKwZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=xBsMwdxJivfuDsKWwk3lW/DROqO3mg9/RPVY9GufXhY=; b=Xnj03HyS
        +bmMwJzIcMjwjQMRJhnfNCNmSiSz6SvR0eFUEjAugngGc4d7qo6Am7RZLepRtcKC
        hrQVxGqFsEyYbC7TsTDmkhZquMvLv+9vOHjSH0K/47tKQefpekw9RgvKKns+serv
        q+kccEX+M7VyV4/QWuK+xMipbJWCN+YB2kZ1cUbZUzRR7/ImXIE3mNWZ+v7IzLF5
        CcnnKj6Y1lnaYw6zM2TNU37P4z5RGRrnqH/JBYH6VrLh1eBJiGf4mWfBuYEDMtZn
        uXGA55HFQTGPHNOBOxa6br9x0EP4uaHSpG1qAfFa/p3Bv9NvO+8qvtiVX3Kydhtm
        Gcs/e7wa5cR92Q==
X-ME-Sender: <xms:JWKvYeWscEjT6pi1KSGK2e9QaNSvrVCZEhr5_CXy5H50uyVmiiH0VQ>
    <xme:JWKvYal3YVT3hsX_ICcyVOAW28RgxWQKJvs46Dw-5baDsEaI7wlOhDRn69kmbvTCO
    X3T5y90_TqgXWsXNA>
X-ME-Received: <xmr:JWKvYSYhLlSDRbmUOXCU1gXfNLtu5GCFo4AEs2FWXfnb4AHFFU8xlk9LqC-fgQjIuEjTNLLcgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeffrghvvgcuvfhutghkvghruceouggrvhgvseguthhutghkvghr
    rdgtohdruhhkqeenucggtffrrghtthgvrhhnpeevgfdtlefhheetvedtueevkeeuvddtie
    eifefftdeigfevvedukeduvdeiueejgfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegurghvvgesughtuhgtkhgvrhdrtghordhukh
X-ME-Proxy: <xmx:JWKvYVWtVxEvpzYjsPJV_c6b_pCIFVLE9ogEDUrF-h-P51_wqHvu8A>
    <xmx:JWKvYYnvruQEPCcxw3fwoJbr21_rRCA7l2miBx6FVI-6uSpxOBFhqQ>
    <xmx:JWKvYaev46ps5D0l3-EFNPAHg5yUbbMJ6Ja6kJ-8SLpwJNRs-9xh8Q>
    <xmx:JWKvYVjNNp6Cdr__kkzCbg9nuaVsXkcTmOKibVF7AEzHTQ-Y8bLG9g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Dec 2021 08:31:16 -0500 (EST)
From:   Dave Tucker <dave@dtucker.co.uk>
To:     bpf@vger.kernel.org
Cc:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH v3 bpf-next 1/2] bpf, docs: add kernel version to map_cgroup_storage
Date:   Tue,  7 Dec 2021 13:31:10 +0000
Message-Id: <a0ba64336d9655021d7b752b8315833684dcf013.1638883067.git.dave@dtucker.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638883067.git.dave@dtucker.co.uk>
References: <cover.1638883067.git.dave@dtucker.co.uk>
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

