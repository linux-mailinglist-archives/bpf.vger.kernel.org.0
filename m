Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E559869E82C
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 20:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjBUTUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 14:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBUTUS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 14:20:18 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40662FCC7
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 11:20:15 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id EC21124040B
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 20:20:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1677007214; bh=30/o/qbcyrtGTojKnwZGtnLmCymEPuRGGPOdXuicSXI=;
        h=Date:From:To:Cc:Subject:From;
        b=lCtLqwgvQ5zmTifecTM5MP9ibG6AdzHRX8hFnRI1F4/8EjsoNhDPUJSr746zkTH6E
         AkQBtWl8dVdwzFI4hm9lkg5nPB8VBJNGlHVJzkX1UDiABZXXOqKMWXV/HFq83tVKq2
         kXADZAbeCYrrrScy+j8iGbfhznPGMHiBky1sp0hFPmuIgTDcBCMkEp71KCvXhEme7H
         1DS8R2KNKQfyW5T4ngxxep4Gy7bO5fhCnLwWA2Psodb2SDbGySoI52dmSMAu0PY8g8
         fbS/S1iaJlPnl5auhlpeholEaAlI/TdIsVXQBlu6EhS11X1YIZHzeRg7vAW5wAeGv4
         pdUlTf6/Hgf0Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PLpyf6RqBz9rxQ;
        Tue, 21 Feb 2023 20:20:10 +0100 (CET)
Date:   Tue, 21 Feb 2023 19:20:07 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "michalgr@meta.com" <michalgr@meta.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kafai@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 1/3] libbpf: Implement basic zip archive parsing
 support
Message-ID: <20230221192007.ow2s6eyy7kknk4s5@muellerd-fedora-PC2BDTX9>
References: <20230217191908.1000004-1-deso@posteo.net>
 <20230217191908.1000004-2-deso@posteo.net>
 <CAEf4BzZkKFLbBD2uh8fTb+tvtLf713RkmAW8Bg+53RNUELkLGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZkKFLbBD2uh8fTb+tvtLf713RkmAW8Bg+53RNUELkLGw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 17, 2023 at 04:10:04PM -0800, Andrii Nakryiko wrote:
