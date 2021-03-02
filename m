Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B0232B348
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352515AbhCCDui (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240792AbhCBRiu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 12:38:50 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1564C061A2B
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 09:20:34 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id jx13so2376154pjb.1
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 09:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cZPyA9m3sp7GWzupY4xnewRoMydoMiMPf4WFOI3CF9w=;
        b=sJ2OJLwmwqDDPUf35eKDe6NU8HZy6R5/C9TvVUeRumZ9EyXhSA8h8QolBQYVIGEN3+
         sjISVk5hmKpVotMoC6UygTqdDwxXci49TMiDryrojQJTntTO6DIwRbfX2NFNfItree7x
         C7BAyAFlxavkRwkLf7sxBHmaw3ED/rv53Y6tRW/1IhShcs2ltLS5YQ6FgsbBqIROgkYA
         fM+Ix6srOLtyQ0/iwdookdICuoar/FA9pgawiIFa0X/QW/HYWNqQw5w9g+srowA9OM/V
         YYbJprgQcsn0hJflHr828zG+XIi0BAjXSo/wbl8mQ1w9yYi50Sht7if7badDtS4JC388
         2lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZPyA9m3sp7GWzupY4xnewRoMydoMiMPf4WFOI3CF9w=;
        b=S2Zqd0U81U6HsbnGSyBlpblwimeUcr/JFZDY2FcHIWB78S9qdpBz86wM0dIADsx1NP
         6rizR1kWGjR9zoDPU+Zbwq4N/dgqnp7ryqpX95W40KFk07il8RPTeevJs8H16LWPZp7f
         kO6Yxkq/Z6LToQ25+eKVLeHk5kgFem8CY0x9J1dJPKSn/4WNgDKFOzrBPzSwEQKPKsGg
         OGuW3bRQiBITD2fEayjLDuOAiZ1QJjOW5T/alBeaboQjVgBJhLYmBz03/zCPlIcNJmhX
         srMAF9BXrCxdRUyjeuOxsyEckLu0jIMsWx4ZBUyCleVgCXjJ3vT0/c2fe+S8GNVRkMga
         GOWw==
X-Gm-Message-State: AOAM531/wrmdH1yb70Av/iJ+NKXURU8E5a/8F/ZUObwahKG8EWhsqOtG
        OIfIo/SIQH4N8+PwAJoJJkVXIHh6ExMYUakI
X-Google-Smtp-Source: ABdhPJz+91huBG/Dlm8J0g83YpRM8aSMTTD4XhyVsTbpSADsoEBemrdz+CbGvbQH2oxc1uXLp/0Zpg==
X-Received: by 2002:a17:90b:110c:: with SMTP id gi12mr5436954pjb.48.1614705633830;
        Tue, 02 Mar 2021 09:20:33 -0800 (PST)
Received: from localhost.localdomain (c-73-93-5-123.hsd1.ca.comcast.net. [73.93.5.123])
        by smtp.gmail.com with ESMTPSA id b15sm20073923pgg.85.2021.03.02.09.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 09:20:33 -0800 (PST)
From:   Joe Stringer <joe@cilium.io>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, ast@kernel.org, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCHv2 bpf-next 01/15] bpf: Import syscall arg documentation
Date:   Tue,  2 Mar 2021 09:19:33 -0800
Message-Id: <20210302171947.2268128-2-joe@cilium.io>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210302171947.2268128-1-joe@cilium.io>
References: <20210302171947.2268128-1-joe@cilium.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These descriptions are present in the man-pages project from the
original submissions around 2015-2016. Import them so that they can be
kept up to date as developers extend the bpf syscall commands.

These descriptions follow the pattern used by scripts/bpf_helpers_doc.py
so that we can take advantage of the parser to generate more up-to-date
man page writing based upon these headers.

Some minor wording adjustments were made to make the descriptions
more consistent for the description / return format.

Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Co-authored-by: Alexei Starovoitov <ast@kernel.org>
Co-authored-by: Michael Kerrisk <mtk.manpages@gmail.com>
Signed-off-by: Joe Stringer <joe@cilium.io>
---
 include/uapi/linux/bpf.h | 122 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b89af20cfa19..fb16c590e6d9 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -93,7 +93,127 @@ union bpf_iter_link_info {
 	} map;
 };
 
