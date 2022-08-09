Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A741258DC2B
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 18:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245123AbiHIQfH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 12:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbiHIQfC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 12:35:02 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72411EECB;
        Tue,  9 Aug 2022 09:34:59 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 9F71B32008FA;
        Tue,  9 Aug 2022 12:34:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 09 Aug 2022 12:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1660062896; x=1660149296; bh=uP5Ush9788ztF3g3kX382p5ir
        OwRq/RLQO97X222ADo=; b=a9DWCo18RTU15Ywij8R7c8cVdAsimEQ1Q9oLYeTiS
        rONGNtq+/V+An2EQyYBDBgprn/StuQOJp9MZN6QZgRT1esyu6Er5QHaZMSmhs89I
        QEbn1hUDODpzqjFfMKcibu6vZy369aScILE3EFzILde7eVCBiUwgQaGs5NOCNjpK
        lsPOGn/Ei/FOa9+BuyBYJC3msus3YJ+oLedlQL23c6FhN1Ed0Ed7UTvGx+qVpJ1D
        XyiGuJM4m60g+acWBQ9ffZbAv5tKqb9HJuJWo+VGgK7ME2wvI5DPlE8HnMA5htWt
        h4J5VEqLCh0nGqO+mwrH8q8aM8I5WzED73WG4HqE3ILsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660062896; x=1660149296; bh=uP5Ush9788ztF3g3kX382p5irOwRq/RLQO9
        7X222ADo=; b=OJ3imwNTs9+wQk2zKsM2tmK0C1Gk764Sx6Ys5BfgdtN5XSsArcm
        xTrhSpEKXEUAlFP+LU+0hiV+Duz4p1yZ9usF3JqpnIKjFt4LRU3/rkimpNPd1TVQ
        BA8n71VYlGwSSzY4w27PMKrVzie3fG3WOyqZnjPRSoFu3tSmfhTIRC0U0Wf+xNkf
        hgMbcslxIo/khsDQHUQ+1rspT7EaYzBMroyGbxpy1iq5EVIXKvf642lZUzd6kX/X
        hvAQ/X4GqE9C2XcXqKGGpmkRiBF+ituXjWBM7eCYn4KBGjhY3woHFBbCcnFZ5rO6
        DZ2Pncf5MJhmAFu5bTVNfIPN3+IjzX4TMAA==
X-ME-Sender: <xms:r4zyYlVlOrWjMWl4aTkQnatS1nk6y0ksQo-FEHidheSHqgdB3cy2cA>
    <xme:r4zyYlmfOQnngdFrEDGx3QsCTSihxscjbqQtkv00ZpbNI3os61ab_EdrcgDh6wc4X
    5bnzv8BTRDt4M7OBg>
X-ME-Received: <xmr:r4zyYhYnH75t0ooeElxNfnGTmmaYCtN51VXr8iwC3lTWhO9Jx5jIYlPgwGk_uXFpU0CKANtMr8s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeetueektdeuhfefvefggf
    evgeffgfekfefhkeekteffheevtddvhedukeehffeltdenucffohhmrghinhepkhgvrhhn
    vghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:r4zyYoXUjFHVoVRQgQVjRgQLAXB7wuqNTjAtrm2VU8sK8082SArSrg>
    <xmx:r4zyYvm-xbzFEb_exNROMdP65c1qRWe1t5AeDG6ymNJXgkXI6lKurg>
    <xmx:r4zyYleiOIZ5_CmpFNnQfey7JdQTzlpZy6-ntFclab5_fXdmURoPLw>
    <xmx:sIzyYqsuUJdOmQxTFcCw-JobzsLSlBQsj7qIEaWaed1lzoIG87F5BA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 12:34:54 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, memxor@gmail.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] Add more bpf_*_ct_lookup() selftests
Date:   Tue,  9 Aug 2022 10:34:40 -0600
Message-Id: <cover.1660062725.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds more bpf_*_ct_lookup() selftests. The goal is to test
interaction with netfilter subsystem as well as reading from `struct
nf_conn`. The first is important when migrating legacy systems towards
bpf. The latter is important in general to take full advantage of
connection tracking.

I'll follow this patchset up with support for writing to `struct nf_conn`.

This change will require two changes to BPF CI kconfig:

* CONFIG_NF_CONNTRACK_MARK=y
* CONFIG_NETFILTER_XT_CONNMARK=y

I can put up the PR if this patchset looks good.

Past discussion:
- v1: https://lore.kernel.org/bpf/cover.1659209738.git.dxu@dxuuu.xyz/

Changes since v1:
- Reword commit message / cover letter to not mention connmark writing

Daniel Xu (2):
  selftests/bpf: Add existing connection bpf_*_ct_lookup() test
  selftests/bpf: Add connmark read test

 .../testing/selftests/bpf/prog_tests/bpf_nf.c | 60 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_bpf_nf.c | 21 +++++++
 2 files changed, 81 insertions(+)

-- 
2.37.1

