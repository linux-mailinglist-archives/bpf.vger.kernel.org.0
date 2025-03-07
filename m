Return-Path: <bpf+bounces-53582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0783A56B03
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 16:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5A53AB2C3
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D531189B94;
	Fri,  7 Mar 2025 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="HMdMZYi3"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FD42E3361
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359657; cv=none; b=N4/K8Ob/bnQkS3tI+ZjD7U8p7br6eqqMNChXkMpMcOnYfYGlZQsnC24o7/lzztEk0Wa1AFgnzqSAMFBvYkl9r2brSpN5WdaM5EsUYWPeYnp2e3Hlfl0U3nJ81UC31EBkP7OZXAEHVYUbm04dW5fMT4aOVJoOnkCoZLlVuqrLLqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359657; c=relaxed/simple;
	bh=uDQO3fQsAuGPKCfS8NWyHcVhK0YIOtz2VT6gyjOJ/1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ax024cL8pF4IjKB1r87Pm6E+4HbljJwXUvpbDkYT7pvmH2q6xlM65IdiKb7NDNcfI5a4Z/g/Wm197DE9zYhafV0a3nWCdGDJE9VznwinW6o6BRqW5l3tPO6LeKzZNel0ncECxjw6ayLt6FsjAYNPXITRe7FvAJw4te9G5h/w6f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=HMdMZYi3; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1741359627; x=1741964427; i=linux@jordanrome.com;
	bh=Nl6k/aLK8bTJiEmSB8t02UDqYtST5P7nFa6wa0qTP+E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HMdMZYi3ZU03SlOeTmtZ0rxyA9Vpk9WMwTPsbgT3++47aUvF7m+v33lMz6OuSXHk
	 XlSZsHIXpcCXPDbISitheA6sZIQgtsmgniVLK/2xuYHIpEm2Fq02w06n+LqGN8Jbf
	 ALa3Q3rT86H9arfr0t2J05Wgk3Kw9dsMComRtlrwuDPoCK03rgHkrAcld/XejRmK6
	 6voCtUzKriNp7812D1a0mDY2tClkrZM+sUHmMrI2mfYV2eGaKFcx3IjnqE8fWsSzy
	 6JMRqt2x8Lg1FDCjWZVzRvqQ5WlSHiySQ5N8vyoymT634pgXyYhmTYVV6NKoRptGb
	 niYPPNUtI1BMhOjdzw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.2]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MgfCq-1tKosA3nWm-00b4ky; Fri, 07 Mar
 2025 16:00:27 +0100
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: [bpf-next v3] bpf: adjust btf load error logging
Date: Fri,  7 Mar 2025 07:00:16 -0800
Message-ID: <20250307150016.2172675-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5LEo8N96GRk+fakROy+rbwExbL6UUFi6+6UGIlgPJGCOzc08CiV
 F68SZblb8y00hKwUzKa8GlsDS6knIkUZW6yeZuIbFRB3Qw5OmhwD77NMpIhWR4h3EJ8yfjK
 fwwpPfstO3Yn9ZSU8EeVFhG/KTE5W36HCIFw7Eq2XeZd9OZlhax+9L8MxC7ElJXiBnJfFXq
 rtUotZM3IhkNnsz3rwHlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qFnP9+cb0oo=;zSW5F+7OTEHuEpaTNotJZA7MFwf
 ltTRCllUeLwMcqQUdyDzbUQJUECZF6meZeiCCBmEfOMlT3pOdwOOOyghllc5tTKlOIuMVnmx5
 WTgoMuSqeHZupdZVtQvJ6YLvMqcoy5o0NSoEH/dsWNYv9mnJkedRmu4r8lAmk+yc0o1xdPRLl
 9TNoJyHxXGSaRqH5gfGM2J5a9+hf/diMvhB/Ikf03e5317Cx0H3o3q6dp8OyfTB1srBrob6df
 Jy7BAiqS8YmZwLpWfGR57tVDOpzuGvQjlo/pyB203zAvAtQMju6TWcnjCiu6FA61pTstG68TT
 RUF0OkXG5ndyBbPE4fu3QlsdcY0ybd8V5+K0j7l+5AvYW4ycEvOQD/5S/izWfH5MoaHseth06
 gMRRN8bmbkFs+k/gyuzR8UHQ+kMFZ+111jiB6fTMtlebRVFDJsYpdStobaW12Gx0eA5UDSJoA
 zTpMPlcS+HWKQx3EDpeqzsLdiXaS1JgBmMXu0Tv0i2LTw90hLSVFkDNY1ssr8uMJGR21F9k4C
 jRkspDWwdhl+4Nplgq5bKbbCphbOvWiotLwl58g/udDOq37mgCD8GyDbBRma0qQCVVyivW29m
 kGV3OfoeiHTssMboCeH+hRIgC4/UQ5pgsiyFHMtCXh0iunVAm+bTXV6O7deyQrto8Fx+9QwZM
 IQceBRLYXOwr1n95Ob0c/Ycw3yjg3XiBuCvhKXg6Zkof/VYLwIYOJhNs9maYcVQ31a9E7FzHq
 FQ8NnvU+rDCR+jO1OyeHWN4dlW1RWSFAFVYW5AhWAaE8o2zT0uDPnGE/TEHxQy/xK+zWkyPrL
 cUrv04MhsBA8iMclIh/XxyWE5hhQfxTFTv/5gt02UghZ8UQqKOwQL1f5f4XROynknr+Sn8QPK
 B16VTyC2dGZXtbuzchtCSRnsQyY75CcAKFRwZnENVnJvQMPkCrCFcBxXrfIlS/TOkSOXJzQBj
 dlmfLiqcL0lZmKb7JMusCdEL+8i18v5S18qqTSpbAp/5sFdgM/h/gtMCyNpXqhXR8OllbtUCv
 1uBlUyvIvUlN5J1hFcHhfu3X8rof7LG1JPaesp32CZnu6XN9KOWRQ00rNoizEnW5RqNivYoel
 LiwSI2U0mx7PiswyDkavW9wpgBdhpguuw4XEOH9fKFZ0LqPU6zhOS44GN7REjI1A+yE5EsXSF
 TVH9KknbS3Ny+qTkLtkiKaeerkuLd1p0BGA0VDVNhdrDMk3+nODb3/C2mDHVfKOCaS2283enV
 UbfcmxcG234KWGrluf/0S45cULQvf1Bw2mXpkTeohTRmXw2mELAPv8CzI4/Vr0btPh+GuJQQQ
 VubNel2uN19v33TEylrbzSuvtVWX6nm2L0fX14/y97K37dzkyoxy1WNqQBoEKdL7jzr

