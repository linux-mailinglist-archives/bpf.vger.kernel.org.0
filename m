Return-Path: <bpf+bounces-51978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7EDA3C96C
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 21:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C6E7A3DAF
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 20:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EEC22E3E7;
	Wed, 19 Feb 2025 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="hDgCUewb"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC6222D7AE
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996013; cv=none; b=W8AbPQciXYDcgLUS9VGRP0SW9AGxu8m0qbIQZp0GpaujaLZDxYY0+mYlsv0HGuZJ5yesCW9/GqZDOMzH5JdYvCJiwZgEjKCEO8HCTNj0c4AgwPYqW5BNNoju513kBFp5i9Kzy9eRHnK9ad7AFzVQZOTwRB1hYQdoKF0vTI6svjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996013; c=relaxed/simple;
	bh=GsY2TZLNzy1/KUp/8cS6gpzf+A6OebA26vibcUT8Tto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=byYFKH/pAT86bkfK6E+aQnz+VmwJsFIfe4mTllff0ynbXO6QKx1zF7abIhj4ctQZ7IL1ca5uO3m9A8D+tUom5AkRW8EYK2f+yJvssjCi3T6V2z2u1EQcomW91X75x8ATdfm1mmadT+2caNHP547sgHwez+qI1Ba6h49KeA5xFNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=hDgCUewb; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1739996004; x=1740600804; i=linux@jordanrome.com;
	bh=btmhY3rlG/4jL/3fy0FK2EXMBas670yzxQn986LR/00=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hDgCUewbRbbq0th2alEf6oqaxrpn1BTokpml2HVO1utramKxpKx7ELhJj8tz+GOC
	 2Or0pYlzzD09yxQrYeR5qX6WJXcnG/DSknFk7j30em/Jcix7FqdXkXm2WqYb5UHdk
	 ds39VA3agLGP1ZC+KWgMGtUZplBslQ4U1FTlSGQ3QtrVlF7KdRFnMUyu71+mZscB4
	 2yCL9Vb0RX0r8t2PhcwzTNZlLeqTsdAtpcEXbKTf690kR2YX3xbiuc8GjXuco6WG2
	 difm/hyjPemszcyT1Yd5Q0eW8n7NKUdEJCpj8x9y1iVHhLM/PLxZUtLmd84IjZ5tI
	 YMFNeMYM9Er8m5EGVg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.116]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1M5Pdx-1tk1Uy4BOf-008bRH; Wed, 19 Feb
 2025 21:13:22 +0100
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: [bpf-next v1] bpf: move warning in btf_load_into_kernel
Date: Wed, 19 Feb 2025 12:13:18 -0800
Message-ID: <20250219201318.3160015-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JQihRVI/mh3OYX0iWdyHwQbfKdeGQ4MQts6MWDldArqMcI7LbS9
 A15zzulnuFmPN9snJiiugBxYkTMEovpPXbL+7pjUuhDFEq+HcFqN91C0PLguVj0qlcsnigW
 9bvlHKyebDaGCv+hH7YXxtxhDdi/9OR3O2wbgwQEHRxQbbKZhFOcIZkMfQCQmu4TrwLIMli
 X5tAHHjzaNWef54MmJOgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VkiVbjx6xQ0=;pk3d1vTla9fjdr3MZI9w4SMbVjx
 D7QEYyStv1qBg/XXXNtBcR6cn+a4PV+TwHcgFUCERabkM5MjChRvb3TLwiUbWxj8CfGIVSTIG
 T1CWhKQnGEIkG8zSvqAXXzuBhCkPHXcSn5+GSyUaWqoqGfJq+qocTvXi868ZCHw0e8eTluzub
 GXofsC6mFyhhl2u74GMGTyLLBIn80FYDZAohM3FBjhOjKu1iFaQZ0jOROxwOpqJw57mM9xkgo
 IyS6+36IE03n4nvanZsikgiDrmEqY4gpDginy+SnDIRtc60nQ+m9y/xaMaUQ8ZoYsOXjqV1NY
 MrulEG4f0HdMIU1xu1DMSt4bhE+plHeJratsNiz6fUnALz6q/dVEMK1M+To6eyInWQewJvdc3
 S/Rrrk3oeB5aCVw631/UOBfKHXxVTW++Xx09ef7FsIwD5wTkgkRo7Ncr54gP1EuKbxzE62VuS
 0leG2gEqm8jCvXlK79koHKTUBXLdRQrrCSfDJo+JO5QpWlp2bUcfpwCYy3plqFtrPF+Nit9Cu
 xct/OqBgh2JRbuS2i74etcnL+97xepi/6GAWGAuyOZ1OabjTJvhoagxZkHUZaYUijo+kubWK2
 kOOCtkcajOU/NfGLkq6xNRtMcL38o+58wZSuVDM4dKV25G5q5cW+b5ZaoWAeKInEgi34P3ECH
 QeJBYCBtFiHcsT7OExAozGc2GGL4kxWtf3irKeBgpvEqFL2FFoCGCnnF8gdkWdkZ1hPBOxUn9
 acLYEatokaWJqUtr1uSP6xn8LeGNS+R5U+W2yXKk8HQpeFs+fKiy0rZzYk/Z7lpSyMlK6hOJz
 D2RcNspbVVVHxemI6tiakdUDr4TgHqW4AoSSjQ2SHL4btK7xCB51g/mR+MguvBSekZHonisVa
 XRCzEIW2wsGKzVP1Wb12dLlmbG0fsGIFUvjdowvrgNO0+wZAOzeO80dhvlVM0ku/qSyVQpHse
 cmf5RMKbv5DUoZo6HbGsD5vSdqo5iAclSxSu4cbYAI4TkIa+wNBJQJTN9UfmCZbCcqG4i4jkL
 qpXxaEXGGkEtTOppaubA4SELrXO9JDCA38UJMj8AuAnjWBvNl5Ky9kJdCFc36k3qyze9Vftcg
 sNDes0YgRZbdzvaw1FRlkB+Ribsw8mDUneHhOXg0XnCHxZK2tSKGGI+JSylVyTYWII3u9Mglz
 6tIQg+MgtMOl7ltMebaZEXFuJVVHmNQmT2EhG+mn0/s559Gij2eX8qk9WsF8js9VwDSrL/02H
 ta8hC/HWzHShqXnwotbvq3A85KO82xAoHXvTYkknQOwWG2B03e9bSgZ8HSbsfEmKrcatHK2oC
 gzbzKDCpV/1b3fyg/GgZgdgpl45BOy3kFWGDydTXVQS7+Nz0HB2LWHCfe7vZzEl8hmV

When BTF fails to load, only show the warning
for callers that didn't supply a log_buf.
This will remove an unneeded warning for
users loading BPF programs (via
`bpf_object__sanitize_and_load_btf`) on kernels
that don't require BTF.

This also assumes that callers providing
a log_buf know what they're doing.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 tools/lib/bpf/btf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index eea99c766a20..e4a463bda0b8 100644
=2D-- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
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
=2D-
2.43.5


