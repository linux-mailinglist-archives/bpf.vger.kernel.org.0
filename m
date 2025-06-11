Return-Path: <bpf+bounces-60300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DA3AD4A63
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 07:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6583A4254
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 05:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A8C2253A4;
	Wed, 11 Jun 2025 05:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVNFubDV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F147317BB6
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749619432; cv=none; b=aREecfX4CtZTWPnJmMoZo+o+UuR8ldhuFhJ63Xx2CLNfzSj8NbxrzZUgivlNbtYNLY0/koRggRVzckgCdJZYYZ603TZ9E5oUVmI9bP+7gJPjB3Y4Zkor3VMNWxfwEu5CcHNKQQ12D0a2R6rcenciw2X7CLvYww1vw14mudO2Gxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749619432; c=relaxed/simple;
	bh=zOmcyg+pUs/ogdgfn/R1e1FclruaAMkCvgsc9YCCf9Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nH9xMNcb2CoZQdObFO7sBeMfMGuKJ7V5m863nxxIj+KRRilGhj9EJmRdubeCo8I47VTlhCd91LMYQRSIJ+RYDhB8BwtdKnVMhalCiyDI2TPqMzgxkZRqon9rtZP2/dFaB05dYU/Js3SnJ9Ld1r+wyV1Hpl0PvUYnt+DpbHN9gIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVNFubDV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-236377f00easo20100025ad.1
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 22:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749619430; x=1750224230; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YPTeK8aSQJIhjLkQZ7HE4k83chR30nEdMZU7uow+gf0=;
        b=VVNFubDVhm+QnokCDr90Y8fFLG4c6TrgBjK3apac6ph63oWaf95CZve0YCyt80rTjV
         4pM7yBVQh1IUgG6GersAymXVWpqe18qxerMcxDiiOG8YSDAk4OaUBfMYCsPaxERwffuS
         lEqjJtmfqWjtzrZ/dMLKLl4Tr7H8Bd01+yQ3ru4QY297TeMizs2TcOItl1Uyh0M8bXjG
         fhRc7DdLzxozFmDhfW2TLGeb9CD+Sx4lS4ZhK2JCVFPrR65eXuspwlv8q9+065xl7p0D
         qIeizqzJGQ9djHWpfXyHTPQ7LDp2LhWZ47b3m1kIrXfKKksLdMavl6VplFJ71+cAqmlb
         o7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749619430; x=1750224230;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YPTeK8aSQJIhjLkQZ7HE4k83chR30nEdMZU7uow+gf0=;
        b=ocR/eIq5up/j0RudFAFEAIYg1RnXVsu4LpJ77k1JrnjkmCThOwFogCm77XqYhCVSvL
         iWPGr/jCDJv4rO+m+cZDna+DZwiTcxIMMFW5lj6Dhka1YltmKNJitKgVhF7OgXrrQt0J
         rRKw94vQVptxY/ETqm1W3AQiaOhsSnD/CH3pOgSnvGR75TWKHqrmyuV2HPy+q9rF7s4+
         ylgRJUaIO3ELlFCmHxYlaa6p3cbkC7M5X5pSQlEtZTnyyJQs9PhnzSmh1FtENYYbQIrE
         9Jv//OYndkJ+DXFrRuTnRhv7a1GmRFQMDmrLawnOT+jqw08vZ5YVUJCRUb9WhnuCQW4X
         l9cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUdP6QBwL8XpbA1/5smKm6Q1SuIXqpVvPD2JMYOOE/5lSLcANbfjgOhjwoE9Qu+6B1aFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK1kan8HWzG8jJPjDeeF528CCsayp7pFBwFXdp9BAgZdKMcpkF
	c/CB0aVvZmtEksqp6lhEHpxWmeSPJ01hAy8jjoxDn3NsbieB2Hnu8/Dl
X-Gm-Gg: ASbGnctLKCD/p0B2zfs8HQ8O5GqL8Mi99nR91E/5ExIYb+W1QlR+YUSWnuGJ/Q5eA1I
	AWezP+dojt+/Pyh29pX0rzjRLtxaopvViuDJqf59gm5PG2ab+BJR1f4c7fPu+7IQ2yyxsbqt6O5
	MWRNNWHRFulwm7n7eIHcf3iahK+nn5uplmoR1WBN7zCXQqqpjSEkBXtxBnlxXtAmQ060cP+4ihW
	k5aGdTYEx7UPq1nGkWyJXHeozZBYXdcY54hBa0ATlFGHnkTrGPG+7mZK0wTnYmFG+ci92Wn2JRt
	T2dzuhigOCjhOI4vFQXSRowYA80hw21BMOpovNtVwuttfkJpYurQCyYSUic=
X-Google-Smtp-Source: AGHT+IFiGGEaMLgaa32gPws1+QDd9McRh81QysBF4oy84pdgW3JiSNb4VLs7LDtnwxatVhyUd3lCoA==
X-Received: by 2002:a17:902:dacf:b0:234:f4da:7eef with SMTP id d9443c01a7336-236426d6cfbmr21123285ad.52.1749619429974;
        Tue, 10 Jun 2025 22:23:49 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5f66a88dsm7669933a12.40.2025.06.10.22.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:23:49 -0700 (PDT)
Message-ID: <1764a937e91b80c922f6189fa4706fab42364e06.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: support array presets in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 10 Jun 2025 22:23:47 -0700
In-Reply-To: <4ff2fafb99131f599901580eac96dca34ca20cc0.camel@gmail.com>
References: <20250610190840.1758122-1-mykyta.yatsenko5@gmail.com>
		 <20250610190840.1758122-3-mykyta.yatsenko5@gmail.com>
	 <4ff2fafb99131f599901580eac96dca34ca20cc0.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-10 at 17:45 -0700, Eduard Zingerman wrote:

[...]

> I applied a diff as in the attachment, to see what offsets are being assi=
gned.
> Looks like this shows a bug:
>=20
>   ./veristat  -q -G "struct1[0].filler =3D 42" set_global_vars.bpf.o > /d=
ev/null
>   setting struct1[0].filler: offset 54, kind int, value 42
>=20
> Shouldn't offset be 2 in this case?

Nevermind, it's an offset inside section, sorry for the noise.

[...]

