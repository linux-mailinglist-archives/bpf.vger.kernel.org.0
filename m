Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC0144EE74
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 22:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbhKLVVO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 16:21:14 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45769 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235742AbhKLVVK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Nov 2021 16:21:10 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B61755C0281;
        Fri, 12 Nov 2021 16:18:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 12 Nov 2021 16:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Xjw24Epbvpnmw
        XQfWSQ4XDh3wmzOWsWHUx+m8uFJnSU=; b=Ah1lZHrudb/xUlIfsBAKMQJ2bXcmN
        HxRDS+8XHz+E/ebQCwKMvIPc1ItsHcBoLVjf/m+HEHsUmJm2XNBSOOTlcflXBaJI
        MjWJl1UHetLRLqciU5fW675Y1x+4ua26CsPXkM8gIwdTX8vAiyNvjmT3Sp2695nP
        PpBjL6ww8wR44QfYERP/EFqcLC9x11uDwSbqH+tCE2Uyg2YKnJKexVk14j15RPy2
        LXymWQZrXT9N43SDiHPKQZmjv72wIZ8WM/8f6PRqmjdT538eBAtjrvWOmhkGW3Ik
        bGj97HVdsKfo4Il1wbvm+NKgoewIT5yOEHa87xOutQPrSNuXdAPjSU+sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Xjw24EpbvpnmwXQfWSQ4XDh3wmzOWsWHUx+m8uFJnSU=; b=DIN1QjiR
        ps2g04eM2UXLST9MLrvepLOtvUySBxelu6soRGlWV/I06Wnukf4uDAnrOMVqi41f
        1vTjiBZ+GxDTuhgy5FtycEyRsddlkEtxsXi5OAF/c9nL8wq6Km2fnyc3u+cJcLDb
        TARjWXorjWppMDuuLlLcVV1Jq/sTqYowBiUHAAK288EXXFyJho1OmyscGOmvPu+x
        fUqmssMaok26eBvInEtVsVLdq4IW6XAJdDBzQv+rSRR0LfsaBLc7G5YuKBL0Hwwn
        HaBNGDeyMQWcb+t8gQfHNPsHNAWiHoq/28ZI1MJqqTx6eMKB9vYZoann2FdqBNyw
        G7JxczhG86B7mA==
X-ME-Sender: <xms:GtqOYearyj-oz8h-hOcA9hXgqFjXIte7n7q3dYAb0e9OcnBP7Gewtg>
    <xme:GtqOYRbxuXO6LZSkszk-6VCkISxSrHDm0ve47FZOr_nChNmD6sisXTbIX9uglXjRH
    uZcX7Q2lEM8E7bsRw>
X-ME-Received: <xmr:GtqOYY_CbaBPxlCPvBJ67perKWWIFdftpOHEEnMJ4IFQ_KGt3sBytimXD2g6AfYbBipA6LINyug2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvdefgddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepffgrvhgvucfvuhgtkhgvrhcuoegurghvvgesughtuhgtkhgv
    rhdrtghordhukheqnecuggftrfgrthhtvghrnhepvefgtdelhfehteevtdeuveekuedvtd
    eiieefffdtiefgveevudekuddvieeujefgnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepuggrvhgvseguthhutghkvghrrdgtohdruhhk
X-ME-Proxy: <xmx:GtqOYQq9P45PlLf2wFZsoHtD35olk6U6uLpHmJta3xJPspD-aJfb_A>
    <xmx:GtqOYZo9dgLm0ky2bjRKtugotEUTGjXDP45BK5nM8lmdJWfrnDugTQ>
    <xmx:GtqOYeQyjx4PsEqQEdc56yc1x1G3DKc1JWNTqdfQf2nj0f2ZYXHKuw>
    <xmx:GtqOYdds3pf0BssAuUTAngp0glAeLy5MCfljYmUcAmpM7V-Q3NZU3w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Nov 2021 16:18:17 -0500 (EST)
From:   Dave Tucker <dave@dtucker.co.uk>
To:     bpf@vger.kernel.org
Cc:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH bpf-next 1/3] docs: change underline in btf to match style guide
Date:   Fri, 12 Nov 2021 21:17:22 +0000
Message-Id: <981b27485cc294206480df36fca46817e2553e39.1636749493.git.dave@dtucker.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1636749493.git.dave@dtucker.co.uk>
References: <cover.1636749493.git.dave@dtucker.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This changes the type of underline used to follow the guidelines in
Documentation/doc-guide/sphinx.rst which also ensures that the headings
are rendered at the correct level in the HTML sidebar

Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
---
 Documentation/bpf/btf.rst | 44 +++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index d0ec40d00c28..1ebf4c5c7ddc 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -3,7 +3,7 @@ BPF Type Format (BTF)
 =====================
 
 1. Introduction
-***************
+===============
 
 BTF (BPF Type Format) is the metadata format which encodes the debug info
 related to BPF program/map. The name BTF was used initially to describe data
@@ -30,7 +30,7 @@ sections are discussed in details in :ref:`BTF_Type_String`.
 .. _BTF_Type_String:
 
 2. BTF Type and String Encoding
-*******************************
+===============================
 
 The file ``include/uapi/linux/btf.h`` provides high-level definition of how
 types/strings are encoded.
@@ -57,13 +57,13 @@ little-endian target. The ``btf_header`` is designed to be extensible with
 generated.
 
 2.1 String Encoding
