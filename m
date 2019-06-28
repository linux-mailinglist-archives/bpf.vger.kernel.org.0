Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5780458F88
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2019 03:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfF1BMg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jun 2019 21:12:36 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:33580 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfF1BMg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jun 2019 21:12:36 -0400
Received: by mail-pl1-f201.google.com with SMTP id f2so2470269plr.0
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2019 18:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Mv+Yt5661paO9K5dtP2dnQMy9o+sBxrbFhsWwSqJJcg=;
        b=fDc2qQrbPMqyoUOaO3fNeaHuQ43ov0aOHxaebEouKgwpC4G3ev/jls3vwwSvcszWbX
         IZhsE6K8dTrSEz1CjjdGtNBGq8zYfVJXg5VU2WUZ/F+IWp/I65K5chy6yMAk68bQtDey
         zTJS2cLjFqPbp2c2gobLF0cfOmNwJaH35Q97uKkbW/RobR4QO+QjUE2JDw+egcR/F3zK
         CcmOkhoizWftCW4vG+Y4wzzQnU5enejBy8l5dq+cLPtm/CZmAvaNECoZOYKmP1+caQqV
         h8hx07T+KvLon+T1YmJMaxit3RNmhuzwIKHRPaG/r316wGeKL72f3iUwl4uemVSgHDwT
         tIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Mv+Yt5661paO9K5dtP2dnQMy9o+sBxrbFhsWwSqJJcg=;
        b=RxTngkDZB7cwCyZ6lTql/sVhvCibRSg1Pc+GASz3f55rtrbOmHencUjpr049JSV+7s
         /J0xT92rE8uujf/YSxGRcGWEISHXhjBKYKBfWbjzGxwhkwpZL7j7nbNxyC5wEap3u1fu
         2ny3yhyVWw+W8qjzFKIJnsh38pv9mPGtRe6iCovk4rgrmnlcy+atX3hJwKhn22GASeAo
         2Os+fQTSaa/SL2/8t1tshU8rIjV2KriGPhi2UEQczbPqjTcWTxotzSJ95ERfdZ9uXZ+7
         lLhVw/zmnfWF21gJm6VjpLKAqEfSQ7DCswRe8TdGFjqRGAJYajUzM2jVREMLH+CUPNWY
         8sdA==
X-Gm-Message-State: APjAAAXM0YVaoDW3NPgx9i/g/KHM3rcjYD9ozKBoaaTfVtfkZ9OjO7G6
        R4RzxdODbLj9y4AjdoL2TAOjGB4=
X-Google-Smtp-Source: APXvYqwkk6MBmmrk0+2fHEUEMJ52i+jfYv7vxan+bt8Qo3VylUxEwqZYZAx235/ZwaMa7oPZ2ZUgAwo=
X-Received: by 2002:a63:de50:: with SMTP id y16mr6615587pgi.431.1561684355393;
 Thu, 27 Jun 2019 18:12:35 -0700 (PDT)
Date:   Thu, 27 Jun 2019 18:12:33 -0700
Message-Id: <20190628011233.63680-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next] selftests/bpf: fix -Wstrict-aliasing in test_sockopt_sk.c
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Let's use union with u8[4] and u32 members for sockopt buffer,
that should fix any possible aliasing issues.

