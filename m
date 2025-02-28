Return-Path: <bpf+bounces-52887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90033A4A160
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC961890131
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 18:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F6D27602F;
	Fri, 28 Feb 2025 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=michaelestner@web.de header.b="L3dReFgQ"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A63E2755E3;
	Fri, 28 Feb 2025 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767072; cv=none; b=gwtTOTeO1TUQWLf9uLsJVjyMrhDuGItGvWTlcU9vIAN/qt7j/QliITHuqegU2d+lwzE28nv5zQHHau8Vlf0FF7s1af2jOIqLl81S5tMQr9Y6Y3PCHv0/45pUQgOC4UToTc121LAnzI1jB0zWm7HeCa30FmvoV0hXZz6kZoxzybQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767072; c=relaxed/simple;
	bh=ulEoNTWX2ai/i1e+m4dRcAUEVFZP1m1dYHYLPjm/u9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VQd2zzwVt/EJlGHd22M6/MLQyu5SU0ch6uVY4Ta25XZBl0FIjocjY589UtQ0Hkbgvhhk6pktNLMW3MV8PNf/L9jwSLaVnjxYDPhEbIW6bs3bpEmvBK+CJcrzoRQtXjxq59G3+4K/w1bdjTnCCVpH6qMxbyhFXq1Y1vpIn9qMCrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=michaelestner@web.de header.b=L3dReFgQ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740767064; x=1741371864; i=michaelestner@web.de;
	bh=Hm2gsSINyxASyXm+O82PUycRhtyQCwm+OL7u80TaOZI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L3dReFgQIiuBskn8vKITtOJKhi9FsY/9XfNr0xxfgYdPEmFYWVZAKirXxWgB4YyE
	 BF42hFcgNe1Qxxq4XRJOjkhipvE2uN0P76OXAbn2+gOZ1JKykQw1E20eobYYGUIdn
	 9WqcaYBYg8mnIKSQqGnNPv2sYWMGMTbcom/9U4w3tggCp0uTMgcSh4gX9y/Q96HjV
	 eMyHi3blIKJ5Mo8ppyfAWo8D3cyRdPozx1b0CC/C+EaG1m6BUHT5xX2DgfLI8entm
	 XIvTYH9rpWlCKVYWjGwRn/fF+Dk2lSF/3Fc/NOiYzBxNDY7mXKUZjUVShy3zVioNO
	 V8ZhfnNxHGY+VTRO+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from del01453.ebgroup.elektrobit.com ([87.150.19.59]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1Mty5w-1t0Mbh3nCu-00zaaT; Fri, 28 Feb 2025 19:18:45 +0100
From: Michael Estner <michaelestner@web.de>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Michael Estner <michaelestner@web.de>
Subject: [PATCH] bpftool: Replace strncpy with strscpy
Date: Fri, 28 Feb 2025 19:18:27 +0100
Message-Id: <20250228181827.90436-1-michaelestner@web.de>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dTJ1bEHopl8bQxzT6+oHnNYmgNuyVP6QWCwbZ70KhlIHpIGhism
 t6XRtAPQPR9OgLHxesMCbqnjAu2gXKzbHQa2ud4f2HYxW5zp/e7SMQXG/u39h8upXtE781K
 Xz6RVrVFl4GT88mKMQ5V6Dn/i8U8+erchfHaUmPXzIyzlmvkfRYMkoPE3eX5by/SU/9+bBV
 T+8tj66PSMBszC+4NsXnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ErGF/CS68pI=;ttSUjnhCdosvNWlTyoPbi2gETk/
 acYvPgpENAlDADA5d7IhgBma9c+wc8LY0ZX+dng/Cvox9rYurQPGolUtLviVU2fJLfOBX1WdB
 Sa21/o3v7EeDK5vuoWDiRRtcwTzvYw2Jw4JDJZEBz07MXnG2ymNDm4IF4pNyxguS8U57G1AAZ
 O4x1ZmMveqQe8zKBIqGhZjIFZqgqqwH7cVxsXg8Ll+nv+QMp+yfZLEXj5XI6DO0fJgAuwSPN5
 7ZRdvGGgUV4FRPLajP6oXYj+2GKWA8gfffUd3gLkoSG9Bueg7I2WgTNxc3VAqpa6wg4/Hy/cj
 +j8YVX3QDRriBOGgeNXEFKI/RHKKoAbZutMwfXUwkDMoV4LPQ1lg4Ibagt7gmZgHiAZnvtoAn
 PGzNeSz8rjjQuWnTAJRsc+R0FidoDRXL32sS1Ls3yQ5dSihHvmgQhtRgKeZNJWRHlTc3oUMzr
 8COA3fjrwoOv+s7NkrL8dG7ifDpaT2NmIH8dO/EMN4EvGFuUiCLPvZlrhhtzgTnpnQS2lM66U
 ad5Ju/ZHdjCmdGca3w9Bgx9GDPaTA0QSc4YEnEF8nnRsQdNEsXhR7b50ZffoTjqok+lv0oRvo
 4s5Sv69kyKMDEnCcGs4/SMM4m9rLGxKzIck2S3HmWDQ+NvFfTz/NkRXEKVrESrP+8jDb9bdoP
 pp2XadOtw1hCLzUbhxCjDvg2Vhw85NSlCqYkv3Q+t2kcVWcXaa8FCK0RHYLnzF6KgQSgQra46
 39nVwzKEhOz0CH49wHih9yGo0fBXydWtKmajY3Z5znSd3P7nKgyZ8oi4EiNe96L9gWYiPD7sI
 w0/BehX8roluPcVtH2g5EBNLUpI/bO6DdwycdDbdmNAo+T4M59IowTHRDjE/r2+UBZYtOydJS
 4yqHdUjPpNNZZE34LLwxGUMXjbwCXT3KFdp0E1ehNt/nhVdTNgjx8Yv2GJJzKfWLV+fv8+4nM
 KkmulHCATdut8lr/LBq9vSn5Gx+9XspIm7ruRYHpn0cAdoa7wCwn/gB9xQXON0GZbdu2UN3Qt
 N40UB+rRK6IpRJ9/STTM5spJcj6UmOkiJZSjKa76NQWCnPkiapvsToqSeFJaDT97hoCi0oZJh
 ynvk7/wQB5yOWJRNks23LGNSL/bi49SJ5MMI41cL4wFAYlvgL5smcBnhrXKhpoirGNADIQ4/Z
 PVbMpwpNBM/q+u77zKwNgczFoFfblI1RuDHfx4QTMoo5BokIeomf827f/7VWu3n7HuG0P7sFl
 5vgNyoRfynJGXMA8Ci56E9DI1hDkbgTmV89ud3wfXKWWP4ppIZWDa9ktAaLKrmXWJOVrvgHH+
 rRLI2Oi/RISc4+bnJe8X9q7fC+mnKjdWAKHMR5zBfkW59QWpraRPXoZbcC3gezqROHvtfr/rM
 3ew7DY7ggjsfwD/lYiMDVmzUHdLgTamk/rztfaBg98e4IJDlGYT9qg9UgolZqzGqDGw/bjnrx
 tiN3aloIS/vKIPCla5wD8Am40GHg=

strncpy() is deprecated for NUL-terminated destination buffers. Use
strscpy() instead and remove the manual NUL-termination.

Compile-tested only.

Link: https://github.com/KSPP/linux/issues/90

Signed-off-by: Michael Estner <michaelestner@web.de>
=2D--
 tools/bpf/bpftool/xlated_dumper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_=
dumper.c
index d0094345fb2b..60dbe48a91a3 100644
=2D-- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -135,8 +135,7 @@ print_insn_json(void *private_data, const char *fmt, .=
..)

 	va_start(args, fmt);
 	if (l > 0) {
-		strncpy(chomped_fmt, fmt, l - 1);
-		chomped_fmt[l - 1] =3D '\0';
+		strscpy(chomped_fmt, fmt);
 	}
 	jsonw_vprintf_enquote(json_wtr, chomped_fmt, args);
 	va_end(args);
=2D-
2.25.1