> On Fri, Feb 17, 2023 at 11:19 AM Daniel Müller <deso@posteo.net> wrote:
> >
> > This change implements support for reading zip archives, including
> > opening an archive, finding an entry based on its path and name in it,
> > and closing it.
> > The code was copied from https://github.com/iovisor/bcc/pull/4440, which
> > implements similar functionality for bcc. The author confirmed that he
> > is fine with this usage and the corresponding relicensing. I adjusted it
> > to adhere to libbpf coding standards.
> 
> Let's record this with
> 
> Acked-by: Michał Gregorczyk <michalgr@meta.com>
> 
> tag added next to your Signed-off-by. I've added Michal to cc for visibility.
> 
> >
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> > ---
> >  tools/lib/bpf/Build |   2 +-
> >  tools/lib/bpf/zip.c | 378 ++++++++++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/zip.h |  47 ++++++
> >  3 files changed, 426 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/lib/bpf/zip.c
> >  create mode 100644 tools/lib/bpf/zip.h
> >
> > diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
> > index 5a3dfb..b8b0a63 100644
> > --- a/tools/lib/bpf/Build
> > +++ b/tools/lib/bpf/Build
> > @@ -1,4 +1,4 @@
> >  libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
> >             netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
> >             btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
> > -           usdt.o
> > +           usdt.o zip.o
> > diff --git a/tools/lib/bpf/zip.c b/tools/lib/bpf/zip.c
> > new file mode 100644
> > index 0000000..59ec79
> > --- /dev/null
> > +++ b/tools/lib/bpf/zip.c
> > @@ -0,0 +1,378 @@
> > +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +/*
> > + * Routines for dealing with .zip archives.
> > + *
> > + * Copyright (c) Meta Platforms, Inc. and affiliates.
> > + */
> > +
> > +#include <fcntl.h>
> > +#include <stdint.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/mman.h>
> > +#include <unistd.h>
> > +
> > +#include "zip.h"
> > +
> > +/* Specification of ZIP file format can be found here:
> > + * https://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT
> > + * For a high level overview of the structure of a ZIP file see
> > + * sections 4.3.1 - 4.3.6.
> > + *
> > + * Data structures appearing in ZIP files do not contain any
> > + * padding and they might be misaligned. To allow us to safely
> > + * operate on pointers to such structures and their members, without
> > + * worrying of platform specific alignment issues, we define
> > + * unaligned_uint16_t and unaligned_uint32_t types with no alignment
> > + * requirements.
> > + */
> > +typedef struct {
> > +       uint8_t raw[2];
> > +} unaligned_uint16_t;
> > +
> > +static uint16_t unaligned_uint16_read(unaligned_uint16_t value)
> > +{
> > +       uint16_t return_value;
> > +
> > +       memcpy(&return_value, value.raw, sizeof(return_value));
> > +       return return_value;
> > +}
> > +
> > +typedef struct {
> > +       uint8_t raw[4];
> > +} unaligned_uint32_t;
> > +
> > +static uint32_t unaligned_uint32_read(unaligned_uint32_t value)
> > +{
> > +       uint32_t return_value;
> > +
> > +       memcpy(&return_value, value.raw, sizeof(return_value));
> > +       return return_value;
> > +}
> 
> it feels like an overkill to use this unaligned_xxx_t approach. Let's
> use __attribute__((packed)) on corresponding structs and just
> uint16_t/uint32_t field types.
> 
> > +
> > +#define END_OF_CD_RECORD_MAGIC 0x06054b50
> > +
> > +/* See section 4.3.16 of the spec. */
> > +struct end_of_central_directory_record {
> > +       /* Magic value equal to END_OF_CD_RECORD_MAGIC */
> > +       unaligned_uint32_t magic;
> > +
> > +       /* Number of the file containing this structure or 0xFFFF if ZIP64 archive.
> > +        * Zip archive might span multiple files (disks).
> > +        */
> > +       unaligned_uint16_t this_disk;
> > +
> > +       /* Number of the file containing the beginning of the central directory or
> > +        * 0xFFFF if ZIP64 archive.
> > +        */
> > +       unaligned_uint16_t cd_disk;
> > +
> > +       /* Number of central directory records on this disk or 0xFFFF if ZIP64
> > +        * archive.
> > +        */
> > +       unaligned_uint16_t cd_records;
> > +
> > +       /* Number of central directory records on all disks or 0xFFFF if ZIP64
> > +        * archive.
> > +        */
> > +       unaligned_uint16_t cd_records_total;
> > +
> > +       /* Size of the central directory recrod or 0xFFFFFFFF if ZIP64 archive. */
> 
> typo: record
> 
> > +       unaligned_uint32_t cd_size;
> > +
> > +       /* Offset of the central directory from the beginning of the archive or
> > +        * 0xFFFFFFFF if ZIP64 archive.
> > +        */
> > +       unaligned_uint32_t cd_offset;
> > +
> > +       /* Length of comment data following end of central driectory record. */
> 
> typo: directory
> 
> 
> > +       unaligned_uint16_t comment_length;
> > +
> > +       /* Up to 64k of arbitrary bytes. */
> > +       /* uint8_t comment[comment_length] */
> > +};
> > +
> > +#define CD_FILE_HEADER_MAGIC 0x02014b50
> > +#define FLAG_ENCRYPTED (1 << 0)
> > +#define FLAG_HAS_DATA_DESCRIPTOR (1 << 3)
> > +
> > +/* See section 4.3.12 of the spec. */
> > +struct central_directory_file_header {
> 
> 
> naming nit here and below: we use CD in constants, but spell out
> "central_directory", which feels a bit mouthful. Let's use "cd"
> consistently throughout (even if it's a bit confusing with "change
> directory", but I think in the context of parsing ZIP contents should
> be recognizable enough)

Sure.

> > +       /* Magic value equal to CD_FILE_HEADER_MAGIC. */
> > +       unaligned_uint32_t magic;
> > +       unaligned_uint16_t version;
> > +       /* Minimum zip version needed to extract the file. */
> > +       unaligned_uint16_t min_version;
> > +       unaligned_uint16_t flags;
> > +       unaligned_uint16_t compression;
> > +       unaligned_uint16_t last_modified_time;
> > +       unaligned_uint16_t last_modified_date;
> > +       unaligned_uint32_t crc;
> > +       unaligned_uint32_t compressed_size;
> > +       unaligned_uint32_t uncompressed_size;
> > +       unaligned_uint16_t file_name_length;
> > +       unaligned_uint16_t extra_field_length;
> > +       unaligned_uint16_t file_comment_length;
> > +       /* Number of the disk where the file starts or 0xFFFF if ZIP64 archive. */
> > +       unaligned_uint16_t disk;
> > +       unaligned_uint16_t internal_attributes;
> > +       unaligned_uint32_t external_attributes;
> > +       /* Offset from the start of the disk containing the local file header to the
> > +        * start of the local file header.
> > +        */
> > +       unaligned_uint32_t offset;
> > +};
> > +
> > +#define LOCAL_FILE_HEADER_MAGIC 0x04034b50
> > +
> > +/* See section 4.3.7 of the spec. */
> > +struct local_file_header {
> > +       /* Magic value equal to LOCAL_FILE_HEADER_MAGIC. */
> > +       unaligned_uint32_t magic;
> > +       /* Minimum zip version needed to extract the file. */
> > +       unaligned_uint16_t min_version;
> > +       unaligned_uint16_t flags;
> > +       unaligned_uint16_t compression;
> > +       unaligned_uint16_t last_modified_time;
> > +       unaligned_uint16_t last_modified_date;
> > +       unaligned_uint32_t crc;
> > +       unaligned_uint32_t compressed_size;
> > +       unaligned_uint32_t uncompressed_size;
> > +       unaligned_uint16_t file_name_length;
> > +       unaligned_uint16_t extra_field_length;
> > +};
> > +
> > +struct zip_archive {
> > +       void *data;
> > +       uint32_t size;
> > +       uint32_t cd_offset;
> > +       uint32_t cd_records;
> > +};
> > +
> 
> $ rg -w 'uint\d\d_t' | wc -l
> 21
> $ rg -w '__u\d\d' | wc -l
> 873
> 
> seems like we overwhelmingly prefer __u32/__u16 in libbpf code base,
> let's use those instead?

