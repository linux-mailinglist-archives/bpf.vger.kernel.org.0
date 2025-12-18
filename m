Return-Path: <bpf+bounces-76948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4D3CC9ED1
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 01:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6926F30456B1
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 00:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ACC221578;
	Thu, 18 Dec 2025 00:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEKqQ1ZH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE4917993
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 00:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766018951; cv=none; b=Gk7Vuygig+l4+0aiB3k7BwAzETgg6x5wAPcDZSOHMCjtg78U1dj1+VhAhku3f7zsempQFVeqafrJsKPTjdxqCnIlBiyrFG69zfJYLHLenkSISq3q9K0XvIGnWxeks1kdeLInqzDzy9y+P1Z2nF0cdE6miJTps2fxlQd2A+t2xn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766018951; c=relaxed/simple;
	bh=le1mPme5fNjxqJJHp8sDz9Vlf574hFhWchTA0WANn3U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CAeGOXbASyGBl93388FIwlzgQ+lF4kbkS+UGi36XZu5IHh8yMiuW3AUJl10JhOiFt8w67UeKjYy2/jHEmdxaDzOyodDzKL+7i+oY4s/ZlK89oyUj7GUF8LYuQHgKVlyhNThSQiJXSXbdhfyCNz3GJol9NV1NSF+HkzGQy+fArZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEKqQ1ZH; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bf5ac50827dso59715a12.2
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 16:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766018950; x=1766623750; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=le1mPme5fNjxqJJHp8sDz9Vlf574hFhWchTA0WANn3U=;
        b=nEKqQ1ZHJggroXc1faH17kyAg+8PQVUeORB27YZxJKJsdv9WbDRoKHkxEGPjuCy7kj
         pvzzsMNO57fczxZyc2MM7JqdWhptayXvwQ+IcaHlKrh/7ld9alLcOIGBSCIpcNgWZx/k
         7rqEkwhlXkGYIdpSm8yGKf9Gm+v/EvES+8L7CcqZTv0ZQW1TMdgD6nDsK7s4WGTxtRa+
         uz+fPBeLDT63Tom6acz1SrWeVyDq0SFYvBsnuT0TiaW7fwo5KKNp0rdrT5pCdpw+bdL2
         QcWyg5ouJgQdaygQrQ7mPown4JDXXBDTwVmGKW46xl0o438TmmFdDYvCDjv/8XC++p8o
         kIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766018950; x=1766623750;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=le1mPme5fNjxqJJHp8sDz9Vlf574hFhWchTA0WANn3U=;
        b=kGmuJn5SbzTjupcs0raVtQSaWKh9bw+SgggoKJ7dZXdGm6Qtll0YSBUpSjSZjfOXeJ
         2Jw4jZ4/7eAqQFXmJFxEOUlAID3gfmowM8bwJxn8ZDT+/noVbwHwg7GskBDe9WfHC8i8
         +OsxLEbAVEMUvLdcdsTXNp5rmVEAnTzQhA5I0StDdd0BAlJtlkR7mf33jpI6ejsdN7Ef
         2c9SP/z0Vg5FjXQ58p916Nxx7Y/3pDFoWSZEkBfe1JuNDU4qmEv1WTm7YLZQg9TS+LEc
         MnSLrxY/WVGhbTvlSuyjdv3R6v4zY7kRmUQ2wZ5gwYtZllJzKgIKEndSPY+9q5NZxUho
         o9/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQO39hahh8fvvC0FwBG0nLB1ew/0IURD1FokjQKquUfERLgVw/bSvnIC8inkeii7s5Hls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVGwL4EDaOwb1LQ9P9GiXcYUu9vPez41SvTPuDJOh9J+C1qMnN
	uzjhFklS66PsQQwyMHs05FhRe3+akKN5zQqyYWf3JZ7ImlhAkwxevS5w
X-Gm-Gg: AY/fxX4TFvHckH3ZEPhJ0g8DB7EKM6I6YHuqm+6feS+/91UL5VbqwIBfrSkB2gIeay4
	Mg7zEqY19UXTWY9B59+k3sD5kWerdhw95063bSz08uV7TbQ5FA/rq1rzWBV5zc+frmAQjA4WvOz
	So/QppTOrD0q+cuL7K0Rr6hjleQ85mvmc1iTvVvCg8kPxL5t+NNJ7h9J6/YwSh2pG5nCg8Ses1J
	PXokfXKn16eXGV+hvHjHTDIz2dJkRKIZPtxKGc5V351gpewwqTsIGg5vBEvOLNuRu3k1XmWL0dH
	pu9UZI5FJ3luTMYAnaCvmsKDkdztP/VTwK5WcpDE+YTfS07MBqaZzaZWVNeWzwhqq+FSUulvVwq
	GaKWloDg21iMyr6mnwSIros6LifjDmLSggnqWb10ZYllWG+3n0yjAhLFk9D/aQlmC42pLLFT0VR
	OPkYaVa6oPwlF1EIOwV4LsoHiIF1srmvplh25l
