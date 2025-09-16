Return-Path: <bpf+bounces-68461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A56B58B26
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 03:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702C51B215E7
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 01:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1178B1FAC34;
	Tue, 16 Sep 2025 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8Fqr5eV"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AE13B293
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986092; cv=none; b=pX6VuQ7DZ5w65kw4XBeCFJi3mV8/dGX+48tjJmvdmW7Ys4JsPxY931XdrH+opZPyU4hgnUNQKWGmdpPajUvYtNWcU4DgDCir4n4VJCCOQOBK3ZyubtciN2M0yERU2nx6QyLhz9KVIbq2sgIAYFEPIT+kXm+0cK5Os3aQNjz7vOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986092; c=relaxed/simple;
	bh=V0yugxsvcLj8XGjY02UDDjUKYpDyhudTfXsjh1q7qrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr113gVuEex6yM/daSB5+b9dm9qC75V/y30Sp2KMzq7asZofPfk1MXSbrh+ZKHz7qoll3jT6qVtILwV0xiVBCWgZJQ+ryuHYmL4yVMDccB8Sa4AhgnmW+pPZsbeNlAfFlX3DH7h4lSfazMH8YwG8x9pKRV8zxlWnqzwuh+dXSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8Fqr5eV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757986089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cqymUK0o/gtjDA+DSxafe5/sd/gWVsVOQwBD6bvjgNg=;
	b=e8Fqr5eVPyaB2NyIhk7OUNu08ncffQ0fH2ZnykwCI+A2LHPyFw+fJJd0ql+kynXeM4fe/D
	TOezK1jG0OEYi1JIs+MErCo+2hMqzLbdi4/7ocIgK8RJKAgI0TMQSNErI5HN1IZlGvsOjw
	rN7+jn2TWbtVziYLgoduYNTKTQVS1VU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-29APtI7xObGeh3pus7KrmQ-1; Mon,
 15 Sep 2025 21:28:08 -0400
X-MC-Unique: 29APtI7xObGeh3pus7KrmQ-1
X-Mimecast-MFC-AGG-ID: 29APtI7xObGeh3pus7KrmQ_1757986086
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B430E180057A;
	Tue, 16 Sep 2025 01:28:04 +0000 (UTC)
Received: from localhost (unknown [10.72.112.143])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 510B419560A2;
	Tue, 16 Sep 2025 01:28:01 +0000 (UTC)
Date: Tue, 16 Sep 2025 09:27:59 +0800
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
Subject: Re: [PATCHv5 08/12] kexec: Factor out routine to find a symbol in ELF
Message-ID: <aMi9H7Jeuiq8mbyE@fedora>
References: <20250819012428.6217-1-piliu@redhat.com>
 <20250819012428.6217-9-piliu@redhat.com>
 <20250901163107.5a0c17e6@rotkaeppchen>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901163107.5a0c17e6@rotkaeppchen>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Sep 01, 2025 at 04:31:07PM +0200, Philipp Rudo wrote:
> On Tue, 19 Aug 2025 09:24:24 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
> 
> > The routine to search a symbol in ELF can be shared, so split it out.
> > 
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Philipp Rudo <prudo@redhat.com>
> > To: kexec@lists.infradead.org
> > ---
> >  include/linux/kexec.h |  8 ++++
> >  kernel/kexec_file.c   | 86 +++++++++++++++++++++++--------------------
> >  2 files changed, 54 insertions(+), 40 deletions(-)
> > 
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index 8f7322c932fb5..2998d8da09d86 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -23,6 +23,10 @@
> >  #include <uapi/linux/kexec.h>
> >  #include <linux/verification.h>
> >  
> > +#if defined(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) || defined(CONFIG_KEXEC_PE_IMAGE)
> > +#include <linux/module.h>
> > +#endif
> > +
> 
> What is linux/module.h used for? Plus module.h already gets included a
> little below, when CONFIG_KEXEC_CORE is set, which should always be the
> case for those two configs.
> 

Yes, it should be dropped. Once I placed the declaration of
elf_find_symbol() here, and later moved it behind.


Thanks,

Pingfan

