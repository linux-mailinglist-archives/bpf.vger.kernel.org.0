Return-Path: <bpf+bounces-53957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E68A5F86F
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 15:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1754B881923
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 14:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1653D26AA8F;
	Thu, 13 Mar 2025 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfvAL82x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F24267393
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876251; cv=none; b=H7fSIraOImrjEMBIEL6hNO1cQAZKU5fLb5EbiUAW82tKyVh00zwOBAzCOv2zQ/1oVk/cvNvtalv4ZRPpYdJfz5ecgKSL5AkoCZBzbGIMUmV5/L0Z76D3i1QBLbUuZbeX5F0p4w4YQS+yV1xxsvASFE14ywwZh+MkpoWVEaGH0yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876251; c=relaxed/simple;
	bh=XvuFMUXSuP8ersNk9s0JF0d5TU1k95qYeywmjNfXe8Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMYsDhSPGZ+Y+w4v3nJYiXz8w6qC0mofUCdfGEsMeUPTNFOpgGbg0QHWCgj4ltA6x7iDhGNtcFzXOmhAD7DcCC5IqAO3NiFlGh0DfBpPK+TpU3u4YkCfaM+bbkrpmpfhkrT09SbzE1T52hRXcr6YQt6Tc0Pzap0KNiZ3VfX9KHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfvAL82x; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso7333365e9.0
        for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 07:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741876248; x=1742481048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwEu8pklcmQuFfQOPsr/psJ5/yZnM2Je73csOzRrZL8=;
        b=UfvAL82xzAtgp3yFkieEi58XWu9WK3gEAmqAi2i29PgmD6XOI3NO5clmBFM0inJKRM
         O08rgzzJKslpoD105kzDeiG7j25XLsWOKJbses9uzg0lYozQ8HwfH1HqZ+uKXePZmOGK
         Y02+1o5NptVs9NufrvM4MXFi4QFUFLC4q+uGP+9JYzkcVK1EkoBllUSeyBlI8f4d7j7c
         QGmfAp3XiUntYL7I3R6O/gzlfeaXfxiC2KTrdiK2H9/Qr5RgLm1AFziu/qtdDdYmTQ2x
         JJj4zFUy4RmIIViH99vxFZlo5Bpe6GjREgKCqNzRRbyqUy9z/ifI8mJISL2UFaXzJgxO
         +nrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876248; x=1742481048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwEu8pklcmQuFfQOPsr/psJ5/yZnM2Je73csOzRrZL8=;
        b=PH0XT6rn+dED7JEL+xHrXnWc1phbVQBUPayzSAoFcd5rBO7NW9SCZGyzbqq4XnZs9X
         vyUMwtxzyH+rK5Z/Sf38etKhcZeQfXsT3ihsdhpGo+5a86X2E8PJ1pTzfqM4jY09o1WO
         WLlTnNlXVOrmW5Yw0wmEBHdTRzm33zGn9nmDcjYMiuy+JGx4ysTiHsD19XsvCRXIs7e3
         eMjnYdOv/3NS2HloR7yRU9lTJfRct7zfpkFTNr21VqO3FEhHlQt07It2HLObj97PSdj+
         MNH/HzI2gH4pyK8BjeMns7mND9m+56xDkMkgVj7RLE2oqa6EVPPUp9QGj+/p4topPD+M
         teTg==
X-Forwarded-Encrypted: i=1; AJvYcCU/8xx1Ur5YlK2WaJaMA+ssUmNSQd1ct2SG5/FWi1PEPWS5obx00eKNlTARgJGNZitn3sA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxasQGsw1oEFittAJadEpUaXrQ3DXNvzUqMSc9yhlS4D+ZB1kNH
	NCOj+SyJwjOyIcqFMC4OwcoJi4/9V7jiptwI2CyyOXTUcj8jVJ22
X-Gm-Gg: ASbGncu7BdJ9Ql3qlTjeeOkup9a09BrhZdEj7jhluoGJIx5g6N32P5xh2+qdWp7zq0K
	5SUJ8hEQ2SvxnBYZTrvoYZoXMD0yZUfpOa5HkzyQdDUDwEHjbsg3MflYQS8AYPXly3xevPbjOuH
	X+CIw4bu2wQWJP8M4fMiKAo/D4vMZPSZC3NrTvzloeFN0HRD4qA2Z9+g4U06lRhm4V3/Dzfzj5Y
	n8zMTuvt7OIlXvQ6Wm1U9irtUBnjC0Yq2t0EWHauyvGETWUptyI7+2s67D4NYedsunFFbMpTIGE
	LwQOzxcKVwdI/IEpYHRqAeoALMmOU2Q=
X-Google-Smtp-Source: AGHT+IGBJlWOOHiek8R+7qazQgJVf/m19HW3OOrzY/2aiOPaJQqoVoz0qxSJlv349L64z44u7a8fXA==
X-Received: by 2002:a05:600c:46d2:b0:439:8e95:796a with SMTP id 5b1f17b1804b1-43d180a4435mr24723745e9.13.1741876247409;
        Thu, 13 Mar 2025 07:30:47 -0700 (PDT)
