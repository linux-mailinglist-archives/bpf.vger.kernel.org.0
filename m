Return-Path: <bpf+bounces-62212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E06AF6718
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 03:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E60481471
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 01:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC7876410;
	Thu,  3 Jul 2025 01:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxAbvKEH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B305915C0
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 01:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751505449; cv=none; b=PgbJ9NzuDIcFhhh01AeGtqQhyrP8p6WTdE3FTkm1Hu8gYFbGUA54mZz6rWP+t/fgYntflP6SS1uR/uFnhnGt4YzBG/vPyvU1ufJXLB9KnInhVnnuOaXhmueUxOEWE3A+QT2kM4/syWn463hHQuI+lML2LHe3bfdWUCj8UtSv4mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751505449; c=relaxed/simple;
	bh=fQZi41SioaM3jWFxpUk1tVQZaqjogbmYKiF9Re0KS0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlN0QF4oX9pVSMXAZ6MMbMp8Xgn9zMYefJcmUuiBJt8wQJeZ5ncZHxT9KWibMfzMX+CRZKVGMvA4rBPJHI6qRdQZI9owWYba2FxIy/roE1yV/b5bbzl+APNXlt266rSQxvneo3CY27OjzmrUJpzYbk0jOmgH/+C9DS+61azledI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxAbvKEH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751505445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfZH8km083uaiTDnVCowwxj6xIqezX746ef+5by3kMM=;
	b=WxAbvKEHlrOcyvyS3HoVrMKvyZoSF9LBe9sSU24VP/PHHxbzfsmwLWdWPqPtMqKSlwsKun
	gHnaMOcVn9JX9pREPlZVqDDmjqpYvS8figgwk6+ACn1VEESA1UAn8U6LRSvY88M5EHiTmo
	HU+AR4ZfxGlO1bQfzfNj3KsFOGaLAxI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-OEDa8JuNM7WLO2lmvQPwuQ-1; Wed, 02 Jul 2025 21:17:24 -0400
X-MC-Unique: OEDa8JuNM7WLO2lmvQPwuQ-1
X-Mimecast-MFC-AGG-ID: OEDa8JuNM7WLO2lmvQPwuQ_1751505443
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235eefe6a8fso53864575ad.1
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 18:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751505443; x=1752110243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfZH8km083uaiTDnVCowwxj6xIqezX746ef+5by3kMM=;
        b=alz9aOz1TzOaLiIQxXTnjC363YSNVZGXitIVL3Kk18HAJW56gHoSAqhpS9xY+V+vDp
         vb6Sf7soY97fRbwBb4E8U6L2CMuw3SE8MNmAwjg67rAPntRHwPLqJzhu2O/1OfjPlx14
         EjbmqSPf0HLeZDzytTbqtDMW5o/v+UaSvZDbvoDpLCkBjaX0icUDMxS4WeIbmUJSTIOj
         3o5t2XBfQlMenV90DkAsm7pP3rx8M84rYssy3C/NtrtsMxHvK8xjz6JuEVT5L6efULGY
         67GSvW90GuWi7AfskYJCWecEawa1RHW7YQEcCL/uoATybGgu07i07yCg8yEdcQWHgrMm
         so+w==
X-Forwarded-Encrypted: i=1; AJvYcCXuEmEvrFYIoeE7YB3Ee2qEajP7VzkziSkyPcK4L32pL6e1vREeFglEMabTK6t2/FUskcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+kKMknH/ZKamoNMpNEbRI2icsB445gXSy3gCcI5y6GMHwOpuf
	e/3afoT56S6+pOQN7+u+uMhQ52T8oaIEX5ifrWh8uL3nk2J5PQLisgoMk7oyaOKgDev7gFFELKp
	BZMhvU+FcYlfXgjPe0E+tc/X7x+ZULQMnEuNJevW92tc+0gdCgXW3cxRqVdvEu5q60UPvWvOR4r
	259K5C27gtdlstAofFvguyFKq/tZSc
