Return-Path: <bpf+bounces-18959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74994823906
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 00:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874DC1C2469D
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 23:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2250D1EB3C;
	Wed,  3 Jan 2024 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZMYzH/t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C61EB31
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 23:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-336990fb8fbso8624603f8f.1
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 15:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704323540; x=1704928340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRCTq042WJO3fJ+l1WqM7AHwSsug02xfSOJhZLS/Krg=;
        b=gZMYzH/trjVX1eDbl7J3OIMjJIzbLoiRRaV3p51HuC0lck8L+ZKyGtJnwgA5ZnAtfe
         zHNcR+7HxqYM6CxKKHKSgDXLX2HuJmik7kuWEVVDsODrFkH4X6sOygPSdm+z0nNIppnS
         TrjRmAVNdPqEVNse7EBF3hRdtmrnPg7JwA9eq88NWQcJUiS6d/tq27xy41HN7w6mwVPR
         itzeIy3avCD+GS6hIqwkebbIFg9ean+scHBJYXSPNErF8/lU4bdLrtZ9O9gJCFgIt0AD
         syCSL/2mhDFol2hxwK53UMC3YIVD6A8y7SeoyOMm+AaXJIElUn25PfuRdfwUumh80KR5
         ASwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704323540; x=1704928340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRCTq042WJO3fJ+l1WqM7AHwSsug02xfSOJhZLS/Krg=;
        b=nUQsMewpfEOriFGkBO4tr/3JdhJSwlaMal/Vfg+A4Sz99b2T45cAdwLwZ5QqNDKqOC
         onk6YOYIBzEbMbiubhUAteQAKULg8iNqXOnBHYUr2KSxbkLEc1s8Rk52wC5PIhn5527f
         E8h6VkZCBNkSYjauLiGbfVLxMD75xnXzJibt24A1aYmjkwyYY+dEU0NFc11tJv9bRSIK
         ufCUDfPk6w0a7Fg76npzX/8jCEDW3i6no8l+9cJVveTCQSmbDV46C4B53kTNv1qI4De7
         i+XKRoXAD/IZY4h7KVtrglBLqwTL2giQfzQ2SwYs0eeL+4s6aXOVtpa7NJ7pGA1YKt47
         SG7w==
X-Gm-Message-State: AOJu0YwYmGT3ayCq7rgaqqnl2+X7YDeJhxoJSRN5PQyC9XQXWg8GEgix
	rRegtScNgw8xezkZ+SRqq+ulWrGnl6G2lkEa8Tw=
X-Google-Smtp-Source: AGHT+IHj6TG8XH97mAV5Fwz4xm5I8AQSa2Rs0BDdj2z7v9wfracQWJdYWYdA7klEi+VUC0tWkmtwgmt/RweOmf57YP0=
X-Received: by 2002:a5d:6da2:0:b0:337:3a69:806e with SMTP id
 u2-20020a5d6da2000000b003373a69806emr3924717wrs.140.1704323540234; Wed, 03
 Jan 2024 15:12:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102190055.1602698-1-andrii@kernel.org> <20240102190055.1602698-2-andrii@kernel.org>
In-Reply-To: <20240102190055.1602698-2-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Jan 2024 15:12:08 -0800
Message-ID: <CAADnVQ+XcewF3aQm1itG_8GDOEbgRZLknYPyK_JuCjzQJ4=+_w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/9] libbpf: name internal functions consistently
To: Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:01=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> For a while now all new internal libbpf functions stopped using
> <obj>__<method>() naming, which was historically used both for public
> APIs and all the helper functions that can be thought of as "methods" of
> libbpf "objects" (bpf_object, bpf_map, bpf_program, etc).

I don't think this shift to single underscore was discussed before.
I could have missed it. Personally I was under the impression that
we're still doing double for methods.
This convention came from perf, since back then
libbpf was part of it and perf is using double everywhere.
For external api-s and for internal functions.
I feel we should continue doing double for existing objects.
This rename feels too churn-y.

At the same time I agree that a public function looking different from
internal is a good thing to have.
We have LIBBPF_API that is used in the headers.
Maybe we should start using something similar in .c files
than there will be no confusion.

Not a strong opinion.

Eduard,
what's your take?

