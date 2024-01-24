Return-Path: <bpf+bounces-20158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A098A839E89
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 03:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71AD1C235AF
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 02:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2C17D2;
	Wed, 24 Jan 2024 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="B5/fHKkk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E715C4
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062084; cv=none; b=CbfJJ8M2wBH3DrOruMbCoaTKnL+bt8nex5i6bQCYq+gg+VZ7BrWNk7e2PIT9eqNHecXcedxXDCBHsPZAzDwOAn13MFecD3rOs7xqEUrn/zga2q8H6czPOrGBNH667ymYup+1VFKHUdxh3zu9MMCcBNS/RI4pZb0WLKZ0SeDvjzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062084; c=relaxed/simple;
	bh=ORDqmNyoFiNfL8xBf2GJYatc3BnkgRqqdKYZIsEvWdA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=CphNJnqGOieeR3RLDUnL7tLFvJo0BmtnyX8jfo9CbQbU3NYw1MdI9H+PEVn0seBopUs+fxK8Tr4lP1N7QMlnHXbwpdb8cD3DiIYFgQS//HpCkAkv8506kn/kG2dDXxpYuXAY56MR7L1N+4qc8/x6BOSEGseb9PYco28wWx9Ba/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=B5/fHKkk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d7431e702dso20883495ad.1
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 18:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706062083; x=1706666883; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/XBycsmOrT3bPgt7CXEBezh1Q8tlHI1tmL3p2LUsFeQ=;
        b=B5/fHKkkktHyvbdZ26YB+DHLqHQPatLqdSH20BwTSOzm6Jcj9LGW5FisikvBqXArTB
         ZLGvYp+VuAgwMPlvbWAJmCbV4LAwzFSVVVe2Yz0l4nwU4uabtx+QMNmB5LKUZ4wRk78r
         v7jqwz9YuKkdtdEkXRcsbqDxscCSKOklXqtbffAku7O/gJs71GLFF7JVqr2Bnob7fRz7
         Ko2FpctJK542N7BYmEowJvAtGXQEBm1AGhNBzYqn1ofpRSsxDXBvuhoNmnLkbxN5ZLDV
         zTROZXlJ2cHluCGuNUhKwNg1cHRXV01tLG6Lty3YAaygAB4B/wwtSVhcFOPTDozdJKwQ
         HnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706062083; x=1706666883;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XBycsmOrT3bPgt7CXEBezh1Q8tlHI1tmL3p2LUsFeQ=;
        b=JPP3FTVBNxHOJ9ecbOGREGxGMZIHLB+n7nFYiRlvV1JrIQNnpdb8zCmZYIOs02h+M+
         XI5jiOhfZVf7uHb3uHYouoJdGc27nopJxE0RhAv4Z5pZzQ5BkXzcxydoS3pQ3Pxxztd5
         rwYAL/B0j2SC9nUmvGDC46ZsuuysRpetgf22uEEJyHfaS+3skY2EmAKG/pM2fXqZn5Uk
         kjlVHTjY5RewrUPWR9nuykin+CPlUkeVDv7JRmg+I7qlhT+jEX2aeoD0Nyc4FsYeQuk8
         RG20rpKJVNznD72VvrBXOhKjag2/lmJWyxT4a0NaM40HZm9RAE/0LtX452BPYpjzgMBM
         o1/w==
X-Gm-Message-State: AOJu0YwTk7cU8FOilYTlqkMQ9lwQHviolPZXKo/ZwTd55eSpVDJyhMMV
	j1I2lanxd+KmXOONIGQqpM7fFKeqckAbD85HtVJZ1MXuwOYW6CxCtgVEMdg4xDs=
X-Google-Smtp-Source: AGHT+IFBrU/DdjpTF353OfC2q068MHkFzjYadPpIr6jKXMcF4yamv570KZBeB1h/DKECir6y8mixNw==
X-Received: by 2002:a17:903:2289:b0:1d7:7d1a:7697 with SMTP id b9-20020a170903228900b001d77d1a7697mr149527plh.68.1706062082778;
        Tue, 23 Jan 2024 18:08:02 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902d04c00b001d73416e65bsm5714924pll.63.2024.01.23.18.08.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 18:08:02 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com> <08ab01da48be$603541a0$209fc4e0$@gmail.com> <829aa552-b04e-4f08-9874-b3f929741852@linux.dev> <095f01da48e8$611687d0$23439770$@gmail.com> <4dfb0d6a-aa48-4d96-82f0-09a960b1012f@linux.dev>
In-Reply-To: <4dfb0d6a-aa48-4d96-82f0-09a960b1012f@linux.dev>
Subject: Jump instructions clarification
Date: Tue, 23 Jan 2024 18:07:59 -0800
Message-ID: <1fc001da4e6a$2848cad0$78da6070$@gmail.com>
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
Thread-Index: AdpOaiE2G19UI2d1RC+MLdhE7be0bA==
Content-Language: en-us

Hi Yonghong,

The MOVSX clarification is now merged, but I just found another similar =
question for you
regarding jump instructions.

For BPF_CALL (same question for src=3D0, src=3D1, and src=3D2),
are both BPF_JMP and BPF_JMP32 legal?  If so, is there a semantic =
difference?
If not, then again I think the doc needs clarification.

BPF_JA's use of imm already has a note that it's BPF_JMP32 class only,
but what about BPF_CALL's use of imm?

Similarly about comparisons like BPF_JEQ etc when BPF_K is set.=20
E.g., is BPF_JEQ | BPF_K | BPF_JMP permitted?  The document currently
has no restriction against it, but if it's permitted, the meaning is not =
explained.

Dave



