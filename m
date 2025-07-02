Return-Path: <bpf+bounces-62088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5BAAF0FB9
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 11:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED484A473B
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 09:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3477323F40C;
	Wed,  2 Jul 2025 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2gjvHtR"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9234A23C51B
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447895; cv=none; b=t9GiUfzaUO05B0UD3siNwUTLDnuqM21Nh5teti9rrowLk52TfDKNq8BPtia/+1PG8dDoj07dGgydmjA9mAN9ShxNp7NAgZEuTsKA/z909+L/dTvW+cD9QJ8D1wKDNxxoL5gMrDfTA4xfqxulYtI0MFnwKMNJfPjnBttlHTZ2SKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447895; c=relaxed/simple;
	bh=VFOkL98y4GpMRA8xoOC+wxWr2QynEyiQgXjc4pBV9N4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noEFTbOPeLlidXJHu6gx7+XCqBhc6xwxElx7+v827ALyCZdIzmZA+SEdgZpBURanWEOoGQ+iOEI3S56frVOXfpLGtEs0SG5vtPxyxKbinbe6MpPCG2l9QInXwY4mRZmgUHIArJ05DaXxAT3q+vuZ9Qz2tfQvo30v1PRdxvlPTrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2gjvHtR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751447892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JKclxFgKVXi+vC8NUwygEIBCeoHKMAxvB1FD+mdZZBQ=;
	b=M2gjvHtRVFDisu29t0uGafX9S0QGeCLFP3Y5xQFAkw/Bnawua5UsObERw4K57WWymLFiRd
	BugwtACS0JXAkWFCygDrUk/ldLUlnwPqBU1piwi0QfKGG1S8GeAmueVslAeVa+gSw3GYmc
	/GasYTRFnNx2ig0v1hypYq54k6OjsvA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-VMOEDDGyPyeUqz-jBnW1uQ-1; Wed,
 02 Jul 2025 05:18:09 -0400
X-MC-Unique: VMOEDDGyPyeUqz-jBnW1uQ-1
X-Mimecast-MFC-AGG-ID: VMOEDDGyPyeUqz-jBnW1uQ_1751447887
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AEFD1944A82;
	Wed,  2 Jul 2025 09:18:05 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.45.224.183])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93E2B19560AB;
	Wed,  2 Jul 2025 09:17:55 +0000 (UTC)
Date: Wed, 2 Jul 2025 11:17:51 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton
 <jeremy.linton@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Simon Horman
 <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Viktor Malik <vmalik@redhat.com>, Jan Hendrik Farr
 <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young
 <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 bpf@vger.kernel.org
Subject: Re: [PATCHv3 5/9] kexec: Introduce kexec_pe_image to parse and load
 PE file
Message-ID: <20250702111751.2b43aea2@rotkaeppchen>
In-Reply-To: <aGKU4ZoPwLXbQGVu@fedora>
References: <20250529041744.16458-1-piliu@redhat.com>
	<20250529041744.16458-6-piliu@redhat.com>
	<20250625200950.16d7a09c@rotkaeppchen>
	<aGKU4ZoPwLXbQGVu@fedora>
Organization: Red Hat inc.
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Pingfan,

