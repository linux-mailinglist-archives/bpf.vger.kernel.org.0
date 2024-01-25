Return-Path: <bpf+bounces-20350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FD883CF03
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 22:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E496B2805E
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 21:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E469713AA4D;
	Thu, 25 Jan 2024 21:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxKf+SYp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E2E131E4F
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219810; cv=none; b=GhnKyZ4uNesWGvDWVnghhBV/MCNaG/8LKgoZIy4gyZ2qZaB8H0YRB13D+0vOzG2U1QThBEemzKkbRFO0YKpeFh0DxOIOVYReIt+x3SFXzQCNezdAKfpKQjrpo/XIErchPNG9VBjEOLMp5UeNyyiks8hapWQNRD/MfL8m3LsNnzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219810; c=relaxed/simple;
	bh=dqSnzfb6Z4viJ8uMvO2JPybW2xGnUswXh/eI2HqErWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMRoW+2RuM62PaUkZOrgvn+3PeEyHUCzDnMXyNZhkpHsk89cLTklJpU+/WSj3eakNLbTZ0tVn9yNkBp30dUzJ26jXF8xBEikFpvdpWmyNi59RIKqXNMAFkp5ltzp0hEkoi0XP6KVBAHtOycQe531pLsLYbH0abr73KetJ+8AGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxKf+SYp; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so944167a12.1
        for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 13:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706219808; x=1706824608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGSDIpHF8U7Omg/MChYndYo89UsYOs9IzFERGt8PlMA=;
        b=LxKf+SYppNwgwkgAt2fcGLVyehd0u6sC7ZCsn607D6QmbnuL4KhOMLJANCjvLmLGqx
         pFe3RFfzxMuobrvaB5osXPqW4w8MYlvUMKppfPhQ8jD3OV36vyM6Hi5LQaPOMWlruh9P
         f4SBg4clfJpnURcpNn1vYAWjci1mar7gxvEC/QVEnXuBqkvbyilQzw6XIQv+YWtLUM97
         hHFlPjYkoVsduyLv0VwFkZ2afUPYSLyUH5Ax4Q/zEmnmTVGiijwdrA0eM4lYEstw1nDB
         pUXwJaXl4SGjS02r7ZJI/6ayvRlZMyVq0K/SVbiUMLv+DqK2O2v7eKhQ8LRNfUAPZqAh
         Y9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706219808; x=1706824608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGSDIpHF8U7Omg/MChYndYo89UsYOs9IzFERGt8PlMA=;
        b=aptcwCSn3LMp2CIn0wr3n+sSOZ3Q8oHCsqfJiT2Z3rkHkPo/gErZcS92+zMzDrufhy
         ZS4VwmniBMmv0JpqW9e3Ze2x2dFuMJ7DPhKut04AO9sVtNDAAdgC2RHC4iNfDMscaEPz
         8XMnzwCGdLF5bd566lrl/WsibWcwjOZXwbZlHNsAIFt0eQjw2aTiFXLHKrLmhSEUO+t5
         tAxZom/RdpW/STG5/yKjnwjF5FPlgeZbsPIzeIt+aWaw3iP09gjSS1drstw4za0Kw6O2
         Mu3PYXrISZipXNBRU4cDuXX01NHIENgpVDWHYDiibfOpu4zZAM8jHsfbyK8f9QoR/RVX
         eQOg==
X-Gm-Message-State: AOJu0Ywe5n0Zl3cN80Nc+9tbP8uDgswnHRds4xukABLeCZVLSnbqib0m
	ZTm0eEC4XcL+VXrcAHCeu8+9ISZKh97nlm6p9ubhX5oo5xh7PBPkt2zWjHax3S3UhD8yCaAs91k
	cv3RbqltU1PffkDHU3NQPZFoawCo=
X-Google-Smtp-Source: AGHT+IHQCm0BRnKtvP6j+a8ITPS+IKrlyn4o46wPEZSbzJd7uPCd2w6d2Kog2qxqJ1ACd4U+bsDn6yTzUDc4HMZv+uY=
X-Received: by 2002:a05:6a20:3b9e:b0:19c:6746:7ddf with SMTP id
 b30-20020a056a203b9e00b0019c67467ddfmr221109pzh.29.1706219807925; Thu, 25 Jan
 2024 13:56:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <875xzhzm2o.fsf@oracle.com>
In-Reply-To: <875xzhzm2o.fsf@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Jan 2024 13:56:35 -0800
Message-ID: <CAEf4BzYwPb55URks8P6wTJGvqYT=6gdh2RLU+=ri2rfABeDVaQ@mail.gmail.com>
Subject: Re: Anonymous struct types in parameter lists in BPF selftests
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@meta.com>, 
	david.faust@oracle.com, cupertino.miranda@oracle.com, 
	Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 3:31=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> Hello.
