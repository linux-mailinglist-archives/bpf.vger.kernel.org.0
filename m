Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C646D34F861
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 07:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhCaFtk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 01:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhCaFta (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 01:49:30 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7809C061574
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 22:49:29 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id l15so20013862ybm.0
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 22:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Dt7nTZjxvYuCW2YkRE1K9Rl1LExWqQTyVcB5ZcYQKA=;
        b=GXsWPyP+1JPKJ5odpI1McPvLCBmiDfIi5g9L3xcgfJ/mvkObCHYSZkb1qiHrZXOnpt
         hiHmaCWDuRa6JG7sXU30E7JBJirsDhFY+EHud5wXnic9ku5+QooF/S6nZK7jxImvj7Pv
         WNEOOjg4EsFJSq8UjonYugjImCTaXBuOPljol/7xbd3vC22D+zPgUMPNXEvdA/nQOknY
         HX5XJmSIA5LtUWAgNrEVrn+Bt8J9/WpyJt4bTQNXz7oDYEDOBSQ0yLJqy20lgFQWYQ7F
         QhVHwyVtZufWV1QBEhTZcHFqSpDLh7dtoDN4jZL3gXE4DEAbz/AgTFXMbJXQT9tCFVax
         RQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Dt7nTZjxvYuCW2YkRE1K9Rl1LExWqQTyVcB5ZcYQKA=;
        b=jEgTfzbnF895Gx4h5vYc9pEgQY5Wg57XOu/bsOQGTR5TLgP0AzFEWX7X58MdtvOAJH
         FsUHg0DV5EW6VSxiV6nKnY8gpox4rmRq76jz9At4Kqv/pCqyLankigtUQpeaianhgfs2
         TthwB4joBARYX2iS+Iui6dOoKmfAhytBeXOy2CDuY0WtMdiXOvJR8ibH4/vtBZrsVbVE
         AuGwGbZtiJ+RNWboiQz3Zz+d4VVKAs0SN1zpg1cgvdOebTBl6HllsOAaOkO7dUARMs3d
         Z74nmEilMDaTIwgl9+eXzleVeSfK/1DcQuL568JY+PSOFtdT1S516A/TEb2hm5dVTFJO
         3wlA==
X-Gm-Message-State: AOAM531a87mnrhMY97nGmMP2y2bg4PUnJbbKP/IG2a6dab+EwhqhNvlg
        qL6De/THcmh0MbmtqHDur/7QIKc6SXHp1e4MSQqAQouQuhE=
X-Google-Smtp-Source: ABdhPJwjMYg9kH8xkLJEmiW8Nle1ZfyvoOL22jAnM9eyevooP2LUtaIRISWCVJIrwz82EY+Bj8cEGoIXAHHTfAKRZWs=
X-Received: by 2002:a25:becd:: with SMTP id k13mr2318756ybm.459.1617169769019;
 Tue, 30 Mar 2021 22:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
 <20210326122438.211242-1-yauheni.kaliuta@redhat.com> <20210326122438.211242-4-yauheni.kaliuta@redhat.com>
 <CAEf4BzZowiRKeLGw7JikKuMs+dy-=OTMbUb3eFJCq03Br7P30g@mail.gmail.com> <CANoWswmy1bHbU8hBkF2DiyW3oHr1wDxZU3CsyDHOJ+-fe5DBTA@mail.gmail.com>
In-Reply-To: <CANoWswmy1bHbU8hBkF2DiyW3oHr1wDxZU3CsyDHOJ+-fe5DBTA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 30 Mar 2021 22:49:18 -0700
Message-ID: <CAEf4BzbKfz7if1ktSMiyK4TZYZF8n7mk34UQCi3ZuDZvobkZqQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] selftests/bpf: ringbuf, mmap: bump up page size to 64K
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 29, 2021 at 8:20 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> On Sun, Mar 28, 2021 at 8:03 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>
> [...]
>
> > >
> > >  struct {
> > >         __uint(type, BPF_MAP_TYPE_ARRAY);
> > > -       __uint(max_entries, 4096);
> > > +       __uint(max_entries, PAGE_SIZE);
> >
> >
> > so you can set map size at runtime before bpf_object__load (or
> > skeleton's load) with bpf_map__set_max_entries. That way you don't
> > have to do any assumptions. Just omit max_entries in BPF source code,
> > and always set it in userspace.
>
> Will it work for ringbuf_multi? If I just set max_entries for ringbuf1
> and ringbuf2 that way, it gives me
>
> libbpf: map 'ringbuf_arr': failed to create inner map: -22
> libbpf: map 'ringbuf_arr': failed to create: Invalid argument(-22)
> libbpf: failed to load object 'test_ringbuf_multi'
> libbpf: failed to load BPF skeleton 'test_ringbuf_multi': -22
> test_ringbuf_multi:FAIL:skel_load skeleton load failed
>

You are right, it won't work. We'd need to add something like
bpf_map__inner_map() accessor to allow to adjust the inner map
definition:

bpf_map__set_max_entries(bpf_map__inner_map(skel->maps.ringbuf_arr), page_size);

And some more fixes. Here's minimal diff that made it work, but
probably needs a bit more testing:

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7aad78dbb4b4..ed5586cce227 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2194,6 +2194,7 @@ static int parse_btf_map_def(struct bpf_object *obj,
             map->inner_map = calloc(1, sizeof(*map->inner_map));
             if (!map->inner_map)
                 return -ENOMEM;
+            map->inner_map->fd = -1;
             map->inner_map->sec_idx = obj->efile.btf_maps_shndx;
             map->inner_map->name = malloc(strlen(map->name) +
                               sizeof(".inner") + 1);
@@ -3845,6 +3846,14 @@ __u32 bpf_map__max_entries(const struct bpf_map *map)
     return map->def.max_entries;
 }

+struct bpf_map *bpf_map__inner_map(struct bpf_map *map)
+{
+    if (!bpf_map_type__is_map_in_map(map->def.type))
+        return NULL;
+
+    return map->inner_map;
+}
+
 int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
 {
     if (map->fd >= 0)
@@ -9476,6 +9485,7 @@ int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd)
         pr_warn("error: inner_map_fd already specified\n");
         return -EINVAL;
     }
+    zfree(&map->inner_map);
     map->inner_map_fd = fd;
     return 0;
 }
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index f500621d28e5..bec4e6a6e31d 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -480,6 +480,7 @@ LIBBPF_API int bpf_map__pin(struct bpf_map *map,
const char *path);
 LIBBPF_API int bpf_map__unpin(struct bpf_map *map, const char *path);

 LIBBPF_API int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd);
