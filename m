Return-Path: <bpf+bounces-1881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B7872326C
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 23:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077F01C20D20
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 21:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFAF27700;
	Mon,  5 Jun 2023 21:41:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2C727202
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 21:41:05 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FADDF2
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 14:41:03 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so4959152e87.2
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686001262; x=1688593262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMK5bPeC0Cy0/4xUsMZMTHgPZzRVlDx9gfMo0caFNXI=;
        b=bPzm8YJWbL/SDsdloKznj35gLIyxmyQzmsEhgS/JbHNd+V8iGAR2KfTt33h1s8tjM9
         EPRs936hE3APRcdbll0acggZARiNSXh4Wg0oqV/5AG/gwRdtLUy4AncyPmb3ocOAszky
         880j++5ZHatG3W6/UezUfyQKoqjFuFE+PLOSBsOD/AiY3Burld4RXLylRPws/uQKKhVN
         WVLCccG93+T0vJnc0+MbPaX1YAN1pZf72IirLBRYhLAOCsbGjm2dhiAFoFC9ByZBGAvx
         vexWPmQk4UUo6EF7/ybTok/1Fq84xqVSQ3vay2vuk4Yl0oRpZzNXRc8pHz4WwhPDMH54
         z0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686001262; x=1688593262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMK5bPeC0Cy0/4xUsMZMTHgPZzRVlDx9gfMo0caFNXI=;
        b=k3KSJ+B94oylSFMVWnhmQ0r4DNGMhGT4yJXkroKA/naFGaFWuAtaB9eeG7wnI1eIoM
         cCGqzh0dA1DpNecjR1GypDbTIc7bUfDriGToHi0xCIQM3Ijq79Sf2vgOe7fcDx8oHMeI
         GTxzR96W1ORzGtzMKiqUR2hwrixW0fu1hovQYOPQDM49fVLHczVizhceGsnL95L6au+k
         XX94FcQNHaI8shmYjQV9RMhXUpls3gurOfu2uu39ZtJacI0M0YRfl1i+hmMzTVs3J4Hi
         5cUISQTcV6+FMk7w07FOb9WU43NhegrnGXZdPZxduVPgxN4nNXps3OCSU41uhx7wAUfj
         STKA==
X-Gm-Message-State: AC+VfDxTHOwUg+QxTIOe9JlfWBYHVYMFkR8VnapL8dGuLMkfD/eirCAr
	e/O6INosnppwMBlqNke+YK+7E5yOlG2LfmFpYcc=
X-Google-Smtp-Source: ACHHUZ7xGKcWHkSNJKQd/UalZ+eRPVKZJR42e3B67cN8zgOsHEBlp7jqV/R1uOaUX22mHiquA2f9kPbdhT+D58d7ff8=
X-Received: by 2002:a2e:988e:0:b0:2a8:bd1f:a377 with SMTP id
 b14-20020a2e988e000000b002a8bd1fa377mr274199ljj.20.1686001261444; Mon, 05 Jun
 2023 14:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
 <20230531201936.1992188-3-alan.maguire@oracle.com> <ZH3AgcYeJPPxWJu3@krava>
