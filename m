Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F16F32B341
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352503AbhCCDuZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349778AbhCBRga (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 12:36:30 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F85C061A30
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 09:20:35 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id jx13so2376184pjb.1
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 09:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uozbbnIbmkxFj/HIjxQ8WJQUr6vi8vUHNtiv9TAUsWg=;
        b=OxJj6Gwx86HVTrnPp9BaOKPNRaezKTLP7TX2wps4YmLsKGHZcFmQAzK8TUUHao3FPu
         8TNG0CyaA8NPFvTxtHIcIMWp26eJNLOrfeWrR5OKukQUxM/ze+qAH001UKAJ3lRegWMy
         vwHFYHnl5UR02YpAy5Mh5SRBNy0/uQSknjg+NbD3liUIZfD0IOa2RjQbW2kGa8eei8/2
         vBVWE57jvS+qXRtzL07HQrtfToQNhv1r61OnrtwLuA7JUUa7Y0/VAO6+Y+VMwfOX6rnI
         /nfHQ8bB9REmQPFtz8wE2A9N5pfXKftaGk/xkc2zitJq2VLofGcRLfGTaM3y5A32/3ib
         Kh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uozbbnIbmkxFj/HIjxQ8WJQUr6vi8vUHNtiv9TAUsWg=;
        b=ec3XjDpQrm6bJ2xHNO1oO67EOtZdJQ9kWudaI8xJa4JZxLAl9ri6hHWQwKzxbTiBIE
         i1vY4mGyoVtqP3bSSQNMo16jJBriPi2XAC6y6UJd1zj3/9E6q8rNaCZdm9tlUN/FgGvL
         6zaoIDNTGzpuM9nJWxvvAWmWdDgPJmdK/Kjlo2F6dQ0bVnFuyILrQWBG2R+8odDA0Hlh
         Rt09sSiBXmJXCJs/w113YOZPbPsha68EuxjnUbqMak2CvRNB6KWZIGE1e4LI0thhlKhM
         zCyLi9mQe0JqFKS40/ns7Ydvnt2vjtz88ruRXAJod1zb1OP0jvup3vKgxziYCObTws2W
         Z3mA==
X-Gm-Message-State: AOAM53207StdaFZWhLbv5W1sNpj84KLOJDlUJSxJYJlGxQKYINl87qkv
        CH4SnOR2zln8bV1WK3l8IuQocPexbaCyX2u1
X-Google-Smtp-Source: ABdhPJx+YkvABLuhZmo1HaocVUC3PQfUgQid0eo7udB08w+vpgyft1oyH7k/T770tY5EwOpwN7oakA==
X-Received: by 2002:a17:90a:cb0a:: with SMTP id z10mr1136091pjt.170.1614705634975;
        Tue, 02 Mar 2021 09:20:34 -0800 (PST)
Received: from localhost.localdomain (c-73-93-5-123.hsd1.ca.comcast.net. [73.93.5.123])
        by smtp.gmail.com with ESMTPSA id b15sm20073923pgg.85.2021.03.02.09.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 09:20:34 -0800 (PST)
From:   Joe Stringer <joe@cilium.io>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, ast@kernel.org, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCHv2 bpf-next 02/15] bpf: Add minimal bpf() command documentation
Date:   Tue,  2 Mar 2021 09:19:34 -0800
Message-Id: <20210302171947.2268128-3-joe@cilium.io>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210302171947.2268128-1-joe@cilium.io>
References: <20210302171947.2268128-1-joe@cilium.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce high-level descriptions of the intent and return codes of the
bpf() syscall commands. Subsequent patches may further flesh out the
content to provide a more useful programming reference.

Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Joe Stringer <joe@cilium.io>
---
 include/uapi/linux/bpf.h | 368 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 368 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fb16c590e6d9..052bbfe65f77 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -204,6 +204,374 @@ union bpf_iter_link_info {
  *		A new file descriptor (a nonnegative integer), or -1 if an
  *		error occurred (in which case, *errno* is set appropriately).
  *
+ * BPF_OBJ_PIN
+ *	Description
+ *		Pin an eBPF program or map referred by the specified *bpf_fd*
+ *		to the provided *pathname* on the filesystem.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ * BPF_OBJ_GET
+ *	Description
+ *		Open a file descriptor for the eBPF object pinned to the
+ *		specified *pathname*.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
+ * BPF_PROG_ATTACH
+ *	Description
+ *		Attach an eBPF program to a *target_fd* at the specified
+ *		*attach_type* hook.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ * BPF_PROG_DETACH
+ *	Description
+ *		Detach the eBPF program associated with the *target_fd* at the
+ *		hook specified by *attach_type*. The program must have been
+ *		previously attached using **BPF_PROG_ATTACH**.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ * BPF_PROG_TEST_RUN
+ *	Description
+ *		Run an eBPF program a number of times against a provided
+ *		program context and return the modified program context and
+ *		duration of the test run.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ * BPF_PROG_GET_NEXT_ID
+ *	Description
+ *		Fetch the next eBPF program currently loaded into the kernel.
+ *
+ *		Looks for the eBPF program with an id greater than *start_id*
+ *		and updates *next_id* on success. If no other eBPF programs
+ *		remain with ids higher than *start_id*, returns -1 and sets
+ *		*errno* to **ENOENT**.
+ *
+ *	Return
+ *		Returns zero on success. On error, or when no id remains, -1
+ *		is returned and *errno* is set appropriately.
+ *
+ * BPF_MAP_GET_NEXT_ID
+ *	Description
+ *		Fetch the next eBPF map currently loaded into the kernel.
+ *
+ *		Looks for the eBPF map with an id greater than *start_id*
+ *		and updates *next_id* on success. If no other eBPF maps
+ *		remain with ids higher than *start_id*, returns -1 and sets
+ *		*errno* to **ENOENT**.
+ *
+ *	Return
+ *		Returns zero on success. On error, or when no id remains, -1
+ *		is returned and *errno* is set appropriately.
+ *
+ * BPF_PROG_GET_FD_BY_ID
+ *	Description
+ *		Open a file descriptor for the eBPF program corresponding to
+ *		*prog_id*.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
+ * BPF_MAP_GET_FD_BY_ID
+ *	Description
+ *		Open a file descriptor for the eBPF map corresponding to
+ *		*map_id*.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
+ * BPF_OBJ_GET_INFO_BY_FD
+ *	Description
+ *		Obtain information about the eBPF object corresponding to
+ *		*bpf_fd*.
+ *
+ *		Populates up to *info_len* bytes of *info*, which will be in
+ *		one of the following formats depending on the eBPF object type
+ *		of *bpf_fd*:
+ *
+ *		* **struct bpf_prog_info**
+ *		* **struct bpf_map_info**
+ *		* **struct bpf_btf_info**
+ *		* **struct bpf_link_info**
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ * BPF_PROG_QUERY
+ *	Description
+ *		Obtain information about eBPF programs associated with the
+ *		specified *attach_type* hook.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ * BPF_RAW_TRACEPOINT_OPEN
+ *	Description
+ *		Attach an eBPF program to a tracepoint *name* to access kernel
+ *		internal arguments of the tracepoint in their raw form.
+ *
+ *		The *prog_fd* must be a valid file descriptor associated with
+ *		a loaded eBPF program of type **BPF_PROG_TYPE_RAW_TRACEPOINT**.
+ *
+ *		No ABI guarantees are made about the content of tracepoint
+ *		arguments exposed to the corresponding eBPF program.
+ *
+ *		Applying **close**\ (2) to the file descriptor returned by
+ *		**BPF_RAW_TRACEPOINT_OPEN** will delete the map (but see NOTES).
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
+ * BPF_BTF_LOAD
+ *	Description
+ *		Verify and load BPF Type Format (BTF) metadata into the kernel,
+ *		returning a new file descriptor associated with the metadata.
+ *		BTF is described in more detail at
+ *		https://www.kernel.org/doc/html/latest/bpf/btf.html.
+ *
+ *		The *btf* parameter must point to valid memory providing
+ *		*btf_size* bytes of BTF binary metadata.
+ *
+ *		The returned file descriptor can be passed to other **bpf**\ ()
+ *		subcommands such as **BPF_PROG_LOAD** or **BPF_MAP_CREATE** to
+ *		associate the BTF with those objects.
+ *
+ *		Similar to **BPF_PROG_LOAD**, **BPF_BTF_LOAD** has optional
+ *		parameters to specify a *btf_log_buf*, *btf_log_size* and
+ *		*btf_log_level* which allow the kernel to return freeform log
+ *		output regarding the BTF verification process.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
+ * BPF_BTF_GET_FD_BY_ID
+ *	Description
+ *		Open a file descriptor for the BPF Type Format (BTF)
+ *		corresponding to *btf_id*.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
+ * BPF_TASK_FD_QUERY
+ *	Description
+ *		Obtain information about eBPF programs associated with the
+ *		target process identified by *pid* and *fd*.
+ *
+ *		If the *pid* and *fd* are associated with a tracepoint, kprobe
+ *		or uprobe perf event, then the *prog_id* and *fd_type* will
+ *		be populated with the eBPF program id and file descriptor type
+ *		of type **bpf_task_fd_type**. If associated with a kprobe or
+ *		uprobe, the  *probe_offset* and *probe_addr* will also be
+ *		populated. Optionally, if *buf* is provided, then up to
+ *		*buf_len* bytes of *buf* will be populated with the name of
+ *		the tracepoint, kprobe or uprobe.
+ *
+ *		The resulting *prog_id* may be introspected in deeper detail
+ *		using **BPF_PROG_GET_FD_BY_ID** and **BPF_OBJ_GET_INFO_BY_FD**.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ * BPF_MAP_LOOKUP_AND_DELETE_ELEM
+ *	Description
+ *		Look up an element with the given *key* in the map referred to
+ *		by the file descriptor *fd*, and if found, delete the element.
+ *
+ *		The **BPF_MAP_TYPE_QUEUE** and **BPF_MAP_TYPE_STACK** map types
+ *		implement this command as a "pop" operation, deleting the top
+ *		element rather than one corresponding to *key*.
+ *		The *key* and *key_len* parameters should be zeroed when
+ *		issuing this operation for these map types.
+ *
+ *		This command is only valid for the following map types:
+ *		* **BPF_MAP_TYPE_QUEUE**
+ *		* **BPF_MAP_TYPE_STACK**
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ * BPF_MAP_FREEZE
+ *	Description
+ *		Freeze the permissions of the specified map.
+ *
+ *		Write permissions may be frozen by passing zero *flags*.
+ *		Upon success, no future syscall invocations may alter the
+ *		map state of *map_fd*. Write operations from eBPF programs
+ *		are still possible for a frozen map.
+ *
+ *		Not supported for maps of type **BPF_MAP_TYPE_STRUCT_OPS**.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ * BPF_BTF_GET_NEXT_ID
+ *	Description
+ *		Fetch the next BPF Type Format (BTF) object currently loaded
+ *		into the kernel.
+ *
+ *		Looks for the BTF object with an id greater than *start_id*
+ *		and updates *next_id* on success. If no other BTF objects
+ *		remain with ids higher than *start_id*, returns -1 and sets
+ *		*errno* to **ENOENT**.
+ *
+ *	Return
+ *		Returns zero on success. On error, or when no id remains, -1
+ *		is returned and *errno* is set appropriately.
+ *
+ * BPF_MAP_LOOKUP_BATCH
+ *	Description
+ *		Iterate and fetch multiple elements in a map.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ * BPF_MAP_LOOKUP_AND_DELETE_BATCH
+ *	Description
+ *		Iterate and delete multiple elements in a map.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ * BPF_MAP_UPDATE_BATCH
+ *	Description
+ *		Iterate and update multiple elements in a map.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ * BPF_MAP_DELETE_BATCH
+ *	Description
+ *		Iterate and delete multiple elements in a map.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ * BPF_LINK_CREATE
+ *	Description
+ *		Attach an eBPF program to a *target_fd* at the specified
+ *		*attach_type* hook and return a file descriptor handle for
+ *		managing the link.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
+ * BPF_LINK_UPDATE
+ *	Description
+ *		Update the eBPF program in the specified *link_fd* to
+ *		*new_prog_fd*.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ * BPF_LINK_GET_FD_BY_ID
+ *	Description
+ *		Open a file descriptor for the eBPF Link corresponding to
+ *		*link_id*.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
+ * BPF_LINK_GET_NEXT_ID
+ *	Description
+ *		Fetch the next eBPF link currently loaded into the kernel.
+ *
+ *		Looks for the eBPF link with an id greater than *start_id*
+ *		and updates *next_id* on success. If no other eBPF links
+ *		remain with ids higher than *start_id*, returns -1 and sets
+ *		*errno* to **ENOENT**.
+ *
+ *	Return
+ *		Returns zero on success. On error, or when no id remains, -1
+ *		is returned and *errno* is set appropriately.
+ *
+ * BPF_ENABLE_STATS
+ *	Description
+ *		Enable eBPF runtime statistics gathering.
+ *
+ *		Runtime statistics gathering for the eBPF runtime is disabled
+ *		by default to minimize the corresponding performance overhead.
+ *		This command enables statistics globally.
+ *
+ *		Multiple programs may independently enable statistics.
+ *		After gathering the desired statistics, eBPF runtime statistics
+ *		may be disabled again by calling **close**\ (2) for the file
+ *		descriptor returned by this function. Statistics will only be
+ *		disabled system-wide when all outstanding file descriptors
+ *		returned by prior calls for this subcommand are closed.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
+ * BPF_ITER_CREATE
+ *	Description
+ *		Create an iterator on top of the specified *link_fd* (as
+ *		previously created using **BPF_LINK_CREATE**) and return a
+ *		file descriptor that can be used to trigger the iteration.
+ *
+ *		If the resulting file descriptor is pinned to the filesystem
+ *		using  **BPF_OBJ_PIN**, then subsequent **read**\ (2) syscalls
+ *		for that path will trigger the iterator to read kernel state
+ *		using the eBPF program attached to *link_fd*.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
+ * BPF_LINK_DETACH
+ *	Description
+ *		Forcefully detach the specified *link_fd* from its
+ *		corresponding attachment point.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ * BPF_PROG_BIND_MAP
+ *	Description
+ *		Bind a map to the lifetime of an eBPF program.
+ *
+ *		The map identified by *map_fd* is bound to the program
+ *		identified by *prog_fd* and only released when *prog_fd* is
+ *		released. This may be used in cases where metadata should be
+ *		associated with a program which otherwise does not contain any
+ *		references to the map (for example, embedded in the eBPF
+ *		program instructions).
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *	For example, after **fork**\ (2), the child inherits file descriptors
-- 
2.27.0