Sure.

> > +static void *check_access(struct zip_archive *archive, uint32_t offset, uint32_t size)
> > +{
> > +       if (offset + size > archive->size || offset > offset + size) {
> > +               return NULL;
> > +       }
> > +       return archive->data + offset;
> > +}
> > +
> > +/* Returns 0 on success, -1 on error and -2 if the eocd indicates
> 
> let's use -EINVAL and -ENOTSUP instead of -1 and -2

Sure.

> > + * the archive uses features which are not supported.
> > + */
> > +static int try_parse_end_of_central_directory(struct zip_archive *archive, uint32_t offset)
> > +{
> > +       struct end_of_central_directory_record *eocd =
> > +               check_access(archive, offset, sizeof(struct end_of_central_directory_record));
> > +       uint16_t comment_length, cd_records;
> > +       uint32_t cd_offset, cd_size;
> > +
> > +       if (!eocd || unaligned_uint32_read(eocd->magic) != END_OF_CD_RECORD_MAGIC) {
> > +               return -1;
> > +       }
> > +
> > +       comment_length = unaligned_uint16_read(eocd->comment_length);
> > +       if (offset + sizeof(struct end_of_central_directory_record) + comment_length !=
> > +           archive->size) {
> > +               return -1;
> > +       }
> > +
> > +       cd_records = unaligned_uint16_read(eocd->cd_records);
> > +       if (unaligned_uint16_read(eocd->this_disk) != 0 ||
> > +           unaligned_uint16_read(eocd->cd_disk) != 0 ||
> > +           unaligned_uint16_read(eocd->cd_records_total) != cd_records) {
> > +               /* This is a valid eocd, but we only support single-file non-ZIP64 archives. */
> > +               return -2;
> > +       }
> > +
> > +       cd_offset = unaligned_uint32_read(eocd->cd_offset);
> > +       cd_size = unaligned_uint32_read(eocd->cd_size);
> > +       if (!check_access(archive, cd_offset, cd_size)) {
> > +               return -1;
> > +       }
> > +
> > +       archive->cd_offset = cd_offset;
> > +       archive->cd_records = cd_records;
> > +       return 0;
> > +}
> > +
> > +static int find_central_directory(struct zip_archive *archive)
> > +{
> > +       uint32_t offset;
> > +       int64_t limit;
> > +       int rc = -1;
> > +
> > +       if (archive->size <= sizeof(struct end_of_central_directory_record)) {
> > +               return -1;
> > +       }
> > +
> > +       /* Because the end of central directory ends with a variable length array of
> > +        * up to 0xFFFF bytes we can't know exactly where it starts and need to
> > +        * search for it at the end of the file, scanning the (limit, offset] range.
> > +        */
> > +       offset = archive->size - sizeof(struct end_of_central_directory_record);
> > +       limit = (int64_t)offset - (1 << 16);
> > +
> > +       for (; offset >= 0 && offset > limit && rc == -1; offset--) {
> > +               rc = try_parse_end_of_central_directory(archive, offset);
> > +       }
> > +
> > +       return rc;
> > +}
> > +
> > +struct zip_archive *zip_archive_open(const char *path)
> > +{
> > +       struct zip_archive *archive;
> > +       int fd = open(path, O_RDONLY);
> 
> let's not do complicated operations during variable initialization,
> let's just init fd right before checking it for <0
> 
> > +       off_t size;
> > +       void *data;
> > +
> > +       if (fd < 0) {
> > +               return NULL;
> > +       }
> 
> no {} for single-line if statement
> 
> > +
> > +       size = lseek(fd, 0, SEEK_END);
> > +       if (size == (off_t)-1 || size > UINT32_MAX) {
> > +               close(fd);
> > +               return NULL;
> > +       }
> > +
> > +       data = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
> > +       close(fd);
> > +
> > +       if (data == MAP_FAILED) {
> > +               return NULL;
> > +       }
> 
> ditto about {}
> 
> > +
> > +       archive = malloc(sizeof(struct zip_archive));
> > +       if (!archive) {
> > +               munmap(data, size);
> > +               return NULL;
> > +       };
> > +
> > +       archive->data = data;
> > +       archive->size = size;
> > +       if (find_central_directory(archive)) {
> > +               munmap(data, size);
> > +               free(archive);
> > +               archive = NULL;
> 
> return NULL; ?
> 
> > +       }
> > +
> > +       return archive;
> > +}
> > +
> > +void zip_archive_close(struct zip_archive *archive)
> > +{
> > +       munmap(archive->data, archive->size);
> > +       free(archive);
> > +}
> > +
> > +static struct local_file_header *local_file_header_at_offset(struct zip_archive *archive,
> > +                                                            uint32_t offset)
> 
> is there a non-local file in ZIP archive? Seems a bit too verbose,
> just "file_header_at_offset"? and seeing "get_entry_at_offset" below,
> should it be "get_file_header_at_offset" then?

