Return-Path: <bpf+bounces-52123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DEBA3E943
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 01:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960C719C312C
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 00:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6412C18641;
	Fri, 21 Feb 2025 00:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="QiyXKaIe"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18781CA9C
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 00:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740098551; cv=none; b=SVnFj32lrEnbcd30IOPHpvLEiVDCCJ/XPL9M3qBh6ZQ4xrNjaG7m1GcGzJcdBzGhu93sz522IA/06BeO/YYrbUd1KgSJJ7xwdc56RH7B02w0kyeStA0qhSyyJJf+Vtg36TsxRILeCo+wMEKq6xh+IkpPtkvYGVwbz28eHxkbeZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740098551; c=relaxed/simple;
	bh=MW6eS1uMlfKTSaCcEkHemi6lb9BP8/pZ4U8GJdSZ5B8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fvchE1EOyfAtrDfF3ib31a4n2kZuUPcHM0kqzT8gEmISJ/Ia4h96L6FS/G0+M8Tz/nL9sRt85D6HhyXPiX80iDrGwbn99Jmlyw9JI2b9zb55JKJCVG6y2D02qCE8pySIGQrOXIAiiUcQkgN3HHmE1dfSrntPI8c2dCU9aUfdWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=QiyXKaIe; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from localhost.localdomain (unknown [49.47.194.30])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id EC37A4350B;
	Fri, 21 Feb 2025 00:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1740098539;
	bh=MW6eS1uMlfKTSaCcEkHemi6lb9BP8/pZ4U8GJdSZ5B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QiyXKaIej20lu7Krv8OYo5MBZf1DXP324Stj760iD3ejSaRtJfU6CVTqH7DFwwqkC
	 IEL7QOeRX893z5ILXJS70LivL7H9dOwWm+Cc/xC6at78tmXrIPH7T02mPSqNoJu1QF
	 23BcLuAKWvNop/6TuI/NLCK33E5NnWwrwNa2f1GWlMwO4W0AeGfFEvSHZo5Uy5DJbY
	 gJApQL0B+ZqWlXba+9ap+flatH18KQ7rX02jidnPGLJag81ZgzIIjYTMWTXWrBKv4h
	 w50ySr1jXsdzptTdhalHCzqdvMRZgnR4PHZ3ixdxo6+VgNJ/ln232oUFhLSwB6SWRY
	 Jv4+mFINTf87g==
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Nandakumar Edamana <nandakumar@nandakumar.co.in>
Subject: [PATCH] fix: out-of-bound read in libbpf.c
Date: Fri, 21 Feb 2025 06:11:04 +0530
Message-Id: <20250221004104.2855261-1-nandakumar@nandakumar.co.in>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <eac572ada2fef3516cb1fb7977f721f738d76558.camel@gmail.com>
References: <eac572ada2fef3516cb1fb7977f721f738d76558.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 194809da5172..1cc87dbd015d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2106,7 +2106,7 @@ static int set_kcfg_value_str(struct extern_desc *ext, char *ext_val,
 	}
 
 	len = strlen(value);
-	if (value[len - 1] != '"') {
+	if (len < 2 || value[len - 1] != '"') {
 		pr_warn("extern (kcfg) '%s': invalid string config '%s'\n",
 			ext->name, value);
 		return -EINVAL;
-- 
2.30.2


