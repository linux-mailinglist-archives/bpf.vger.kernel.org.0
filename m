Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43535561A24
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 14:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiF3MQA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 08:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiF3MP7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 08:15:59 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF1A1EC69;
        Thu, 30 Jun 2022 05:15:57 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7677E5802C4;
        Thu, 30 Jun 2022 08:04:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 30 Jun 2022 08:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1656590672; x=1656597872; bh=pAZH5MTBdgS3CquuCfAfzYAxKgms2Uu1+KL
        7ZAZvgAA=; b=EvEf7W+eOXP5lYbA71ryKh7xp6PoglK7MbvylNGO3aGGoHvcIZ1
        /WZ7AcV09D5AMzBDBq0cb0/qQxIbYFT1HH09IlXRqvH6sd6Vr1aFZfAOr29GTsGm
        w4ULvZ4pKZsFTxUhfLuSO1vYn+SN7Tajeo8D4ShNlFLw46WhzpsJiLiZfJDGAQfE
        GjU95ZWGVAWu/RvtIuDjma8/Uy+0hm7PpUll2fTXXeJOPzJDlTRlgQeLEXVAfwLo
        HiKjjiUQTG45IYc8Eu/SsdGwrjXKhmf8PGLnP0iwWeoHFS5V5UuxhENUiULTUb+o
        xfm28LKWBamXQbDCYqKLcad61cpiwK7ORxg==
X-ME-Sender: <xms:T5G9YjeGSFKqvKIWHutUc3pqfn-s0mYmcRlNXWLcJIRSoGyMrLOqAw>
    <xme:T5G9YpOrIOabj2zmH_ue6okukwHuxSLcu4QKj_xfsXfwCMy5uwF3PTdcArGoQCJ3F
    gcWiKz_5dDIJ9Fvng>
X-ME-Received: <xmr:T5G9Ysh38_JA8Xn3R-tMENTbcX20SVfym-s38Hasrx3eY1touhofJnHzMepEOGHTbrhqHszMGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehuddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeffrghvvgcuvfhutghkvghruceouggrvhgvseguthhutghkvghr
    rdgtohdruhhkqeenucggtffrrghtthgvrhhnpefhffdtkeegveeiveefgfdtudehkeehie
    ejleduieehiedtffevjeekhfehfeehtdenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegurghvvgesughtuhgtkhgvrhdrtghordhukh
X-ME-Proxy: <xmx:T5G9Yk8ci1CUBwvN2HTjAfU_WNUWvVNfxh2IV6_jstvMkFioSDQh9g>
    <xmx:T5G9YvvLwR0sg5rmRDDj-go4SqIzZmXbsS2gmkAO6MEIxUYckkd-0w>
    <xmx:T5G9YjH4Ef-P0Zt6996DfB8xvZh-_2-hjACdgawOIVhGSPExChK8Gg>
    <xmx:UJG9YtLuaxoLMGwv7GaGuRTG433-kbS91x33MCS75Qg0bR4JBw4wOA>
Feedback-ID: i559945a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jun 2022 08:04:31 -0400 (EDT)
From:   Dave Tucker <dave@dtucker.co.uk>
To:     bpf@vger.kernel.org
Cc:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH v4 bpf-next 0/2] bpf, docs: Document BPF_MAP_TYPE_ARRAY
Date:   Thu, 30 Jun 2022 13:04:07 +0100
Message-Id: <cover.1656590177.git.dave@dtucker.co.uk>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_FAIL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series is the beginning of my attempt to improve the BPF map and
program type documentation. It expands the template from
map_cgroup_storage to include the kernel version it was introduced.
I then used this template to document BPF_MAP_TYPE_ARRAY and
BPF_MAP_TYPE_PERCPU_ARRAY

v3->v4:
- fix doctest failure due to missing newline

v2->v3:
- wrap text to 80 chars and add newline at end of file

v1->v2:
- point to selftests for functional examples
- update examples to follow kernel style
- add docs for BPF_F_MMAPABLE

Dave Tucker (2):
  bpf, docs: add kernel version to map_cgroup_storage
  bpf, docs: document BPF_MAP_TYPE_ARRAY

 Documentation/bpf/map_array.rst          | 183 +++++++++++++++++++++++
 Documentation/bpf/map_cgroup_storage.rst |   2 +
 2 files changed, 185 insertions(+)
 create mode 100644 Documentation/bpf/map_array.rst

-- 
2.37.0

