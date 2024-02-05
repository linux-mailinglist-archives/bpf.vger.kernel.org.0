Return-Path: <bpf+bounces-21228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C560F849DA4
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 16:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76ADD1F21567
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC5B2DF73;
	Mon,  5 Feb 2024 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXv6nVK/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69BE32C6C
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145257; cv=none; b=tw+WPt1ffyp7WmyrdKvwnWLPNx2PstTqKky1Qf8Tf5qtuLEAl0GXxRVkjWPTM1hlLyhfIzwsY/mpf6nYtMSYc8ve93zl+ftXRYyM9A5MFJpOJOevf0enyhdtc3tnb4imSt5TEIM5QvcqwCWJcchgQTm3THoVTsMQUK1swfKy030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145257; c=relaxed/simple;
	bh=4x/pL/LexyK+4wqZZH/6gBXshFnDy2QZXDAbJnIwUqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQ4EZktVY64D3rn1qAGm8MB8qMh1I6ma8M1Dk0+8N14/ZO+jJBUn+i2kk4MgTqMyp8+RNrJjavDlhySaNlHactzuHgxuLLmbdJBXMz3E08puPqaOdVgobTkiwPglQ2RRag562t0sVyKx3UECwTxaHz5+BJjrNqLjLXCc2w8e3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXv6nVK/; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d317aafbd1so1994430241.2
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 07:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707145254; x=1707750054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdJNeue2Wv0xiehiEald+OUh21W9eFlv7KMsoDs8oU8=;
        b=CXv6nVK/NtQ0TRotQaF8GyMgdPby6UPMK7Y0wkjW56Lx1IpFExmMB4zm2fmO6d2R6B
         8rCbxnjOsCrQffUh3EZKZh3hHyFUbMV/AvyiuVyhY/JKhEhTQQopu5JgGds2ZPkULBLv
         Kxfz8GKvQx2SwMTEfPPjuqDft9/toFNQCSy/sBWdX+2+saRIyCtAWEfCN6eWUeIiudwD
         KIRge7BNSL+AScZd1gh5ZCr/vgCLw8M3H38i+tSfX4KIugGt0h/tGMnlcgJFwqKPzHHO
         kxhhb3ZdokFnoSUoJ1hSrAoQEWC1L530eaDADN9U1U9opeZv01BJQIPE9wytblQgoGyv
         PZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707145254; x=1707750054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdJNeue2Wv0xiehiEald+OUh21W9eFlv7KMsoDs8oU8=;
        b=mjUKDJnA/ccw271aDMV3mAqDFFgQpoo2AbUCIldKoKPogh3s98Bc23gBxhhVZKWfbx
         TxhLzxOyfcg0tRks60myCLQAJmCfYj0MRQsBDOXEe9KEDC4z7j8iSnPiND0UrnVZ1OKz
         nB2IV3ApCWd6iuUC74QCeNT6YavFxcOlFuCl5lxKzqd6weZ0OzhVFr1rC9yD2Ef1InQy
         WjjE0JLu1EiO7QasS7FF1hvkhSVfMjm3NH4tRmZkNdcYw70yqQ/F+S5gWMmgDsRPGzEA
         g4enAaASrwrav+wOFwLrMPZWNHlgA5LKsFu0eAOJzpdWuWVTiiXAwIcNmKPgUf0AtvAx
         CupA==
X-Gm-Message-State: AOJu0YzWGfv14X2hwTnCi3wJXu8mfcy+/jNg2KxA6ebdUIba8jWuQPX3
	7MgAoOx8HJr4XVlHAvPAuDLaELyaUu1pjBIj/IctKu5GWz2rpkDyBAqgutDH7xv6RCSi1HuGczc
	ik6M7qaCUUNoba2kQzlsiwbf1ySEsfggdq/D6
X-Google-Smtp-Source: AGHT+IGyGdxgsP9UcWiEJx0V/pq8uMBpCddwlbwcThZVJXxE7PBJjn7CzGAgysVY689BVIMKpe8Rx7vH/upebwniUjA=
X-Received: by 2002:a67:cf8c:0:b0:46d:27ba:526b with SMTP id
 g12-20020a67cf8c000000b0046d27ba526bmr22209vsm.34.1707145252109; Mon, 05 Feb
 2024 07:00:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131141858.1149719-1-elver@google.com> <b500bb70-aa3f-41d3-b058-2b634471ffef@linux.dev>
In-Reply-To: <b500bb70-aa3f-41d3-b058-2b634471ffef@linux.dev>
From: Marco Elver <elver@google.com>
Date: Mon, 5 Feb 2024 16:00:15 +0100
Message-ID: <CANpmjNPKACDwXMnZRw9=CAgWNaMWAyFZ2W7KY2s4ck0s_ue1ag@mail.gmail.com>
Subject: Re: [PATCH] bpf: Separate bpf_local_storage_lookup() fast and slow paths
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jan 2024 at 20:52, Martin KaFai Lau <martin.lau@linux.dev> wrote=
:
[...]
> > | num_maps: 1000
> > |  local_storage cache sequential  get:
> > |                              <before>                | <after>
> > |   hits throughput:           0.357 =C2=B1 0.005 M ops/s   | 0.325 =C2=
=B1 0.005 M ops/s        (-9.0%)
> > |   hits latency:              2803.738 ns/op          | 3076.923 ns/op=
               (+9.7%)
>
> Is it understood why the slow down here? The same goes for the "num_maps:=
 32"
> case above but not as bad as here.

It turned out that there's a real slowdown due to the outlined
slowpath. If I inline everything except for inserting the entry into
the cache (cacheit_lockit codepath is still outlined), the results
look much better even for the case where it always misses the cache.

[...]
> > diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c b/to=
ols/testing/selftests/bpf/progs/cgrp_ls_recursion.c
> > index a043d8fefdac..9895087a9235 100644
> > --- a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
> > +++ b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
> > @@ -21,7 +21,7 @@ struct {
> >       __type(value, long);
> >   } map_b SEC(".maps");
> >
> > -SEC("fentry/bpf_local_storage_lookup")
> > +SEC("fentry/bpf_local_storage_lookup_slowpath")
>
> The selftest is trying to catch recursion. The change here cannot test th=
e same
> thing because the slowpath will never be hit in the test_progs.  I don't =
have a
> better idea for now also.

Trying to prepare a v2, and for the test, the only option I see is to
introduce a tracepoint ("bpf_local_storage_lookup"). If unused, should
be a no-op due to static branch.

Or can you suggest different functions to hook to for the recursion test?

Preferences?

