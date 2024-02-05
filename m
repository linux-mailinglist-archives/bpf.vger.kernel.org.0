Return-Path: <bpf+bounces-21233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F8F849F36
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 17:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C0B1C23CC0
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 16:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB96239AF5;
	Mon,  5 Feb 2024 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvOo1Oh5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4223EA86
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148947; cv=none; b=pMAYmlFu0rJLfdNMKaHEGvWDrk4xb7zxv+T9GGGOSYEVQjIck8LKuYWGtGKVTl7gqFXb68tb7BxZkddpTQ9Dm0+0cHSEOcFZ3GAJxFMuEhDzRQ8r+P6fjmQVxCnvLGdvVJM10Ns2HtgVfd3G0X9HcPSqkQOY3v0rwANPz0RSIfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148947; c=relaxed/simple;
	bh=wW9ZspvSIcwyEIONMIBvk+Yr+k/PaslR0mILVTwQ+TY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lycg2P5sHGOcq6dzAMKdWGeA6MqDpopJofelhYu+CADgX7IXDy22mxy+QigSg6VdRBL80xwqPEv7SyqvXIdw3kXCaCUHuf4FuVF48Av+QMBsCFTmGGmeb5/2UsVW9OqCBh4MBmAdgMqrZKceZMCNAzU6noC30HI754Sbj2R/nuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvOo1Oh5; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56001b47285so3299759a12.1
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 08:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707148944; x=1707753744; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G7yyzwFimP+LlvwGRBoQM2+lsZeHNB8FH/DJy1cTCoQ=;
        b=MvOo1Oh5k0KUZNUThgpISZL+QoEVhgOU5Nx8z87A3Vqlb4lypOie0EEVUcmeL29jX6
         jBL5nSI80UKPkBJT6U6OYMThL8aka/74aRPi/qIxX05OWiA4ogKvzlB5owFTqhUiwCRs
         Ufsj800pe+nJX6yPEw6AaLguXLN/YALHTamChCVS2jiEkFwHIGJWkfAxvqg4p/yfaPPz
         pAP8rdi69frRHTJNEhpdQ0rqpStBz2wqLTptGmbcjdaSo8knM/cxNOMtIy4YgXSQZv03
         /boP80KJmhIK5i91QkmVj1tN5DbCs6CWnN2MW405AwaCB5mby3vhKVo8mdxg8ioNd7la
         pISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148944; x=1707753744;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7yyzwFimP+LlvwGRBoQM2+lsZeHNB8FH/DJy1cTCoQ=;
        b=Lxj0moRmOWawQyTlVreo1ag3w8Ebtm6gZztVSSxy/i0ARTsOqfcOBvkMcYQlPxHnPJ
         p6eTTMXHCWGoX3ySlxaM7T3n2N8Atew15OZ5nUa5gBDr0tIHINfpbhvauUgkZzelfPL1
         1i/hdLwWYON7isnWIl6lnjM3hF0ukR+PWf8JK8feOnE5JMILf/lcnPAbhuz/MXSvu3iE
         ip0SmxSxvVguozjVWXJijjriiSFIQyf9yRb9OvGaEPfLNSDpfPrYKES6TVRg9Z5+xUaJ
         N/ZhX6eIawbP5MXaivuVCzNVLDcz6zse0TmnfUke8Iiqz/0D8G96xVLfnDa0MJvjRYlq
         xl1A==
X-Gm-Message-State: AOJu0YyEYPfhI2vO8jpfu0tQZaWGvHbBh+OcUKxmV0jGwASm1OZsqafJ
	3TW2SprJfmy6lt5Qz/EeGRDCfie1DsHKD6h/ey9sgzD5tArmM7lukOnCYpbG
X-Google-Smtp-Source: AGHT+IGXzRGo8pIK6vA/Ku21Khne7OumQWrvXD0cffcghO4FVDYg9rqdHe6lq3M4CxJ8F39L59pWVA==
X-Received: by 2002:a17:906:4e91:b0:a37:9395:9045 with SMTP id v17-20020a1709064e9100b00a3793959045mr2963635eju.4.1707148943378;
        Mon, 05 Feb 2024 08:02:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWcezCd1xb7EOT53bfD6Ozmup3dXjtz3wTuwit7jCRFBuh6rMT4yga6bV8Lfc0OLW1i5Rq88SQOI4+INe7xxXh0Lu7vNgNaHZWkFA/124gSC66fueeV0gdOFyP+Y7iTI9umTPOUTAUtV/HyVIwki9mbVUowLvuC6ecgLD6d+O3kEJVoBu0kSiBlU80XWh3z3MXT+WmaAKed
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a13-20020a17090640cd00b00a37d491c221sm892132ejk.118.2024.02.05.08.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:02:22 -0800 (PST)
Message-ID: <f906870c6ce92798209ccf2841a291b214acf38c.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix flaky selftest
 lwt_redirect/lwt_reroute
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Mon, 05 Feb 2024 18:02:17 +0200
In-Reply-To: <20240205052914.1742687-1-yonghong.song@linux.dev>
References: <20240205052914.1742687-1-yonghong.song@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-04 at 21:29 -0800, Yonghong Song wrote:
> Recently, when running './test_progs -j', I occasionally hit the
> following errors:
>=20
>   test_lwt_redirect:PASS:pthread_create 0 nsec
>   test_lwt_redirect_run:FAIL:netns_create unexpected error: 256 (errno 0)
>   #142/2   lwt_redirect/lwt_redirect_normal_nomac:FAIL
>   #142     lwt_redirect:FAIL
>   test_lwt_reroute:PASS:pthread_create 0 nsec
>   test_lwt_reroute_run:FAIL:netns_create unexpected error: 256 (errno 0)
>   test_lwt_reroute:PASS:pthread_join 0 nsec
>   #143/2   lwt_reroute/lwt_reroute_qdisc_dropped:FAIL
>   #143     lwt_reroute:FAIL
>=20
> The netns_create() definition looks like below:
>=20
>   #define NETNS "ns_lwt"
>   static inline int netns_create(void)
>   {
>         return system("ip netns add " NETNS);
>   }
>=20
> One possibility is that both lwt_redirect and lwt_reroute create
> netns with the same name "ns_lwt" which may cause conflict. I tried
> the following example:
>   $ sudo ip netns add abc
>   $ echo $?
>   0
>   $ sudo ip netns add abc
>   Cannot create namespace file "/var/run/netns/abc": File exists
>   $ echo $?
>   1
>   $
>=20
> The return code for above netns_create() is 256. The internet search
> suggests that the return value for 'ip netns add ns_lwt' is 1, which
> matches the above 'sudo ip netns add abc' example.
>=20
> This patch tried to use different netns names for two tests to avoid
> 'ip netns add <name>' failure.
>=20
> I ran './test_progs -j' 10 times and all succeeded with
> lwt_redirect/lwt_reroute tests.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

Can confirm, w/o this patch tests reliably step on each others toes
when using command:

  ./test_progs -j  -a "lwt_*"
 =20
This patch resolves the issue.

