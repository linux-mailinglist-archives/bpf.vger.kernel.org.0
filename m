Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9B244EE76
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 22:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbhKLVVO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 16:21:14 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48829 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235757AbhKLVVN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Nov 2021 16:21:13 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A2A785C0279;
        Fri, 12 Nov 2021 16:18:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 12 Nov 2021 16:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=fIRWMwdKzJeyc
        z/KDiOpYPUx3KPnYCbztqg09wWSwTM=; b=yS8vunQCqRQD9MBbBfCrE3VLSQSY+
        SSvN8VjsSHLAdtGy0bcivbZ2RlyBqHrlr4QHxLhQMPvW6LlgUpa9bE24ypt4JI/7
        Q6H0JcpACQQjwzqW9y2tBW7EeM8RHPMrE8anYyXtyAnu6ejmS0ShvDpBgF951Lf4
        Ww239vhurTuYe5eK7ZoMDHw2JulBk5c7ByngjetXs1fczRzsI3/ZIsXeax3jaPd9
        dOw3183JWc23/aywHm3zjDGCE97P88ceKrm0pdRitJVHtELUarGfQyfPALOlRBvj
        7HYwxFHIeXQf/aN9mBAnNAqFgxzN9xWIWIZkFX5nRaUlgSaM41uRCXbsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=fIRWMwdKzJeycz/KDiOpYPUx3KPnYCbztqg09wWSwTM=; b=Ia7fP8gx
        TVGNfQHM4Wmp30NAsdk66SIT0CiyVWTMczkXOfEja2CvYaJkfX24zrXpFXnBkvDt
        pZakFoGBXmyqcOdE7xFEFsZwFO7/2yFMoS3uPkrv7KLr3E+4k+7+MG1P8cSuu76L
        cAXemPFb5hI9ts+0gYRdvcP4wrnY2wg/awnfRmADsWa0SnPKfO0OuMuZqE5G/CNf
        lfd6p68bJgBQMAr4ebtcfRe1hpMAUxrmx+WHyqxO4PcyxnozX9yHfdBIiXgsB/BD
        c73Gb+qAfu+fRD9G2nQxTCWvFkqwUT5zHIutp0+4jzFmKi1aftPCxzhnPU08r312
        hUkEVHX5lPveJA==
X-ME-Sender: <xms:HdqOYY-iYiDenbWEQxaGFCWIzACk2dP5Els1mVmmnzletUkH11PIPg>
    <xme:HdqOYQvN1Y1dpp5EBeh6iTJ55nbcxNvdNVEdObjsg_SMqfMREP1uJphUDCjZs4e52
    SmIds1i2_gt-1XBbg>
X-ME-Received: <xmr:HdqOYeCHxAEyqz5p0lOOWcwKzngCegOKCaG5uKAzBMqSrewyaIHlkbKmX4jbd5KNZKsW2Hf8iHlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvdefgddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepffgrvhgvucfvuhgtkhgvrhcuoegurghvvgesughtuhgtkhgv
    rhdrtghordhukheqnecuggftrfgrthhtvghrnhepudduiedtiedvffeugeeuveeluddtve
    fhtdevheelfeejleeflefggfehuddtvefhnecuffhomhgrihhnpehmrghnjedrohhrghdp
    khgvrhhnvghlrdhorhhgpdgtihhlihhumhdrihhopdhrvggrughthhgvughotghsrdhioh
    dpthhhihhsihhsughotghumhgvnhhtrghtihhonhhfohhrlhhisggsphhfrghushgvrhhs
    phgrtggvlhhisghrrghrhihfohhrlhhorgguihhnghgrnhguihhnthgvrhgrtghtihhngh
    ifihhthhgsphhfphhrohhgrhgrmhhsrdhfohhrrghpihguohgtuhhmvghnthgrthhiohhn
    shgvvghthhgvvhgvrhhsihhonhgvuggrphhiughotghumhgvnhhtrghtihhonhhsihhtvg
    hhthhtphhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepuggrvhgvseguthhutghkvghrrdgtohdruhhk
X-ME-Proxy: <xmx:HdqOYYeGJBpCjmye6pt-KJ7g0ValqssKbRIa_RxrGb5h8zBsqvuDrg>
    <xmx:HdqOYdNVIkVY7DQVgcBk4xUnSGrmxIYcLadfLuqUW1ykNEiBmnD1SQ>
    <xmx:HdqOYSm5JOKW_2RWkBQld-5mgHhZF6W8rZ2EZLCm4DAaKqKvltpvSQ>
    <xmx:HdqOYWgoJcUkCmN9-LeuAzfFEfHe5F8O6aaJN3jVNpqLH6TPM7tZyQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Nov 2021 16:18:21 -0500 (EST)
