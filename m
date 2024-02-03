Return-Path: <bpf+bounces-21125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D54847E3D
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 02:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34213B286B9
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 01:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FAE2F25;
	Sat,  3 Feb 2024 01:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="IIAoIPoH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JSnmRurV"
X-Original-To: bpf@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BDE1FB4
	for <bpf@vger.kernel.org>; Sat,  3 Feb 2024 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706924304; cv=none; b=ebjvfYLtLx+7W7CQVyRhjAbrcMU2WOhkM/hXF97g5YCAY8fape0t9hPYylxHY+zq5g5VwBExt84BLI4S7nsw1eWxoWe/IoswEEZtN3QFwvzKWBHqcNKSWUGO9dNR2EGBb4PDZ+FhkgQ0euQYOAdqIeZGMxyEIs19dOlZ0IByowI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706924304; c=relaxed/simple;
	bh=SB0PTpPm5qGRsE8fRaUwr8p1ijAY3Bt5vwr7lWrdq+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mim0WjPJuwMaGFDFx0QTKwdmZP3W7KH7XCNeVkeYXIX60fL3IQzSVEx5TOuBhGdODPgqze4qzYrl429NHvqRTe+kD1tSkKVk4cfDDafMyK1dIsBwYmCZOUas0FEPhenlOxnxGz1kvo9WYPSwQgX6nyLS1Ji1Z7XSMFNnKFr5pSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=IIAoIPoH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JSnmRurV; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 496115C008D;
	Fri,  2 Feb 2024 20:38:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 02 Feb 2024 20:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706924301; x=1707010701; bh=QtFKsckm1W
	La560vNHrS203d/p13q5i0Q8Z5ZM/l6UQ=; b=IIAoIPoHuPJ1CjFvcgIGUMCPiW
	qmQQlvl2Fx3qegrVx2+VKpLNkJo98OFniOCWi2UKD5DrpSQB/acA9lGyWZ14odIa
	9fKtVUvh+y25bNw9XLYhWAns7m8BWZhLg2TdHWWq6HWf+dnX95Q2d/sX0Cdh6tyB
	htqx2g50unoB1Lf1Agl+XFYsp56GJYHHlRb1CEisXJgXyHg8uzpZEYzfB1qry6pO
	pCfvp8gtDtZtkBBAq0dGH/VbizsG7Chc2bU3U2E602ilCeyExgUu1zqtLBWoiMQ5
	zu/bBbjAieA5ghk8LjCAAZpjNT4uUWdwvVXm/ToqqKU/4ppr/8d6rB5O0OJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706924301; x=1707010701; bh=QtFKsckm1WLa560vNHrS203d/p13
	q5i0Q8Z5ZM/l6UQ=; b=JSnmRurV+oAYZETptbJ3+RMxoCqoMV+QHus00FwdvKzU
	EJk5ChsYQvmbcC3lIx0RyElT1rtZFzuP54yK+UF8bVm62Vef9CbHd13C17dzYYc1
	2Mf6FrkbVS+JbqQG+5ktfFv2lXte9haRCOezMsD4XU1C32AHnkDuQPC5cMJqw3NR
	qQ/VY0HtIRyJGShxps15y9L/JHxwNobY7WYJkFdh7bixMbjCQafGM5j8bEIe0bZD
	8SiUNDvw2nFl6gW77cujy/PYoNPhqZhfvlkQVg4xKW0yb9LFSbbO+3Qi158W94Th
	qNzwbQwZ5LPKORn8hW64abP9qZxPNiGDxXadb7nlew==
X-ME-Sender: <xms:DJm9ZfykXO14DJ8irPDKM882p-4XZklgclB6uzfEEY68O6QKSxH85Q>
    <xme:DJm9ZXTD8jQiR-w8QikiN4oFQO25q79YVjawOkqmZHmDnHeOOvIuy9w-SJf5DMaEB
    QsUdMa84dO4Gouecw>
X-ME-Received: <xmr:DJm9ZZXIR2UUztqowvSSqU65HcQHwS0z6r_i3DWbUEJ0nX7EGaeH-zDdAHrKTGMxmkNruHl-YDaeLLMTfRFCSe8DJW4-Q91lbvelgnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduhedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:DZm9ZZixBQIbc87p9iK__BZCjvWnQOopi5ItVwz-ytOK7QEl5zZMCg>
    <xmx:DZm9ZRDyXr5je_W2g0iXErY-MJn2Vyp_sYlR5fRvuvze4jcp3WvXAQ>
    <xmx:DZm9ZSINjuPTt-0SoKa4ciu8CZslmsIqozC4AQ6NA6UJJucN0J5msg>
    <xmx:DZm9ZbTEjxFFpoWQ0FjfLLBhlhKpvjZWO3cOXUUdMbcSbl-2cVu_Mg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 20:38:19 -0500 (EST)