On Mon, 30 Jun 2025 21:45:05 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> On Wed, Jun 25, 2025 at 08:09:50PM +0200, Philipp Rudo wrote:
> > Hi Pingfan,
> > 
> > On Thu, 29 May 2025 12:17:40 +0800
> > Pingfan Liu <piliu@redhat.com> wrote:
> >   
> > > As UEFI becomes popular, a few architectures support to boot a PE format
> > > kernel image directly. But the internal of PE format varies, which means
> > > each parser for each format.
> > > 
> > > This patch (with the rest in this series) introduces a common skeleton
> > > to all parsers, and leave the format parsing in
> > > bpf-prog, so the kernel code can keep relative stable.
> > > 
> > > A new kexec_file_ops is implementation, named pe_image_ops.
> > > 
> > > There are some place holder function in this patch. (They will take
> > > effect after the introduction of kexec bpf light skeleton and bpf
> > > helpers). Overall the parsing progress is a pipeline, the current
> > > bpf-prog parser is attached to bpf_handle_pefile(), and detatched at the
> > > end of the current stage 'disarm_bpf_prog()' the current parsed result
> > > by the current bpf-prog will be buffered in kernel 'prepare_nested_pe()'
> > > , and deliver to the next stage.  For each stage, the bpf bytecode is
> > > extracted from the '.bpf' section in the PE file.
> > > 
> > > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > > Cc: Baoquan He <bhe@redhat.com>
> > > Cc: Dave Young <dyoung@redhat.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Philipp Rudo <prudo@redhat.com>
> > > To: kexec@lists.infradead.org
> > > ---
> > >  include/linux/kexec.h   |   1 +
> > >  kernel/Kconfig.kexec    |   8 +
> > >  kernel/Makefile         |   1 +
> > >  kernel/kexec_pe_image.c | 356 ++++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 366 insertions(+)
> > >  create mode 100644 kernel/kexec_pe_image.c
> > >   
> > [...]
> >   
> > > diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
> > > new file mode 100644
> > > index 0000000000000..3097efccb8502
> > > --- /dev/null
> > > +++ b/kernel/kexec_pe_image.c
> > > @@ -0,0 +1,356 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Kexec PE image loader
> > > +
> > > + * Copyright (C) 2025 Red Hat, Inc
> > > + */
> > > +
> > > +#define pr_fmt(fmt)	"kexec_file(Image): " fmt
> > > +
> > > +#include <linux/err.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/list.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/vmalloc.h>
> > > +#include <linux/kexec.h>
> > > +#include <linux/pe.h>
> > > +#include <linux/string.h>
> > > +#include <linux/bpf.h>
> > > +#include <linux/filter.h>
> > > +#include <asm/byteorder.h>
> > > +#include <asm/image.h>
> > > +#include <asm/memory.h>
> > > +
> > > +
> > > +static LIST_HEAD(phase_head);
> > > +
> > > +struct parsed_phase {
> > > +	struct list_head head;
> > > +	struct list_head res_head;
> > > +};
> > > +
> > > +static struct parsed_phase *cur_phase;
> > > +
> > > +static char *kexec_res_names[3] = {"kernel", "initrd", "cmdline"};  
> > 
> > Wouldn't it be better to use a enum rather than strings for the
> > different resources? Especially as in prepare_nested_pe you are  
> 
> I plan to make bpf_copy_to_kernel() fit for more cases besides kexec. So
> string may be better choice, and I think it is better to have a
> subsystem prefix, like "kexec:kernel"

True, although an enum could be utilized directly as, e.g. an index for
an array directly. Anyway, I don't think there is a single 'best'
solution here. So feel free to use strings.

> > comparing two strings using == instead of strcmp(). So IIUC it should
> > always return false.
> >   
> 
> Oops, I will fix that. In fact, I meaned to assign the pointer
> kexec_res_names[i] to kexec_res.name in bpf_kexec_carrier(). Later in
> prepare_nested_pe() can compare two pointers.
> 
> 
> > > +struct kexec_res {
> > > +	struct list_head node;
> > > +	char *name;
> > > +	/* The free of buffer is deferred to kimage_file_post_load_cleanup */
> > > +	bool deferred_free;
> > > +	struct mem_range_result *r;
> > > +};
> > > +
> > > +static struct parsed_phase *alloc_new_phase(void)
> > > +{
> > > +	struct parsed_phase *phase = kzalloc(sizeof(struct parsed_phase), GFP_KERNEL);
> > > +
> > > +	INIT_LIST_HEAD(&phase->head);
> > > +	INIT_LIST_HEAD(&phase->res_head);
> > > +	list_add_tail(&phase->head, &phase_head);
> > > +
> > > +	return phase;
> > > +}  
> > 
> > I must admit I don't fully understand how you are handling the
> > different phases. In particular I don't understand why you are keeping
> > all the resources a phase returned once it is finished. The way I see
> > it those resources are only needed once as input for the next phase. So
> > it should be sufficient to only keep a single kexec_context and update
> > it when a phase returns a new resource. The way I see it this should
> > simplify pe_image_load quite a bit. Or am I missing something?
> >   
> 
> Let us say an aarch64 zboot image embeded in UKI's .linux section.
> The UKI parser takes apart the image into kernel, initrd, cmdline.
> And the kernel part contains the zboot PE, including zboot parser.
> The zboot parser needn't to handle either initrd or cmdline.
> So I use the phases, and the leaf node is the final parsed result.

Right, that's how the code is working. My point was that when you have
multiple phases working on the same component, e.g. the kernel image,
then you still keep all the intermediate kernel images in memory until
the end. Even though the intermediate images are only used as an input
for the next phase(s). So my suggestion is to remove them immediately
once a phase returns a new image. My expectation is that this not only
reduces the memory usage but also simplifies the code.