X-Gm-Gg: ASbGnctaOOB5ksJn+Axc4K9C5TGcjCeH6Pd0jzrllPF0qb9hRz9nWTtok8WugyHACse
	9EoCdGz1bsJkXjV8n1FRJJWA8nGbGz2Iu4dZ93jvUBGzHywAbxHLvj0RIFcqHATtPJstJgcdFpY
	2tHEiI
X-Received: by 2002:a17:902:e84a:b0:235:2e0:aa9 with SMTP id d9443c01a7336-23c796b1fbemr24260845ad.14.1751505442926;
        Wed, 02 Jul 2025 18:17:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUyFwInKkqe69FB1sSoAdPI4KbI8olqXCvbFZjzvlKEnYGsBNIIOV5wTcmNZ85ijaVxMTQNrmcqiW7JNcLMEE=
X-Received: by 2002:a17:902:e84a:b0:235:2e0:aa9 with SMTP id
 d9443c01a7336-23c796b1fbemr24260405ad.14.1751505442515; Wed, 02 Jul 2025
 18:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529041744.16458-1-piliu@redhat.com> <20250529041744.16458-6-piliu@redhat.com>
 <20250625200950.16d7a09c@rotkaeppchen> <aGKU4ZoPwLXbQGVu@fedora> <20250702111751.2b43aea2@rotkaeppchen>
In-Reply-To: <20250702111751.2b43aea2@rotkaeppchen>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 3 Jul 2025 09:17:11 +0800
X-Gm-Features: Ac12FXwcOKMhT-zbLAZjOQ5BvdUp7_sJUteKLdnGSojiSAmrzw1iEZm38mbjink
Message-ID: <CAF+s44RPNeLyCZJXuQUEjN_dFQtF2XHYW8yf0RjhG8zWb5_zaw@mail.gmail.com>
Subject: Re: [PATCHv3 5/9] kexec: Introduce kexec_pe_image to parse and load
 PE file