>
> In C functions whose declarations/definitions use struct types or enum
> types (or pointers to them) in the parameter list, the scope of such
> defined types is limited to the parameter list, which makes the
> functions basically un-callable with type-correct arguments.
>
> Therefore GCC has always emitted a warning when it finds such function
> declarations, be them named:
>
>   int f ( struct root { int i; } *arg)
>   {
>     return arg->i;
>   }
>
>   foo.c:1:9: warning: 'struct root' declared inside parameter list
>              will not be visible outside of this definition or declaratio=
n
>     1 |   int f(struct root { int i; } *_)
>       |         ^~~~~~~~~~~
>
> or anonymous:
>
>   int f ( struct { int i; } *arg)
>   {
>     return arg->i;
>   }
>
>   foo.c:1:9: warning: anonymous struct declared inside parameter list
>              will not be visible outside of this definition or declaratio=
n
>     1 |   int f ( struct { int i; } *arg)
>       |           ^~~~~~
>
> This warning cannot be disabled.
>
> Clang, on the other side, emits the warning by default when the type is
> no anonymous (this warning can be disabled with -Wno-visibility):
>
>   int f ( struct root { int i; } *arg)
>   {
>     return arg->i;
>   }
>
>   foo.c:1:18: warning: declaration of 'struct root' will not be visible
>               outside of this function [-Wvisibility]
>     int f ( struct root { int i; } *arg)
>
> But it doesn't emit any warning if the type is anonymous, which is
> puzzling to some (see
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D108189).
>
> Now, there are a few BPF selftests that contain function declarations
> that get arguments of anonymous struct types defined inline:
>
>   btf_dump_test_case_bitfields.c
>   btf_dump_test_case_namespacing.c
>   btf_dump_test_case_packing.c
>   btf_dump_test_case_padding.c
>   btf_dump_test_case_syntax.c
>
> The first four tests can easily be changed to no longer use anonymous
> definitions of struct types in the formal arguments, since their purpose
> (as far as I can see) is to test quirks related to struct fields and
> other unrelated issue.  This makes them buildable with GCC with -Werror.
> See diff below.
>
> However, btf_dump_test_case_syntax.c explicitly tests the dumping of a C
> function like the above:
>
>  * - `fn_ptr2_t`: function, taking anonymous struct as a first arg and po=
inter
>  *   to a function, that takes int and returns int, as a second arg; retu=
rning
>  *   a pointer to a const pointer to a char. Equivalent to:
>  *      typedef struct { int a; } s_t;
>  *      typedef int (*fn_t)(int);
>  *      typedef char * const * (*fn_ptr2_t)(s_t, fn_t);
>
> the function being:
>
>   typedef char * const * (*fn_ptr2_t)(struct {
>         int a;
>   }, int (*)(int));
>
> which is not really equivalent to the above because one is an anonymous
> struct type, the other is named, and also the scope issue described
> above.

"Equivalent" in the conceptual sense to explain arcane C syntax.

>
> That makes me wonder, since this is testing the C generation from BTF,
> what motivated this particular test?  Is there some particular code in
> the kernel (or anywhere else) that uses anonymous struct types defined
> in parameter lists?  If so, how are these functions used?

I don't remember, but I'm not sure I'd be able to come up with such
monstrosity by myself (but who knows...) I used vmlinux BTF and kept
fixing and improving BTF dumper until I could dump everything in
vmlinux BTF and make it compile without warnings (that's my
recollection). So I suspect there is something in kernel that uses
similar kind of declarations.

>
> I understand the code above is legal C code, even if questionable in
> practice, so perhaps the right thing to do is to build these selftests
> with -Wno-error, because the warnings are actually expected?

Is it possible to have #pragma equivalent of -Wno-error? That probably
would be best. But yeah, we can just add -Wno-error to
btf_dump_test_case_syntax.c in Makefile, if it's just one file.

>
> diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfiel=
ds.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
> index e01690618e1e..7ee9f6fcb8d9 100644
> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
> @@ -82,11 +82,12 @@ struct bitfield_flushed {
>         long b: 16;
>  };
>
> -int f(struct {
> +struct root {
>         struct bitfields_only_mixed_types _1;
>         struct bitfield_mixed_with_others _2;
>         struct bitfield_flushed _3;
> -} *_)
> +};
> +int f(struct root *_)
>  {
>         return 0;
>  }

Changes like this are fine, if they don't change the order of type
outputs (i.e., if tests still succeed with these changes, I have no
objections).

> diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_namespa=
cing.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_namespacing.c
> index 92a4ad428710..0472183ed56d 100644

[...]