From:   Dave Tucker <dave@dtucker.co.uk>
To:     bpf@vger.kernel.org
Cc:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH bpf-next 3/3] docs: fix ordering of bpf documentation
Date:   Fri, 12 Nov 2021 21:17:24 +0000
Message-Id: <1a1eed800e7b9dc13b458de113a489641519b0cc.1636749493.git.dave@dtucker.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1636749493.git.dave@dtucker.co.uk>
References: <cover.1636749493.git.dave@dtucker.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit fixes the display of the BPF documentation in the sidebar
when rendered as HTML.

Before this patch, the sidebar would render as follows for some
sections:

| BPF Documentation
  |- BPF Type Format (BTF)
    |- BPF Type Format (BTF)

This was due to creating a heading in index.rst followed by
a sphinx toctree, where the file referenced carries the same
title as the section heading.

To fix this I applied a pattern that has been established in other
subfolders of Documentation:

1. Re-wrote index.rst to have a single toctree
2. Split the sections out in to their own files

Additionally maps.rst and programs.rst make use of a glob pattern to
include map_* or prog_* rst files in their toctree, meaning future map
or program type documentation will be automatically included.

Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
---
 Documentation/bpf/faq.rst          | 11 ++++
 Documentation/bpf/helpers.rst      |  7 +++
 Documentation/bpf/index.rst        | 97 ++++--------------------------
 Documentation/bpf/libbpf/index.rst |  4 +-
 Documentation/bpf/maps.rst         |  9 +++
 Documentation/bpf/other.rst        |  9 +++
 Documentation/bpf/programs.rst     |  9 +++
 Documentation/bpf/syscall_api.rst  | 11 ++++
 Documentation/bpf/test_debug.rst   |  9 +++
 9 files changed, 80 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/bpf/faq.rst
 create mode 100644 Documentation/bpf/helpers.rst
 create mode 100644 Documentation/bpf/maps.rst
 create mode 100644 Documentation/bpf/other.rst
 create mode 100644 Documentation/bpf/programs.rst
 create mode 100644 Documentation/bpf/syscall_api.rst
 create mode 100644 Documentation/bpf/test_debug.rst

diff --git a/Documentation/bpf/faq.rst b/Documentation/bpf/faq.rst
new file mode 100644
index 000000000000..a622602ce9ad
--- /dev/null
+++ b/Documentation/bpf/faq.rst
@@ -0,0 +1,11 @@
+================================
+Frequently asked questions (FAQ)
+================================
+
+Two sets of Questions and Answers (Q&A) are maintained.
+
+.. toctree::
+   :maxdepth: 1
+
+   bpf_design_QA
+   bpf_devel_QA
diff --git a/Documentation/bpf/helpers.rst b/Documentation/bpf/helpers.rst
new file mode 100644
index 000000000000..c4ee0cc20dec
--- /dev/null
+++ b/Documentation/bpf/helpers.rst
@@ -0,0 +1,7 @@
+Helper functions
+================
+
+* `bpf-helpers(7)`_ maintains a list of helpers available to eBPF programs.
+
+.. Links
+.. _bpf-helpers(7): https://man7.org/linux/man-pages/man7/bpf-helpers.7.html
\ No newline at end of file
diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index 37f273a7e8b6..413f50101eca 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -12,97 +12,26 @@ BPF instruction-set.
 The Cilium project also maintains a `BPF and XDP Reference Guide`_
 that goes into great technical depth about the BPF Architecture.
 
-libbpf
-======
-
-Documentation/bpf/libbpf/libbpf.rst is a userspace library for loading and interacting with bpf programs.
-
-BPF Type Format (BTF)
-=====================
-
 .. toctree::
    :maxdepth: 1
 
+   libbpf/index
    btf
-
-
-Frequently asked questions (FAQ)
-================================
-
-Two sets of Questions and Answers (Q&A) are maintained.
-
-.. toctree::
-   :maxdepth: 1
-
-   bpf_design_QA
-   bpf_devel_QA
-
-Syscall API
-===========
-
-The primary info for the bpf syscall is available in the `man-pages`_
-for `bpf(2)`_. For more information about the userspace API, see
-Documentation/userspace-api/ebpf/index.rst.
-
-Helper functions
-================
-
-* `bpf-helpers(7)`_ maintains a list of helpers available to eBPF programs.
-
-
-Program types
-=============
-
-.. toctree::
-   :maxdepth: 1
-
-   prog_cgroup_sockopt
-   prog_cgroup_sysctl
-   prog_flow_dissector
-   bpf_lsm
-   prog_sk_lookup
-
-
-Map types
-=========
-
-.. toctree::
-   :maxdepth: 1
-
-   map_cgroup_storage
-
-
-Testing and debugging BPF
-=========================
-
-.. toctree::
-   :maxdepth: 1
-
-   drgn
-   s390
-
-
-Licensing
-=========
-
-.. toctree::
-   :maxdepth: 1
-
+   faq
+   syscall_api
+   helpers
+   programs
+   maps
    bpf_licensing
