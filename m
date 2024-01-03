Return-Path: <bpf+bounces-18909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5866C823671
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 21:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6051A1C24511
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C101DA53;
	Wed,  3 Jan 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig1sfHJM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9291DA22
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-555bd21f9fdso5206455a12.0
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 12:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704313142; x=1704917942; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+IDIbGj3vmYw6qo7mPDxa7+E87/r4cZGJu1NeB11lDk=;
        b=ig1sfHJME4pyLK5LavNmcxxwxag/vDZ+aNNOnstxIFV2GUQ3O2hirE01LBVUokVWpL
         5Tq7S1bEoDHoJrxlRHmpAKSnt7kk7hwyxi4brvZI7nDMkkyXcMHtotalE/Xjv/r2gsCN
         lWZxLfQDx3XrY5LdPp4Uk8cL1hfDYNH683pf3Z8v3Q5fUm/CZDHtGSnUi8eq7pPKdPxA
         l/9bzVHLbo2O986qoVBMoeHy0FvtJwlCFwDBErP9taQ4MiNF8PJeL7ima4nU41Bm5DgO
         +YAQq4cRyP/1oTyanodV2bX5tAwzd+ynCKmZYgcXGvTF/6AvN6aUf3Jk++bPzv2rF5bO
         4McA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704313142; x=1704917942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IDIbGj3vmYw6qo7mPDxa7+E87/r4cZGJu1NeB11lDk=;
        b=xBgLdpZzK+t/skI7GR4qxK60odJwx9juGmZvFWLfqRyUN85bK/SpbxBXeI4hMsadlC
         8A7WFQpUDB9CtJLxD1Q9l3uEzqWVS3q8y+tbfQI/F1Mj3jpq+mu5fjxbtYOogVu2vS/F
         GR1c18Bzszxf6jr2nJRfToDF6VDrD26jcyj7ZJy2LJVN+DbTmywAVMf0R0IdJUBYgm8r
         YluwtHetfHIzxtCPHbplBJaIcaC7Ec/kB0B9+j+jZoTNk5B1FUO3ppdY+oOJjC2ZGbqo
         IFpuYEzOfl99303W2289ONHaGYOBWeo1ppaD/2DmSzTB+n5lF20ykDcPPCU076cD1gjX
         RGMA==
X-Gm-Message-State: AOJu0YzfO3udVY9QmaFofyjv4bcjwvYsTjWYgLEmlqj/DIlv7KJx+5/T
	8IhvMEvag7dQo3lmJGLrvgsjrfArwV6Whw==
X-Google-Smtp-Source: AGHT+IGrTV3bxyIZarkrQ8vjnqidKNcW7Lgnt7Jw9DPzhr53O6kq/bSQAVEdGKc0h0y3O1XLByjZ2A==
X-Received: by 2002:a17:906:97c8:b0:a27:f6aa:c7b0 with SMTP id ef8-20020a17090697c800b00a27f6aac7b0mr2432215ejb.11.1704313142365;
        Wed, 03 Jan 2024 12:19:02 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id ka24-20020a170907921800b00a26a80a58fcsm12653352ejb.196.2024.01.03.12.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:19:01 -0800 (PST)
Date: Wed, 3 Jan 2024 21:18:53 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev,
	dan.carpenter@linaro.org, olsajiri@gmail.com, asavkov@redhat.com
Subject: Re: [PATCH bpf-next v12 2/4] selftests/bpf: Add test for recursive
 attachment of tracing progs
Message-ID: <20240103201853.xqh4hhdp7p4owkna@erthalion.local>
References: <20240103190559.14750-1-9erthalion6@gmail.com>
 <20240103190559.14750-3-9erthalion6@gmail.com>
 <CAPhsuW7Nn2i1PBCH5JDcShH6dYYwPKU9tHrVmT822n7BHNByLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7Nn2i1PBCH5JDcShH6dYYwPKU9tHrVmT822n7BHNByLw@mail.gmail.com>

> On Wed, Jan 03, 2024 at 11:47:14AM -0800, Song Liu wrote:
> On Wed, Jan 3, 2024 at 11:06 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> > +char _license[] SEC("license") = "GPL";
> > +
> > +/*
> > + * Dummy fentry bpf prog for testing fentry attachment chains. It's going to be
> > + * a start of the chain.
> > + */
>
> Comment  style. I guess we don't need to respin the set just for this.

Damn, I thought I've corrected them all, sorry.

What do you mean by not needing to respin the set, are you suggesting
leaving it like this, or to change it without bumping the patch set
number?

