Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E7A41A0E6
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 22:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbhI0VAB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 17:00:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236723AbhI0VAB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 27 Sep 2021 17:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632776302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=h6SdPKJUQraJPyWtfAQGpSNiAyg6FY/Asb+egfA785I=;
        b=OsCSNI500i1WmrWbW2Co4D4B+FgkYIiUIWgRiSa2RGH/NBiqr6Svp1AFWt1sedUe2djHPS
        Kz0cJsBBMxZ4pWxnJMjqdAcGUo38J4IeLKfYsThOlcbJ/aGdAz0ea/Idkig5+Nn2vxYohD
        zApeGqeEm7ugORDfxJm9MIwVPfLgKUs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-Pj-evTT0Nc6OgENGiTjJoQ-1; Mon, 27 Sep 2021 16:58:21 -0400
X-MC-Unique: Pj-evTT0Nc6OgENGiTjJoQ-1
Received: by mail-ed1-f72.google.com with SMTP id l29-20020a50d6dd000000b003d80214566cso19155984edj.21
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 13:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h6SdPKJUQraJPyWtfAQGpSNiAyg6FY/Asb+egfA785I=;
        b=OmDE3L6wzJg5L0DuhSfWziFQjCHnBtADN+IfWxPio9tEmzqHwejGRW80/bhwN8bT6a
         VJvsPmBIiwzvCoPyidZynIPKAjajk0XRL3rcxk8Npi0hFyOm6Uvj8qqAUC76idZRMiKF
         abrGLAyqyBMaNIXpWR0UFoUrC9nNfWJMetFcWkPeWHuxiLk9EBXivQPhtKtErYLuVnd5
         2gjxAZVpHlQ7obGsTNy3MmD6Ke5mQQzUBBUEToCURnLDQdNpvQosK/v9QY522H/YfXPR
         cNtPFu0ChI17/5KHPSYgXL8MMYQmwexU4Nrqsrkmti2Q1JQLwxnKMjBKhtfX9PTOP7Dw
         4YlQ==
X-Gm-Message-State: AOAM5324NQ2r2UIT7E23MMBQFL+LQ9Zqszi010EhuFwQStoLXNiR+BTB
        hV2HyrO1XrAXfP4fKzdxL+ZZ2gbvdYUOsMqP7V1e3JAwb+uOFmvvkHXltip4nUZ4pnNaHCJK5bB
        n+unpZ98qYyCx
X-Received: by 2002:a17:906:3fc8:: with SMTP id k8mr2434570ejj.217.1632776299235;
        Mon, 27 Sep 2021 13:58:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxR54oADu3eZwUs7o8PM47gmSezL3c0oDksiYLb05ia3fYL8Dkwb8A22gomTQdovRb780HmQA==
X-Received: by 2002:a17:906:3fc8:: with SMTP id k8mr2434490ejj.217.1632776298326;
        Mon, 27 Sep 2021 13:58:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u4sm9143140ejc.19.2021.09.27.13.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:58:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A7DA418034A; Mon, 27 Sep 2021 22:58:16 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>
Subject: [PATCH bpf-next] libbpf: ignore STT_SECTION symbols in 'maps' section
Date:   Mon, 27 Sep 2021 22:58:10 +0200
Message-Id: <20210927205810.715656-1-toke@redhat.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When parsing legacy map definitions, libbpf would error out when
encountering an STT_SECTION symbol. This becomes a problem because some
versions of binutils will produce SECTION symbols for every section when
processing an ELF file, so BPF files run through 'strip' will end up with
such symbols, making libbpf refuse to load them.

There's not really any reason why erroring out is strictly necessary, so
change libbpf to just ignore SECTION symbols when parsing the ELF.

Cc: Jiri Benc <jbenc@redhat.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ef5db34bf913..453148fe8b4b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1869,6 +1869,8 @@ static int bpf_object__init_user_maps(struct bpf_object *obj, bool strict)
 			continue;
 		if (sym.st_shndx != obj->efile.maps_shndx)
 			continue;
+		if (GELF_ST_TYPE(sym.st_info) == STT_SECTION)
+			continue;
 
 		map = bpf_object__add_map(obj);
 		if (IS_ERR(map))
@@ -1881,8 +1883,7 @@ static int bpf_object__init_user_maps(struct bpf_object *obj, bool strict)
 			return -LIBBPF_ERRNO__FORMAT;
 		}
 
-		if (GELF_ST_TYPE(sym.st_info) == STT_SECTION
-		    || GELF_ST_BIND(sym.st_info) == STB_LOCAL) {
+		if (GELF_ST_BIND(sym.st_info) == STB_LOCAL) {
 			pr_warn("map '%s' (legacy): static maps are not supported\n", map_name);
 			return -ENOTSUP;
 		}
-- 
2.33.0

