Return-Path: <bpf+bounces-37068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1848950BEB
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 20:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A743B25DED
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31561A3BA1;
	Tue, 13 Aug 2024 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="vExC26ZU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C99D1A38D0
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723571982; cv=none; b=SIAQ+I8RyB1PqpK3Uomjxb+A5mqO0bkrSdTLnyBYRYwgIk8nGxC5T5qsgj/+/NXkyVAsFxXccqZaInjndKEovRB82dOQv6nOIpHjwMPH8veEn+DjBlkJKsWtA2dl5fwENMwzXjtVRbmnk1gUoenaKYgCDiVOSLQg9e9dujGLnmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723571982; c=relaxed/simple;
	bh=1D3aBq+76dfV3NuMMTICVwtmTkz//c6+wX/Vqv82420=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=B9Nq2ZHh5wWnRn8ePQOfPZPac2d1k2M/huoOIjcr5L0wUjmPyXlcHnQJqY9cauZOHVpRx0Poz5zewJOb1dsyLMYH7CQdWD/4FJrZBGh+MBgZ49y/fBJM8hIpQ7lDmHqPcJc5/F7Yil6ktPAzQMRY0I0yWrKt0vicLVaivz4/JrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=vExC26ZU; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso5686420a12.3
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 10:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723571978; x=1724176778; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fz0h1N/CKA3fHj12ow4qN56OoJaUyvUMXhRJFJBFv9g=;
        b=vExC26ZUeGFlWXO+pAqX+yRgHf5qUqhxxdG2apYEZQMy5XOCAqcgiRzv8UmCUdOycn
         Ika6FPVb3rvlKwA1ioA1V57QJWM5ocB6kKLo3GZBOytrNu79iBI+ttItdu1doWoCx4RP
         ZZQ8+JrcFBYhQ7FLXxcC74YfqVG7Ag038xAhlKeVqPhxKzWifpjn5BVGdppWwyGqiJfE
         Nrb5M90t0np7vFRhBdEN+pe7nx6dM7gKfAwoxhzeXIL+XNx/J5k2fimGyPs3tgu96XVg
         bFUUbax4/jSdgbw7roDUvosUqksDUuXaOAVQMAiUlLDHGw3ZyUOPw1DNkvUUCtOXxDLi
         vK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723571978; x=1724176778;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fz0h1N/CKA3fHj12ow4qN56OoJaUyvUMXhRJFJBFv9g=;
        b=UlEiI7pPna3H5cmww9gi3HqRq/qtApnUs8ejnt2V7lRPqWUdGbkHF7+zlFLdIBhLji
         SW0shm3UOTkFhJNjaK/Kehql0NgWkNqxfgG6faKVYrvwcWrmfNu/dv/zZrQ95gmPHA7t
         aIONeahkV85Pnlmg1aVn5lTU18uVuvMPx19WzuWD/sdjWZZ5PswdxokTxSZ7oUcpzXW1
         FoJSqtEyQWt5uDvpJirDVk0UOiW8T1Zc2G/M5EbUhyhfv7iqNXVslBXYWJvt7yQKvorP
         5+DW0S50CVSm5q1OiO1JV2H+wGr7LJVv+RO98yhNL3FKIs6K+4CepSPuFvtzhZboIDwZ
         pULA==
X-Forwarded-Encrypted: i=1; AJvYcCUqaW2FLz+Mut2QXb3HVCBPCNEj1mOPXsBb2bpwF82eX2WeDY4tYlke3/ABv+Ln4Tdfuvprz3sJjvJjAk9oxqxKaGGS
X-Gm-Message-State: AOJu0YxdE3VNhqQnwE0sjzFt2PdcZ6JtA7NgAYB0NOTUMYDj72QIm8Sb
	ZYuvP146lnzva2z26KWBxUrFiPAmBapQwQUh4qOqNIO1i1CnqVt7UEvydtNF0rY=
X-Google-Smtp-Source: AGHT+IHvT1d9KDa22miJHX6Og5kQRd7CLcIk5kV1JH9fciPcel8AmUjrwBIuaOctOR9AlHNT4yM1QQ==
X-Received: by 2002:a17:907:f186:b0:a7a:acae:340e with SMTP id a640c23a62f3a-a8366d444cfmr10573566b.26.1723571977503;
        Tue, 13 Aug 2024 10:59:37 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a92:ee01:80be:a0fb:1808:f06e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa43f9sm88343866b.53.2024.08.13.10.59.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2024 10:59:37 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] bpf: Annotate struct bpf_cand_cache with __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <CAADnVQKEgG5bXvLMLYupAZO6xahWHU7mc06KFfseNoYUvoJbRQ@mail.gmail.com>
Date: Tue, 13 Aug 2024 19:59:25 +0200
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2A7DB1E6-4CCE-446E-B6F1-4A99D3F87B57@toblux.com>
References: <20240813151752.95161-2-thorsten.blum@toblux.com>
 <CAADnVQKEgG5bXvLMLYupAZO6xahWHU7mc06KFfseNoYUvoJbRQ@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: Apple Mail (2.3774.600.62)

On 13. Aug 2024, at 18:28, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Aug 13, 2024 at 8:19=E2=80=AFAM Thorsten Blum =
<thorsten.blum@toblux.com> wrote:
>>=20
>> Add the __counted_by compiler attribute to the flexible array member
>> cands to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>>=20
>> Increment cnt before adding a new struct to the cands array.
>=20
> why? What happens otherwise?

If you try to access cands->cands[cands->cnt] without incrementing
cands->cnt first, you're essentially accessing the array out of bounds
which will fail during runtime.

You can read more about it at [1] and [2].

> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>> ---
>> kernel/bpf/btf.c | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 520f49f422fe..42bc70a56fcd 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7240,7 +7240,7 @@ struct bpf_cand_cache {
>>        struct {
>>                const struct btf *btf;
>>                u32 id;
>> -       } cands[];
>> +       } cands[] __counted_by(cnt);
>> };
>>=20
>> static DEFINE_MUTEX(cand_cache_mutex);
>> @@ -8784,9 +8784,9 @@ bpf_core_add_cands(struct bpf_cand_cache =
*cands, const struct btf *targ_btf,
>>                memcpy(new_cands, cands, sizeof_cands(cands->cnt));
>>                bpf_free_cands(cands);
>>                cands =3D new_cands;
>> -               cands->cands[cands->cnt].btf =3D targ_btf;
>> -               cands->cands[cands->cnt].id =3D i;
>>                cands->cnt++;
>> +               cands->cands[cands->cnt - 1].btf =3D targ_btf;
>> +               cands->cands[cands->cnt - 1].id =3D i;
>>        }
>>        return cands;
>> }
>> --
>> 2.46.0
>>=20

[1] =
https://opensource.googleblog.com/2024/07/bounds-checking-flexible-array-m=
embers.html
[2] =
https://embeddedor.com/blog/2024/06/18/how-to-use-the-new-counted_by-attri=
bute-in-c-and-linux/=