X-Google-Smtp-Source: AGHT+IF6XOygEpKO220KMKDeUp4j011LsHvZ7TXDz2wa7fX8XyTpjFk6vdWMB99dTFR5UuA2kvb8hw==
X-Received: by 2002:a05:7300:b28:b0:2ae:51ae:5cf3 with SMTP id 5a478bee46e88-2ae51ae5fd1mr4536650eec.6.1766018949492;
        Wed, 17 Dec 2025 16:49:09 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:9f95:2f12:bb69:e3e6? ([2620:10d:c090:500::7:a4ff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b04e87b4d4sm941179eec.16.2025.12.17.16.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 16:49:09 -0800 (PST)
Message-ID: <4249d7ea924491da5d95f6dab60c7cf4da742bae.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize
 nested structs for BTF dump
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Quentin Monnet <qmo@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf	
 <bpf@vger.kernel.org>
Date: Wed, 17 Dec 2025 16:49:07 -0800
In-Reply-To: <CAEf4BzaRxvM9C2+FvUViJqFJPTMTv6uoWc8i1taEzijdJOddwg@mail.gmail.com>
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
	 <20251216171854.2291424-2-alan.maguire@oracle.com>
	 <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
	 <9a096b2a16d552031a12f3f4f5a2c725212df5e6.camel@gmail.com>
	 <b535b47a-519e-4138-861b-c16ed7fa0bcd@oracle.com>
	 <CAADnVQ+EyYO+aOZewNQwETr5rphOCp6jJQH_fw9GqjVFdQd19A@mail.gmail.com>
	 <CAEf4BzbWZtRdKCGwhjRV9MOufTC-coWFSU5sRtk4gdm9S_bg+w@mail.gmail.com>
	 <6ae6dfd8-3f73-4318-93c1-97541d267a28@oracle.com>
	 <CAADnVQ+wNPbbA0e4+6kx+LtOH=09jJyiYcEKZfc8kt6UPnq=EQ@mail.gmail.com>
	 <535846f7-4cc7-4b12-aab4-52e530d04706@oracle.com>
	 <ae6c6e50b3176d4ee4cce4cda09807a05d103fbf.camel@gmail.com>
	 <3071012cc1e8d6bdf16b13d371a12cb201c502a7.camel@gmail.com>
	 <b65fd7dc-fbad-4a96-8eb8-f36f8f518d44@oracle.com>
	 <CAEf4Bzb+3cryZAEwC_O7xgm3=cthZU-SNsUWfGH8OpSwc+3vaw@mail.gmail.com>
	 <CAADnVQJ1V1vwPVnhyE4OfOSQt_BnB3wRW9g9_bhkdu-QZyuQkQ@mail.gmail.com>
	 <CAEf4BzaRxvM9C2+FvUViJqFJPTMTv6uoWc8i1taEzijdJOddwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-17 at 15:52 -0800, Andrii Nakryiko wrote:
> On Wed, Dec 17, 2025 at 1:27=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >=20
> > On Wed, Dec 17, 2025 at 1:02=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >=20
> > > On Wed, Dec 17, 2025 at 12:50=E2=80=AFPM Alan Maguire <alan.maguire@o=
racle.com> wrote:
> > > >=20
> > > > On 17/12/2025 19:35, Eduard Zingerman wrote:
> > > > > On Wed, 2025-12-17 at 11:34 -0800, Eduard Zingerman wrote:
> > > > > > On Wed, 2025-12-17 at 18:41 +0000, Alan Maguire wrote:
> > > > > >=20
> > > > > > [...]
> > > > > >=20
> > > > > > > So maybe the best we can do here is something like the follow=
ing at the top
> > > > > > > of vmlinux.h:
> > > > > > >=20
> > > > > > > #ifndef BPF_USE_MS_EXTENSIONS
> > > > > > > #if __has_builtin(__builtin_FUNCSIG) || defined(_MSC_EXTENSIO=
NS)
> > > > > > > #define BPF_USE_MS_EXTENSIONS
> > > > > > > #endif
> > > > > > > #endif
> > > > > > >=20
> > > > > > > ...and then guard using #ifdef BPF_USE_MS_EXTENSIONS
> > > > > > >=20
> > > > > > > That will work on clang and perhaps at some point work on gcc=
, but also
> > > > > > > gives the user the option to supply a macro to force use in c=
ases where
> > > > > > > there is no detection available.
> > > > > >=20
> > > > > > Are we sure we need such flexibility?
> > > > > > Maybe just stick with current implementation and unroll the str=
uctures
> > > > > > unconditionally?
> > > > >=20
> > > > > I mean, the point of the extension is to make the code smaller.
> > > > > But here we are expanding it instead, so why bother?
> > > >=20
> > > > Yeah, I'm happy either way; if we have agreement that we just use t=
he nested anon
> > > > struct without macro complications I'll send an updated patch.
> > >=20
> > > There is a little bit of semantic meaning being lost when we inline
> > > the struct, but I guess that can't be helped. Let's just
> > > unconditionally inline then. Still better than having extra emit
> > > option, IMO.
> >=20
> > tbh I'm concerned about information loss.
> >=20
> > If it's not too hard I would do
> > #ifndef BPF_USE_MS_EXTENSIONS
> > #if __has_builtin(__builtin_FUNCSIG)
> > #define BPF_USE_MS_EXTENSIONS
> > #endif
> >=20
>=20
> Concert I have with this is that we'd need to hard-code this
> bpftool/vmlinux.h-specific #ifdef/#else/#endif logic (with arbitrary
> and custom BPF_USE_MS_EXTENSIONS define use) for -fms-extension
> handling inside generic libbpf btf_dump API, which is not supposed to
> be vmlinux.h specific.
>=20
> Wasn't there a way to basically declare -fms-extensions using #pragma
> inside vmlinux.h itself? If yes, what's the problem with using it? Why
> do we need to work-around anything at all then?

Can't find anything relevant in [1] or [2].
[1] https://clang.llvm.org/docs/LanguageExtensions.html
[2] https://clang.llvm.org/docs/UsersManual.html

Google's LLM doesn't know about such pragmas either.

> > and it will guarantee to work for clang while gcc will have structs inl=
ined.
> >=20
> > In one of the clang selftests they have this comment:
> > clang/test/Preprocessor/feature_tests.c:
> > #elif __has_builtin(__builtin_FUNCSIG)
> > #error Clang should not have this without '-fms-extensions'
> > #endif
> >=20
> > so this detection is a known approach.

