Return-Path: <bpf+bounces-20967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C03845E15
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 18:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B9C1F236EF
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA8F608F3;
	Thu,  1 Feb 2024 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="J1xyrncV"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B71608E6
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807079; cv=none; b=C/Dwbh5HtXNo6/xqk0mR22mNCoA0fuWtmhV6/rAlbwcH+eclOnfMht811jW+fJT6sK2BM1Hf6BbPP5XvgBB4/zSBg7iQQ5FFAlQY5lp5+uLav4+u36xeIhnjmI/ll3Wm5ESIsUWH9oCFN9ym66of4+i/g72wsFf6bv5wSsGwtF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807079; c=relaxed/simple;
	bh=/EMH7qDHVxiWzQPsomW63HIBIdXiG/EARNme5SWCkeQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hCMNA1ZaM0UmoQk30kv1TiDISJTWb3lf6Y9yZ5up/88FrKHMM1q6foy4HpbgcXDPZC+uOrC8gbjJ5+eHPWLMzjYwYrkyoXyHnl+0gIAQ+3O6X7mw8sCsERPIu4ic8OSm/NzCze3CHXwKKLBzoYPAsPm6Fe66xfABzyj5NNaZeoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=J1xyrncV; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=WijHL+Kqd1CRKpWFhwz44pVlrksHITclUtXLGvTQ3Ck=; b=J1xyrncVu8aQ+cdUZ+BnbAy1Ie
	r76BkauMAmVOArtkPrttX3XT2zOPzDHwWn7zONbWh/DsWlwLZEhDtUztmeJFTPiPs6QanZ744/Hk8
	MbQZdJYIzivSQRxNjOkTkQaoVuSILLkz76SBZfbaQW6zWVf319tIY8CBgtZv6HsHMBZlASSI8lz7X
	PrvVvVrZREyGIYS+qSx4hDWM7wI4jo3skH+rdKGr5EhQOGFujsJ5l323IG2bDpWkl7mPNpRsdYr8G
	243mpoOjDlbKoIKXTAa+/5hM6mJ6l/Gu0ULxBNO8928Soxo0+TKoABImFbHEqO12G52fSM/SWQdqI
	y+nbtMzw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rVa3V-000OPh-Vs; Thu, 01 Feb 2024 17:36:50 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rVa3V-000BAD-2e; Thu, 01 Feb 2024 17:36:49 +0100
Subject: Re: [PATCH bpf-next v2 2/2] tools/resolve_btfids: fix
 cross-compilation to non-host endianness
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <cover.1706717857.git.vmalik@redhat.com>
 <64f6372c75a44d5c8d00db5c5b7ca21aa3b8bd77.1706717857.git.vmalik@redhat.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a9b408bf-4b4b-b0ce-1f2f-193c0fcfd3ff@iogearbox.net>
Date: Thu, 1 Feb 2024 17:36:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <64f6372c75a44d5c8d00db5c5b7ca21aa3b8bd77.1706717857.git.vmalik@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27172/Thu Feb  1 10:40:50 2024)

On 1/31/24 5:24 PM, Viktor Malik wrote:
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
>      $ sudo ./test_verifier 502 502
>      #502/p sleepable fentry accept FAIL
>      Failed to load prog 'Invalid argument'!
>      bpf_fentry_test1 is not sleepable
>      verification time 34 usec
>      stack depth 0
>      processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>      Summary: 0 PASSED, 0 SKIPPED, 1 FAILED
> 
> Since it's not possible to instruct libelf to translate just certain
> values, let's manually bswap the flags in resolve_btfids when needed, so
> that libelf then translates everything correctly.
> 
> Fixes: ef2c6f370a63 ("tools/resolve_btfids: Add support for 8-byte BTF sets")
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>   tools/bpf/resolve_btfids/main.c | 27 ++++++++++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 7badf1557e5c..d01603ef6283 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -652,13 +652,23 @@ static int sets_patch(struct object *obj)
>   	Elf_Data *data = obj->efile.idlist;
>   	int *ptr = data->d_buf;
>   	struct rb_node *next;
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
>   	next = rb_first(&obj->sets);
>   	while (next) {
>   		unsigned long addr, idx;
>   		struct btf_id *id;
>   		void *base;
> -		int cnt, size;
> +		int cnt, size, i;
>   
>   		id   = rb_entry(next, struct btf_id, rb_node);
>   		addr = id->addr[0];
> @@ -686,6 +696,21 @@ static int sets_patch(struct object *obj)
>   			base = set8->pairs;
>   			cnt = set8->cnt;
>   			size = sizeof(set8->pairs[0]);
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
> +			}
>   		}
>   

