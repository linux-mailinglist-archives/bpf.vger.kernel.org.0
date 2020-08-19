Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDF3249B5E
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 13:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgHSLFx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 07:05:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56151 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727901AbgHSLFm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Aug 2020 07:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597835141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BlIxxc2NP5YsxPio5n+cKYLRJVTpBsLfxKRpA+yVyjk=;
        b=IIGpNMIe7mTMQId78TybSJnl7xu7UIaZ4oVYTCZe9wmvVQey9u8iDUBVtjGYy7DDGfPunD
        zV663GdDfAO6b3zylbqxVYgyhMkkE7yq3XhcsftATBexUi3kB605WpMEVu/1pSsZlXDSnX
        LbVFF+x3rRdPhmieA+lytIqV5t1vM38=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-SZNu0gZaP5SgVoBMRmZCQQ-1; Wed, 19 Aug 2020 07:05:39 -0400
X-MC-Unique: SZNu0gZaP5SgVoBMRmZCQQ-1
Received: by mail-wr1-f69.google.com with SMTP id m7so9221823wrb.20
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 04:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BlIxxc2NP5YsxPio5n+cKYLRJVTpBsLfxKRpA+yVyjk=;
        b=JCJDQLlOzZZqKuuA0Iz1+3/BQv64mlxuLJS/wfmOBOkhDLNIzz6Q73vLDWpHIOkI+H
         iG/m0KBC3FOS8nxs/AdBg62UZSxUM/WrZsw6e0j5F9xByNW8wDgkQH5o/Uhlw7QxzBS8
         DgogFTuKDebGTRt9vlat3NfZZDHdGYMzdjYSC7MgsB9Hrm3s4GoHV7z8NhqnJ5HMjEhZ
         h031/lSKlZRl86ebLGRYT2nnatQ9572CGOdEg1ThEeNKyoZQ9dxOvKA9Sp8YwobaMXo+
         +xmP33mJjKE9ctYbkK+HesvGYu+cMqpE4tr41IWw0zkT+/oOIsW+OWl4pxcYIOm7LMdW
         +xiQ==
X-Gm-Message-State: AOAM532i6VmqhMN1EpzxjhZOFRq8xHkigCQAuwGnZN9xTJ26Opkfa2x9
        5xGjOmUck4NLKrDG3m+IRSGZX9b8aJKBj4yJ0AjUxz2DdZyl1dcszvjkG3KuHeaalUFGqPgJPwx
        Qjaa9FB05MVCf
X-Received: by 2002:a1c:41c5:: with SMTP id o188mr4467209wma.187.1597835138126;
        Wed, 19 Aug 2020 04:05:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw++CRYKKVRjU61mp4sDlrM7r+oWH1k7qLIf/Zd+Cohsxxqj9be2dzy5fKmY9DjytQnLNYtyQ==
X-Received: by 2002:a1c:41c5:: with SMTP id o188mr4467191wma.187.1597835137971;
        Wed, 19 Aug 2020 04:05:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b123sm4931449wme.20.2020.08.19.04.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 04:05:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BD27D182B54; Wed, 19 Aug 2020 13:05:36 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf] libbpf: fix map index used in error message
Date:   Wed, 19 Aug 2020 13:05:34 +0200
Message-Id: <20200819110534.9058-1-toke@redhat.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The error message emitted by bpf_object__init_user_btf_maps() was using the
wrong section ID.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5d20b2da4427..0ad0b0491e1f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2264,7 +2264,7 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 		data = elf_getdata(scn, NULL);
 	if (!scn || !data) {
 		pr_warn("failed to get Elf_Data from map section %d (%s)\n",
-			obj->efile.maps_shndx, MAPS_ELF_SEC);
+			obj->efile.btf_maps_shndx, MAPS_ELF_SEC);
 		return -EINVAL;
 	}
 
-- 
2.28.0

