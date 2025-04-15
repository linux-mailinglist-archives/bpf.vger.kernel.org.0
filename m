Return-Path: <bpf+bounces-55971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB72A8A4D1
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 19:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF3F3BC3DF
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED0317741;
	Tue, 15 Apr 2025 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PP8/0JZ1"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B746FC5
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736461; cv=none; b=n3/CfK5xVPw+d5D1pcfa0DxwTzHnd1pKxzOd3RZaSV82201vEB2NEUHB4mSqxCuWuOROxdhpzROtXPnLU+4OkX6miFLlDwP18VPp9BzKA+aGwYfhiB0JWNPFDz1WrBWRLsN/v85xIW936xkqYe10ZHKPlYnIOO892VWWUP8i188=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736461; c=relaxed/simple;
	bh=HYG9Ydj1CkNJHv3NAdtVSqltgwNIhIWhSRCR+zyDhKc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ivKOrNi2NjQPs3Qvwb+ZMeDtLt+XdcVkdcVhHw3Ilca7dj7t9242mJpNDasp1ZcpxcKNvoRoV46AYI4PzKQXkukm9sWjsHDtrVo3/Krf4gyrIiSLLVjP2qwsCe6mrsIqyLNmPK7yaTg9+7dvfOEN0YA5LqPmhfY7CU2TgUL8nys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PP8/0JZ1; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744736456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2++wc7gpI0tHQBsAwAQSij1voTjj4GtIOJIGp4oiEs=;
	b=PP8/0JZ1/bymDhLZDb2VwAHNIKWWAk0MIVlaFFGD3CVsnSOv0j/Nb39QM9GrqcB3R8hhHo
	NgvWBhRupLIwI+4KZ5OorVe8sAQ6+wD1zXJ8Z72T7FKyIBLwa26eRU0faYOyaSdxqHnI3P
	kCBegkTLqKendtMI8yMsJjZz6nzZxNQ=
Date: Tue, 15 Apr 2025 17:00:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <02aa843af95ad3413fb37f898007cb17723dd1aa@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf] selftests/bpf: remove sockmap_ktls
 disconnect_after_delete test
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, mykolal@fb.com, kernel-team@meta.com
In-Reply-To: <3cb523bc8eb334cb420508a84f3f1d37543f4253@linux.dev>
References: <20250415163332.1836826-1-ihor.solodrai@linux.dev>
 <3cb523bc8eb334cb420508a84f3f1d37543f4253@linux.dev>
X-Migadu-Flow: FLOW_OUT

On 4/15/25 9:53 AM, Jiayuan Chen wrote:
> April 16, 2025 at 24:33, "Ihor Solodrai" <ihor.solodrai@linux.dev> wrot=
e:
>>
>> "sockmap_ktls disconnect_after_delete" test has been failing on BPF CI
>> after recent merges from netdev:
>> * https://github.com/kernel-patches/bpf/actions/runs/14458537639
>> * https://github.com/kernel-patches/bpf/actions/runs/14457178732
>> It happens because disconnect has been disabled for TLS [1], and it
>> renders the test case invalid. Remove it from the suite.
>> [1] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@kerne=
l.org/
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> The original selftest patch used disconnect to re-produce the endless
> loop caused by tcp_bpf_unhash, which has already been removed.
>
> I hope this doesn't conflict with bpf-next...

I just tried applying to bpf-next, and it does indeed have a
conflict... Although kdiff3 merged it automatically.

What's the right way to resolve this? Send for bpf-next?


From 21ecc409c7e78e52cbb27296b039c13860ace7fa Mon Sep 17 00:00:00 2001
From: Ihor Solodrai <ihor.solodrai@linux.dev>
Date: Tue, 15 Apr 2025 09:22:50 -0700
Subject: [PATCH] selftests/bpf: remove sockmap_ktls disconnect_after_dele=
te
 test

"sockmap_ktls disconnect_after_delete" test has been failing on BPF CI
after recent merges from netdev:
* https://github.com/kernel-patches/bpf/actions/runs/14458537639
* https://github.com/kernel-patches/bpf/actions/runs/14457178732

It happens because disconnect has been disabled for TLS [1], and it
renders the test case invalid. Remove it from the suite.

[1] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@kernel.o=
rg/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 68 -------------------
 1 file changed, 68 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tool=
s/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 49b85c1c7552..3044f54b16d6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -61,72 +61,6 @@ static int create_ktls_pairs(int family, int sotype, i=
nt *c, int *p)
 	return 0;
 }
=20
-static=20int tcp_server(int family)
-{
-	int err, s;
-
-	s =3D socket(family, SOCK_STREAM, 0);
-	if (!ASSERT_GE(s, 0, "socket"))
-		return -1;
-
-	err =3D listen(s, SOMAXCONN);
-	if (!ASSERT_OK(err, "listen"))
-		return -1;
-
-	return s;
-}
-
-static int disconnect(int fd)
-{
-	struct sockaddr unspec =3D { AF_UNSPEC };
-
-	return connect(fd, &unspec, sizeof(unspec));
-}
-
-/* Disconnect (unhash) a kTLS socket after removing it from sockmap. */
-static void test_sockmap_ktls_disconnect_after_delete(int family, int ma=
p)
-{
-	struct sockaddr_storage addr =3D {0};
-	socklen_t len =3D sizeof(addr);
-	int err, cli, srv, zero =3D 0;
-
-	srv =3D tcp_server(family);
-	if (srv =3D=3D -1)
-		return;
-
-	err =3D getsockname(srv, (struct sockaddr *)&addr, &len);
-	if (!ASSERT_OK(err, "getsockopt"))
-		goto close_srv;
-
-	cli =3D socket(family, SOCK_STREAM, 0);
-	if (!ASSERT_GE(cli, 0, "socket"))
-		goto close_srv;
-
-	err =3D connect(cli, (struct sockaddr *)&addr, len);
-	if (!ASSERT_OK(err, "connect"))
-		goto close_cli;
-
-	err =3D bpf_map_update_elem(map, &zero, &cli, 0);
-	if (!ASSERT_OK(err, "bpf_map_update_elem"))
-		goto close_cli;
-
-	err =3D setsockopt(cli, IPPROTO_TCP, TCP_ULP, "tls", strlen("tls"));
-	if (!ASSERT_OK(err, "setsockopt(TCP_ULP)"))
-		goto close_cli;
-
-	err =3D bpf_map_delete_elem(map, &zero);
-	if (!ASSERT_OK(err, "bpf_map_delete_elem"))
-		goto close_cli;
-
-	err =3D disconnect(cli);
-	ASSERT_OK(err, "disconnect");
-
-close_cli:
-	close(cli);
-close_srv:
-	close(srv);
-}
-
 static void test_sockmap_ktls_update_fails_when_sock_has_ulp(int family,=
 int map)
 {
 	struct sockaddr_storage addr =3D {};
@@ -314,8 +248,6 @@ static void run_tests(int family, enum bpf_map_type m=
ap_type)
 	if (!ASSERT_GE(map, 0, "bpf_map_create"))
 		return;
=20
-=09if (test__start_subtest(fmt_test_name("disconnect_after_delete", fami=
ly, map_type)))
-		test_sockmap_ktls_disconnect_after_delete(family, map);
 	if (test__start_subtest(fmt_test_name("update_fails_when_sock_has_ulp",=
 family, map_type)))
 		test_sockmap_ktls_update_fails_when_sock_has_ulp(family, map);
=20
--=20
2.49.0


>
> Thanks.

