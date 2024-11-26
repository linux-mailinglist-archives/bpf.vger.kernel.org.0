Return-Path: <bpf+bounces-45618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F779D9B6E
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 17:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FFE8B32D5D
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 16:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110B61D86F6;
	Tue, 26 Nov 2024 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dS8OxSMC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D5BE46;
	Tue, 26 Nov 2024 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638309; cv=none; b=pTmuCsu8pF8aLmp9vp3kpQ6iXOtoInnJeU30wg7vv+wE7jGyE7ceRRipBfbcris2aw9kfB0FkoNH2Ea9biomaOgvVlPUMBPmAUqK/sZ2LOxNVwLW36QV0tNkjHpPzGolImkbeEV2v4w0tb1de2+b1tRelAvhoViJcx1g4ofdyNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638309; c=relaxed/simple;
	bh=EWEkaPmPduTOn44sUuTXFT8o9D5hYhQYL3cJzzlC4Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8B/WPbnqkqVRq1n6Y5fU8RsJZ9Hddoz5P4o8yVGUX4CjuXrOaozaYk0TpUHvF2B2Pg/nKHGZdbZKdCOEBZ98E2a/hg9naEQW9tG1CEVBAyuPcK0BXnxv1IWQupVnkgAq6kVKxO4aLN8OD91A9qc29t+3a5+qLU6IjZtfpd27nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dS8OxSMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EF0C4CED0;
	Tue, 26 Nov 2024 16:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732638309;
	bh=EWEkaPmPduTOn44sUuTXFT8o9D5hYhQYL3cJzzlC4Q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dS8OxSMCr3TmlAWfG5Es4oSV+QUErurUmo/Wmi43axAPIftPdHSjeDyTEI9PmeLhU
	 ik79pAkPyzmABvrBNnrBq2j26rhCZl79okdtO7rTbUGbiMbng4lPirItFsbqPYrI5M
	 9SGZYdh80j667kxk3utdbTCEJ5U2lYjCEYr+e74XypF34NnaKiidFWU4Rlmx2+Rjv1
	 Hi60cq9R8inGPFJf9+47lCJp7T8W5TmsXa3ph5OBKMeUilMwmNVnvgeryJOo8fDpi1
	 96MgN8xvtZmBeUMGl12BPv+oMtiaGVwBZZRqILp2kPMxwZzhu87AjZkKi1j/8RRnRK
	 c2euPqthi7kzA==
Date: Tue, 26 Nov 2024 13:25:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, dwarves@vger.kernel.org,
	arnaldo.melo@gmail.com, bpf@vger.kernel.org, kernel-team@fb.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yonghong.song@linux.dev, Alan Maguire <alan.maguire@oracle.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH dwarves v2 1/1] btf_encoder: handle .BTF_ids section
 endianness
Message-ID: <Z0X2YnMyzNlZyQtP@x1>
References: <20241122214431.292196-1-eddyz87@gmail.com>
 <20241122214431.292196-2-eddyz87@gmail.com>
 <Z0HXqLswziDAjNrk@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0HXqLswziDAjNrk@krava>

On Sat, Nov 23, 2024 at 02:24:56PM +0100, Jiri Olsa wrote:
> On Fri, Nov 22, 2024 at 01:44:31PM -0800, Eduard Zingerman wrote:
> > btf_encoder__tag_kfuncs() reads .BTF_ids section to identify a set of
> > kfuncs present in the ELF file being processed.
> > This section consists of:
> > - arrays of uint32_t elements;
> > - arrays of records with the following structure:
> >   struct btf_id_and_flag {
> >       uint32_t id;
> >       uint32_t flags;
> >   };
> > 
> > When endianness of a binary operated by pahole differs from the host
> > system's endianness, these fields require byte-swapping before use.
> > Currently, this byte-swapping does not occur, resulting in kfuncs not
> > being marked with declaration tags.
> > 
> > This commit resolves the issue by introducing an endianness conversion
> > step for the .BTF_ids section data before the main processing stage.
> > Since the ELF file is opened in O_RDONLY mode, gelf_xlatetom()
> > cannot be used for endianness conversion.
> > Instead, a new type is introduced:
> > 
> >   struct local_elf_data {
> > 	void *d_buf;
> > 	size_t d_size;
> > 	int64_t d_off;
> > 	bool owns_buf;
> >   };
> > 
> > This structure is populated from the Elf_Data object representing
> > the .BTF_ids section. When byte-swapping is required, a local copy
> > of d_buf is created.
> > 
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Daniel Xu <dxu@dxuuu.xyz>
> > Cc: Jiri Olsa <olsajiri@gmail.com>
> > Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Cc: Vadim Fedorenko <vadfed@meta.com>
> > Fixes: 72e88f29c6f7 ("pahole: Inject kfunc decl tags into BTF")
> > Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Looks ok to me as well, only byte swaps when needed, so affects only
cross BTF encoding.

Alan, have you looked at this as well?

I think I saw instructions in one of the messages in this thread to get
hold of a vmlinux for s390 and test it. Right?

One extra question: this solves the BTF encoder case, the loader already
supported loading BTF from a different endianness, right? Lemme
check.

cus__load_btf()
  cu->little_endian = btf__endianness(btf) == BTF_LITTLE_ENDIAN;

enum btf_endianness btf__endianness(const struct btf *btf)
{
        if (is_host_big_endian())
                return btf->swapped_endian ? BTF_LITTLE_ENDIAN : BTF_BIG_ENDIAN;
        else
                return btf->swapped_endian ? BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN;
}

So we have parts of BTF byte swapping happening in libbpf and with this
patch, parts of it done in pahole, have you tought about doing this in
libbpf instead?

