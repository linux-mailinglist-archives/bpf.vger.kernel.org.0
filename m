Return-Path: <bpf+bounces-62346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76510AF82D4
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 23:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC70564CEE
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 21:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E452A220F36;
	Thu,  3 Jul 2025 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVIN9cd/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6E2DE701
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 21:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751579360; cv=none; b=HWEESCybRWZLWfYpIfhiX0kwh9CXIbCuGw2VnGAOaQMu6LK0dvXdJJfpSzf5dP2AMNNGuVz5Phxd9rfcWyCwZoZUxosMhPms0Kh8duzjChh5+53/fhCHobYEiyNggFu13byBQ/emZyHG/1IQEuxlpryT8K46SP2dNzCfnEr9zDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751579360; c=relaxed/simple;
	bh=tFp/8WOZB/THo3ZA01sF7eJVSmYSGW+HEr1x9wYFe98=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m3jvZ1J939GDnCO1pjXb5Y8nfJ3EKj7p1/eqNbLUvgqdBF9HA8t0amaKVAhvTTr5XNOQeCFW7f0xBCUr31rajIA2sltlSu6Mb8NF9o/uXgNISTro7Yjwr8wdk8G2Wr4Db9WAcRLjaG998uTvalSROem3MHttYNfvFmoQ6KVdtbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVIN9cd/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234fcadde3eso6298005ad.0
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 14:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751579357; x=1752184157; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GrDETjKJi4K32GykXAn8s2aHpeD5qSDWsaq99/FUI4M=;
        b=fVIN9cd/SCCKvEOmb2pnwt+/DfQDf5BaIWejw3q/4n4+o08GTKnX+JXjIVyF0UfOWr
         jaAQPZS3+Zy9OlcxuwD0brsQoO8NysnGJ7cb0nO95358pKfFWnJ64y+b/jcIVd6h1SXb
         oxgtyE542E+haXkgIboovq6Rr4NcArz77CJ2S9PXYrjgR1558uK9UHQidiYr521/GDIJ
         eEqiM8F8kz25yI8qY9/phiIiFtq04BaRO2UIdPUGWgjczjIA51NwheP4bOvZ6KstPLNB
         xPX6GI6rGmKHwmfJh8fg3V730dBzvRasq6Ea0Wz9uKqrVe1UbBim7mTFBht95XdSqgbR
         EOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751579357; x=1752184157;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GrDETjKJi4K32GykXAn8s2aHpeD5qSDWsaq99/FUI4M=;
        b=MbLlXo5ceZc2uy7hedM6iucjzODV2opIh0Dd0krGaAlBYAhQBMIHfBQ6o5hWpxcoEJ
         7nZD0ENG1nuyS6+3KL9PmM0BkahX3ouZzP7YYipsKr7gV8wkCkw93032hkfpNC5l+GKo
         HHJEtlkcszurMf7jDqqZJ8IZNeh3BxFeJOCxG5T8KW0KilcV+DdeHnwBVJDOsNucRTnw
         RDfk3wfE0tDQpB54rJUQX0u7M8HFtBQEPr9/yStK4OigL93ACcOaIP9rsPUYEYKnG0h2
         llEj/9F62MKr32w2DdREG/601bpF/bSdSRalvUJ844O60DlqOyxeIlAXHA/flyu7Td9Q
         qOSQ==
X-Gm-Message-State: AOJu0Yw8d6ROt7SonoewR6o5tmgW2WwZFwUVcXSKObMoTlwZwQz0Zgvk
	aaAD4HaYoM4hf/t1EN23fC0xmne0RCbvSKMIMfoeU3jtUggzOPoeTiF+
