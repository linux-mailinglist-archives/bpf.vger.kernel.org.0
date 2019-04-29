Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6631EE3E9
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2019 15:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfD2NqX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Apr 2019 09:46:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47560 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbfD2NqX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Apr 2019 09:46:23 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A532B4FBAD9A45CAE935;
        Mon, 29 Apr 2019 21:46:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Mon, 29 Apr 2019 21:46:09 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH net-next] bpf: Use PTR_ERR_OR_ZERO in bpf_fd_sk_storage_update_elem()
Date:   Mon, 29 Apr 2019 13:56:11 +0000
Message-ID: <20190429135611.72640-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/core/bpf_sk_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index a8e9ac71b22d..cc9597a87770 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -708,7 +708,7 @@ static int bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
 	if (sock) {
 		sdata = sk_storage_update(sock->sk, map, value, map_flags);
 		sockfd_put(sock);
-		return IS_ERR(sdata) ? PTR_ERR(sdata) : 0;
+		return PTR_ERR_OR_ZERO(sdata);
 	}
 
 	return err;