To: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Viktor Malik <vmalik@redhat.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 5:18=E2=80=AFPM Philipp Rudo <prudo@redhat.com> wrot=
e:
>
> Hi Pingfan,
>
> On Mon, 30 Jun 2025 21:45:05 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
>
> > On Wed, Jun 25, 2025 at 08:09:50PM +0200, Philipp Rudo wrote:
> > > Hi Pingfan,
> > >
> > > On Thu, 29 May 2025 12:17:40 +0800
> > > Pingfan Liu <piliu@redhat.com> wrote:
> > >
> > > > As UEFI becomes popular, a few architectures support to boot a PE f=
ormat
> > > > kernel image directly. But the internal of PE format varies, which =
means
> > > > each parser for each format.
> > > >
> > > > This patch (with the rest in this series) introduces a common skele=
ton
> > > > to all parsers, and leave the format parsing in
> > > > bpf-prog, so the kernel code can keep relative stable.
> > > >
> > > > A new kexec_file_ops is implementation, named pe_image_ops.
> > > >
> > > > There are some place holder function in this patch. (They will take
> > > > effect after the introduction of kexec bpf light skeleton and bpf
> > > > helpers). Overall the parsing progress is a pipeline, the current
> > > > bpf-prog parser is attached to bpf_handle_pefile(), and detatched a=
t the
> > > > end of the current stage 'disarm_bpf_prog()' the current parsed res=
ult
> > > > by the current bpf-prog will be buffered in kernel 'prepare_nested_=
pe()'
> > > > , and deliver to the next stage.  For each stage, the bpf bytecode =
is
> > > > extracted from the '.bpf' section in the PE file.
> > > >
> > > > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > > > Cc: Baoquan He <bhe@redhat.com>
> > > > Cc: Dave Young <dyoung@redhat.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Philipp Rudo <prudo@redhat.com>
> > > > To: kexec@lists.infradead.org
> > > > ---
> > > >  include/linux/kexec.h   |   1 +
> > > >  kernel/Kconfig.kexec    |   8 +
> > > >  kernel/Makefile         |   1 +
> > > >  kernel/kexec_pe_image.c | 356 ++++++++++++++++++++++++++++++++++++=
++++
> > > >  4 files changed, 366 insertions(+)
> > > >  create mode 100644 kernel/kexec_pe_image.c
> > > >
> > > [...]
> > >
> > > > diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
> > > > new file mode 100644
> > > > index 0000000000000..3097efccb8502
> > > > --- /dev/null
> > > > +++ b/kernel/kexec_pe_image.c
> > > > @@ -0,0 +1,356 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Kexec PE image loader
> > > > +
> > > > + * Copyright (C) 2025 Red Hat, Inc
> > > > + */
> > > > +
> > > > +#define pr_fmt(fmt)      "kexec_file(Image): " fmt
> > > > +
> > > > +#include <linux/err.h>
> > > > +#include <linux/errno.h>
> > > > +#include <linux/list.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/vmalloc.h>
> > > > +#include <linux/kexec.h>
> > > > +#include <linux/pe.h>
> > > > +#include <linux/string.h>
> > > > +#include <linux/bpf.h>
> > > > +#include <linux/filter.h>
> > > > +#include <asm/byteorder.h>
> > > > +#include <asm/image.h>
> > > > +#include <asm/memory.h>
> > > > +
> > > > +
> > > > +static LIST_HEAD(phase_head);
> > > > +
> > > > +struct parsed_phase {
> > > > + struct list_head head;
> > > > + struct list_head res_head;
> > > > +};
> > > > +
> > > > +static struct parsed_phase *cur_phase;
> > > > +
> > > > +static char *kexec_res_names[3] =3D {"kernel", "initrd", "cmdline"=
};
> > >
> > > Wouldn't it be better to use a enum rather than strings for the
> > > different resources? Especially as in prepare_nested_pe you are
> >
> > I plan to make bpf_copy_to_kernel() fit for more cases besides kexec. S=
o
> > string may be better choice, and I think it is better to have a
> > subsystem prefix, like "kexec:kernel"
>
> True, although an enum could be utilized directly as, e.g. an index for
> an array directly. Anyway, I don't think there is a single 'best'
> solution here. So feel free to use strings.
>
> > > comparing two strings using =3D=3D instead of strcmp(). So IIUC it sh=
ould
> > > always return false.
> > >
> >
> > Oops, I will fix that. In fact, I meaned to assign the pointer
> > kexec_res_names[i] to kexec_res.name in bpf_kexec_carrier(). Later in
> > prepare_nested_pe() can compare two pointers.
> >
> >
> > > > +struct kexec_res {
> > > > + struct list_head node;
> > > > + char *name;
> > > > + /* The free of buffer is deferred to kimage_file_post_load_cleanu=
p */
> > > > + bool deferred_free;
> > > > + struct mem_range_result *r;
> > > > +};
> > > > +
> > > > +static struct parsed_phase *alloc_new_phase(void)
> > > > +{
> > > > + struct parsed_phase *phase =3D kzalloc(sizeof(struct parsed_phase=
), GFP_KERNEL);
> > > > +
> > > > + INIT_LIST_HEAD(&phase->head);
> > > > + INIT_LIST_HEAD(&phase->res_head);
> > > > + list_add_tail(&phase->head, &phase_head);
> > > > +
> > > > + return phase;
> > > > +}
> > >
> > > I must admit I don't fully understand how you are handling the
> > > different phases. In particular I don't understand why you are keepin=
g
> > > all the resources a phase returned once it is finished. The way I see
> > > it those resources are only needed once as input for the next phase. =
So
> > > it should be sufficient to only keep a single kexec_context and updat=
e
> > > it when a phase returns a new resource. The way I see it this should
> > > simplify pe_image_load quite a bit. Or am I missing something?
> > >
> >
> > Let us say an aarch64 zboot image embeded in UKI's .linux section.
> > The UKI parser takes apart the image into kernel, initrd, cmdline.
> > And the kernel part contains the zboot PE, including zboot parser.
> > The zboot parser needn't to handle either initrd or cmdline.
> > So I use the phases, and the leaf node is the final parsed result.
>
> Right, that's how the code is working. My point was that when you have
> multiple phases working on the same component, e.g. the kernel image,
> then you still keep all the intermediate kernel images in memory until
> the end. Even though the intermediate images are only used as an input
> for the next phase(s). So my suggestion is to remove them immediately
> once a phase returns a new image. My expectation is that this not only
> reduces the memory usage but also simplifies the code.
>

