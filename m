Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A184593E4
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 18:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbhKVRWr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 12:22:47 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:38243 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239943AbhKVRWr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Nov 2021 12:22:47 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 267082B01C1A;
        Mon, 22 Nov 2021 12:19:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 22 Nov 2021 12:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=k75e97xJOemZF9Q2EZ0aO8bMuU
        vrvUJCM9ymJuayhHU=; b=lBGinIY9st78c60dELP6M0yCsrLFt2khvMMOCiWMCR
        H1oALMA1ldnw0+BDwoPd+53R+lEPpAFeRJI+OLfNk2WLCC2WJhkgUR/eWR+/VZDz
        HY/FBZhfe9V7UmdD4iThmpOVnx74uFPlFhXs2JJh6kTI1gSkYAZ8A15ibpwKVYeO
        T+rvl+BjOhlUh+gCCnqpdh/0XzHdnxnBWm1Ndx1VyegGNIl5wBuR8OQhNQoqqyVM
        regp8WZ3852qj0PYe8OedyG+b+vQfZKgNBPH+pjNjX6PUCSNtp9zcuXzaDZeyxHd
        KrnqWIJdP+UiNoU+dXLo/03AzxOHd/Q2PCrJJJ4+PgvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=k75e97xJOemZF9Q2E
        Z0aO8bMuUvrvUJCM9ymJuayhHU=; b=lH/aZC6Jb239CE5wPURyc7fPm5IfFbt5E
        XdGzy60UXHNKPvVI+k3skjQ0xDLe8BelgmhrBhyb4W/sfSMlXXvOJZfoFGKAGMq5
        PSGZSSLBYcIVaG2SvwWkxxe/B4S4buJ6JYtfwpPiH76POJWEInvvRDP4NEKGLCji
        dNuLsxExT7Yyiit0fXU16N6OXm7iE6QLrnSx7HQqQOK0U9p7b3+oDlV40t9Dbjjp
        MvYO/LT5MJUrW0I4005xuamjNwFXIcv+YmE48tjAdgd8SSWoag6YoY9fKrgeeZQB
        l5g49D1Cg1sfYluMFbKe43lFc9/gmzkmy2SJZKghfmHYXY8E6GZNw==
X-ME-Sender: <xms:KtGbYdb20_EcDffvSYLzMFSXw-4ift6cwJk-fWc07g1u529vzdD0_g>
    <xme:KtGbYUZ5QtAt9-bxJg5RmINuElK4B9U-VMtcHjAkttgV_oLXFYai5rD9fgxOkCjcV
    JQGhRNemw3l-Qd3hg>
X-ME-Received: <xmr:KtGbYf_eKt0UzJ8auBOYe8B8Xzu_T6Xs6O1dOPez637ecoynp5uN6Pwm-wIX7MWN66IbOsAr3rhr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeggddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepffgrvhgvucfvuhgtkhgvrhcuoegurghvvgesughtuhgtkhgvrhdr
    tghordhukheqnecuggftrfgrthhtvghrnhepfedvtdeuleefhfeutdfgveefhfegvdekge
    dutedvgfeukeduheetgfehhfekuddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepuggrvhgvseguthhutghkvghrrdgtohdruhhk
X-ME-Proxy: <xmx:KtGbYbp4kalX4g0MgZWWj-TA-cYV-1QhYrVZ60H6NAH0yeiKcGbMtw>
    <xmx:KtGbYYpHI7ke0zjzZaBlJ5me4KW-Tab0SN0NVYNb_UgweAVY_6yp1g>
    <xmx:KtGbYRQOaqaLYGM7dEwhbG_IrWwoGxRCFP_SJKMVGmKJRepSTaJ7AA>
    <xmx:KtGbYf07PsLfPCo3Ax0UxES-lB7iXFG2y9hPbGj4O2qim6OXzdje45DVvCA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Nov 2021 12:19:37 -0500 (EST)
From:   Dave Tucker <dave@dtucker.co.uk>
To:     bpf@vger.kernel.org
Cc:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH bpf-next 0/2] bpf, docs: Document BPF_MAP_TYPE_ARRAY
Date:   Mon, 22 Nov 2021 17:19:30 +0000
Message-Id: <cover.1637601045.git.dave@dtucker.co.uk>
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

Dave Tucker (2):
  bpf, docs: add kernel version to map_cgroup_storage
  bpf, docs: document BPF_MAP_TYPE_ARRAY

 Documentation/bpf/map_array.rst          | 150 +++++++++++++++++++++++
 Documentation/bpf/map_cgroup_storage.rst |   2 +
 2 files changed, 152 insertions(+)
 create mode 100644 Documentation/bpf/map_array.rst

-- 
2.33.1

