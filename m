Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEAC183D0A
	for <lists+bpf@lfdr.de>; Fri, 13 Mar 2020 00:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgCLXIa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 19:08:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58705 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726710AbgCLXIa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Mar 2020 19:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584054509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h4wdU2a9XoFrutcCJNoK3uetDhXcg3rLVvbtWHaFulA=;
        b=bvju6hx1UPnwzfQvOV/dgPNYBoUthv9xdCNTekULK/aT9amNV+f8hh+pz2NpLc/uZMOQ/g
        pkzRB9Zxq46X/1p7q1tOaPOrRZHPsMRan0SgQtgNMzM/FHOTqRnMxximbh3nkGruTP1F2h
        mip0UmbasBKWOZwWGiY+3Ez75vvghkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-DfpokljDPvucxZeEsqrfkg-1; Thu, 12 Mar 2020 19:08:27 -0400
X-MC-Unique: DfpokljDPvucxZeEsqrfkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D02AA107ACC9;
        Thu, 12 Mar 2020 23:08:25 +0000 (UTC)
Received: from localhost (ovpn-121-102.rdu2.redhat.com [10.10.121.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 859551001902;
        Thu, 12 Mar 2020 23:08:22 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     GLin@suse.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2] net/bpfilter: fix dprintf usage for /dev/kmsg
Date:   Thu, 12 Mar 2020 20:08:20 -0300
Message-Id: <20200312230820.2132069-1-bmeneg@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpfilter UMH code was recently changed to log its informative message=
s to
/dev/kmsg, however this interface doesn't support SEEK_CUR yet, used by
dprintf(). As result dprintf() returns -EINVAL and doesn't log anything.

However there already had some discussions about supporting SEEK_CUR into
/dev/kmsg interface in the past it wasn't concluded. Since the only user =
of
that from userspace perspective inside the kernel is the bpfilter UMH
(userspace) module it's better to correct it here instead waiting a concl=
usion
on the interface.

Fixes: 36c4357c63f3 ("net: bpfilter: print umh messages to /dev/kmsg")
Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 net/bpfilter/main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/bpfilter/main.c b/net/bpfilter/main.c
index 77396a098fbe..efea4874743e 100644
--- a/net/bpfilter/main.c
+++ b/net/bpfilter/main.c
@@ -10,7 +10,7 @@
 #include <asm/unistd.h>
 #include "msgfmt.h"
=20
-int debug_fd;
+FILE *debug_f;
=20
 static int handle_get_cmd(struct mbox_request *cmd)
 {
@@ -35,9 +35,10 @@ static void loop(void)
 		struct mbox_reply reply;
 		int n;
=20
+		fprintf(debug_f, "testing the buffer\n");
 		n =3D read(0, &req, sizeof(req));
 		if (n !=3D sizeof(req)) {
-			dprintf(debug_fd, "invalid request %d\n", n);
+			fprintf(debug_f, "invalid request %d\n", n);
 			return;
 		}
=20
@@ -47,7 +48,7 @@ static void loop(void)
=20
 		n =3D write(1, &reply, sizeof(reply));
 		if (n !=3D sizeof(reply)) {
-			dprintf(debug_fd, "reply failed %d\n", n);
+			fprintf(debug_f, "reply failed %d\n", n);
 			return;
 		}
 	}
@@ -55,9 +56,10 @@ static void loop(void)
=20
 int main(void)
 {
-	debug_fd =3D open("/dev/kmsg", 00000002);
-	dprintf(debug_fd, "Started bpfilter\n");
+	debug_f =3D fopen("/dev/kmsg", "w");
+	setvbuf(debug_f, 0, _IOLBF, 0);
+	fprintf(debug_f, "Started bpfilter\n");
 	loop();
-	close(debug_fd);
+	fclose(debug_f);
 	return 0;
 }
--=20
2.24.1

