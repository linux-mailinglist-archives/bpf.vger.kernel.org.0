Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31E069B69A
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 01:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBRAKW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 19:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBRAKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 19:10:21 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B04466CCB
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 16:10:19 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m17so10832836edc.9
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 16:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdH6p+rTThz9OqD7IzzfKLd1vLggkyZ2bSQP5OQOhKs=;
        b=jvw/L/E4xVYhL+gkW3Ngxgpcl0GTzlcptXqfFCIg7gxBZQhf1kFG6/xUW78gRkYh1f
         GIWMD6UTVad/96E0AC6AM8S9GB4iNwgJl7cE+rA5hsT63Ilh2emuNZ73+xegpT28VsVs
         NkPlyxukPKpirPAXSVfLWarXzX4FdL/Yalo5wiTUJaW7UZt6z5lfbYTGwMpKdT/9Z/gN
         6K6HQpxZhN4meXKVcIQGQiKneA4wrb1RuzRUjuivdFz77ACtI5nGNVL5WM05G/Py/zS2
         dU2XD5waDZpm3Q5lyUZVBFxWL+SRWx1sH0UNvvVV2Wm9ciR/i7SNgMwfSN1IQSwtVPOH
         fozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdH6p+rTThz9OqD7IzzfKLd1vLggkyZ2bSQP5OQOhKs=;
        b=x0FIF+lvtG6B/0BQU6A04StR2fhdhG1vRhqTbO6eUr2AptGNmCm8WGNniY3MNnWTQ4
         FCDM/gK8BU0A+ngHP/dEOpXDfRFd8AXmXWSjplgaqOVu4uRIf7s6mV5EZYj+h3BTW3uV
         OKlq+ezqbWuNITlQO+HYInn6c4vgjYoJ5po6ynvsbAohMtxjU59pNOX7eo9dxNRGKZDN
         f4MqET3xsdDXSDiM2m62n2HKSivxHuZa2n3cmlSmPqBJoUrdHq8QJn7ycMnhsJq1D6rd
         peRDu8GEHYf0xdphKaTcHLD2JNWkH8kBjkLHtTNV8yW/+yD0pcifwWF2qaMvmAHJ8WpY
         rg/A==
X-Gm-Message-State: AO0yUKVB62bwMXtKn5LaovTLe0T6hoEpz4vxU2V1EmMGzyn7m40CkyWC
        VW5A+XL8Gg2B9it9XzeeDlSV17Ze7KfSFN/6GML8l4lM
X-Google-Smtp-Source: AK7set9mGSpF43YXgz0ynfBAfzkAR4TUutfjdLWWf0qvRXHPqHeN4veZoVuEWW39SBikrI74sx42GnaYsyQxMO/Y07s=
X-Received: by 2002:a50:9f2f:0:b0:4ac:b626:378e with SMTP id
 b44-20020a509f2f000000b004acb626378emr1621611edf.5.1676679017231; Fri, 17 Feb
 2023 16:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20230217191908.1000004-1-deso@posteo.net> <20230217191908.1000004-2-deso@posteo.net>
In-Reply-To: <20230217191908.1000004-2-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Feb 2023 16:10:04 -0800
Message-ID: <CAEf4BzZkKFLbBD2uh8fTb+tvtLf713RkmAW8Bg+53RNUELkLGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] libbpf: Implement basic zip archive parsing support
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
        "michalgr@meta.com" <michalgr@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 17, 2023 at 11:19 AM Daniel M=C3=BCller <deso@posteo.net> wrote=
:
>
> This change implements support for reading zip archives, including
> opening an archive, finding an entry based on its path and name in it,
> and closing it.
> The code was copied from https://github.com/iovisor/bcc/pull/4440, which
> implements similar functionality for bcc. The author confirmed that he
> is fine with this usage and the corresponding relicensing. I adjusted it
> to adhere to libbpf coding standards.

Let's record this with

Acked-by: Micha=C5=82 Gregorczyk <michalgr@meta.com>

tag added next to your Signed-off-by. I've added Michal to cc for visibilit=
y.