Could we improve that somewhat, e.g. gathering endianness could be moved into
elf_collect() and the test could also be simplified (if I'm not missing sth) ?

Like the below (not even compile-tested ...) :

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 7badf1557e5c..7b5f592fe79c 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -90,6 +90,14 @@

  #define ADDR_CNT	100

+#if __BYTE_ORDER == __LITTLE_ENDIAN
+# define ELFDATANATIVE	ELFDATA2LSB
+#elif __BYTE_ORDER == __BIG_ENDIAN
+# define ELFDATANATIVE	ELFDATA2MSB
+#else
+# error "Unknown machine endianness!"
+#endif
+
  struct btf_id {
  	struct rb_node	 rb_node;
  	char		*name;
@@ -117,6 +125,7 @@ struct object {
  		int		 idlist_shndx;
  		size_t		 strtabidx;
  		unsigned long	 idlist_addr;
+		int		 encoding;
  	} efile;

  	struct rb_root	sets;
@@ -320,6 +329,7 @@ static int elf_collect(struct object *obj)
  {
  	Elf_Scn *scn = NULL;
  	size_t shdrstrndx;
+	GElf_Ehdr ehdr;
  	int idx = 0;
  	Elf *elf;
  	int fd;
@@ -351,6 +361,13 @@ static int elf_collect(struct object *obj)
  		return -1;
  	}

+	if (gelf_getehdr(obj->efile.elf, &ehdr) == NULL) {
+		pr_err("FAILED cannot get ELF header: %s\n", elf_errmsg(-1));
+		return -1;
+	}
+
+	obj->efile.encoding = ehdr.e_ident[EI_DATA];
+
  	/*
  	 * Scan all the elf sections and look for save data
  	 * from .BTF_ids section and symbols.
@@ -649,6 +666,7 @@ static int cmp_id(const void *pa, const void *pb)

  static int sets_patch(struct object *obj)
  {
+	bool need_bswap = obj->efile.encoding != ELFDATANATIVE;
  	Elf_Data *data = obj->efile.idlist;
  	int *ptr = data->d_buf;
  	struct rb_node *next;
@@ -658,7 +676,7 @@ static int sets_patch(struct object *obj)
  		unsigned long addr, idx;
  		struct btf_id *id;
  		void *base;
-		int cnt, size;
+		int cnt, size, i;

  		id   = rb_entry(next, struct btf_id, rb_node);
  		addr = id->addr[0];
@@ -686,6 +704,21 @@ static int sets_patch(struct object *obj)
  			base = set8->pairs;
  			cnt = set8->cnt;
  			size = sizeof(set8->pairs[0]);
+
+			/*
+			 * When ELF endianness does not match endianness of the
+			 * host, libelf will do the translation when updating
+			 * the ELF. This, however, corrupts SET8 flags which are
+			 * already in the target endianness. So, let's bswap
+			 * them to the host endianness and libelf will then
+			 * correctly translate everything.
+			 */
+			if (need_bswap) {
+				for (i = 0; i < cnt; i++) {
+					set8->pairs[i].flags =
+						bswap_32(set8->pairs[i].flags);
+				}
+			}
  		}

  		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
-- 
2.21.0


