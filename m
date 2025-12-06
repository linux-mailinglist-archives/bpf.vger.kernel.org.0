Return-Path: <bpf+bounces-76207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4D7CA9DC1
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 02:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 161833028DBB
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 01:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455BB1A0B15;
	Sat,  6 Dec 2025 01:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pu9Dr7ue"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044213B8D49
	for <bpf@vger.kernel.org>; Sat,  6 Dec 2025 01:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764985059; cv=none; b=sYtcjFgMRRg/6MJSWOmQrpsLTKHmQROFRfPUV/4MmscbdIy9J+5u3wg3cINy0/pDk9mZxbrdCniDrZhpGm40OuZtWHFxjXS8P++V6sd012BLtLP7ah6pXyyLIbV6VoC4A569i6s9mJAOOE0/z7lxUpS9Xf2hZE2a3jI35MlV/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764985059; c=relaxed/simple;
	bh=INv2EcaxDc6nCobVlehf7iUd62kSXSOVQYEmh5Pe0aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bC2cvI1AP5YaYO+Bfs8z+yo8kXQ3ExYHOztXQuQImjAPjLy5Nst1zkwNqThWEOStURcQL7dGuxjwav5A9vFIfR2aOefm1h0C3kpTeoJdi1RLcu0iL4FVERtwdr04RrxwgYKFtLOVbpClfL5dPrku/sUbi2tOhqTtDhH70p4ltbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pu9Dr7ue; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1957a60b-6c45-42a7-b525-a6e335a735ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764985054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqK9z/eySTwed+qE+80JGNFbJ1Vl2gTvkm6WoaXvR9c=;
	b=Pu9Dr7uejHlf3nQuxNZbcYOFE63b7Xfxh9DfydQMefx+BZJM32ckYSDq2arWpcDBD02HkT
	petS+VzbcIstkZiKJlJYjZx3LAKAMApz8uy2UZwCB400IJ1eRvFKstNr4jh48ZB+fR+5ay
	Ri50wQ5RYeEpfPdfutt+NOrGcc+vSv4=
Date: Fri, 5 Dec 2025 17:37:20 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 6/6] resolve_btfids: change in-place update
 with raw binary output
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Shuah Khan <shuah@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Donglin Peng
 <dolinux.peng@gmail.com>, bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20251205223046.4155870-6-ihor.solodrai@linux.dev>
 <20251205223554.4159772-1-ihor.solodrai@linux.dev>
 <CAEf4BzYz9jBG7njY4Vsu53aspzfp+1B++SdY5zYya0Sq_PEP8w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzYz9jBG7njY4Vsu53aspzfp+1B++SdY5zYya0Sq_PEP8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/5/25 5:13 PM, Andrii Nakryiko wrote:
> On Fri, Dec 5, 2025 at 2:36 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> [...]
>>
> 
> Overall it looks good, but I'd like another pair of eyes on this :)

I don't think you need to worry about another pair of eyes :)

> See some more minore nits below as well.
> 
> pw-bot: cr
> 
> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e36689cd7cc7..fe6141c69708 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4673,6 +4673,7 @@ F:        net/sched/act_bpf.c
>>  F:     net/sched/cls_bpf.c
>>  F:     samples/bpf/
>>  F:     scripts/bpf_doc.py
>> +F:     scripts/gen-btf.sh
>>  F:     scripts/Makefile.btf
>>  F:     scripts/pahole-version.sh
>>  F:     tools/bpf/
>> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>> index 7c1cd6c2ff75..d067e91049cb 100644
>> --- a/scripts/Makefile.btf
>> +++ b/scripts/Makefile.btf
>> @@ -1,5 +1,10 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>
>> +gen-btf-y                              =
>> +gen-btf-$(CONFIG_DEBUG_INFO_BTF)       = $(srctree)/scripts/gen-btf.sh
>> +
>> +export GEN_BTF := $(gen-btf-y)
>> +
> 
> What's the point of GEN_BTF? It's just so that you don't have to have
> $(srctree)/scripts/gen-btf.sh specified in three places? Between
> obscure $(GEN_BTF) (and having to understand where it is set and how
> it's exported) and explicit $(srctree)/scripts/gen-btf.sh in a few
> places, I'd prefer the latter, as it is way more greppable and it's
> not like we are going to rename or move this script frequently

Yeah... It seems fine for me either way, tbh.

I think a slight difference is that in link-vmlinux.sh checking for a
config value is a grep on include/config/auto.conf, which is not
necessary if we have a dedicated env variable.

> 
> 
>>  pahole-ver := $(CONFIG_PAHOLE_VERSION)
>>  pahole-flags-y :=
>>
> 
> [...]
> 
>> @@ -371,7 +348,7 @@ static int elf_collect(struct object *obj)
>>
>>         elf_version(EV_CURRENT);
>>
>> -       elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
>> +       elf = elf_begin(fd, ELF_C_READ_MMAP_PRIVATE, NULL);
>>         if (!elf) {
>>                 close(fd);
>>                 pr_err("FAILED cannot create ELF descriptor: %s\n",
>> @@ -434,21 +411,20 @@ static int elf_collect(struct object *obj)
>>                         obj->efile.symbols_shndx = idx;
>>                         obj->efile.strtabidx     = sh.sh_link;
>>                 } else if (!strcmp(name, BTF_IDS_SECTION)) {
>> +                       /*
>> +                        * If target endianness differs from host, we need to bswap32
>> +                        * the .BTF_ids section data on load, because .BTF_ids has
>> +                        * Elf_Type = ELF_T_BYTE, and so libelf returns data buffer in
>> +                        * the target endiannes. We repeat this on dump.
> 
> gmail screams at me for "endianness"

That's how you know I am not AI.

> 
>> +                        */
>> +                       if (obj->efile.encoding != ELFDATANATIVE) {
>> +                               pr_debug("bswap_32 .BTF_ids data from target to host endianness\n");
>> +                               bswap_32_data(data->d_buf, data->d_size);
> 
> this looks like a violation of ELF_C_READ_MMAP_PRIVATE promise, no?...
> would it be too create a copy here? for simplicity we can just always
> malloc() a copy, regardless of bswap(), it can never be a huge amount
> of data

No, it's not a violation. From libelf.h:

  ELF_C_READ_MMAP_PRIVATE,	/* Read, but memory is writable, results are
				   not written to the file.  */

I haven't checked how it works under the hood, but from testing so far
the comment seems to be telling the truth.


> 
>> +                       }
>>                         obj->efile.idlist       = data;
>>                         obj->efile.idlist_shndx = idx;
>>                         obj->efile.idlist_addr  = sh.sh_addr;
>> -               } else if (!strcmp(name, BTF_BASE_ELF_SEC)) {
>> -                       /* If a .BTF.base section is found, do not resolve
>> -                        * BTF ids relative to vmlinux; resolve relative
>> -                        * to the .BTF.base section instead.  btf__parse_split()
>> -                        * will take care of this once the base BTF it is
>> -                        * passed is NULL.
>> -                        */
>> -                       obj->base_btf_path = NULL;
>>                 }
>> -
>> -               if (compressed_section_fix(elf, scn, &sh))
>> -                       return -1;
>>         }
>>
>>         return 0;
>> @@ -552,6 +528,13 @@ static int symbols_collect(struct object *obj)
>>         return 0;
>>  }
>>
>> +static inline bool is_envvar_set(const char *var_name)
>> +{
>> +       const char *value = getenv(var_name);
>> +
>> +       return value && value[0] != '\0';
>> +}
>> +
> 
> leftovers?

