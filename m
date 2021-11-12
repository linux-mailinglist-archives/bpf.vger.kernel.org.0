Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8477A44EE70
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 22:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhKLVVF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 16:21:05 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52943 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235706AbhKLVVE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Nov 2021 16:21:04 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D3B955C02AF;
        Fri, 12 Nov 2021 16:18:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 12 Nov 2021 16:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=+CRPAJdAc3bRjhgjv3UnsZhqxv
        /TCIhH9BX7uofsml4=; b=yqZiOU6Ez+vZYcJ1DhEHJ+O6IuC2xEOQQgj4nDOQnG
        rIOINW3BqXoUQ7Yae+k9LEho7N5+UG3kLrVag5pfbeh/NHOWdboNWo9MxHrAZVyo
        4iEEBSH+l36yPZixenJcXY4aF5wlbIqlYp8zZPEeM5smXAnFMcxZ1Etdogk8Djbe
        JAu3fpFQ1kuf5u0fsVc1k+evVe/mhSFd4ILscjZ1pHbDRK7+zBgNIAb+2UNsb68H
        1RyG9PE/gt5LhnEmTkt+Tjo1cvZ59kSheVfx4bs9fGx9lN5zcoGQBHtL7YHFYug6
        P4xJ3nSlE0JCxZsXZqesnq3NNyhZYJ4s8OM/v83BvuEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+CRPAJdAc3bRjhgjv
        3UnsZhqxv/TCIhH9BX7uofsml4=; b=kES2smRf3C0TNqWNf9jCsOiztlAxtLvVa
        cIcRxAG16jafkec5raqjeoKFNrI7oXg6Cx1IisfUs5/joQ/hLy2Xt1nwTM14XjG6
        9AkXPzaVKI/lJCUzElvMpbAeQ+xPig0wMVOIAFf87RrXDl/QzQZFoSZc4QohhDCm
        DKDwTBETL+9jHMa9iIzQBVggTlfkn6qRu5lzrPSpgJFNAY/BeqjcK/m0NCHw5emh
        cv1WCpzPQmFGJZLS9qe4WrGYj1vd+XDb4TuQhktit5qa1JpkREtbgzsL4b9/ARbv
        AztvGh+RKEaS0i2EVs91UNwZl2dHJIDI6ExVu7qkzE2YcXlwH2ZBw==
X-ME-Sender: <xms:FNqOYa7r91hRXyp7u1nWRBVb-Q_iHv5ERKKoG_K6_FeIWfljaQLwbQ>
    <xme:FNqOYT7Jqw_t_zNkI7CFJzJwj1RkLmfKVSshLdJIGPjuJuDhsITXBW4yo3t7lOKa1
    LLa1SkAXbwJNssu6g>
X-ME-Received: <xmr:FNqOYZe7ekNW5vayvzUbf-VdI0wlfSBwFgCER8XJjQllloIHI4LnVtQEgMukrcPykKuFFESuJRsF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvdefgddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepffgrvhgvucfvuhgtkhgvrhcuoegurghvvgesughtuhgtkhgvrhdr
    tghordhukheqnecuggftrfgrthhtvghrnhepfedvtdeuleefhfeutdfgveefhfegvdekge
    dutedvgfeukeduheetgfehhfekuddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepuggrvhgvseguthhutghkvghrrdgtohdruhhk
X-ME-Proxy: <xmx:FNqOYXL14iX12dN_Qvf73-WWH_gwnMtXLNn7wCQwTdYPa9fhR8FoTA>
    <xmx:FNqOYeKxgmeJ7tJb0lhwaZ0bYeqcQPZhyG-d4cLS0rXr66ddVTJ9Mw>
    <xmx:FNqOYYxltfc_Ae4R_hfcg7C4wTF-zTcVpGunj4tvuN_hpsAtVp0-Cg>
    <xmx:FNqOYd-3u--geE2XPG7aWVqmUad5Kj2LWPQlBZahQVHudwyvoyvcMQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Nov 2021 16:18:11 -0500 (EST)
From:   Dave Tucker <dave@dtucker.co.uk>
To:     bpf@vger.kernel.org
Cc:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH bpf-next 0/3] Fix Navigation Issues in Docs
Date:   Fri, 12 Nov 2021 21:17:21 +0000
Message-Id: <cover.1636749493.git.dave@dtucker.co.uk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set fixes a couple of documentation issues that was causing
some strange behaviour when the sidebar was rendered in the HTML docs.

1. The underlines in the BTF document weren't following the docs
guidelines, which I believe caused an issue rendering the TOC with my
other patches applied
2. Mixing the Sphix toctree with named sections was causing name stutter
in the sidebar navigation. For example:

  | BPF Type Format
    | - BPF Type Format
3. The libbpf API documentation wasn't referenced in a toctree

It also renames bpf_lsm.rst to prog_lsm.rst such that documentation for
program types can be included in the toctree via glob for prog_*

Dave Tucker (3):
  docs: change underline in btf to match style guide
  docs: Rename bpf_lsm.rst to prog_lsm.rst
  docs: fix ordering of bpf documentation

 Documentation/bpf/btf.rst                     | 44 ++++-----
 Documentation/bpf/faq.rst                     | 11 +++
 Documentation/bpf/helpers.rst                 |  7 ++
 Documentation/bpf/index.rst                   | 97 +++----------------
 Documentation/bpf/libbpf/index.rst            |  4 +-
 Documentation/bpf/maps.rst                    |  9 ++
 Documentation/bpf/other.rst                   |  9 ++
 .../bpf/{bpf_lsm.rst => prog_lsm.rst}         |  0
 Documentation/bpf/programs.rst                |  9 ++
 Documentation/bpf/syscall_api.rst             | 11 +++
 Documentation/bpf/test_debug.rst              |  9 ++
 MAINTAINERS                                   |  2 +-
 12 files changed, 103 insertions(+), 109 deletions(-)
 create mode 100644 Documentation/bpf/faq.rst
 create mode 100644 Documentation/bpf/helpers.rst
 create mode 100644 Documentation/bpf/maps.rst
 create mode 100644 Documentation/bpf/other.rst
 rename Documentation/bpf/{bpf_lsm.rst => prog_lsm.rst} (100%)
 create mode 100644 Documentation/bpf/programs.rst
 create mode 100644 Documentation/bpf/syscall_api.rst
 create mode 100644 Documentation/bpf/test_debug.rst

-- 
2.33.1

