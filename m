Return-Path: <bpf+bounces-76773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAB6CC5412
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F197300C367
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 21:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3D633E363;
	Tue, 16 Dec 2025 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="f7x86Wfo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E6328257
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765921702; cv=none; b=nc2+D1PLNAyjJ6fVHtjr3WDBLzssfyoTtIHKYBXrogxDmQbuRXIRemWiM57lWW0KGNG2XBcHankviV2hmKRykrSlWj0aU6LqCgap2tABhHiGsXIDzr5NBqrPXQblVrYWYfe+ac+a4VT/0kUmjRUs6/1cjhb4iahA2oQV3D9SSoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765921702; c=relaxed/simple;
	bh=Y5zkVJ30iALAIRyPkyT80qkBWpiSOuTPZzaKz+ADav4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Mq9JPCjO9FMt4bMEXk0xm61eeBhrF41Gauf3VuXgCI6RQ1v2DmxdMcofeakGXjj86jvM86Jx2RCorXF4rI1Mq1rWx+9Hiix322J+8H/QFevJma9gjojvERa7KW50OuE4QQIwYMtL7bXwh9Ute1L/ZxSulRKrvNCaZMm92VkqewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=f7x86Wfo; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88a35a00502so29173086d6.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 13:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765921694; x=1766526494; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUp4or4VaB102ZVYzKahGb7OVzrjdiLwBoMq6+d/I84=;
        b=f7x86WfoqtsfCJ/jYxOycINf93x50HgYg8jGctKDI0A1t4+FTxIuk8np7Km3iM+Ztv
         XR2jW6KL5eDH3lAzQBYDKDwt6FqQydmYwZoG80qKdb+07WqyI4X/PjRWoVi2b8H+nMPG
         ufJ4fPOWa07wc8fEJAyjUM2RNelBTzHfoMVTYBcZ2/6IKuRdWTaSFo1gjL/FseiMHR+Q
         2CThqd1JujwWk+5zk81P3ZOpHSTkyn/dCrPfPWGS0yYBTQhE+fotopQGaFs+S7LSYmL/
         v/1twJxJZ3kAcdaXiipJWSLEkVa5X3AEjFEf6WvVpfkLTPyUdY3/aBG5bC0GzbYoZ06f
         ICiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765921694; x=1766526494;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUp4or4VaB102ZVYzKahGb7OVzrjdiLwBoMq6+d/I84=;
        b=vLGWLm3HpoxMb9wEuaqtgqh7KHpLMQLKolIaQKn81IXKEZyrI+iA6trqdPaeGSB1RB
         YIb3zwmQ1f1mhpjwoLWkw6/gcDOvqfjxfUFRpgCH78+t2i6R29MJjBV6CbaoxXzRJYpl
         bmHugcZYP6QGkh/iyZbt52g501vlyx2ixjjxbuRh4UloMIyU8nKXyEFxXA23UgLTxoUE
         ZlbUeIL3nrh8UfTXSoYnxWR/JDZT0MPY8rPWGI7/JX1yK1Km+tXlWdG7SbOeC3Y/jLgB
         BCCaykE9maQI1fbTS4y198UjpZFWAzMKC8+X46MIAMLs5BHDlFJkMwoqDTLHtqv2XFAp
         JLvA==
X-Forwarded-Encrypted: i=1; AJvYcCUrtpnakT8xp3nASOUOotpMYxC938x4eoAeRhs1pIjAVyqt7b5PrerE5RgXQ5tE4s2Z5Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgjxGBtkw2eZmuf15VkTnhip3GU4VSkEAWj4xkFP1tDrijdaF
	EzP3xa7xUFriPjmTL7MTyMtP3ASszmi5vShpJI7UHCAIZnbuwSPEsxwtWvq5KxbT7pU=
X-Gm-Gg: AY/fxX6cdgVo/dHBlsvppZPQHN4397gDd5V1VWD/UguKN4IgKbClZbxS+GkGW4z8p3C
	Ny3wenrywWOc9vWWpWX8QnvI+kQ7QL3ly2KoFmi3u7XP7LjiV3Hc2yl+OK6U0F4DS/3ZcSGCzlY
	ZIY1ZUqN3/m/sUhme/jcy7UGBgbJRo7wydNABPs2Ba3NJgKYvLB7ivTCQcmF1B1tV2wsfwITRC8
	aNMCDnwF7YBHE76EhLuFdchEq1PXE3Hu2Ms3OMlcajbbuqZTF9poQjUeTIPmzTgsO0zeYyzZdUO
	1Pmk6xVrAYPhfqnangYb166/12PYCohYEDMucxhXJPEC6En+D6/jSOal7cjBWu1lEwucKYgQbWF
	Re4740Rti8FuEcvWuR9+scW48zyCWNTsLBr+KdHI77FeXJ9v3kSqZe6RpL6pOgZk9Lb6UUbhbd7
	4l78qnsf6RnvU=
