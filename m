Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC471996FB
	for <lists+bpf@lfdr.de>; Tue, 31 Mar 2020 15:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbgCaNGq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Mar 2020 09:06:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35021 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730473AbgCaNGq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Mar 2020 09:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585660005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TEnvRQUG2NaO2WXEs+JHaZkj1OJo/2Aq4DgDrJCFUmo=;
        b=RnRP3Kxeo36Cb7IDZtejJxypFAa7b4a0Z7+6nzklIADlRC9tt5ma4YurQ9zdPs9y8cdOXW
        VXIjYcDm14RVDsEaPiPKsnN7sN0C+rcktqMb7XjpcKubHAy0bsBEb/aoaZDZeNTXv7OIRQ
        J+c4x0kC1bmQK2/ScejKo6ZGBEieT08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-eoYx2jAsPdKOexGShbHIyg-1; Tue, 31 Mar 2020 09:06:41 -0400
X-MC-Unique: eoYx2jAsPdKOexGShbHIyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 430DA80573C;
        Tue, 31 Mar 2020 13:06:40 +0000 (UTC)
Received: from localhost (ovpn-116-139.gru2.redhat.com [10.97.116.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87C7F94B5C;
        Tue, 31 Mar 2020 13:06:36 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, micron10@gmail.com, ast@kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH] net/bpfilter: remove superfluous testing message
Date:   Tue, 31 Mar 2020 10:06:30 -0300
Message-Id: <20200331130630.633400-1-bmeneg@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A testing message was brought by 13d0f7b814d9 ("net/bpfilter: fix dprintf
usage for /dev/kmsg") but should've been deleted before patch submission.
Although it doesn't cause any harm to the code or functionality itself, i=
t's
totally unpleasant to have it displayed on every loop iteration with no r=
eal
use case. Thus remove it unconditionally.

Fixes: 13d0f7b814d9 ("net/bpfilter: fix dprintf usage for /dev/kmsg")
Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 net/bpfilter/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bpfilter/main.c b/net/bpfilter/main.c
index efea4874743e..05e1cfc1e5cd 100644
--- a/net/bpfilter/main.c
+++ b/net/bpfilter/main.c
@@ -35,7 +35,6 @@ static void loop(void)
 		struct mbox_reply reply;
 		int n;
=20
-		fprintf(debug_f, "testing the buffer\n");
 		n =3D read(0, &req, sizeof(req));
 		if (n !=3D sizeof(req)) {
 			fprintf(debug_f, "invalid request %d\n", n);
--=20
2.25.1

