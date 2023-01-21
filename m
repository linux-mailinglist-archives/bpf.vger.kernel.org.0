Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2B6676335
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 03:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjAUC53 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 21:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjAUC53 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 21:57:29 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFD16AC91
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 18:57:28 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KNmeOF012368
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 18:57:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=Zhn9xNVwKO2PPFy243h0rJy1V/FGtGTYjCYHqV53EQo=;
 b=BrfO8SVnjbVznyUk7l+53UTFcC5fwPX5gAOxdWoDc04B3+vcm1Q3fMEocpDeDPgBACNk
 4oQz7X1yfpOMYS1kxZimndAk36cuSpPRJP4/X8xw+jgo4eT36AXDQNvCrErBFmzyULic
 hr7oGq96nCGhlM3oYn7fC8DxXMidN3WIVRmb21zfAMZam0rv3fa/m/ZAhUrJGldgte4O
 Jb/EMwEA8vXDVdpnvzdnNHm7h7iPt+/IEy1zeb5lcMU/TJeYcjbVtKANC0XcKO0VMSi5
 OubuA1mU4iTkAD/Wz5zcdXxYanHypq2YtoGhP+A0ukvVm4xjCl5TanmEGeNkphqd7MWC ZA== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n702vmvqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 18:57:28 -0800
Received: from twshared19053.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 18:57:27 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 8CA3531A6231; Fri, 20 Jan 2023 18:57:18 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <song@kernel.org>, <kernel-team@meta.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next 1/2] bpf: Check the protocol of a sock to agree the calls to bpf_setsockopt().
Date:   Fri, 20 Jan 2023 18:57:15 -0800
Message-ID: <20230121025716.3039933-2-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230121025716.3039933-1-kuifeng@meta.com>
References: <20230121025716.3039933-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Oa8j4A314Dgwkz2LrYizQfbwROBgBpN5
X-Proofpoint-ORIG-GUID: Oa8j4A314Dgwkz2LrYizQfbwROBgBpN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_13,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Resolve an issue when calling sol_tcp_sockopt() on a socket with ktls
enabled. Prior to this patch, sol_tcp_sockopt() would only allow calls
if the function pointer of setsockopt of the socket was set to
tcp_setsockopt(). However, any socket with ktls enabled would have its
function pointer set to tls_setsockopt(). To resolve this issue, the
patch adds a check of the protocol of the linux socket and allows
bpf_setsockopt() to be called if ktls is initialized on the linux
socket. This ensures that calls to sol_tcp_sockopt() will succeed on
sockets with ktls enabled.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index b4547a2c02f4..890384cbdeb2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5204,7 +5204,7 @@ static int sol_tcp_sockopt(struct sock *sk, int opt=
name,
 			   char *optval, int *optlen,
 			   bool getopt)
 {
-	if (sk->sk_prot->setsockopt !=3D tcp_setsockopt)
+	if (sk->sk_protocol !=3D IPPROTO_TCP)
 		return -EINVAL;
=20
 	switch (optname) {
--=20
2.30.2