Date: Fri, 2 Feb 2024 18:38:18 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] tools/resolve_btfids: fix
 cross-compilation to non-host endianness
Message-ID: <vjbvcxsbtz7mrwevvcb3i4sf7hv5ah6iyjyzg7awr4iuiimryv@wjkglqsk6wee>
References: <cover.1706717857.git.vmalik@redhat.com>
 <64f6372c75a44d5c8d00db5c5b7ca21aa3b8bd77.1706717857.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64f6372c75a44d5c8d00db5c5b7ca21aa3b8bd77.1706717857.git.vmalik@redhat.com>

Hi Viktor,

On Wed, Jan 31, 2024 at 05:24:09PM +0100, Viktor Malik wrote:
> The .BTF_ids section is pre-filled with zeroed BTF ID entries during the
> build and afterwards patched by resolve_btfids with correct values.
> Since resolve_btfids always writes in host-native endianness, it relies
> on libelf to do the translation when the target ELF is cross-compiled to
> a different endianness (this was introduced in commit 61e8aeda9398
> ("bpf: Fix libelf endian handling in resolv_btfids")).
> 
> Unfortunately, the translation will corrupt the flags fields of SET8
> entries because these were written during vmlinux compilation and are in
> the correct endianness already. This will lead to numerous selftests
> failures such as:
> 
>     $ sudo ./test_verifier 502 502
>     #502/p sleepable fentry accept FAIL
>     Failed to load prog 'Invalid argument'!
>     bpf_fentry_test1 is not sleepable
>     verification time 34 usec
>     stack depth 0
>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>     Summary: 0 PASSED, 0 SKIPPED, 1 FAILED
> 
> Since it's not possible to instruct libelf to translate just certain
> values, let's manually bswap the flags in resolve_btfids when needed, so
> that libelf then translates everything correctly.
> 
> Fixes: ef2c6f370a63 ("tools/resolve_btfids: Add support for 8-byte BTF sets")
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  tools/bpf/resolve_btfids/main.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 7badf1557e5c..d01603ef6283 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -652,13 +652,23 @@ static int sets_patch(struct object *obj)
>  	Elf_Data *data = obj->efile.idlist;
>  	int *ptr = data->d_buf;
>  	struct rb_node *next;
> +	GElf_Ehdr ehdr;
> +	int need_bswap;
> +
> +	if (gelf_getehdr(obj->efile.elf, &ehdr) == NULL) {
> +		pr_err("FAILED cannot get ELF header: %s\n",
> +			elf_errmsg(-1));
> +		return -1;
> +	}
> +	need_bswap = (__BYTE_ORDER == __LITTLE_ENDIAN) !=
> +		     (ehdr.e_ident[EI_DATA] == ELFDATA2LSB);
>  
>  	next = rb_first(&obj->sets);
>  	while (next) {
>  		unsigned long addr, idx;
>  		struct btf_id *id;
>  		void *base;
> -		int cnt, size;
> +		int cnt, size, i;
>  
>  		id   = rb_entry(next, struct btf_id, rb_node);
>  		addr = id->addr[0];
> @@ -686,6 +696,21 @@ static int sets_patch(struct object *obj)
>  			base = set8->pairs;
>  			cnt = set8->cnt;
>  			size = sizeof(set8->pairs[0]);
> +
> +			/*
> +			 * When ELF endianness does not match endianness of the
> +			 * host, libelf will do the translation when updating
> +			 * the ELF. This, however, corrupts SET8 flags which are
> +			 * already in the target endianness. So, let's bswap
> +			 * them to the host endianness and libelf will then
> +			 * correctly translate everything.
> +			 */
> +			if (need_bswap) {
> +				for (i = 0; i < cnt; i++) {
> +					set8->pairs[i].flags =
> +						bswap_32(set8->pairs[i].flags);
> +				}

Do we need this for btf_id_set8:flags as well? Didn't get a chance to
look too deeply yet.

Thanks,
Daniel

