Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BFC3C8909
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 18:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhGNQz0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 12:55:26 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38779 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229617AbhGNQzZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Jul 2021 12:55:25 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 1B3E25C0085;
        Wed, 14 Jul 2021 12:52:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 14 Jul 2021 12:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=WQkid/bagTG63j635
        23iTPfwy44fvlX2HogWXyYuSBs=; b=haveMH+2JrmZmrg76mexWknv29Fi4RLKC
        hlUXOJZNP+fGjosRym9dg886nLDJuICv+C6qMT+w2bB7IHd+tLy+aGzL/6Yp94e3
        AjU/BfSNrqpH3RY9JHiYSQ4plNNxfozfbzVnZgJZ51lkICjYUWP5QH14JwoxV9+x
        iMi463qxHs7g2CWTgvKYDrJkZGNT+0TQGOmZlmOgucqYxDoLEslzn0cdVD55lrkC
        NLVCPYQnHFq2UHCuoQFPIo71RXQuih16aC1HHVRFbgMPmp1Mmn/28hCOePg4Y86y
        EWzmYheOdgsXoJ9SDpx2D2g16FjqJQoYwg/LNqvSxLPSygxAmLw3w==
X-ME-Sender: <xms:TxbvYIxxIhbdtmPZpdcNorR2kB-YMk4FScNDJcPD8CGraNynz1epIw>
    <xme:TxbvYMQ8tLuIbNDGAJwRkc3_mflVnWOOfLMm7RtoeC6IdulPRQSRWdYB389yrLKXF
    3jz6AIznMB84m17alg>
X-ME-Received: <xmr:TxbvYKVPZs6Uoy8dJsTKT-Kou683E71JbsWBfzt0hJzm5fNReXcbZ39K5P_hupQHsVVKyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepofgrrhhthihnrghsucfruhhmphhuthhishcuoehmsehlrghmsggu
    rgdrlhhtqeenucggtffrrghtthgvrhhnpeekudehtdegieeijeegffeuieehveegjeeigf
    ekudejiefgtdehtdevhfevfeegvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmheslhgrmh
    gsuggrrdhlth
X-ME-Proxy: <xmx:TxbvYGiTHZR_-L6rTQ8_c7474BJikrfqfPh0KDjFsRcsz5HPOMtpUQ>
    <xmx:TxbvYKD3KvObLgksnRPOKXUztFWkF6ovOQd3s1RhzLpIZ3Luu4e57w>
    <xmx:TxbvYHLLK6x_kMmBnv1Ql5ZDdxJ6APC6YROwdBMm4_jRnJqICLfcuA>
    <xmx:URbvYNNYQe-iLbtfuP7gh6-WgdRwmVtVzHSr6_JZ8XJrXjn-EdxqAw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jul 2021 12:52:30 -0400 (EDT)
From:   Martynas Pumputis <m@lambda.lt>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        m@lambda.lt
Subject: [PATCH bpf 0/2] libbpf: fix inner map removal in bpf_object__create_map
Date:   Wed, 14 Jul 2021 18:54:38 +0200
Message-Id: <20210714165440.472566-1-m@lambda.lt>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set fixes the removal of a BTF-defined inner map if the
creation of the outer map has failed. This was identified by Andrii
in [1].

[1]: https://lore.kernel.org/bpf/CAEf4BzYaQsD6NaEUij6ttDeKYP7oEB0=c0D9_xdAKw6FYb7h1g@mail.gmail.com/

Martynas Pumputis (2):
  libbpf: fix removal of inner map in bpf_object__create_map
  selftests/bpf: check inner map deletion

 tools/lib/bpf/libbpf.c                        |  5 +-
 .../bpf/progs/test_map_in_map_invalid.c       | 27 +++++++++
 tools/testing/selftests/bpf/test_maps.c       | 58 ++++++++++++++++++-
 3 files changed, 87 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c

-- 
2.32.0