In-Reply-To: <ZH3AgcYeJPPxWJu3@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jun 2023 14:40:49 -0700
Message-ID: <CAEf4Bzbd+E26m83uy4YUVHi=5n7UB8EcbVYzOhGpDm+L7YVweQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 2/8] libbpf: support handling of metadata section
 in BTF
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, acme@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, quentin@isovalent.com, mykolal@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 5, 2023 at 4:01=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Wed, May 31, 2023 at 09:19:29PM +0100, Alan Maguire wrote:
> > support reading in metadata, fixing endian issues on reading;
> > also support writing metadata section to raw BTF object.
> > There is not yet an API to populate the metadata with meaningful
> > information.
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  tools/lib/bpf/btf.c | 141 ++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 111 insertions(+), 30 deletions(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 8484b563b53d..036dc1505969 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/err.h>
> >  #include <linux/btf.h>
> >  #include <gelf.h>
> > +#include <zlib.h>
> >  #include "btf.h"
> >  #include "bpf.h"
> >  #include "libbpf.h"
> > @@ -39,36 +40,40 @@ struct btf {
> >
> >       /*
> >        * When BTF is loaded from an ELF or raw memory it is stored
> > -      * in a contiguous memory block. The hdr, type_data, and, strs_da=
ta
> > -      * point inside that memory region to their respective parts of B=
TF
> > -      * representation:
> > +      * in a contiguous memory block. The hdr, type_data, strs_data,
> > +      * and optional meta_data point inside that memory region to thei=
r
> > +      * respective parts of BTF representation:
> >        *
> > -      * +--------------------------------+
> > -      * |  Header  |  Types  |  Strings  |
> > -      * +--------------------------------+
> > -      * ^          ^         ^
> > -      * |          |         |
> > -      * hdr        |         |
> > -      * types_data-+         |
> > -      * strs_data------------+
> > +      * +--------------------------------+----------+
> > +      * |  Header  |  Types  |  Strings  | Metadata |
> > +      * +--------------------------------+----------+
> > +      * ^          ^         ^           ^
> > +      * |          |         |           |
> > +      * hdr        |         |           |
> > +      * types_data-+         |           |
> > +      * strs_data------------+           |
> > +      * meta_data------------------------+
> > +      *
> > +      * meta_data is optional.
> >        *
> >        * If BTF data is later modified, e.g., due to types added or
> >        * removed, BTF deduplication performed, etc, this contiguous
> > -      * representation is broken up into three independently allocated
> > -      * memory regions to be able to modify them independently.
> > +      * representation is broken up into three or four independently
> > +      * allocated memory regions to be able to modify them independent=
ly.
> >        * raw_data is nulled out at that point, but can be later allocat=
ed
> >        * and cached again if user calls btf__raw_data(), at which point
> > -      * raw_data will contain a contiguous copy of header, types, and
> > -      * strings:
> > +      * raw_data will contain a contiguous copy of header, types, stri=
ngs
> > +      * and (again optionally) metadata:
> >        *
> > -      * +----------+  +---------+  +-----------+
> > -      * |  Header  |  |  Types  |  |  Strings  |
> > -      * +----------+  +---------+  +-----------+
> > -      * ^             ^            ^
> > -      * |             |            |
> > -      * hdr           |            |
> > -      * types_data----+            |
> > -      * strset__data(strs_set)-----+
> > +      * +----------+  +---------+  +-----------+  +----------+
> > +      * |  Header  |  |  Types  |  |  Strings  |  | Metadata |
> > +      * +----------+  +---------+  +-----------+  +---------_+
> > +      * ^             ^            ^              ^
> > +      * |             |            |              |
> > +      * hdr           |            |              |
> > +      * types_data----+            |              |
> > +      * strset__data(strs_set)-----+              |
> > +      * meta_data---------------------------------+
> >        *
> >        *               +----------+---------+-----------+
> >        *               |  Header  |  Types  |  Strings  |
> > @@ -116,6 +121,8 @@ struct btf {
> >       /* whether strings are already deduplicated */
> >       bool strs_deduped;
> >
> > +     void *meta_data;
> > +
> >       /* BTF object FD, if loaded into kernel */
> >       int fd;
> >
> > @@ -215,6 +222,11 @@ static void btf_bswap_hdr(struct btf_header *h)
> >       h->type_len =3D bswap_32(h->type_len);
> >       h->str_off =3D bswap_32(h->str_off);
> >       h->str_len =3D bswap_32(h->str_len);
> > +     if (h->hdr_len >=3D sizeof(struct btf_header)) {
> > +             h->meta_header.meta_off =3D bswap_32(h->meta_header.meta_=
off);
> > +             h->meta_header.meta_len =3D bswap_32(h->meta_header.meta_=
len);
> > +     }
> > +
> >  }
> >
> >  static int btf_parse_hdr(struct btf *btf)
> > @@ -222,14 +234,17 @@ static int btf_parse_hdr(struct btf *btf)
> >       struct btf_header *hdr =3D btf->hdr;
> >       __u32 meta_left;
> >
> > -     if (btf->raw_size < sizeof(struct btf_header)) {
> > +     if (btf->raw_size < sizeof(struct btf_header) - sizeof(struct btf=
_meta_header)) {
> >               pr_debug("BTF header not found\n");
> >               return -EINVAL;
> >       }
> >
> >       if (hdr->magic =3D=3D bswap_16(BTF_MAGIC)) {
> > +             int swapped_len =3D bswap_32(hdr->hdr_len);
> > +
> >               btf->swapped_endian =3D true;
> > -             if (bswap_32(hdr->hdr_len) !=3D sizeof(struct btf_header)=
) {
> > +             if (swapped_len !=3D sizeof(struct btf_header) &&
> > +                 swapped_len !=3D sizeof(struct btf_header) - sizeof(s=
truct btf_meta_header)) {
> >                       pr_warn("Can't load BTF with non-native endiannes=
s due to unsupported header length %u\n",
> >                               bswap_32(hdr->hdr_len));
> >                       return -ENOTSUP;
> > @@ -285,6 +300,42 @@ static int btf_parse_str_sec(struct btf *btf)
> >       return 0;
> >  }
> >
> > +static void btf_bswap_meta(struct btf_metadata *meta, int len)
> > +{
> > +     struct btf_kind_meta *m =3D &meta->kind_meta[0];
> > +     struct btf_kind_meta *end =3D (void *)meta + len;
> > +
> > +     meta->flags =3D bswap_32(meta->flags);
> > +     meta->crc =3D bswap_32(meta->crc);
> > +     meta->base_crc =3D bswap_32(meta->base_crc);
> > +     meta->description_off =3D bswap_32(meta->description_off);
> > +
> > +     while (m < end) {
> > +             m->name_off =3D bswap_32(m->name_off);
> > +             m->flags =3D bswap_16(m->flags);
> > +             m++;
> > +     }
> > +}
> > +
> > +static int btf_parse_meta_sec(struct btf *btf)
> > +{
> > +     const struct btf_header *hdr =3D btf->hdr;
> > +
> > +     if (hdr->hdr_len < sizeof(struct btf_header) ||
> > +         !hdr->meta_header.meta_off || !hdr->meta_header.meta_len)
> > +             return 0;
>
> I'm trying to figure out how is the meta data optional, and it seems to b=
e
> in here, right? but hdr->meta_header.meta_off or hdr->meta_header.meta_le=
n
> must be set NULL or zero
>
> I'm getting crash when running btf test and it seems like correption when
> parsing BTF generated from clang, which does not have this meta support
>
> we do need clang support for this right? or bump version?

libbpf doesn't enforce that btf_header is all zeroes after last known
field (which until now was str_len). So the whole design of adding
fields to btf_header is backwards compatible from libbpf standpoint.

From the implementation standpoint, though, we should make our lives
simpler by not using btf->raw_data for btf_header, and instead do what
we do in kernel with bpf_attr. That is, have a local zero-initialized
copy, and overwrite it with data found in btf.


>
> thanks,
> jirka
>
>
> > +     if (hdr->meta_header.meta_len < sizeof(struct btf_metadata)) {
> > +             pr_debug("Invalid BTF metadata section\n");
> > +             return -EINVAL;
> > +     }
> > +     btf->meta_data =3D btf->raw_data + btf->hdr->hdr_len + btf->hdr->=
meta_header.meta_off;
> > +
> > +     if (btf->swapped_endian)
> > +             btf_bswap_meta(btf->meta_data, hdr->meta_header.meta_len)=
;
> > +
> > +     return 0;
> > +}
> > +
> >  static int btf_type_size(const struct btf_type *t)
> >  {
> >       const int base_size =3D sizeof(struct btf_type);
> > @@ -904,6 +955,7 @@ static struct btf *btf_new(const void *data, __u32 =
size, struct btf *base_btf)
> >       err =3D err ?: btf_parse_type_sec(btf);
> >       if (err)
> >               goto done;
> > +     err =3D btf_parse_meta_sec(btf);
> >
> >  done:
> >       if (err) {
> > @@ -1267,6 +1319,11 @@ static void *btf_get_raw_data(const struct btf *=
btf, __u32 *size, bool swap_endi
> >       }
> >
> >       data_sz =3D hdr->hdr_len + hdr->type_len + hdr->str_len;
> > +     if (btf->meta_data) {
> > +             data_sz =3D roundup(data_sz, 8);
> > +             data_sz +=3D hdr->meta_header.meta_len;
> > +             hdr->meta_header.meta_off =3D roundup(hdr->type_len + hdr=
->str_len, 8);
> > +     }
> >       data =3D calloc(1, data_sz);
> >       if (!data)
> >               return NULL;
> > @@ -1293,8 +1350,21 @@ static void *btf_get_raw_data(const struct btf *=
btf, __u32 *size, bool swap_endi
> >       p +=3D hdr->type_len;
> >
> >       memcpy(p, btf_strs_data(btf), hdr->str_len);
> > -     p +=3D hdr->str_len;
> > +     /* round up to 8 byte alignment to match offset above */
> > +     p =3D data + hdr->hdr_len + roundup(hdr->type_len + hdr->str_len,=
 8);
> > +
> > +     if (btf->meta_data) {
> > +             struct btf_metadata *meta =3D p;
> >
> > +             memcpy(p, btf->meta_data, hdr->meta_header.meta_len);
> > +             if (!swap_endian) {
> > +                     meta->crc =3D crc32(0L, (const Bytef *)&data, siz=
eof(data));
> > +                     meta->flags |=3D BTF_META_CRC_SET;
> > +             }
> > +             if (swap_endian)
> > +                     btf_bswap_meta(p, hdr->meta_header.meta_len);
> > +             p +=3D hdr->meta_header.meta_len;
> > +     }
> >       *size =3D data_sz;
> >       return data;
> >  err_out:
> > @@ -1425,13 +1495,13 @@ static void btf_invalidate_raw_data(struct btf =
*btf)
> >       }
> >  }
> >
> > -/* Ensure BTF is ready to be modified (by splitting into a three memor=
y
> > - * regions for header, types, and strings). Also invalidate cached
> > - * raw_data, if any.
> > +/* Ensure BTF is ready to be modified (by splitting into a three or fo=
ur memory
> > + * regions for header, types, strings and optional metadata). Also inv=
alidate
> > + * cached raw_data, if any.
> >   */
> >  static int btf_ensure_modifiable(struct btf *btf)
> >  {
> > -     void *hdr, *types;
> > +     void *hdr, *types, *meta =3D NULL;
> >       struct strset *set =3D NULL;
> >       int err =3D -ENOMEM;
> >
> > @@ -1446,9 +1516,17 @@ static int btf_ensure_modifiable(struct btf *btf=
)
> >       types =3D malloc(btf->hdr->type_len);
> >       if (!hdr || !types)
> >               goto err_out;
> > +     if (btf->hdr->hdr_len >=3D sizeof(struct btf_header)  &&
> > +         btf->hdr->meta_header.meta_off && btf->hdr->meta_header.meta_=
len) {
> > +             meta =3D calloc(1, btf->hdr->meta_header.meta_len);
> > +             if (!meta)
> > +                     goto err_out;
> > +     }
> >
> >       memcpy(hdr, btf->hdr, btf->hdr->hdr_len);
> >       memcpy(types, btf->types_data, btf->hdr->type_len);
> > +     if (meta)
> > +             memcpy(meta, btf->meta_data, btf->hdr->meta_header.meta_l=
en);
> >
> >       /* build lookup index for all strings */
> >       set =3D strset__new(BTF_MAX_STR_OFFSET, btf->strs_data, btf->hdr-=
>str_len);
> > @@ -1463,6 +1541,8 @@ static int btf_ensure_modifiable(struct btf *btf)
> >       btf->types_data_cap =3D btf->hdr->type_len;
> >       btf->strs_data =3D NULL;
> >       btf->strs_set =3D set;
> > +     btf->meta_data =3D meta;
> > +
> >       /* if BTF was created from scratch, all strings are guaranteed to=
 be
> >        * unique and deduplicated
> >        */
> > @@ -1480,6 +1560,7 @@ static int btf_ensure_modifiable(struct btf *btf)
> >       strset__free(set);
> >       free(hdr);
> >       free(types);
> > +     free(meta);
> >       return err;
> >  }
> >
> > --
> > 2.31.1
> >