It's called that by the standard. See section 4.3.7  Local file header in
https://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT

> > +{
> > +       struct local_file_header *lfh =
> > +               check_access(archive, offset, sizeof(struct local_file_header));
> 
> empty line between variables and code
> 
> > +       if (!lfh || unaligned_uint32_read(lfh->magic) != LOCAL_FILE_HEADER_MAGIC) {
> > +               return NULL;
> > +       }
> 
> here and below, same {} issue
> 
> > +       return lfh;
> > +}
> > +
> > +static int get_entry_at_offset(struct zip_archive *archive, uint32_t offset, struct zip_entry *out)
> > +{
> > +       struct local_file_header *lfh = local_file_header_at_offset(archive, offset);
> 
> same as above, let's not do extensive operations during variable
> initialization, please split
> 
> > +       uint16_t flags, name_length, extra_field_length;
> > +       uint32_t compressed_size;
> > +       const char *name;
> > +       void *data;
> > +
> > +       offset += sizeof(struct local_file_header);
> 
> logically this probably should happen after we checked lfh for NULL?

Sure.

> > +       if (!lfh) {
> > +               return -1;
> 
> here and everywhere, let's use kernel error code constants, e.g., -EINVAL

Sure.

> > +       };
> > +
> > +       flags = unaligned_uint16_read(lfh->flags);
> > +       if ((flags & FLAG_ENCRYPTED) || (flags & FLAG_HAS_DATA_DESCRIPTOR)) {
> > +               return -1;
> > +       }
> > +
> > +       name_length = unaligned_uint16_read(lfh->file_name_length);
> > +       name = check_access(archive, offset, name_length);
> > +       offset += name_length;
> > +       if (!name) {
> > +               return -1;
> > +       }
> > +
> > +       extra_field_length = unaligned_uint16_read(lfh->extra_field_length);
> > +       if (!check_access(archive, offset, extra_field_length)) {
> > +               return -1;
> > +       }
> > +       offset += extra_field_length;
> > +
> > +       compressed_size = unaligned_uint32_read(lfh->compressed_size);
> 
> why not fill out out->data_length instead of all these local variables?

Because the function contract is that 'out' is left untouched on error.

> > +       data = check_access(archive, offset, compressed_size);
> > +       if (!data) {
> > +               return -1;
> > +       }
> > +
> > +       out->compression = unaligned_uint16_read(lfh->compression);
> > +       out->name_length = name_length;
> > +       out->name = name;
> > +       out->data = data;
> > +       out->data_length = compressed_size;
> > +       out->data_offset = offset;
> > +
> > +       return 0;
> > +}
> > +
> > +static struct central_directory_file_header *cd_file_header_at_offset(struct zip_archive *archive,
> > +                                                                     uint32_t offset)
> 
> this function is called just once below, why a helper?

