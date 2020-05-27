Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7B81E4024
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 13:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgE0LeD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 07:34:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31536 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728962AbgE0LeD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 May 2020 07:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590579242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OJ0aWjGhMAbtLyDaiXZ47E6ii9k8+r2gqwcz/bpN+Bk=;
        b=VbEiiH0Hp4rOdnvXuf+QnoV19QgtQcPLl72pNUTrM2qCXeeUbv3EE+7Q9Yh9F4w4kcVoCJ
        Z5hLY8gDUzaYhbHZui+L5MoD7KrLtLcjVPnZzZhzGAbpC+UGPZ+Aqo+hHzokazdNTqIxdL
        RGKQwlHCQeKpXMBpsm6PepTNRNwkRmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-XLaBZvCRMHqdYiuWpZmduw-1; Wed, 27 May 2020 07:33:59 -0400
X-MC-Unique: XLaBZvCRMHqdYiuWpZmduw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C033D80183C;
        Wed, 27 May 2020 11:33:58 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF0835C1BD;
        Wed, 27 May 2020 11:33:55 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 6EEC8300003EB;
        Wed, 27 May 2020 13:33:54 +0200 (CEST)
Subject: [PATCH bpf-next V2] bpf: Fix map_check_no_btf return code
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 May 2020 13:33:54 +0200
Message-ID: <159057923399.191121.11186124752660899399.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a BPF-map type doesn't support having a BTF info associated, the
bpf_map_ops->map_check_btf is set to map_check_no_btf(). This function
map_check_no_btf() currently returns -ENOTSUPP, which result in a very
confusing error message in libbpf, see below.

The errno ENOTSUPP is part of the kernels internal errno in file
include/linux/errno.h. As is stated in the file, these "should never be
seen by user programs". This is not a not a standard Unix error.

This should likely have been EOPNOTSUPP instead. This seems to be a common
mistake, that even checkpatch tries to catch see commit 6b9ea5ff5abd
("checkpatch: warn about uses of ENOTSUPP").

Before this change end-users of libbpf will see:
 libbpf: Error in bpf_create_map_xattr(cpu_map):ERROR: strerror_r(-524)=22(-524). Retrying without BTF.

After this change end-users of libbpf will see:
 libbpf: Error in bpf_create_map_xattr(cpu_map):Operation not supported(-95). Retrying without BTF.

V2: Use EOPNOTSUPP instead of EUCLEAN.

Fixes: e8d2bec04579 ("bpf: decouple btf from seq bpf fs dump and enable more maps")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 kernel/bpf/syscall.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d13b804ff045..e4e0a0c5192c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -732,7 +732,7 @@ int map_check_no_btf(const struct bpf_map *map,
 		     const struct btf_type *key_type,
 		     const struct btf_type *value_type)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static int map_check_btf(struct bpf_map *map, const struct btf *btf,


