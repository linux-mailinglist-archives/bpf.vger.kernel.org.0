Return-Path: <bpf+bounces-68661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B87FB7F379
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24882A6137
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 13:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE33C32E74B;
	Wed, 17 Sep 2025 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZwPpITD"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2693132BC06
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114284; cv=none; b=bRGD+rOEOvwF4cefRBPE003eEC10k1GRRo0nMvwLM67qYN1eI2WbqiIj6da6aFDHByYytmu+p5ZgCxjjpXubKhAm3WmHm0JDedIOytVVPr6EANLqlhmoF0Ww79z1mUiX5CINqc5E9tHg3iry+TzoDKgidt2N6lwnmtg34om2J3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114284; c=relaxed/simple;
	bh=aCLINqOJXo7aCsdceGXF06zzKag3pasl55vbCKEB5bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8gp4PQiRox6RJKpcgbdB9VrcKLbDGMe4z8Rxi2UAhVHwe1Hwpoegc9W+3p1y/JHbe2o74ndu2w45rBDV9U814gPW2Aowxh0I9nRAZU9iIELhVuipUIGLQERe3/apN9DS3//2/75RH2F6kgo0mS1bbxCiYmN6MX9bWsEKV27+ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZwPpITD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758114281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9M0HY5vU9dfbX9REnWEbhEbNzjrF7Jv8rQDTMuCSe3Q=;
	b=AZwPpITD2PpMgg9neTF58zGRP0L+CgNs8UMO0B+qVk4Mk2nzrEQ+iyJPtZNT8Pg0o9tqjM
	P3oRkA+Wd3DASdh0b3hHYidAiRjBb8PP19jk4T+EcvHa+RpSwpnV6BAn9E4mGAjdvQ3y0T
	sUIk06YYj9PU7ABZjgxFwom5tut7xbY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-_SJLiuuaMxmEsmTOKRCDtg-1; Wed,
 17 Sep 2025 09:04:38 -0400
X-MC-Unique: _SJLiuuaMxmEsmTOKRCDtg-1
X-Mimecast-MFC-AGG-ID: _SJLiuuaMxmEsmTOKRCDtg_1758114276
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73886180057F;
	Wed, 17 Sep 2025 13:04:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.96])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC4001955F19;
	Wed, 17 Sep 2025 13:04:31 +0000 (UTC)
Date: Wed, 17 Sep 2025 21:04:28 +0800
From: Pingfan Liu <piliu@redhat.com>
To: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: Re: [PATCHv5 05/12] kexec: Introduce kexec_pe_image to parse and
 load PE file
Message-ID: <aMqx3PLkYLp3FLOD@fedora>
References: <20250819012428.6217-1-piliu@redhat.com>
 <20250819012428.6217-6-piliu@redhat.com>
 <20250901163020.30ce3c1e@rotkaeppchen>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901163020.30ce3c1e@rotkaeppchen>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Sep 01, 2025 at 04:30:20PM +0200, Philipp Rudo wrote:
> Hi Pingfan,
> 
> a few nits in addition to what is mentioned in the cover letter.
> 

Besides the following comment, as we agree on your suggestion, many of
the logic in this file will be moved to kimage_file_prepare_segments().

