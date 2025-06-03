Return-Path: <bpf+bounces-59481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92A8ACBF4F
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 06:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99A83A4924
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 04:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BAC1F2C34;
	Tue,  3 Jun 2025 04:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3rY+LNWd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6EC2F42
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 04:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748926079; cv=none; b=BuZs73hvih4Sz+aFV4tbX2Yw8UAanKabim24Ix9svffSiE4pfWrNo71DVDcRQ3vpSPApCmzW3wuj9I75iKZCViGj0ajXJuhxXtFgyzCgN2qZ7O0MgTVz3v0SmNATpUabJ/uQuWOx6c3+FGHOFkoeVp7wqbpCI669Vy2JZ4OtGTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748926079; c=relaxed/simple;
	bh=Cgf4uJUUkUndlqeoRIwJ1DirxTrSOgGNFLZSraEodVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tpko+mggRLLnpHop8n4Zd4wRkbDHVWxike+Pa/qVuRe9huSA32HvaDg0gWF9/28R+GEkCPz7dxiZ96dlH95EoRrQ97h23274xL8iiy78FvtGE/yiRzNxwVfLdjc8PQUgc722j1Dcwjzi/N5xoPrdIPLcu3Oz75Kfi5b/Y3L9zj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3rY+LNWd; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4e5a1a4e4aaso1715888137.0
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 21:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748926075; x=1749530875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJEm8CuAi/t+jAarwCEcsP7zVwYAqs3E2ajamXZGJEU=;
        b=3rY+LNWdjkNR7/D9MZNOnHUY3PiBVm0ZOoOwK/umEWr7uVeP07RrID5GpJdN+sSk3v
         GntYl5ghr4JDWxlqemZfLB2quNmGxwzM3zAme0BAqO14AteQwRYX17rfrAHmlxPo3BtN
         zHsRYxwxT8xBTLSi1Ju/lWgeH1hNz0TlI5mfMkSOdlQBFyY2Kh+c94pFDQ6Uyn3eSE32
         fERZEXY/z9CVAA20ax6Ew9NUUXUjjqAUwjhf2q/hB1J0tjQhSpUJ6a0kKRpsE2vIbau9
         dD4gx16dxrXM4Z5sYc0L4pa6ZqkJZsWo4yPMxPzF//sphBADFruLvqaJypYqhcUp8SLY
         ZLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748926075; x=1749530875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJEm8CuAi/t+jAarwCEcsP7zVwYAqs3E2ajamXZGJEU=;
        b=LK+GfsxOUAc7colrTGOK3ZUV6B7qP7QxftBQ+Yr3StAgXUMxqhstZxapN/ALfl+MeZ
         o6+qxpKPD9Iru4/Il1zc75dJa4EK44qlhIo/hJYfNWHS8K9qxjOp2f+LKxBhXiGE0ouJ
         EJ874rk7r6SXxaNkmE7x0qpamK0hjoHYWHyIvRCSQKdKdbvqDws1aTmEKRlW9SWcog2g
         iS3YzHGzFoaJlDzudtOXNF8iqFt7n47jjLSbGvxYPGiMPK3N5dQX7ybJxzJXFmTYdFv7
         NKf8IiYSfQbO1YuhE7Wr9+IoWCacXofnq84Kd7+0bfo9vxEnkICIGWXG6G45kdGrqz3f
         ytRw==
X-Forwarded-Encrypted: i=1; AJvYcCWEdxbtTLy5PYAT+wp4jwMDviDX9kZEL60rtZikBF1kVhdgDR0ZrqJ3o/2U1zQXOzHZb+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6cXRVbUGQnXL46yAiL58FL8x1oqWsJSEqm/H/KbtfjQjVTTQQ
	eeWOHaFcH7u2yHkkGHznYlLNkbyJYKadCxpbEeW3ohqQ5fKwiR9QobKhbOSMUKF1ofSt5NW1b3O
	XwwHUkDjRO8dLGNhlqddlQ6HAwvID+rPFqEdcZaiN
