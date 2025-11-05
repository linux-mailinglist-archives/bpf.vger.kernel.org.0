Return-Path: <bpf+bounces-73541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 413DDC33758
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 01:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E180D34E254
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 00:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D81323C512;
	Wed,  5 Nov 2025 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SctNo6F/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B534C23958A
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301963; cv=none; b=UpuXpDF0z9hPMvzm5Cheq9x8XiPmJ/zo/yHXBApBXqhGNHNwsg24zPZkA1ifQBV4YHmJQqKDWzUyhYU4eOnRbV+EcOa1FIX91HJuXMTiauRc2wNvEH44D+kiiuLVSmJiWJQwXjWRqYt8bVVdWxdmjzEI5EVpx6CgR4aZ7Yhkn2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301963; c=relaxed/simple;
	bh=QDwYksSWVzmrhGL6bChdX4vnl8TjAu3iipcMTTMEHVw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gmkeMilo54y0m0YS8dNiAVdN/rRIbsNjDIzEqOs9fK2Yj1qeITUD86zaDx41Dg209I66v5vhU2aP5pVJmQQmtQWgzNgGlLgzCVoFd7rBg+/n8U2J/1DzAtpn2vXXnWeI05W55KG8JOMZjpiB+/LSa7iR52e1HfxbR8YrpVpvbeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SctNo6F/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso1074280b3a.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 16:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762301961; x=1762906761; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PQOo5M0i6Q/NGE0WSQPjyiNe2YqX4cEHbsFV38mV+ZI=;
        b=SctNo6F/QsJfysFeTMPqhhPpAV7IGBx2K1OG8eIsnCRYkKIrnuBDycoLxD9FMCCAqA
         pIkC6mcmtPfeN8RYXSywm6Z61Cz5TMvBJaadQm0/4Uj5X9tT6gPEpZjnb70s5f/X2aWv
         nJzCxq4l5YsFP5MyCET4HlQvTigi0VLWJi6vA/qqHDXu6sbTayNX0NXlgd4OtlKU7IWv
         OulFj+4jNiVq3jigw+EZTz44C13gxv6x8YP89EhgzhgTHlcoo/4t1eNdTMtWVK8wAhW5
         Z+QqfqBZFmEFaWdluwRGnN+00f6l47VZFGCIbQqi9JbxjaKUef5IOQXxSLTfdDGJew1D
         5dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301961; x=1762906761;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQOo5M0i6Q/NGE0WSQPjyiNe2YqX4cEHbsFV38mV+ZI=;
        b=GlGr4w5UcSdlDYEa0kBQb26XAKedEPsEx749DE62jSyGubLnvP8Jw4Weq8M8UlLtls
         9V4DYphSWy6oy74gHu9wDmc3gGNeZonm9jJYRD/CYsXxe2AcjgBPpOVii5wzu5mvse8T
         f9iuUGW3P/WvsLcKDeapRA8MtgA4IKSreorru6Lr+aAkoofzqxvmvrKUFmNmxbTP+G+T
         79f7pJrTn7puCAsINUqo07bJrBf00xV7hignKnn2zZ6hKyfcX1p7guL9I4Mf54LNnHQ2
         O2E1LuYGCDkpJjomyTvmImo7299/VGZNcjG2IhadYyVNe3xreLvlY2AlYY5HZAZb9zTf
         kyfA==
X-Forwarded-Encrypted: i=1; AJvYcCWriN/9i88p/1m+RbvOtNkLME3N2dWWa74TJMKgD8chr7cSbVz595y9NRDydPH+FBphPHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE7JmRJIP2b7LmWyOYNO4sTypn+QO9niOIygPjPFX2RjcZrMqc
	cM+L5M51TApeuQCslo7zHc6Jk7VB+DO+//2zvjqfqWZhTYotFwqYET4LxmmE3pbF
X-Gm-Gg: ASbGnctdIj4ZuWVSlQReTMVBIeObNbqKmwrLUpeYlxNwSXkJv+NLhmkXZAI/orw6kJD
	apJaNIvrA8G5xr8JOI7DpuREdD2hWmveSfaAhfmZUIwGgjY0iExtz9j6jF6QVqw/AzBo6e9KVB3
	1ZOorKBXEUYwyv/Vxj1zMT2IlgqSRAkjXU9l5F+8cdygWrMBbuHiziVZMNCywFKchB5yQ2AEU4n
	2HDomgFxtJTeiIzRfv1xEYQtoz+oNEOEuZb8eHGtPb2sXae3AGAu5fh0/Ol9hAMGKY09AhCMEsI
	as8ixJwSoeLet8CWxSehCWmiMMoizt2JwoKjBhskA1Uv/j7cTQMy5ecagQJjLeXG0dZZNIQqlqy
	OkkIh9oIj+/p7hDXXEcCs4t7+1WVC55703oNkQhhmSuYoJPgSRB+2pXKOI0Zf2QLu73FqKrW/O/
	YdzSRqOWV5d5xitiiXEPwNfSc=
X-Google-Smtp-Source: AGHT+IHD2NG1fQ3xl98wFzeuOQRvtfU5I7A4mP97EoxmWWPr5Ongqgmj+Ju/4NPWI3gyRmGoE0iydA==
X-Received: by 2002:a05:6a20:f20:b0:34f:b660:7723 with SMTP id adf61e73a8af0-34fb6608efamr518592637.48.1762301960948;
        Tue, 04 Nov 2025 16:19:20 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a710asm3616987a12.30.2025.11.04.16.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 16:19:20 -0800 (PST)
Message-ID: <a2aa0996f076e976b8aef43c94658322150443b6.camel@gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Donglin Peng
	 <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Alan
 Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, pengdonglin
 <pengdonglin@xiaomi.com>
Date: Tue, 04 Nov 2025 16:19:19 -0800
In-Reply-To: <CAEf4BzaxU1ea_cVRRD9EenTusDy54tuEpbFqoDQUZVf46zdawg@mail.gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-4-dolinux.peng@gmail.com>
	 <CAEf4BzaxU1ea_cVRRD9EenTusDy54tuEpbFqoDQUZVf46zdawg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:

[...]

> > @@ -897,44 +903,134 @@ int btf__resolve_type(const struct btf *btf, __u=
32 type_id)
> >         return type_id;
> >  }
> >=20
> > -__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
> > +/*
> > + * Find BTF types with matching names within the [left, right] index r=
ange.
> > + * On success, updates *left and *right to the boundaries of the match=
ing range
> > + * and returns the leftmost matching index.
> > + */
> > +static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, cons=
t char *name,
> > +                                               __s32 *left, __s32 *rig=
ht)
>=20
> I thought we discussed this, why do you need "right"? Two binary
> searches where one would do just fine.

I think the idea is that there would be less strcmp's if there is a
long sequence of items with identical names.

