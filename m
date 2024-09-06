Return-Path: <bpf+bounces-39131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C32B996F605
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 15:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76939284433
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793A71CF5CB;
	Fri,  6 Sep 2024 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QCJ0wn1x"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E251C86F2
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630981; cv=none; b=RaxIIpuR+rgvnROOMWGVc0QzcRu7cdLO7NZUJCuYRw5OiOD/e5bOrCmBaqjVEQPu0xmo0gxDO/FKGyENDybP8Sp3DhcptGyVBlatARRrZWICtJDhDvZ6ZNX7n7ELNkSmTD/mbzUjGvuFiqFI/89CaicCRzjv64kkC/SD7wmRBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630981; c=relaxed/simple;
	bh=aSO8udBLKicPLF3+RFIDYapuu6Dk7h/9nchoe6BUh4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iBQYZUn2zU2WS5dHlUeZFS6iOzRlZCuCOkQpkEMPM08BEDecCLh71uSIruc0WEMgR9y81w+AqNyqL8ChcERFDFRiWWQC0I9iCxecir3qEZIxswfCrouOlztQqi0eiQNJL/GENivs7FBq5ekIKe27YaTY673CN8dtJqZcLDnPjEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=QCJ0wn1x; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fglwQ15qRqlQDvZ3j8FVKvytf3IEa3sofEdEZAk3Bfo=; b=QCJ0wn1xlCdZrtqwXeSTwfz6kO
	z2gNbKvoKvBC2DrlCDHh3Hwfip1GCRT5Gn8xhtiAjBUutNBM+ZpD4ralEgmy8Lyg1WtTKZdpeMA7x
	K39UE1BDFfVRusAZHOEoIkYrW+YuEBQ+VEq/ewsSFkyPg7tT0Q0nMEfz8/mNdoouwsNFJpq3dbh9V
	LNQfGap6yvRYBU9EH3JE204+y1JtRHIPTaamoGwtDSiVwopF7FAPKmWq9ljMh5r8TT+0a6IGf5SCF
	p3OLpMMZJ3m6WxDqzNc/c4BcZHQtXvYcBzrb+BqtH6o8XJh7coJHmB3hrkK+vNBheMVqAAbtG7/4m
	YEiOLOjA==;
Received: from 15.248.197.178.dynamic.cust.swisscom.net ([178.197.248.15] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1smZRb-0001yo-7X; Fri, 06 Sep 2024 15:56:11 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: shung-hsi.yu@suse.com,
	andrii@kernel.org,
	ast@kernel.org,
	kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v4 2/8] bpf: Remove truncation test in bpf_strtol and bpf_strtoul helpers
Date: Fri,  6 Sep 2024 15:56:02 +0200
Message-Id: <20240906135608.26477-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240906135608.26477-1-daniel@iogearbox.net>
References: <20240906135608.26477-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27390/Fri Sep  6 10:38:06 2024)

Both bpf_strtol() and bpf_strtoul() helpers passed a temporary "long long"
respectively "unsigned long long" to __bpf_strtoll() / __bpf_strtoull().

Later, the result was checked for truncation via _res != ({unsigned,} long)_res
as the destination buffer for the BPF helpers was of type {unsigned,} long
which is 32bit on 32bit architectures.

Given the latter was a bug in the helper signatures where the destination buffer
got adjusted to {s,u}64, the truncation check can now be removed.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v3 -> v4:
 - added patch 

 kernel/bpf/helpers.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0cf42be52890..5404bb964d83 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -526,8 +526,6 @@ BPF_CALL_4(bpf_strtol, const char *, buf, size_t, buf_len, u64, flags,
 	err = __bpf_strtoll(buf, buf_len, flags, &_res);
 	if (err < 0)
 		return err;
-	if (_res != (long)_res)
-		return -ERANGE;
 	*res = _res;
 	return err;
 }
@@ -554,8 +552,6 @@ BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
 		return err;
 	if (is_negative)
 		return -EINVAL;
-	if (_res != (unsigned long)_res)
-		return -ERANGE;
 	*res = _res;
 	return err;
 }
-- 
2.43.0