- Arnaldo
 
> > ---
> >  btf_encoder.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 59 insertions(+), 6 deletions(-)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index e1adddf..06d4a61 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -33,6 +33,7 @@
> >  #include <stdint.h>
> >  #include <search.h> /* for tsearch(), tfind() and tdestroy() */
> >  #include <pthread.h>
> > +#include <byteswap.h>
> >  
> >  #define BTF_IDS_SECTION		".BTF_ids"
> >  #define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
> > @@ -145,6 +146,14 @@ struct btf_kfunc_set_range {
> >  	uint64_t end;
> >  };
> >  
> > +/* Like Elf_Data, but when there is a need to change the data read from ELF */
> > +struct local_elf_data {
> > +	void *d_buf;
> > +	size_t d_size;
> > +	int64_t d_off;
> > +	bool owns_buf;
> > +};
> > +
> >  static LIST_HEAD(encoders);
> >  static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
> >  
> > @@ -1681,7 +1690,8 @@ out:
> >  }
> >  
> >  /* Returns if `sym` points to a kfunc set */
> > -static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, Elf_Data *idlist, size_t idlist_addr)
> > +static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, struct local_elf_data *idlist,
> > +			    size_t idlist_addr)
> >  {
> >  	void *ptr = idlist->d_buf;
> >  	struct btf_id_set8 *set;
> > @@ -1847,13 +1857,52 @@ static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *
> >  	return 0;
> >  }
> >  
> > +/* If byte order of 'elf' differs from current byte order, convert the data->d_buf.
> > + * ELF file is opened in a readonly mode, so data->d_buf cannot be modified in place.
> > + * Instead, allocate a new buffer if modification is necessary.
> > + */
> > +static int convert_idlist_endianness(Elf *elf, Elf_Data *src, struct local_elf_data *dst)
> > +{
> > +	int byteorder, i;
> > +	char *elf_ident;
> > +	uint32_t *tmp;
> > +
> > +	dst->d_size = src->d_size;
> > +	dst->d_off = src->d_off;
> > +	elf_ident = elf_getident(elf, NULL);
> > +	if (elf_ident == NULL) {
> > +		fprintf(stderr, "Cannot get ELF identification from header\n");
> > +		return -EINVAL;
> > +	}
> > +	byteorder = elf_ident[EI_DATA];
> > +	if ((BYTE_ORDER == LITTLE_ENDIAN && byteorder == ELFDATA2LSB)
> > +	    || (BYTE_ORDER == BIG_ENDIAN && byteorder == ELFDATA2MSB)) {
> > +		dst->d_buf = src->d_buf;
> > +		dst->owns_buf = false;
> > +		return 0;
> > +	}
> > +	tmp = malloc(src->d_size);
> > +	if (tmp == NULL) {
> > +		fprintf(stderr, "Cannot allocate %lu bytes of memory\n", src->d_size);
> > +		return -ENOMEM;
> > +	}
> > +	memcpy(tmp, src->d_buf, src->d_size);
> > +	dst->d_buf = tmp;
> > +	dst->owns_buf = true;
> > +
> > +	/* .BTF_ids sections consist of u32 objects */
> > +	for (i = 0; i < dst->d_size / sizeof(uint32_t); i++)
> > +		tmp[i] = bswap_32(tmp[i]);
> > +	return 0;
> > +}
> > +
> >  static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> >  {
> >  	const char *filename = encoder->source_filename;
> >  	struct gobuffer btf_kfunc_ranges = {};
> > +	struct local_elf_data idlist = {};
> >  	struct gobuffer btf_funcs = {};
> >  	Elf_Data *symbols = NULL;
> > -	Elf_Data *idlist = NULL;
> >  	Elf_Scn *symscn = NULL;
> >  	int symbols_shndx = -1;
> >  	size_t idlist_addr = 0;
> > @@ -1918,7 +1967,9 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> >  		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
> >  			idlist_shndx = i;
> >  			idlist_addr = shdr.sh_addr;
> > -			idlist = data;
> > +			err = convert_idlist_endianness(elf, data, &idlist);
> > +			if (err < 0)
> > +				goto out;
> >  		}
> >  	}
> >  
> > @@ -1960,7 +2011,7 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> >  			continue;
> >  
> >  		name = elf_strptr(elf, strtabidx, sym.st_name);
> > -		if (!is_sym_kfunc_set(&sym, name, idlist, idlist_addr))
> > +		if (!is_sym_kfunc_set(&sym, name, &idlist, idlist_addr))
> >  			continue;
> >  
> >  		range.start = sym.st_value;
> > @@ -2003,13 +2054,13 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> >  			if (ranges[j].start <= addr && addr < ranges[j].end) {
> >  				found = true;
> >  				off = addr - idlist_addr;
> > -				if (off < 0 || off + sizeof(*pair) > idlist->d_size) {
> > +				if (off < 0 || off + sizeof(*pair) > idlist.d_size) {
> >  					fprintf(stderr, "%s: kfunc '%s' offset outside section '%s'\n",
> >  						__func__, func, BTF_IDS_SECTION);
> >  					free(func);
> >  					goto out;
> >  				}
> > -				pair = idlist->d_buf + off;
> > +				pair = idlist.d_buf + off;
> >  				break;
> >  			}
> >  		}
> > @@ -2031,6 +2082,8 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> >  out:
> >  	__gobuffer__delete(&btf_funcs);
> >  	__gobuffer__delete(&btf_kfunc_ranges);
> > +	if (idlist.owns_buf)
> > +		free(idlist.d_buf);
> >  	if (elf)
> >  		elf_end(elf);
> >  	if (fd != -1)
> > -- 
> > 2.47.0
> > 