>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> ---
>  tools/lib/bpf/Build |   2 +-
>  tools/lib/bpf/zip.c | 378 ++++++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/zip.h |  47 ++++++
>  3 files changed, 426 insertions(+), 1 deletion(-)
>  create mode 100644 tools/lib/bpf/zip.c
>  create mode 100644 tools/lib/bpf/zip.h
>
> diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
> index 5a3dfb..b8b0a63 100644
> --- a/tools/lib/bpf/Build
> +++ b/tools/lib/bpf/Build
> @@ -1,4 +1,4 @@
>  libbpf-y :=3D libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
>             netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
>             btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core=
.o \
> -           usdt.o
> +           usdt.o zip.o
> diff --git a/tools/lib/bpf/zip.c b/tools/lib/bpf/zip.c
> new file mode 100644
> index 0000000..59ec79
> --- /dev/null
> +++ b/tools/lib/bpf/zip.c
> @@ -0,0 +1,378 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +/*
> + * Routines for dealing with .zip archives.
> + *
> + * Copyright (c) Meta Platforms, Inc. and affiliates.
> + */
> +
> +#include <fcntl.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +
> +#include "zip.h"
> +
> +/* Specification of ZIP file format can be found here:
> + * https://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT
> + * For a high level overview of the structure of a ZIP file see
> + * sections 4.3.1 - 4.3.6.
> + *
> + * Data structures appearing in ZIP files do not contain any
> + * padding and they might be misaligned. To allow us to safely
> + * operate on pointers to such structures and their members, without
> + * worrying of platform specific alignment issues, we define
> + * unaligned_uint16_t and unaligned_uint32_t types with no alignment
> + * requirements.
> + */
> +typedef struct {
> +       uint8_t raw[2];
> +} unaligned_uint16_t;
> +
> +static uint16_t unaligned_uint16_read(unaligned_uint16_t value)
> +{
> +       uint16_t return_value;
> +
> +       memcpy(&return_value, value.raw, sizeof(return_value));
> +       return return_value;
> +}
> +
> +typedef struct {
> +       uint8_t raw[4];
> +} unaligned_uint32_t;
> +
> +static uint32_t unaligned_uint32_read(unaligned_uint32_t value)
> +{
> +       uint32_t return_value;
> +
> +       memcpy(&return_value, value.raw, sizeof(return_value));
> +       return return_value;
> +}

it feels like an overkill to use this unaligned_xxx_t approach. Let's
use __attribute__((packed)) on corresponding structs and just
uint16_t/uint32_t field types.

> +
> +#define END_OF_CD_RECORD_MAGIC 0x06054b50
> +
> +/* See section 4.3.16 of the spec. */
> +struct end_of_central_directory_record {
> +       /* Magic value equal to END_OF_CD_RECORD_MAGIC */
> +       unaligned_uint32_t magic;
> +
> +       /* Number of the file containing this structure or 0xFFFF if ZIP6=
4 archive.
> +        * Zip archive might span multiple files (disks).
> +        */
> +       unaligned_uint16_t this_disk;
> +
> +       /* Number of the file containing the beginning of the central dir=
ectory or
> +        * 0xFFFF if ZIP64 archive.
> +        */
> +       unaligned_uint16_t cd_disk;
> +
> +       /* Number of central directory records on this disk or 0xFFFF if =
ZIP64
> +        * archive.
> +        */
> +       unaligned_uint16_t cd_records;
> +
> +       /* Number of central directory records on all disks or 0xFFFF if =
ZIP64
> +        * archive.
> +        */
> +       unaligned_uint16_t cd_records_total;
> +
> +       /* Size of the central directory recrod or 0xFFFFFFFF if ZIP64 ar=
chive. */

typo: record

> +       unaligned_uint32_t cd_size;
> +
> +       /* Offset of the central directory from the beginning of the arch=
ive or
> +        * 0xFFFFFFFF if ZIP64 archive.
> +        */
> +       unaligned_uint32_t cd_offset;
> +
> +       /* Length of comment data following end of central driectory reco=
rd. */

typo: directory


> +       unaligned_uint16_t comment_length;
> +
> +       /* Up to 64k of arbitrary bytes. */
> +       /* uint8_t comment[comment_length] */
> +};
> +
> +#define CD_FILE_HEADER_MAGIC 0x02014b50
> +#define FLAG_ENCRYPTED (1 << 0)
> +#define FLAG_HAS_DATA_DESCRIPTOR (1 << 3)
> +
> +/* See section 4.3.12 of the spec. */
> +struct central_directory_file_header {


naming nit here and below: we use CD in constants, but spell out
"central_directory", which feels a bit mouthful. Let's use "cd"
consistently throughout (even if it's a bit confusing with "change
directory", but I think in the context of parsing ZIP contents should
be recognizable enough)

> +       /* Magic value equal to CD_FILE_HEADER_MAGIC. */
> +       unaligned_uint32_t magic;
> +       unaligned_uint16_t version;
> +       /* Minimum zip version needed to extract the file. */
> +       unaligned_uint16_t min_version;
> +       unaligned_uint16_t flags;
> +       unaligned_uint16_t compression;
> +       unaligned_uint16_t last_modified_time;
> +       unaligned_uint16_t last_modified_date;
> +       unaligned_uint32_t crc;
> +       unaligned_uint32_t compressed_size;
> +       unaligned_uint32_t uncompressed_size;
> +       unaligned_uint16_t file_name_length;
> +       unaligned_uint16_t extra_field_length;
> +       unaligned_uint16_t file_comment_length;
> +       /* Number of the disk where the file starts or 0xFFFF if ZIP64 ar=
chive. */
> +       unaligned_uint16_t disk;
> +       unaligned_uint16_t internal_attributes;
> +       unaligned_uint32_t external_attributes;
> +       /* Offset from the start of the disk containing the local file he=
ader to the
> +        * start of the local file header.
> +        */
> +       unaligned_uint32_t offset;
> +};
> +
> +#define LOCAL_FILE_HEADER_MAGIC 0x04034b50
> +
> +/* See section 4.3.7 of the spec. */
> +struct local_file_header {
> +       /* Magic value equal to LOCAL_FILE_HEADER_MAGIC. */
> +       unaligned_uint32_t magic;
> +       /* Minimum zip version needed to extract the file. */
> +       unaligned_uint16_t min_version;
> +       unaligned_uint16_t flags;
> +       unaligned_uint16_t compression;
> +       unaligned_uint16_t last_modified_time;
> +       unaligned_uint16_t last_modified_date;
> +       unaligned_uint32_t crc;
> +       unaligned_uint32_t compressed_size;
> +       unaligned_uint32_t uncompressed_size;
> +       unaligned_uint16_t file_name_length;
> +       unaligned_uint16_t extra_field_length;
> +};
> +
> +struct zip_archive {
> +       void *data;
> +       uint32_t size;
> +       uint32_t cd_offset;
> +       uint32_t cd_records;
> +};
> +

