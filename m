Return-Path: <bpf+bounces-53452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC71A5419D
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 05:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C738716D344
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 04:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F9619AD70;
	Thu,  6 Mar 2025 04:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="e52ri+gM"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E11718C337
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 04:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741234919; cv=none; b=B8S7jmXAp9DuzRVSuPUCiS8aA8vOC2qEyD2vGHH6/vz9nyhda69dnNsPGz+7R1ZD0aiAeKVaUzNYTHEjniqUmppJu9Rj9E+/Lt53rEKmKaDwBqpOrxGtOiLU2xf3VXyZetdrikOjE8mnBlBMklEYiBf+GEXhaLkfBM50JbFSn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741234919; c=relaxed/simple;
	bh=k1oeK3pvC1DWhYVUI/+gn5QuO8FyTWbVSdIBCg4KbDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=elSiLSj6EnsOXxHMP+OjRZaJuAWtStGo3TxmSoKdObxRHSuRiFRgfj2XEmLNmXlV/LJMn7QDMsWSvofa0d86nUyU65vLxYYvjLgP+xGwU9JptiPH/sAYMJb9qYIQ028V2UTNnE7cLkmrISTxaJ2mxfIcFd7VZPJp3EtUmGj+70E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=e52ri+gM; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1741234913; x=1741839713; i=linux@jordanrome.com;
	bh=YSzjZsGurb7cFOuiOUaXQeLPSDmqRR5nIL4MOGPXFvk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=e52ri+gMktIGTg6bFPaw+ktAcQ6GXL8GQx9q5K5QwAA7cUMk+qwThZD7BohnSxsv
	 CKDKaiZ0UjRcLgFFKbdle5YJH59laHNH/grXYjYOP/qoCOvMlQJLyYajEb9Mtk1jR
	 CIMzYgaB1reL957hh07Tq9zHJJ9WdjvMhi6mC8CPtggil6JBwlODtY2k80L/CC0/P
	 MSyCfFxXQNaVykr+TW/QTnLZBXGDAotqzdFte2sNkChZ/Trbn7dOtgGFFz9DGNa3R
	 sU2q4arL4NM2Ho1inGM9xgp/OSqzDDhoBmxPmqWqi27/5qnqpSoW5m/ynf9n370ZV
	 50YiRODfUh7bGpck4g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.4]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lmae5-1tHFbj14pX-00ZLyd; Thu, 06 Mar
 2025 05:08:04 +0100
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: [bpf-next v2] bpf: adjust btf load error logging
Date: Wed,  5 Mar 2025 20:07:56 -0800
Message-ID: <20250306040756.3191271-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MStJzM0ffWVcN6c+22nRn701o15dKeSObrQBKUAZfxP5MsT7ZXC
 QJwZOj+H/N6ELprX8Wlt1lhjqfKZfrMv0T+j3/Ep+QVvVeJ2chEnUediigdyA4Z8qq/sVYv
 mCQf9e1wcb5VRNrz3j76vcnSYwVTZppaN8u26w1qQYkoItZoO6KhTkeyRj5Hqah8lZzCzWQ
 WCBlqRoMJdP7ruwnFO9tg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HSE4WlpFLHs=;fUgF6sOvURvpXud7Gcvj+yDiPEe
 R6LMdK+7NDSI91khPoxoDfqBWtRlVBzU2u1cdrSv+qKHs9xyqXqYOGLC9aCguCy+fwRRl4K3X
 /WCehBGvKaAiMIRoYDWpg2FtoNP7hyIotYUPUIHoJl05TluL8UFyposzbgObNaqWHxiqZRCGQ
 EklnDY4YFIV+1TbJ/ikNuU+JVdHCVXjdfXwlTkMckyVmTivyt4DMLYlc5tqDvaINxkiXy5f6T
 mVSOZDfZosI6U0qGxbFxfDJHltLd5i84tzgqkY3TMddpBL+UutMLuGoqHevilfCAmOo7W+cOn
 oEKBtOt4JhCm+qemzSYwZpv7OTIqA7pXszs45Yc7CLRbPIIemz9UjF8ADVzAld2uSRqlR3fkH
 WK/QGGoQqLjLa15UGJHRnM9LyzdMan4OlPkkhpF33CyK44I+TK1lsGdv10QuwoCtQytMbMlIb
 tiMEJPLP4fabqD7XxxcGp9GR+wi/JqRpSu6HWw7nlfH36rz2wvbil0cdEcgCDOuJLj5CV3ua+
 AUuwgHT9ZGkcqPOX1qvAlhd4jLEMt3ZmcaJaNxe1ckJQ+ot8svSuLzJW3dOHc9AUHMuzKj9sn
 wJc2cliI6q7xR9P1XmntQsLHcamW8vth6uBul8pzkGKwf40dUZ8lMmpSjVh4p+WqMuerCSJ8r
 fEe1Q+G8UNihcBH886Ab1lNJWLyuwI3YhPW+QACXNpf0ieZeq1Sm+3g6Sy+76JZiJQwtz2/Db
 xsksuDCBqMD2T2MsNp5cYSBkpY9xbk/41WUayg3qAVZPx8WOJ/XjgDRtY2+lgET5lXy7GdI9o
 lC7jPvsWXin84YfzBT172xIgFOd9wwqT+FviqaBSKLdpiOxvpHkjUxCzYcDt8Pe9KlAETez05
 QjZmVC9DGvZZYkPD/lyucXJjh9jyENhhKxseSq9AGa3/6DU9BgLKU8GehyNPglfYuXW0JM4WQ
 I2YPhpTz/0hkQC0oUf523HFBuPFParN2APGSZCrZajWy31s71egS9nTcnS5Muv/ryZatjmDHW
 RF4jEi55i+V5WAtdcFDLuvaXgyDMGbDmp9M3Z8quVrqNEkGMzalA9jk8hptRfPJBzhCHXy8kA
 eHYftkgX6SfjgmH9UZjqajGCVDyGZhnuoHo5UB/RM8kyIT+KDK+As2mwbNwHdPodKAhcOW9lR
 BT03nMqJq9GXxTYBFheO7XDOz1tLTo+mDqu1G47JTt2QrNR6YwRnKPUNo6Mo0jl4xRpHldGI0
 MjfiBBJFb80YoakAI3jg2rPXeyUuTFgN+OpJwAv0/Z9/XXRGrziHWjRyjZIS4Ue6O4pGxKyB6
 2ShoIc7CSBoJtARh49FLewq85w8NxPh6cFsnbBM5qyEa+0=

