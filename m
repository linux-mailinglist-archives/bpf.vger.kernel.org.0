Return-Path: <bpf+bounces-61313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B3EAE4E60
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 22:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 498DA7A4A24
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 20:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBD11FF1A0;
	Mon, 23 Jun 2025 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpC8iAk4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB811F5820
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712045; cv=none; b=CRzDzTckAbp2WA+/0pSGwEAaWOm/PPlZsY+UpTfZeNFWOgfvEodRUgBUHa3nolMF3VN5HWDHq8NAHt2xCq6N3QwP3bPUtkqtH49zVgSKSXaPEoZBHp5g3zl5PKQFxAyOJKl4tkDlQlOda7eo/YWGwU0Vl4ZcZr7rMT3mF/OTgG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712045; c=relaxed/simple;
	bh=1i8Omkp8SQ9EtF+kKqCjSeU+ZNSG+aEl0Sp2QqtWbLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmPpBEDE5/iE08S2fQE+K1eUh6dEOsnhpYjSjPVEL/ukTGfre3XhNm/nQE5mTULpb7GgCL3meIWvQHe0714kgBYXa1fWeuwtaFqaD0tUenL828IBxVVA2RWuj1svX5ClisVShdpfdJnUuoGtx1QmBlWDdxewuG1uxP3qA+IQXoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpC8iAk4; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b31f22d706aso3024462a12.0
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 13:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750712043; x=1751316843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4we2r6q/miisuicgKmPMrMxnb33fe2Ow0TocRIh8yk=;
        b=NpC8iAk4+2RhA/WukrQIUHOZahx5rFrFLGJNhCEpmVFXm+5KoIjjaxPp8pZF68PCLv
         oxfJ2JxibdA2Wpq52N+UlKpRxyArCh/Mb1A1EzCXtJOxqDyox2uSstBOm+Nq4H5FDrV/
         TsYyCJVWZOnZesl2vY2YlMOUlBPpJEQAXh7BRXpgQX9k8P+Idp/RzstAC94e3HJAtFBk
         lGqYl0uvF6gbN6Q9b5lrLI6kCgFselcnvI3XEM+ohasnpKGdAkbiUBxuNeqYlMgmrywl
         xIuYDhR8FQVM7quigWKI+HeyBpG4Ok4UhGZfS/KcnJCbwmYNaf6IM15LnvKBaSTHtGKL
         Fzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750712043; x=1751316843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4we2r6q/miisuicgKmPMrMxnb33fe2Ow0TocRIh8yk=;
        b=eToHXzOQ25Fi4I1FENdsShPuwcGkDhrqLGwMxg/hYdCuw1i6jHqTXIvSFfxzVhwVOh
         DJtaYjjEa+EdQhORUT7cCeCIBlnKZ4G6kX+0x/xy/2sRveBSzyHBIZbNaXPO3YLYLY6t
         95Tf5mAMO2Sg4/e82O1JhskVmebhsPPCBKfFKtUecBA2URxoWmxaGK8/bRNR3Z53/p56
         ywvbfUWsUed2hzfgxNnqfZT5iD8UMLj6uLjxWzrPpOBueVPuabaslEhPukJf7WrIMJzw
         M7MQ/wrCgBMDD5k8GvvmNV+nExlxS9krML9eBZt7aP0ALHIoa0p4E1O7T+mCakjTiRY5
         n07Q==
X-Gm-Message-State: AOJu0Yx9hYl/NJYMTuqq02y3mSQKLTejaqfVSWv2UXzWe3jJTkp6/EcT
	IgqFtZsQCTTfWX9+yaBJCZZyCIGCRRBN0HkBg9vkoale9swCAKBd1OfJTg4EJu7XoKjCyKf4f6B
	WDQ0mrJjTZFxiQDPrSZyWImpyDM6w/aw=
X-Gm-Gg: ASbGncvEDyzNoM/Ljsfe9JkWP3g8qu1FZwkkNmfQqU/1fZItseOjzZJgAsnCwUK6DbB
	GiF2lsElKr1yRiN6BGc0aATRwMANLQuPwMxohxu1Wx41nWyKbwU5mb2BLdSbHAMfCiL+ysYxutp
	yaybQ9X9VShukMm3HQ5RmH9Vo3i+lnvwS1xLI0x9bU8zJO48TiUHsHUZGLCUg=
