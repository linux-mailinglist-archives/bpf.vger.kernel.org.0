Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1FD3C890A
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 18:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGNQz3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 12:55:29 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43109 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229617AbhGNQz3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Jul 2021 12:55:29 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F0195C0140;
        Wed, 14 Jul 2021 12:52:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 14 Jul 2021 12:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=sLHf2FGTj0fqJAd1kANoWfoDR5oW8f8b6GIXB2ywFRU=; b=fhdeEEu1
        dXZnEWLzpuEXjRyXiG76kKGf22Z4HntYuED/4chJmFKWPfheQWxx9RRFSEqrk0mH
        LS90aeKZziw5oEUZqgV/4xy/KYcnsc4H2lL3PH1tSccU/O9Ebe6CHD+4awLEY3tj
        YuztWjoVl6lMgQXg1G8AHwWeXta6ZnAW1+N4aDHPKMufLy7jxp7I3s5jxBnZd4fX
        rm2hUxgCo/MGG+jcx+h4t7gvCkQkiQs3vzOyg+3Vyo6sxOzaLfGMGwieAu+0Si6H
        BMkeq0blm+Po65A221A1p4roEKH5d9fRF3r9VhqEF/3xBLjHVfQK4Xbv5YRw7j9O
        sKYf+++bSrcUlg==
X-ME-Sender: <xms:VRbvYCd6e1Mcjm8PjSR6Y-7ACp0Q8F5JkSMfn6ZTTzqblCJdJs7K9Q>
    <xme:VRbvYMMoPDGB9AE59_z3A0ewj2vMDO1uDse9LinYxt1QjOJ0mqr9z-XDB7cViOHZf
    FH_gdLpCSKtICPI61g>
X-ME-Received: <xmr:VRbvYDjlYKjEi4a_HTPc8T_HaTLmtyGrrL2SFrUyzb73C_c_VJRbFJoUsmCw0Ow1gzXQ1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepofgrrhhthihnrghsucfruhhmphhuthhishcuoehmsehlrghm
    sggurgdrlhhtqeenucggtffrrghtthgvrhhnpedtffffgeffjeeiheeuvdfhkeejvefhie
    dufeekffekueeuhfelvdetjeeiteduvdenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehmsehlrghmsggurgdrlhht
X-ME-Proxy: <xmx:VRbvYP9UtePQkCt5_whHXiWF9XX118ZzG_C-X7C1m0cD_2y6Fe7TSQ>
    <xmx:VRbvYOsO6pcKN2uLd-7ut4sgBlgBbelQPhNRApYBXi7GkklFHJsBBQ>
    <xmx:VRbvYGEYmgMRJWwkmMstNmlZ9jR37zMcQNPpWPjgxBkNERoGn5mqFA>
    <xmx:VRbvYH7uMc527WadcU4G08Ztp7c3hi9JdEheJFNl6NL3KeNEF3SkUw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jul 2021 12:52:36 -0400 (EDT)
From:   Martynas Pumputis <m@lambda.lt>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        m@lambda.lt
Subject: [PATCH bpf 1/2] libbpf: fix removal of inner map in bpf_object__create_map
Date:   Wed, 14 Jul 2021 18:54:39 +0200
Message-Id: <20210714165440.472566-2-m@lambda.lt>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714165440.472566-1-m@lambda.lt>
References: <20210714165440.472566-1-m@lambda.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If creating an outer map of a BTF-defined map-in-map fails (via
bpf_object__create_map()), then the previously created its inner map
won't be destroyed.

Fix this by ensuring that the destroy routines are not bypassed in the
case of a failure.

Fixes: 646f02ffdd49c ("libbpf: Add BTF-defined map-in-map support")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Martynas Pumputis <m@lambda.lt>
---
 tools/lib/bpf/libbpf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6f5e2757bb3c..1a840e81ea0a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4479,6 +4479,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 {
 	struct bpf_create_map_attr create_attr;
 	struct bpf_map_def *def = &map->def;
+	int ret = 0;
 
 	memset(&create_attr, 0, sizeof(create_attr));
 
@@ -4561,7 +4562,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	}
 
 	if (map->fd < 0)
-		return -errno;
+		ret = -errno;
 
 	if (bpf_map_type__is_map_in_map(def->type) && map->inner_map) {
 		if (obj->gen_loader)
@@ -4570,7 +4571,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 		zfree(&map->inner_map);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
-- 
2.32.0