$ rg -w 'uint\d\d_t' | wc -l
21
$ rg -w '__u\d\d' | wc -l
873

seems like we overwhelmingly prefer __u32/__u16 in libbpf code base,
let's use those instead?

> +static void *check_access(struct zip_archive *archive, uint32_t offset, =
uint32_t size)
> +{
> +       if (offset + size > archive->size || offset > offset + size) {
> +               return NULL;
> +       }
> +       return archive->data + offset;
> +}
> +
> +/* Returns 0 on success, -1 on error and -2 if the eocd indicates

let's use -EINVAL and -ENOTSUP instead of -1 and -2

> + * the archive uses features which are not supported.
> + */
> +static int try_parse_end_of_central_directory(struct zip_archive *archiv=
e, uint32_t offset)
> +{
> +       struct end_of_central_directory_record *eocd =3D
> +               check_access(archive, offset, sizeof(struct end_of_centra=
l_directory_record));
> +       uint16_t comment_length, cd_records;
> +       uint32_t cd_offset, cd_size;
> +
> +       if (!eocd || unaligned_uint32_read(eocd->magic) !=3D END_OF_CD_RE=
CORD_MAGIC) {
> +               return -1;
> +       }
> +
> +       comment_length =3D unaligned_uint16_read(eocd->comment_length);
> +       if (offset + sizeof(struct end_of_central_directory_record) + com=
ment_length !=3D
> +           archive->size) {
> +               return -1;
> +       }
> +
> +       cd_records =3D unaligned_uint16_read(eocd->cd_records);
> +       if (unaligned_uint16_read(eocd->this_disk) !=3D 0 ||
> +           unaligned_uint16_read(eocd->cd_disk) !=3D 0 ||
> +           unaligned_uint16_read(eocd->cd_records_total) !=3D cd_records=
) {
> +               /* This is a valid eocd, but we only support single-file =
non-ZIP64 archives. */
> +               return -2;
> +       }
> +
> +       cd_offset =3D unaligned_uint32_read(eocd->cd_offset);
> +       cd_size =3D unaligned_uint32_read(eocd->cd_size);
> +       if (!check_access(archive, cd_offset, cd_size)) {
> +               return -1;
> +       }
> +
> +       archive->cd_offset =3D cd_offset;
> +       archive->cd_records =3D cd_records;
> +       return 0;
> +}
> +
> +static int find_central_directory(struct zip_archive *archive)
> +{
> +       uint32_t offset;
> +       int64_t limit;
> +       int rc =3D -1;
> +
> +       if (archive->size <=3D sizeof(struct end_of_central_directory_rec=
ord)) {
> +               return -1;
> +       }
> +
> +       /* Because the end of central directory ends with a variable leng=
th array of
> +        * up to 0xFFFF bytes we can't know exactly where it starts and n=
eed to
> +        * search for it at the end of the file, scanning the (limit, off=
set] range.
> +        */
> +       offset =3D archive->size - sizeof(struct end_of_central_directory=
_record);
> +       limit =3D (int64_t)offset - (1 << 16);
> +
> +       for (; offset >=3D 0 && offset > limit && rc =3D=3D -1; offset--)=
 {
> +               rc =3D try_parse_end_of_central_directory(archive, offset=
);
> +       }
> +
> +       return rc;
> +}
> +
> +struct zip_archive *zip_archive_open(const char *path)
> +{
> +       struct zip_archive *archive;
> +       int fd =3D open(path, O_RDONLY);

let's not do complicated operations during variable initialization,
let's just init fd right before checking it for <0

> +       off_t size;
> +       void *data;
> +
> +       if (fd < 0) {
> +               return NULL;
> +       }

no {} for single-line if statement

> +
> +       size =3D lseek(fd, 0, SEEK_END);
> +       if (size =3D=3D (off_t)-1 || size > UINT32_MAX) {
> +               close(fd);
> +               return NULL;
> +       }
> +
> +       data =3D mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
> +       close(fd);
> +
> +       if (data =3D=3D MAP_FAILED) {
> +               return NULL;
> +       }

ditto about {}

> +
> +       archive =3D malloc(sizeof(struct zip_archive));
> +       if (!archive) {
> +               munmap(data, size);
> +               return NULL;
> +       };
> +
> +       archive->data =3D data;
> +       archive->size =3D size;
> +       if (find_central_directory(archive)) {
> +               munmap(data, size);
> +               free(archive);
> +               archive =3D NULL;

return NULL; ?

> +       }
> +
> +       return archive;
> +}
> +
> +void zip_archive_close(struct zip_archive *archive)
> +{
> +       munmap(archive->data, archive->size);
> +       free(archive);
> +}
> +
> +static struct local_file_header *local_file_header_at_offset(struct zip_=
archive *archive,
> +                                                            uint32_t off=
set)