For kernels where btf is not mandatory
we don't need to log btf loading errors
if a log buf is not provided and the
log_level is 0. This is unneeded noise.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 tools/lib/bpf/btf.c             | 11 ++++++-----
 tools/lib/bpf/libbpf.c          |  3 ++-
 tools/lib/bpf/libbpf_internal.h |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index eea99c766a20..64af279c36d9 100644
=2D-- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1379,7 +1379,7 @@ static void *btf_get_raw_data(const struct btf *btf,=
 __u32 *size, bool swap_endi

 int btf_load_into_kernel(struct btf *btf,
 			 char *log_buf, size_t log_sz, __u32 log_level,
-			 int token_fd)
+			 int token_fd, bool btf_mandatory)
 {
 	LIBBPF_OPTS(bpf_btf_load_opts, opts);
 	__u32 buf_sz =3D 0, raw_size;
@@ -1436,7 +1436,7 @@ int btf_load_into_kernel(struct btf *btf,
 	btf->fd =3D bpf_btf_load(raw_data, raw_size, &opts);
 	if (btf->fd < 0) {
 		/* time to turn on verbose mode and try again */
-		if (log_level =3D=3D 0) {
+		if (log_level =3D=3D 0 && btf_mandatory) {
 			log_level =3D 1;
 			goto retry_load;
 		}
@@ -1447,10 +1447,11 @@ int btf_load_into_kernel(struct btf *btf,
 			goto retry_load;

 		err =3D -errno;
-		pr_warn("BTF loading error: %s\n", errstr(err));
 		/* don't print out contents of custom log_buf */
-		if (!log_buf && buf[0])
+		if (!log_buf && buf[0]) {
+			pr_warn("BTF loading error: %s\n", errstr(err));
 			pr_warn("-- BEGIN BTF LOAD LOG ---\n%s\n-- END BTF LOAD LOG --\n", buf=
);
+		}
 	}

 done:
@@ -1460,7 +1461,7 @@ int btf_load_into_kernel(struct btf *btf,

 int btf__load_into_kernel(struct btf *btf)
 {
-	return btf_load_into_kernel(btf, NULL, 0, 0, 0);
+	return btf_load_into_kernel(btf, NULL, 0, 0, 0, true);
 }

 int btf__fd(const struct btf *btf)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8e32286854ef..2cb3f067a12e 100644
=2D-- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3604,9 +3604,10 @@ static int bpf_object__sanitize_and_load_btf(struct=
 bpf_object *obj)
 		 */
 		btf__set_fd(kern_btf, 0);
 	} else {
+		btf_mandatory =3D kernel_needs_btf(obj);
 		/* currently BPF_BTF_LOAD only supports log_level 1 */
 		err =3D btf_load_into_kernel(kern_btf, obj->log_buf, obj->log_size,
-					   obj->log_level ? 1 : 0, obj->token_fd);
+					   obj->log_level ? 1 : 0, obj->token_fd, btf_mandatory);
 	}
 	if (sanitize) {
 		if (!err) {
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_intern=
al.h
index de498e2dd6b0..f1de2ba462c3 100644
=2D-- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -408,7 +408,7 @@ int libbpf__load_raw_btf(const char *raw_types, size_t=
 types_len,
 			 int token_fd);
 int btf_load_into_kernel(struct btf *btf,
 			 char *log_buf, size_t log_sz, __u32 log_level,
-			 int token_fd);
+			 int token_fd, bool btf_mandatory);

 struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
 void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
=2D-
2.43.5