> On Tue, 19 Aug 2025 09:24:21 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
> 
> > As UEFI becomes popular, a few architectures support to boot a PE format
> > kernel image directly. But the internal of PE format varies, which means
> > each parser for each format.
> > 
> > This patch (with the rest in this series) introduces a common skeleton
> > to all parsers, and leave the format parsing in
> > bpf-prog, so the kernel code can keep relative stable.
> > 
> > A new kexec_file_ops is implementation, named pe_image_ops.
> > 
> > There are some place holder function in this patch. (They will take
> > effect after the introduction of kexec bpf light skeleton and bpf
> > helpers). Overall the parsing progress is a pipeline, the current
> > bpf-prog parser is attached to bpf_handle_pefile(), and detatched at the
> > end of the current stage 'disarm_bpf_prog()' the current parsed result
> > by the current bpf-prog will be buffered in kernel 'prepare_nested_pe()'
> > , and deliver to the next stage.  For each stage, the bpf bytecode is
> > extracted from the '.bpf' section in the PE file.
> > 
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Philipp Rudo <prudo@redhat.com>
> > To: kexec@lists.infradead.org
> > ---
> >  include/linux/kexec.h   |   1 +
> >  kernel/Kconfig.kexec    |   9 ++
> >  kernel/Makefile         |   1 +
> >  kernel/kexec_pe_image.c | 348 ++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 359 insertions(+)
> >  create mode 100644 kernel/kexec_pe_image.c
> 
> [...]
> 
> > new file mode 100644
> > index 0000000000000..b0cf9942e68d2
> > --- /dev/null
> > +++ b/kernel/kexec_pe_image.c
> > @@ -0,0 +1,348 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Kexec PE image loader
> > +
> > + * Copyright (C) 2025 Red Hat, Inc
> > + */
> > +
> > +#define pr_fmt(fmt)	"kexec_file(Image): " fmt
> > +
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/list.h>
> > +#include <linux/kernel.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/kexec.h>
> > +#include <linux/pe.h>
> > +#include <linux/string.h>
> > +#include <linux/bpf.h>
> > +#include <linux/filter.h>
> > +#include <asm/byteorder.h>
> > +#include <asm/image.h>
> > +#include <asm/memory.h>
> > +
> > +
> > +#define KEXEC_RES_KERNEL_NAME "kexec:kernel"
> > +#define KEXEC_RES_INITRD_NAME "kexec:initrd"
> > +#define KEXEC_RES_CMDLINE_NAME "kexec:cmdline"
> > +
> > +struct kexec_res {
> > +	char *name;
> > +	/* The free of buffer is deferred to kimage_file_post_load_cleanup */
> > +	struct mem_range_result *r;
> > +};
> > +
> > +static struct kexec_res parsed_resource[3] = {
> > +	{ KEXEC_RES_KERNEL_NAME, },
> > +	{ KEXEC_RES_INITRD_NAME, },
> > +	{ KEXEC_RES_CMDLINE_NAME, },
> > +};
> > +
> > +static bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz);
> > +
> > +static bool is_valid_pe(const char *kernel_buf, unsigned long kernel_len)
> > +{
> > +	struct mz_hdr *mz;
> > +	struct pe_hdr *pe;
> > +
> > +	if (!kernel_buf)
> > +		return false;
> > +	mz = (struct mz_hdr *)kernel_buf;
> > +	if (mz->magic != IMAGE_DOS_SIGNATURE)
> > +		return false;
> > +	pe = (struct pe_hdr *)(kernel_buf + mz->peaddr);
> > +	if (pe->magic != IMAGE_NT_SIGNATURE)
> > +		return false;
> > +	if (pe->opt_hdr_size == 0) {
> > +		pr_err("optional header is missing\n");
> > +		return false;
> > +	}
> > +
> > +	return pe_has_bpf_section(kernel_buf, kernel_len);
> > +}
> 
> Also check for 
> pe32plus_opt_hdr->subsys == IMAGE_SUBSYSTEM_EFI_APPLICATION?
> 

Yes, it would be better.

