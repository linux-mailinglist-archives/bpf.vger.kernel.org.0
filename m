Return-Path: <bpf+bounces-69924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890D8BA713E
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 15:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF74818941A0
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 13:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBBD1E1DE5;
	Sun, 28 Sep 2025 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oj2uaTpB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106BFA927
	for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759067487; cv=none; b=LRJZhNTSJDrxMI84P6lFU8KghAj9p35fpgWG59btXncopggNWNFDpfuy4X/1dHFgf0ROqBgYDKewE3Xi2W81DE+1ib3GWr5ye/+Q72UedVhccW4mJGId+kybWefB3Yhj+07DWkN36y3mZYOfXcTuRyi9tHPZsJUH/tMpdtyiXcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759067487; c=relaxed/simple;
	bh=WNHLuj1DVHQxL8XSb9h/Jbhkhrfyh2r/EZ0IDKG0dFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fr6RWjxwHTbsTE+jT8yPOOEo7iHuP6MFKCRovRg+mh/ZC57Bdp+zN1vmGSPy8cLUbJ09bKsu/hznbVQG4PwyM4zdQyfLYkp6i9v1w86e2zJ5Kh+WRRFDcEbQdMZXB2010s+KuU9MNhaquvuJVc3aUlc7rmdAnhqZnMvTgOIY/WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oj2uaTpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949D7C116C6
	for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 13:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759067486;
	bh=WNHLuj1DVHQxL8XSb9h/Jbhkhrfyh2r/EZ0IDKG0dFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Oj2uaTpBZOFKHDq98vKONbtdzd3/gZyZgkOFSpLdLbns0gU3/zt7HIL0J4m+ptljT
	 2J84KQkmZvV/1k0B2QwWye/QsRfVoziBpB7rF/visVB1OKOhvFW1LxCs/KNnJPLgaa
	 K4ola5ZCj+O5cSzQSL8pnX1CY/LoX+XGWmq749fndFlS+8s3azJMFqQovAF0qyJkgO
	 2/13zWAS3OUAm7BBWzilvzJ1Ps9Lsy9Wm6Pftlp0jAqg3y1fYSWSLyGTrcInCY7db0
	 pNUgzHiS1Vx5FBb68W8bpCVreES5R/psD2sPyMudR1c751IeWm8XKt/VvjP4Zq/9+I
	 wT+EbcvP3TIlQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso6365914e87.1
        for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 06:51:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBMedPDMOS12olKOGXosIxlxiA0g1nm2osplw0WPkXU/FVrWYaFb7ibQpmALrXpWTDt54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG1FnKYtr5O0BWcn8o3b23pP/KWFgADEfT31QtPAHHagxKC6ct
	mpJzSi2SropoBv8nme45l0EEYgh+cuA/86rE7as1OEFumLRJXSECBmrc4vP0jqTYCyJ5+E1Vcpg
	pJox+RZZrOXJIPSo6cNrWKDOa1xB6wQg=
X-Google-Smtp-Source: AGHT+IHtT8s7cf/Igz8hDJnDvLNiLkhl/WbUwA/+Y2ICnmrB7rPUSVrDdwURQn4q3xiCMVY/Fuc9FfNyP80aB+9Mq2g=
X-Received: by 2002:a05:6512:10c3:b0:579:5d8e:1629 with SMTP id
 2adb3069b0e04-5857f272139mr1856031e87.12.1759067484817; Sun, 28 Sep 2025
 06:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925225322.13013-1-ebiggers@kernel.org>
