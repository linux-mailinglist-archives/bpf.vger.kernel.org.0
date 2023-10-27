Return-Path: <bpf+bounces-13425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C077D9AEB
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 16:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95111C2107B
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F036436AF4;
	Fri, 27 Oct 2023 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZAnjJQW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA836AE1
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:13:21 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17A3FA
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 07:13:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9bdf5829000so345515366b.0
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698415998; x=1699020798; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Gajptuuteu0oLmCgL4LSPXzJYB3TCTIu18rZ2UrzME=;
        b=kZAnjJQWyl7sxf7igBTW2vR8V0pVl6exVVTVxnEUqNWaiRC/X9jKIp0+XtibwrrqHF
         qR7Glob40YHv3oDaN7Hrzlj3CuHO1uWf0fPop5b/s28LorcInTatwRg4XNu4qTVRKrY5
         qpziDPRjngqufECH9HB0C9gAgvlvNYCkLHFwIEljJeZWxBY2vCV2yEp2j+Xnu9o6LGjJ
         i8MOquzy3+Y2sh3eT4MWHc82yF+Zn8ZEl9MwMdIWOgDlFFubxK1S5WX72qhWBmor5fSd
         iBw3css7UmPt/979vxltM+zZ/7Qrwzma59E5X5DLM7aV1aC022b7WkOL/fbSqSDwLZwQ
         2wTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698415998; x=1699020798;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Gajptuuteu0oLmCgL4LSPXzJYB3TCTIu18rZ2UrzME=;
        b=ONTEMfOeKpxS9+dBxy4GK2+Lz4oxto2HxsV+T0hJ5OKJUXlzN9pt1eAXttJFgf4cRb
         GMZxV7LrP2nfG7H2Z5KmxThqAaOOgkniLzLD4x+n6aTMCx3jaq4TqHvIUlbvaCdU67Pz
         eiRyQheM3/MTUZ065UGBjyUOpRgCy2yGI/Xi4OZjmuKq9YUaXT+TRdGGVPNoKN6Tr/Lk
         ypUPlZs27pDAdb2t63e3gVyAn+ponOjcDrWw8O6Be7oNGYKZwOfepqqpK0IdXl8evAc/
         QMLQC7l+cGrK9v5KLc70KF6aKUhBRpwYHjhVUiE4B6ME94nSOdJHTVjHuo3Jv2BUQQ2B
         C8fA==
X-Gm-Message-State: AOJu0YzGoMKNw7LLXBoxGIMNkZonIiCqgcM8PwTVBEEeXNqD3OoxFrw/
	vmEQNiTm9Zs7Xuth2UJOxxQ=
X-Google-Smtp-Source: AGHT+IE9ER8PCGubYidLGH+NwFxk56v4sgLvKnqiQdoZzv2OpBzIxYS3WoT6yfl9Ev7VrizgpSRePQ==
X-Received: by 2002:a17:907:3f20:b0:9be:e278:4d47 with SMTP id hq32-20020a1709073f2000b009bee2784d47mr2585418ejc.27.1698415997839;
        Fri, 27 Oct 2023 07:13:17 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ha11-20020a170906a88b00b0099bc80d5575sm1236458ejb.200.2023.10.27.07.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:13:17 -0700 (PDT)
Message-ID: <66a48029129dbbfdba57dcd01daa9b4a1f91b915.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 10/10] selftests/bpf: test case for
 register_bpf_struct_ops().
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, thinker.li@gmail.com, 
 bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
  kernel-team@meta.com, andrii@kernel.org, drosen@google.com
Cc: kuifeng@meta.com
Date: Fri, 27 Oct 2023 17:13:16 +0300
In-Reply-To: <5b3609f3-bc40-4fc3-b591-d124432dc4d9@gmail.com>
References: <20231022050335.2579051-1-thinker.li@gmail.com>
	 <20231022050335.2579051-11-thinker.li@gmail.com>
	 <abd76cd234ab2a1185bb9557fa54013264df6a50.camel@gmail.com>
	 <5b3609f3-bc40-4fc3-b591-d124432dc4d9@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-10-26 at 21:55 -0700, Kui-Feng Lee wrote:
[...]
>=20
> The test will pass even without this change.
> But, the test harness may complain by showing warnings.
> You may see an additional warning message without this change.

Understood, thank you for explanation.

> > Regarding assertion:
> >=20
> > > +	ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
> >=20
> > Could you please leave a comment explaining why the value is 7?
> > I don't understand what invokes 'test_2' but changing it to 8
> > forces test to fail, so something does call 'test_2' :)
>=20
> It is called by bpf_dummy_reg() in bpf_testmod.c.
> I will add a comment here.

Oh, sorry, I did not notice, thank you.

[...]