Ah, got your point. It is a good suggestion especially that it can
save lots of code.

Thanks,

Pingfan

> Thanks
> Philipp
>
> > > > +static bool is_valid_pe(const char *kernel_buf, unsigned long kern=
el_len)
> > > > +{
> > > > + struct mz_hdr *mz;
> > > > + struct pe_hdr *pe;
> > > > +
> > > > + if (!kernel_buf)
> > > > +         return false;
> > > > + mz =3D (struct mz_hdr *)kernel_buf;
> > > > + if (mz->magic !=3D MZ_MAGIC)
> > > > +         return false;
> > > > + pe =3D (struct pe_hdr *)(kernel_buf + mz->peaddr);
> > > > + if (pe->magic !=3D PE_MAGIC)
> > > > +         return false;
> > > > + if (pe->opt_hdr_size =3D=3D 0) {
> > > > +         pr_err("optional header is missing\n");
> > > > +         return false;
> > > > + }
> > > > +
> > > > + return true;
> > > > +}
> > > > +
> > > > +static bool is_valid_format(const char *kernel_buf, unsigned long =
kernel_len)
> > > > +{
> > > > + return is_valid_pe(kernel_buf, kernel_len);
> > > > +}
> > > > +
> > > > +/*
> > > > + * The UEFI Terse Executable (TE) image has MZ header.
> > > > + */
> > > > +static int pe_image_probe(const char *kernel_buf, unsigned long ke=
rnel_len)
> > > > +{
> > > > + return is_valid_pe(kernel_buf, kernel_len) ? 0 : -1;
> > >
> > > Every image, at least on x86, is a valid pe file. So we should check
> > > for the .bpf section rather than the header.
> > >
> >
> > You are right that it should include the check on the existence of .bpf
> > section. On the other hand, the check on PE header in kernel can ensure
> > the kexec-tools passes the right candidate for this parser.
> >
> > > > +}
> > > > +
> > > > +static int get_pe_section(char *file_buf, const char *sect_name,
> > >
> > > s/get_pe_section/pe_get_section/ ?
> > > that would make it more consistent with the other functions.
> >
> > Sure. I will fix it.
> >
> >
> > Thanks for your careful review.
> >
> >
> > Best Regards,
> >
> > Pingfan
> >
> > >
> > > Thanks
> > > Philipp
> > >
> > > > +         char **sect_start, unsigned long *sect_sz)
> > > > +{
> > > > + struct pe_hdr *pe_hdr;
> > > > + struct pe32plus_opt_hdr *opt_hdr;
> > > > + struct section_header *sect_hdr;
> > > > + int section_nr, i;
> > > > + struct mz_hdr *mz =3D (struct mz_hdr *)file_buf;
> > > > +
> > > > + *sect_start =3D NULL;
> > > > + *sect_sz =3D 0;
> > > > + pe_hdr =3D (struct pe_hdr *)(file_buf + mz->peaddr);
> > > > + section_nr =3D pe_hdr->sections;
> > > > + opt_hdr =3D (struct pe32plus_opt_hdr *)(file_buf + mz->peaddr + s=
izeof(struct pe_hdr));
> > > > + sect_hdr =3D (struct section_header *)((char *)opt_hdr + pe_hdr->=
opt_hdr_size);
> > > > +
> > > > + for (i =3D 0; i < section_nr; i++) {
> > > > +         if (strcmp(sect_hdr->name, sect_name) =3D=3D 0) {
> > > > +                 *sect_start =3D file_buf + sect_hdr->data_addr;
> > > > +                 *sect_sz =3D sect_hdr->raw_data_size;
> > > > +                 return 0;
> > > > +         }
> > > > +         sect_hdr++;
> > > > + }
> > > > +
> > > > + return -1;
> > > > +}
> > > > +
> > > > +static bool pe_has_bpf_section(char *file_buf, unsigned long pe_sz=
)
> > > > +{
> > > > + char *sect_start =3D NULL;
> > > > + unsigned long sect_sz =3D 0;
> > > > + int ret;
> > > > +
> > > > + ret =3D get_pe_section(file_buf, ".bpf", &sect_start, &sect_sz);
> > > > + if (ret < 0)
> > > > +         return false;
> > > > + return true;
> > > > +}
> > > > +
> > > > +/* Load a ELF */
> > > > +static int arm_bpf_prog(char *bpf_elf, unsigned long sz)
> > > > +{
> > > > + return 0;
> > > > +}
> > > > +
> > > > +static void disarm_bpf_prog(void)
> > > > +{
> > > > +}
> > > > +
> > > > +struct kexec_context {
> > > > + bool kdump;
> > > > + char *image;
> > > > + int image_sz;
> > > > + char *initrd;
> > > > + int initrd_sz;
> > > > + char *cmdline;
> > > > + int cmdline_sz;
> > > > +};
> > > > +
> > > > +void bpf_handle_pefile(struct kexec_context *context);
> > > > +void bpf_post_handle_pefile(struct kexec_context *context);
> > > > +
> > > > +
> > > > +/*
> > > > + * optimize("O0") prevents inline, compiler constant propagation
> > > > + */
> > > > +__attribute__((used, optimize("O0"))) void bpf_handle_pefile(struc=
t kexec_context *context)
> > > > +{
> > > > +}
> > > > +
> > > > +__attribute__((used, optimize("O0"))) void bpf_post_handle_pefile(=
struct kexec_context *context)
> > > > +{
> > > > +}
> > > > +
> > > > +/*
> > > > + * PE file may be nested and should be unfold one by one.
> > > > + * Query 'kernel', 'initrd', 'cmdline' in cur_phase, as they are i=
nputs for the
> > > > + * next phase.
> > > > + */
> > > > +static int prepare_nested_pe(char **kernel, unsigned long *kernel_=
len, char **initrd,
> > > > +         unsigned long *initrd_len, char **cmdline)
> > > > +{
> > > > + struct kexec_res *res;
> > > > + int ret =3D -1;
> > > > +
> > > > + *kernel =3D NULL;
> > > > + *kernel_len =3D 0;
> > > > +
> > > > + list_for_each_entry(res, &cur_phase->res_head, node) {
> > > > +         if (res->name =3D=3D kexec_res_names[0]) {
> > > > +                 *kernel =3D res->r->buf;
> > > > +                 *kernel_len =3D res->r->data_sz;
> > > > +                 ret =3D 0;
> > > > +         } else if (res->name =3D=3D kexec_res_names[1]) {
> > > > +                 *initrd =3D res->r->buf;
> > > > +                 *initrd_len =3D res->r->data_sz;
> > > > +         } else if (res->name =3D=3D kexec_res_names[2]) {
> > > > +                 *cmdline =3D res->r->buf;
> > > > +         }
> > > > + }
> > > > +
> > > > + return ret;
> > > > +}
> > > > +
> > > > +static void *pe_image_load(struct kimage *image,
> > > > +                         char *kernel, unsigned long kernel_len,
> > > > +                         char *initrd, unsigned long initrd_len,
> > > > +                         char *cmdline, unsigned long cmdline_len)
> > > > +{
> > > > + char *parsed_kernel =3D NULL;
> > > > + unsigned long parsed_len;
> > > > + char *linux_start, *initrd_start, *cmdline_start, *bpf_start;
> > > > + unsigned long linux_sz, initrd_sz, cmdline_sz, bpf_sz;
> > > > + struct parsed_phase *phase, *phase_tmp;
> > > > + struct kexec_res *res, *res_tmp;
> > > > + void *ldata;
> > > > + int ret;
> > > > +
> > > > + linux_start =3D kernel;
> > > > + linux_sz =3D kernel_len;
> > > > + initrd_start =3D initrd;
> > > > + initrd_sz =3D initrd_len;
> > > > + cmdline_start =3D cmdline;
> > > > + cmdline_sz =3D cmdline_len;
> > > > +
> > > > + while (is_valid_format(linux_start, linux_sz) &&
> > > > +        pe_has_bpf_section(linux_start, linux_sz)) {
> > > > +         struct kexec_context context;
> > > > +
> > > > +         get_pe_section(linux_start, ".bpf", &bpf_start, &bpf_sz);
> > > > +         if (!!bpf_sz) {
> > > > +                 /* load and attach bpf-prog */
> > > > +                 ret =3D arm_bpf_prog(bpf_start, bpf_sz);
> > > > +                 if (ret) {
> > > > +                         pr_err("Fail to load .bpf section\n");
> > > > +                         ldata =3D ERR_PTR(ret);
> > > > +                         goto err;
> > > > +                 }
> > > > +         }
> > > > +         cur_phase =3D alloc_new_phase();
> > > > +         if (image->type !=3D KEXEC_TYPE_CRASH)
> > > > +                 context.kdump =3D false;
> > > > +         else
> > > > +                 context.kdump =3D true;
> > > > +         context.image =3D linux_start;
> > > > +         context.image_sz =3D linux_sz;
> > > > +         context.initrd =3D initrd_start;
> > > > +         context.initrd_sz =3D initrd_sz;
> > > > +         context.cmdline =3D cmdline_start;
> > > > +         context.cmdline_sz =3D strlen(cmdline_start);
> > > > +         /* bpf-prog fentry, which handle above buffers. */
> > > > +         bpf_handle_pefile(&context);
> > > > +
> > > > +         prepare_nested_pe(&linux_start, &linux_sz, &initrd_start,
> > > > +                                 &initrd_sz, &cmdline_start);
> > > > +         /* bpf-prog fentry */
> > > > +         bpf_post_handle_pefile(&context);
> > > > +         /*
> > > > +          * detach the current bpf-prog from their attachment poin=
ts.
> > > > +          * It also a point to free any registered interim resourc=
e.
> > > > +          * Any resource except attached to phase is interim.
> > > > +          */
> > > > +         disarm_bpf_prog();
> > > > + }
> > > > +
> > > > + /* the rear of parsed phase contains the result */
> > > > + list_for_each_entry_reverse(phase, &phase_head, head) {
> > > > +         if (initrd !=3D NULL && cmdline !=3D NULL && parsed_kerne=
l !=3D NULL)
> > > > +                 break;
> > > > +         list_for_each_entry(res, &phase->res_head, node) {
> > > > +                 if (!strcmp(res->name, "kernel") && !parsed_kerne=
l) {
> > > > +                         parsed_kernel =3D res->r->buf;
> > > > +                         parsed_len =3D res->r->data_sz;
> > > > +                         res->deferred_free =3D true;
> > > > +                 } else if (!strcmp(res->name, "initrd") && !initr=
d) {
> > > > +                         initrd =3D res->r->buf;
> > > > +                         initrd_len =3D res->r->data_sz;
> > > > +                         res->deferred_free =3D true;
> > > > +                 } else if (!strcmp(res->name, "cmdline") && !cmdl=
ine) {
> > > > +                         cmdline =3D res->r->buf;
> > > > +                         cmdline_len =3D res->r->data_sz;
> > > > +                         res->deferred_free =3D true;
> > > > +                 }
> > > > +         }
> > > > +
> > > > + }
> > > > +
> > > > + if (initrd =3D=3D NULL || cmdline =3D=3D NULL || parsed_kernel =
=3D=3D NULL) {
> > > > +         char *c, buf[64];
> > > > +
> > > > +         c =3D buf;
> > > > +         if (parsed_kernel =3D=3D NULL) {
> > > > +                 strcpy(c, "kernel ");
> > > > +                 c +=3D strlen("kernel ");
> > > > +         }
> > > > +         if (initrd =3D=3D NULL) {
> > > > +                 strcpy(c, "initrd ");
> > > > +                 c +=3D strlen("initrd ");
> > > > +         }
> > > > +         if (cmdline =3D=3D NULL) {
> > > > +                 strcpy(c, "cmdline ");
> > > > +                 c +=3D strlen("cmdline ");
> > > > +         }
> > > > +         c =3D '\0';
> > > > +         pr_err("Can not extract data for %s", buf);
> > > > +         ldata =3D ERR_PTR(-EINVAL);
> > > > +         goto err;
> > > > + }
> > > > + /*
> > > > +  * image's kernel_buf, initrd_buf, cmdline_buf are set. Now they =
should
> > > > +  * be updated to the new content.
> > > > +  */
> > > > + if (image->kernel_buf !=3D parsed_kernel) {
> > > > +         vfree(image->kernel_buf);
> > > > +         image->kernel_buf =3D parsed_kernel;
> > > > +         image->kernel_buf_len =3D parsed_len;
> > > > + }
> > > > + if (image->initrd_buf !=3D initrd) {
> > > > +         vfree(image->initrd_buf);
> > > > +         image->initrd_buf =3D initrd;
> > > > +         image->initrd_buf_len =3D initrd_len;
> > > > + }
> > > > + if (image->cmdline_buf !=3D cmdline) {
> > > > +         kfree(image->cmdline_buf);
> > > > +         image->cmdline_buf =3D cmdline;
> > > > +         image->cmdline_buf_len =3D cmdline_len;
> > > > + }
> > > > + ret =3D arch_kexec_kernel_image_probe(image, image->kernel_buf,
> > > > +                                     image->kernel_buf_len);
> > > > + if (ret) {
> > > > +         pr_err("Fail to find suitable image loader\n");
> > > > +         ldata =3D ERR_PTR(ret);
> > > > +         goto err;
> > > > + }
> > > > + ldata =3D kexec_image_load_default(image);
> > > > + if (IS_ERR(ldata)) {
> > > > +         pr_err("architecture code fails to load image\n");
> > > > +         goto err;
> > > > + }
> > > > + image->image_loader_data =3D ldata;
> > > > +
> > > > +err:
> > > > + list_for_each_entry_safe(phase, phase_tmp, &phase_head, head) {
> > > > +         list_for_each_entry_safe(res, res_tmp, &phase->res_head, =
node) {
> > > > +                 list_del(&res->node);
> > > > +                 /* defer to kimage_file_post_load_cleanup() */
> > > > +                 if (res->deferred_free) {
> > > > +                         res->r->buf =3D NULL;
> > > > +                         res->r->buf_sz =3D 0;
> > > > +                 }
> > > > +                 mem_range_result_put(res->r);
> > > > +                 kfree(res);
> > > > +         }
> > > > +         list_del(&phase->head);
> > > > +         kfree(phase);
> > > > + }
> > > > +
> > > > + return ldata;
> > > > +}
> > > > +
> > > > +const struct kexec_file_ops kexec_pe_image_ops =3D {
> > > > + .probe =3D pe_image_probe,
> > > > + .load =3D pe_image_load,
> > > > +#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
> > > > + .verify_sig =3D kexec_kernel_verify_pe_sig,
> > > > +#endif
> > > > +};
> > >
> >
>


