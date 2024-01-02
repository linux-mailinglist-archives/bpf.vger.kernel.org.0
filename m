Return-Path: <bpf+bounces-18826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B75482256A
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D127B22663
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 23:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B47917740;
	Tue,  2 Jan 2024 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzauKm1T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54DF17995
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e80d40a41so7601352e87.1
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 15:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704237239; x=1704842039; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RyL02EeNc5kt3BgxBhQw4sG2VbFMNxTO19DKqVSUksU=;
        b=gzauKm1TQBZeEclyh8mvbfaajnZeFKzbeG+41SD+wj+mOiEJ1IZZmUQUc5SM9ypsgN
         j94etBQwYwLZfQbXcL5SzX0vtHHvVqpd7QcHTAL/+wR7rMd2Orxf5+9dt7gvafElmAlV
         RIe3nTReqls8RWk1/4Mi6ApVkMK8SuXf/L2vrGcqZfQ695AcYqSFo3l9pNfWIY/KHSTw
         fTS0uc649JiQ5dal6/XZua06T13aejoIcB4rEswBaR/w1KPqNqW+fCtEKVF1Cc3r4cxv
         25tkkULQa7eweDMs5Pmt4nqBhgnkaVU6yDUh94WmRhrGhHngtsE/bmHrshBxMoFDlLAM
         fmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704237239; x=1704842039;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RyL02EeNc5kt3BgxBhQw4sG2VbFMNxTO19DKqVSUksU=;
        b=M9LssyCmBVaArkQh/egpFa0HxwQKnqzLsn7EG9T8KcKMu/1Rhlp5dQmqeFXRxyf+VQ
         cgAU5CWe3VS2TksA+SPUr++sOSpTm72mEf3x43MRf34MoGPmNGZVL2ZRT2pBdbVJS1zA
         xehJQZSiP8DF12jhv2v0qOnB5dPT4TkRhMWeSujFvJUX63lk7qaA451tUTZmfhPflHVI
         K8JF7YQJvwIKBNMjIw+O83yc36XP/N/f5VW//c21XU3WBq+kxqQgFUXtP6gsfm1CWuRI
         39qaHvHgW7DY1dyzWKEQcXYofs+Fw5XmGmJm/dYuWA+pPyf9Uvgx61V2beMmOtK1MM0F
         Tuvw==
X-Gm-Message-State: AOJu0Yzcq4So4h/hKL4yBYpuEoG58g5y2LYuEiTHQVTFHNPjEGhMjXgw
	hLxXY65HpLoTnXEZ6FvH74M=
X-Google-Smtp-Source: AGHT+IFs5SbEpVUbqmj5aLx1W/91lzzR2kd1q5n7O0nEvuCWSNQ81RoXHecqNr+v4hFOtdbuXvo6qQ==
X-Received: by 2002:a05:6512:3b8f:b0:50e:7c9b:85da with SMTP id g15-20020a0565123b8f00b0050e7c9b85damr6682164lfv.76.1704237239242;
        Tue, 02 Jan 2024 15:13:59 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id wh13-20020a170906fd0d00b00a2684d2e684sm12180412ejb.92.2024.01.02.15.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 15:13:58 -0800 (PST)
Message-ID: <4e28b260c469164846abc26c1487f565fea98f67.camel@gmail.com>
Subject: Re: Funky verifier packet range error (> check works, != does not).
From: Eduard Zingerman <eddyz87@gmail.com>
To: Maciej =?UTF-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: BPF Mailing List <bpf@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>
Date: Wed, 03 Jan 2024 01:13:57 +0200
In-Reply-To: <CAHo-OoxanNo=0ppvq940KaUZBMBWjLyMgWCXCMfmyhMR6pmC2g@mail.gmail.com>
References: 
	<CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com>
	 <1b75e54f235a7cb510768ca8142f15171024dd78.camel@gmail.com>
	 <CAHo-OowjLmtEPmoo2rQ3i4_3mO0Uy6Sr9+pdcv2qCbahdVVgxg@mail.gmail.com>
	 <85731a963139eb226b76069a5422ecbac063dd74.camel@gmail.com>
	 <CAHo-OoxanNo=0ppvq940KaUZBMBWjLyMgWCXCMfmyhMR6pmC2g@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-02 at 12:36 -0800, Maciej =C5=BBenczykowski wrote:
[...]
>=20
> I wonder if JEQ/JNE couldn't simply be folded into the existing cases tho=
ugh...
> Or perhaps some other refactoring to tri-state the jmps...
>=20
> switch (opcode) {
> case BPF_JEQ: eq_branch =3D this_branch; lt_branch =3D gt_branch =3D
> other_branch; break;
> case BPF_JNE: lt_branch =3D gt_branch =3D this_branch; eq_branch =3D
> other_branch; break;
> case BPF_LT: lt_branch =3D this_branch; eq_branch =3D gt_branch =3D
> other_branch; break;
> ...
> }
> and then you can ignore opcode...

The code could probably be simplified a bit (actually, I'm thinking
about pulling all dst/src type checks as bool variables at the beginning).

Suppose Andrii accepts this change, would you want to submit the patch?
(or I can wrap-up what I have).