test_sockopt_sk.c: In function =E2=80=98getsetsockopt=E2=80=99:
test_sockopt_sk.c:115:2: warning: dereferencing type-punned pointer will br=
eak strict-aliasing rules [-Wstrict-aliasing]
  if (*(__u32 *)buf !=3D 0x55AA*2) {
  ^~
test_sockopt_sk.c:116:3: warning: dereferencing type-punned pointer will br=
eak strict-aliasing rules [-Wstrict-aliasing]
   log_err("Unexpected getsockopt(SO_SNDBUF) 0x%x !=3D 0x55AA*2",
   ^~~~~~~

Fixes: 8a027dc0d8f5 ("selftests/bpf: add sockopt test that exercises sk hel=
pers")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_sockopt_sk.c | 51 +++++++++----------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockopt_sk.c b/tools/testing/=
selftests/bpf/test_sockopt_sk.c
index 12e79ed075ce..036b652e5ca9 100644
--- a/tools/testing/selftests/bpf/test_sockopt_sk.c
+++ b/tools/testing/selftests/bpf/test_sockopt_sk.c
@@ -22,7 +22,10 @@
 static int getsetsockopt(void)
 {
 	int fd, err;
-	char buf[4] =3D {};
+	union {
+		char u8[4];
+		__u32 u32;
+	} buf =3D {};
 	socklen_t optlen;
=20
 	fd =3D socket(AF_INET, SOCK_STREAM, 0);
@@ -33,31 +36,31 @@ static int getsetsockopt(void)
=20
 	/* IP_TOS - BPF bypass */
=20
-	buf[0] =3D 0x08;
-	err =3D setsockopt(fd, SOL_IP, IP_TOS, buf, 1);
+	buf.u8[0] =3D 0x08;
+	err =3D setsockopt(fd, SOL_IP, IP_TOS, &buf, 1);
 	if (err) {
 		log_err("Failed to call setsockopt(IP_TOS)");
 		goto err;
 	}
=20
-	buf[0] =3D 0x00;
+	buf.u8[0] =3D 0x00;
 	optlen =3D 1;
-	err =3D getsockopt(fd, SOL_IP, IP_TOS, buf, &optlen);
+	err =3D getsockopt(fd, SOL_IP, IP_TOS, &buf, &optlen);
 	if (err) {
 		log_err("Failed to call getsockopt(IP_TOS)");
 		goto err;
 	}
=20
-	if (buf[0] !=3D 0x08) {
+	if (buf.u8[0] !=3D 0x08) {
 		log_err("Unexpected getsockopt(IP_TOS) buf[0] 0x%02x !=3D 0x08",
-			buf[0]);
+			buf.u8[0]);
 		goto err;
 	}
=20
 	/* IP_TTL - EPERM */
=20
-	buf[0] =3D 1;
-	err =3D setsockopt(fd, SOL_IP, IP_TTL, buf, 1);
+	buf.u8[0] =3D 1;
+	err =3D setsockopt(fd, SOL_IP, IP_TTL, &buf, 1);
 	if (!err || errno !=3D EPERM) {
 		log_err("Unexpected success from setsockopt(IP_TTL)");
 		goto err;
@@ -65,16 +68,16 @@ static int getsetsockopt(void)
=20
 	/* SOL_CUSTOM - handled by BPF */
=20
-	buf[0] =3D 0x01;
-	err =3D setsockopt(fd, SOL_CUSTOM, 0, buf, 1);
+	buf.u8[0] =3D 0x01;
+	err =3D setsockopt(fd, SOL_CUSTOM, 0, &buf, 1);
 	if (err) {
 		log_err("Failed to call setsockopt");
 		goto err;
 	}
=20
-	buf[0] =3D 0x00;
+	buf.u32 =3D 0x00;
 	optlen =3D 4;
-	err =3D getsockopt(fd, SOL_CUSTOM, 0, buf, &optlen);
+	err =3D getsockopt(fd, SOL_CUSTOM, 0, &buf, &optlen);
 	if (err) {
 		log_err("Failed to call getsockopt");
 		goto err;
@@ -84,37 +87,31 @@ static int getsetsockopt(void)
 		log_err("Unexpected optlen %d !=3D 1", optlen);
 		goto err;
 	}
-	if (buf[0] !=3D 0x01) {
-		log_err("Unexpected buf[0] 0x%02x !=3D 0x01", buf[0]);
+	if (buf.u8[0] !=3D 0x01) {
+		log_err("Unexpected buf[0] 0x%02x !=3D 0x01", buf.u8[0]);
 		goto err;
 	}
=20
 	/* SO_SNDBUF is overwritten */
=20
-	buf[0] =3D 0x01;
-	buf[1] =3D 0x01;
-	buf[2] =3D 0x01;
-	buf[3] =3D 0x01;
-	err =3D setsockopt(fd, SOL_SOCKET, SO_SNDBUF, buf, 4);
+	buf.u32 =3D 0x01010101;
+	err =3D setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &buf, 4);
 	if (err) {
 		log_err("Failed to call setsockopt(SO_SNDBUF)");
 		goto err;
 	}
=20
-	buf[0] =3D 0x00;
-	buf[1] =3D 0x00;
-	buf[2] =3D 0x00;
-	buf[3] =3D 0x00;
+	buf.u32 =3D 0x00;
 	optlen =3D 4;
-	err =3D getsockopt(fd, SOL_SOCKET, SO_SNDBUF, buf, &optlen);
+	err =3D getsockopt(fd, SOL_SOCKET, SO_SNDBUF, &buf, &optlen);
 	if (err) {
 		log_err("Failed to call getsockopt(SO_SNDBUF)");
 		goto err;
 	}
=20
-	if (*(__u32 *)buf !=3D 0x55AA*2) {
+	if (buf.u32 !=3D 0x55AA*2) {
 		log_err("Unexpected getsockopt(SO_SNDBUF) 0x%x !=3D 0x55AA*2",
-			*(__u32 *)buf);
+			buf.u32);
 		goto err;
 	}
=20
--=20
2.22.0.410.gd8fdbe21b5-goog

