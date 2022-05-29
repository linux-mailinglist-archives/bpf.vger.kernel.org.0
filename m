Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CD55372BD
	for <lists+bpf@lfdr.de>; Mon, 30 May 2022 00:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiE2WGb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 May 2022 18:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiE2WGa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 May 2022 18:06:30 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1C579810;
        Sun, 29 May 2022 15:06:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E21F5C00C4;
        Sun, 29 May 2022 18:06:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 29 May 2022 18:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1653861984; x=1653948384; bh=uL7tQhldtntuHotWwMklpuGYS
        aIxV8IbejYp0K3iJKE=; b=wIeVqxy3qdgsMed2yxjJNZa4/nNcDhrZiKOTcBj88
        U2L8abwfruqVW8OReKAFi+E0CuSMT4lDVH0rBBqu0D8MXWAXrV82DJAtXcdbfRyc
        yhFPX8rv+DrgoMhXghj/NicuXwON2K4iXYNNOXA9HU7d7Fgy6y5wHFg4Y85Mbxfg
        ikxZgkbxzrmgjXF3O3jNnYfW3fwivbAhGGOpSNXcJlSjkIFbbAp+cZmWYlr3Ioa7
        oDSSR4yZYrwqftQcKtHmIQ/EEffjclcFyx3ix7ENZRuHQ4OlyM19UNdvLRs/xt5I
        eb1331W0q+pNKiHjURQgZchiQ0mPO3d5/UhqfsBa7f3tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1653861984; x=1653948384; bh=uL7tQhldtntuHotWwMklpuGYSaIxV8IbejY
        p0K3iJKE=; b=PY7MAlvZURI82SB9CsAv3VVHXzMzZbhXYCeEZhPhMf3mQMMffdH
        Dva1s6uF4fbHhZ2Veu5tcG2j+4R/SCQ9CMODicc7XEhaPfNrlVZFFYgbBq3ajzai
        L4ZvZFmgDfUi41qcmsZLtZuuH3ld60Q+BnZDg87Hj/NBoysYoruNlEXofIEzspUX
        FQirsTrIcd890qL776Y+Mly3et2nlLJJPoIBXmtHHcF5fIsVcEzZpb4X2FZph0bl
        bPdJq/gatHsNP5izxD+iaPI+CIgrgT0pPh5t+ovKXP15zktXBm5NkpsP/hUHg6Y8
        wGiXxEYpU4cTCdLfUDJ1sf3bqvA3GJhpLgQ==
X-ME-Sender: <xms:YO6TYp5rd53qxjTWhThJGCggno6TyG1gvCgRuyQi_XpCcgYSlDszDw>
    <xme:YO6TYm7iJtj3lIVAL1lOP3ZBNryw7Tinhn2GtOeQKljEfqsMzB65qJc4ZSU7cqfNf
    JnehLdSrL11fdzitw>
X-ME-Received: <xmr:YO6TYgeVxRDBBumrt1IYEHkAhPH8opzlV3UgsMCaGPB_mNLM7N-5WLRYvAp9X8M7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeehgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvve
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvgefgtefgleehhfeufeekud
    dvgfeuvdfhgeeljeduudfffffgteeuudeiieekjeenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:YO6TYiIqXGGDGbEUXATPZKu38axyc-gzNrfOXU2AgjNo-IIfoYCYcQ>
    <xmx:YO6TYtJAtNGb51yz3VBdTSFKwQnHxtnJ5v-rpYXXMEVBdgjh25Gi8g>
    <xmx:YO6TYrzhepquuWdCzn55GfTw-QGveiCRaZ3Hu4-GGEFCdQ__4B8fNg>
    <xmx:YO6TYqGlcbib8ajqGdUeeWJ9RFUElUyoiM97Uakgxu62O-8iCChZKw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 May 2022 18:06:23 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/2] Add PROG_TEST_RUN support to BPF_PROG_TYPE_KPROBE
Date:   Sun, 29 May 2022 17:06:04 -0500
Message-Id: <cover.1653861287.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

This patchset adds PROG_TEST_RUN support to BPF_PROG_TYPE_KPROBE progs.
On top of being generally useful for unit testing kprobe progs, this
feature more specifically helps solve a relability problem with bpftrace
BEGIN and END probes.

BEGIN and END probes are run exactly once at the beginning and end of a
bpftrace tracing session, respectively. bpftrace currently implements
the probes by creating two dummy functions and attaching the BEGIN and
END progs, if defined, to those functions and calling the dummy
functions as appropriate. This works pretty well most of the time except
for when distros strip symbols from bpftrace. Every now and then this
happens and users get confused. Having PROG_TEST_RUN support will help
solve this issue by allowing us to directly trigger uprobes from
userspace.

Admittedly, this is a pretty specific problem and could probably be
solved other ways. However, PROG_TEST_RUN also makes unit testing more
convenient, especially as users start building more complex tracing
applications. So I see this as killing two birds with one stone.

Daniel Xu (2):
  bpf, test_run: Add PROG_TEST_RUN support to kprobe
  Add PROG_TEST_RUN selftest for BPF_PROG_TYPE_KPROBE

 include/linux/bpf.h                           | 10 ++++
 kernel/trace/bpf_trace.c                      |  1 +
 net/bpf/test_run.c                            | 36 ++++++++++++
 .../selftests/bpf/prog_tests/kprobe_ctx.c     | 57 +++++++++++++++++++
 .../testing/selftests/bpf/progs/kprobe_ctx.c  | 33 +++++++++++
 5 files changed, 137 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kprobe_ctx.c
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_ctx.c

-- 
2.36.1