X-Gm-Gg: ASbGncvJBNEyiTccI6KP2ZCQzLk5dL1z9YgZdbdt9AGVIWErgGwuT9xCXn83/uvgTXR
	/mgtnxTGIsPG1VNw3UiREiRMPRvxkNITweJEyD06LU/YzjHML2QacB7rm4tsD+I7f1KkS04zmCJ
	GYDDYe5Z5cmAF3WJScoy2Q6kkFu9ILQg6leWGE7d/0R+uBjRPCrMJl/A==
X-Google-Smtp-Source: AGHT+IEpIjGceN2rv1hrs1pvu0Ely5BSyrBVy6Mmn3bTojzhqzoFXABgDgARO99epxYcLU46y74uRkrGE51OEqI32QE=
X-Received: by 2002:a05:6102:41a9:b0:4e5:acea:2dec with SMTP id
 ada2fe7eead31-4e6ecd568f9mr10344192137.7.1748926074812; Mon, 02 Jun 2025
 21:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531072031.2263491-1-blakejones@google.com> <CAEf4BzapWKWVzPFeZN5Ms6tOMhrtfpd8aiKenHgf4K4_1fhqMg@mail.gmail.com>
In-Reply-To: <CAEf4BzapWKWVzPFeZN5Ms6tOMhrtfpd8aiKenHgf4K4_1fhqMg@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Mon, 2 Jun 2025 21:47:43 -0700
X-Gm-Features: AX0GCFscdET_wsUXTylJujBnbhv9BhHKKV6VK3h7Z8lQxMbBW9ESGrRePttAXKM
Message-ID: <CAP_z_CgGAFydp2qVGtUEive=ipWToqzuO-7w13PBSHVhYzhhdQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add support for printing BTF character arrays as strings
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrii,

Thanks for your careful review.

On Mon, Jun 2, 2025 at 5:06=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> > +       bool print_strings;     /* print char arrays as strings */
>
> let's use "emit_strings" naming, so it's consistent with emit_zeroes?

Done.

> > @@ -75,6 +75,7 @@ struct btf_dump_data {
> > [...]
> > +       bool print_strings;
>
> ditto, emit_strings (and maybe put it next to emit_zeroes then)

Done.

> > +static int btf_dump_string_data(struct btf_dump *d,
> > [...]
> > +       if (!btf_is_int(skip_mods_and_typedefs(d->btf, array->type, NUL=
L)) ||
> > +           btf__resolve_size(d->btf, array->type) !=3D 1 ||
> > +           !d->typed_dump->print_strings) {
> > +               pr_warn("unexpected %s() call for array type %u\n",
> > +                       __func__, array->type);
> > +               return -EINVAL;
> > +       }
> > +
>
> IMO, a bit too defensive. You literally checked that we have char[] in
> the caller, I think it's fine not to double-check that here, let's
> drop this

Done.

> > +               if (c =3D=3D '\0') {
> > +                       /* When printing character arrays as strings, N=
UL bytes
> > +                        * are always treated as string terminators; th=
ey are
> > +                        * never printed.
> > +                        */
> > +                       break;
>
> what if there are non-zero characters after the terminating zero?
> should we keep going and if there is any non-zero one, still emit
> them? or maybe that should be an extra option?... When capturing some
> data and dumping, it might be important to know all the contents (it
> might be garbage or not, but you'll still see non-garbage values
> before \0, so maybe it's fine to always do it?)

I was thinking of this option as being optimized for common-case
pretty-printing, rather than being the ideal tool for displaying arbitrary
character arrays. If there are garbage values that are worth displaying,
btf_dump() without the ".emit_strings" option would still show them.

> > +static int find_char_array_type(struct btf *btf, int nelems)
> > [...]
> > +               if (btf_kind(t) !=3D BTF_KIND_ARRAY)
>
> btf_is_array()

Removed, in light of your next comment.

> > +static int btf_dump_string_data(struct btf *btf, struct btf_dump *d,
> > [...]
> > +       snprintf(name, sizeof(name), "char[%zu]", ptr_sz);
> > +       type_id =3D find_char_array_type(btf, ptr_sz);
>
> instead of trying to find a suitable type in kernel BTF, just generate
> a tiny custom BTF with necessary char[N] types? see btf__add_xxx()
> usage for an example.

Ah thanks, that's a much better approach. Fixed.

I'll send out an updated version of these changes with the
comments I've received so far.

Blake

