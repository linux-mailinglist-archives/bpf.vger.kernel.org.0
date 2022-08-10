Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D312858F4C0
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 01:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiHJXRG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 19:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbiHJXRC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 19:17:02 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE4179EFD;
        Wed, 10 Aug 2022 16:17:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D606C58088D;
        Wed, 10 Aug 2022 19:16:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 10 Aug 2022 19:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1660173416; x=1660180616; bh=s2eqPpo3EcIBzlyogIed9ASwn
        BssDbDTakSn5dsaPGk=; b=QMgOjsYj6nZ/rVWkV8dkpAOxkAZsZWJz6n+PkR/5H
        dTu4M/bDkFKjOcvPOGro0Np/N7h+5pSfR8IXUcqup01N+NwF1CZBuMOZQmTvXsKK
        aCcuG/MjpNNpwtRDzN3B9Y3kbjp1jCGnaGv6a347ckEZwkywJGMRmCs6F7J1QD5K
        hFkFHypoesH22W6O62j6tCQ30i6TQd1qKaXLAniJsXkkUgsBR/KZE5tmR8HXkOLP
        1bZ3S/Q9YIUffG8sVummTFXgegSKFjw+0GNbCQGrv0Cologd3dIehavnhnYW2NrY
        PC0qYAS2oCJj4iVC8BdmdoYPFNxT6cD2RWLTSz9gmmNVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660173416; x=1660180616; bh=s2eqPpo3EcIBzlyogIed9ASwnBssDbDTakS
        n5dsaPGk=; b=4myC0Pl5CTEM3EE3d/pP8uoxQK2YEQV+M6WAjI3S7bJsnMnL0Hc
        0ypPBNz2PEHbt6dWorbV3/y8K3Nfl6YvUVsL8GN+ZTwsALtovuXorThQ/skjnskr
        49Mhbpq1dHYjTtAaY/D8sX6xPPiNuXPs4hGmfQ9wP/HPAoJAgH5nJj4MbIW1la2o
        mdgOSwZ9DxHDyXXUwOHiKwtYcs2+DHxLf8jh5WT/5A1UKgxGWTB9KNOw2jLGwmSh
        bo2+61TRcik86NwRf6ztKkknR71r+Jj1CiT0SnW3ynaTGsMxg2mxd1kF94x5KRGA
        zPm6HkWwLQu9da5cDCbTOVsZy3/t44DyZhA==
X-ME-Sender: <xms:aDz0YrzwQHDukS4HjXR6ViZvzaPnCFS0Uq5mlQ2gzdIWd8YddM3TiA>
    <xme:aDz0YjSENWFuLFMjiW57s8AEIL9PBUrDH1pwNwp6zpK1nVfh_CNmJYiu5SsV5FTzR
    akDAP9mTheIFyxt-g>
X-ME-Received: <xmr:aDz0YlVa4GdR5cRwMVnPTYrnTbO9oxxCMwPLh9IOcA5IB9vfVmgkjuj5htV5-XI-OoBMw7mFUTk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegfedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenogevohgrshhtrg
    hlqdfhgeduvddqtddvucdludehtddmnecujfgurhephffvvefufffkofgggfestdekredt
    redttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpeetueektdeuhfefvefggfevgeffgfekfefhkeekteffheev
    tddvhedukeehffeltdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdr
    giihii
X-ME-Proxy: <xmx:aDz0YlhA7gwpakel8onQLP_au8kBpUiHGoLZPm29M93_FICw6eFutQ>
    <xmx:aDz0YtA5pGxzjuwCHRDtxamnwfV2_QYepf-VZsv7J0ybhVbhkHIcEQ>
    <xmx:aDz0YuIZhPrgJAdYUYWyj-ignIYGuu9RzDkbzCII07mOaE9k-SFehw>
    <xmx:aDz0Yg5CuVqAVP8vqChtgZ3tLS-y0MiitCWunL3nh8ZnPIQtg-EjLQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Aug 2022 19:16:54 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, memxor@gmail.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 0/3] Add more bpf_*_ct_lookup() selftests
Date:   Wed, 10 Aug 2022 17:16:41 -0600
Message-Id: <cover.1660173222.git.dxu@dxuuu.xyz>
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

Past discussion:
- v2: https://lore.kernel.org/bpf/cover.1660062725.git.dxu@dxuuu.xyz/
- v1: https://lore.kernel.org/bpf/cover.1659209738.git.dxu@dxuuu.xyz/

Changes since v2:
- Add bpf-ci kconfig changes

Changes since v1:
- Reword commit message / cover letter to not mention connmark writing


Daniel Xu (3):
  selftests/bpf: Add existing connection bpf_*_ct_lookup() test
  selftests/bpf: Add connmark read test
  selftests/bpf: Update CI kconfig

 tools/testing/selftests/bpf/config            |  2 +
 .../testing/selftests/bpf/prog_tests/bpf_nf.c | 60 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_bpf_nf.c | 21 +++++++
 3 files changed, 83 insertions(+)

-- 
2.37.1

