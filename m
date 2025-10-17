Return-Path: <bpf+bounces-71242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8384ABEB3BB
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 20:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2504519A7030
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 18:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C6932ABEC;
	Fri, 17 Oct 2025 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2OF7ekU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D071257831
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760726105; cv=none; b=P8PSzVvgILHFCcgDjjp0uNiWgyP+Q7uyCJRw3E4opaXSo6jVjOUk/bo2bnNN9CVmZAOEdcOsXIO5/VziuS+XPzKrafp3bzqECpQJaJyxSrAZ1NMYpbgVEkXMACGBurD0s1F7By3yneEm8VuNpG1zr0GF6iwdyFq23BmUrmK5IA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760726105; c=relaxed/simple;
	bh=0iENiZzbTb8uCHs4L3WUEMSC5KFtIxyYIKH9TNR6xqg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iCCdHWovysrG7HUNeOkR6GCAdmOO033baLk9oPeqoFtgWtCvuDTni0luKBcWfSqUhMYMPtBDuZmf8oYxxJ7jUWkUpA+3IvA+mZZvqlKwH9FJJKx/IcC3WfufUOyUrEXYL9sC5Vh0IJ3cSEZ1qyEA6l7SFya5udGsZXydS/nJSeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2OF7ekU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6a73db16efso364992a12.3
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 11:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760726104; x=1761330904; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jVHajBjNul9kCyYgDzM3z7MQYUrB0pEh+1Pm+YJOmg0=;
        b=C2OF7ekUsn/i7LRon6Md3WQW09rs51vNAvVui2IPCKpXL1QjFFbJB3iscjMlO3RXHd
         yRZNcGrD9kZqw+2RfIeWNfiYYo5fW/vZKPIX49x3XSIOE600GBv1UYX8RdL2HXQHAfXu
         QE12/snpBRrZzXWebhqHsZMkxKg17TGM1hQWr0LdVDrKWhEjcfLILkXfCXX4entEi+Uh
         u1G/+QvhA/Jio+LDR1rFrtn+OdjPBYN8MXYMemIOInyOmuvtaSLDqeiL2qHpo0igbZip
         8VXc0qKcEMT3Te+f+Lgp5sOLvuEl2zjGkmkDC4XqPu5v3HO0xN8xVgEOeYB0jaAfT0FB
         R27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760726104; x=1761330904;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVHajBjNul9kCyYgDzM3z7MQYUrB0pEh+1Pm+YJOmg0=;
        b=teAH73LQcIMO5a8o6WeChJdU/teU4duO0M2pcT7SMbWKhhTT0qiuC6awyi5c3jHXGO
         3HWpaRXd56JYc3rrgZ4PCLEooCeqcyfuDpOg/OFRNCg8bP1SJaw4KyKyj64xdrFgzy6h
         sP42mhsJBdKw/jRU++sNpzGf20cEzsDYN/Ko7XRkAUuH0bpFQKLQpF182Cqpk+Z4tcCs
         08fkqsIRaIv1ZjicRfWYmRP9lG3fBs1bT3p/quKnJ3nfw8yb4mInj6VUeYHhWS3DNkBA
         Dn8pTI9DwYBKZMOV2+5M4FFSl64nLfkl1u+3eGmcqGBId88MkYxTtL8Szqo6YJMDuGmS
         kPcw==
X-Forwarded-Encrypted: i=1; AJvYcCVT/QDxOLRdJWNkuqpP+Zom+sc1j6GKmvF5JI5RNmTLAQtdqBS6uvJ8yEoUP9cOqAxxYnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxinRPt/I0OMqugvE7EmtvbzeGm7+jQocxy5XhOOxwQQDjkSPQo
	mL662rF5cO6LOpOr2us9mnkb6O69x9aUGu63W789MmkB03QNBs5B/MzxtSMUNRzA
X-Gm-Gg: ASbGncuU/cjFI94UPyJ6+/umR8yVEqrY1EBTgU2BsopGaS4RbVcD55FPbX09qwgWIua
	Nk0nKhsOGDqSGW4ny2QBCE7RGqTXVihqiZwOX3PszwITju0D12UtswSutwBvEw7SahWM2IczxRo
	ThYeONLUe9dETv/nF4ny7/IW9QLOc1ahmdhZgY4YtMxhpP1FMsMULqgPc6TF5/fwx7ubUsd+K1E
	adJy8zSMfSoxE0qe0M1fDUTXFZd+UURtaeDUOS16QqMHTbEuL8CuQbXfXjssxz50F4EeyxGtgnG
	ZDA+YR8szMuAOe73sI+ZsPEvu10SaXjtLxDQTCsy7OlJqgo8mpHU1WKuFiXei016vEC7+t6qWYY
	Y00MO6yK7Nh/KF86L2TY/gJYUdoNHuaeEM8JFia33r5U+kaOKgG4qM3wo7ocopG7hb5nkffg7gm
	VzMwkHJ/XJTubSUMn1v6fRtBqr/nAvSWwdfLE=
X-Google-Smtp-Source: AGHT+IG10SBFAdkKBLa9w4hlpw1/z+tbgXpJDoQoG1IqvtkQeZnsY1HOoq/0era33ekF+hysQ2Gtiw==
X-Received: by 2002:a17:902:f70f:b0:290:2a14:2eab with SMTP id d9443c01a7336-290c9cf8f2fmr53038885ad.11.1760726103554;
        Fri, 17 Oct 2025 11:35:03 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:49ef:d9f5:3ec:b542? ([2620:10d:c090:500::7:77fa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5965sm1919125ad.75.2025.10.17.11.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 11:35:03 -0700 (PDT)
Message-ID: <42bc3b8552fa2dec468747fc3e81a6b011222b84.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix list_del() in arena list
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kkd@meta.com, 	kernel-team@meta.com
Date: Fri, 17 Oct 2025 11:35:02 -0700
In-Reply-To: <20251017141727.51355-1-puranjay@kernel.org>
References: <20251017141727.51355-1-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 14:17 +0000, Puranjay Mohan wrote:
> The __list_del fuction doesn't set the previous node's next pointer to
> the next node of the node to be deleted. It just updates the local variab=
le
> and not the actual pointer in the previous node.
>=20
> The test was passing up till now because the bpf code is doing bpf_free()
> after list_del and therfore reading head->first from the userspace will
> read all zeroes. But after arena_list_del() is finished, head->first shou=
ld
> point to NULL;
>=20
> If you remove the bpf_free() call in arena_list_del(), the test will star=
t
> crashing because now the userpsace will read 0x100 (LIST_POISON1) in
> head->first and segfault.

I tried commenting out bpf_free() in arena_list_del() but the test
passes for me even w/o this patch.  Is there a way to modify the test
case, so that logic of the list_del() is checked more thoroughly?

> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

[...]

