Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56B443D164
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 21:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbhJ0TIM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 15:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240551AbhJ0TIK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 15:08:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89EED60296;
        Wed, 27 Oct 2021 19:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635361544;
        bh=oASi6surqpnnbqD8BoYZtifRE/ITWs1gY7nOQBZymAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZoKziiZaSzTr7LFkD8Ji8B7uTHEHDcZMQPCY2daRIVeLBMfN2KZVVlgjltva1oBX3
         +TV9586lIJZOHVK7ygV470zSWXX2AHeOrIp96iz9Ixm1awxELDZdWEWoYC8YkIUuSp
         me7Fe+/77l3p94Vp+lOqXxXSR9dhM0aG3ONbLaowhj7IOKDEcDURkkOkVLDt/PDRpK
         pMOY0UMds0uIyFyMgc4SCUmjjX8Bj+/wcEv45Ao9geZS3LH7McAbFIWh7M9riNL3Lc
         zjjeiXWJJ3owUaxXoLLsqs2ui7f2dfZBfqTJNr5qMuac/40XnPVZd7JE2SrrkzrBmi
         f6rZiglJMR/Ww==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7244A410A1; Wed, 27 Oct 2021 16:05:42 -0300 (-03)
Date:   Wed, 27 Oct 2021 16:05:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf-next v3 2/6] libbpf: Use __BYTE_ORDER__
Message-ID: <YXmjBiq4ujhQDIN0@kernel.org>
References: <20211026010831.748682-1-iii@linux.ibm.com>
 <20211026010831.748682-3-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211026010831.748682-3-iii@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Oct 26, 2021 at 03:08:27AM +0200, Ilya Leoshkevich escreveu:
> Use the compiler-defined __BYTE_ORDER__ instead of the libc-defined
> __BYTE_ORDER for consistency.

There are some in tools/perf/:

⬢[acme@toolbox perf]$ find tools/perf -name "*.[ch]" | xargs grep -w __BYTE_ORDER
tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c:#if __BYTE_ORDER == __BIG_ENDIAN
tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c:#if __BYTE_ORDER == __BIG_ENDIAN
tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c:#if __BYTE_ORDER == __BIG_ENDIAN
tools/perf/util/genelf.h:#if __BYTE_ORDER == __BIG_ENDIAN
tools/perf/util/intel-bts.c:#if __BYTE_ORDER == __BIG_ENDIAN
tools/perf/util/s390-cpumsf.c:#if __BYTE_ORDER == __LITTLE_ENDIAN
tools/perf/util/s390-cpumsf.c:#if __BYTE_ORDER == __LITTLE_ENDIAN
tools/perf/util/s390-cpumsf.c:#if __BYTE_ORDER == __LITTLE_ENDIAN
tools/perf/util/s390-cpumsf.c:#if __BYTE_ORDER == __LITTLE_ENDIAN
tools/perf/util/data-convert-bt.c:#if __BYTE_ORDER == __BIG_ENDIAN
⬢[acme@toolbox perf]$

Please consider submitting a patch for those as well, please :-)

- Arnaldo
 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/btf.c       |  4 ++--
>  tools/lib/bpf/btf_dump.c  |  8 ++++----
>  tools/lib/bpf/libbpf.c    |  4 ++--
>  tools/lib/bpf/linker.c    | 12 ++++++------
>  tools/lib/bpf/relo_core.c |  2 +-
>  5 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index ef924fc2c911..0c628c33e23b 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -538,9 +538,9 @@ int btf__set_pointer_size(struct btf *btf, size_t ptr_sz)
>  
>  static bool is_host_big_endian(void)
>  {
> -#if __BYTE_ORDER == __LITTLE_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>  	return false;
> -#elif __BYTE_ORDER == __BIG_ENDIAN
> +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>  	return true;
>  #else
>  # error "Unrecognized __BYTE_ORDER__"
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 8e05ab44c22a..17db62b5002e 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1576,11 +1576,11 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
>  	/* Bitfield value retrieval is done in two steps; first relevant bytes are
>  	 * stored in num, then we left/right shift num to eliminate irrelevant bits.
>  	 */
> -#if __BYTE_ORDER == __LITTLE_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>  	for (i = t->size - 1; i >= 0; i--)
>  		num = num * 256 + bytes[i];
>  	nr_copy_bits = bit_sz + bits_offset;
> -#elif __BYTE_ORDER == __BIG_ENDIAN
> +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>  	for (i = 0; i < t->size; i++)
>  		num = num * 256 + bytes[i];
>  	nr_copy_bits = t->size * 8 - bits_offset;
> @@ -1700,10 +1700,10 @@ static int btf_dump_int_data(struct btf_dump *d,
>  		/* avoid use of __int128 as some 32-bit platforms do not
>  		 * support it.
>  		 */
> -#if __BYTE_ORDER == __LITTLE_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>  		lsi = ints[0];
>  		msi = ints[1];
> -#elif __BYTE_ORDER == __BIG_ENDIAN
> +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>  		lsi = ints[1];
>  		msi = ints[0];
>  #else
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 604abe00785f..cd6132c5a416 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1299,10 +1299,10 @@ static int bpf_object__elf_init(struct bpf_object *obj)
>  
>  static int bpf_object__check_endianness(struct bpf_object *obj)
>  {
> -#if __BYTE_ORDER == __LITTLE_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>  	if (obj->efile.ehdr->e_ident[EI_DATA] == ELFDATA2LSB)
>  		return 0;
> -#elif __BYTE_ORDER == __BIG_ENDIAN
> +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>  	if (obj->efile.ehdr->e_ident[EI_DATA] == ELFDATA2MSB)
>  		return 0;
>  #else
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 7bf658fbda80..ce0800e61dc7 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -323,12 +323,12 @@ static int init_output_elf(struct bpf_linker *linker, const char *file)
>  
>  	linker->elf_hdr->e_machine = EM_BPF;
>  	linker->elf_hdr->e_type = ET_REL;
> -#if __BYTE_ORDER == __LITTLE_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>  	linker->elf_hdr->e_ident[EI_DATA] = ELFDATA2LSB;
> -#elif __BYTE_ORDER == __BIG_ENDIAN
> +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>  	linker->elf_hdr->e_ident[EI_DATA] = ELFDATA2MSB;
>  #else
> -#error "Unknown __BYTE_ORDER"
> +#error "Unknown __BYTE_ORDER__"
>  #endif
>  
>  	/* STRTAB */
> @@ -538,12 +538,12 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
>  				const struct bpf_linker_file_opts *opts,
>  				struct src_obj *obj)
>  {
> -#if __BYTE_ORDER == __LITTLE_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>  	const int host_endianness = ELFDATA2LSB;
> -#elif __BYTE_ORDER == __BIG_ENDIAN
> +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>  	const int host_endianness = ELFDATA2MSB;
>  #else
> -#error "Unknown __BYTE_ORDER"
> +#error "Unknown __BYTE_ORDER__"
>  #endif
>  	int err = 0;
>  	Elf_Scn *scn;
> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 4016ed492d0c..b5b8956a1be8 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -662,7 +662,7 @@ static int bpf_core_calc_field_relo(const char *prog_name,
>  			*validate = true; /* signedness is never ambiguous */
>  		break;
>  	case BPF_FIELD_LSHIFT_U64:
> -#if __BYTE_ORDER == __LITTLE_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>  		*val = 64 - (bit_off + bit_sz - byte_off  * 8);
>  #else
>  		*val = (8 - byte_sz) * 8 + (bit_off - byte_off * 8);
> -- 
> 2.31.1

-- 

- Arnaldo