For kernels where btf is not mandatory
we should log loading errors with `pr_info`
and not retry where we increase the log level
as this is just added noise.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 tools/lib/bpf/btf.c             | 16 ++++++++++++----
 tools/lib/bpf/libbpf.c          |  3 ++-
 tools/lib/bpf/libbpf_internal.h |  2 +-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index eea99c766a20..c8139c3bc9e0 100644
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
@@ -1435,6 +1435,15 @@ int btf_load_into_kernel(struct btf *btf,

 	btf->fd =3D bpf_btf_load(raw_data, raw_size, &opts);
 	if (btf->fd < 0) {
+		if (!btf_mandatory) {
+			err =3D -errno;
+			pr_info("BTF loading error: %s\n", errstr(err));
+
+			if (!log_buf && log_level)
+				pr_info("-- BEGIN BTF LOAD LOG ---\n%s\n-- END BTF LOAD LOG --\n", bu=
f);
+			goto done;
+		}
+
 		/* time to turn on verbose mode and try again */
 		if (log_level =3D=3D 0) {
 			log_level =3D 1;
@@ -1448,8 +1457,7 @@ int btf_load_into_kernel(struct btf *btf,

 		err =3D -errno;
 		pr_warn("BTF loading error: %s\n", errstr(err));
-		/* don't print out contents of custom log_buf */
-		if (!log_buf && buf[0])
+		if (!log_buf && log_level)
 			pr_warn("-- BEGIN BTF LOAD LOG ---\n%s\n-- END BTF LOAD LOG --\n", buf=
);
 	}

@@ -1460,7 +1468,7 @@ int btf_load_into_kernel(struct btf *btf,

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


