Return-Path: <bpf+bounces-38586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D9496686F
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 19:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A811F24132
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 17:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23D11BB6BF;
	Fri, 30 Aug 2024 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWxdB9ER"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAA314E2E9
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040438; cv=none; b=br5Yi3by3dCE/nLy9J7gNfTNicmJq3pxCm9e9zd4bUKSRPOW4vWkBd2pVzGbC4xUh5L1jCDiRZPI7NKg4G4BEL2kUH5vrb4qOaG8tyZqYxSoKAJwKlWvf9hGZZEjSo2P8ec1lITDN426K2otCBhwS9HU31ponFbQ7N566o1nApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040438; c=relaxed/simple;
	bh=paO8P5fwyueIYiSYfUEZYGXZ9APgQ3VTgx5/M+GzjDs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TzkXRSq53cV6VwFmve6NCP/+ss9UyMHPbQHOlxNMZ4YpBCu4wH+aguHooYncDA7kvd5w0btSQzuUaH4G4jzqWpqbwTIzyspruZoWooFYEuLQ5mIi1P7h2HWkVgR7k91g3+jygclqMzqgxDoj7IQ85BdDlZAM1ymERH7paci6yc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWxdB9ER; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201fba05363so18349985ad.3
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 10:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725040436; x=1725645236; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BnD3G27TOY4IWRp1Ba0p2jHXYnF5ykiIgds0w8RymGM=;
        b=gWxdB9ERm5sCu2I64WdBt2LSX9kIGwyKqiPQXiaNlt2xtlStiPs1yKAfjy6mwSbZ6y
         nwmVgW0Z3KgQc46pM/K2D/1nGn1r5ICoUoMNcxQJ1Diqs54PO5JzK5bcFnghZTX+HS+r
         vMhgnweJ7a3mKcYd7FB12PotMSGwI1UbdmAPf7vpWJdotmXoQhZJnEi0Bms3TIe4+1XO
         zrn1AUSKIrvvEcYVFca8VBrbCpYTSRaoA0XT0T2AgZqjMRQSRo8F76VjuKhh9OM/qGy7
         wk21NT0P1kE+7p9wqZ1qWJ1bYyE4KcBJxviZFEII32mwbP/DtV43L1ZOFooNKb7nyC+t
         Th8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725040436; x=1725645236;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BnD3G27TOY4IWRp1Ba0p2jHXYnF5ykiIgds0w8RymGM=;
        b=VhtpsupK7qk3s4NmylcNJy8O9dyItBsSEPyZ1yUpL0dZ8KAgcJTMyYehiwPebVfQ8g
         NIVucodZIFT1roWUDueWYzkEja4p3kbbv1FZNAt1+Udl7FzqRAtHppSZK5C0j6bNaxQY
         0RkUQsiLjM94DSlcZ7qDkvr0/YE1l2DVmhAGSNAca8bPhu9xtCoErYx0Si2s7geiNUxS
         nQbISKp5tSy7OL16gJbH6vmpkxiwWMErsAzO/v1Snc9ehSKxMtLV3TlZhzc189rUfIF7
         +8XzCJG1p9AFwwyzgUsw/s7uGr0YP4FqaAsPChDn5hPkfxwOIClDwM38kfO+S0gvkZ9V
         4p1A==
X-Gm-Message-State: AOJu0Yy9eMLGbefToulW69E7E6KyvDYuhna+t82/Lyn4tXwW02XxFFF9
	Kldsmgq3xAkLAlTreiGvN2BXjrGf6JPmmKccRNpJWcOjUQZaLpOy
X-Google-Smtp-Source: AGHT+IHBpjaPJNfmGqU98ENd0GhMW8N91c3OKqX8Hnnw5c4Ri4dbj/V9WmQfzZhePY9bHlEGDKUc5A==
X-Received: by 2002:a17:902:d2ce:b0:202:3e52:e124 with SMTP id d9443c01a7336-2054451b9f9mr2284865ad.31.1725040436057;
        Fri, 30 Aug 2024 10:53:56 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205155338bcsm29506695ad.177.2024.08.30.10.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:53:55 -0700 (PDT)
Message-ID: <f3f79ff5c10ccfe1603597805cfe67f2691ba780.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: check if distilled base
 inherits source endianness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  tony.ambardar@gmail.com, alan.maguire@oracle.com
Date: Fri, 30 Aug 2024 10:53:51 -0700
In-Reply-To: <CAEf4BzYF0PqVHuj2gjZzaqrBOrVo8TEfuxiJe0TZvBb55n_Jog@mail.gmail.com>
References: <20240830173406.1581007-1-eddyz87@gmail.com>
	 <CAEf4BzYF0PqVHuj2gjZzaqrBOrVo8TEfuxiJe0TZvBb55n_Jog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-30 at 10:51 -0700, Andrii Nakryiko wrote:

[...]

> > +/* Split and new base BTFs should inherit endianness from source BTF. =
*/
> > +static void test_distilled_endianness(void)
> > +{
> > +       struct btf *base =3D NULL, *split =3D NULL, *new_base =3D NULL,=
 *new_split =3D NULL;
> > +       struct btf *new_base1 =3D NULL, *new_split1 =3D NULL;
> > +       enum btf_endianness inverse_endianness;
> > +       const void *raw_data;
> > +       __u32 size;
> > +
> > +       printf("is_host_big_endian? %d\n", is_host_big_endian());
>=20
> removed printf

:facepalm:, sorry, my bad.

[...]


