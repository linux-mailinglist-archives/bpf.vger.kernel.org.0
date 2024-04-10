Return-Path: <bpf+bounces-26333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5214289E6D4
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 02:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3B4283C85
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED881621;
	Wed, 10 Apr 2024 00:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="s43aOJgZ"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DDE19F;
	Wed, 10 Apr 2024 00:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708894; cv=none; b=jP0ER3w5cUO7ONRZLMgJXkq0R1xjj8y4ifjLJb/bxKdFkz4PgIDWYy7w9zRJut3pJl4F3wHpvoAJJffy+udIf6/8i1Tv82103jniN90kXMf8l45ScLGKD64BwkoU9Vav2PorrJN0OI5z5Te6xJVRjnF9T0RFZd9GHCbpjM220Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708894; c=relaxed/simple;
	bh=W+pYLXuRXB0jH5q5NK82XfEzLZKFNQRH5v63Njz4D2o=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Zg1/EPrpdmxBKoeLRaSiEPll6NVL2pE9Zc95jEbLMm6jIAVdAf3msvpDaCt3yBrv+r9FyRUB/mubvmxQK7qBPTKNXTP1lZ4JvAntbqoGa9btwaiJdGjpEhPGBmemEzwVJZB1vCFzV7pLvjPPEq+5MrPfpcaeFXe8xb0cvptYxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=s43aOJgZ; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712708885; bh=ovDthVW7r0uBySIExmKxz78q0JYqkQ5bKXWaw7WizAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=s43aOJgZZE5lccYurgJjlLZrnGsonBdCd6x1V9v9PM+pcMuc4zj7hnomuzngN4Xaz
	 rn3WF7lm18QD9TBDPEa265RJRyO5vRG38X2kRoh7TzLk9CeirGyAYk25flr4xifqA9
	 riRoVm7trSsARxUOP0z4gqtDmxOiA6cxFhk9z0R0=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 701004C9; Wed, 10 Apr 2024 08:28:01 +0800
X-QQ-mid: xmsmtpt1712708881ta4aorxgu
Message-ID: <tencent_FB85678A3DC136BE969236344B0A74177709@qq.com>
X-QQ-XMAILINFO: N5sfBKY/oC4kM+iGSm6/9VCLVz8SGTECWfptp5OikjMSRFNCCQNfxKXST3r33W
	 DUPiklFjqBdyQutO5oxysWrhjgBej1LJjDMWS8LRdP7P8NF+U3+gOOCRxd3ul1RIj6fyGaDLAUWJ
	 Cyw6qH5JBlfQcJhcychPjL7LB1dyqJbq9t39TK2mooK3ycFVzt1LFCi6m9LYbYmSuJV64tpbMBfl
	 H2Jhwz0UisNyNfKavN8h2oz56RGgzk4GoyqKqZ8eh7Zt3yCsHE/VmIFq2FdI7YyhGDjGtFZkOT4r
	 tGL/tBnLlx8ttq8CFkrJJadd4KypmeZe59v7wErxdJ+91h/S2su4ypgeNeflhCIh7rJ/Kuhw5B6P
	 Ly9nW62wG61vrwHQGYpV3DJqziJpKChqLH8AkparwEm0DMlsZ9FKtAEG7MaTfAYXdYJLEvQQU183
	 yH0jnZPw3bj/d2gau3MZUXy3EPtsKAxF0N1h/IeKc4N9r6KTP2jT4CiCY9aD097qMPlYA/BiuP1J
	 h8dTgeF1f6VJ2TvcRHkTTFXr/3fhDPVcAHn32PB8MmpYzkjjtc6Ey5M0eLU9nwH67ZZHFG916ntY
	 d5rlqEA5xBoJ3iCMX0bjHnO8EfNvqOnTAt5LU7BRBjBrsxz7vIXbt420Zqbu8GywWAHwCtrtEeb7
	 Zw3e38wHADGvZyI9LE+Dz+irtAUsLMsPhzMetrI4QWUThiMXX0odv6fSj6eSzRndE4ozLvjKunyu
	 MJl9k/whTFP9yAuG2NcyGPFiXQe9UoLndaGbK1ji/7rGeIajCPKU/11ho7+7fkCVUQs6MdcMkMih
	 qTyuSi1w6d/4pRchxLOgtltkh9McWO8cNGSIC06k+qas4i+LJ4KJigbNx7xfdwB+GttQXYFwlq/0
	 IY3Z6TEzAJ4MfQ2AcrOO78x6WlMDUkNX49BP5LzdJsqO3cQpKGdzPACVb60Vjemsh8eG5+W8fDSt
	 Y4+q9EIUs=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: martin.lau@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eadavis@qq.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	sdf@google.com,
	song@kernel.org,
	syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH] bpf: fix uninit-value in strnchr
Date: Wed, 10 Apr 2024 08:28:01 +0800
X-OQ-MSGID: <20240410002800.176768-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3cbc70e6-04e9-4523-9d4d-84d0794cfc74@linux.dev>
References: <3cbc70e6-04e9-4523-9d4d-84d0794cfc74@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 9 Apr 2024 10:59:17 -0700, Martin KaFai Lau wrote:
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 449b9a5d3fe3..07490eba24fe 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -826,7 +826,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
> >   	u64 cur_arg;
> >   	char fmt_ptype, cur_ip[16], ip_spec[] = "%pXX";
> >
> > -	fmt_end = strnchr(fmt, fmt_size, 0);
> > +	fmt_end = strnchrnul(fmt, fmt_size, 0);
> 
> I don't think it is correct either.
> 
> >   	if (!fmt_end)
> 
> e.g. what will strnchrnul return if fmt is not NULL terminated?
> 
> The current code is correct as is. Comment snippet from strnchr:
> 
> /*
>   * ...
>   *
>   * Note that the %NUL-terminator is considered part of the string, and can
>   * be searched for.
>   */
> char *strnchr(const char *s, size_t count, int c)
lib/string.c
  9 /**
  8  * strnchr - Find a character in a length limited string
  7  * @s: The string to be searched
  6  * @count: The number of characters to be searched
  5  * @c: The character to search for
  4  *
  3  * Note that the %NUL-terminator is considered part of the string, and can
  2  * be searched for.
  1  */
384 char *strnchr(const char *s, size_t count, int c) 
  1 {
  2         while (count--) {
  3                 if (*s == (char)c)           // Only when the length of s is 1, can NUL char be obtained
  4                         return (char *)s;
  5                 if (*s++ == '\0')            // When the length of s is greater than 1, the loop will terminate and return NULL, without obtaining a pointer to a NUL char
  6                         break;
  7         }
  8         return NULL;
  9 }
> 
> 
> >   		return -EINVAL;
> >   	fmt_size = fmt_end - fmt;