> > +
> > +static bool is_valid_format(const char *kernel_buf, unsigned long kernel_len)
> > +{
> > +	return is_valid_pe(kernel_buf, kernel_len);
> > +}
> > +
> > +/*
> > + * The UEFI Terse Executable (TE) image has MZ header.
> > + */
> > +static int pe_image_probe(const char *kernel_buf, unsigned long kernel_len)
> > +{
> > +	return is_valid_pe(kernel_buf, kernel_len) ? 0 : -1;
> > +}
> > +
> > +static int pe_get_section(const char *file_buf, const char *sect_name,
> > +		char **sect_start, unsigned long *sect_sz)
> > +{
> > +	struct pe_hdr *pe_hdr;
> > +	struct pe32plus_opt_hdr *opt_hdr;
> > +	struct section_header *sect_hdr;
> > +	int section_nr, i;
> > +	struct mz_hdr *mz = (struct mz_hdr *)file_buf;
> > +
> > +	*sect_start = NULL;
> > +	*sect_sz = 0;
> > +	pe_hdr = (struct pe_hdr *)(file_buf + mz->peaddr);
> > +	section_nr = pe_hdr->sections;
> > +	opt_hdr = (struct pe32plus_opt_hdr *)(file_buf + mz->peaddr + sizeof(struct pe_hdr));
> > +	sect_hdr = (struct section_header *)((char *)opt_hdr + pe_hdr->opt_hdr_size);
> > +
> > +	for (i = 0; i < section_nr; i++) {
> > +		if (strcmp(sect_hdr->name, sect_name) == 0) {
> > +			*sect_start = (char *)file_buf + sect_hdr->data_addr;
> > +			*sect_sz = sect_hdr->raw_data_size;
> > +			return 0;
> > +		}
> > +		sect_hdr++;
> > +	}
> > +
> > +	return -1;
> > +}
> > +
> > +static bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz)
> > +{
> > +	char *sect_start = NULL;
> > +	unsigned long sect_sz = 0;
> > +	int ret;
> > +
> > +	ret = pe_get_section(file_buf, ".bpf", &sect_start, &sect_sz);
> > +	if (ret < 0)
> > +		return false;
> > +	return true;
> > +}
> > +
> > +/* Load a ELF */
> > +static int arm_bpf_prog(char *bpf_elf, unsigned long sz)
> > +{
> > +	return 0;
> > +}
> > +
> > +static void disarm_bpf_prog(void)
> > +{
> > +}
> > +
> > +struct kexec_context {
> > +	bool kdump;
> > +	char *image;
> > +	int image_sz;
> > +	char *initrd;
> > +	int initrd_sz;
> > +	char *cmdline;
> > +	int cmdline_sz;
> > +};
> > +
> > +void bpf_handle_pefile(struct kexec_context *context);
> > +void bpf_post_handle_pefile(struct kexec_context *context);
> > +
> > +
> > +/*
> > + * optimize("O0") prevents inline, compiler constant propagation
> > + */
> > +__attribute__((used, optimize("O0"))) void bpf_handle_pefile(struct kexec_context *context)
> > +{
> > +	/*
> > +	 * To prevent linker from Identical Code Folding (ICF) with bpf_handle_pefile,
> > +	 * making them have different code.
> > +	 */
> > +	volatile int dummy = 0;
> > +
> > +	dummy += 1;
> > +}
> > +
> > +__attribute__((used, optimize("O0"))) void bpf_post_handle_pefile(struct kexec_context *context)
> > +{
> > +	volatile int dummy = 0;
> > +
> > +	dummy += 2;
> > +}
> > +
> > +/*
> > + * PE file may be nested and should be unfold one by one.
> > + * Query 'kernel', 'initrd', 'cmdline' in cur_phase, as they are inputs for the
> > + * next phase.
> > + */
> > +static int prepare_nested_pe(char **kernel, unsigned long *kernel_len, char **initrd,
> > +		unsigned long *initrd_len, char **cmdline)
> > +{
> > +	struct kexec_res *res;
> > +	int ret = -1;
> > +
> > +	*kernel = NULL;
> > +	*kernel_len = 0;
> > +
> > +	res = &parsed_resource[0];
> > +	if (!!res->r) {
> > +		*kernel = res->r->buf;
> > +		*kernel_len = res->r->data_sz;
> > +		ret = 0;
> > +	}
> > +
> > +	res = &parsed_resource[1];
> > +	if (!!res->r) {
> > +		*initrd = res->r->buf;
> > +		*initrd_len = res->r->data_sz;
> > +	}
> > +
> > +	res = &parsed_resource[2];
> > +	if (!!res->r) {
> > +		*cmdline = res->r->buf;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static void *pe_image_load(struct kimage *image,
> > +				char *kernel, unsigned long kernel_len,
> > +				char *initrd, unsigned long initrd_len,
> > +				char *cmdline, unsigned long cmdline_len)
> > +{
> > +	char *linux_start, *initrd_start, *cmdline_start, *bpf_start;
> > +	unsigned long linux_sz, initrd_sz, cmdline_sz, bpf_sz;
> 
> I don't see a point in defining all the
> {linux,initrd,cmdline}_{start,sz} variables. Either you could reuse
> the corresponding {kernel,initrd,cmdline} variables from the function
> definition. Or better use a kexec_context that contains the same
> information.
> 

OK, I will remove them.

> > +	struct kexec_res *res;
> > +	struct mem_range_result *r;
> > +	void *ldata;
> > +	int ret;
> > +
> > +	linux_start = kernel;
> > +	linux_sz = kernel_len;
> > +	initrd_start = initrd;
> > +	initrd_sz = initrd_len;
> > +	cmdline_start = cmdline;
> > +	cmdline_sz = cmdline_len;
> > +
> > +	while (is_valid_format(linux_start, linux_sz) &&
> > +	       pe_has_bpf_section(linux_start, linux_sz)) {
> > +		struct kexec_context context;
> > +
> > +		pe_get_section((const char *)linux_start, ".bpf", &bpf_start, &bpf_sz);
> > +		if (!!bpf_sz) {
> > +			/* load and attach bpf-prog */
> > +			ret = arm_bpf_prog(bpf_start, bpf_sz);
> > +			if (ret) {
> > +				pr_err("Fail to load .bpf section\n");
> > +				ldata = ERR_PTR(ret);
> > +				goto err;
> > +			}
> > +		}
> > +		if (image->type != KEXEC_TYPE_CRASH)
> > +			context.kdump = false;
> > +		else
> > +			context.kdump = true;
> 
> The bpf_prog cannot change whether kexec is used to load a kdump or
> normal kernel. So this check can be moved outside the loop.
> 

Original, this assignment happens only if the file has valid bpf-prog,
which is the loop body. But I have no strong opinion about it. I can
declare context outside the loop as __maybe_unused.

> > +		context.image = linux_start;
> > +		context.image_sz = linux_sz;
> > +		context.initrd = initrd_start;
> > +		context.initrd_sz = initrd_sz;
> > +		context.cmdline = cmdline_start;
> > +		context.cmdline_sz = strlen(cmdline_start);
> > +		/* bpf-prog fentry, which handle above buffers. */
> > +		bpf_handle_pefile(&context);
> > +
> > +		prepare_nested_pe(&linux_start, &linux_sz, &initrd_start,
> > +					&initrd_sz, &cmdline_start);
> > +		/* bpf-prog fentry */
> > +		bpf_post_handle_pefile(&context);
> > +		/*
> > +		 * detach the current bpf-prog from their attachment points.
> > +		 */
> > +		disarm_bpf_prog();
> > +	}
> > +
> > +	/*
> > +	 * image's kernel_buf, initrd_buf, cmdline_buf are set. Now they should
> > +	 * be updated to the new content.
> > +	 */
> > +
> > +	res = &parsed_resource[0];
> > +	/* Kernel part should always be parsed */
> > +	if (!res->r) {
> > +		pr_err("Can not parse kernel\n");
> > +		ldata = ERR_PTR(-EINVAL);
> > +		goto err;
> > +	}
> > +	kernel = res->r->buf;
> > +	kernel_len = res->r->data_sz;
> > +	vfree(image->kernel_buf);
> > +	image->kernel_buf = kernel;
> > +	image->kernel_buf_len = kernel_len;
> 
> Can't you assign the output to image->kernel_buf{_len} directly? Same
> for initrd and cmdline.
> 

OK.

> > +
> > +	res = &parsed_resource[1];
> > +	if (!!res->r) {
> > +		initrd = res->r->buf;
> > +		initrd_len = res->r->data_sz;
> > +		vfree(image->initrd_buf);
> > +		image->initrd_buf = initrd;
> > +		image->initrd_buf_len = initrd_len;
> > +	}
> > +	res = &parsed_resource[2];
> > +	if (!!res->r) {
> > +		cmdline = res->r->buf;
> > +		cmdline_len = res->r->data_sz;
> > +		kfree(image->cmdline_buf);
> > +		image->cmdline_buf = cmdline;
> > +		image->cmdline_buf_len = cmdline_len;
> > +	}
> > +
> > +	if (kernel == NULL || initrd == NULL || cmdline == NULL) {
> > +		char *c, buf[64];
> > +
> > +		c = buf;
> > +		if (kernel == NULL) {
> > +			strcpy(c, "kernel ");
> > +			c += strlen("kernel ");
> > +		}
> > +		if (initrd == NULL) {
> > +			strcpy(c, "initrd ");
> > +			c += strlen("initrd ");
> > +		}
> > +		if (cmdline == NULL) {
> > +			strcpy(c, "cmdline ");
> > +			c += strlen("cmdline ");
> > +		}
> > +		c = '\0';
> > +		pr_err("Can not extract data for %s", buf);
> > +		ldata = ERR_PTR(-EINVAL);
> > +		goto err;
> > +	}
> 
> This check needs to go. Not having a initrd or cmdline is not an error
> plus not having a kernel already throws an error above. In case you
> want to keep the error message for debugging purpose you can add it to
> the 'else' paths above.
> 

Ah, it is valid to have either initrd or cmdline as NULL in
kexec_file_load. I will remove this chunk regarding to the check on
kernel done.

> > +
> > +	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> > +					    image->kernel_buf_len);
> > +	if (ret) {
> > +		pr_err("Fail to find suitable image loader\n");
> > +		ldata = ERR_PTR(ret);
> > +		goto err;
> > +	}
> > +	ldata = kexec_image_load_default(image);
> > +	if (IS_ERR(ldata)) {
> > +		pr_err("architecture code fails to load image\n");
> > +		goto err;
> > +	}
> > +	image->image_loader_data = ldata;
> > +
> > +err:
> > +	for (int i = 0; i < 3; i++) {
> 
> Can you please get rid of the magic '3', e.g. by using ARRAY_SIZE.
> 

Yes.


Thank you for careful review.

Best Regards,

Pingfan

> Thanks
> Philipp
> 
> > +		r = parsed_resource[i].r;
> > +		if (!r)
> > +			continue;
> > +		parsed_resource[i].r = NULL;
> > +		/*
> > +		 * The release of buffer defers to
> > +		 * kimage_file_post_load_cleanup()
> > +		 */
> > +		r->buf = NULL;
> > +		r->buf_sz = 0;
> > +		mem_range_result_put(r);
> > +	}
> > +
> > +	return ldata;
> > +}
> > +
> > +const struct kexec_file_ops kexec_pe_image_ops = {
> > +	.probe = pe_image_probe,
> > +	.load = pe_image_load,
> > +#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
> > +	.verify_sig = kexec_kernel_verify_pe_sig,
> > +#endif
> > +};
> 


