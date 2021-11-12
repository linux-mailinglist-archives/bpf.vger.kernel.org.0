Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A1644EE75
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 22:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbhKLVVO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 16:21:14 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56637 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235720AbhKLVVL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Nov 2021 16:21:11 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2CEC45C0103;
        Fri, 12 Nov 2021 16:18:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 12 Nov 2021 16:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=zhsxRFYx12PVn
        PzhB8XDhZMWRq7Rlfgl+sFJ+LaEwls=; b=Z6wGvVq8dlQIqM9nVliPqfi5hr8Wt
        cgNyncVjfDiCp+8029S6mIzc0SVZI1ibyjRdcjMWicFVqQISB/xJRohEtodh230s
        LlfLf8arvpyaAK1B+zw3T6ClR+qqC/Sd4VmWLz+muM59AEe42OF+LcEaZkAtu5LJ
        V991zc2tV3MksyDMxCjWUfZDqvEfzV+wkaj9duuUa3Amedx1OXQALqR40FrfwwYu
        W5P3+FbdZAFee9mcQK4NuMYFu3ML9xe2fD40Z2oglh1EN1c6ucGE1OyVERHX4MFK
        oII2V5+qFh/crByRBYb2ZrZ5EZeu9Qp74dO2hgtrgsnFSJiA78NScfjkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=zhsxRFYx12PVnPzhB8XDhZMWRq7Rlfgl+sFJ+LaEwls=; b=BeApdezt
        OEb4zKL7Z0ZS/gDKWuH4GUfNIb1qrOYylinhVGcE+mCNf06rivIEO2Oi6KmXKgXR
        dgqLb5lOEw8dAlwer8OSDMPbQoY68nVP1qwXkJk6VSat7lBW1qM3AMptxHgw9vWt
        R91F+q619Thdt1VRFu/tA4NrIAqCh3yqjy3kcX+oBjDengziftIOPPYAPuuWdEWf
        FKVNEhMiOh4WV3b5ik3Ba/RJ25R0rHDSOLIkbmfnUbwBbH+t8QV9XmzNdH0UoM/N
        VUVJB7f/DGyMNwRhAHwNjxnDeSvT68Z4xmdBGnFjtvz4aNNynDc7D8VYsUGZltJo
        zxhsMdrY7G99SA==
X-ME-Sender: <xms:HNqOYUds-sePBbKIM4yGW-5hMxAkt6K-Wr3xR7nIF9QP431_jyr4SA>
    <xme:HNqOYWMAUs4b6Ky00kNAStVszfTBIRp7G3bSyKVebotaM_wzDPFEr8vK-TgCSDTVC
    KqieBDRPQuuTQXlXA>
X-ME-Received: <xmr:HNqOYVh057ENnInPgfpTemdTDqdf4hR4maY90yxOhjLbn392CRQBuEZ59wz6MTcPaM4G57gE4dI5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvdefgddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepffgrvhgvucfvuhgtkhgvrhcuoegurghvvgesughtuhgtkhgv
    rhdrtghordhukheqnecuggftrfgrthhtvghrnhepvefgtdelhfehteevtdeuveekuedvtd
    eiieefffdtiefgveevudekuddvieeujefgnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepuggrvhgvseguthhutghkvghrrdgtohdruhhk
X-ME-Proxy: <xmx:HNqOYZ8FF4ivf2FJpPMbs3s7bOWSi1-dK-DJ-sDtki-ehfQFoAKwTw>
    <xmx:HNqOYQsDsu2jD57yBP_wuQlbhsPGDcO2M8YIYT-jvhmg-iNeIOHrxA>
    <xmx:HNqOYQHKkfxXToLK32kGX9PJKG0ZcTkmTIHwCZyyIG3Btut1o4KSqA>
    <xmx:HNqOYeAiPOrUkiBFcRf6x2Le3XPLG91KBilzyzYvZEUxEzeonXfsTA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Nov 2021 16:18:19 -0500 (EST)
From:   Dave Tucker <dave@dtucker.co.uk>
To:     bpf@vger.kernel.org
Cc:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH bpf-next 2/3] docs: Rename bpf_lsm.rst to prog_lsm.rst
Date:   Fri, 12 Nov 2021 21:17:23 +0000
Message-Id: <49fe0f370a2b28500c1b60f1fdb6fb7ec90de28a.1636749493.git.dave@dtucker.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1636749493.git.dave@dtucker.co.uk>
References: <cover.1636749493.git.dave@dtucker.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This allows for documentation relating to BPF Program Types to be
matched by the glob pattern prog_* for inclusion in a sphinx toctree

Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
---
 Documentation/bpf/{bpf_lsm.rst => prog_lsm.rst} | 0
 MAINTAINERS                                     | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/bpf/{bpf_lsm.rst => prog_lsm.rst} (100%)

diff --git a/Documentation/bpf/bpf_lsm.rst b/Documentation/bpf/prog_lsm.rst
similarity index 100%
rename from Documentation/bpf/bpf_lsm.rst
rename to Documentation/bpf/prog_lsm.rst
diff --git a/MAINTAINERS b/MAINTAINERS
index f96aa662ee32..bd690d1ba272 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3529,7 +3529,7 @@ R:	Florent Revest <revest@chromium.org>
 R:	Brendan Jackman <jackmanb@chromium.org>
 L:	bpf@vger.kernel.org
 S:	Maintained
-F:	Documentation/bpf/bpf_lsm.rst
+F:	Documentation/bpf/prog_lsm.rst
 F:	include/linux/bpf_lsm.h
 F:	kernel/bpf/bpf_lsm.c
 F:	security/bpf/
-- 
2.33.1

