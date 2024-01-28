Return-Path: <bpf+bounces-20526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D2F83F9DA
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 21:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A23C1F21B39
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 20:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE983BB5F;
	Sun, 28 Jan 2024 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDBFv+ra"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074133BB5E
	for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706473044; cv=none; b=Pz/0oL2qPjz+yxX4L0W6iDGoOV92JcxIAwVNeT7x4hHPMKc1lmKBmGaIjSxPjevmKhsGtkRuI74FJzHl34aGDmgKbVIZ2m7uFKNtwIIyvAhBPZCYTIE2hjC8PPbbECqaOCr4gwHT7FV+HWKhlG5MRPOSCk8kCMXtLKsCTGve/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706473044; c=relaxed/simple;
	bh=M9ylQrBldw8arol/NBZ2uAgsNSeVJkhhNiXH1vMD2zw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElXdyYThtsPkr3t1yyW1XtArap6IskADJf0XcXxhOSlqsgyMoA5pNDkId3FtjZps8kq1NJCwWUtG2pYw/bzqVumA1yS2hcrTTHT8/LNRnIaLzq8WqSdzD+wRspqS/pdbPJ/yX6WjIb/UvNO2E/090YuFXz0T3nj65W0oZcidkCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDBFv+ra; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33aea66a31cso265449f8f.1
        for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 12:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706473041; x=1707077841; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8U1QLDn4tiaa8LAT8cFZD8yRKsZK5WZFA4kzMXskr7s=;
        b=DDBFv+rai+Lf+232gD1VLoPWr4nkzsOh3fitj09fGqBETR3+vxprljtvbhi64thX7H
         cxvegD033N541ZtTJcgsE+nrATADY08oeBZ8ETWliaKPljQX0l+nDFDT/xFpVFRCRtZ2
         dF21VXPSpiJ/7/7l15hKUfQDyQpgqB5ANu/uVb1SjyPmc7TZEJGcW+ztsucdZi1vqBWd
         fETfuVBFZKGAySEkAyPozzZ0f3dLNfmDch1776UICO75m7wac8dgxhnyuAYcKF78sT/v
         PZTCKZdZDEU61TuzPEoQ15oxJTnfawS/SWJ4b1oz+d2gR3HzmhNy39VZxsbngkaJGJf6
         FcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706473041; x=1707077841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8U1QLDn4tiaa8LAT8cFZD8yRKsZK5WZFA4kzMXskr7s=;
        b=r0LNzk7cVMw7rP51h8dEzLb4oId4pnX6LsGTg4+Zg66pbF6U/RCtCAH5BnfNNiXtiG
         TijRGWzlRX6K4fsfLxoPdMDFpkTcoNp1Xl1Jtiw76gbrM1CbkiBF3PxnWEM9WESffMRO
         QkGe6pIva1wD+0VzZYYd7fvQKLhQethONd5zwYIHOzIm5FZlVylGRSgWRC6pD3pnqfAi
         zOthdAD8lc3ksoYzUwWBbcoTrKq+ynbAJUa6dqxsJFOqNR5+9D8EmN38IdDgbJE/EhR8
         xijT2S6ZZhAs6yzp4yvWSYQJ9DEkaP2RYjV7w5xSUVbVfr5L/bg8J2uhe2Pq5fpJ6uNJ
         G74g==
X-Gm-Message-State: AOJu0Yxw/yirJR4KFpgvdD/zmznlgA9w/hjccM/Puv74hncwIytJzepB
	QEfy1myH1B1d4+nCy3h/bPFIPCpj5Ac7sNl1IvAM8ljoiRNK2Wdn
X-Google-Smtp-Source: AGHT+IGXnuQ8jVq6p5Bo0zN5mMREhPlhozVk+148GuYwKQB6WMJvRovOmaSiOsr//L2L9uqICc7SBQ==
X-Received: by 2002:a5d:4fc6:0:b0:333:c81:8f9d with SMTP id h6-20020a5d4fc6000000b003330c818f9dmr3651343wrw.2.1706473040884;
        Sun, 28 Jan 2024 12:17:20 -0800 (PST)
Received: from krava ([83.240.60.213])
        by smtp.gmail.com with ESMTPSA id u11-20020a056000038b00b0033aed5feea4sm1043426wrf.54.2024.01.28.12.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 12:17:20 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 28 Jan 2024 21:17:18 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: fix cross-compilation to
 non-host endianness
Message-ID: <Zba2TrYs6jRcNhH8@krava>
References: <20240123120759.1865189-1-vmalik@redhat.com>
 <CAEf4Bzb=eSCO=h4q1fqqGfEoo9Nf4BZL51_dYm2MHvEFzD_csw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb=eSCO=h4q1fqqGfEoo9Nf4BZL51_dYm2MHvEFzD_csw@mail.gmail.com>