-/* BPF syscall commands, see bpf(2) man-page for details. */
+/* BPF syscall commands, see bpf(2) man-page for more details. */
+/**
+ * DOC: eBPF Syscall Preamble
+ *
+ * The operation to be performed by the **bpf**\ () system call is determined
+ * by the *cmd* argument. Each operation takes an accompanying argument,
+ * provided via *attr*, which is a pointer to a union of type *bpf_attr* (see
+ * below). The size argument is the size of the union pointed to by *attr*.
+ */
+/**
+ * DOC: eBPF Syscall Commands
+ *
+ * BPF_MAP_CREATE
+ *	Description
+ *		Create a map and return a file descriptor that refers to the
+ *		map. The close-on-exec file descriptor flag (see **fcntl**\ (2))
+ *		is automatically enabled for the new file descriptor.
+ *
+ *		Applying **close**\ (2) to the file descriptor returned by
+ *		**BPF_MAP_CREATE** will delete the map (but see NOTES).
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
+ * BPF_MAP_LOOKUP_ELEM
+ *	Description
+ *		Look up an element with a given *key* in the map referred to
+ *		by the file descriptor *map_fd*.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ * BPF_MAP_UPDATE_ELEM
+ *	Description
+ *		Create or update an element (key/value pair) in a specified map.
+ *
+ *		The *flags* argument should be specified as one of the
+ *		following:
+ *
+ *		**BPF_ANY**
+ *			Create a new element or update an existing element.
+ *		**BPF_NOEXIST**
+ *			Create a new element only if it did not exist.
+ *		**BPF_EXIST**
+ *			Update an existing element.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ *		May set *errno* to **EINVAL**, **EPERM**, **ENOMEM**,
+ *		**E2BIG**, **EEXIST**, or **ENOENT**.
+ *
+ *		**E2BIG**
+ *			The number of elements in the map reached the
+ *			*max_entries* limit specified at map creation time.
+ *		**EEXIST**
+ *			If *flags* specifies **BPF_NOEXIST** and the element
+ *			with *key* already exists in the map.
+ *		**ENOENT**
+ *			If *flags* specifies **BPF_EXIST** and the element with
+ *			*key* does not exist in the map.
+ *
+ * BPF_MAP_DELETE_ELEM
+ *	Description
+ *		Look up and delete an element by key in a specified map.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ * BPF_MAP_GET_NEXT_KEY
+ *	Description
+ *		Look up an element by key in a specified map and return the key
+ *		of the next element. Can be used to iterate over all elements
+ *		in the map.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ *		The following cases can be used to iterate over all elements of
+ *		the map:
+ *
+ *		* If *key* is not found, the operation returns zero and sets
+ *		  the *next_key* pointer to the key of the first element.
+ *		* If *key* is found, the operation returns zero and sets the
+ *		  *next_key* pointer to the key of the next element.
+ *		* If *key* is the last element, returns -1 and *errno* is set
+ *		  to **ENOENT**.
+ *
+ *		May set *errno* to **ENOMEM**, **EFAULT**, **EPERM**, or
+ *		**EINVAL** on error.
+ *
+ * BPF_PROG_LOAD
+ *	Description
+ *		Verify and load an eBPF program, returning a new file
+ *		descriptor associated with the program.
+ *
+ *		Applying **close**\ (2) to the file descriptor returned by
+ *		**BPF_PROG_LOAD** will unload the eBPF program (but see NOTES).
+ *
+ *		The close-on-exec file descriptor flag (see **fcntl**\ (2)) is
+ *		automatically enabled for the new file descriptor.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
+ * NOTES
+ *	eBPF objects (maps and programs) can be shared between processes.
+ *	For example, after **fork**\ (2), the child inherits file descriptors
+ *	referring to the same eBPF objects. In addition, file descriptors
+ *	referring to eBPF objects can be transferred over UNIX domain sockets.
+ *	File descriptors referring to eBPF objects can be duplicated in the
+ *	usual way, using **dup**\ (2) and similar calls. An eBPF object is
+ *	deallocated only after all file descriptors referring to the object
+ *	have been closed.
+ */
 enum bpf_cmd {
 	BPF_MAP_CREATE,
 	BPF_MAP_LOOKUP_ELEM,
-- 
2.27.0