+LIBBPF_API struct bpf_map *bpf_map__inner_map(struct bpf_map *map);

 LIBBPF_API long libbpf_get_error(const void *ptr);

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f5990f7208ce..eeb6d5ebd1cc 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -360,4 +360,5 @@ LIBBPF_0.4.0 {
         bpf_linker__free;
         bpf_linker__new;
         bpf_object__set_kversion;
+        bpf_map__inner_map;
 } LIBBPF_0.3.0;
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
index d37161e59bb2..cdc9c9b1d0e1 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
@@ -41,13 +41,23 @@ static int process_sample(void *ctx, void *data, size_t len)
 void test_ringbuf_multi(void)
 {
     struct test_ringbuf_multi *skel;
-    struct ring_buffer *ringbuf;
+    struct ring_buffer *ringbuf = NULL;
     int err;

-    skel = test_ringbuf_multi__open_and_load();
+    skel = test_ringbuf_multi__open();
     if (CHECK(!skel, "skel_open_load", "skeleton open&load failed\n"))
         return;

+    bpf_map__set_max_entries(skel->maps.ringbuf1, 4096);
+    bpf_map__set_max_entries(skel->maps.ringbuf2, 4096);
+    bpf_map__set_max_entries(bpf_map__inner_map(skel->maps.ringbuf_arr), 4096);
+
+    err = test_ringbuf_multi__load(skel);
+    if (!ASSERT_OK(err, "skel_load"))
+        goto cleanup;
+
     /* only trigger BPF program for current process */
     skel->bss->pid = getpid();

diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
index edf3b6953533..055c10b2ff80 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
@@ -15,7 +15,6 @@ struct sample {

 struct ringbuf_map {
     __uint(type, BPF_MAP_TYPE_RINGBUF);
-    __uint(max_entries, 1 << 12);
 } ringbuf1 SEC(".maps"),
   ringbuf2 SEC(".maps");
