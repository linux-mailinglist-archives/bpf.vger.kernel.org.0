Return-Path: <bpf+bounces-77871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B0CF54A4
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 20:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87DFD300BFAA
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 19:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B768F340A69;
	Mon,  5 Jan 2026 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUHQX/eT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nRM8wwfO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B00309EF0
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767639873; cv=none; b=qlVnrXi0DPUgoTz7sK0dTXpNVYAVUWpIC1veO8FQAjTfwqtMIoBlboTsu2DGDWmJWj7JScVHKf8WHYfcFpXJB7JkhBAYSuGzkCqHo/9uOMx84uGR4TZqf0re3iLwCCEvJCx9tifcp653A4k9cI6Nmvbuq2sb/l1wwo6i6+BkhKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767639873; c=relaxed/simple;
	bh=EW35fAGpc6irv6klge1pSAUT/e498MzsYzLU58+p0RM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sWsXpaP3LYiZJb7TIVB3f+wdhMckwnhChA2N/xaElyVEL5yFhTH//svdw2wnYpzMpbtESgKd87aVWff2onmwZhVeBNc+i/dRG9Mm20GrH/Pz9peG79jC2O6YGyK2bvqhTFNigLTxejg4wZVxos064Cbv+4DwDwV7inqmlqPjEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUHQX/eT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nRM8wwfO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767639869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PP3X6T+cAs16XCJeSGeaAouaKAUNwzGXxOOaWFTYxXk=;
	b=eUHQX/eTrr5XY4oY/EHMCrlXb0rIPuapBrcM9bm5QObRb4dZJibkHMIqHTLrnzSMiYe6Qx
	apEJXS9wo38p2VCj9pQbrTL7HaT0fe9Z5iBQZ3itP5K9qxsue7out/7HqWto0GrKTjasmn
	u5iXhHsHVsJYp2e7ZFEU7WmQjBteXUM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-G2uAt_KeOjmEP9T2UODMbA-1; Mon, 05 Jan 2026 14:04:28 -0500
X-MC-Unique: G2uAt_KeOjmEP9T2UODMbA-1
X-Mimecast-MFC-AGG-ID: G2uAt_KeOjmEP9T2UODMbA_1767639867
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b79fddf8e75so21150066b.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 11:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767639867; x=1768244667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PP3X6T+cAs16XCJeSGeaAouaKAUNwzGXxOOaWFTYxXk=;
        b=nRM8wwfO00ZS831dTIXYEPEH9DCgFw/pK/7Yg7SSe2s6hBlazKLKhh3ecBZ/Osbrsa
         VVBFA8zi1EbrQiE/B0RK0XUO4fo6E7bf3z0Ek6RckbiSdc01pJ3goDC1T4W7rW0htzB8
         A2/IVlO5GKar6NGz9UmRKPTaUNEs/KhoBV4qznwiR1i/0eUF6Zqu8v62+OI7PKvHEo+w
         WMPoguBXuyMAgg/HWqns0YEzrxfm0PATN8KgN8Gc6eWat6VTTIGmqdAZt7bAURsQMa/w
         YcZM9n/R2CokDMFduViiDULlxfZhWoVXTHKnKqPCJQRxjhKvtqLbCTTQUOlMsyApp7QT
         TMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767639867; x=1768244667;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PP3X6T+cAs16XCJeSGeaAouaKAUNwzGXxOOaWFTYxXk=;
        b=TEUX1F5fQGebD9TJIPMyk63EXmSTH6GZklgxW8+ik4W7RDWRVYBjPC0HKi+zNB87R+
         68aWTefpbP1tBq5KmBLtm/2/+GzpJeOdNdXTYsGikREApmT1p4d2junaotRECVavVTBu
         0ncF32udDieziwjKzL2nvZmWK3wIB9RkVPvABp5FlZvmjD3Qyi0NhfnrQJDNpvFqDrL3
         fD1ghXmBJPdSklRZC0C4ucqN34mwNGuhFxTTWxWc+Y16P3osz2uWnTDehAaVlLWDzQhW
         HgTd+Tewj+AZNroWnZ83bsjje7l7nyF3eEfKwHgoowvJxCZoAoIVs/jV/DoUyXKrfvXC
         LZBg==
X-Forwarded-Encrypted: i=1; AJvYcCX/0svyKsh7QNJNRyF4nVW8ymMzvKfYJDtd1W+1Db6OLZgVKURAt0OBY/1dufe6uSh8s/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEM1mKboHvsr+wLnaFiwQwXoyLn7NuMkhNjsv3I38+VP8p88Vl
	/tt19vyeKK+gYlM/+UBiRhpQgiybuakjsbvjJv8lH5z283bRGYlZ6tO0uPHz/nIjYgosoz3N2MU
	UV4aUGwIKViyxq2OuVUWnwB31BP1gqXEDuGidhML7/PU66fZBs6fdKQ==
