Return-Path: <bpf+bounces-70286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 623E7BB639F
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 10:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5F419E12FF
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 08:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4870623D7E2;
	Fri,  3 Oct 2025 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E30uBSAk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776292746A
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759479350; cv=none; b=XNr9N+1aBDmucUOD0G0PvigtZYHReV7e7Ga9hYJ/mR3RZSWrL+sCN0eT26PXzhoQpKNeTq82CohzkQcsTRot9kYypi06NFVUGyZc7Vurp49xX/V+U6OdIycFBJyWXceFKjZbPKlvsDii5UObiAk+X9OkuABYCsVb59PXIA7nJEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759479350; c=relaxed/simple;
	bh=LhVOlXGxLSfc/w6W56itVFy8IP8Ikru9Cd4wmDY7TlA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HIZ9LCqRt2+wFDZfrpBjs83kheCG6EaKhpHTDPDKS/As3aHGR4l7Az4lR2RK1UR0LkvqQUrn8Mm/J7d/xKbn121JIv753yWn/Y0NqbIMMkwVsZ/n5Qbk5dSuJ1omYpZeb4QqSabEE8qT52zYSfvuWtvgdKi59cK2S6FS1JfjP1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E30uBSAk; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7810289cd4bso2017826b3a.2
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 01:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759479348; x=1760084148; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hYKers38yBOcfC5oEQozzjT/UCTlPziesz2W+nLe4/s=;
        b=E30uBSAkMmERJraPl3meWmORa8O6w6as57AmjUuWdIE0mE9Zxe6Q/f/m6mVAvlPK5J
         BBqjl7gMGOxKoSN1mrOdpshL9Dzd5byPoi2NYNeV9768ASvsI65DRiEC9cVoO9vwDpWP
         +6w+UOvSn4XcWFW6xKzbQOAIOq2YNz0UAs3vjg+Q/sTtJSuu1faJWwh5lZn2gjGUj/VW
         zX/WYgRoPGNOOIyqvz/pMaTeXSNxVH0LrhhrH122zoCcVc4wd6JxMi4VMY8o3Q1xgaLy
         STsCKGys1JSRZKnSvKWtjgQsOqre+Qqa/qNebkXDiUZtwGbOhxjN7ryrwwVL/JQYlHQG
         LQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759479348; x=1760084148;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hYKers38yBOcfC5oEQozzjT/UCTlPziesz2W+nLe4/s=;
        b=XKd08iBw9xiA7aPWmnZCvL9deW/6hKUHnn4RcbR+mva4ajCr3S3yvv1ZtVDGxQETL0
         b4kMU8PKz3a8Png/0/z1gNFqTXy0SqFBVasvrzYV2F+prq+9Za4FER6Wxbh1zVHBk1JJ
         RCmAs3QSxk8MrYk6+UiiliNP2CXlzlw1zeFoCfdyoTtZOGROjQspLqPhKMTZTlYNiXMC
         IdQvbtVJtHFtkk258WhuzyfZfdqvfWmHMgKXESPsLtQ+TqAQ6bfGfOkJSNoia46QJYMP
         I5FtCvZdLtI9jZh2h94+UHyZG6wsHZ805vAE0fqo+S5McWPAs4U+PinWzBbCXjXCueVZ
         oS3A==
X-Gm-Message-State: AOJu0YyR3LIyNQbcfrEP7SVvfcs/SeSxrsWdCGMc0fcoylJrZCUDJB3f
	n1KbGYSuZpqse5JuRrwDy3ZYtolJD20Tvtu5/6TnMSdON5JPmj2YODEt
X-Gm-Gg: ASbGncveZ/aw6JjDDWcFHlwBEpLa2F/ct5t/CoJueoXDL7Hqoy91yjgz0XdRu/nEOAi
	QUUhg1RKthEb8KTvtemeyie0fU1fjmFaXMpuL61suUKJ+J6bT0WcC2v4kdxMFpGxZI++FxI22vR
	dau3s96sz986/dw9Yuld4ujq5hByI9PxmZek3GZAc4YCFxxKOPzVaPrAokp+xj6n9fm+x5PiOeF
	UJyUYGle0ci6R0cIoebTh7wdefHtpByczOrnBeZTxxUQ5GHNhQ9ushJyFr2aPhHRXk9bji9Suyi
	SBd/a2Ym43ubC9QJp60dK+8t0EzEmjxloFTU4hTpsFG4K3trEqRPzRQi0N1wm75Qy6FweIMu2Rb
	7mpydFoc4g9m9V0BO58o4FZnyyK8XvITv8Ta7QSUGZEzlt+7UXXdfdWTDpwP9jbLd0Q==
X-Google-Smtp-Source: AGHT+IHGviyeXfWApmOt6vP/SwU6XV4KbFZwsVbh5qZakVz3YaE9i9S3SLY4wm12EvfLXX2MOVlNkw==
X-Received: by 2002:a05:6a21:32a8:b0:311:f99e:e7ce with SMTP id adf61e73a8af0-32b620feaccmr3162416637.55.1759479347630;
        Fri, 03 Oct 2025 01:15:47 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9ac7esm4265513b3a.7.2025.10.03.01.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 01:15:46 -0700 (PDT)
Message-ID: <d40e3ab390621a234135b7fd43d9d00baf5abcec.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 05/15] selftests/bpf: add selftests for new
 insn_array map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Fri, 03 Oct 2025 01:15:44 -0700
In-Reply-To: <aN9/XoodAYHN5Lm7@mail.gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-6-a.s.protopopov@gmail.com>
	 <b7ed4bb22cd73006f761888305ed7ed2f70a5071.camel@gmail.com>
	 <aN9/XoodAYHN5Lm7@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 07:46 +0000, Anton Protopopov wrote:

[...]

> > If this test fails, debugging it with -vvv would be inconvenient,
> > as there is no way to see xlated program. Maybe extend load_prog()
> > to check debug level and add capability to print xlated?
> > See __xlated annotation implementation in selftests.
>=20
> Ok, nice, will do.
>=20
> Just in case, typically, when I write selftests I add smth like
>=20
>     if (getenv("HANG") && *(getenv("HANG")))
>         for (;;)
>             pause();
>=20
> before destroying skeleton, so I can examine what was loaded, if needed.

I mean, yeah, but I regularly find myself adding options to print
verifier log in selftests that are not within test_loader framework
(which handles -vvv uniformly), and it is annoying every time.

[...]

> > Success test cases follow identical pattern, ultimately having 3 input
> > parameters:
> > - program
> > - map_in
> > - map_out
> >=20
> > Would it make sense to write a generic utility function accepting
> > exactly these three params and hiding the boilerplate?
>=20
> Will do.
>=20
> Are you ok with the contexts of tests? Any more test cases, maybe?

I think you covered interesting cases.
We will add more tests once bugs are reported and addressed :)

[...]

