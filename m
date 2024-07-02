Return-Path: <bpf+bounces-33672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC769249C0
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F86E1C2258E
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02082201261;
	Tue,  2 Jul 2024 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UamMK0ew"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937220012E
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954469; cv=none; b=GP+aDK0Sia59CZSk6rfFa7EjM0q/EOPGqBjtIUQQGCZovhRRlzr2haIJK4Pnz1UzHgIph8eB/8smQp8+a5vjC1+hEfb3MstAIdMGExnCQ8iNev6W8O8QXQkpqrlSv10Hvbdq60swnTXr2WHCYx9/hNE5/RZ+tmIb/pJye2qPHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954469; c=relaxed/simple;
	bh=pcD1HVVPOS8NO/m7NA93FzMos/tQIKrKoubJttLGroY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A1XiE/XyUQMvp/q0qJ71z1mSbsG81RUPrAjfkSmKsgKc7CHrjmAznHXXa0/P41FCbjsgDRg9dETngx/pjKYmMW+TvVUxx+VSpwoRwTZD+WjhMdCf6PYz92prBQuw0+e+S8NTKJY9nbDUcO90bSEbqGzG3KxvkMbVOqGzwmGApPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UamMK0ew; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so3186926a12.0
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719954467; x=1720559267; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gbxVJnOQDnOCA0E8C21ktf8itiOYvvy0vh4mYz7dJqw=;
        b=UamMK0ew2gYrqfKH0Ri7DhME5Z/9ZIHqF026haIAC8/Qtg+xMSuEcvIYQ2XZjf3ruv
         PskeYiQx5/YPjX1836HA7qN5udeetAlqR4JY3SWUyJN77xnrSUnfDL0k6jW2KJ8zpcOz
         unFTdkqI4WlfKmoCnKes361bHUXwOWnuSkHAVI8/GHeEqSg2DsabQm9am196SCNzI9Vr
         isxCQVykNlV/7QRcVVUgP7FajwcXZwdb901S3tDWKFu/GQVH6t0ahv8qzwvAGZR1Kznx
         MuxQebOI3wfxgrgzYbjMWuuMOgZvIr1bBqsNz9vatX3cYZ9aU7oflgV6H4J5TA7ZVOns
         YKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719954467; x=1720559267;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gbxVJnOQDnOCA0E8C21ktf8itiOYvvy0vh4mYz7dJqw=;
        b=PdJfkQElUOKlozUuN3n2d7B1BF2hcKpWMf7NaaB9U7pLTxGNYvodzMF/eTr9Cttf/E
         elPzNoobhpo7C+xLMFKEnKYbf7PKAXsw5fyKxLwvmvjqoAvNvGy/6oFx1LUl5mtgV8Kf
         2YSl/AWd+s9FTYxXNjo4OY3N/jTz4xymNZGDdwUDzrmzL9HY6l/sm50Hx1wbU3Ilq1Vn
         hV2NiIKf08BvNcJ3E2FOhu+8Z5+NJI0f7LlHvUwQhJ13BddL2UuA+l1/lCuwDCnOF4cR
         mkyCdht9g/lyjPvmtAellrmwCCReQa9yBtcxnF5O8gx6ouVfvWk7o/ppYOm1tZUzCQhP
         Vd3A==
X-Gm-Message-State: AOJu0YxCxuK8RhriQTEqVuzWlpgp3W+lIUhxdD8OqYBNnoF10Qj/MIFq
	Q6G3Beobx2JPkEjoSnYl4QO3lHT67ni7qy8xfOOFE9EGGq/xG4Fy
X-Google-Smtp-Source: AGHT+IG9c3yvHHKVL1XZXXh1xJH5d4aW4JIs97CBWzIQ6mHJCo3v/DTp5tO5FiSTdX+F5z4KrSZrDQ==
X-Received: by 2002:a05:6a20:1590:b0:1b5:ae2c:c729 with SMTP id adf61e73a8af0-1bef611bcf7mr15316623637.19.1719954467432;
        Tue, 02 Jul 2024 14:07:47 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ae3a0sm9274098b3a.173.2024.07.02.14.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:07:47 -0700 (PDT)
Message-ID: <2cc3dd09ecaa7691c3606120c81d58a40251516a.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 7/8] selftests/bpf: allow checking xlated
 programs in verifier_* tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com
Date: Tue, 02 Jul 2024 14:07:42 -0700
In-Reply-To: <CAEf4Bzb1Bt+N7rKDrcgMSyo9=u+4qkD5mrWJtjwYFMg-ZsWrNA@mail.gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
	 <20240629094733.3863850-8-eddyz87@gmail.com>
	 <CAEf4Bzb1Bt+N7rKDrcgMSyo9=u+4qkD5mrWJtjwYFMg-ZsWrNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 17:42 -0700, Andrii Nakryiko wrote:

[...]

> > +#define __xlated_unpriv(msg)   \
> > +       __attribute__((btf_decl_tag("comment:test_expect_xlated_unpriv=
=3D" msg)))
>=20
> nit: keep on a single line? you are ruining the beauty :)

checkpatch.pl won't be happy but makes sense.

