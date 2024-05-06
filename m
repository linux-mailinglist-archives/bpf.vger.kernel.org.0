Return-Path: <bpf+bounces-28712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A20A58BD5D4
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 21:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0A7281ED0
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 19:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29C315ADA8;
	Mon,  6 May 2024 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFFz6ATW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22A8158873
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024848; cv=none; b=IypRIDrt7ERs8Mf2FGaRYX71qEVQM0ejuIl77J3DaaeB90D24Qj9TJUfdwjanep0MAOmnEb3oCxOgTh59AnTQ/sbA61ZXnJF2+Vwrn4KYaXvwNSaQsi7F9osf+c875nE2EJVsKODDpAtKXaAHz9gW52ZAKp2V/M0Qm+cMpIPuug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024848; c=relaxed/simple;
	bh=GByCENBgWchn0akpqZGoD+13cIMCyJdu/t7ZRXWHSVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LLtMJNqagtVK0iGhhGDZcrGPkWGwGMLpu4VejUdtDMv2nLHWYG5PldgPC3O1+W/MJbRJo1o7jIGcXOJcw/dEckDMVsNZb1ThFjBHXGIcDpOwSdNhCKRVlaJIPzN9SQLTLMrWuourCU0HIRUakprfpwEybEkoJMpvXJINRX9g9Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFFz6ATW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715024845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B+LfvZaM0cDhMeJS6ywBd3hBXEDd/TNc5rZ9ADTiBeU=;
	b=XFFz6ATWAYxWIPX6dQOicv1BgwQn+0Nr5heyzjg+MHj7lcis5yn5DkHbq3DftmlKtKp2DF
	BEZOVpGwIboeY6L1uFsjjS2BXlcgx1a8bpdjuAjq+YqHmLCw9ydbelytX4GvoMQBjsZFbf
	PxN2OsaWtIoeDidlQ4nwV5+6z8fjxGE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-R9Qq2RSjPOyACnH7wFgftA-1; Mon, 06 May 2024 15:47:24 -0400
X-MC-Unique: R9Qq2RSjPOyACnH7wFgftA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a59c942611bso98542966b.0
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 12:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715024843; x=1715629643;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+LfvZaM0cDhMeJS6ywBd3hBXEDd/TNc5rZ9ADTiBeU=;
        b=bSCrxeQnHKC268Hb8w/VC+baNRU3+j7LinmdnCbWc6Bww0+2w1f/8H9yRO2jzLsq8z
         V//h5JZTyf6w7SgYGS/5GwlNOgeBdaHOcOl3NeChdOrY4dXvONtNWYQXA3YrjktdPtjw
         f/r2Qtyj2PBjBN6tR2XwCzd4QD9NXVXUwK7NSBKR13lJeOjZlKG/n4XnegjwIeoqGguY
         a6dxvPAp8u0A7sPaBU7PWoEcC29s/2V0f77adGT3rALzcyaNKZTenxG0gMnsS40VSkNC
         Dn+wxHgifCpmz5E3MkMN26FHqSRqyr8OgSIgnRnoCW8SVRhfmCK0/tavlzPh9EaFB7bS
         AH0A==
X-Forwarded-Encrypted: i=1; AJvYcCXcRUVpp0e5RysQ5Qmy4iHJ16dwncSfx7QcTTgk8KcKBDW41wmUuSzubBS7Vj5d2EXGoE0hv5IurP/jrQLo5A1m27FO
X-Gm-Message-State: AOJu0YxSvPuqHc/nEJlCSyI86AgmIWBCPiNFmPr+O/Kl/TLsQ5CyiJXy
	rV9t2pGq6hdNBHIeW7oHI70ZnLikL/2sWhZoHqZk0MJtDuxaGyYPUmiSgapkp+iLkxrAsM+lFir
	hyU8pvjy5boCRmDpZ6OfbCvqnw9crhxpTsRKXT8Ns4ELmAGbSPQ==
X-Received: by 2002:a17:906:b52:b0:a59:a857:85d9 with SMTP id v18-20020a1709060b5200b00a59a85785d9mr4643933ejg.69.1715024843408;
        Mon, 06 May 2024 12:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRBhj9be7jQBaaYDelz+oS21CM2eqozyILXEzEZ8HkdFgKx5zuiy6DpoR7jF+SLKlNWeLj5A==
X-Received: by 2002:a17:906:b52:b0:a59:a857:85d9 with SMTP id v18-20020a1709060b5200b00a59a85785d9mr4643904ejg.69.1715024842927;
        Mon, 06 May 2024 12:47:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id mf1-20020a170906cb8100b00a55778c1af7sm5641019ejb.11.2024.05.06.12.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:47:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D9DAC1275C78; Mon, 06 May 2024 21:47:21 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Michal Schmidt <mschmidt@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] selftests/bpf: fix pointer arithmetic in
 test_xdp_do_redirect
In-Reply-To: <20240506145023.214248-1-mschmidt@redhat.com>
References: <20240506145023.214248-1-mschmidt@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 06 May 2024 21:47:21 +0200
Message-ID: <87v83qoh86.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michal Schmidt <mschmidt@redhat.com> writes:

> Cast operation has a higher precedence than addition. The code here
> wants to zero the 2nd half of the 64-bit metadata, but due to a pointer
> arithmetic mistake, it writes the zero at offset 16 instead.
>
> Just adding parentheses around "data + 4" would fix this, but I think
> this will be slightly better readable with array syntax.
>
> I was unable to test this with tools/testing/selftests/bpf/vmtest.sh,
> because my glibc is newer than glibc in the provided VM image.
> So I just checked the difference in the compiled code.
> objdump -S tools/testing/selftests/bpf/xdp_do_redirect.test.o:
>   -	*((__u32 *)data) =3D 0x42; /* metadata test value */
>   +	((__u32 *)data)[0] =3D 0x42; /* metadata test value */
>         be7:	48 8d 85 30 fc ff ff 	lea    -0x3d0(%rbp),%rax
>         bee:	c7 00 42 00 00 00    	movl   $0x42,(%rax)
>   -	*((__u32 *)data + 4) =3D 0;
>   +	((__u32 *)data)[1] =3D 0;
>         bf4:	48 8d 85 30 fc ff ff 	lea    -0x3d0(%rbp),%rax
>   -     bfb:	48 83 c0 10          	add    $0x10,%rax
>   +     bfb:	48 83 c0 04          	add    $0x4,%rax
>         bff:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
>
> Fixes: 5640b6d89434 ("selftests/bpf: fix "metadata marker" getting overwr=
itten by the netstack")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