X-Gm-Gg: ASbGncuzeolBJryiNrwzD8bCiEuAI3tfJbF9vCTtzNQmW5fDzZLqTNTJzI41xK7OWUJ
	nIZyLSOSIgUv+jUkA5kvQxfo/5GCUz4y1fXyegd83V5HtF9/0EPjPrxWhf8SW2eOtlfbvjUeGez
	88WNd2hWLwWyEqYAQbMd2XeIGF5flonHmnfvd6Shhsukqy0nydSz1cICa1ptI4PGVS2Eldo3M+m
	o/r26SB49/3eTz3ZWjQZKsmrNKVYU23xopkNIEBDY80HqqvBxWzOToFNii/UC/nbY8XElNVBT8r
	zOUM6ft/g8Q21NnZhbfPGVXCaUYdP7hwwuWieuCT5N6mg8fW1Pb2bW+El1oklYium5th
X-Google-Smtp-Source: AGHT+IF0bU4vU7FCujZTm2zI1rqcEtdBw8qBVfpJaYqIJWWiKJudaTbQLFdFqPBafBFD2i6hdREMKg==
X-Received: by 2002:a17:902:e94d:b0:235:668:fb00 with SMTP id d9443c01a7336-23c85ef5219mr5186415ad.46.1751579357434;
        Thu, 03 Jul 2025 14:49:17 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:90c4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee482a56sm502674a12.32.2025.07.03.14.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 14:49:17 -0700 (PDT)
Message-ID: <63695ed41e85be62d93e5e86204cd8c0d3491ff5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] bpf: support for void/primitive
 __arg_untrusted global func params
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Thu, 03 Jul 2025 14:49:15 -0700
In-Reply-To: <CAADnVQKRigoGjm+jeKY-nGHi=_5pVr+Yjs_MnRDXNbf09AP8kg@mail.gmail.com>
References: <20250702224209.3300396-1-eddyz87@gmail.com>
	 <20250702224209.3300396-8-eddyz87@gmail.com>
	 <CAADnVQKRigoGjm+jeKY-nGHi=_5pVr+Yjs_MnRDXNbf09AP8kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-02 at 20:20 -0700, Alexei Starovoitov wrote:
> On Wed, Jul 2, 2025 at 3:42=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > Allow specifying __arg_untrusted for void */char */int */long *
> > parameters. Treat such parameters as
> > PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED of size zero.
> > Intended usage is as follows:
> >=20
> >   int memcmp(char *a __arg_untrusted, char *b __arg_untrusted, size_t n=
) {
> >     bpf_for(i, 0, n) {
> >       if (a[i] - b[i])      // load at any offset is allowed
> >         return a[i] - b[i];
> >     }
> >     return 0;
> >   }
>=20
> ...
>=20
> > +bool btf_type_is_primitive(const struct btf_type *t)
> > +{
> > +       return (btf_type_is_int(t) && btf_type_int_is_regular(t)) ||
> > +              btf_is_any_enum(t);
> > +}
>=20
> Should array of primitive types be allowed as well ?
> Since in C
>    int memcmp(char a[] __arg_untrusted, char b[] __arg_untrusted, size_t =
n) {
>      bpf_for(i, 0, n) {
>        if (a[i] - b[i])      // load at any offset is allowed
>          return a[i] - b[i];
>=20
> will work just like 'char *'.

I agree in general, but compiler converts arrays to pointers for
function parameters, e.g.:

  [~/tmp]
  $ cat test-array-btf.c=20
  int foo(int a[], char b[3]) {
    return 0;
  }
  [~/tmp]
  $ clang --target=3Dbpf -c -g -O2 test-array-btf.c -o test-array-btf.o
  [~/tmp]
  $ bpftool btf dump file test-array-btf.o
  [1] PTR '(anon)' type_id=3D2
  [2] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
  [3] PTR '(anon)' type_id=3D4
  [4] INT 'char' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3DSIGNED
  [5] FUNC_PROTO '(anon)' ret_type_id=3D2 vlen=3D2
          'a' type_id=3D1
          'b' type_id=3D3
  [6] FUNC 'foo' type_id=3D5 linkage=3Dglobal

So, I'm inclined to skip this for now.