+   test_debug
+   other
 
+.. only::  subproject and html
 
-Other
-=====
-
-.. toctree::
-   :maxdepth: 1
+   Indices
+   =======
 
-   ringbuf
-   llvm_reloc
+   * :ref:`genindex`
 
 .. Links:
-.. _networking-filter: ../networking/filter.rst
-.. _man-pages: https://www.kernel.org/doc/man-pages/
-.. _bpf(2): https://man7.org/linux/man-pages/man2/bpf.2.html
-.. _bpf-helpers(7): https://man7.org/linux/man-pages/man7/bpf-helpers.7.html
-.. _BPF and XDP Reference Guide: https://docs.cilium.io/en/latest/bpf/
+.. _BPF and XDP Reference Guide: https://docs.cilium.io/en/latest/bpf/
\ No newline at end of file
diff --git a/Documentation/bpf/libbpf/index.rst b/Documentation/bpf/libbpf/index.rst
index 4f8adfc3ab83..4e8c656b539a 100644
--- a/Documentation/bpf/libbpf/index.rst
+++ b/Documentation/bpf/libbpf/index.rst
@@ -3,8 +3,6 @@
 libbpf
 ======
 
-For API documentation see the `versioned API documentation site <https://libbpf.readthedocs.io/en/latest/api.html>`_.
-
 .. toctree::
    :maxdepth: 1
 
@@ -14,6 +12,8 @@ For API documentation see the `versioned API documentation site <https://libbpf.
 This is documentation for libbpf, a userspace library for loading and
 interacting with bpf programs.
 
+For API documentation see the `versioned API documentation site <https://libbpf.readthedocs.io/en/latest/api.html>`_.
+
 All general BPF questions, including kernel functionality, libbpf APIs and
 their application, should be sent to bpf@vger.kernel.org mailing list.
 You can `subscribe <http://vger.kernel.org/vger-lists.html#bpf>`_ to the
diff --git a/Documentation/bpf/maps.rst b/Documentation/bpf/maps.rst
new file mode 100644
index 000000000000..2084b0e7cde8
--- /dev/null
+++ b/Documentation/bpf/maps.rst
@@ -0,0 +1,9 @@
+=========
+Map Types
+=========
+
+.. toctree::
+   :maxdepth: 1
+   :glob:
+
+   map_*
\ No newline at end of file
diff --git a/Documentation/bpf/other.rst b/Documentation/bpf/other.rst
new file mode 100644
index 000000000000..3d61963403b4
--- /dev/null
+++ b/Documentation/bpf/other.rst
@@ -0,0 +1,9 @@
+=====
+Other
+=====
+
+.. toctree::
+   :maxdepth: 1
+
+   ringbuf
+   llvm_reloc
\ No newline at end of file
diff --git a/Documentation/bpf/programs.rst b/Documentation/bpf/programs.rst
new file mode 100644
index 000000000000..620eb667ac7a
--- /dev/null
+++ b/Documentation/bpf/programs.rst
@@ -0,0 +1,9 @@
+=============
+Program Types
+=============
+
+.. toctree::
+   :maxdepth: 1
+   :glob:
+
+   prog_*
diff --git a/Documentation/bpf/syscall_api.rst b/Documentation/bpf/syscall_api.rst
new file mode 100644
index 000000000000..f0a1dff087ad
--- /dev/null
+++ b/Documentation/bpf/syscall_api.rst
@@ -0,0 +1,11 @@
+===========
+Syscall API
+===========
+
+The primary info for the bpf syscall is available in the `man-pages`_
+for `bpf(2)`_. For more information about the userspace API, see
+Documentation/userspace-api/ebpf/index.rst.
+
+.. Links:
+.. _man-pages: https://www.kernel.org/doc/man-pages/
+.. _bpf(2): https://man7.org/linux/man-pages/man2/bpf.2.html
\ No newline at end of file
diff --git a/Documentation/bpf/test_debug.rst b/Documentation/bpf/test_debug.rst
new file mode 100644
index 000000000000..ebf0caceb6a6
--- /dev/null
+++ b/Documentation/bpf/test_debug.rst
@@ -0,0 +1,9 @@
+=========================
+Testing and debugging BPF
+=========================
+
+.. toctree::
+   :maxdepth: 1
+
+   drgn
+   s390
-- 
2.33.1

