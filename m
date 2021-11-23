Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F3D45A794
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 17:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhKWQ1m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 11:27:42 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:43449 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231187AbhKWQ1h (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 11:27:37 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 067E22B01478;
        Tue, 23 Nov 2021 11:24:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 23 Nov 2021 11:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=4PpDbsLtMyT0tQ7B4AuoGIQTJF
        IglmyFjTyXLB+zyIc=; b=o3DgD9/MMVnJkg0dklPbhmdrIq7h13Y5zXexsG9H2J
        tcMgCpR7s9T0r+1RSNIE1ozyCycFSyhjyYvy8lbGom848Zwdq1jnn7VlCH5jWPaL
        SDuFbtHDjUqlAXKQSp+Iru+f/5dEVHuZP8dSuOD9qR7gCWVEtAQAnQPcPK3FoxAV
        L0gxE8EDwOAEXPdxtfDVbwqp40XMUwOD5drOc3qtWSCjRki9Zkhx2n2nGKVuEgUu
        Z3HmbbA8Epk9a/S7hv3mkRvayAlmTkFZr3aWSuaLej6TW7uv2RtUblGHuBTW3OxO
        aWSg52siqa/or2gnJ4fOj5WTBZrK5LYN22vjMk+ZERbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=4PpDbsLtMyT0tQ7B4
        AuoGIQTJFIglmyFjTyXLB+zyIc=; b=NgLCpRsfMeF59Z9mwcnxyfI/rRQu7++I+
        miJ+slL5dc1loNPHm82Xk07tCgINJklOeGwCev2hCKv4eeWpDhe/+HmXwOIWweVI
        LOsYYEeOg3Ryl9pyGs5ZsxRviRtFLLcwa4q5MylgvRK0cGluEZUh9NTJuObJV9M/
        4CNEhk/2zpj/AGsdJWq6KjIg2nkxBnD97a5fwVwXKlCJUPbJ2BWeCBQyXGQjzL8n
        btmZfCGJQL2v0+RNa47O3Vb+AnC7s17Nh1pvqDiIfU/RxsLR+MCBLNnxBoODB9uP
        Ppq9V11z9kv3A/ixx7P1PFGCmxEfJ0kh8HQMPydZIPsH4NJ9TS69Q==
X-ME-Sender: <xms:uhWdYWuECM0mqrer3gX13e2aj33BVlFdN9CjADc3c1dbJp-bGJ_UMA>
    <xme:uhWdYbefMhiK0onGOKYmz16QhKt1RG-9OOdh8bvtdssI6z7wP6hFb8tYt9p7pB0k5
    p2Tv8WgHK3HpsiUIg>
X-ME-Received: <xmr:uhWdYRzDIK8PfM9J6FpM9xDebUTEWH7JDQdBTiNmrx86MR5USywJFwnA3yif_v6Q68OdMCp7CDIf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeigdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeffrghvvgcuvfhutghkvghruceouggrvhgvseguthhutghkvghrrdgt
    ohdruhhkqeenucggtffrrghtthgvrhhnpeefvddtueelfefhuedtgfevfefhgedvkeegud
    etvdfgueekudehtefghefhkeduudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegurghvvgesughtuhgtkhgvrhdrtghordhukh
X-ME-Proxy: <xmx:uhWdYROn8WpxKwGhXHQVGIX-n0f6fWgKcgmvhhw3bnzdKkWtIIwnoQ>
    <xmx:uhWdYW_5xmCy7gTrWYIJ9No8UEP8s25gpgECjSkV1HECJXfiLjDC-A>
    <xmx:uhWdYZWKDK7t0oONs7J_Dx82BJJgMZhqEg5VZCcEq05mDG6pJKlgRg>
    <xmx:uhWdYZayWvxM1ltYbBhGdXvQspN7eITPaescqs0i1W3AP6kbSzxrlXYhDR8>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Nov 2021 11:24:25 -0500 (EST)
From:   Dave Tucker <dave@dtucker.co.uk>
To:     bpf@vger.kernel.org
Cc:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH v2 bpf-next 0/2] bpf, docs: Document BPF_MAP_TYPE_ARRAY
Date:   Tue, 23 Nov 2021 16:24:19 +0000
Message-Id: <cover.1637682120.git.dave@dtucker.co.uk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series is the beginning of my attempt to improve the BPF map and
program type documentation. It expands the template from
map_cgroup_storage to include the kernel version it was introduced.
I then used this template to document BPF_MAP_TYPE_ARRAY and
BPF_MAP_TYPE_PERCPU_ARRAY

v1->v2:
- point to selftests for functional examples
- update examples to follow kernel style
- add docs for BPF_F_MMAPABLE

Dave Tucker (2):
  bpf, docs: add kernel version to map_cgroup_storage
  bpf, docs: document BPF_MAP_TYPE_ARRAY

 Documentation/bpf/map_array.rst          | 172 +++++++++++++++++++++++
 Documentation/bpf/map_cgroup_storage.rst |   2 +
 2 files changed, 174 insertions(+)
 create mode 100644 Documentation/bpf/map_array.rst

-- 
2.33.1

