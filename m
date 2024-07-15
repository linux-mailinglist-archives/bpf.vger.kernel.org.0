Return-Path: <bpf+bounces-34803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7E793110D
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 11:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E121C21332
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 09:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9CE186E26;
	Mon, 15 Jul 2024 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="skcF89Tc"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD5185E5B;
	Mon, 15 Jul 2024 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035252; cv=none; b=HqU6MUqntlajq1J8XjWWDbxEYymLqeSbuo64Rx1OlzctYXOt0z2NSrgscqCe6SuFbvPnuf2HPDbtZuzsmJNkC3Tm0+Yq7Mul/tRhOLirTQG70llC9N0IDVu+X42tkiq3GEqitivYFAyM9lw3i1s63JSzwRCnX0So+Ktu0ApkFqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035252; c=relaxed/simple;
	bh=eTRBEPkS2r87hNj5UkLCu1loixz5oChnDT5vx9ZswWw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=olLPKsGNQXr/meYGthLf/pT3nL9Iq4MqrLeu5XVbIzsNy4AEIHcq+0Pr0P5VkKX/ebi7NQj/OMwxqD7Xw6LOIU1kRUg5bKTlGlfP3ZdXXOd5Si0lodUFE9DiWiltet0BFAZzpxkjhwuYEm0lrswj/EiYI1Nq0qWS59clPv25hfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=skcF89Tc; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721035229; x=1721640029; i=markus.elfring@web.de;
	bh=h5J4xnTRRczNmA4SY9gfKeB3SBi2lBm0xtml3mDw2LU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=skcF89TcJn6FKgVZEzX+cCIs7of3bzdp4RQpo/UUt3+bEwFVx7x1o7G5ZbW/PCqp
	 0ZbD7zPYCKvwZKj+7INxy86WumWnrvDIQUDrr77APVOxwV2CPfyfxsCu7CEoTGZmP
	 Pg//dlCry5CWYCcwsbPCbgHJVt3G1qokcA83z5QeM5EwK7v4XV3keApPNOi79sYWu
	 DKiO4149pDmyjphYEEVOoGkCQabA+anBd7VPKwZtPhIG2HEV3Z/+5WdZ653vGoH3r
	 TcuSfR89XxASQrB0BDzuNDRskt3BxrX8p2ROtqSCcx1x5B1ng+h1+PLGZi/oIf68I
	 SKc7UTpnnN/gXBA9hg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc4q-1rrlCO3Yk4-00hHPN; Mon, 15
 Jul 2024 11:20:28 +0200
Message-ID: <abde0992-3d71-44d2-ab27-75b382933a22@web.de>
Date: Mon, 15 Jul 2024 11:20:27 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: bpf@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] bpf: Simplify character output in seq_print_delegate_opts()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3cIevsQjGB9LkZ4UtKg/WHmhtrHXPpk3H78A16xjMuEDTnWYs1G
 oo+o1TLOx0EZ04WW/RxbiXTKvakzKH5I9TPu++LyibC380zAt84j6UeTwDz6uqQI2Aq5vV3
 Pit47qm8vn/RISSejp2KPWpLdAebLoF/LDFfGOl2n0hK9IlJcc7U1XSFewIzsAqJ/jkeAWx
 GCTEgjgG1CcJDKjS7LqEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:41ZoitEmC68=;dx0jI6QkWrMTUcENTtTJbIVoQLP
 v9KSdawl8hNi9dUfWAkrQdy1Q14j+STscKcjvxstw4orPVMstRYPX/H5TGmwJrvmSkWiAFWES
 t/eifFVwvOMeR1BL9D30EcvlC1OGJ2GYFtTKSqFAAkz9q37K0PxiRtgPxs1etRVkD/BwRByPn
 Wwba5whkBsONZN7VXJNVZi5ImvSedLdsJO5qlsiCkR8JhpYgZb0LSgsCgfekOSnfDBAoC7elN
 s/pro39uLvY97MwW8AmR2IVoGaef4ypIHxDUU9gaCWWmalLZf0mjUOAHiYk5+m6ru6X7PCE33
 K8Fc4SZZiUitxeEFWQIkdcKvQ1KJaA2eDPrBM/IiKZrTK834wWzWsNXjOHN2X25NXSfVpWjhX
 7BxIKqMBz6TJdlWKoV3L3uFybuhl7c6gPRnGVVxwKSXWcdX6c/sK8cZwSXJpgiE+8pMjkXMTx
 0Zx0GzT9LA9cdbFDOfqEYTA2+Y75Upl5fORmkMtDr9CamlNencZJUXuuZFvDXttpZwiWIHiPg
 e4uie2ZxSfWCoCYa1wrEtjMDGKeBBndOiEKz3lYQTQ/TGMC/iOksG9PA92G+p/miRGkq8ey5d
 NsdVXm8vtboIuaf9cpMrFynclP/eESSKKQVMmLpZdNm4ZZ7LhhK/Fx9G/TQp9KZb1PyUURWBV
 xVn3u8Y6CowoVgcNUVX4H8WACiDhyg7Mx7slRwgK0xerEzBSrlcjiM3RCix7Kp0vHvDuzEs2t
 t6SBDeUDRJ/QcjmB8J/jxrTxLVJfwvzEeCujG02X3fW42a313Rzxe1+7OkpEkUxAEB9zlCzke
 VDSLQLbXzdxKHdOLy+A0CvgQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 15 Jul 2024 11:12:30 +0200

Single characters should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D for two sel=
ected calls.

This issue was transformed by using the Coccinelle software.

Suggested-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/bpf/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index af5d2ffadd70..d8fc5eba529d 100644
=2D-- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -709,10 +709,10 @@ static void seq_print_delegate_opts(struct seq_file =
*m,
 			msk =3D 1ULL << e->val;
 			if (delegate_msk & msk) {
 				/* emit lower-case name without prefix */
-				seq_printf(m, "%c", first ? '=3D' : ':');
+				seq_putc(m, first ? '=3D' : ':');
 				name +=3D pfx_len;
 				while (*name) {
-					seq_printf(m, "%c", tolower(*name));
+					seq_putc(m, tolower(*name));
 					name++;
 				}

=2D-
2.45.2


