Return-Path: <bpf+bounces-32019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA5390619D
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 04:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC3DB22748
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 02:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4792A2A1DC;
	Thu, 13 Jun 2024 02:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="skUdpxQn"
X-Original-To: bpf@vger.kernel.org
Received: from hb.d.sender-sib.com (hb.d.sender-sib.com [77.32.148.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BBB17C72
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718244533; cv=none; b=DjUWKoFMoZ5p5m3HQzulF1MWUUSl7p4zIkUC0crogwEtAyWpPFo0BHsuQybCA/tp5hckshoYNsPJZileZhXTbGTUB02lQxk1kHEhkcUgTG5WZS3TjBfZHfIo7uSX3v3ggSR2oV7B55QDJCl+j43YJX4MStys8OTbSDCnYv2Imho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718244533; c=relaxed/simple;
	bh=sZxd/lr33FvS0G0PuEB6LuG1Xcz3G2EiXoxxSj04Ywk=;
	h=Date:Subject:Cc:In-Reply-To:References:Mime-Version:Message-Id:To:
	 From; b=XlOxmaD8LGtHkSbLD1Z6ghN+CRcgNVCkc7wW16ZT/bw9784rDwdVnI65E6gQhNv18J5PYybOZPIkonbQwKz6KCp5wm8wzMDeH1XGgN61ubHITvp8+k4XJb6WugaiszknNzCJiyZ1B5zTish4Sq9PqADerBxhGUr67h9pZHsYNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=hb.d.sender-sib.com; dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=skUdpxQn; arc=none smtp.client-ip=77.32.148.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hb.d.sender-sib.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rcpassos.me;
 q=dns/txt; s=mail; bh=SBjGjI4O6beCAtZ6uctM2JVyHFqO6oB+EbE/vImerjE=;
 h=from:reply-to:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=skUdpxQn34P6oeza5aVwJ6CWpdjw98GTJ9lpB6muydmli56Q0nVu/lSo8WINga8WPINzGqSYQsIh
        DoE6MpHyMH4m24g9FM00WuVPNDrVBhnNoTTRUtZLAbwfPnn3AefLDLsqE9E54/qR5VDegQmscgLy
        JQ4078uDZlV+IUnl+io=
Received: by smtp-relay.sendinblue.com with ESMTP id b48e798a-e937-4416-9757-92b7b2d492ef; Thu, 13 June 2024 02:07:43 +0000 (UTC)
X-Mailin-EID: MjM2NzcxMDk4fmJwZkB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwNjEzMDIwNzI5LjQzOTUzLTQtcmFmYWVsQHJjcGFzc29zLm1lPn5oYi5kLnNlbmRlci1zaWIuY29t
Date: Wed, 12 Jun 2024 23:03:14 -0300
Subject: [PATCH bpf-next 3/3] bpf: remove redeclaration of new_n in bpf_verifier_vlog
Cc: "Rafael Passos" <rafael@rcpassos.me>, bpf@vger.kernel.org
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613020729.43953-1-rafael@rcpassos.me>
References: <20240613020729.43953-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: Rafael Passos <rafael@rcpassos.me>
Message-Id: <b48e798a-e937-4416-9757-92b7b2d492ef@smtp-relay.sendinblue.com>
Origin-messageId: <20240613020729.43953-4-rafael@rcpassos.me>
To: <ast@kernel.org>,<daniel@iogearbox.net>,<andrii@kernel.org>
X-sib-id: W5tAXx3Wn24DZlJgMASfspAiR4zVYsgMzd3mU9ZkyuIxxV25PJ5za9jCezx7I3f8MMFsT77sFXBnKSD8bG25PC-ORV-ZUZDed9GCzUJe6atfH3RJ0Jh46I78b8-NdGCtSQc-EP_kZlIJ01i5LQ04BrGVFVhGCho_CFyQJTl-Bmyh
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 77.32.148.28:6736438_-1:6736438:Sendinblue
From: "Rafael Passos" <rafael@rcpassos.me>

This new=5Fn is defined in the start of this function.
Its value is overwritten by `new=5Fn =3D min(n, log->len=5Ftotal);`
a couple lines before my change,
rendering the shadow declaration unnecessary.

Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---
 kernel/bpf/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 4bd8f17a9f24..10b2ed6995eb 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -91,7 +91,7 @@ void bpf=5Fverifier=5Fvlog(struct bpf=5Fverifier=5Flog =
*log, const char *fmt,
 			goto fail;
 	} else {
 		u64 new=5Fend, new=5Fstart;
-		u32 buf=5Fstart, buf=5Fend, new=5Fn;
+		u32 buf=5Fstart, buf=5Fend;
=20
 		new=5Fend =3D log->end=5Fpos + n;
 		if (new=5Fend - log->start=5Fpos >=3D log->len=5Ftotal)
--=20
2.45.2