Yes. I think I should add "fail build on warnings" for resolve_btfids.

> 
>>  static int load_btf(struct object *obj)
>>  {
>>         struct btf *base_btf = NULL, *btf = NULL;
>> @@ -578,6 +561,19 @@ static int load_btf(struct object *obj)
>>         obj->base_btf = base_btf;
>>         obj->btf = btf;
>>
>> +       if (obj->base_btf && obj->distill_base) {
>> +               err = btf__distill_base(obj->btf, &base_btf, &btf);
>> +               if (err) {
>> +                       pr_err("FAILED to distill base BTF: %s\n", strerror(errno));
>> +                       goto out_err;
>> +               }
>> +
>> +               btf__free(obj->btf);
>> +               btf__free(obj->base_btf);
>> +               obj->btf = btf;
>> +               obj->base_btf = base_btf;
>> +       }
>> +
>>         return 0;
>>
>>  out_err:
> 
> [...]
> 
>> +static int dump_raw_btf_ids(struct object *obj, const char *out_path)
>> +{
>> +       Elf_Data *data = obj->efile.idlist;
>> +       int fd, err;
>> +
>> +       if (!data || !data->d_buf) {
>> +               pr_debug("%s has no BTF_ids data to dump\n", obj->path);
>> +               return 0;
>> +       }
>> +
>> +       /*
>> +        * If target endianness differs from host, we need to bswap32 the
>> +        * .BTF_ids section data before dumping so that the output is in
>> +        * target endianness.
>> +        */
>> +       if (obj->efile.encoding != ELFDATANATIVE) {
>> +               pr_debug("bswap_32 .BTF_ids data from host to target endianness\n");
>> +               bswap_32_data(data->d_buf, data->d_size);
> 
> same about modifying ELF data in-place for what is supposed to be read-only use

See above.

> 
>> +       }
>> +
>> +       err = dump_raw_data(out_path, data->d_buf, data->d_size);
>> +       if (err)
>> +               return -1;
>> +
>> +       return 0;
>> +}
>> +
>> +static int dump_raw_btf(struct btf *btf, const char *out_path)
>> +{
>> +       const void *raw_btf_data;
>> +       u32 raw_btf_size;
>> +       int fd, err;
>> +
>> +       raw_btf_data = btf__raw_data(btf, &raw_btf_size);
>> +       if (!raw_btf_data) {
>> +               pr_err("btf__raw_data() failed\n");
>> +               return -1;
>> +       }
> 
> did you check that libbpf does proper byte swap as well?

libbpf is tracking BTF endianness internally, we don't have to worry
about it here. If it wasn't, s390x selftests would have almost
certainly failed (and they did when I messed up).

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/bpf/btf.c?h=v6.18#n227

> 
>> +
>> +       err = dump_raw_data(out_path, raw_btf_data, raw_btf_size);
>> +       if (err)
>> +               return -1;
>> +
>> +       return 0;
>> +}
>> +
>> +static inline int make_out_path(char *buf, const char *in_path, const char *suffix)
>> +{
>> +       int len = snprintf(buf, PATH_MAX, "%s%s", in_path, suffix);
> 
> nit: normally you pass buffer and its size as input arguments instead
> of assuming and hard-coding common PATH_MAX constant in two separate
> places

acked

> 
>> +
>> +       if (len < 0 || len >= PATH_MAX) {
>> +               pr_err("Output path is too long: %s%s\n", in_path, suffix);
>> +               return -E2BIG;
>>         }
>>
>> -       pr_debug("update %s for %s\n",
>> -                err >= 0 ? "ok" : "failed", obj->path);
>> -       return err < 0 ? -1 : 0;
>> +       return 0;
>>  }
>>
>>  static const char * const resolve_btfids_usage[] = {
> 
> [...]


