Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B843CE99F
	for <lists+bpf@lfdr.de>; Mon, 19 Jul 2021 19:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243490AbhGSQ6P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 12:58:15 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46469 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344158AbhGSQ4C (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 19 Jul 2021 12:56:02 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id F2EEA5C012E;
        Mon, 19 Jul 2021 13:36:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 19 Jul 2021 13:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Ff0N7MQMpJ3IqLnMJ
        lmOtWrckyck9X4BlpDuedgpkeQ=; b=dcR0195r7Wnsfx6D8C5wHyJXoVobfz8Kg
        O6Bdm1ruzZnDFfKnanzc/5GNPX3PiPicnPEgUeuPyrqBfv68igdmo5cjy6t/sJKJ
        AcnH9rAWstPQ7sbdmliFZz0exwHsf/0WXD8xSS7HvLBi6IGNY6LcmAX8gRKgG0E/
        cxnoi4DhjV+hYIN9DD+2C8zzRG/e1hjUlYhJtbEnu3lsKa6SPwXjGlACa+knC+ek
        WG4y5AOHfkRefMsKE8T8FgZVpdz39XmKGUgyW/CWv8vKf5fY2/jOxttn6OG6TBo9
        8hpYWz1TZgQ13WGEfZ6SrX1V76R3vHwv7F2gqYN6lAgDiN7y99u6Q==
X-ME-Sender: <xms:KLj1YHrRFLOv1mhDMnmZVwj9kcwTYVQzp3aiTKhI-8wohbsbRm0uPQ>
    <xme:KLj1YBrpfiQ4W8uJ4MWoBdrlvafA9ifKI_vut6BQfgOj7cU0BcXCn_gjdeaN8-Wab
    H_bxDuh2tbyfVxLXno>
X-ME-Received: <xmr:KLj1YEP0zvbHWstj-wxzn_2Va40XyGhFjoujHZ5Ofhxemztz4bhJtEf_Pp154GkzFlIgyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedtgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepofgrrhhthihnrghsucfruhhmphhuthhishcuoehmsehlrghmsggu
    rgdrlhhtqeenucggtffrrghtthgvrhhnpeekudehtdegieeijeegffeuieehveegjeeigf
    ekudejiefgtdehtdevhfevfeegvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmheslhgrmh
    gsuggrrdhlth
X-ME-Proxy: <xmx:KLj1YK6eOZIJqvFzyG0tblCdMn9iRr3TWvdjdDnFCyUoTmvK2W3YyA>
    <xmx:KLj1YG6oxG982Xt4ayEfL9BwOW0FTNrNdiKZCWSjaJwlE_2gG1NZ6g>
    <xmx:KLj1YCgnXXA06lcHp6wWWrMBJaHLazg_NwKAfRlrd8LeKuQWP4PIsg>
    <xmx:KLj1YGEVp_N6NZ5lmiI3DLkIo03UvttwYPd4B57ZtlUekmUXIQ4ofg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jul 2021 13:36:38 -0400 (EDT)
From:   Martynas Pumputis <m@lambda.lt>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        m@lambda.lt
Subject: [PATCH v2 bpf 0/2] libbpf: fix inner map removal in bpf_object__create_map
Date:   Mon, 19 Jul 2021 19:38:36 +0200
Message-Id: <20210719173838.423148-1-m@lambda.lt>
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

 tools/lib/bpf/libbpf.c                        | 11 ++--
 .../bpf/progs/test_map_in_map_invalid.c       | 26 ++++++++
 tools/testing/selftests/bpf/test_maps.c       | 64 ++++++++++++++++++-
 3 files changed, 95 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c

-- 
2.32.0

