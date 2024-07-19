Return-Path: <bpf+bounces-35112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1109937C79
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 20:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4804DB216B4
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DA81474C8;
	Fri, 19 Jul 2024 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi1mqCYC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6753A12D76F;
	Fri, 19 Jul 2024 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721413942; cv=none; b=MGrs9caIvvolk5oAAehZeoNnKlkEaRU1gWdu4DVOUUzzVFLR17g1+BzzValT+WEyLrIhsDio8AhBtfeGoo62OJRxjrR3q5mTdZnBsw9slg1nO1kk9ZHO1ypun62eg/1Zyp6L1KdvADM+jsA4sfhrg++/PpzlSC+FxSdxIEs0WoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721413942; c=relaxed/simple;
	bh=chfnQWvv6wT68NRD8o1nsnPaxfzC8AV7osc76WnLKgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpqfzeU5Ckw1fEWQc4GG/n1tkaNeVQE4fYbNizP+I5FYq3CQx3MfviZ1z1aj+WZJJuiDqIbbzS94GUQO45POw//Vq7qs25fayUOGQe41q9BsyCM3bblm2HLd/sP6Db3h05W4MfF37IOkptpIGe3mIRAJXsOcdnkINYdVeKaeyFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi1mqCYC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-78512d44a13so1321406a12.1;
        Fri, 19 Jul 2024 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721413940; x=1722018740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt9ogvLnzJEaKS4laT2weLwJaVlY34NVQYCHlvnv5rE=;
        b=Bi1mqCYCh/qZeeT7/SjuHQQhuAvkRMSXAp+laStG0/qtxlQL75i3N3DUjq3r8PGTI2
         /c5mA0CiKpw0z1Kvi75Gr5HyDACTzy2PTk26P09tuS1wwmuNgKZmDm1Hy4c41yNI6OHJ
         b5FyS+dzjHAMZ37/rZlmC+A4oQzVZOmct83uPESaaoLQB494KkXJS2JrS31GyXtATezo
         EXhCbIGVkR+F6wsSCk0LyDFV9j8rETl3iNRdWhCeQzPgJiJBq5+2CqAYTTjnCez6EukU
         x42J9Iichz/OUomR/2DtLX315jPzOccn204Le+iLhTs8WnqCdqsItjZ4muSaXu3IwEwk
         q0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721413940; x=1722018740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dt9ogvLnzJEaKS4laT2weLwJaVlY34NVQYCHlvnv5rE=;
        b=EBo/jx2obL/VYc6DdX1QvY5kPhd5Dluv52WHXdfgG2NC0sQELKxzJyvgmDtx5agnWZ
         Y71JTBdvFZPrSwANRuCWIbTtSvsYJtIyTjazaVCNC/eBxoVeACGWL5ypahd7rr9e5ljs
         E9xdUqScBekrhZnn2aVhXV63zIVfwFCio1NBF4/Jdp8fZK0cf1EBXwuo2dvN/9FbGY7h
         uEbAq5uUSjJOR1oUVrZ/SZv/ZiWf07gVxTJYfcyPZMVzp/0bw6MoEQowGqmY5hhPaCUK
         kN0TbPaejObz/RYngHadFaNymjgsZN4gLT+aOmZtzkTBRux+lVwF/g2PNGYzqq9wzuXC
         wLYw==
X-Forwarded-Encrypted: i=1; AJvYcCUTHDidVtKhdEvQ+n8TLIyz95MTAx0zlqG2fZ+pt/yr2D2IB9B3dutgkBzguy2OFXSukvI/Y7B5QEhKXqIrUwxecE4Kvs5BQBHjQRdOhXJ5L/dWNS27m4Omw/bWkVjBEyE6d09sCpH4S3zrssWkZRtuNSjO/e3kiWRdUXokALqF
X-Gm-Message-State: AOJu0Yx3ICCR96kof408v7vF1CK5SOn1sUDKBK4H9lJx/0PsHGaH7YEC
	TTBc+73wtWisvEvpoQGOdNBLIzbtOVZeL/ZBZRSU9n+5v5AxFjIwPqGO43R11TnUzU+UwRK54UT
	pLWGgno9ZdZct3X25X/0bHC4hkLg=
