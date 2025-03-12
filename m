Return-Path: <bpf+bounces-53872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454A9A5D3D5
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 02:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29BCB17A038
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 01:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E1186358;
	Wed, 12 Mar 2025 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="R6j115r1"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C344213C914
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741741501; cv=none; b=bDj2ef+5Qa8y6HNuARIT25pB5MTkIB7c07jKan7X9+D5hu1DgdCdKRIV+WX78eYXAA7HE+XGnh7RqE/0cMplukAcKBDQepugxaOjqmy+CsPNq6cDsBL+0bdZgpt9RXzUYh6WdQ5yzgMdwS73aF6LSZpITrPhhDKQbcrSl9Bxr5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741741501; c=relaxed/simple;
	bh=zLmS7OguD9RXBS9H3AupHq9ltsQBhDEQxcbPowzkhYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEhW4n/dmKZFVTLpJWbM0tvE3zXhltImULNccatDU/F85cZEH7odGyjowwLafdUOhC6HI5qIzQZKYrVZC+DnjePBjaVhrpo0igQX7rl1zwH1PR1efyOb1wrQxLpV5lJx9iaoJnnBHsCEk/+R0w3UCeNU7BkJ77QqqwPRrGRX8hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=R6j115r1; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1741741443; x=1742346243; i=linux@jordanrome.com;
	bh=nLSKkK9VOyBHdQD7GM8j4kFUdMlT3QFVlJjS+0crkGk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=R6j115r1tC1SOijw28lyx5A6qk0SxZxdUvAVNH+ECUYsPwGgfbo+AkZ6tpDldg+z
	 vXfphfEPniVdGulvHO62nxUUsZc4HMkj7KX0bg/odIDv8ipI4zA48YEfbyFUixD1u
	 OEHB4smWQo53Ppc0zM0ZapTIWv76BQA+MMU/PCaEsTdcIoFGRxkvIlSAdCbFUOIil
	 B/nCE3hiQ9/QF8bX0mqbaoOLhwkSl3wYgRWWRqvdtmC8DHg1dC3HEC49IIXOE5MyP
	 BUloaxcG7bxEYMGvdoPUREojOlNcuwDp/prQYU+zEDr7EzBtZ9TdnAKQDgBJ05+ei
	 Re/p626mqWzr4AVdKg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.12]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LnPvE-1tIFsC3MYY-00nlt3; Wed, 12 Mar
 2025 02:04:02 +0100
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: [bpf-next v4] bpf: adjust btf load error logging
Date: Tue, 11 Mar 2025 18:03:58 -0700
Message-ID: <20250312010358.3468811-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:no8HlsA2uzDeZ0DnL/2ZGykZrtP5iTSc1th66ktd4/cEmvMZXde
 EsgfUtjgyMuE1ZcIEt1lrftyyz8AySF2OcgVoYxdAbV+9lbDbsGFdC6JVr8MQtFOWr6oPjO
 uM3b5O/p+x9HtXRUlIoHxNRwHfbhaAMFNwpBz8TEWgMKH854GX/e/7D8fAH9M4bQF541jhi
 lMuJTCR9/19v6dtHdorfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H5HFIPlv7Rg=;zb96NgFJSKfiA2Y5+37I3dVZozD
 QgwJPOyqVT6sJ3vRigNPgk7WP1CeV9iZ77jw0C1Xzp0ZiTfO5x8fvjCjSNRFUabLQ7EvnZ+SF
 RCza2ti1OcAOLxxilwJpyf4Zkqa3INa3n+QFnWNm5UA8jKjKpMY1JynWySaFQ8SoO2AyhTLxj
 90VmQuOHoPAd892UDc5w00Uggpa5VpN6BRgLx1AiqGlZmVFHoPLFkeXdcEij37YrJJgfNP10y
 yL7aQrSwZ/66WViPblaQM+KBQ/1NdIO53CGgjeXVHZ4GLWG1cmIIHFcZDQgbHxYOfgZwXG+G3
 tBYCj0ztQgpQpoMtL6rfjMf/uKeP8gf3M4mM1E3Phxq3S18iLvi3sVDQG5UnG/MM8o4DZwNso
 vvC0w66D/RE0rlxGSZj5EfNq9AcwXmBPNvODhyebxB2thWfi4wEN50neSc5vAbnkgnq8GR4MY
 bcSsz1uOu8TpXXrmlbtGgJthpeb7V+MLIIRHPK2ZU6n3y20dtrEji1gjtv3/FB1LlfLYnPSn1
 RTPmTjKoUptbb5hkKvp11dgrAfzZEvFTwk5rg47SOVDqyb4IOafquidSuFxBHfd2Mjsg3koUB
 JCiDPvuIFuUj55/5Hco3A+X8IvKBUMr0Zsm9TYxsXzj4dl2DBHSva7QLmBuxqbEWB+6MClX6W
 tIkbqdBV/BcWoJ69Or2ksADEkYstAIsQ456nbC5ZIgt7drjME7t2vUZqTrZtOqZVkFJ5iLrBM
 ZIGWJRc6+PAkICt+lsabGyXziZEwFbrQ20wbBWuXPUECrZRTSxPd1GSLVfMXZfQmM3TLDzKDh
 v7UA2fAKTdCipbJZaVx/xQ2cWr49evahbZhGxVKWBk95z9lT9ZjPao+600h2iIDoZvhkGX7ZP
 GzEBf2F2m0ukyW+ZgnTPEMYbsOrWNeodm8GwLt+ZcHL5gxQ2YZZNQTps2GakIQAd8gIp0q++u
 9oHDMM8Sd6DgHyomyNgsS+CJ5LAi/8b1GqkW8cB6XITThpyzv1LlMw/yBh/jdVzt9uYMombSg
 TB/jHGb+gPFfQJMYBeMHoYOi3k/ujMSHY1WdkiPnNABVMFE0l6NK9ERFitjwBCFaGK1tEaroH
 yRmwKo6NkmHVIwuLvXWiMtIumc0P9NBWNiKUkcgzyn6xvtCXl0quOTC5lTt0gprxfBVFVGRrT
 nqOMGh20INBCLljfXDpVuAPnWP4miyWOx7SUZFGP1+g2LxWeJrzdemmgnV6Jj5vheZRYoMht4
 iFGVgdGwa0KrKgltk9b137ExmPGQM1uKW3bwoG9FodkUEMCUGcQvLJFgDXc/zYp6ToHltqHoW
 uqAeEuxQuZEfge9Cn1b7Jj/kzrAMBJjRFfAVsoz2uPAxmzIBF/Otxbhyg6Wm4mJVMZ0