X-Google-Smtp-Source: AGHT+IHb6vE+ArQQRTtNqwUg5inIwqkbGh+qfMMrp04KiMX5PvlrDAyt2n3Z4/CvkebK9uzb37iz7A==
X-Received: by 2002:a05:6214:2f93:b0:882:3156:6180 with SMTP id 6a1803df08f44-8887e19d691mr221604836d6.22.1765921693872;
        Tue, 16 Dec 2025 13:48:13 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88987f398d1sm84265926d6.0.2025.12.16.13.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 13:48:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Dec 2025 16:48:12 -0500
Message-Id: <DEZYZTVXVGIO.10E92BXV43Q2T@etsalapatis.com>
Subject: Re: [PATCH v3 2/5] bpf/verifier: do not limit maximum direct offset
 into arena map
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <john.fastabend@gmail.com>, <memxor@gmail.com>, <yonghong.song@linux.dev>
X-Mailer: aerc 0.20.1
References: <20251215161313.10120-1-emil@etsalapatis.com>
 <20251215161313.10120-3-emil@etsalapatis.com>
 <0720a98e6a73ee6298d73b2c64a08f47a4337007.camel@gmail.com>
 <DEZTEJOJ7WF2.1VFDHK28XKO4A@etsalapatis.com>
 <4edb0de3c4eb13d276df8741c663e398ddde5708.camel@gmail.com>
In-Reply-To: <4edb0de3c4eb13d276df8741c663e398ddde5708.camel@gmail.com>

On Tue Dec 16, 2025 at 3:13 PM EST, Eduard Zingerman wrote:
> On Tue, 2025-12-16 at 12:25 -0500, Emil Tsalapatis wrote:
>> On Mon Dec 15, 2025 at 3:19 PM EST, Eduard Zingerman wrote:
>> > On Mon, 2025-12-15 at 11:13 -0500, Emil Tsalapatis wrote:
>> > > The verifier currently limits direct offsets into a map to 512MiB
>> > > to avoid overflow during pointer arithmetic. However, this prevents
>> > > arena maps from using direct addressing instructions to access data
>> > > at the end of > 512MiB arena maps. This is necessary when moving
>> > > arena globals to the end of the arena instead of the front.
>> > >
>> > > Refactor the verifier code to remove the offset calculation during
>> > > direct value access calculations. This is possible because the only
>> > > two map types that implement .map_direct_value_addr() are arrays and
>> > > arenas, and they both do their own internal checks to ensure the
>> > > offset is within bounds.
>> >
>> > Nit: instruction array map also implements it (bpf_insn_array.c).
>> >
>> > >
>> > > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> > > ---
>> >
>> > I double checked implementations for all 3 map types and confirm that
>> > the above is correct. Also, I commented out the range checks in kernel
>> > implementations (as in the attached patch), and no tests seem to fail.
>> > Do we need to extend selftests?
>>
>> I forgot to address a couple selftest errors from this patch in this ver=
sion,
>> but after fixing them for v4 and applying the attached patch I am gettin=
g a
>> couple failures - direct map access tests #332, #334, #336, #337, #338, =
#345.
>
> Uh-oh, sorry, I forgot about test_verifier binary.
>
>> #332 (write test 7) is an unexpected load success, while the rest are ab=
out a
>> mismatch in the error message. Maybe the test wasn't being marked as an
>> unexpected success because I hadn't fixed it up?
>
> For me it shows:
>
>   #332/p direct map access, write test 7 FAIL
>   Unexpected verifier log!
>   EXP: direct value offset of 4294967295 is not allowed
>   RES:
>   FAIL
>   Unexpected error message!
>           EXP: direct value offset of 4294967295 is not allowed
>           RES: invalid access to map value pointer, value_size=3D48 off=
=3D4294967295
>
> So, seem to be an expected behavior given your changes?

Yes, for v3 this was the expected behavior: The tests used to trigger
the old error msg (in EXP), but even after removing it they fail
because the map isn't actually large enough to support the value
offset offset of the tests ((-1) and (1UL << 29) for tests 7 and
12). The RES output is from the .map_direct_value_addr() method
doing bounds checking and rejecting the out-of-bounds offset.