In-Reply-To: <20250925225322.13013-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 28 Sep 2025 15:51:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE00UdJD+exgg+4NK+g6x+qvSCqN=TO2ew8UFO0F1MqqA@mail.gmail.com>
X-Gm-Features: AS18NWAeKR4H_FwiHH_ngz_9Q65HWf3Eq6IyXvNYiRIO1X02TTEPMN-QdoCgOkY
Message-ID: <CAMj1kXE00UdJD+exgg+4NK+g6x+qvSCqN=TO2ew8UFO0F1MqqA@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] lib/bpf_legacy: Use userspace SHA-1 code
 instead of AF_ALG
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 00:54, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Add a basic SHA-1 implementation to lib/, and make lib/bpf_legacy.c use
> it to calculate the SHA-1 digest of BPF objects instead of the previous
> AF_ALG-based code.  This eliminates the dependency on the kernel config
> options CONFIG_CRYPTO_USER_API_HASH and CONFIG_CRYPTO_SHA1.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

Perhaps -in case the maintainer is not convinced- add a paragraph to
the commit log explaining that using AF_ALG to invoke the kernel's
software SHA1 implementation is a terrible idea, and should have never
existed in this form in the first place? (AF_ALG's original purpose
was to expose h/w crypto accelerators to user space but we
accidentally ended up exposing kernel software implementations that
should simply execute in user space entirely)


