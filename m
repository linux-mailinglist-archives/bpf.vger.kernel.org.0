Return-Path: <bpf+bounces-38301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9BC962EEA
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 19:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90732B215D7
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 17:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C506A1A705D;
	Wed, 28 Aug 2024 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqmZBbRV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96356166302;
	Wed, 28 Aug 2024 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867397; cv=none; b=DTNBytlYZdZUZzRxBNBYxlEZnMbHZuumOxQW9E1QO6PCxUO5gyE5w9Foxe8TbQblmrxURpMye7jeoMvuoZj0bdNqd6DZeXP6wZF6eeghw3niPyqyl/dyOsOlpQFYBqGHuaj/85Hz/KpO68MqlM5i+ux41ZaFbz74Z+co0hFuUno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867397; c=relaxed/simple;
	bh=WLVw/MzwZZYc+FLwv4AVDjwEdiq3qFjmZrfxJuaPQi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8iHK4bRAEz8AI97Wqrx8eRi6hzkJn9CJTONGj753nX8UcdwJnaCgRitpNM8MT25njdrxiwgZ6M6jprf83vHF+QWpSKBvRyTNosM3yrrsxgEQPWmwMb0m5TeebdgLyqJ0bP0VZ22qE7aN3BMMABxL9xN9Fx0D7m+CeAPfZddbcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqmZBbRV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86910caf9cso176535166b.1;
        Wed, 28 Aug 2024 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724867394; x=1725472194; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LbtgMIebzvLQcLsMDmLEedziYElh6r9r50MOFoD98VM=;
        b=AqmZBbRVI7m+7Ag83WI0MVmLzVLNzhIIHD0Pg7H3/DTb6R1nzr3hKDDFtXPt/kENir
         df7R9dQh7OoxAsIqgudG8/ZlT5LZjBKZxfo4697JklsQpL2aP4TY6T1PNx23qbTKNb9q
         ChNRH10YbsuK2k5nzyvK5703pDz0Mjl/SKOep9gq4pltipWTzsZMEHCMrP0iWK9BZfQk
         g4QFm1BhOrE3jdk9RdunCZVuDPJzN3V0HI2LiESH6xq5oHRDg/qCICbnj+Pgte+E7QSv
         4TZWbqzci/jdUVOhb4vy1Mb0kgZfFYpgw+Sq0K42vtJV06rVkBv5B7e3wgdMwFdUkI8z
         mziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724867394; x=1725472194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbtgMIebzvLQcLsMDmLEedziYElh6r9r50MOFoD98VM=;
        b=ttu20UHvY0CVBUV9DOQqSs1KnbdzD/W0rnQXqRW/lQLh27i8vgR3pOT17Kd1S+jVMJ
         QOTNE+USghyk0GfbodiC8VdiGxN6p7tuPU+P80G1Qui62E42f+rcXjon4Knxh5vFLT5N
         lua0qUki7SzH3pwVqaFChxms48wFX9zL23Mr5fvO7WPbS7M50J7mlokh6N5QAh2SAgv6
         fX3RnUrsA7iIp/akwQcrzUe9KRYPW80M6fQDAmEeE8cPnAghbRlA7Ihdmt589qZXd1gM
         hCYQkRl3EyGmajUSxhL0BzkKhY8m3x7tTxubpOqbz38qfWjP7jUL5TxShh5Uuiu3Sfkb
         s5iA==
X-Forwarded-Encrypted: i=1; AJvYcCWA0xyCUha7rQ+qm8eESjmYoLYfZ6DyVvrOCikz2R3hC5/ucdnYd9syfRwOGRuiArNRIfmKA1MgsDLPHPpf@vger.kernel.org, AJvYcCWflPN4QNcb2o6cLI3rlbkKo5hyqpEZ+C5Itq9FXcjIy54FYy0Y9xZ908Pbb76fbsjjEDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRA+4SSWekLKib4BMKASezA98kvMieL+GwjQyby94Sdb2klUfE
	XB0Txa4QiRfs6F02KujtMQU4W0eCedSLqQv+UD5oAidCkwRBOmWZ
