Return-Path: <bpf+bounces-43886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 343B79BB694
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 14:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE29F1F23518
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 13:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46B370839;
	Mon,  4 Nov 2024 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJFQ3ZPz"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4949414A91
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727828; cv=none; b=HTye6aUF3U8BQlLa6HMWkFcFIrXvcHd9/ZsA6AReC3St4Gj8BF7UjE9h2ZH7dR1v+T/1UOTBE6Wd9c6l9E/blsDKZ86S6LPEftixcv9pZqc7y4sq2xg79Cym7u58wOKCqz5tHgwua63xmPklH7JgT38EJX3GVYj7qgbi7HdG4hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727828; c=relaxed/simple;
	bh=83wa0hJ3Ph4Iuqghy0B7pHyzzRHFxpoQ4rMQtywOrkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BwVhzeHwHAqVV43fIJHiKisHTUdzQclVrVlu0Clo2cwF8m/Y5/CdF+A/PjYwExTtBcjS8pHbRuBJJ7FfaOjbHRg1wjTmhXGe0qoW+Tx4jxFyJCOuFYyydqhX0YaqILd+ZhkP3cDPwo1pTkdq0gHqwBk7YxqfAI+QOgYfBOGpgak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJFQ3ZPz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730727825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XsK05GEcmjQYzOJmvYa3LzYc8KeD2f2CDx7Ms3Tt0c8=;
	b=hJFQ3ZPzs6o7R9BudtQQWCy/03klsbAb//92ayBwEOFH80u3DsuqQMgENE3XQlQYcZl8UU
	Tf/HCrXWxLaSeXtq+SoD7Gr0fuE38aVZsTd0VmvePQA0U9HgesILXyOUXIXMxy+XlOBrEA
	NsDGc5ugw6a0fiwHS3gu5x/m1vAhOzo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-f37zHo5ANvG9bA74DU6-hg-1; Mon, 04 Nov 2024 08:43:44 -0500
X-MC-Unique: f37zHo5ANvG9bA74DU6-hg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315ad4938fso26857225e9.0
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 05:43:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727823; x=1731332623;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsK05GEcmjQYzOJmvYa3LzYc8KeD2f2CDx7Ms3Tt0c8=;
        b=W4jYgUWHWq1TrX/vdmk+HtNAEQu5r7T6FpTZXr9A5HOLL92lSOIIIhwudtI0TQvmA8
         eqwdkdyzfCuptvm8i6bBhDNAsAMluoS6ma1/Nd4XmxgvQtpCCcExuQhN/VkBrcrXggIr
         g7TzvWu+oqKOjw/AmTu3d1c43WSdvp9FM0z46TDBHG3xpS40kjVneoUeKjaSs2o7KEnY
         K8iZ/uhx34+dcKs8aNrKGNK0L97o5U5Mr9pKkyUxL6wsFkIXu9SHtLJXMv0bHSybVDud
         q8ZON8JwwdfYPyJwj4cO0dr2P0ioqsmYOA1BaQV0Pyi1fBNi4hRXjfQK6zaKzjW8w0te
         gv0Q==
X-Gm-Message-State: AOJu0YxB7+ACU7XOCqdVCuSYJO7nF9E8gVq985U3vdxy6ezDiuQHSHB8
	mufoqEGfnodtglctAAcVQ/tgpyX3nDX/DQtLDshMjgHI+3+/HmYdGSKECObC6kAJXyV1ds0Kf93
	tvNoQ+w9TnhLv62n3DfmjHK8YCivqTMLFvttuSulAm3bB8bXnfA==
X-Received: by 2002:a05:600c:500a:b0:431:561b:b32a with SMTP id 5b1f17b1804b1-4319acb8ce7mr293679955e9.19.1730727822866;
        Mon, 04 Nov 2024 05:43:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOX75jfsIBy4FUx99LG6zJI2P3FPcjP9P8/AWN4W8lBqdid1SKeuObnXZh/Lk72vkX8haz2w==
X-Received: by 2002:a05:600c:500a:b0:431:561b:b32a with SMTP id 5b1f17b1804b1-4319acb8ce7mr293679625e9.19.1730727822529;
        Mon, 04 Nov 2024 05:43:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116b0dasm13343373f8f.102.2024.11.04.05.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:43:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9D434164C033; Mon, 04 Nov 2024 14:43:40 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Viktor Malik
 <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH bpf-next v3 1/3] selftests/bpf: Allow building with
 extra flags
In-Reply-To: <CAEf4BzZ_kB3YaeA5c2cB7dyiaJna4nGBtww9n0fS_b1d-ZtMGQ@mail.gmail.com>
References: <cover.1730449390.git.vmalik@redhat.com>
 <6cb7d34d0ff257deaf5bb818ac4bce3c95994d29.1730449390.git.vmalik@redhat.com>
 <CAEf4BzZ_kB3YaeA5c2cB7dyiaJna4nGBtww9n0fS_b1d-ZtMGQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 04 Nov 2024 14:43:40 +0100
Message-ID: <87a5ef9ks3.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Nov 1, 2024 at 1:29=E2=80=AFAM Viktor Malik <vmalik@redhat.com> w=
rote:
>>
>> In order to specify extra compilation or linking flags to BPF selftests,
>> it is possible to set EXTRA_CFLAGS and EXTRA_LDFLAGS from the command
>> line. The problem is that they are not propagated to sub-make calls
>> (runqslower, bpftool, libbpf) and in the better case are not applied, in
>> the worse case cause the entire build fail.
>>
>> Propagate EXTRA_CFLAGS and EXTRA_LDFLAGS to the sub-makes.
>>
>> This, for instance, allows to build selftests as PIE with
>>
>>     $ make EXTRA_CFLAGS=3D'-fPIE' EXTRA_LDFLAGS=3D'-pie'
>>
>> Without this change, the command would fail because libbpf.a would not
>> be built with -fPIE and other PIE binaries would not link against it.
>>
>> The only problem is that we have to explicitly provide empty
>> EXTRA_CFLAGS=3D'' and EXTRA_LDFLAGS=3D'' to the builds of kernel modules=
 as
>> we don't want to build modules with flags used for userspace (the above
>> example would fail as kernel doesn't support PIE).
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>  tools/testing/selftests/bpf/Makefile | 34 +++++++++++++++++++---------
>>  1 file changed, 23 insertions(+), 11 deletions(-)
>>
>
> Ok, so this will conflict with Toke's [0]. Who should go first? :)

I'm OK with rebasing on top of Viktor's patch :)
>
> And given you guys touch these more obscure parts of BPF selftests
> Makefile, I'd really appreciate it if you can help reviewing them for
> each other :)

Sure, can do!

-Toke


