Return-Path: <bpf+bounces-5909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A38762CBD
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 09:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781A6281C19
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 07:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833CB8480;
	Wed, 26 Jul 2023 07:10:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB3615C4
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 07:10:03 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06CC559E;
	Wed, 26 Jul 2023 00:09:49 -0700 (PDT)
X-UUID: 48d18b7fbb5e4399a646d23469c1a346-20230726
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:308e6581-c474-4014-b1a3-53283994d9aa,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.28,REQID:308e6581-c474-4014-b1a3-53283994d9aa,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:2dd756d2-cd77-4e67-bbfd-aa4eaace762f,B
	ulkID:230726150927DGBQ9DXH,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 48d18b7fbb5e4399a646d23469c1a346-20230726
X-User: guodongtai@kylinos.cn
Received: from localhost.localdomain [(39.156.73.12)] by mailgw
	(envelope-from <guodongtai@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 586468305; Wed, 26 Jul 2023 15:09:24 +0800
From: George Guo <guodongtai@kylinos.cn>
To: masahiroy@kernel.org,
	ndesaulniers@google.com,
	nathan@kernel.org,
	nicolas@fjasle.eu
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] samples/bpf: Update sockex2: get the expected output results
Date: Wed, 26 Jul 2023 15:09:55 +0800
Message-Id: <20230726070955.178288-1-guodongtai@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Running "ping -4 -c5 localhost" only shows 4 times prints not 5:

$ sudo ./samples/bpf/sockex2
ip 127.0.0.1 bytes 392 packets 4
ip 127.0.0.1 bytes 784 packets 8
ip 127.0.0.1 bytes 1176 packets 12
ip 127.0.0.1 bytes 1568 packets 16

debug it with num prints:
$ sudo ./samples/bpf/sockex2
num = 1: ip 127.0.0.1 bytes 392 packets 4
num = 2: ip 127.0.0.1 bytes 784 packets 8
num = 3: ip 127.0.0.1 bytes 1176 packets 12
num = 4: ip 127.0.0.1 bytes 1568 packets 16

The reason is that we check it faster, just put sleep(1) before check
while(bpf_map_get_next_key(map_fd, &key, &next_key) == 0).
Now we get the expected results:

$ sudo ./samples/bpf/sockex2
num = 0: ip 127.0.0.1 bytes 392 packets 4
num = 1: ip 127.0.0.1 bytes 784 packets 8
num = 2: ip 127.0.0.1 bytes 1176 packets 12
num = 3: ip 127.0.0.1 bytes 1568 packets 16
num = 4: ip 127.0.0.1 bytes 1960 packets 20

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 samples/bpf/sockex2_user.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/samples/bpf/sockex2_user.c b/samples/bpf/sockex2_user.c
index 2c18471336f0..84bf1ab77649 100644
--- a/samples/bpf/sockex2_user.c
+++ b/samples/bpf/sockex2_user.c
@@ -18,8 +18,8 @@ int main(int ac, char **argv)
 	struct bpf_program *prog;
 	struct bpf_object *obj;
 	int map_fd, prog_fd;
-	char filename[256];
-	int i, sock, err;
+	char filename[256], command[64];
+	int i, sock, err, num = 5;
 	FILE *f;
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
@@ -42,21 +42,22 @@ int main(int ac, char **argv)
 	assert(setsockopt(sock, SOL_SOCKET, SO_ATTACH_BPF, &prog_fd,
 			  sizeof(prog_fd)) == 0);
 
-	f = popen("ping -4 -c5 localhost", "r");
+	snprintf(command, sizeof(command), "ping -4 -c%d localhost", num);
+	f = popen(command, "r");
 	(void) f;
 
-	for (i = 0; i < 5; i++) {
+	for (i = 0; i < num; i++) {
 		int key = 0, next_key;
 		struct pair value;
 
+		sleep(1);
 		while (bpf_map_get_next_key(map_fd, &key, &next_key) == 0) {
 			bpf_map_lookup_elem(map_fd, &next_key, &value);
-			printf("ip %s bytes %lld packets %lld\n",
+			printf("num = %d: ip %s bytes %lld packets %lld\n", i,
 			       inet_ntoa((struct in_addr){htonl(next_key)}),
 			       value.bytes, value.packets);
 			key = next_key;
 		}
-		sleep(1);
 	}
 	return 0;
 }
-- 
2.34.1


