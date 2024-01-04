Return-Path: <bpf+bounces-18975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 423988239AA
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 01:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D431F260F9
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 00:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6010380;
	Thu,  4 Jan 2024 00:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0q8uYBE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E040836C
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d5f402571so77723515e9.0
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 16:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704328110; x=1704932910; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OpJVJAY4IHnH36eyppLZb+SRsSXdonY7vjAGBjCZK48=;
        b=h0q8uYBEIYf/bAgPFGWSksP2m7g5ZBR3jLhSpKmWchmRUDd2EBasBtAKLKHkKs8C/k
         0v8Z67Zml60tKK2OD7ayHsGHTM6V6vzGsBV2PxYC8cdStOzlH9Er0UQaKLGXT5GlHjWs
         lc4HDeRJS2kCAxoD1QUkVA50XLIXSn//HpEAsNNkg99yNbuGdHY8zrOFZB7Bc8qBSQY0
         TV4dUwhK9YLkHSLtQxt6CZ9So6FqEC5Fe34qawBFN1Cx7IRfEY1oe6VtSKSNk1J0Kg0m
         DJ450NY1kf+IRO1Oyiu5u7S/+JZM37KidaOl0O9SwuD/3A8tuNqK3A1oOTUiFUrW6CqD
         Q2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704328110; x=1704932910;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpJVJAY4IHnH36eyppLZb+SRsSXdonY7vjAGBjCZK48=;
        b=vxPRCh9NZ3NrLDuvRbpPxsJWA4sJfE5622VrEAWsw/FGuq+ldLWwFzR8VZiCd8aZlj
         cVgjFqpF/z7ZdNj7hw7UwE3noejJc8LH7XMePOhpgYy6e8IyOn30c4sJT9LLpkbNjUFx
         7+VYqMub2z/O9740no7MtC4aAiPNnJkwGQW5mN46jnc0BSnWkurR35gEvbIGlNR/20jO
         XlmZkB/ZbPbfNBQlI5ipGgKgbhcNWQChcgRcgK0Gyv1Nphgx9XxFlCNtnESwNyNp0iCm
         yuRhvzo9zjhmk0RbckPr0aJGWhMO48OIW+npfcNqiNTvShfPIQ3Y553Yng8egctAQDCP
         t2ng==
X-Gm-Message-State: AOJu0Yx9WdapidY2MDDN8kbHkUX5ARj0LEnXf0g3OM35VH03AT85oH/B
	nH6eSD0FctT1sb5K1oDxz1U=
X-Google-Smtp-Source: AGHT+IFvPJUVov81ev6b7BqXq2tR4oLG01SDur7OTAnKh7ubLsSka+NjhjPmA+Q58/HRqz0XNm498A==
X-Received: by 2002:a05:600c:4da1:b0:40d:3c4e:a5a4 with SMTP id v33-20020a05600c4da100b0040d3c4ea5a4mr10244706wmp.96.1704328110026;
        Wed, 03 Jan 2024 16:28:30 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z16-20020a1709063ad000b00a28bf7969cdsm378873ejd.180.2024.01.03.16.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 16:28:29 -0800 (PST)
Message-ID: <219d48dede525478a24ca3b68221182421ed88c7.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 9/9] selftests/bpf: add arg:ctx cases to
 test_global_funcs tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com, Jiri Olsa <jolsa@kernel.org>
Date: Thu, 04 Jan 2024 02:28:28 +0200
In-Reply-To: <CAEf4BzaCLZrDTZevHASXJBSjLQ3zR0A-E2zCZJtVwR=De0DfJw@mail.gmail.com>
References: <20240102190055.1602698-1-andrii@kernel.org>
	 <20240102190055.1602698-10-andrii@kernel.org>
	 <2e7306da990a9b7af22d2af271dacb9723b067fc.camel@gmail.com>
	 <CAEf4Bzbj8Eeo=SNtRzk75ST8=BnPVJi9CNp4KKpPaT_fnhUymA@mail.gmail.com>
	 <2f889478e7fc787dee74816f9f374284a94a3041.camel@gmail.com>
	 <CAEf4BzaCLZrDTZevHASXJBSjLQ3zR0A-E2zCZJtVwR=De0DfJw@mail.gmail.com>
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

On Wed, 2024-01-03 at 16:26 -0800, Andrii Nakryiko wrote:
[...]
> > > > I think it's worth it to add such test, wdyt?
> > > >=20
> > >=20
> > > I feel like slacking and not adding this :) This will definitely fail
> > > in libbpf CI, if it's wrong.
> >=20
> > Very few people look at libbpf CI results and those results would be
> > available only after sync.
> >=20
> > Idk, I think that some form of testing is necessary for kernel CI.
> > Either this, or an additional job that executes selected set of tests
> > on old kernel.
>=20
> Alright, I'll add a test then.

Thank you.

