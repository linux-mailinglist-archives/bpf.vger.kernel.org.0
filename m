Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1281E24C1
	for <lists+bpf@lfdr.de>; Tue, 26 May 2020 16:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgEZO6l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 May 2020 10:58:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22956 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731329AbgEZO6k (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 May 2020 10:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590505118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4tAE1IK4f2T1kuJd9DT8hikh4EdTWXjmuVs8CT+cGE0=;
        b=gM1LEYZnk031CIsxiHKp7oQegfn/NmI40Iw6oaqZdHquw/HodRQ6NlSufRChpYDi8+Xerz
        oTkJY8U5H06N2kStoxdn18Hip1L106olfX+EMF7N3rA2QrX3gvfyF6wRnuRnjazWHDt3s9
        Eb2DT9q9ymQcWMMSOb3hdoQzIrLaRjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-iQffCG_xMXCBCE5H44383Q-1; Tue, 26 May 2020 10:58:37 -0400
X-MC-Unique: iQffCG_xMXCBCE5H44383Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1193D835B49;
        Tue, 26 May 2020 14:58:36 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B75FF5D9E7;
        Tue, 26 May 2020 14:58:31 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 8B5F6300003E9;
        Tue, 26 May 2020 16:58:30 +0200 (CEST)
Subject: [PATCH bpf-next] bpf: Fix map_check_no_btf return code
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Tue, 26 May 2020 16:58:30 +0200
Message-ID: <159050511046.148183.1806612131878890638.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a BPF-map type doesn't support having a BTF info associated, the
bpf_map_ops->map_check_btf is set to map_check_no_btf(). This function
map_check_no_btf() currently returns -ENOTSUPP, which result in a very
confusing error message in libbpf, see below.

The errno ENOTSUPP is part of the kernels internal errno in file
include/linux/errno.h. As is stated in the file, these "should never be seen
by user programs."

Choosing errno EUCLEAN instead, which translated to "Structure needs
cleaning" by strerror(3). This hopefully leads people to think about data
structures which BTF is all about.

Before this change end-users of libbpf will see:
 libbpf: Error in bpf_create_map_xattr(cpu_map):ERROR: strerror_r(-524)=22(-524). Retrying without BTF.

After this change end-users of libbpf will see:
 libbpf: Error in bpf_create_map_xattr(cpu_map):Structure needs cleaning(-117). Retrying without BTF.

Fixes: e8d2bec04579 ("bpf: decouple btf from seq bpf fs dump and enable more maps")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 kernel/bpf/syscall.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d13b804ff045..ecde7d938421 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -732,7 +732,7 @@ int map_check_no_btf(const struct bpf_map *map,
 		     const struct btf_type *key_type,
 		     const struct btf_type *value_type)
 {
-	return -ENOTSUPP;
+	return -EUCLEAN;
 }
 
 static int map_check_btf(struct bpf_map *map, const struct btf *btf,