For kernels where btf is not mandatory
we should log loading errors with `pr_info`
and not retry where we increase the log level
as this is just added noise.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 tools/lib/bpf/btf.c             | 36 ++++++++++++++++++---------------
 tools/lib/bpf/libbpf.c          |  3 ++-
 tools/lib/bpf/libbpf_internal.h |  2 +-
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index eea99c766a20..7da4807451bb 100644
=2D-- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1379,9 +1379,10 @@ static void *btf_get_raw_data(const struct btf *btf=
, __u32 *size, bool swap_endi

 int btf_load_into_kernel(struct btf *btf,
 			 char *log_buf, size_t log_sz, __u32 log_level,
-			 int token_fd)
+			 int token_fd, bool btf_mandatory)
 {
 	LIBBPF_OPTS(bpf_btf_load_opts, opts);
+	enum libbpf_print_level print_level;
 	__u32 buf_sz =3D 0, raw_size;
 	char *buf =3D NULL, *tmp;
 	void *raw_data;
@@ -1435,22 +1436,25 @@ int btf_load_into_kernel(struct btf *btf,

 	btf->fd =3D bpf_btf_load(raw_data, raw_size, &opts);
 	if (btf->fd < 0) {
-		/* time to turn on verbose mode and try again */
-		if (log_level =3D=3D 0) {
-			log_level =3D 1;
-			goto retry_load;
+		if (btf_mandatory) {
+			/* time to turn on verbose mode and try again */
+			if (log_level =3D=3D 0) {
+				log_level =3D 1;
+				goto retry_load;
+			}
+			/* only retry if caller didn't provide custom log_buf, but
+			 * make sure we can never overflow buf_sz
+			 */
+			if (!log_buf && errno =3D=3D ENOSPC && buf_sz <=3D UINT_MAX / 2)
+				goto retry_load;
 		}
-		/* only retry if caller didn't provide custom log_buf, but
-		 * make sure we can never overflow buf_sz
-		 */
-		if (!log_buf && errno =3D=3D ENOSPC && buf_sz <=3D UINT_MAX / 2)
-			goto retry_load;
-
 		err =3D -errno;
-		pr_warn("BTF loading error: %s\n", errstr(err));
-		/* don't print out contents of custom log_buf */
-		if (!log_buf && buf[0])
-			pr_warn("-- BEGIN BTF LOAD LOG ---\n%s\n-- END BTF LOAD LOG --\n", buf=
);
+		print_level =3D btf_mandatory ? LIBBPF_WARN : LIBBPF_INFO;
+		__pr(print_level, "BTF loading error: %s\n", errstr(err));
+		if (!log_buf && log_level)
+			__pr(print_level,
+			     "-- BEGIN BTF LOAD LOG ---\n%s\n-- END BTF LOAD LOG --\n",
+			     buf);
 	}

 done:
@@ -1460,7 +1464,7 @@ int btf_load_into_kernel(struct btf *btf,

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
2.47.1