Will inline it.

> > +{
> > +       struct central_directory_file_header *cdfh =
> > +               check_access(archive, offset, sizeof(struct central_directory_file_header));
> 
> empty line
> 
> > +       if (!cdfh || unaligned_uint32_read(cdfh->magic) != CD_FILE_HEADER_MAGIC) {
> > +               return NULL;
> > +       }
> > +       return cdfh;
> > +}
> > +
> > +int zip_archive_find_entry(struct zip_archive *archive, const char *file_name,
> > +                          struct zip_entry *out)
> > +{
> > +       size_t file_name_length = strlen(file_name);
> > +
> 
> no need for empty line, let's keep variable declarations in one block
> 
> > +       uint32_t i, offset = archive->cd_offset;
> > +
> > +       for (i = 0; i < archive->cd_records; ++i) {
> > +               struct central_directory_file_header *cdfh =
> > +                       cd_file_header_at_offset(archive, offset);
> > +               uint16_t cdfh_name_length, cdfh_flags;
> > +               const char *cdfh_name;
> > +
> > +               offset += sizeof(struct central_directory_file_header);
> 
> same, logically offset should be updated after we made sure we have
> cd_file_header
> 
> > +               if (!cdfh) {
> > +                       return -1;
> > +               }
> > +
> > +               cdfh_name_length = unaligned_uint16_read(cdfh->file_name_length);
> > +               cdfh_name = check_access(archive, offset, cdfh_name_length);
> > +               if (!cdfh_name) {
> > +                       return -1;
> > +               }
> > +
> > +               cdfh_flags = unaligned_uint16_read(cdfh->flags);
> > +               if ((cdfh_flags & FLAG_ENCRYPTED) == 0 &&
> > +                   (cdfh_flags & FLAG_HAS_DATA_DESCRIPTOR) == 0 &&
> > +                   file_name_length == cdfh_name_length &&
> > +                   memcmp(file_name, archive->data + offset, file_name_length) == 0) {
> > +                       return get_entry_at_offset(archive, unaligned_uint32_read(cdfh->offset),
> > +                                                  out);
> > +               }
> > +
> > +               offset += cdfh_name_length;
> > +               offset += unaligned_uint16_read(cdfh->extra_field_length);
> > +               offset += unaligned_uint16_read(cdfh->file_comment_length);
> > +       }
> > +
> > +       return -1;
> > +}
> > diff --git a/tools/lib/bpf/zip.h b/tools/lib/bpf/zip.h
> > new file mode 100644
> > index 0000000..a9083f
> > --- /dev/null
> > +++ b/tools/lib/bpf/zip.h
> > @@ -0,0 +1,47 @@
> > +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> > +
> > +#ifndef __LIBBPF_ZIP_H
> > +#define __LIBBPF_ZIP_H
> > +
> > +#include <stdint.h>
> > +
> > +/* Represents an opened zip archive.
> 
> s/opened/open/
> 
> 
> > + * Only basic ZIP files are supported, in particular the following are not
> > + * supported:
> > + * - encryption
> > + * - streaming
> > + * - multi-part ZIP files
> > + * - ZIP64
> > + */
> > +struct zip_archive;
> > +
> > +/* Carries information on name, compression method, and data corresponding to a
> > + * file in a zip archive.
> > + */
> > +struct zip_entry {
> > +       /* Compression method as defined in pkzip spec. 0 means data is uncompressed. */
> > +       uint16_t compression;
> > +
> > +       /* Non-null terminated name of the file. */
> > +       const char *name;
> > +       /* Length of the file name. */
> > +       uint16_t name_length;
> > +
> > +       /* Pointer to the file data. */
> > +       const void *data;
> > +       /* Length of the file data. */
> > +       uint32_t data_length;
> > +       /* Offset of the file data within the archive. */
> > +       uint32_t data_offset;
> > +};
> > +
> > +/* Open a zip archive. Returns NULL in case of an error. */
> > +struct zip_archive *zip_archive_open(const char *path);
> > +
> > +/* Close a zip archive and release resources. */
> > +void zip_archive_close(struct zip_archive *archive);
> > +
> > +/* Look up an entry corresponding to a file in given zip archive. */
> > +int zip_archive_find_entry(struct zip_archive *archive, const char *name, struct zip_entry *out);
> > +
> > +#endif
> > --
> > 2.30.2
> >