X-Gm-Gg: AY/fxX7btEReDE6y1CbIPq913EsWXqW8Z9aOB/Q/zuQjo+xwXpnhQuPQvCKB9xQ7dOT
	+TqTJRS6VQqqUgrd8FvSgtBirKDIoYrJfuWwHhrLrMehjWEA6lwYMe6dAvOPYwqzBjWzS/8orri
	TbHjsZFAtQdVgGD29K2Mb2QC/Eb9v002q4uwwEVafb93rFfc8GI17fdN+PNNUBjjqDIff0x2Z72
	0vN8dwopcMchMJGdjI+7JnQiZH9OpvRD62dTbX+xxuu49MfBrTmNEfGuK4EAdY9fNhyznBZdjz4
	LSCtI1zB3FMHk5IBWsTKcOmM6H1NDe+D+J8W88+efKJqync+93kzjMbWTxk9sftQBkdILHWatfQ
	NMorrs9BRRePti8/gzWEqfUP8isIjb90qcigE
X-Received: by 2002:a17:906:f59b:b0:b73:6f8c:6127 with SMTP id a640c23a62f3a-b8426a4b134mr86835966b.12.1767639866824;
        Mon, 05 Jan 2026 11:04:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbl0sMF7WNuNmxyY1IoonTxVITXROFrKJi6E+jKHxLhqK6WzqE7cMd2bm7JOrdaxhfHloe6g==
X-Received: by 2002:a17:906:f59b:b0:b73:6f8c:6127 with SMTP id a640c23a62f3a-b8426a4b134mr86834166b.12.1767639866393;
        Mon, 05 Jan 2026 11:04:26 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a234000sm6862866b.4.2026.01.05.11.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 11:04:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DCED9407F1D; Mon, 05 Jan 2026 20:04:24 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Update xdp_context_test_run test
 to check maximum metadata size
In-Reply-To: <CAMB2axPO7VENB-XUSUb5eU1ae7h0NBjbVukzxaObBDMMmkGYAw@mail.gmail.com>
References: <20260105114747.1358750-1-toke@redhat.com>
 <20260105114747.1358750-2-toke@redhat.com>
 <CAMB2axPO7VENB-XUSUb5eU1ae7h0NBjbVukzxaObBDMMmkGYAw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 05 Jan 2026 20:04:24 +0100
Message-ID: <87eco36fuv.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Amery Hung <ameryhung@gmail.com> writes:

> On Mon, Jan 5, 2026 at 3:48=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>>
>> Update the selftest to check that the metadata size check takes the
>> xdp_frame size into account in bpf_prog_test_run. The original
>> check (for meta size 256) was broken because the data frame supplied was
>> smaller than this, triggering a different EINVAL return. So supply a
>> larger data frame for this test to make sure we actually exercise the
>> check we think we are.
>>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  .../bpf/prog_tests/xdp_context_test_run.c          | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run=
.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
>> index ee94c281888a..24d7d6d8fea1 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
>> @@ -47,6 +47,7 @@ void test_xdp_context_test_run(void)
>>         struct test_xdp_context_test_run *skel =3D NULL;
>>         char data[sizeof(pkt_v4) + sizeof(__u32)];
>>         char bad_ctx[sizeof(struct xdp_md) + 1];
>> +       char large_data[256];
>>         struct xdp_md ctx_in, ctx_out;
>>         DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
>>                             .data_in =3D &data,
>> @@ -94,9 +95,6 @@ void test_xdp_context_test_run(void)
>>         test_xdp_context_error(prog_fd, opts, 4, sizeof(__u32), sizeof(d=
ata),
>>                                0, 0, 0);
>>
>> -       /* Meta data must be 255 bytes or smaller */
>> -       test_xdp_context_error(prog_fd, opts, 0, 256, sizeof(data), 0, 0=
, 0);
>> -
>>         /* Total size of data must be data_end - data_meta or larger */
>>         test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
>>                                sizeof(data) + 1, 0, 0, 0);
>> @@ -116,6 +114,16 @@ void test_xdp_context_test_run(void)
>>         test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32), sizeof(d=
ata),
>>                                0, 0, 1);
>>
>> +       /* Meta data must be 216 bytes or smaller (256 - sizeof(struct
>> +        * xdp_frame)). Test both nearest invalid size and nearest inval=
id
>> +        * 4-byte-aligned size, and make sure data_in is large enough th=
at we
>> +        * actually hit the cheeck on metadata length
>
> nit: a typo here: cheeck -> check

Oops. Will leave this for the maintainers to fix up unless there's
another reason to respin, though...

>> +        */
>> +       opts.data_in =3D large_data;
>> +       opts.data_size_in =3D sizeof(large_data);
>> +       test_xdp_context_error(prog_fd, opts, 0, 217, sizeof(large_data)=
, 0, 0, 0);
>> +       test_xdp_context_error(prog_fd, opts, 0, 220, sizeof(large_data)=
, 0, 0, 0);
>> +
>>         test_xdp_context_test_run__destroy(skel);
>>  }
>
> Reviewed-by: Amery Hung <ameryhung@gmail.com>

Thanks!

-Toke


