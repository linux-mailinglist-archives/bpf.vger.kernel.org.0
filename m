Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D77E9F6179
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2019 21:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfKIUhe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Nov 2019 15:37:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26848 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726467AbfKIUhd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Nov 2019 15:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573331851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d0rOEoaUyqMmBq+Hxgb41cmJhdsjELtmnb5UaWYonJk=;
        b=ZjEO+OBJodDEet2uTGQ+dbsGawBT4pcnN/zTX4kzemhZxwO6h496JrUX9VZEhQf9Yj4ybE
        Bq3O6crdXDiFEnC7IKZe3V1CtitUl6Yswzk8pEp4yLkq2Wzi8jD016tmA4J9Xmmz2hD9vj
        fgNggN3Gybu2bNBsPIb8947e4TPt3lM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-TqTNaKaVOfWFs9n-A0W-og-1; Sat, 09 Nov 2019 15:37:30 -0500
Received: by mail-lj1-f199.google.com with SMTP id y7so1066037ljc.2
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2019 12:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=62bBWH2vDaf8qBssfp0tI1eOslFQZrsVY2Oj+vZ2ygw=;
        b=EYfRVDt2MtuARB0N65Z2J66hcFQbFss2Y0ozbC+yPfTtk5WWMTAM2b+dCTV66qYOQd
         QTech+n+KMlirMz3TZo2OuqpDzLzVvuIyDn+Wn4axxgYRTBn5Bun1SkwLYm/ERKUdvgv
         LaLq3DVJJ+BqycMFqq7vcl3J5ByIO0ymtvzPrff3tVkrHn12K6NpiQ9tnZTo/zMTJGEM
         u8shTCTp3Gj2PzTWIgOi3T3NtqRKJZJ7bu135KPGEhOKFnG81qr5QXQVNXgz2JI2EcfJ
         JX/SwJ0bY95C+J5/AkxN2IxwHN+4Wo25iNPzvuG9WUzEsDd8uph4EIUstsd8TMv6qkHH
         l8Vw==
X-Gm-Message-State: APjAAAWkZFkiNEMBx5Z9EsRXyf23lm+U1gC9TPYBQzewbzcTDC+UDkVz
        YeBSBePM8i5DVjuoAQ/ElpK4EQ7YJNLBoXFGBR1J2A2qQ6jKxPGFIyY+zJBRkAzCpmA3Hv6CeQR
        +NwjHFOYc99eJ
X-Received: by 2002:a2e:9610:: with SMTP id v16mr10923762ljh.219.1573331848938;
        Sat, 09 Nov 2019 12:37:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqxrUOaBgc2ywo1TZeACcKA2auheY6ip/NPyq6HcO2e5+YPyszOrcFo46dJu9FpjhVM8ZXcXAQ==
X-Received: by 2002:a2e:9610:: with SMTP id v16mr10923743ljh.219.1573331848665;
        Sat, 09 Nov 2019 12:37:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id t12sm4326307lfc.73.2019.11.09.12.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 12:37:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5E0191800CE; Sat,  9 Nov 2019 21:37:27 +0100 (CET)
Subject: [PATCH bpf-next v4 1/6] libbpf: Unpin auto-pinned maps if loading
 fails
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Sat, 09 Nov 2019 21:37:27 +0100
Message-ID: <157333184731.88376.9992935027056165873.stgit@toke.dk>
In-Reply-To: <157333184619.88376.13377736576285554047.stgit@toke.dk>
References: <157333184619.88376.13377736576285554047.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-MC-Unique: TqTNaKaVOfWFs9n-A0W-og-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Since the automatic map-pinning happens during load, it will leave pinned
maps around if the load fails at a later stage. Fix this by unpinning any
pinned maps on cleanup. To avoid unpinning pinned maps that were reused
rather than newly pinned, add a new boolean property on struct bpf_map to
keep track of whether that map was reused or not; and only unpin those maps
that were not reused.

Fixes: 57a00f41644f ("libbpf: Add auto-pinning of maps when loading BPF obj=
ects")
Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index be4af95d5a2c..a70ade546a73 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -229,6 +229,7 @@ struct bpf_map {
 =09enum libbpf_map_type libbpf_type;
 =09char *pin_path;
 =09bool pinned;
+=09bool reused;
 };
=20
 struct bpf_secdata {
@@ -1995,6 +1996,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 =09map->def.map_flags =3D info.map_flags;
 =09map->btf_key_type_id =3D info.btf_key_type_id;
 =09map->btf_value_type_id =3D info.btf_value_type_id;
+=09map->reused =3D true;
=20
 =09return 0;
=20
@@ -4026,7 +4028,7 @@ int bpf_object__unload(struct bpf_object *obj)
 int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 {
 =09struct bpf_object *obj;
-=09int err;
+=09int err, i;
=20
 =09if (!attr)
 =09=09return -EINVAL;
@@ -4047,6 +4049,11 @@ int bpf_object__load_xattr(struct bpf_object_load_at=
tr *attr)
=20
 =09return 0;
 out:
+=09/* unpin any maps that were auto-pinned during load */
+=09for (i =3D 0; i < obj->nr_maps; i++)
+=09=09if (obj->maps[i].pinned && !obj->maps[i].reused)
+=09=09=09bpf_map__unpin(&obj->maps[i], NULL);
+
 =09bpf_object__unload(obj);
 =09pr_warn("failed to load object '%s'\n", obj->path);
 =09return err;

