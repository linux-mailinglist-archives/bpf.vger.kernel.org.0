Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6984593E7
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 18:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240116AbhKVRWu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 12:22:50 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:46449 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240022AbhKVRWu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Nov 2021 12:22:50 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 7ED002B01C1F;
        Mon, 22 Nov 2021 12:19:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 22 Nov 2021 12:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=xBsMwdxJivfuD
        sKWwk3lW/DROqO3mg9/RPVY9GufXhY=; b=w8QdY/WDafZozqKCfB9q67zmKmfZp
        qzH7rn5z23kUSZf+IH6LP6cIDV021f9pHk+zDnbX7FQlpbcuZ9xBNZ/OrCylQ4FZ
        G8qczPBQhS1x2qkR+9MBn9TYl1y++blvWrfamUCxuxBAOR++U6hggXoUXNtoUayO
        Winx2kLvmBQ7xtuPc0QaJvmXtXNkrfvcaTEdX98EyR/XofECjClDhBFzgP+js9IE
        MhwfT4TV/A+GLPtZ0uFhJl2m3LEcQY2cwMfHEduHwJfLx+StZcN26pxFYYlaoYuH
        NO5Rzn60Ec1rVDmaqxtvpnBRBH7YYhvHPZwY26t+6ourABjHQdGnRfaog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=xBsMwdxJivfuDsKWwk3lW/DROqO3mg9/RPVY9GufXhY=; b=Q5rrPHwq
        lE6DZSJ36B1YRwH8ENckAk/7qfWpjsI/D2apUMSyKXDpTVBn21sxk4mmxVT+Lxcm
        ugiUrkNzcJCMkX/k747wGn0lLWCFbODxhPRstcY1rKX/GTbgbnYCkhMdj57YkJJE
        E31aLPHJreObh8/6t/ksuHzVj50tpH4J8QjUvdB8O9CH7oL4Vnw6IxzI78XEnyZM
        VVAEdLTdjSGeyikwnkXr1GqVwTwyhFYaSVs/yKRxpbk+VDJN712U+IMCkC1vGs6g
        cciWA2twfiNtBb9TBH8zq/5IRKQ4BxJ8u9SeaZF24LmbPHxkHjEzwiEuhR987SvG
        w/OvBDfBldeYKQ==
X-ME-Sender: <xms:LdGbYRgI91f--YdTKjrYOiUlWCQdt3h7eNAN8Zh2EIT0PAoUWrKFWw>
    <xme:LdGbYWAeivMW76uF_KvMZ2bKi3aWIlLMwCW3XJa9AkspS9q61M50kpPZ4DSmYeRTt
    0EhnakOxHEaz5j84A>
X-ME-Received: <xmr:LdGbYRGH-QA2dzyw7cUc57vInV2--NOr5_3eiPFDVuYHuucDXezV0K1u8calFJ7fz0Rl2q0PXzHt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeggddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepffgrvhgvucfvuhgtkhgvrhcuoegurghvvgesughtuhgtkhgv
    rhdrtghordhukheqnecuggftrfgrthhtvghrnhepvefgtdelhfehteevtdeuveekuedvtd
    eiieefffdtiefgveevudekuddvieeujefgnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepuggrvhgvseguthhutghkvghrrdgtohdruhhk
X-ME-Proxy: <xmx:LdGbYWQ0JyAlo8IhJYBUTNnub7oM8paVNYg5C3KJGOYZ0GPVdhJLyQ>
    <xmx:LdGbYezqNipUtABWB4_sXDj3Lp6PBEaXHqikIPbwOUa_91L1dsaOvw>
    <xmx:LdGbYc6q6AoYJhp_Bd12gv6Mf_80S86qGdlXtQTp7OfaIP9K3lUzhA>
    <xmx:LtGbYSc2wtLEX2_6lE2Iyus-sQ7CIJYjz7oX-Ulr2aO4fludYs0GB9oac4w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Nov 2021 12:19:41 -0500 (EST)
From:   Dave Tucker <dave@dtucker.co.uk>
To:     bpf@vger.kernel.org
Cc:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH bpf-next 1/2] bpf, docs: add kernel version to map_cgroup_storage
Date:   Mon, 22 Nov 2021 17:19:31 +0000
Message-Id: <fb36291f5998c98faa1bd02ce282d940813c8efd.1637601045.git.dave@dtucker.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637601045.git.dave@dtucker.co.uk>
References: <cover.1637601045.git.dave@dtucker.co.uk>
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