> Thanks
> Philipp
> 
> >  extern note_buf_t __percpu *crash_notes;
> >  
> >  #ifdef CONFIG_CRASH_DUMP
> > @@ -550,6 +554,10 @@ void set_kexec_sig_enforced(void);
> >  static inline void set_kexec_sig_enforced(void) {}
> >  #endif
> >  
> > +#if defined(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) || defined(CONFIG_KEXEC_PE_IMAGE)
> > +const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name);
> > +#endif
> > +
> >  #endif /* !defined(__ASSEBMLY__) */
> >  
> >  #endif /* LINUX_KEXEC_H */
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 4780d8aae24e7..137049e7e2410 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -880,6 +880,51 @@ static int kexec_calculate_store_digests(struct kimage *image)
> >  	return ret;
> >  }
> >  
> > +#if defined(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) || defined(CONFIG_KEXEC_PE_IMAGE)
> > +const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name)
> > +{
> > +	const Elf_Shdr *sechdrs;
> > +	const Elf_Sym *syms;
> > +	const char *strtab;
> > +	int i, k;
> > +
> > +	sechdrs = (void *)ehdr + ehdr->e_shoff;
> > +
> > +	for (i = 0; i < ehdr->e_shnum; i++) {
> > +		if (sechdrs[i].sh_type != SHT_SYMTAB)
> > +			continue;
> > +
> > +		if (sechdrs[i].sh_link >= ehdr->e_shnum)
> > +			/* Invalid strtab section number */
> > +			continue;
> > +		strtab = (void *)ehdr + sechdrs[sechdrs[i].sh_link].sh_offset;
> > +		syms = (void *)ehdr + sechdrs[i].sh_offset;
> > +
> > +		/* Go through symbols for a match */
> > +		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
> > +			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
> > +				continue;
> > +
> > +			if (strcmp(strtab + syms[k].st_name, name) != 0)
> > +				continue;
> > +
> > +			if (syms[k].st_shndx == SHN_UNDEF ||
> > +			    syms[k].st_shndx >= ehdr->e_shnum) {
> > +				pr_debug("Symbol: %s has bad section index %d.\n",
> > +						name, syms[k].st_shndx);
> > +				return NULL;
> > +			}
> > +
> > +			/* Found the symbol we are looking for */
> > +			return &syms[k];
> > +		}
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +#endif
> > +
> >  #ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
> >  /*
> >   * kexec_purgatory_setup_kbuf - prepare buffer to load purgatory.
> > @@ -1137,49 +1182,10 @@ int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
> >  static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
> >  						  const char *name)
> >  {
> > -	const Elf_Shdr *sechdrs;
> > -	const Elf_Ehdr *ehdr;
> > -	const Elf_Sym *syms;
> > -	const char *strtab;
> > -	int i, k;
> > -
> >  	if (!pi->ehdr)
> >  		return NULL;
> >  
> > -	ehdr = pi->ehdr;
> > -	sechdrs = (void *)ehdr + ehdr->e_shoff;
> > -
> > -	for (i = 0; i < ehdr->e_shnum; i++) {
> > -		if (sechdrs[i].sh_type != SHT_SYMTAB)
> > -			continue;
> > -
> > -		if (sechdrs[i].sh_link >= ehdr->e_shnum)
> > -			/* Invalid strtab section number */
> > -			continue;
> > -		strtab = (void *)ehdr + sechdrs[sechdrs[i].sh_link].sh_offset;
> > -		syms = (void *)ehdr + sechdrs[i].sh_offset;
> > -
> > -		/* Go through symbols for a match */
> > -		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
> > -			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
> > -				continue;
> > -
> > -			if (strcmp(strtab + syms[k].st_name, name) != 0)
> > -				continue;
> > -
> > -			if (syms[k].st_shndx == SHN_UNDEF ||
> > -			    syms[k].st_shndx >= ehdr->e_shnum) {
> > -				pr_debug("Symbol: %s has bad section index %d.\n",
> > -						name, syms[k].st_shndx);
> > -				return NULL;
> > -			}
> > -
> > -			/* Found the symbol we are looking for */
> > -			return &syms[k];
> > -		}
> > -	}
> > -
> > -	return NULL;
> > +	return elf_find_symbol(pi->ehdr, name);
> >  }
> >  
> >  void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name)
> 