-===================
+-------------------
 
 The first string in the string section must be a null string. The rest of
 string table is a concatenation of other null-terminated strings.
 
 2.2 Type Encoding
-=================
+-----------------
 
 The type id ``0`` is reserved for ``void`` type. The type section is parsed
 sequentially and type id is assigned to each recognized type starting from id
@@ -504,7 +504,7 @@ valid index (starting from 0) pointing to a member or an argument.
  * ``type``: the type with ``btf_type_tag`` attribute
 
 3. BTF Kernel API
-*****************
+=================
 
 The following bpf syscall command involves BTF:
    * BPF_BTF_LOAD: load a blob of BTF data into kernel
@@ -547,14 +547,14 @@ The workflow typically looks like:
 
 
 3.1 BPF_BTF_LOAD
-================
+----------------
 
 Load a blob of BTF data into kernel. A blob of data, described in
 :ref:`BTF_Type_String`, can be directly loaded into the kernel. A ``btf_fd``
 is returned to a userspace.
 
 3.2 BPF_MAP_CREATE
-==================
+------------------
 
 A map can be created with ``btf_fd`` and specified key/value type id.::
 
@@ -581,7 +581,7 @@ automatically.
 .. _BPF_Prog_Load:
 
 3.3 BPF_PROG_LOAD
-=================
+-----------------
 
 During prog_load, func_info and line_info can be passed to kernel with proper
 values for the following attributes:
@@ -631,7 +631,7 @@ For line_info, the line number and column number are defined as below:
     #define BPF_LINE_INFO_LINE_COL(line_col)        ((line_col) & 0x3ff)
 
 3.4 BPF_{PROG,MAP}_GET_NEXT_ID
-==============================
+------------------------------
 
 In kernel, every loaded program, map or btf has a unique id. The id won't
 change during the lifetime of a program, map, or btf.
@@ -641,13 +641,13 @@ each command, to user space, for bpf program or maps, respectively, so an
 inspection tool can inspect all programs and maps.
 
 3.5 BPF_{PROG,MAP}_GET_FD_BY_ID
-===============================
+-------------------------------
 
 An introspection tool cannot use id to get details about program or maps.
 A file descriptor needs to be obtained first for reference-counting purpose.
 
 3.6 BPF_OBJ_GET_INFO_BY_FD
-==========================
+--------------------------
 
 Once a program/map fd is acquired, an introspection tool can get the detailed
 information from kernel about this fd, some of which are BTF-related. For
@@ -656,7 +656,7 @@ example, ``bpf_map_info`` returns ``btf_id`` and key/value type ids.
 bpf byte codes, and jited_line_info.
 
 3.7 BPF_BTF_GET_FD_BY_ID
-========================
+------------------------
 
 With ``btf_id`` obtained in ``bpf_map_info`` and ``bpf_prog_info``, bpf
 syscall command BPF_BTF_GET_FD_BY_ID can retrieve a btf fd. Then, with
@@ -668,10 +668,10 @@ tool has full btf knowledge and is able to pretty print map key/values, dump
 func signatures and line info, along with byte/jit codes.
 
 4. ELF File Format Interface
-****************************
+============================
 
 4.1 .BTF section
-================
+----------------
 
 The .BTF section contains type and string data. The format of this section is
 same as the one describe in :ref:`BTF_Type_String`.
@@ -679,7 +679,7 @@ same as the one describe in :ref:`BTF_Type_String`.
 .. _BTF_Ext_Section:
 
 4.2 .BTF.ext section
-====================
+--------------------
 
 The .BTF.ext section encodes func_info and line_info which needs loader
 manipulation before loading into the kernel.
@@ -743,7 +743,7 @@ bpf_insn``. For ELF API, the ``insn_off`` is the byte offset from the
 beginning of section (``btf_ext_info_sec->sec_name_off``).
 
 4.2 .BTF_ids section
-====================
+--------------------
 
 The .BTF_ids section encodes BTF ID values that are used within the kernel.
 
@@ -804,10 +804,10 @@ All the BTF ID lists and sets are compiled in the .BTF_ids section and
 resolved during the linking phase of kernel build by ``resolve_btfids`` tool.
 
 5. Using BTF
-************
+============
 
 5.1 bpftool map pretty print
-============================
+----------------------------
 
 With BTF, the map key/value can be printed based on fields rather than simply
 raw bytes. This is especially valuable for large structure or if your data
@@ -849,7 +849,7 @@ bpftool is able to pretty print like below:
       ]
 
 5.2 bpftool prog dump
-=====================
+---------------------
 
 The following is an example showing how func_info and line_info can help prog
 dump with better kernel symbol names, function prototypes and line
@@ -883,7 +883,7 @@ information.::
     [...]
 
 5.3 Verifier Log
-================
+----------------
 
 The following is an example of how line_info can help debugging verification
 failure.::
@@ -909,7 +909,7 @@ failure.::
         R2 offset is outside of the packet
 
 6. BTF Generation
-*****************
+=================
 
 You need latest pahole
 
@@ -1016,6 +1016,6 @@ format.::
             .long   8206                    # Line 8 Col 14
 
 7. Testing
-**********
+==========
 
 Kernel bpf selftest `test_btf.c` provides extensive set of BTF-related tests.
-- 
2.33.1