is there a non-local file in ZIP archive? Seems a bit too verbose,
just "file_header_at_offset"? and seeing "get_entry_at_offset" below,
should it be "get_file_header_at_offset" then?

> +{
> +       struct local_file_header *lfh =3D
> +               check_access(archive, offset, sizeof(struct local_file_he=
ader));

empty line between variables and code

> +       if (!lfh || unaligned_uint32_read(lfh->magic) !=3D LOCAL_FILE_HEA=
DER_MAGIC) {
> +               return NULL;
> +       }

here and below, same {} issue

> +       return lfh;
> +}
> +
> +static int get_entry_at_offset(struct zip_archive *archive, uint32_t off=
set, struct zip_entry *out)
> +{
> +       struct local_file_header *lfh =3D local_file_header_at_offset(arc=
hive, offset);

same as above, let's not do extensive operations during variable
initialization, please split

> +       uint16_t flags, name_length, extra_field_length;
> +       uint32_t compressed_size;
> +       const char *name;
> +       void *data;
> +
> +       offset +=3D sizeof(struct local_file_header);

logically this probably should happen after we checked lfh for NULL?

> +       if (!lfh) {
> +               return -1;

here and everywhere, let's use kernel error code constants, e.g., -EINVAL

> +       };
> +
> +       flags =3D unaligned_uint16_read(lfh->flags);
> +       if ((flags & FLAG_ENCRYPTED) || (flags & FLAG_HAS_DATA_DESCRIPTOR=
)) {
> +               return -1;
> +       }
> +
> +       name_length =3D unaligned_uint16_read(lfh->file_name_length);
> +       name =3D check_access(archive, offset, name_length);
> +       offset +=3D name_length;
> +       if (!name) {
> +               return -1;
> +       }
> +
> +       extra_field_length =3D unaligned_uint16_read(lfh->extra_field_len=
gth);
> +       if (!check_access(archive, offset, extra_field_length)) {
> +               return -1;
> +       }
> +       offset +=3D extra_field_length;
> +
> +       compressed_size =3D unaligned_uint32_read(lfh->compressed_size);

why not fill out out->data_length instead of all these local variables?

> +       data =3D check_access(archive, offset, compressed_size);
> +       if (!data) {
> +               return -1;
> +       }
> +
> +       out->compression =3D unaligned_uint16_read(lfh->compression);
> +       out->name_length =3D name_length;
> +       out->name =3D name;
> +       out->data =3D data;
> +       out->data_length =3D compressed_size;
> +       out->data_offset =3D offset;
> +
> +       return 0;
> +}
> +
> +static struct central_directory_file_header *cd_file_header_at_offset(st=
ruct zip_archive *archive,
> +                                                                     uin=
t32_t offset)

