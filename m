Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344B969B2F5
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 20:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBQTTY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 14:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQTTX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 14:19:23 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DA8498BF
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 11:19:21 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id C19062403E0
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 20:19:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1676661559; bh=uR1etxSmCAteS8np0qhgLmpJSlRGC9c301Pgqk+71+w=;
        h=From:To:Subject:Date:From;
        b=hjIi5AvJcXb8JSNcQYYji22kWVEkmlrBX2riAepUPxqQGxTJarjRaRCJstx6F0Fw9
         /ggUB7pgFjFnmsN14L9SJISRdANpKYKrbSaKq5OC6gMqPR3awiohyNhjcKSFfBZfVG
         viWnTvDUr5NLqQNBZb/Sv0TOqLFsWPGW4Zgzx1lmvXRL0hLm5L1ytV4qXSX32SKorP
         j9UNmqbcFuD6AgA12x9Ylu6NuOYBjvhKX76tybqBz6W6zQjusSglV7ZLsTgCM7VhYL
         VMIZY8oFLbFMTVjr5zqPD64kXmXj5XsklkNFXaMPul7XKQnz0Zljr60mRTgjRKg+iX
         Sw6PQzhq0/BoA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PJM7V5Cz1z9rxF;
        Fri, 17 Feb 2023 20:19:18 +0100 (CET)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Subject: [PATCH bpf-next 1/3] libbpf: Implement basic zip archive parsing support
Date:   Fri, 17 Feb 2023 19:19:06 +0000
Message-Id: <20230217191908.1000004-2-deso@posteo.net>
In-Reply-To: <20230217191908.1000004-1-deso@posteo.net>
References: <20230217191908.1000004-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change implements support for reading zip archives, including
opening an archive, finding an entry based on its path and name in it,
and closing it.
The code was copied from https://github.com/iovisor/bcc/pull/4440, which
implements similar functionality for bcc. The author confirmed that he
is fine with this usage and the corresponding relicensing. I adjusted it
to adhere to libbpf coding standards.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/lib/bpf/Build |   2 +-
 tools/lib/bpf/zip.c | 378 ++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/zip.h |  47 ++++++
 3 files changed, 426 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/bpf/zip.c
 create mode 100644 tools/lib/bpf/zip.h

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index 5a3dfb..b8b0a63 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1,4 +1,4 @@
 libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
 	    netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
 	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
