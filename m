Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2AAD1942DB
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 16:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgCZPSE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 11:18:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39295 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727874AbgCZPSD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Mar 2020 11:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585235882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lvxhivEZKDcTt1poeB5iwHQWHnaT/0gmsJdrcgOX2mc=;
        b=QXnLJGOnDq8JAEJhXEcPZYKkOrYvn1mr87x4OFCthamY64xOdHcPAy2q8ny1HY8VBQLK4B
        j51Ap7l7yfJBgrTGYOQWTKkFHsL296N86uKhqS3vjpHqTrG49++pJS+FExbwHySuWI6sOs
        /SUa+eUclobhmMKUBd6Mfa0i4/4hZek=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-Mn9o4uJ8PMu6byBdYLCdFQ-1; Thu, 26 Mar 2020 11:18:01 -0400
X-MC-Unique: Mn9o4uJ8PMu6byBdYLCdFQ-1
Received: by mail-lf1-f72.google.com with SMTP id 144so2399913lfj.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2020 08:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lvxhivEZKDcTt1poeB5iwHQWHnaT/0gmsJdrcgOX2mc=;
        b=FmhXUJgvY1fkbpXaCzn3EHD1gqDdeD3SLXVbCqLZa3KRFY6NOtiZJhuQfcxEXBTjvm
         mF6DLImiJz2sEAAJYk2+v1EXyys2PSPqAZM4LzG3VXarYRnj0wFs1MzfJ2U/SctOokfl
         aT150ON5mfLda1AFcrh28l5w/2WXEEIPK9nYkZZvjMuwT4cHF7NXc1gQLZEHFXtUUVeS
         lk1MEocDWbuASYAER2XXlD2VizG2SN1f565L8mtD9A7Q2nq9a3vCk7T3xnLlOg8L4CYq
         CTUlsESB0ppzC4XSufP0IXqWH1+FeL3p2lSo9UyAC2IBKnl6FnQO1+9TvEOqEoP+4LN+
         NJVw==
X-Gm-Message-State: ANhLgQ0OI9Hwj1Qz54vVWzyY12nlNSkAbSBLo33cjn86dNrJDiT+yCoQ
        3jC4qj3lcLrttenKqQgdHkl8k6D9Ex/jD89T7iM2wgstjS+DFCN0z2l1T3tdQJwCMzSW00POpxj
        mghiIrjG1CDoG
X-Received: by 2002:a2e:a173:: with SMTP id u19mr5742111ljl.67.1585235877936;
        Thu, 26 Mar 2020 08:17:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsj7MerWWTlCWLvfp9Knj7RahTvIrsuIKrnRtePYCUeFUYHw465ZRV4s+GtGsN18WaxZVMntA==
X-Received: by 2002:a2e:a173:: with SMTP id u19mr5742056ljl.67.1585235876746;
        Thu, 26 Mar 2020 08:17:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l11sm1726889lfg.87.2020.03.26.08.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:17:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 33D2918158B; Thu, 26 Mar 2020 16:17:53 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next] libbpf: Add bpf_object__rodata getter function
Date:   Thu, 26 Mar 2020 16:17:41 +0100
Message-Id: <20200326151741.125427-1-toke@redhat.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds a new getter function to libbpf to get the rodata area of a bpf
object. This is useful if a program wants to modify the rodata before
loading the object. Any such modification needs to be done before loading,
since libbpf freezes the backing map after populating it (to allow the
kernel to do dead code elimination based on its contents).

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c   | 13 +++++++++++++
 tools/lib/bpf/libbpf.h   |  1 +
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 15 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 085e41f9b68e..d3e3bbe12f78 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1352,6 +1352,19 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	return 0;
 }
 
+void *bpf_object__rodata(const struct bpf_object *obj, size_t *size)
+{
+	struct bpf_map *map;
+
+	bpf_object__for_each_map(map, obj) {
+		if (map->libbpf_type == LIBBPF_MAP_RODATA && map->mmaped) {
+			*size = map->def.value_size;
+			return map->mmaped;
+		}
+	}
+	return NULL;
+}
+
 static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 {
 	int err;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d38d7a629417..d2a9beed7b8a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -166,6 +166,7 @@ typedef void (*bpf_object_clear_priv_t)(struct bpf_object *, void *);
 LIBBPF_API int bpf_object__set_priv(struct bpf_object *obj, void *priv,
 				    bpf_object_clear_priv_t clear_priv);
 LIBBPF_API void *bpf_object__priv(const struct bpf_object *prog);
+LIBBPF_API void *bpf_object__rodata(const struct bpf_object *obj, size_t *size);
 
 LIBBPF_API int
 libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 5129283c0284..a248f4ff3a40 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -243,5 +243,6 @@ LIBBPF_0.0.8 {
 		bpf_link__pin;
 		bpf_link__pin_path;
 		bpf_link__unpin;
+		bpf_object__rodata;
 		bpf_program__set_attach_target;
 } LIBBPF_0.0.7;
-- 
2.26.0

