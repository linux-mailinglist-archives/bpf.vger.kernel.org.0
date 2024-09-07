Return-Path: <bpf+bounces-39195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A16970481
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 01:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32091F2206D
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 23:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF344167296;
	Sat,  7 Sep 2024 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXuAFFSv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D733625632
	for <bpf@vger.kernel.org>; Sat,  7 Sep 2024 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725752015; cv=none; b=D0kwnJt5YO9h/7BAXTAKu/fQ8hHsCDMUwZOw6Q57byAC95zEIxoYO9JuBhcLnhxTxPWrzuIN8jWxfZYEgABoxMUgJxgNUJ2CVtn1Ge+hzO7MGAgk+aYvMyTXRUx1ucx23QaOHtEz9n+LQ857AfjGzMAu1eBKb+VANf3UymHI1Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725752015; c=relaxed/simple;
	bh=CljwVZZ56bnMSdANbZTHCcYD3PNjbj9Jb9ldr+KnBjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DA+PMZCRKnhTYFuBP0CsK5GbXo9JmjT6kdQ/9xzwRhQRIkuGGGj7ay7T1yNJKuyGn/m1gcNqxRQDbwDPGxhqexL/3+ftx6fU1WK16kHVnNrp99xHmxPgflzoAnTSt+cunnPxNJanBNWZ8eFmeKg2yediEVuQo3uvAUFU6sP78SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXuAFFSv; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-457e153cbdcso22891731cf.2
        for <bpf@vger.kernel.org>; Sat, 07 Sep 2024 16:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725752012; x=1726356812; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s40DcOwnMXc49PW5AvfNzz4Zc8gm0PO6rbMLztvvgzI=;
        b=lXuAFFSvCnkKPLYUwMHY7p/xJCYKXdvltLFLmegrKHaVqgV105u2u8YqC7pch15gYc
         9p0KP3IhTvESxhmApGrsBBms+nPkBEjGl9+xdlo1eNpcTcXnGptUIB1GKmBho7WBTkLG
         M9i+wvuPeJo8539KoGddUXo4FM4MZojL/eGeSZ2w8zu6LavUIFVBS2OiZsdC3We9EFNu
         wJ+nS/H/uf8qHOexeSGyclydE0YNVlu+3fK+zSlGN84N+U7ok2XcqGNjL5Puo8wH3vUj
         JId2Tj4V/EB4R9KMxmBgd9iJyJv6sybGZbUB/m0/CPRAvb9rPGImVwA4uRBjmTxZbLxy
         dwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725752012; x=1726356812;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s40DcOwnMXc49PW5AvfNzz4Zc8gm0PO6rbMLztvvgzI=;
        b=CarwlBKXAKs4X/ehyrvC3HpAsPaRWZ5UWBu1nT3tFOnzDL3jy/QQwmbeOMMwzeFAmn
         WiHQnlOKSR45oT0PGA+eQUyv/i2Dkmf3ryzHxpaez5lKi8EaCT7yWcSmCHY6tZ5GiPCu
         R2VZi8PH2qHHGW6jqmKnjiEo1F+QpAwmxvEuoiPhkxFku6WQ/KwFfz8I1GH6gjNMx2Hr
         LdAGQKcSLmtM80VP1Loh2c672zFjOSn88xr+am5ZudJDCfY+vZXmkbP+S9jKrTtMQt4A
         D70f5dPbmHLVLoKcjfIrPQlGDWqFv+r54ZsFlyv3Obq2uUr4Fve4nnwPWriCaelnHZmc
         Z+eg==
X-Forwarded-Encrypted: i=1; AJvYcCXYF5Tm4HJpAVfI47FHWSf6NGVJSfZiUl+7KdQ/lGoajPhDK3bSdBLpo55zDN2t7shTpyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXrR8Mswb81s/uKavrVYRcUoV9VBVfBRKmvoItEgXeZnRXA6xW
	G6e586oVe/qE5WdQwTpDA99HkjDaYmhMGhrS1sHdYbDc1NADVhTsAMMO4BXL/uu0NrmD7xGK6Qz
	X/9OSnPD/Fxf58QjnGQ9ERFdIsrqAFAT8
