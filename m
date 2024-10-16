Return-Path: <bpf+bounces-42248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C83649A15BD
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 00:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706DD1F22DBD
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 22:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D96C1D4169;
	Wed, 16 Oct 2024 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdM97qLL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF8914EC47
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729117138; cv=none; b=ZeF3+x1p89b60x0NUUWC7r/cZh93Wt55mcJbQXOtGUlcWmHbxD0/wfCrBBDXtWPjgj0zAySmcWEbdF5apZG9ZrS0DHmZN61gesj/HwLYZIxV8mAOb8+q++Rc+txb0VlsjgC3fEK/fqO8h/EG2DnvAM+zOmpP0lOO26zUBxucmmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729117138; c=relaxed/simple;
	bh=Fe6+xGzl6Uo0953U+p/DYb85hpULEorJSCHIoYA/3uk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JS2LzWdrQ+AfqIsV+mhCpDzbRwU3cj4+u8PxNg+Cd/m8Bw2MEOVhKdM8yzdaRXIfMXNjfrpYvbfJUN8ndirkHfcG1n+AXkilvKwlosAoyaizJjYVanJfryOTmhh9ZLQ72hU6hy5JMFqvaY+zpZWo6bA4Swpo+T6t2jHGlw0v/xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdM97qLL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e49ef3b2bso202698b3a.2
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 15:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729117136; x=1729721936; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m9lG3UFqivqt8ceQwz6YRRlLk0aVwUnww1pm6vvyweU=;
        b=VdM97qLLXZV/vAgsi9HPNYNspY64sxRhFPTo+a7oNuV4dCKwzV9xiqM504NL+G9Fg/
         qzL1qLB8WZplsP+wsGoa1Wlig1FC7QkrFGUUQuWC/GBduKaiylaBcZA5moXDQ7kbVley
         sjVcySdZb0kLFJA0+7qwWo0Dpm4+JZPxKR+qHv0XjYPkekLzEsmEVo7bPC/FWg45GOyf
         bmLG9Xgh3L+JoQZDvOfndrKgKQbNZHbuQs4F6pOt6FkFwOSaA3Evh4W8DZH7QYyZ5aWu
         FgR7vYpXtlpuUwGY5v+uzx5KBeSclEtB6nPTa72xA1TXUmAb+E3JDIGoY7oqdSfuQnNc
         AHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729117136; x=1729721936;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m9lG3UFqivqt8ceQwz6YRRlLk0aVwUnww1pm6vvyweU=;
        b=iDUoHmzVL9O8bSKeaXj7FckmLSGafUFBwp2DtZV3LYloBm2S5ScD9stlwrqI/gpMOM
         OEs3ukKTB48301toxJpxLJ3O326Y3cMgiFGz5QfGGqoAgzsl4UgEoMw5DGh7aRWNxnEE
         mKLHIdzSJ7kQ3JcdiAJAjPIACDS8h/5A/fYgItB2yOrmlmCognIUVB4IGrcoVYjRCHUc
         Pw2TuGPZn3oAYujONgIeMgHhaQ6c7VCg1kEibSDUb4MxJ+kGZVCbDAY0BvxFcq6H5u+E
         KsgcC+PSBumpRwo+lchaODEc5kvLY3vuD5PsfPgaRX0jnyShHiRqm/RAReAtoak765UZ
         EB2w==
X-Gm-Message-State: AOJu0YxsQOM6gM976I0HLi533aB+bmsmurpH/7WoRWp6nTyse3yR53hC
	0pXcmIJ0ZAvdCBXF7ZGpxdeMO2VvjnDMUec22HXL11Y58b7O0VvQ
X-Google-Smtp-Source: AGHT+IG019RXym2l4/8wZdtjCj5kXUjqudqVuyFfdhuX9ljpk1osreWpRmAxwumkv2G0d3pkSL/YhA==
X-Received: by 2002:a05:6a20:2d22:b0:1d9:17fa:e5d8 with SMTP id adf61e73a8af0-1d917fb1118mr3455946637.26.1729117135960;
        Wed, 16 Oct 2024 15:18:55 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6c1948sm3792988a12.27.2024.10.16.15.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 15:18:55 -0700 (PDT)
Message-ID: <7fdc3253df59bd216eec02a53bbd0adc06fb8e7c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Allow ignoring some flags
 for Clang builds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Viktor Malik
	 <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Shuah Khan <shuah@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Date: Wed, 16 Oct 2024 15:18:50 -0700
In-Reply-To: <CAEf4BzYv6+v_AUp-xF=1z6spjLc0cp55fg-t=b4-bcwR+LFanA@mail.gmail.com>
References: <cover.1728975031.git.vmalik@redhat.com>
	 <08becac5b0b536d918adeb90efd63bdd7dcc856c.1728975031.git.vmalik@redhat.com>
	 <CAEf4BzYv6+v_AUp-xF=1z6spjLc0cp55fg-t=b4-bcwR+LFanA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-16 at 13:37 -0700, Andrii Nakryiko wrote:
> On Mon, Oct 14, 2024 at 11:55=E2=80=AFPM Viktor Malik <vmalik@redhat.com>=
 wrote:
> >=20
> > There exist compiler flags supported by GCC but not supported by Clang
> > (e.g. -specs=3D...). Currently, these cannot be passed to BPF selftests
> > builds, even when building with GCC, as some binaries (urandom_read and
> > liburandom_read.so) are always built with Clang and the unsupported
> > flags make the compilation fail (as -Werror is turned on).
> >=20
> > Add new Makefile variable CLANG_FILTEROUT_FLAGS which can be used by
> > users to specify which flags (from the user-provided CFLAGS or LDFLAGS)
> > should be filtered out for Clang invocations.
> >=20
> > This allows to do things like:
> >=20
> >     $ CFLAGS=3D"-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1" \
> >       CLANG_FILTEROUT_FLAGS=3D"-specs=3D%" \
> >       make -C tools/testing/selftests/bpf
> >=20
> > Without this patch, the compilation would fail with:
> >=20
> >     [...]
> >     clang: error: argument unused during compilation: '-specs=3D/usr/li=
b/rpm/redhat/redhat-hardened-cc1' [-Werror,-Wunused-command-line-argument]
>=20
> maybe we should just not error out (i.e., enable
> -Wno-unused-command-line-argument)?

I agree with Andrii, grepping for FILTEROUT in kernel source code does
not show anything similar to this. Are such filter-out variables some
kind of convention?

Another option might be to remove `-Werror` and add it on CI via EXTRA_CFLA=
GS.

[...]