-	    usdt.o
+	    usdt.o zip.o
diff --git a/tools/lib/bpf/zip.c b/tools/lib/bpf/zip.c
new file mode 100644
index 0000000..59ec79
--- /dev/null
+++ b/tools/lib/bpf/zip.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+/*
+ * Routines for dealing with .zip archives.
+ *
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
+ */
+
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include "zip.h"
+
+/* Specification of ZIP file format can be found here:
+ * https://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT
+ * For a high level overview of the structure of a ZIP file see
+ * sections 4.3.1 - 4.3.6.
+ *
+ * Data structures appearing in ZIP files do not contain any
+ * padding and they might be misaligned. To allow us to safely
+ * operate on pointers to such structures and their members, without
+ * worrying of platform specific alignment issues, we define
+ * unaligned_uint16_t and unaligned_uint32_t types with no alignment
+ * requirements.
+ */
+typedef struct {
+	uint8_t raw[2];
+} unaligned_uint16_t;
+
+static uint16_t unaligned_uint16_read(unaligned_uint16_t value)
+{
+	uint16_t return_value;
+
+	memcpy(&return_value, value.raw, sizeof(return_value));
+	return return_value;
+}
+
+typedef struct {
+	uint8_t raw[4];
+} unaligned_uint32_t;
+
+static uint32_t unaligned_uint32_read(unaligned_uint32_t value)
+{
+	uint32_t return_value;
+
+	memcpy(&return_value, value.raw, sizeof(return_value));
+	return return_value;
+}
+
+#define END_OF_CD_RECORD_MAGIC 0x06054b50
+
+/* See section 4.3.16 of the spec. */
+struct end_of_central_directory_record {
+	/* Magic value equal to END_OF_CD_RECORD_MAGIC */
+	unaligned_uint32_t magic;
+
+	/* Number of the file containing this structure or 0xFFFF if ZIP64 archive.
+	 * Zip archive might span multiple files (disks).
+	 */
+	unaligned_uint16_t this_disk;
+
+	/* Number of the file containing the beginning of the central directory or
+	 * 0xFFFF if ZIP64 archive.
+	 */
+	unaligned_uint16_t cd_disk;
+
+	/* Number of central directory records on this disk or 0xFFFF if ZIP64
+	 * archive.
+	 */
+	unaligned_uint16_t cd_records;
+
+	/* Number of central directory records on all disks or 0xFFFF if ZIP64
+	 * archive.
+	 */
+	unaligned_uint16_t cd_records_total;
+
+	/* Size of the central directory recrod or 0xFFFFFFFF if ZIP64 archive. */
+	unaligned_uint32_t cd_size;
+
+	/* Offset of the central directory from the beginning of the archive or
+	 * 0xFFFFFFFF if ZIP64 archive.
+	 */
+	unaligned_uint32_t cd_offset;
+
+	/* Length of comment data following end of central driectory record. */
+	unaligned_uint16_t comment_length;
+
+	/* Up to 64k of arbitrary bytes. */
+	/* uint8_t comment[comment_length] */
+};
+
+#define CD_FILE_HEADER_MAGIC 0x02014b50
+#define FLAG_ENCRYPTED (1 << 0)
+#define FLAG_HAS_DATA_DESCRIPTOR (1 << 3)
+
+/* See section 4.3.12 of the spec. */
+struct central_directory_file_header {
+	/* Magic value equal to CD_FILE_HEADER_MAGIC. */
+	unaligned_uint32_t magic;
+	unaligned_uint16_t version;
+	/* Minimum zip version needed to extract the file. */
+	unaligned_uint16_t min_version;
+	unaligned_uint16_t flags;
+	unaligned_uint16_t compression;
+	unaligned_uint16_t last_modified_time;
+	unaligned_uint16_t last_modified_date;
+	unaligned_uint32_t crc;
+	unaligned_uint32_t compressed_size;
+	unaligned_uint32_t uncompressed_size;
+	unaligned_uint16_t file_name_length;
+	unaligned_uint16_t extra_field_length;
+	unaligned_uint16_t file_comment_length;
+	/* Number of the disk where the file starts or 0xFFFF if ZIP64 archive. */
+	unaligned_uint16_t disk;
+	unaligned_uint16_t internal_attributes;
+	unaligned_uint32_t external_attributes;
+	/* Offset from the start of the disk containing the local file header to the
+	 * start of the local file header.
+	 */
+	unaligned_uint32_t offset;
+};
+
+#define LOCAL_FILE_HEADER_MAGIC 0x04034b50
+
+/* See section 4.3.7 of the spec. */
+struct local_file_header {
+	/* Magic value equal to LOCAL_FILE_HEADER_MAGIC. */
+	unaligned_uint32_t magic;
+	/* Minimum zip version needed to extract the file. */
+	unaligned_uint16_t min_version;
+	unaligned_uint16_t flags;
+	unaligned_uint16_t compression;
+	unaligned_uint16_t last_modified_time;
+	unaligned_uint16_t last_modified_date;
+	unaligned_uint32_t crc;
+	unaligned_uint32_t compressed_size;
+	unaligned_uint32_t uncompressed_size;
+	unaligned_uint16_t file_name_length;
+	unaligned_uint16_t extra_field_length;
+};
+
+struct zip_archive {
+	void *data;
+	uint32_t size;
+	uint32_t cd_offset;
+	uint32_t cd_records;
+};
+
+static void *check_access(struct zip_archive *archive, uint32_t offset, uint32_t size)
+{
+	if (offset + size > archive->size || offset > offset + size) {
+		return NULL;
+	}
+	return archive->data + offset;
+}
+
+/* Returns 0 on success, -1 on error and -2 if the eocd indicates
+ * the archive uses features which are not supported.
+ */
+static int try_parse_end_of_central_directory(struct zip_archive *archive, uint32_t offset)
+{
+	struct end_of_central_directory_record *eocd =
+		check_access(archive, offset, sizeof(struct end_of_central_directory_record));
+	uint16_t comment_length, cd_records;
+	uint32_t cd_offset, cd_size;
+
+	if (!eocd || unaligned_uint32_read(eocd->magic) != END_OF_CD_RECORD_MAGIC) {
+		return -1;
+	}
+
+	comment_length = unaligned_uint16_read(eocd->comment_length);
+	if (offset + sizeof(struct end_of_central_directory_record) + comment_length !=
+	    archive->size) {
+		return -1;
+	}
+
+	cd_records = unaligned_uint16_read(eocd->cd_records);
+	if (unaligned_uint16_read(eocd->this_disk) != 0 ||
+	    unaligned_uint16_read(eocd->cd_disk) != 0 ||
+	    unaligned_uint16_read(eocd->cd_records_total) != cd_records) {
+		/* This is a valid eocd, but we only support single-file non-ZIP64 archives. */
+		return -2;
+	}
+
+	cd_offset = unaligned_uint32_read(eocd->cd_offset);
+	cd_size = unaligned_uint32_read(eocd->cd_size);
+	if (!check_access(archive, cd_offset, cd_size)) {
+		return -1;
+	}
+
+	archive->cd_offset = cd_offset;
+	archive->cd_records = cd_records;
+	return 0;
+}
+
+static int find_central_directory(struct zip_archive *archive)
+{
+	uint32_t offset;
+	int64_t limit;
+	int rc = -1;
+
+	if (archive->size <= sizeof(struct end_of_central_directory_record)) {
+		return -1;
+	}
+
+	/* Because the end of central directory ends with a variable length array of
+	 * up to 0xFFFF bytes we can't know exactly where it starts and need to
+	 * search for it at the end of the file, scanning the (limit, offset] range.
+	 */
+	offset = archive->size - sizeof(struct end_of_central_directory_record);
+	limit = (int64_t)offset - (1 << 16);
+
+	for (; offset >= 0 && offset > limit && rc == -1; offset--) {
+		rc = try_parse_end_of_central_directory(archive, offset);
+	}
+
+	return rc;
+}
+
+struct zip_archive *zip_archive_open(const char *path)
+{
+	struct zip_archive *archive;
+	int fd = open(path, O_RDONLY);
+	off_t size;
+	void *data;
+
+	if (fd < 0) {
+		return NULL;
+	}
+
+	size = lseek(fd, 0, SEEK_END);
+	if (size == (off_t)-1 || size > UINT32_MAX) {
+		close(fd);
+		return NULL;
+	}
+
+	data = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+
+	if (data == MAP_FAILED) {
+		return NULL;
+	}
+
+	archive = malloc(sizeof(struct zip_archive));
+	if (!archive) {
+		munmap(data, size);
+		return NULL;
+	};
+
+	archive->data = data;
+	archive->size = size;
+	if (find_central_directory(archive)) {
+		munmap(data, size);
+		free(archive);
+		archive = NULL;
+	}
+
+	return archive;
+}
+
+void zip_archive_close(struct zip_archive *archive)
+{
+	munmap(archive->data, archive->size);
+	free(archive);
+}
+
+static struct local_file_header *local_file_header_at_offset(struct zip_archive *archive,
+							     uint32_t offset)
+{
+	struct local_file_header *lfh =
+		check_access(archive, offset, sizeof(struct local_file_header));
+	if (!lfh || unaligned_uint32_read(lfh->magic) != LOCAL_FILE_HEADER_MAGIC) {
+		return NULL;
+	}
+	return lfh;
+}
+
+static int get_entry_at_offset(struct zip_archive *archive, uint32_t offset, struct zip_entry *out)
+{
+	struct local_file_header *lfh = local_file_header_at_offset(archive, offset);
+	uint16_t flags, name_length, extra_field_length;
+	uint32_t compressed_size;
+	const char *name;
+	void *data;
+
+	offset += sizeof(struct local_file_header);
+	if (!lfh) {
+		return -1;
+	};
+
+	flags = unaligned_uint16_read(lfh->flags);
+	if ((flags & FLAG_ENCRYPTED) || (flags & FLAG_HAS_DATA_DESCRIPTOR)) {
+		return -1;
+	}
+
+	name_length = unaligned_uint16_read(lfh->file_name_length);
+	name = check_access(archive, offset, name_length);
+	offset += name_length;
+	if (!name) {
+		return -1;
+	}
+
+	extra_field_length = unaligned_uint16_read(lfh->extra_field_length);
+	if (!check_access(archive, offset, extra_field_length)) {
+		return -1;
+	}
+	offset += extra_field_length;
+
+	compressed_size = unaligned_uint32_read(lfh->compressed_size);
+	data = check_access(archive, offset, compressed_size);
+	if (!data) {
+		return -1;
+	}
+
+	out->compression = unaligned_uint16_read(lfh->compression);
+	out->name_length = name_length;
+	out->name = name;
+	out->data = data;
+	out->data_length = compressed_size;
+	out->data_offset = offset;
+
+	return 0;
+}
+
+static struct central_directory_file_header *cd_file_header_at_offset(struct zip_archive *archive,
+								      uint32_t offset)
+{
+	struct central_directory_file_header *cdfh =
+		check_access(archive, offset, sizeof(struct central_directory_file_header));
+	if (!cdfh || unaligned_uint32_read(cdfh->magic) != CD_FILE_HEADER_MAGIC) {
+		return NULL;
+	}
+	return cdfh;
+}
+
+int zip_archive_find_entry(struct zip_archive *archive, const char *file_name,
+			   struct zip_entry *out)
+{
+	size_t file_name_length = strlen(file_name);
+
+	uint32_t i, offset = archive->cd_offset;
+
+	for (i = 0; i < archive->cd_records; ++i) {
+		struct central_directory_file_header *cdfh =
+			cd_file_header_at_offset(archive, offset);
+		uint16_t cdfh_name_length, cdfh_flags;
+		const char *cdfh_name;
+
+		offset += sizeof(struct central_directory_file_header);
+		if (!cdfh) {
+			return -1;
+		}
+
+		cdfh_name_length = unaligned_uint16_read(cdfh->file_name_length);
+		cdfh_name = check_access(archive, offset, cdfh_name_length);
+		if (!cdfh_name) {
+			return -1;
+		}
+
+		cdfh_flags = unaligned_uint16_read(cdfh->flags);
+		if ((cdfh_flags & FLAG_ENCRYPTED) == 0 &&
+		    (cdfh_flags & FLAG_HAS_DATA_DESCRIPTOR) == 0 &&
+		    file_name_length == cdfh_name_length &&
+		    memcmp(file_name, archive->data + offset, file_name_length) == 0) {
+			return get_entry_at_offset(archive, unaligned_uint32_read(cdfh->offset),
+						   out);
+		}
+
+		offset += cdfh_name_length;
+		offset += unaligned_uint16_read(cdfh->extra_field_length);
+		offset += unaligned_uint16_read(cdfh->file_comment_length);
+	}
+
+	return -1;
+}
diff --git a/tools/lib/bpf/zip.h b/tools/lib/bpf/zip.h
new file mode 100644
index 0000000..a9083f
--- /dev/null
+++ b/tools/lib/bpf/zip.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+
+#ifndef __LIBBPF_ZIP_H
+#define __LIBBPF_ZIP_H
+
+#include <stdint.h>
+
+/* Represents an opened zip archive.
+ * Only basic ZIP files are supported, in particular the following are not
+ * supported:
+ * - encryption
+ * - streaming
+ * - multi-part ZIP files
+ * - ZIP64
+ */
+struct zip_archive;
+
+/* Carries information on name, compression method, and data corresponding to a
+ * file in a zip archive.
+ */
+struct zip_entry {
+	/* Compression method as defined in pkzip spec. 0 means data is uncompressed. */
+	uint16_t compression;
+
+	/* Non-null terminated name of the file. */
+	const char *name;
+	/* Length of the file name. */
+	uint16_t name_length;
+
+	/* Pointer to the file data. */
+	const void *data;
+	/* Length of the file data. */
+	uint32_t data_length;
+	/* Offset of the file data within the archive. */
+	uint32_t data_offset;
+};
+
+/* Open a zip archive. Returns NULL in case of an error. */
+struct zip_archive *zip_archive_open(const char *path);
+
+/* Close a zip archive and release resources. */
+void zip_archive_close(struct zip_archive *archive);
+
+/* Look up an entry corresponding to a file in given zip archive. */
+int zip_archive_find_entry(struct zip_archive *archive, const char *name, struct zip_entry *out);
+
+#endif
-- 
2.30.2