X-Google-Smtp-Source: AGHT+IE4vBfeRFM4byIab76yDsQOJRX37Xos2G/MiQVHkE5Zzsz0kSeJfotFwXN4CHSqHQaZrkWSJQ==
X-Received: by 2002:a17:907:3f8a:b0:a7a:a4cf:4f93 with SMTP id a640c23a62f3a-a897ead4b78mr36893766b.32.1724867393562;
        Wed, 28 Aug 2024 10:49:53 -0700 (PDT)
Received: from example.org (ip-94-112-152-157.bb.vodafone.cz. [94.112.152.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e588b39asm271462166b.159.2024.08.28.10.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 10:49:52 -0700 (PDT)
Date: Wed, 28 Aug 2024 19:49:50 +0200
From: Alexey Gladkov <gladkov.alexey@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2] bpf: Remove custom build rule
Message-ID: <Zs9jPsBY_SNuuB3d@example.org>
References: <CAK7LNAQju8OeqW_8JtNXAQWow8Ho8778Rq-Y_v22PSrbB39L0g@mail.gmail.com>
 <20240828170635.4112907-1-legion@kernel.org>
 <CAK7LNATb8dbhvdSgiNEMkdsgg93q4ZUGUxReZYNjOV3fDPnfyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATb8dbhvdSgiNEMkdsgg93q4ZUGUxReZYNjOV3fDPnfyQ@mail.gmail.com>

On Thu, Aug 29, 2024 at 02:22:33AM +0900, Masahiro Yamada wrote:
> On Thu, Aug 29, 2024 at 2:07 AM Alexey Gladkov <legion@kernel.org> wrote:
> >
> > According to the documentation, when building a kernel with the C=2
> > parameter, all source files should be checked. But this does not happen
> > for the kernel/bpf/ directory.
> >
> > $ touch kernel/bpf/core.o
> > $ make C=2 CHECK=true kernel/bpf/core.o
> >
> > Outputs:
> >
> >   CHECK   scripts/mod/empty.c
> >   CALL    scripts/checksyscalls.sh
> >   DESCEND objtool
> >   INSTALL libsubcmd_headers
> >   CC      kernel/bpf/core.o
> >
> > As can be seen the compilation is done, but CHECK is not executed. This
> > happens because kernel/bpf/Makefile has defined its own rule for
> > compilation and forgotten the macro that does the check.
> >
> > There is no need to duplicate the build code, and this rule can be
> > removed to use generic rules.
> >
> > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> 
> 
> Did you compile-test this?

Yes. I repeated my steps for reproduce:

$ touch kernel/bpf/core.c
$ make C=2 CHECK=true |grep kernel/bpf/core
  CC      kernel/bpf/core.o
  CHECK   kernel/bpf/core.c

but maybe my config is too small.

> 
> See my previous email.
> 
> 
> 
> 
> I said this:
> 
> $ cat kernel/bpf/btf_iter.c
> #include "../../tools/lib/bpf/btf_iter.c"
> 
> 
> Same for
> kernel/bpf/btf_relocate.c
> kernel/bpf/relo_core.c
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> > ---
> >  kernel/bpf/Makefile | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> > index 0291eef9ce92..9b9c151b5c82 100644
> > --- a/kernel/bpf/Makefile
> > +++ b/kernel/bpf/Makefile
> > @@ -52,9 +52,3 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
> >  obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
> >  obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
> >  obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
> > -
> > -# Some source files are common to libbpf.
> > -vpath %.c $(srctree)/kernel/bpf:$(srctree)/tools/lib/bpf
> > -
> > -$(obj)/%.o: %.c FORCE
> > -       $(call if_changed_rule,cc_o_c)
> > --
> > 2.46.0
> >
> 
> 
> --
> Best Regards
> Masahiro Yamada
> 

-- 
Rgrds, legion