Thanks
Philipp

> > > +static bool is_valid_pe(const char *kernel_buf, unsigned long kernel_len)
> > > +{
> > > +	struct mz_hdr *mz;
> > > +	struct pe_hdr *pe;
> > > +
> > > +	if (!kernel_buf)
> > > +		return false;
> > > +	mz = (struct mz_hdr *)kernel_buf;
> > > +	if (mz->magic != MZ_MAGIC)
> > > +		return false;
> > > +	pe = (struct pe_hdr *)(kernel_buf + mz->peaddr);
> > > +	if (pe->magic != PE_MAGIC)
> > > +		return false;
> > > +	if (pe->opt_hdr_size == 0) {
> > > +		pr_err("optional header is missing\n");
> > > +		return false;
> > > +	}
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +static bool is_valid_format(const char *kernel_buf, unsigned long kernel_len)
> > > +{
> > > +	return is_valid_pe(kernel_buf, kernel_len);
> > > +}
> > > +
> > > +/*
> > > + * The UEFI Terse Executable (TE) image has MZ header.
> > > + */
> > > +static int pe_image_probe(const char *kernel_buf, unsigned long kernel_len)
> > > +{
> > > +	return is_valid_pe(kernel_buf, kernel_len) ? 0 : -1;  
> > 
> > Every image, at least on x86, is a valid pe file. So we should check
> > for the .bpf section rather than the header.
> >   
> 
> You are right that it should include the check on the existence of .bpf
> section. On the other hand, the check on PE header in kernel can ensure 
> the kexec-tools passes the right candidate for this parser.
> 
> > > +}
> > > +
> > > +static int get_pe_section(char *file_buf, const char *sect_name,  
> > 
> > s/get_pe_section/pe_get_section/ ?
> > that would make it more consistent with the other functions.  
> 
> Sure. I will fix it.
> 
> 
> Thanks for your careful review.
> 
> 
> Best Regards,
> 
> Pingfan
> 
> > 
> > Thanks
> > Philipp
> >   
> > > +		char **sect_start, unsigned long *sect_sz)
> > > +{
> > > +	struct pe_hdr *pe_hdr;
> > > +	struct pe32plus_opt_hdr *opt_hdr;
> > > +	struct section_header *sect_hdr;
> > > +	int section_nr, i;
> > > +	struct mz_hdr *mz = (struct mz_hdr *)file_buf;
> > > +
> > > +	*sect_start = NULL;
> > > +	*sect_sz = 0;
> > > +	pe_hdr = (struct pe_hdr *)(file_buf + mz->peaddr);
> > > +	section_nr = pe_hdr->sections;
> > > +	opt_hdr = (struct pe32plus_opt_hdr *)(file_buf + mz->peaddr + sizeof(struct pe_hdr));
> > > +	sect_hdr = (struct section_header *)((char *)opt_hdr + pe_hdr->opt_hdr_size);
> > > +
> > > +	for (i = 0; i < section_nr; i++) {
> > > +		if (strcmp(sect_hdr->name, sect_name) == 0) {
> > > +			*sect_start = file_buf + sect_hdr->data_addr;
> > > +			*sect_sz = sect_hdr->raw_data_size;
> > > +			return 0;
> > > +		}
> > > +		sect_hdr++;
> > > +	}
> > > +
> > > +	return -1;
> > > +}
> > > +
> > > +static bool pe_has_bpf_section(char *file_buf, unsigned long pe_sz)
> > > +{
> > > +	char *sect_start = NULL;
> > > +	unsigned long sect_sz = 0;
> > > +	int ret;
> > > +
> > > +	ret = get_pe_section(file_buf, ".bpf", &sect_start, &sect_sz);
> > > +	if (ret < 0)
> > > +		return false;
> > > +	return true;
> > > +}
> > > +
> > > +/* Load a ELF */
> > > +static int arm_bpf_prog(char *bpf_elf, unsigned long sz)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static void disarm_bpf_prog(void)
> > > +{
> > > +}
> > > +
> > > +struct kexec_context {
> > > +	bool kdump;
> > > +	char *image;
> > > +	int image_sz;
> > > +	char *initrd;
> > > +	int initrd_sz;
> > > +	char *cmdline;
> > > +	int cmdline_sz;
> > > +};
> > > +
> > > +void bpf_handle_pefile(struct kexec_context *context);
> > > +void bpf_post_handle_pefile(struct kexec_context *context);
> > > +
> > > +
> > > +/*
> > > + * optimize("O0") prevents inline, compiler constant propagation
> > > + */
> > > +__attribute__((used, optimize("O0"))) void bpf_handle_pefile(struct kexec_context *context)
> > > +{
> > > +}
> > > +
> > > +__attribute__((used, optimize("O0"))) void bpf_post_handle_pefile(struct kexec_context *context)
> > > +{
> > > +}
> > > +
> > > +/*
> > > + * PE file may be nested and should be unfold one by one.
> > > + * Query 'kernel', 'initrd', 'cmdline' in cur_phase, as they are inputs for the
> > > + * next phase.
> > > + */
> > > +static int prepare_nested_pe(char **kernel, unsigned long *kernel_len, char **initrd,
> > > +		unsigned long *initrd_len, char **cmdline)
> > > +{
> > > +	struct kexec_res *res;
> > > +	int ret = -1;
> > > +
> > > +	*kernel = NULL;
> > > +	*kernel_len = 0;
> > > +
> > > +	list_for_each_entry(res, &cur_phase->res_head, node) {
> > > +		if (res->name == kexec_res_names[0]) {
> > > +			*kernel = res->r->buf;
> > > +			*kernel_len = res->r->data_sz;
> > > +			ret = 0;
> > > +		} else if (res->name == kexec_res_names[1]) {
> > > +			*initrd = res->r->buf;
> > > +			*initrd_len = res->r->data_sz;
> > > +		} else if (res->name == kexec_res_names[2]) {
> > > +			*cmdline = res->r->buf;
> > > +		}
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void *pe_image_load(struct kimage *image,
> > > +				char *kernel, unsigned long kernel_len,
> > > +				char *initrd, unsigned long initrd_len,
> > > +				char *cmdline, unsigned long cmdline_len)
> > > +{
> > > +	char *parsed_kernel = NULL;
> > > +	unsigned long parsed_len;
> > > +	char *linux_start, *initrd_start, *cmdline_start, *bpf_start;
> > > +	unsigned long linux_sz, initrd_sz, cmdline_sz, bpf_sz;
> > > +	struct parsed_phase *phase, *phase_tmp;
> > > +	struct kexec_res *res, *res_tmp;
> > > +	void *ldata;
> > > +	int ret;
> > > +
> > > +	linux_start = kernel;
> > > +	linux_sz = kernel_len;
> > > +	initrd_start = initrd;
> > > +	initrd_sz = initrd_len;
> > > +	cmdline_start = cmdline;
> > > +	cmdline_sz = cmdline_len;
> > > +
> > > +	while (is_valid_format(linux_start, linux_sz) &&
> > > +	       pe_has_bpf_section(linux_start, linux_sz)) {
> > > +		struct kexec_context context;
> > > +
> > > +		get_pe_section(linux_start, ".bpf", &bpf_start, &bpf_sz);
> > > +		if (!!bpf_sz) {
> > > +			/* load and attach bpf-prog */
> > > +			ret = arm_bpf_prog(bpf_start, bpf_sz);
> > > +			if (ret) {
> > > +				pr_err("Fail to load .bpf section\n");
> > > +				ldata = ERR_PTR(ret);
> > > +				goto err;
> > > +			}
> > > +		}
> > > +		cur_phase = alloc_new_phase();
> > > +		if (image->type != KEXEC_TYPE_CRASH)
> > > +			context.kdump = false;
> > > +		else
> > > +			context.kdump = true;
> > > +		context.image = linux_start;
> > > +		context.image_sz = linux_sz;
> > > +		context.initrd = initrd_start;
> > > +		context.initrd_sz = initrd_sz;
> > > +		context.cmdline = cmdline_start;
> > > +		context.cmdline_sz = strlen(cmdline_start);
> > > +		/* bpf-prog fentry, which handle above buffers. */
> > > +		bpf_handle_pefile(&context);
> > > +
> > > +		prepare_nested_pe(&linux_start, &linux_sz, &initrd_start,
> > > +					&initrd_sz, &cmdline_start);
> > > +		/* bpf-prog fentry */
> > > +		bpf_post_handle_pefile(&context);
> > > +		/*
> > > +		 * detach the current bpf-prog from their attachment points.
> > > +		 * It also a point to free any registered interim resource.
> > > +		 * Any resource except attached to phase is interim.
> > > +		 */
> > > +		disarm_bpf_prog();
> > > +	}
> > > +
> > > +	/* the rear of parsed phase contains the result */
> > > +	list_for_each_entry_reverse(phase, &phase_head, head) {
> > > +		if (initrd != NULL && cmdline != NULL && parsed_kernel != NULL)
> > > +			break;
> > > +		list_for_each_entry(res, &phase->res_head, node) {
> > > +			if (!strcmp(res->name, "kernel") && !parsed_kernel) {
> > > +				parsed_kernel = res->r->buf;
> > > +				parsed_len = res->r->data_sz;
> > > +				res->deferred_free = true;
> > > +			} else if (!strcmp(res->name, "initrd") && !initrd) {
> > > +				initrd = res->r->buf;
> > > +				initrd_len = res->r->data_sz;
> > > +				res->deferred_free = true;
> > > +			} else if (!strcmp(res->name, "cmdline") && !cmdline) {
> > > +				cmdline = res->r->buf;
> > > +				cmdline_len = res->r->data_sz;
> > > +				res->deferred_free = true;
> > > +			}
> > > +		}
> > > +
> > > +	}
> > > +
> > > +	if (initrd == NULL || cmdline == NULL || parsed_kernel == NULL) {
> > > +		char *c, buf[64];
> > > +
> > > +		c = buf;
> > > +		if (parsed_kernel == NULL) {
> > > +			strcpy(c, "kernel ");
> > > +			c += strlen("kernel ");
> > > +		}
> > > +		if (initrd == NULL) {
> > > +			strcpy(c, "initrd ");
> > > +			c += strlen("initrd ");
> > > +		}
> > > +		if (cmdline == NULL) {
> > > +			strcpy(c, "cmdline ");
> > > +			c += strlen("cmdline ");
> > > +		}
> > > +		c = '\0';
> > > +		pr_err("Can not extract data for %s", buf);
> > > +		ldata = ERR_PTR(-EINVAL);
> > > +		goto err;
> > > +	}
> > > +	/*
> > > +	 * image's kernel_buf, initrd_buf, cmdline_buf are set. Now they should
> > > +	 * be updated to the new content.
> > > +	 */
> > > +	if (image->kernel_buf != parsed_kernel) {
> > > +		vfree(image->kernel_buf);
> > > +		image->kernel_buf = parsed_kernel;
> > > +		image->kernel_buf_len = parsed_len;
> > > +	}
> > > +	if (image->initrd_buf != initrd) {
> > > +		vfree(image->initrd_buf);
> > > +		image->initrd_buf = initrd;
> > > +		image->initrd_buf_len = initrd_len;
> > > +	}
> > > +	if (image->cmdline_buf != cmdline) {
> > > +		kfree(image->cmdline_buf);
> > > +		image->cmdline_buf = cmdline;
> > > +		image->cmdline_buf_len = cmdline_len;
> > > +	}
> > > +	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> > > +					    image->kernel_buf_len);
> > > +	if (ret) {
> > > +		pr_err("Fail to find suitable image loader\n");
> > > +		ldata = ERR_PTR(ret);
> > > +		goto err;
> > > +	}
> > > +	ldata = kexec_image_load_default(image);
> > > +	if (IS_ERR(ldata)) {
> > > +		pr_err("architecture code fails to load image\n");
> > > +		goto err;
> > > +	}
> > > +	image->image_loader_data = ldata;
> > > +
> > > +err:
> > > +	list_for_each_entry_safe(phase, phase_tmp, &phase_head, head) {
> > > +		list_for_each_entry_safe(res, res_tmp, &phase->res_head, node) {
> > > +			list_del(&res->node);
> > > +			/* defer to kimage_file_post_load_cleanup() */
> > > +			if (res->deferred_free) {
> > > +				res->r->buf = NULL;
> > > +				res->r->buf_sz = 0;
> > > +			}
> > > +			mem_range_result_put(res->r);
> > > +			kfree(res);
> > > +		}
> > > +		list_del(&phase->head);
> > > +		kfree(phase);
> > > +	}
> > > +
> > > +	return ldata;
> > > +}
> > > +
> > > +const struct kexec_file_ops kexec_pe_image_ops = {
> > > +	.probe = pe_image_probe,
> > > +	.load = pe_image_load,
> > > +#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
> > > +	.verify_sig = kexec_kernel_verify_pe_sig,
> > > +#endif
> > > +};  
> >   
> 


