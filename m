Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027862B539D
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 22:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgKPVRw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 16:17:52 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:35305 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726735AbgKPVRt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 16:17:49 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 35B50D05;
        Mon, 16 Nov 2020 16:17:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 16 Nov 2020 16:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=bI7+0n+mvNdYBFFyytXWs7i5PU
        CHOde+5ov5uwXFL7k=; b=m0qOIwIJXZidGxx0Mp8vuIA/REOXrKwkhn37qVDsum
        vQS1YupiiabxkBvRsg86kMnpmE9QV5R9C+AB/KquaJegGOSkUzkXrmNla+8W1eOh
        4+k6iA02/5vQ+WreGmBkoRbAUJj2GtvXhgyWxWs08GyylHCFTlFTrM3bfGSb/EPi
        sfS+iS751ZS3yTKA+RKMwAWn2HM7Q9828/2trZOl67bw9EFKHUUYLCKJLm7+aZzz
        xcpUTMwJNR53LsNLGP9Ja1Bsva87gmFHxfp6FV+aKgD9JVpW6NdAafnbSTMfd/PE
        X+53l+MlfomTITB4jp2xdArf/MNE0I1Y0csYjnCZcwVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=bI7+0n+mvNdYBFFyy
        tXWs7i5PUCHOde+5ov5uwXFL7k=; b=CS6/vLYdbVG0YQDrNXnWM69h3YTrShaCY
        nEgzlL01sPxL9PKSdzMwnw9w1YtCJSHtNjbsr07Tay6nT7Wom75O9XXMHmfvF1Gt
        yORDUuTI1zl2c+4QMswXTqPbOUDqD4jOVXgYBqzYxRiJy6poZiKrVvcLVH5qkh2f
        XSHM/csNQ4xQkcJTFdNbcLlB2qSbqpZxnXkNFRtdSfwHRgRfPNNEFzSGRf0U8v5Q
        Hzf2bGwRwb4jG3TGqhGXiAA3chwlCh+yIMRKPicfQicAAknOGhZ2w+GPXm1qUDVJ
        vlBZa9g+S9KyPWq0sVrlcu8khupjdsgsh5klta1hv4e6qpAfUBX5g==
X-ME-Sender: <xms:euyyXzZM7pZMiyEI4lEuYY-TZOwACh10XapxpIui4VAJmCG7mhBNuQ>
    <xme:euyyXyYTrbnaPRinm9PyTfRZlL2LovuqaPKJaJCh_AkU2vdfLBGgbaKpnDC09m4Iq
    V8I0iCCJmml6wxtYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefuddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepieffgfelvdffiedtleejvd
    etfeefiedvfeehieevveejudeiiefgteeiveeiffffnecukfhppeeiledrudekuddruddt
    hedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:euyyX1-jTSCnIqRf3uk9P5iw-i2ofTGhtDPdB0xhaqOnlixUcs892A>
    <xmx:euyyX5pVTcRjVcKDraozefy7B11IGu_AXJDmjw-yTO-Je4X_gY0_dw>
    <xmx:euyyX-qSEcKmLbVJrxwNY49NrkEoyu9m1zSMtizIavrWyLM5MjcsXg>
    <xmx:e-yyX_cq_6KI3eiisDDEoOcsLhAHWSNcIBilAiecK5_8gvl_fhF5sA>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id E98DF3280060;
        Mon, 16 Nov 2020 16:17:45 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        andrii.nakryiko@gmail.com, torvalds@linux-foundation.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH bpf v6 0/2] Fix bpf_probe_read_user_str() overcopying
Date:   Mon, 16 Nov 2020 13:17:30 -0800
Message-Id: <cover.1605560917.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.29.2
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

v5 -> v6:
* zero-pad up to sizeof(unsigned long) after NUL

v4 -> v5:
* don't read potentially uninitialized memory

v3 -> v4:
* directly pass userspace pointer to prog
* test more strings of different length

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

 lib/strncpy_from_user.c                       |  8 ++-
 .../bpf/prog_tests/probe_read_user_str.c      | 71 +++++++++++++++++++
 .../bpf/progs/test_probe_read_user_str.c      | 25 +++++++
 3 files changed, 102 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_probe_read_user_str.c

-- 
2.29.2

