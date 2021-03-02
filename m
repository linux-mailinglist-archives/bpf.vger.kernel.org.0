Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C36332B33D
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352501AbhCCDuX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349773AbhCBRga (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 12:36:30 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D7EC061A86
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 09:20:38 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id o10so14272455pgg.4
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 09:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLtlvyaPh/9T56HasU+WSMU0kz49t2tHiOoZMMkTowk=;
        b=KOb5TwQX9FBBkprFm/htpAAUQeFnhX03SiYO3cltYiXu02VFt63RgxKdA9dChGxLGX
         qDVRO5bziB1NphRiYWyi3eMF/ZalwYDjRmsaH6hAGJ0rl3xFIsgYa/80AUz87nqvIpV/
         01gOYgYOIRFJ6kl7Enk49pmHzXMuHoLOG1Un8ijL5vAQcgRIsDJ26DcXkAQA8NeU7GFy
         DrlesMGqoPqYOrrfOexGmVun8Gaw2OAFkTyFABjQYYptNSuN8adrxa2gLG3BG/BTr5/k
         jmLpgnI8NHNsvE3Xzy9rqdhhUshdief1DM9qMfW7tnq0AoGTwi5/x8/DLGHaEbHxhoXU
         2D0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLtlvyaPh/9T56HasU+WSMU0kz49t2tHiOoZMMkTowk=;
        b=SXRFKHQCcfrrymoGLvT+VyszlOqupE3V2BsbiS5XLUS+CKZQG0VY+cgfPpRGci1AgH
         VXX+OTEhHOSgJ7iDeUQ3dmfkzvHRVIIXiSB5uNPrSrmLztygdcJR5tjRW6v+2RydzEZ4
         ajInLFzCWPNXdDPMY1J4CRflwUeIoU0zZJrsXgDrn1yIeE2078MyNqzfKxI4XLfW/9+m
         zalCEyFQXhtSNcD5AdweTimtBA305x01HTYtZ2Jjtm7tPfHAt4aYKgqp0X3dH2rqjCQN
         +iX4HOZd7aWL05HxQ+SS6dT7z18L5PR128qYojgEH0V56TetTxa/jvihykeJ8MWyAhUe
         5BwA==
X-Gm-Message-State: AOAM532Ev+y0WMD+7ZrFY5KFJHFhFfRqIlQk+l1vPEDmz3Bv6ccFUN26
        CYucVEkPe5H2QdzOXMBQS6qTFiFXWMzL+5wa
X-Google-Smtp-Source: ABdhPJz3kypQd3bHxFkEeV/1MTPv662VAv9XKyEsN2c3ppcIx1ZRCI7lLCQahJF6lnqjjaciXNJYsg==
X-Received: by 2002:aa7:8057:0:b029:1ee:6534:2a95 with SMTP id y23-20020aa780570000b02901ee65342a95mr4094571pfm.57.1614705637437;
        Tue, 02 Mar 2021 09:20:37 -0800 (PST)
Received: from localhost.localdomain (c-73-93-5-123.hsd1.ca.comcast.net. [73.93.5.123])
        by smtp.gmail.com with ESMTPSA id b15sm20073923pgg.85.2021.03.02.09.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 09:20:37 -0800 (PST)
From:   Joe Stringer <joe@cilium.io>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, ast@kernel.org, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCHv2 bpf-next 04/15] bpf: Document BPF_PROG_PIN syscall command
Date:   Tue,  2 Mar 2021 09:19:36 -0800
Message-Id: <20210302171947.2268128-5-joe@cilium.io>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210302171947.2268128-1-joe@cilium.io>
References: <20210302171947.2268128-1-joe@cilium.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit b2197755b263 ("bpf: add support for persistent maps/progs")
contains the original implementation and git logs, used as reference for
this documentation.

Also pull in the filename restriction as documented in commit 6d8cb045cde6
("bpf: comment why dots in filenames under BPF virtual FS are not allowed")

Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Joe Stringer <joe@cilium.io>
---
CC: Daniel Borkmann <daniel@iogearbox.net>
---
 include/uapi/linux/bpf.h | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index eb9f059f0569..6946dde90c56 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -219,6 +219,22 @@ union bpf_iter_link_info {
  *		Pin an eBPF program or map referred by the specified *bpf_fd*
  *		to the provided *pathname* on the filesystem.
  *
+ *		The *pathname* argument must not contain a dot (".").
+ *
+ *		On success, *pathname* retains a reference to the eBPF object,
+ *		preventing deallocation of the object when the original
+ *		*bpf_fd* is closed. This allow the eBPF object to live beyond
+ *		**close**\ (\ *bpf_fd*\ ), and hence the lifetime of the parent
+ *		process.
+ *
+ *		Applying **unlink**\ (2) or similar calls to the *pathname*
+ *		unpins the object from the filesystem, removing the reference.
+ *		If no other file descriptors or filesystem nodes refer to the
+ *		same object, it will be deallocated (see NOTES).
+ *
+ *		The filesystem type for the parent directory of *pathname* must
+ *		be **BPF_FS_MAGIC**.
+ *
  *	Return
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
@@ -584,13 +600,19 @@ union bpf_iter_link_info {
  *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
- *	For example, after **fork**\ (2), the child inherits file descriptors
- *	referring to the same eBPF objects. In addition, file descriptors
- *	referring to eBPF objects can be transferred over UNIX domain sockets.
- *	File descriptors referring to eBPF objects can be duplicated in the
- *	usual way, using **dup**\ (2) and similar calls. An eBPF object is
- *	deallocated only after all file descriptors referring to the object
- *	have been closed.
+ *
+ *	* After **fork**\ (2), the child inherits file descriptors
+ *	  referring to the same eBPF objects.
+ *	* File descriptors referring to eBPF objects can be transferred over
+ *	  **unix**\ (7) domain sockets.
+ *	* File descriptors referring to eBPF objects can be duplicated in the
+ *	  usual way, using **dup**\ (2) and similar calls.
+ *	* File descriptors referring to eBPF objects can be pinned to the
+ *	  filesystem using the **BPF_OBJ_PIN** command of **bpf**\ (2).
+ *
+ *	An eBPF object is deallocated only after all file descriptors referring
+ *	to the object have been closed and no references remain pinned to the
+ *	filesystem or attached (for example, bound to a program or device).
  */
 enum bpf_cmd {
 	BPF_MAP_CREATE,
-- 
2.27.0

