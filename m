Return-Path: <bpf+bounces-29688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6C28C4C99
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 09:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4D41C20F25
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 07:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5734010795;
	Tue, 14 May 2024 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="Pfr793ku"
X-Original-To: bpf@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7053F9D4
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715670590; cv=none; b=mIC/4DMgnxx5hiSq8sBYDwhQ0cIL87cbW/t+4ZN124Y9v7as/RzDQ0S0sD0SaZdnorV2NVYsfFjTyK9uB+TicQbnbiFvO0BPf5LmXICpRrLIMGBp+1B4h8Ev8j6UVjY4A/wcto/GDrAVrgi7YIHn6iF9m2HRYlgAH/dW1WmBYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715670590; c=relaxed/simple;
	bh=x3CzbNa5k4QK7Ar+bafrK6JiajAOPY8FNsqwGxKap6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bPI7T01AJhrUO+zxU3MuFypYELfNInjvy0hX7+CJSdjwL1DzOFrnuTRjqGEmF9d3Pe04q/Ev748Z4OvzIc4QV1bOas+rdMOzD94+2R9uX/k9/YdefQI86hEU/dWVZJr/HDRKMX5QpP2o8WGzYjcKfSDbvapvTVJT/YtBI4L4Qmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b=Pfr793ku; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715670582; x=1716275382; i=friedrich.vock@gmx.de;
	bh=0upNUKa53dB2ZQzO1xHBi9iI/C23XKAE8+YH7Oij7u4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Pfr793kuSQz0pDKCq4yGwC09GOrEF18aWhOmGIgKmfU7Ny38NQXuV1v9o8UiNqi2
	 v49B8R/Owqfbq9c3nfe07FhYA8PDVBDD/Lldot18f6B0Rbcpl6ZFrgSzqRi0vQK2+
	 oLRnbo9dOYCp2avwHlqv+ReR9OGrxv56Vr1aTytfB4M2azKvti0v/cKXw1Ag/eyoV
	 IpzrdDO34AB3MUkJ3/lI99gvAwnXvZTPdm/zgR4eIvF9WqSBbyHGRE7+5FJCi8t1y
	 ks8mbQTzualYFPhKHQvuuumvoEnlqpGYgZ7Ceg2Yu6NNjdlzLNzesEQK5pH8NYNjp
	 cBe3TIGIyGhGGochhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from arch.fritz.box ([213.152.117.111]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdefD-1sfq7z285x-00czvI; Tue, 14
 May 2024 09:09:42 +0200
From: Friedrich Vock <friedrich.vock@gmx.de>
To: bpf@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH] bpf: Fix potential integer overflow in resolve_btfids
Date: Tue, 14 May 2024 09:09:31 +0200
Message-ID: <20240514070931.199694-1-friedrich.vock@gmx.de>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H0w8I0zQWEFts+p6rBfzcwckNeRxUbwZXYpZBSvFRchzeBy5Gdb
 KEwThNkXEDhHEquZYJrxf5Q6kZCrXqtS4C4ocF1czignW6zMqGHCrQmgBdl1d03dONtrTe+
 289/c0Yqd9+c7hSwCMesp4yScV2eyS/ROvZSGd8SdKKhDzZrpx/vEpTzHrX4NSsskPZFFQx
 AXA1Luux5EC1g51PJMYfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cb/h93ryQdE=;5AOunb6wPwdZRQHmBvhSGnHCNyy
 NmM/Fp2q4yJckgl6v1Ja9EdPM7pT3WX3AO/XJSk1mFt1ctmor2e7GlGdhiQCdhz6pzDuOXRYP
 kdodjD9ly0D3aww8CSjDx/o+nF6EuKJbpSvCTxWWP7u5pGg4WYNSLPCqoWss/iTYc5LZL94b6
 VJTYF4rddmW0zw1HPK3qCJkFl2HWLO/0cve5NxzM8KBvqaGFWmX7EupwJoLY+mCB0VG0L0aJV
 3C4hpWHOGoz+dCBG7T23xNjnuSriM8WVg/5PLuuNscSVl3rt1iuNEU4wHZTgDvo/dp5deEMZx
 97chEAqFaslJdbwhxEwK4JRJvMfJ7pXRVh0bOqkR41KQ2zt0kcDY/TobP1Ttoj/cTnfJVaKmS
 1luij5yTqEppW2zsJo44LFWYun8pOGNrL22TK8gSvScnvEhUCH5cuVw4JvrElASZh4h8Nikjn
 Iq6H3p4mp20IFigmXwkfm9MRnblDBsAEaZlPkI+GRWECssHMiZTR7EAtTSx48KYEmu0nbw6HH
 Tc+tW6+tm0sHuY2C8Oc4L4L4rtc1V69JJ4JrYDcQNlbWbR/br+GKklQHAbnD9BEuySxdmTS60
 OA8TafjHeyBXJuPjC/C05P8dbfmoiHyD5iCD7EZSM3BCVDBtYZxtwqf/PtVxcmqK9jMEY5fs/
 TWoZJ6AyZtxEtX3i5j/qYFlwj/ZQCr80OvkF2rsZvpPxfn6I7VPOLV/dBqonVAhd1pyyjM5ru
 qFJYNbWvyddQErJ1vOnvWp/EHuSYJq2jy+fQ7PiKVaNFAxDRZnM/FNK1bsY4xxpBdfK6C37ac
 wgAFjONvz+8QGPpEBRXpPvTij/46gjGwtz9lJf69ZYBSE=

err is a 32-bit integer, but elf_update returns an off_t, which is
64-bit at least on 64-bit platforms. If symbols_patch is called on a
binary between 2-4GB in size, the result will be negative when cast to
a 32-bit integer, which the code assumes means an error occurred. This
can wrongly trigger build failures when building very large kernel
images.

Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>

Fixes: fbbb68de80a4 ("bpf: Add resolve_btfids tool to resolve BTF IDs in E=
LF object")
Cc: Jiri Olsa <jolsa@kernel.org>
=2D--
 tools/bpf/resolve_btfids/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/ma=
in.c
index d9520cb826b31..af393c7dee1f1 100644
=2D-- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -728,7 +728,7 @@ static int sets_patch(struct object *obj)

 static int symbols_patch(struct object *obj)
 {
-	int err;
+	off_t err;

 	if (__symbols_patch(obj, &obj->structs)  ||
 	    __symbols_patch(obj, &obj->unions)   ||
=2D-
2.45.0