Received: from krava ([173.38.220.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c255bsm2254956f8f.23.2025.03.13.07.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:30:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 13 Mar 2025 15:30:44 +0100
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	andrii@kernel.org, eddyz87@gmail.com, deso@posteo.net
Subject: Re: [PATCH] libbpf: Fix uprobe offset calculation
Message-ID: <Z9LsFNtXXBD0ydeO@krava>
References: <20250307140120.1261890-1-hengqi.chen@gmail.com>
 <10239917-2cbe-434e-adc5-69c3f3e66e36@linux.dev>
 <CAEyhmHT+DZDjXixnWgCq028K7KZ84bWHY1+Kv9bjJAQW9vryHQ@mail.gmail.com>
 <CAEf4BzbAi-g-jyFoHdXHNfOT3DLTnKN1XioPhR=XYJnM7+_VOQ@mail.gmail.com>
 <CAEyhmHRobpifJ_h3q2ucnhunV_r2MLO4QE5sAMZKQmAMYaBzjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEyhmHRobpifJ_h3q2ucnhunV_r2MLO4QE5sAMZKQmAMYaBzjw@mail.gmail.com>

On Thu, Mar 13, 2025 at 12:23:10PM +0800, Hengqi Chen wrote:

SNIP

> > > > >   tools/lib/bpf/elf.c | 32 ++++++++++++++++++++++++--------
> > > > >   1 file changed, 24 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> > > > > index 823f83ad819c..9b561c8d1eec 100644
> > > > > --- a/tools/lib/bpf/elf.c
> > > > > +++ b/tools/lib/bpf/elf.c
> > > > > @@ -260,13 +260,29 @@ static bool symbol_match(struct elf_sym_iter *iter, int sh_type, struct elf_sym
> > > > >    * for shared libs) into file offset, which is what kernel is expecting
> > > > >    * for uprobe/uretprobe attachment.
> > > > >    * See Documentation/trace/uprobetracer.rst for more details. This is done
> > > > > - * by looking up symbol's containing section's header and using iter's virtual
> > > > > - * address (sh_addr) and corresponding file offset (sh_offset) to transform
> > > > > + * by looking up symbol's containing program header and using its virtual
> > > > > + * address (p_vaddr) and corresponding file offset (p_offset) to transform
> > > > >    * sym.st_value (virtual address) into desired final file offset.
> > > > >    */
> > > > > -static unsigned long elf_sym_offset(struct elf_sym *sym)
> > > > > +static unsigned long elf_sym_offset(Elf *elf, struct elf_sym *sym)
> > > > >   {
> > > > > -     return sym->sym.st_value - sym->sh.sh_addr + sym->sh.sh_offset;
> > > > > +     size_t nhdrs, i;
> > > > > +     GElf_Phdr phdr;
> > > > > +
> > > > > +     if (elf_getphdrnum(elf, &nhdrs))
> > > > > +             return -1;
> > > > > +
> > > > > +     for (i = 0; i < nhdrs; i++) {
> > > > > +             if (!gelf_getphdr(elf, (int)i, &phdr))
> > > > > +                     continue;
> > > > > +             if (phdr.p_type != PT_LOAD || !(phdr.p_flags & PF_X))
> > > > > +                     continue;
> > > > > +             if (sym->sym.st_value >= phdr.p_vaddr &&
> > > > > +                 sym->sym.st_value < (phdr.p_vaddr + phdr.p_memsz))
> > > > > +                     return sym->sym.st_value - phdr.p_vaddr + phdr.p_offset;
> >
> > Hengqi,
> >
> > Can you please provide an example where existing code doesn't work? I think that
> >
> > sym->sym.st_value - sym->sh.sh_addr + sym->sh.sh_offset
> >
> > and
> >
> > sym->sym.st_value - phdr.p_vaddr + phdr.p_offset
> >
> >
> > Should result in the same, and we don't need to search for a matching
> > segment if we have an ELF symbol and its section. But maybe I'm
> > mistaken, so can you please elaborate a bit?
> 
> The binary ([0]) provided in the issue shows some counterexamples.
> I could't find an authoritative documentation describing this though.
> A modified version ([1]) of this patch could pass the CI now.

yes, I tried that binary and it gives me different offsets

IIUC the symbol seems to be from .eh_frame_hdr (odd?) while the new logic
base it on offset of .text section.. I'm still not following that binary
layout completely.. will try to check on that more later today

jirka

> 
>   [0]: https://github.com/libbpf/libbpf-rs/issues/1110#issuecomment-2699221802
>   [1]: https://github.com/kernel-patches/bpf/pull/8647
> 
> >
> > > > > +     }
> > > > > +
> > > > > +     return -1;
> > > > >   }
> > > > >
> > > > >   /* Find offset of function name in the provided ELF object. "binary_path" is
> > > > > @@ -329,7 +345,7 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
> > > > >
> > > > >                       if (ret > 0) {
> > > > >                               /* handle multiple matches */
> > > > > -                             if (elf_sym_offset(sym) == ret) {
> > > > > +                             if (elf_sym_offset(elf, sym) == ret) {
> > > > >                                       /* same offset, no problem */
> > > > >                                       continue;
> > > > >                               } else if (last_bind != STB_WEAK && cur_bind != STB_WEAK) {
> > > >
> > > > [...]
> > > >
> 

