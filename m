Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24DD43B0AE
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 13:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbhJZLCv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 07:02:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235322AbhJZLCu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Oct 2021 07:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635246025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Pn9u4KRkeLiDe3ra91esFQkIjSd7OhtSN2H5uGezA8I=;
        b=NwasIhozjk9uwgrUxdNEZiiOGtrehnAcEOKf29z7P/iltOaXrqFpWVxm8wDK7/vDUXxM4q
        kH9BJS/VGUki8YA+CpdwcxVTdvo++f9n+pRjFvGruq/kcOzWejxokiibUpdhfjTtG1CTxi
        wkhCQnS9T8RwYez64BbtErRfY9e856o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-EBw4vBFWMBicqW_iZq-Ujw-1; Tue, 26 Oct 2021 07:00:24 -0400
X-MC-Unique: EBw4vBFWMBicqW_iZq-Ujw-1
Received: by mail-ed1-f70.google.com with SMTP id f21-20020a0564021e9500b003dd77985601so2516232edf.9
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 04:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pn9u4KRkeLiDe3ra91esFQkIjSd7OhtSN2H5uGezA8I=;
        b=fXQNgYKLdVGJFKhvbz9TDyIZrXxLAWFLUQx3KkF3FseJHJheqbOVLvbTDCfHIUMAXt
         K9Pggy84CWTqu2xy1VMGPc3Sz9+G32wT51UuTF74ZqydpqsRYnQx9Lw0LsktoWTLN69R
         +ZUtQLxtaH5Eatnx4icWikuC6oBlDC8+YpDFTnTIlojokWDoWUeqttzyuXiuUAninelv
         Pn3+d297XIUB17I7nN6tdmvb74vySJU3R6+aZqYYkrLe0GC0l+4oJlv0nWm40LU+yuu1
         J9ltnfZ38Cx4ub1ZXUvwtnPtdfdLA18NU54SKLbAUFQvOm9Xen9w882RMaGxB9ie0q14
         at3A==
X-Gm-Message-State: AOAM5323Hf1FtJ6+9+EsrwAdXl6hCti4G5f8UlSw+b2Cn2BgFuyMmHLI
        sFQR+z5MzaqnQNHckoj0lkWjBq+hVbzsQHau1UiVwnbFaWYNi9eJ+1D1EJrzdP3qms8x8jyuw12
        w6ImWEXL+oAd9
X-Received: by 2002:a17:907:2098:: with SMTP id pv24mr29324851ejb.137.1635246023301;
        Tue, 26 Oct 2021 04:00:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgB7jUsbjfufpK94h1vhX2zVfGvYzuNS0v09hq4zOTkccri0r5cA5qhpU4wyssLC8rvNTURA==
X-Received: by 2002:a17:907:2098:: with SMTP id pv24mr29324801ejb.137.1635246022881;
        Tue, 26 Oct 2021 04:00:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id c7sm4559650ejd.91.2021.10.26.04.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:00:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 91FBE180262; Tue, 26 Oct 2021 13:00:20 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: [PATCH bpf v3] bpf: fix potential race in tail call compatibility check
Date:   Tue, 26 Oct 2021 13:00:19 +0200
Message-Id: <20211026110019.363464-1-toke@redhat.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo noticed that the code testing for program type compatibility of
tail call maps is potentially racy in that two threads could encounter a
map with an unset type simultaneously and both return true even though they
are inserting incompatible programs.

The race window is quite small, but artificially enlarging it by adding a
usleep_range() inside the check in bpf_prog_array_compatible() makes it
trivial to trigger from userspace with a program that does, essentially:

        map_fd = bpf_create_map(BPF_MAP_TYPE_PROG_ARRAY, 4, 4, 2, 0);
        pid = fork();
        if (pid) {
                key = 0;
                value = xdp_fd;
        } else {
                key = 1;
                value = tc_fd;
        }
        err = bpf_map_update_elem(map_fd, &key, &value, 0);

While the race window is small, it has potentially serious ramifications in
that triggering it would allow a BPF program to tail call to a program of a
different type. So let's get rid of it by protecting the update with a
spinlock. The commit in the Fixes tag is the last commit that touches the
code in question.

v2:
- Use a spinlock instead of an atomic variable and cmpxchg() (Alexei)
v3:
- Put lock and the members it protects into an embedded 'owner' struct (Daniel)

Fixes: 3324b584b6f6 ("ebpf: misc core cleanup")
Reported-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/bpf.h   |  7 +++++--
 kernel/bpf/arraymap.c |  1 +
 kernel/bpf/core.c     | 20 +++++++++++++-------
 kernel/bpf/syscall.c  |  6 ++++--
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 020a7d5bf470..3db6f6c95489 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -929,8 +929,11 @@ struct bpf_array_aux {
 	 * stored in the map to make sure that all callers and callees have
 	 * the same prog type and JITed flag.
 	 */
-	enum bpf_prog_type type;
-	bool jited;
+	struct {
+		spinlock_t lock;
+		enum bpf_prog_type type;
+		bool jited;
+	} owner;
 	/* Programs with direct jumps into programs part of this array. */
 	struct list_head poke_progs;
 	struct bpf_map *map;
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index cebd4fb06d19..447def540544 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -1072,6 +1072,7 @@ static struct bpf_map *prog_array_map_alloc(union bpf_attr *attr)
 	INIT_WORK(&aux->work, prog_array_map_clear_deferred);
 	INIT_LIST_HEAD(&aux->poke_progs);
 	mutex_init(&aux->poke_mutex);
+	spin_lock_init(&aux->owner.lock);
 
 	map = array_map_alloc(attr);
 	if (IS_ERR(map)) {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c1e7eb3f1876..6e3ae90ad107 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1823,20 +1823,26 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
 bool bpf_prog_array_compatible(struct bpf_array *array,
 			       const struct bpf_prog *fp)
 {
+	bool ret;
+
 	if (fp->kprobe_override)
 		return false;
 
-	if (!array->aux->type) {
+	spin_lock(&array->aux->owner.lock);
+
+	if (!array->aux->owner.type) {
 		/* There's no owner yet where we could check for
 		 * compatibility.
 		 */
-		array->aux->type  = fp->type;
-		array->aux->jited = fp->jited;
-		return true;
+		array->aux->owner.type  = fp->type;
+		array->aux->owner.jited = fp->jited;
+		ret = true;
+	} else {
+		ret = array->aux->owner.type  == fp->type &&
+		      array->aux->owner.jited == fp->jited;
 	}
-
-	return array->aux->type  == fp->type &&
-	       array->aux->jited == fp->jited;
+	spin_unlock(&array->aux->owner.lock);
+	return ret;
 }
 
 static int bpf_check_tail_call(const struct bpf_prog *fp)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e50c0bfdb7d..5f425b0b37b2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -543,8 +543,10 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 
 	if (map->map_type == BPF_MAP_TYPE_PROG_ARRAY) {
 		array = container_of(map, struct bpf_array, map);
-		type  = array->aux->type;
-		jited = array->aux->jited;
+		spin_lock(&array->aux->owner.lock);
+		type  = array->aux->owner.type;
+		jited = array->aux->owner.jited;
+		spin_unlock(&array->aux->owner.lock);
 	}
 
 	seq_printf(m,
-- 
2.33.0