X-Google-Smtp-Source: AGHT+IEsCrZi4HTv77O1zMlwoeQD3BHr99ocJHxZ4oeAvi3beTe/OhFZ9pUBHdQcaKcrB+8jWsjrJBEe70ZKKC5Um9E=
X-Received: by 2002:a17:90b:2748:b0:313:d346:f347 with SMTP id
 98e67ed59e1d1-3159d911708mr19288877a91.35.1750712043262; Mon, 23 Jun 2025
 13:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619221256.50893-1-adin@scannell.ca> <CAPgzrSXjbBRq-ToY62G_Wxpfzw7izSEC1eBccB2sFOQ3a_b2jQ@mail.gmail.com>
In-Reply-To: <CAPgzrSXjbBRq-ToY62G_Wxpfzw7izSEC1eBccB2sFOQ3a_b2jQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Jun 2025 13:53:50 -0700
X-Gm-Features: AX0GCFuyDLGKvUaxZzIoNd_F-fV8SHXY4l2aQ_ghEJXoGzaDJw2arq5Pfq_zv9c
Message-ID: <CAEf4Bzb7crLj9Xk+xNhyeqeatModiWB+2RvVAYjVf_mBBwKKRQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix possible use-after-free for externs
To: adin@scannell.ca
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 4:39=E2=80=AFPM Adin Scannell <amscanne@gmail.com> =
wrote:
>
> I=E2=80=99ve been advised that I=E2=80=99m missing a couple bits. I will =
resend tomorrow with the branch tag, Fixes tag and a small selftest.
>

makes sense, thanks

> On Thu, Jun 19, 2025 at 11:14=E2=80=AFPM Adin Scannell <adin@scannell.ca>=
 wrote:
>>
>> The `name` field in `obj->externs` points into the BTF data at load time=
.
>> However, some functions may invalidate this after loading (e.g.

"after loading" is quite misleading. You can't resize a map after a
BPF object is loaded. You meant "after open" (and before load), please
adjust the message.

>> `bpf_map__set_value_size`), which results in pointers into freed memory =
and
>> undefined behavior.
>>
>> The simplest solution is to simply `strdup` these strings, similar to th=
e
>> `essent_name`, and free them at the same time.
>>
>> Signed-off-by: Adin Scannell <adin@scannell.ca>
>> ---
>>  tools/lib/bpf/libbpf.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 6445165a24f2..5adf2b68adb3 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -597,7 +597,7 @@ struct extern_desc {
>>         int sym_idx;
>>         int btf_id;
>>         int sec_btf_id;
>> -       const char *name;
>> +       char *name;
>>         char *essent_name;
>>         bool is_set;
>>         bool is_weak;
>> @@ -4259,7 +4259,7 @@ static int bpf_object__collect_externs(struct bpf_=
object *obj)
>>                         return ext->btf_id;
>>                 }
>>                 t =3D btf__type_by_id(obj->btf, ext->btf_id);
>> -               ext->name =3D btf__name_by_offset(obj->btf, t->name_off)=
;
>> +               ext->name =3D strdup(btf__name_by_offset(obj->btf, t->na=
me_off));

this needs:

if (!ext->name)
    return -ENOMEM;


Other than that, it looks good. I pondered the possibility of just
remembering string offset for name, but this becomes a chore to wire
all that up through all the current uses of ext->name, plus we'd need
to switch to qsort_r() for some operations and pass through obj's BTF
instance, which doesn't seem worth it.  So let's just check for NULL
here for correctness' sake.

pw-bot: cr

>>                 ext->sym_idx =3D i;
>>                 ext->is_weak =3D ELF64_ST_BIND(sym->st_info) =3D=3D STB_=
WEAK;
>>
>> @@ -9138,8 +9138,10 @@ void bpf_object__close(struct bpf_object *obj)
>>         zfree(&obj->btf_custom_path);
>>         zfree(&obj->kconfig);
>>
>> -       for (i =3D 0; i < obj->nr_extern; i++)
>> +       for (i =3D 0; i < obj->nr_extern; i++) {
>> +               zfree(&obj->externs[i].name);
>>                 zfree(&obj->externs[i].essent_name);
>> +       }
>>
>>         zfree(&obj->externs);
>>         obj->nr_extern =3D 0;
>> --
>> 2.39.5 (Apple Git-154)
>>

