Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B606A41CE4D
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 23:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346386AbhI2Vka (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 17:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344269AbhI2Vka (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Sep 2021 17:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632951528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GFQyIQau4ZqHlHKeJVLj2V2Zq1y0ubXLhD9d0aYg5f8=;
        b=S1ab0KS7MPHHvr6vRUBPhLuHSXEuAeRgtcVFudvKLOabH33uvBTacJ4gxfruz2R60GHWuP
        CMDYnoPuK/v4brwpRvh6i8Gb7HZRCKZSwvhc9WBgkH1knNg9BNKDtzgUk1RyFrZeT+TJbA
        QI963Vx8r4zW5Swy1RxTh7AWRQMKPBM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-5xeOjuT5PyacUDY5D6ilZQ-1; Wed, 29 Sep 2021 17:38:46 -0400
X-MC-Unique: 5xeOjuT5PyacUDY5D6ilZQ-1
Received: by mail-ed1-f69.google.com with SMTP id h6-20020a50c386000000b003da01adc065so3928591edf.7
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 14:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFQyIQau4ZqHlHKeJVLj2V2Zq1y0ubXLhD9d0aYg5f8=;
        b=XTG0Ysk7QeR4f4xAzpPZTCPd99mvysGmzbJPTOBGHS2crL2CCLEfaJ6BjmHI6Ip7Ny
         HHQ+CI5TQyCbeS17UnRK8lk5s+BS9fEHc6TWCjttlQLEGS9IAGovown8k0bavRfgcuiP
         I0Em8ynYUHlu4p+w1b1kKmmP143gWIv9jVm7PgNs5O3rGvttPbo6v2fPhBxMdnu1oaiL
         kfAFwaTKsP1QEm6EY7W/JKcle+FgeS6Oac/+94QZDNyaO2nML6H1wQBalw6l9Z+R9Xjm
         d4Wq3nL1rY376rMtq6Jr+Tj3WfQzbnjdehdBc4PVDYw1p51areJueI0/hK42N0uUV1/L
         RQ6Q==
X-Gm-Message-State: AOAM532pud5iyWIotTtyh6nY0yRXNbegrUum6SFexies3MLyKvlCv/ah
        xMj8wgSaTYADEmVWRQA/ZBZt+WFVPlksdKNjmVKidXHr+OmBnkxI55WYnxhbZe93iMzowm+wbG1
        HUPaToBWvkYe4
X-Received: by 2002:a17:906:2691:: with SMTP id t17mr2413696ejc.522.1632951525335;
        Wed, 29 Sep 2021 14:38:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxV3yi4hVwTbLwu8bjXisu/brfph67g1je/j5/L1usCpUjEy7tIHvP+x7DmAP5NMrVlfOaL7g==
X-Received: by 2002:a17:906:2691:: with SMTP id t17mr2413668ejc.522.1632951525023;
        Wed, 29 Sep 2021 14:38:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id qw28sm570391ejb.56.2021.09.29.14.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 14:38:44 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B6EC718034F; Wed, 29 Sep 2021 23:38:43 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Benc <jbenc@redhat.com>, bpf@vger.kernel.org
Subject: [PATCH bpf-next] libbpf: properly ignore STT_SECTION symbols in legacy map definitions
Date:   Wed, 29 Sep 2021 23:38:37 +0200
Message-Id: <20210929213837.832449-1-toke@redhat.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The previous patch to ignore STT_SECTION symbols only added the ignore
condition in one of them. This fails if there's more than one map
definition in the 'maps' section, because the subsequent modulus check will
fail, resulting in error messages like:

libbpf: elf: unable to determine legacy map definition size in ./xdpdump_xdp.o

Fix this by also ignoring STT_SECTION in the first loop.

Fixes: c3e8c44a9063 ("libbpf: Ignore STT_SECTION symbols in 'maps' section")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
Terribly sorry for not catching this in the previous patch. I was testing with an
object file with only one map definition, which worked fine :(

 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 453148fe8b4b..c20b2167e354 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1845,6 +1845,8 @@ static int bpf_object__init_user_maps(struct bpf_object *obj, bool strict)
 			continue;
 		if (sym.st_shndx != obj->efile.maps_shndx)
 			continue;
+		if (GELF_ST_TYPE(sym.st_info) == STT_SECTION)
+			continue;
 		nr_maps++;
 	}
 	/* Assume equally sized map definitions */
-- 
2.33.0

