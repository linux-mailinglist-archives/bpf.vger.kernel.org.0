Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653922A8735
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 20:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbgKETaB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 14:30:01 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52197 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbgKETaA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 14:30:00 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D7EC55C0194;
        Thu,  5 Nov 2020 14:29:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 05 Nov 2020 14:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=/EbwIVqAd4S4jxZr8erVVHn5BX
        H6AogaRJ+OMfzsmRw=; b=L0XhRdyVJWhvyKg23AtwxYQdTHm8RNigjpZXyE6IEj
        hykLHdDuqqRVxwB33qEu2+W555OE4bktMCSVaiKm2wGhS+vA7lN1LIBzwdwcpC5R
        S13/OeHEi/4ZVfZVZj+bRvYDLAi459RldX5v7dljYYoSAHnCquoxx/O560AqmfVa
        M+WlrwMzw3+4RrkSFnARNhnROvdNcDzbwu5l/w5eWNMeGZx3G1F4tZzeRatxU8c5
        Pp0B8+p3DbUoJzg5Ugv4Q5mSC/7bj+SnCWzhZ11Ck20H0MxhfiiobsoQ59wStilq
        FdW5EXw9XUfTnOHKUH11s/nbD4JWLVjY97peKnqi9Qkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/EbwIVqAd4S4jxZr8
        erVVHn5BXH6AogaRJ+OMfzsmRw=; b=HipFs0T33qLV23+ExL2BrYLKuCJUesOG2
        hVQNePfDW3gL8jyTbOCJGSY6/ohIOG9SdPBiE6kSCxHaPcc4opCMN32IVUGL0rfr
        ArF6lkMJarBAcFsUR8gHVNR7skyPX9MBtIE2DoV8iip345u368G07csH71ayDyp2
        ILD9mK1tPsrfcEc2dhf6MMfzdbFRGrT2aTT9ifbztfHjdVCdlO9oq8zsd+Qizlb9
        /vYCNJLKV0YC2LeuTmpv3U12QteKW/mDeMDhjVJ+yVGEB6il55jhMDs+RgDK4NxZ
        uRq25GghE5l+pziobYSpRuTCmWWWfh76WHSi04zO1pzyKvTo4Ei5w==
X-ME-Sender: <xms:tlKkX0JEZMMLy7jO5h3QcM-8smYvWt9Cb0naoTHL2z0ygOPqBHESFg>
    <xme:tlKkX0J40rfiFkWdeJxbnOuS8NdcStJu7YxQ91leW8PkBrKB6XaldN_O5_9rgJsfE
    2INbc9olcZPnsWxhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepieffgfelvdffiedtleejvd
    etfeefiedvfeehieevveejudeiiefgteeiveeiffffnecukfhppeeiledrudekuddruddt
    hedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:tlKkX0vY4GwBlWMMi23km_EVkCoFAMH98RXMC0abmuZGNUl8pwhwyA>
    <xmx:tlKkXxbmFhI9-6sxLeSrtqjR4CrUD-VMWEI8E18wjKPsPaEQHV4T0A>
    <xmx:tlKkX7Z_A7PSGK51dMYQZDYzZWsMR7OZb5vEfK-TPlaB4xV3GXDM6g>
    <xmx:tlKkX6XFMBeOhYWDrLgM5NvwCoCZQuuFqBWea7G79h9B3A0GdMQMDQ>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6900A3280391;
        Thu,  5 Nov 2020 14:29:57 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH bpf v3 0/2] Fix bpf_probe_read_user_str() overcopying
Date:   Thu,  5 Nov 2020 11:29:20 -0800
Message-Id: <cover.1604604240.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.28.0
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
 .../bpf/prog_tests/probe_read_user_str.c      | 60 +++++++++++++++++++
 .../bpf/progs/test_probe_read_user_str.c      | 34 +++++++++++
 3 files changed, 101 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_probe_read_user_str.c

-- 
2.28.0