X-Google-Smtp-Source: AGHT+IFZB42Kv6M3kHjmPvgoBP5DIsJTbFSggVbUrq4I/PPdU2cEzRmFbUk847UJQeglY8oMUKpm3wEYVeLO3IZ2R6k=
X-Received: by 2002:ac8:7d8b:0:b0:457:f6e5:1955 with SMTP id
 d75a77b69052e-4580c6704b9mr105335371cf.12.1725752012068; Sat, 07 Sep 2024
 16:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJxriS06VxYSaCoo0WT2LtUPPwXopyMHr=-FyR5qRoeGWguBZg@mail.gmail.com>
 <b9262f12-73e8-a090-1197-2cf380ba3cea@huaweicloud.com> <72cac21d-f973-a40c-35de-cc7942ecae06@huaweicloud.com>
In-Reply-To: <72cac21d-f973-a40c-35de-cc7942ecae06@huaweicloud.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Sat, 7 Sep 2024 16:33:21 -0700
Message-ID: <CAK3+h2zrDfOdouk5_uPrM2iwbTkMg3DecKJ7ro037F2hdK26fg@mail.gmail.com>
Subject: Re: Using BPF_MAP_TYPE_LPM_TRIE for string matching
To: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tao,

Sorry to hijack this old email thread :)

On Mon, Dec 25, 2023 at 5:39=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
>
>
> On 12/25/2023 10:24 PM, Hou Tao wrote:
> > Hi,
> >
> > On 12/22/2023 8:05 PM, Dominic wrote:
> >> Can BPF_MAP_TYPE_LPM_TRIE be used for string matching? I tried it but
> >> the matching doesn't work as expected.
> > Yes. LPM_TRIE will work for string matching.  Did you setup the key siz=
e
> > of the map and the prefixlen field of bpf_lpm_trie_key correctly ?
> > Because the unit of key_size is in-bytes and it should be the maximal
> > length of these strings, but the unit of prefixlen is in-bits and it is
> > the length of string expressed in bits. And could you share the steps o=
n
> > how you used it ?
>
> Forgot to mention the trick when using LPM_TRIE for string matching.
> Because LPM_TRIE uses longest prefix matching to find the target
> element, so using the string abcd as key to lookup LPM_TRIE will match
> the string abc saved in LPM_TRIE and it is not we wanted. To fix that,
> we need to add the terminated null byte of the string to the key, so the
> string abc\0 will not be the prefix of the string abcd\0. The code
> snippet looks as follows.
>
> map_fd =3D bpf_map_create(BPF_MAP_TYPE_LPM_TRIE, name,
> sizeof(bpf_lpm_trie_key) + max_string_length + 1, value_size,
> max_entries, &opts);
>
> key.prefixlen =3D (strlen(str) + 1) * 8;
> memcpy(key.data, str, strlen(str) + 1);
> bpf_map_update_elem(map_fd, &key, &value, BPF_NOEXIST);
>

I have a use case where I want to run an XDP program to parse the DNS
packet to get the query domain name, then lookup the domain name in
bpf map to decide if the query is allowed or not. For example if the
LPM_TRIE map is pre-populated with "example.com", then  queries like
"foo.example.com", "bar.example.com" should be matched, right?

I haven't gone that far yet because  I haven't got a string match in
hash map working, but that LPM_TRIE map would be my end goal.

Here is the hash map string not matching problem
https://github.com/vincentmli/xdp-tools/issues/2,  am I missing
something about string terminator '\0'?


> >
> >> Thanks & Regards,
> >> Dominic
> >>
> >> .
> >
> > .
>
>

