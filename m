Return-Path: <bpf+bounces-30761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D690F8D22B5
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CAB6B20BFE
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 17:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2347E27469;
	Tue, 28 May 2024 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AzY1gH6j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E58024B2F
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918181; cv=none; b=dSfz+bLlEl0K2iBwIWxblKkXLmH2N8pGOeuquB9hfVLEbRvEIqnYQwgWzqGu7BQSNkoQCemSJH8tpQujCyxlwFchqTCHN7PiSI2VVKhvJLCy7zxX8IC4ToFaLsHJRQ/ls0rszru3R5FZDJ/HCIlQF7u/8Av29fWVEPWE6FhpIho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918181; c=relaxed/simple;
	bh=GY1vFONspZUvAkJaFkIkQ8lXaYwEc8UEiUXSIPAusFo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=fMzuNxH/XEEwWxC8SKaMI1fpIdBrp6gJBEe+Bd3VnoKPp/tsbaDi2VOi2yOJYYmI3a3C16SlwYf8jO3djx1hh9sbRyXL1dlQ63ihaCgUZxO5nomPraJwUhLtDnD2kTPP311GDjR/40xRs7DaJWAvs+0N78lwYDHj6W/VGDhN9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=AzY1gH6j; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f6911d16b4so917177b3a.3
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1716918180; x=1717522980; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gMPlZrZg855cDMa8KIrlF2/+VDUcW37pXNgD5SWIQ4Y=;
        b=AzY1gH6jJ+xcfuIB8KFXXdic4xA2QZQm2Mgngc4g5pupATQ+4p+c782VTZ/020+EmV
         Cmbo/PF3tAyiZFbdCEw8z8lJAgIJgtKTccpLM4cIiBMEuq2fdnEaKBiKbziZ7Y9lto22
         iakXLrufIscHh4C1f5v4dYT5EuJkUjZy4vahjTYRq6HY0DAgspDB2nWuAsP01LbxGIzX
         n5Ac7UKQzqMM+4r13KhKXXOn36zeCLUDeHLp16c31waC5ndQSCE39kTSdt/A7xbQqtlb
         F7P0MWCiZWigVMTXeuQyRwyDAXUgIWq2qu8oQ2D44NZv6KtTdXz+DoquxK81NZHWAcZi
         yxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716918180; x=1717522980;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMPlZrZg855cDMa8KIrlF2/+VDUcW37pXNgD5SWIQ4Y=;
        b=Bbh2yYurjNZ2e4Qd31FvjUY6m79EEAaV3xhlq9Iazo5IIvKcs+qtDG005fhcmm99+A
         gmp7fhKvYctaWDt1GG3i9geTodI6SsJnkfAeWM9me8QQQyyxqhqnbsHVBc7gvVcmE+CR
         5km47FEUzoqk5ZIMLbilC+KMaeBlj6MTQQAY7dY2JldAm4UqcRpxemH387SLtwKOfuSj
         MY1sBI1nVqAS1M4hQVg1uarSvu7YTMjioLJgIU5LoTZpeDPrjXL3bq1MTowtidY4bfiB
         9/RhcjAmkAMD1AzW0ctNMm9RPUrFQoxU+tXn9QZwghxxdumoizuJ7MQjxk+K57ZR6ViX
         7blw==
X-Forwarded-Encrypted: i=1; AJvYcCULIRZNULBi+dc0og8emoP3vMwc+rvn+o9k0r9HhcW2ZJITs4eimUBH8G7LFG3Et8T+jbDIpkm/oQ1Rq/NjOnBjOtIV
X-Gm-Message-State: AOJu0YytGxSwE+lnurRjxJMVigmN2iaQuUeat2Q6cQ1j00tSQ3kVuIj8
	iJKGwGoTeiIPxIE8tEVRoBXxjiXgy/N5fULYYC+KMqt3NlN/guWa
X-Google-Smtp-Source: AGHT+IHqBHvhrwhDzjoMr8Ep35e894mqrFqRZigAjbv82pVtqugZXkbRyOR6aP+kQL2M/7AR9LFgeQ==
X-Received: by 2002:a05:6a20:8404:b0:1a8:4254:5cdf with SMTP id adf61e73a8af0-1b212d2a5e3mr13444931637.22.1716918179565;
        Tue, 28 May 2024 10:42:59 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6822092f45fsm6652362a12.9.2024.05.28.10.42.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2024 10:42:59 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Andrii Nakryiko'" <andrii.nakryiko@gmail.com>,
	"'Shankar Seal'" <Shankar.Seal=40microsoft.com@dmarc.ietf.org>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <PH0PR21MB19101A296E6A180AD99EDD3898F12@PH0PR21MB1910.namprd21.prod.outlook.com> <PH0PR21MB191058745A71A705F199B19A98F12@PH0PR21MB1910.namprd21.prod.outlook.com> <CAEf4BzZf=7Sb9Zf7Bt_oJh=Pq6b=03wspmr8iJSY-KRyJVZ3nw@mail.gmail.com>
In-Reply-To: <CAEf4BzZf=7Sb9Zf7Bt_oJh=Pq6b=03wspmr8iJSY-KRyJVZ3nw@mail.gmail.com>
Subject: RE: [Bpf] Re: Writing into a ring buffer map from user space
Date: Tue, 28 May 2024 10:42:56 -0700
Message-ID: <0c4801dab126$7a502fc0$6ef08f40$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHl5GiPScCT4J9LZ8tQH7TdFBakVgIm+6NAAnaUIquxcZcd0A==
Content-Language: en-us

Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Tue, May 28, 2024 at 9:32=E2=80=AFAM Shankar Seal
> <Shankar.Seal=3D40microsoft.com@dmarc.ietf.org> wrote:
> >
> > Adding bpf@vger.kernel.org
> >
> > A common use case of an BPF ring buffer map to use as a queue of
> > events generated by BPF programs that can be read in-order by user
> > space applications. I have a scenario requirement for a user space
> > application to write into a ring buffer (or similar) map, such that
> > events by BPF programs in kernel and user space applications are
> > interleaved in the order they were generated, that can be consumed =
by
> > another user space application
> >
> > I would like to implement this new feature in the
> https://github.com/microsoft/ebpf-for-windows project. But before I go =
ahead with
> the implementation, I wanted to check if there is any way to =
accomplish this in
> Linux today? If not, is there any reason why this should not be done?
>=20
> Yes, there is. See user_ring_buffer ([0], [1]).
>=20
>   [0]
> =
https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf=
/prog_tests/
> user_ringbuf.c
>   [1]
> =
https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf=
/progs/user_
> ringbuf_success.c

Both of those links go to GPL code so I suspect Shankar cannot use those =
links.
I think the answer is that BPF_MAP_TYPE_USER_RINGBUF is defined for this
purpose and Shankar can read https://lwn.net/Articles/907056/

Thanks,
Dave