> ---
>  include/bpf_util.h          |   5 --
>  include/sha1.h              |  18 ++++++
>  include/uapi/linux/if_alg.h |  61 --------------------
>  lib/Makefile                |   2 +-
>  lib/bpf_legacy.c            | 109 +++++++++---------------------------
>  lib/sha1.c                  | 108 +++++++++++++++++++++++++++++++++++
>  6 files changed, 154 insertions(+), 149 deletions(-)
>  create mode 100644 include/sha1.h
>  delete mode 100644 include/uapi/linux/if_alg.h
>  create mode 100644 lib/sha1.c
>
> diff --git a/include/bpf_util.h b/include/bpf_util.h
> index 8951a5e8..e1b8d327 100644
> --- a/include/bpf_util.h
> +++ b/include/bpf_util.h
> @@ -12,11 +12,10 @@
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
>  #include <linux/filter.h>
>  #include <linux/magic.h>
>  #include <linux/elf-em.h>
> -#include <linux/if_alg.h>
>
>  #include "utils.h"
>  #include "bpf_scm.h"
>
>  #define BPF_ENV_UDS    "TC_BPF_UDS"
> @@ -38,14 +37,10 @@
>  # define TRACEFS_MAGIC 0x74726163
>  #endif
>
>  #define TRACE_DIR_MNT  "/sys/kernel/tracing"
>
> -#ifndef AF_ALG
> -# define AF_ALG                38
> -#endif
> -
>  #ifndef EM_BPF
>  # define EM_BPF                247
>  #endif
>
>  struct bpf_cfg_ops {
> diff --git a/include/sha1.h b/include/sha1.h
> new file mode 100644
> index 00000000..4a2ed513
> --- /dev/null
> +++ b/include/sha1.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * SHA-1 message digest algorithm
> + *
> + * Copyright 2025 Google LLC
> + */
> +#ifndef __SHA1_H__
> +#define __SHA1_H__
> +
> +#include <linux/types.h>
> +#include <stddef.h>
> +
> +#define SHA1_DIGEST_SIZE 20
> +#define SHA1_BLOCK_SIZE 64
> +
> +void sha1(const __u8 *data, size_t len, __u8 out[SHA1_DIGEST_SIZE]);
> +
> +#endif /* __SHA1_H__ */
> diff --git a/include/uapi/linux/if_alg.h b/include/uapi/linux/if_alg.h
> deleted file mode 100644
> index 0824fbc0..00000000
> --- a/include/uapi/linux/if_alg.h
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> -/*
> - * if_alg: User-space algorithm interface
> - *
> - * Copyright (c) 2010 Herbert Xu <herbert@gondor.apana.org.au>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License as published by the Free
> - * Software Foundation; either version 2 of the License, or (at your option)
> - * any later version.
> - *
> - */
> -
> -#ifndef _LINUX_IF_ALG_H
> -#define _LINUX_IF_ALG_H
> -
> -#include <linux/types.h>
> -
> -struct sockaddr_alg {
> -       __u16   salg_family;
> -       __u8    salg_type[14];
> -       __u32   salg_feat;
> -       __u32   salg_mask;
> -       __u8    salg_name[64];
> -};
> -
> -/*
> - * Linux v4.12 and later removed the 64-byte limit on salg_name[]; it's now an
> - * arbitrary-length field.  We had to keep the original struct above for source
> - * compatibility with existing userspace programs, though.  Use the new struct
> - * below if support for very long algorithm names is needed.  To do this,
> - * allocate 'sizeof(struct sockaddr_alg_new) + strlen(algname) + 1' bytes, and
> - * copy algname (including the null terminator) into salg_name.
> - */
> -struct sockaddr_alg_new {
> -       __u16   salg_family;
> -       __u8    salg_type[14];
> -       __u32   salg_feat;
> -       __u32   salg_mask;
> -       __u8    salg_name[];
> -};
> -
> -struct af_alg_iv {
> -       __u32   ivlen;
> -       __u8    iv[];
> -};
> -
> -/* Socket options */
> -#define ALG_SET_KEY                    1
> -#define ALG_SET_IV                     2
> -#define ALG_SET_OP                     3
> -#define ALG_SET_AEAD_ASSOCLEN          4
> -#define ALG_SET_AEAD_AUTHSIZE          5
> -#define ALG_SET_DRBG_ENTROPY           6
> -#define ALG_SET_KEY_BY_KEY_SERIAL      7
> -
> -/* Operations */
> -#define ALG_OP_DECRYPT                 0
> -#define ALG_OP_ENCRYPT                 1
> -
> -#endif /* _LINUX_IF_ALG_H */
> diff --git a/lib/Makefile b/lib/Makefile
> index 0ba62942..ee1e2e87 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -4,11 +4,11 @@ include ../config.mk
>  CFLAGS += -fPIC
>
>  UTILOBJ = utils.o utils_math.o rt_names.o ll_map.o ll_types.o ll_proto.o ll_addr.o \
>         inet_proto.o namespace.o json_writer.o json_print.o json_print_math.o \
>         names.o color.o bpf_legacy.o bpf_glue.o exec.o fs.o cg_map.o \
> -       ppp_proto.o bridge.o
> +       ppp_proto.o bridge.o sha1.o
>
>  ifeq ($(HAVE_ELF),y)
>  ifeq ($(HAVE_LIBBPF),y)
>  UTILOBJ += bpf_libbpf.o
>  endif
> diff --git a/lib/bpf_legacy.c b/lib/bpf_legacy.c
> index c8da4a3e..c4b1d5de 100644
> --- a/lib/bpf_legacy.c
> +++ b/lib/bpf_legacy.c
> @@ -27,18 +27,19 @@
>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/un.h>
>  #include <sys/vfs.h>
> +#include <sys/mman.h>
>  #include <sys/mount.h>
> -#include <sys/sendfile.h>
>  #include <sys/resource.h>
>
>  #include <arpa/inet.h>
>
>  #include "utils.h"
>  #include "json_print.h"
> +#include "sha1.h"
>
>  #include "bpf_util.h"
>  #include "bpf_elf.h"
>  #include "bpf_scm.h"
>
> @@ -1178,11 +1179,10 @@ struct bpf_elf_ctx {
>         int                     sec_btf;
>         char                    license[ELF_MAX_LICENSE_LEN];
>         enum bpf_prog_type      type;
>         __u32                   ifindex;
>         bool                    verbose;
> -       bool                    noafalg;
>         struct bpf_elf_st       stat;
>         struct bpf_hash_entry   *ht[256];
>         char                    *log;
>         size_t                  log_size;
>  };
> @@ -1306,76 +1306,32 @@ static int bpf_obj_pin(int fd, const char *pathname)
>         attr.bpf_fd = fd;
>
>         return bpf(BPF_OBJ_PIN, &attr, sizeof(attr));
>  }
>
> -static int bpf_obj_hash(const char *object, uint8_t *out, size_t len)
> +static int bpf_obj_hash(int fd, const char *object, __u8 out[SHA1_DIGEST_SIZE])
>  {
> -       struct sockaddr_alg alg = {
> -               .salg_family    = AF_ALG,
> -               .salg_type      = "hash",
> -               .salg_name      = "sha1",
> -       };
> -       int ret, cfd, ofd, ffd;
>         struct stat stbuff;
> -       ssize_t size;
> -
> -       if (!object || len != 20)
> -               return -EINVAL;
> -
> -       cfd = socket(AF_ALG, SOCK_SEQPACKET, 0);
> -       if (cfd < 0)
> -               return cfd;
> +       void *data;
>
> -       ret = bind(cfd, (struct sockaddr *)&alg, sizeof(alg));
> -       if (ret < 0)
> -               goto out_cfd;
> -
> -       ofd = accept(cfd, NULL, 0);
> -       if (ofd < 0) {
> -               ret = ofd;
> -               goto out_cfd;
> +       if (fstat(fd, &stbuff) < 0) {
> +               fprintf(stderr, "Error doing fstat: %s\n", strerror(errno));
> +               return -1;
>         }
> -
> -       ffd = open(object, O_RDONLY);
> -       if (ffd < 0) {
> -               fprintf(stderr, "Error opening object %s: %s\n",
> -                       object, strerror(errno));
> -               ret = ffd;
> -               goto out_ofd;
> +       if ((size_t)stbuff.st_size != stbuff.st_size) {
> +               fprintf(stderr, "Object %s is too big\n", object);
> +               return -EFBIG;
>         }
> -
> -       ret = fstat(ffd, &stbuff);
> -       if (ret < 0) {
> -               fprintf(stderr, "Error doing fstat: %s\n",
> +       data = mmap(NULL, stbuff.st_size, PROT_READ, MAP_SHARED, fd, 0);
> +       if (data == MAP_FAILED) {
> +               fprintf(stderr, "Error mapping object %s: %s\n", object,
>                         strerror(errno));
> -               goto out_ffd;
> -       }
> -
> -       size = sendfile(ofd, ffd, NULL, stbuff.st_size);
> -       if (size != stbuff.st_size) {
> -               fprintf(stderr, "Error from sendfile (%zd vs %zu bytes): %s\n",
> -                       size, stbuff.st_size, strerror(errno));
> -               ret = -1;
> -               goto out_ffd;
> +               return -1;
>         }
> -
> -       size = read(ofd, out, len);
> -       if (size != len) {
> -               fprintf(stderr, "Error from read (%zd vs %zu bytes): %s\n",
> -                       size, len, strerror(errno));
> -               ret = -1;
> -       } else {
> -               ret = 0;
> -       }
> -out_ffd:
> -       close(ffd);
> -out_ofd:
> -       close(ofd);
> -out_cfd:
> -       close(cfd);
> -       return ret;
> +       sha1(data, stbuff.st_size, out);
> +       munmap(data, stbuff.st_size);
> +       return 0;
>  }
>
>  static void bpf_init_env(void)
>  {
>         struct rlimit limit = {
> @@ -1812,16 +1768,10 @@ static int bpf_maps_attach_all(struct bpf_elf_ctx *ctx)
>  {
>         int i, j, ret, fd, inner_fd, inner_idx, have_map_in_map = 0;
>         const char *map_name;
>
>         for (i = 0; i < ctx->map_num; i++) {
> -               if (ctx->maps[i].pinning == PIN_OBJECT_NS &&
> -                   ctx->noafalg) {
> -                       fprintf(stderr, "Missing kernel AF_ALG support for PIN_OBJECT_NS!\n");
> -                       return -ENOTSUP;
> -               }
> -
>                 map_name = bpf_map_fetch_name(ctx, i);
>                 if (!map_name)
>                         return -EIO;
>
>                 fd = bpf_map_attach(map_name, ctx, &ctx->maps[i],
> @@ -2867,35 +2817,36 @@ static void bpf_get_cfg(struct bpf_elf_ctx *ctx)
>
>  static int bpf_elf_ctx_init(struct bpf_elf_ctx *ctx, const char *pathname,
>                             enum bpf_prog_type type, __u32 ifindex,
>                             bool verbose)
>  {
> -       uint8_t tmp[20];
> +       __u8 tmp[SHA1_DIGEST_SIZE];
>         int ret;
>
>         if (elf_version(EV_CURRENT) == EV_NONE)
>                 return -EINVAL;
>
>         bpf_init_env();
>
>         memset(ctx, 0, sizeof(*ctx));
>         bpf_get_cfg(ctx);
>
> -       ret = bpf_obj_hash(pathname, tmp, sizeof(tmp));
> -       if (ret)
> -               ctx->noafalg = true;
> -       else
> -               hexstring_n2a(tmp, sizeof(tmp), ctx->obj_uid,
> -                             sizeof(ctx->obj_uid));
> -
>         ctx->verbose = verbose;
>         ctx->type    = type;
>         ctx->ifindex = ifindex;
>
>         ctx->obj_fd = open(pathname, O_RDONLY);
> -       if (ctx->obj_fd < 0)
> +       if (ctx->obj_fd < 0) {
> +               fprintf(stderr, "Error opening object %s: %s\n", pathname,
> +                       strerror(errno));
>                 return ctx->obj_fd;
> +       }
> +
> +       ret = bpf_obj_hash(ctx->obj_fd, pathname, tmp);
> +       if (ret)
> +               return ret;
> +       hexstring_n2a(tmp, sizeof(tmp), ctx->obj_uid, sizeof(ctx->obj_uid));
>
>         ctx->elf_fd = elf_begin(ctx->obj_fd, ELF_C_READ, NULL);
>         if (!ctx->elf_fd) {
>                 ret = -EINVAL;
>                 goto out_fd;
> @@ -3257,16 +3208,10 @@ bool iproute2_is_pin_map(const char *libbpf_map_name, char *pathname)
>         const char *map_name, *tmp;
>         unsigned int pinning;
>         int i, ret = 0;
>
>         for (i = 0; i < ctx->map_num; i++) {
> -               if (ctx->maps[i].pinning == PIN_OBJECT_NS &&
> -                   ctx->noafalg) {
> -                       fprintf(stderr, "Missing kernel AF_ALG support for PIN_OBJECT_NS!\n");
> -                       return false;
> -               }
> -
>                 map_name = bpf_map_fetch_name(ctx, i);
>                 if (!map_name) {
>                         return false;
>                 }
>
> diff --git a/lib/sha1.c b/lib/sha1.c
> new file mode 100644
> index 00000000..1aa8fd83
> --- /dev/null
> +++ b/lib/sha1.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * SHA-1 message digest algorithm
> + *
> + * Copyright 2025 Google LLC
> + */
> +
> +#include <arpa/inet.h>
> +#include <string.h>
> +
> +#include "sha1.h"
> +#include "utils.h"
> +
> +static const __u32 sha1_K[4] = { 0x5A827999, 0x6ED9EBA1, 0x8F1BBCDC,
> +                                0xCA62C1D6 };
> +
> +static inline __u32 rol32(__u32 v, int bits)
> +{
> +       return (v << bits) | (v >> (32 - bits));
> +}
> +
> +#define round_up(a, b) (((a) + (b) - 1) & ~((b) - 1))
> +
> +#define SHA1_ROUND(i, a, b, c, d, e)                                           \
> +       do {                                                                   \
> +               if ((i) >= 16)                                                 \
> +                       w[i] = rol32(w[(i) - 16] ^ w[(i) - 14] ^ w[(i) - 8] ^  \
> +                                            w[(i) - 3],                       \
> +                                    1);                                       \
> +               e += w[i] + rol32(a, 5) + sha1_K[(i) / 20];                    \
> +               if ((i) < 20)                                                  \
> +                       e += (b & (c ^ d)) ^ d;                                \
> +               else if ((i) < 40 || (i) >= 60)                                \
> +                       e += b ^ c ^ d;                                        \
> +               else                                                           \
> +                       e += (c & d) ^ (b & (c ^ d));                          \
> +               b = rol32(b, 30);                                              \
> +               /* The new (a, b, c, d, e) is the old (e, a, b, c, d). */      \
> +       } while (0)
> +
> +#define SHA1_5ROUNDS(i)                                                        \
> +       do {                                                                   \
> +               SHA1_ROUND((i) + 0, a, b, c, d, e);                            \
> +               SHA1_ROUND((i) + 1, e, a, b, c, d);                            \
> +               SHA1_ROUND((i) + 2, d, e, a, b, c);                            \
> +               SHA1_ROUND((i) + 3, c, d, e, a, b);                            \
> +               SHA1_ROUND((i) + 4, b, c, d, e, a);                            \
> +       } while (0)
> +
> +#define SHA1_20ROUNDS(i)                                                       \
> +       do {                                                                   \
> +               SHA1_5ROUNDS((i) + 0);                                         \
> +               SHA1_5ROUNDS((i) + 5);                                         \
> +               SHA1_5ROUNDS((i) + 10);                                        \
> +               SHA1_5ROUNDS((i) + 15);                                        \
> +       } while (0)
> +
> +static void sha1_blocks(__u32 h[5], const __u8 *data, size_t nblocks)
> +{
> +       while (nblocks--) {
> +               __u32 a = h[0];
> +               __u32 b = h[1];
> +               __u32 c = h[2];
> +               __u32 d = h[3];
> +               __u32 e = h[4];
> +               __u32 w[80];
> +               int i;
> +
> +               memcpy(w, data, SHA1_BLOCK_SIZE);
> +               for (i = 0; i < 16; i++)
> +                       w[i] = ntohl(w[i]);
> +               SHA1_20ROUNDS(0);
> +               SHA1_20ROUNDS(20);
> +               SHA1_20ROUNDS(40);
> +               SHA1_20ROUNDS(60);
> +
> +               h[0] += a;
> +               h[1] += b;
> +               h[2] += c;
> +               h[3] += d;
> +               h[4] += e;
> +               data += SHA1_BLOCK_SIZE;
> +       }
> +}
> +
> +/* Calculate the SHA-1 message digest of the given data. */
> +void sha1(const __u8 *data, size_t len, __u8 out[SHA1_DIGEST_SIZE])
> +{
> +       __u32 h[5] = { 0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476,
> +                      0xC3D2E1F0 };
> +       const __be64 bitcount = htonll((__u64)len * 8);
> +       __u8 final_data[2 * SHA1_BLOCK_SIZE] = { 0 };
> +       size_t final_len = len % SHA1_BLOCK_SIZE;
> +       int i;
> +
> +       sha1_blocks(h, data, len / SHA1_BLOCK_SIZE);
> +
> +       memcpy(final_data, data + len - final_len, final_len);
> +       final_data[final_len] = 0x80;
> +       final_len = round_up(final_len + 9, SHA1_BLOCK_SIZE);
> +       memcpy(&final_data[final_len - 8], &bitcount, 8);
> +
> +       sha1_blocks(h, final_data, final_len / SHA1_BLOCK_SIZE);
> +
> +       for (i = 0; i < ARRAY_SIZE(h); i++)
> +               h[i] = htonl(h[i]);
> +       memcpy(out, h, SHA1_DIGEST_SIZE);
> +}
>
> base-commit: afceddf61037440628a5612f15a6eaefd28d9fd3
> --
> 2.51.0
>