this function is called just once below, why a helper?

> +{
> +       struct central_directory_file_header *cdfh =3D
> +               check_access(archive, offset, sizeof(struct central_direc=
tory_file_header));

empty line

> +       if (!cdfh || unaligned_uint32_read(cdfh->magic) !=3D CD_FILE_HEAD=
ER_MAGIC) {
> +               return NULL;
> +       }
> +       return cdfh;
> +}
> +
> +int zip_archive_find_entry(struct zip_archive *archive, const char *file=
_name,
> +                          struct zip_entry *out)
> +{
> +       size_t file_name_length =3D strlen(file_name);
> +

no need for empty line, let's keep variable declarations in one block

> +       uint32_t i, offset =3D archive->cd_offset;
> +
> +       for (i =3D 0; i < archive->cd_records; ++i) {
> +               struct central_directory_file_header *cdfh =3D
> +                       cd_file_header_at_offset(archive, offset);
> +               uint16_t cdfh_name_length, cdfh_flags;
> +               const char *cdfh_name;
> +
> +               offset +=3D sizeof(struct central_directory_file_header);

same, logically offset should be updated after we made sure we have
cd_file_header

> +               if (!cdfh) {
> +                       return -1;
> +               }
> +
> +               cdfh_name_length =3D unaligned_uint16_read(cdfh->file_nam=
e_length);
> +               cdfh_name =3D check_access(archive, offset, cdfh_name_len=
gth);
> +               if (!cdfh_name) {
> +                       return -1;
> +               }
> +
> +               cdfh_flags =3D unaligned_uint16_read(cdfh->flags);
> +               if ((cdfh_flags & FLAG_ENCRYPTED) =3D=3D 0 &&
> +                   (cdfh_flags & FLAG_HAS_DATA_DESCRIPTOR) =3D=3D 0 &&
> +                   file_name_length =3D=3D cdfh_name_length &&
> +                   memcmp(file_name, archive->data + offset, file_name_l=
ength) =3D=3D 0) {
> +                       return get_entry_at_offset(archive, unaligned_uin=
t32_read(cdfh->offset),
> +                                                  out);
> +               }
> +
> +               offset +=3D cdfh_name_length;
> +               offset +=3D unaligned_uint16_read(cdfh->extra_field_lengt=
h);
> +               offset +=3D unaligned_uint16_read(cdfh->file_comment_leng=
th);
> +       }
> +
> +       return -1;
> +}
> diff --git a/tools/lib/bpf/zip.h b/tools/lib/bpf/zip.h
> new file mode 100644
> index 0000000..a9083f
> --- /dev/null
> +++ b/tools/lib/bpf/zip.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> +
> +#ifndef __LIBBPF_ZIP_H
> +#define __LIBBPF_ZIP_H
> +
> +#include <stdint.h>
> +
> +/* Represents an opened zip archive.

s/opened/open/


> + * Only basic ZIP files are supported, in particular the following are n=
ot
> + * supported:
> + * - encryption
> + * - streaming
> + * - multi-part ZIP files
> + * - ZIP64
> + */
> +struct zip_archive;
> +
> +/* Carries information on name, compression method, and data correspondi=
ng to a
> + * file in a zip archive.
> + */
> +struct zip_entry {
> +       /* Compression method as defined in pkzip spec. 0 means data is u=
ncompressed. */
> +       uint16_t compression;
> +
> +       /* Non-null terminated name of the file. */
> +       const char *name;
> +       /* Length of the file name. */
> +       uint16_t name_length;
> +
> +       /* Pointer to the file data. */
> +       const void *data;
> +       /* Length of the file data. */
> +       uint32_t data_length;
> +       /* Offset of the file data within the archive. */
> +       uint32_t data_offset;
> +};
> +
> +/* Open a zip archive. Returns NULL in case of an error. */
> +struct zip_archive *zip_archive_open(const char *path);
> +
> +/* Close a zip archive and release resources. */
> +void zip_archive_close(struct zip_archive *archive);
> +
> +/* Look up an entry corresponding to a file in given zip archive. */
> +int zip_archive_find_entry(struct zip_archive *archive, const char *name=
, struct zip_entry *out);
> +
> +#endif
> --
> 2.30.2
>