On Fri, Jan 26, 2024 at 03:40:11PM -0800, Andrii Nakryiko wrote:
> On Tue, Jan 23, 2024 at 4:08 AM Viktor Malik <vmalik@redhat.com> wrote:
> >
> > The .BTF_ids section is pre-filled with zeroed BTF ID entries during the
> > build and afterwards patched by resolve_btfids with correct values.
> > Since resolve_btfids always writes in host-native endianness, it relies
> > on libelf to do the translation when the target ELF is cross-compiled to
> > a different endianness (this was introduced in commit 61e8aeda9398
> > ("bpf: Fix libelf endian handling in resolv_btfids")).
> >
> > Unfortunately, the translation will corrupt the flags fields of SET8
> > entries because these were written during vmlinux compilation and are in
> > the correct endianness already. This will lead to numerous selftests
> > failures such as:
> >
> >     $ sudo ./test_verifier 502 502
> >     #502/p sleepable fentry accept FAIL
> >     Failed to load prog 'Invalid argument'!
> >     bpf_fentry_test1 is not sleepable
> >     verification time 34 usec
> >     stack depth 0
> >     processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
> >     Summary: 0 PASSED, 0 SKIPPED, 1 FAILED

hum, I'd think we should have hit such bug long time ago.. set8 is
there for some time already.. nice ;-)

> >
> > Since it's not possible to instruct libelf to translate just certain
> > values, let's manually bswap the flags in resolve_btfids when needed, so
> > that libelf then translates everything correctly.
> >
> > Fixes: ef2c6f370a63 ("tools/resolve_btfids: Add support for 8-byte BTF sets")
> > Signed-off-by: Viktor Malik <vmalik@redhat.com>
> > ---
> >  tools/bpf/resolve_btfids/main.c | 35 +++++++++++++++++++++++++++++++--
> >  1 file changed, 33 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> > index 27a23196d58e..440d3d066ce4 100644
> > --- a/tools/bpf/resolve_btfids/main.c
> > +++ b/tools/bpf/resolve_btfids/main.c
> > @@ -646,18 +646,31 @@ static int cmp_id(const void *pa, const void *pb)
> >         return *a - *b;
> >  }
> >
> > +static int need_bswap(int elf_byte_order)
> > +{
> > +       return __BYTE_ORDER == __LITTLE_ENDIAN && elf_byte_order != ELFDATA2LSB ||
> > +              __BYTE_ORDER == __BIG_ENDIAN && elf_byte_order != ELFDATA2MSB;
> 
> return (__BYTE_ORDER == __LITTLE_ENDIAN) != (elf_byte_order == ELFDATA2LSB);
> 
> ?
> 
> > +}
> > +
> >  static int sets_patch(struct object *obj)
> >  {
> >         Elf_Data *data = obj->efile.idlist;
> >         int *ptr = data->d_buf;
> >         struct rb_node *next;
> > +       GElf_Ehdr ehdr;
> > +
> > +       if (gelf_getehdr(obj->efile.elf, &ehdr) == NULL) {
> > +               pr_err("FAILED cannot get ELF header: %s\n",
> > +                       elf_errmsg(-1));
> > +               return -1;
> > +       }
> 
> calculate needs_bswap() once here?
> 
> >
> >         next = rb_first(&obj->sets);
> >         while (next) {
> > -               unsigned long addr, idx;
> > +               unsigned long addr, idx, flags;
> >                 struct btf_id *id;
> >                 int *base;
> > -               int cnt;
> > +               int cnt, i;
> >
> >                 id   = rb_entry(next, struct btf_id, rb_node);
> >                 addr = id->addr[0];
> > @@ -679,6 +692,24 @@ static int sets_patch(struct object *obj)
> >
> >                 qsort(base, cnt, id->is_set8 ? sizeof(uint64_t) : sizeof(int), cmp_id);
> >
> > +               /*
> > +                * When ELF endianness does not match endianness of the host,
> > +                * libelf will do the translation when updating the ELF. This,
> > +                * however, corrupts SET8 flags which are already in the target
> > +                * endianness. So, let's bswap them to the host endianness and
> > +                * libelf will then correctly translate everything.
> > +                */
> > +               if (id->is_set8 && need_bswap(ehdr.e_ident[EI_DATA])) {
> > +                       for (i = 0; i < cnt; i++) {
> > +                               /*
> > +                                * header and entries are 8-byte, flags is the
> > +                                * second half of an entry
> > +                                */
> > +                               flags = idx + (i + 1) * 2 + 1;
> > +                               ptr[flags] = bswap_32(ptr[flags]);
> 
> we are dealing with struct btf_id_set8, right? Can't we #include
> include/linux/btf_ids.h and use that type for all these offset
> calculations?..

we could, there's tools/include/linux/btf_ids.h, which we could include
in here, we do that in selftests.. but it needs to be updated with latest
kernel updates (at least with set8 struct)

> 
> I have the same question for existing code, tbh, so maybe there was
> some good reason, not sure...

I think the test came later and I did not think of it for the resolve_btfids
itself, I guess it might make the code more readable

thanks,
jirka

> 
> > +                       }
> > +               }
> > +
> >                 next = rb_next(next);
> >         }
> >         return 0;
> > --
> > 2.43.0
> >
> >

