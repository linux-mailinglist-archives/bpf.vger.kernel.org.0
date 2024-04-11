Return-Path: <bpf+bounces-26507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390788A144D
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 14:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75B9284966
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E73C14C5BA;
	Thu, 11 Apr 2024 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="paP0M6PO"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7BC14A603;
	Thu, 11 Apr 2024 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838001; cv=none; b=MpM+Kvur2cBqT1K6+TKZIBw+iPud1fKQvqwI9/35ucbIr08y8sLK/WoTwCWHvFoAoQ8N5gD2kK13k8OYgTJTxxqFdcbLnKqxVZi51imlukjcb5PXdT1uWWRVsr0fYzofETYpyMLTpTmiykHb9K4kVFcISIq5pJCvav7GQiWPtg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838001; c=relaxed/simple;
	bh=Fv8F+LqJff2mEWVv8dPMK9uakqRJ0lDNqkorVAyOs7U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=SmA5pGbeihYtJrxAZwMcoHa7rZyfeid4HWIBmXrslBAdqDFQPHRUH6yd9tGCdiGWUMDFZH5vd3+t2wjhFPfISWKBRmQIruD/60NuEfr8Sjl2xRoTUVu5jrDs+os35QtNHBG2Ntkdap0+FGHwBe82nj+wKj3ovPlEziAZ1xg7YpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=paP0M6PO; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712837990; bh=REf7CUdqiJuDhAU9bhL9/nMO0Vzqyv6Hp1KPo+J2oHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=paP0M6POb5tMsm/RYRZgah8h97gUtkaLDIbqOfr+jJVZ2W5QdCgV3bWcNol1YdW7d
	 qVd6+lOXO8nL/3Ogb6KuVfPX/tpX3Qv1ukUHDQxId1ZcHGb/QDS0+IYznVctxJLu4o
	 8msCAfObXp+OFhyTAHDmpCZvmPlPGbxs7C/wVan0=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc6-0.qq.com (NewEsmtp) with SMTP
	id 364BDA7C; Thu, 11 Apr 2024 20:13:36 +0800
X-QQ-mid: xmsmtpt1712837616t7fd8r3g2
Message-ID: <tencent_7078297303BC2446F7663763C6D773640305@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0aA9gxQHflprTWP5hmPAz0fROehYfqfNzE27OdQsGTgE+9RlXr3F
	 nOQu/JldIf1DS8ZwZfAOVX8tBQJUziU0Oz7t0vzq1Yr6gUSrWlLEi7hKL9LwcUQ07N2AYEnmHAde
	 5xL4MGeIiL0AERRXjINQ9d0/mw9x4Asxmdzb7ZRuxV0D5xbYXfm2v5JXeoASu/cO28p+lK6qEnRM
	 prgRXnPcDM3u2oDJNiHaJDMWIe0ErZ7YMV0ZQrBkNQLGCssAOu4QeeAcR20fjisCUkU7W45g9hub
	 qcUWGD3bC6Vv7iUrOF3TWWM5ACVEAPju7cvUdKyBd+llXDQfPknK/JPQVUfDdqXaggLfVhFGHo6X
	 jUSymgkGN7PZ1KZb30l/N+cNXXhkjtYIRFSBF2CVEQZ4MGrLayPQaCFlBGLJPoj47aYnrosXqrP1
	 TNd1/knQMXnwo6CnBCDgtPSeGRlwrcOPOMAe4jpeScfsk5JHg6I9yjPbb8OmyiaVqWJ4j9IkYvJL
	 FaBo4VgPELfxTy7JNmhrRy0lGfbZfYm39NNyR2PYcx/9/1cmpGbTUmDLw4rySydmRICpWDMfPnDK
	 yZL9swNc19jbTumrePxpRxLkWvy/J+JuT24YU4welZ0gztoJjFKSrjrJCt/5YQfIM0jGr55WdJK/
	 8DZtsDjE978NaW4I+kIt138+5ZSom9BXTt8K3tCydXd2pKmtMd/JeNZdwr01InQyZdZ/cTjhxNIa
	 OmdaQPrLUxJIQvOrFPuQr3Z9y82EW6+nB/vxDkLCj+y+hgwe/zu4bgGJzeVd23nKwbpNWPJnRtkX
	 4/2qle7h0ttSZ6JJMhsRhRhvwOrVGE9/8ylkIWYw/CNAC7FQPmHDrzWix4O84YTxT9BBKRZPF4mP
	 L7HA5mo+pGPOY95mK32EZXFr/5ruvEhIP4h1acmU3hlLyyX09pfZnF2WRIueDljTWV0qkiRdCv5+
	 qv2z8+aNn+hr+n8zNhWQn+CKsw2pan
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@google.com,
	song@kernel.org,
	syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH] bpf: fix uninit-value in strnchr
Date: Thu, 11 Apr 2024 20:13:37 +0800
X-OQ-MSGID: <20240411121336.1323182-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_FB85678A3DC136BE969236344B0A74177709@qq.com>
References: <tencent_FB85678A3DC136BE969236344B0A74177709@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

on Wed, 10 Apr 2024 08:28:01 +0800, Edward Adam Davis
> >   * Note that the %NUL-terminator is considered part of the string, and can
> >   * be searched for.
> >   */
> > char *strnchr(const char *s, size_t count, int c)
> lib/string.c
>   9 /**
>   8  * strnchr - Find a character in a length limited string
>   7  * @s: The string to be searched
>   6  * @count: The number of characters to be searched
>   5  * @c: The character to search for
>   4  *
>   3  * Note that the %NUL-terminator is considered part of the string, and can
>   2  * be searched for.
>   1  */
> 384 char *strnchr(const char *s, size_t count, int c)
>   1 {
>   2         while (count--) {
>   3                 if (*s == (char)c)           // Only when the length of s is 1, can NUL char be obtained
>   4                         return (char *)s;
>   5                 if (*s++ == '\0')            // When the length of s is greater than 1, the loop will terminate and return NULL, without obtaining a pointer to a NUL char
>   6                         break;
>   7         }
>   8         return NULL;
>   9 }
My comments is wrong, strnchr() work well.
> >
> >
> > >   		return -EINVAL;
> > >   	fmt_size = fmt_end - fmt;