X-Google-Smtp-Source: AGHT+IH+t8cjX+hL8AiXQYe3xNJ3zB4Ji5WkgUknzxkGnpkBpKnGZ9QYP1DMt4PjPsSwLPGqGmUTy/w8t343hDNrKzw=
X-Received: by 2002:a05:6a20:9186:b0:1c3:a55e:6199 with SMTP id
 adf61e73a8af0-1c422997a27mr1121977637.44.1721413940352; Fri, 19 Jul 2024
 11:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715203325.3832977-1-briannorris@chromium.org>
 <20240715203325.3832977-3-briannorris@chromium.org> <ZpYngEl9XKumuow5@krava>
In-Reply-To: <ZpYngEl9XKumuow5@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jul 2024 11:32:08 -0700
Message-ID: <CAEf4BzbR7vRgz-XQAOqNUe2-b=9v7JKt7hrV10DdNpsf9VGz1w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] tools build: Avoid circular .fixdep-in.o.cmd issues
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Brian Norris <briannorris@chromium.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 12:55=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Mon, Jul 15, 2024 at 01:32:43PM -0700, Brian Norris wrote:
> > The 'fixdep' tool is used to post-process dependency files for various
> > reasons, and it runs after every object file generation command. This
> > even includes 'fixdep' itself.
> >
> > In Kbuild, this isn't actually a problem, because it uses a single
> > command to generate fixdep (a compile-and-link command on fixdep.c), an=
d
> > afterward runs the fixdep command on the accompanying .fixdep.cmd file.
> >
> > In tools/ builds (which notably is maintained separately from Kbuild),
> > fixdep is generated in several phases:
> >
> >  1. fixdep.c -> fixdep-in.o
> >  2. fixdep-in.o -> fixdep
> >
> > Thus, fixdep is not available in the post-processing for step 1, and
> > instead, we generate .cmd files that look like:
> >
> >   ## from tools/objtool/libsubcmd/.fixdep.o.cmd
> >   # cannot find fixdep (/path/to/linux/tools/objtool/libsubcmd//fixdep)
> >   [...]
> >
> > These invalid .cmd files are benign in some respects, but cause problem=
s
> > in others (such as the linked reports).
> >
> > Because the tools/ build system is rather complicated in its own right
> > (and pointedly different than Kbuild), I choose to simply open-code the
> > rule for building fixdep, and avoid the recursive-make indirection that
> > produces the problem in the first place.
> >
> > Link: https://lore.kernel.org/all/Zk-C5Eg84yt6_nml@google.com/
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> >
> > (no changes since v3)
> >
> > Changes in v3:
> >  - Drop unnecessary tools/build/Build
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> so usually Arnaldo takes changes for tools/build, Arnaldo, could you plea=
se take a look?
> but still there'are the tools/lib/bpf bits..

I think it should be fine for libbpf bits to go through Arnaldo's tree
and get back to bpf-next eventually. Unlikely that we'll have any
conflict in libbpf's Makefile specifically, we rarely change it.

>
> thanks,
> jirka
>
> >
> >  tools/build/Build    |  3 ---
> >  tools/build/Makefile | 11 ++---------
> >  2 files changed, 2 insertions(+), 12 deletions(-)
> >  delete mode 100644 tools/build/Build
> >
> > diff --git a/tools/build/Build b/tools/build/Build
> > deleted file mode 100644
> > index 76d1a4960973..000000000000
> > --- a/tools/build/Build
> > +++ /dev/null
> > @@ -1,3 +0,0 @@
> > -hostprogs :=3D fixdep
> > -
> > -fixdep-y :=3D fixdep.o
> > diff --git a/tools/build/Makefile b/tools/build/Makefile
> > index 17cdf01e29a0..fea3cf647f5b 100644
> > --- a/tools/build/Makefile
> > +++ b/tools/build/Makefile
> > @@ -43,12 +43,5 @@ ifneq ($(wildcard $(TMP_O)),)
> >       $(Q)$(MAKE) -C feature OUTPUT=3D$(TMP_O) clean >/dev/null
> >  endif
> >
> > -$(OUTPUT)fixdep-in.o: FORCE
> > -     $(Q)$(MAKE) $(build)=3Dfixdep
> > -
> > -$(OUTPUT)fixdep: $(OUTPUT)fixdep-in.o
> > -     $(QUIET_LINK)$(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ $<
> > -
> > -FORCE:
> > -
> > -.PHONY: FORCE
> > +$(OUTPUT)fixdep: $(srctree)/tools/build/fixdep.c
> > +     $(QUIET_CC)$(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ $<
> > --
> > 2.45.2.993.g49e7a77208-goog
> >
> >
>

