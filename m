Return-Path: <bpf+bounces-38611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CCF966B3B
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 23:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D291C21D01
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 21:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0881C0DD2;
	Fri, 30 Aug 2024 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHya6oub"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA0166F0D
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725053027; cv=none; b=qAWSdmGuUyeLNeaojCmlkBkf33V3G2dQ2YhYHTXPm1BFNu3fen/zPIdNBbIxwQvQ5XFF8nMkiF7D2aphBVtfdyJtbzK5knprUa+H6ITH3pVtHiZDKOBjkVxWoOu7h9tiaMpnT5XSS5HMG6EU3bsfIKFS/4uJ4LVPxVLhne0EbEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725053027; c=relaxed/simple;
	bh=sj0iPaAjV7Gx1QoC17GdZPSivD6BB9pyyOJiJduzyew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPMxNOfWpffTRvAA77t/o4pYf9DndS6mnRtZTEn7FXnsKDtC3R/cj5M7mEMLb9An38/7X5Z7+m+PGWI6Vfkzq76YEgSaAJ97YXZ7A7YJuTWaYX99hawuCaqvdDZixEKKJGkFWHrY7BcizKT2XtmWUHuB8dtWRh2Mlh+jddM/dlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHya6oub; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bed68129a7so3095236a12.2
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 14:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725053024; x=1725657824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5gFoCNkxSJi1R6FxplPUZrs/O+IDn6nipGxBihoGq0=;
        b=eHya6oub+9+cC4Z4tUkReI1fK+SbbD401HmGT8i7iBEi5rM15pGLR//vTpo1o9abjp
         Zo9w4EFw1+JjktQrxCwuEv1t9q5KpA5m3saGFc8ml8CloCPDBADxe5igJXQt3xPntjtF
         uxPbFHEmVNsu5LwhANrefIwJW0ifFtEEJX84EFchD/nh5F14npFw/gr1+DfTOkCMynCa
         UqB/WvuvxsPgV80AwyI0OpqL6KJF4CvwGttKsPMNV0K/OF+CKIShHUXcQwUnvtN4XnLq
         rt/6OCS/FFoqCNu2v8jR0LtbsfxkmbV2miBIzS9t0lKov/Qyro/4/SpDJHMRFvhkzmcr
         lZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725053024; x=1725657824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5gFoCNkxSJi1R6FxplPUZrs/O+IDn6nipGxBihoGq0=;
        b=D3T01i6WXsvK5bA+SeyU6ocKHx2Ky1IjP4xdEnhuJgRYLtn99i63LGd93SAiPAB9ZH
         e1Q2GfV/+l5hM3tkkRW5KGUxW4Km9OcObE0piDuQGdbNpKq5+xj/3nw5Q826D4uUD21+
         PKXFVMhOcL19NWejVserLbH1D6ODkIKOrNj8q/N90fl19YVPeWFMUs+cAkYXMY/uJ4cF
         XJ+y6KYcfpZjMPdex8ObVuJZacifUg5CSVtSgfH8v4B+giwvLz+6eDFw08XrzPEJOEpV
         LQUywKkjA9RZ2yHi/+yLc1e92RmHK0mea6QyUVT3zFYZImT++IUKZoI0fe0HXzD/BWuV
         +rkA==
X-Forwarded-Encrypted: i=1; AJvYcCUEVbYSeUf1R5G2B8ifaBuYytF6VdccEirQrlKnuitQmOCIOLURh/YTPGreqXnCMsiGHwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YypuiIkh5eYDjTnmE6Vx+7ng/alvIPemvdbO3PqrmunkP6s1tK1
	HJO+LzCfcplI8QUM6F/z2q+UL4qDol9odsxkcjuwPvRjJALpENCC
X-Google-Smtp-Source: AGHT+IGZNpNh423DMFx2s5lzP3dt8K2482N9XwJpDkkSxXdgwe9nfbkAKqUsexEXohsso7Nwlktqyw==
X-Received: by 2002:a17:907:3ea6:b0:a80:7c30:a82a with SMTP id a640c23a62f3a-a897fb15ab7mr576205666b.69.1725053023026;
        Fri, 30 Aug 2024 14:23:43 -0700 (PDT)
Received: from [192.168.0.20] (walt-20-b2-v4wan-167837-cust573.vm13.cable.virginm.net. [80.2.18.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900f603sm253312566b.74.2024.08.30.14.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 14:23:42 -0700 (PDT)
Message-ID: <45a24817-358d-4d25-ae7c-118539ec2ba7@gmail.com>
Date: Fri, 30 Aug 2024 22:23:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: do not update vmlinux.h
 unnecessarily
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire
 <alan.maguire@oracle.com>, Mykyta Yatsenko <yatsenko@meta.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org,
 andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com
References: <20240828174608.377204-1-ihor.solodrai@pm.me>
 <20240828174608.377204-2-ihor.solodrai@pm.me>
 <b48f348c76dd5b724384aef7c7c067877b28ee5b.camel@gmail.com>
 <CAEf4BzaBMhb4a2Y-2_mcLmYjJ2UWQuwNF-2sPVJXo39+0ziqzw@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzaBMhb4a2Y-2_mcLmYjJ2UWQuwNF-2sPVJXo39+0ziqzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/08/2024 21:34, Andrii Nakryiko wrote:
> On Wed, Aug 28, 2024 at 3:02 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>> On Wed, 2024-08-28 at 17:46 +0000, Ihor Solodrai wrote:
>>> %.bpf.o objects depend on vmlinux.h, which makes them transitively
>>> dependent on unnecessary libbpf headers. However vmlinux.h doesn't
>>> actually change as often.
>>>
>>> When generating vmlinux.h, compare it to a previous version and update
>>> it only if there are changes.
>>>
>>> Example of build time improvement (after first clean build):
>>>    $ touch ../../../lib/bpf/bpf.h
>>>    $ time make -j8
>>> Before: real  1m37.592s
>>> After:  real  0m27.310s
>>>
>>> Notice that %.bpf.o gen step is skipped if vmlinux.h hasn't changed.
>>>
>>> Link: https://lore.kernel.org/bpf/CAEf4BzY1z5cC7BKye8=A8aTVxpsCzD=p1jdTfKC7i0XVuYoHUQ@mail.gmail.com
>>>
>>> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
>>> ---
>> Unfortunately, I think that this is a half-measure.
>> E.g. the following command forces tests rebuild for me:
>>
>>    touch ../../../../kernel/bpf/verifier.c; \
>>    make -j22 -C ../../../../; \
>>    time make test_progs
>>
>> To workaround this we need to enable reproducible_build option:
>>
>>      diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>>      index b75f09f3f424..8cd648f3e32b 100644
>>      --- a/scripts/Makefile.btf
>>      +++ b/scripts/Makefile.btf
>>      @@ -19,7 +19,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)      += --skip_encoding_btf_inconsis
>>       else
>>
>>       # Switch to using --btf_features for v1.26 and later.
>>      -pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
>>      +pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs,reproducible_build
>>
>>       ifneq ($(KBUILD_EXTMOD),)
>>       module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
>>
>> Question to the mailing list: do we want this?
> Alan, can you please give us a summary of what are the consequences of
> the reproducible_build pahole option? In terms of performance and
> otherwise.
>
> I've applied patches as is, despite them not solving the issue
> completely, as they are moving us in the right direction anyways. I do
> get slightly different BTF every single time I rebuild my kernel, so
> the change in patch #2 doesn't yet help me.
>
> For libbpf headers, Ihor, can you please follow up with adding
> bpf_helper_defs.h as a dependency?
>
> I have some ideas on how to make BTF regeneration in vmlinux.h itself
> unnecessary, that might help with this issue. Separately (depending on
> what are the negatives of the reproducible_build option) we can look
> into making pahole have more consistent internal BTF type ordering
> without negatively affecting the overall BTF dedup performance in
> pahole. Hopefully I can work with Ihor on this as follow ups.
>
> P.S. I also spent more time than I'm willing to admit trying to
> improve bpftool's BTF sorting to minimize the chance of vmlinux.h
> contents being different, and I think I removed a bunch of cases where
> we had unnecessary differences, but still, it's fundamentally
> non-deterministic to do everything based on type and field names,
> unfortunately.
>
> Anyways, Mykyta (cc'ed), what do you think about the changes below?
> Note that I'm also fixing the incorrect handling of enum64 (would be
> nice to prepare a proper patch and send it upstream, if you get a
> chance).
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 6789c7a4d5ca..e8a244b09d56 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -50,6 +50,7 @@ struct sort_datum {
>          int type_rank;
>          const char *sort_name;
>          const char *own_name;
> +       __u64 disambig_hash;
>   };
>
>   static const char *btf_int_enc_str(__u8 encoding)
> @@ -552,35 +553,92 @@ static int btf_type_rank(const struct btf *btf,
> __u32 index, bool has_name)
>          }
>   }
>
> -static const char *btf_type_sort_name(const struct btf *btf, __u32
> index, bool from_ref)
> +static const char *btf_type_sort_name(const struct btf *btf, __u32
> index, bool from_ref, const char *typedef_name)
>   {
>          const struct btf_type *t = btf__type_by_id(btf, index);
> +       int name_off;
>
>          switch (btf_kind(t)) {
>          case BTF_KIND_ENUM:
> -       case BTF_KIND_ENUM64: {
> -               int name_off = t->name_off;
> -
>                  /* Use name of the first element for anonymous enums
> if allowed */
>                  if (!from_ref && !t->name_off && btf_vlen(t))
>                          name_off = btf_enum(t)->name_off;
> +               else
> +                       name_off = t->name_off;
> +
> +               return btf__name_by_offset(btf, name_off);
> +       case BTF_KIND_ENUM64:
> +               /* Use name of the first element for anonymous enums
> if allowed */
> +               if (!from_ref && !t->name_off && btf_vlen(t))
> +                       name_off = btf_enum64(t)->name_off;
> +               else
> +                       name_off = t->name_off;
>
>                  return btf__name_by_offset(btf, name_off);
> -       }
>          case BTF_KIND_ARRAY:
> -               return btf_type_sort_name(btf, btf_array(t)->type, true);
> +               return btf_type_sort_name(btf, btf_array(t)->type,
> true, typedef_name);
> +       case BTF_KIND_STRUCT:
> +       case BTF_KIND_UNION:
> +               if (t->name_off == 0)
> +                       return typedef_name;
> +               return btf__name_by_offset(btf, t->name_off);
> +       case BTF_KIND_TYPEDEF:
> +               return btf_type_sort_name(btf, t->type, true,
> +                                         btf__name_by_offset(btf,
> t->name_off));
>          case BTF_KIND_TYPE_TAG:
>          case BTF_KIND_CONST:
>          case BTF_KIND_PTR:
>          case BTF_KIND_VOLATILE:
>          case BTF_KIND_RESTRICT:
> -       case BTF_KIND_TYPEDEF:
>          case BTF_KIND_DECL_TAG:
> -               return btf_type_sort_name(btf, t->type, true);
> +               return btf_type_sort_name(btf, t->type, true, typedef_name);
>          default:
>                  return btf__name_by_offset(btf, t->name_off);
>          }
> -       return NULL;
> +}
> +
> +static __u64 hasher(__u64 hash, __u64 val)
> +{
> +       return hash * 31 + val;
> +}
> +
> +static __u64 btf_type_disambig_hash(const struct btf *btf, __u32 index)
> +{
> +       const struct btf_type *t = btf__type_by_id(btf, index);
> +       int i;
> +       size_t hash = 0;
> +
> +       switch (btf_kind(t)) {
> +       case BTF_KIND_ENUM:
> +               hash = hasher(hash, t->size);
> +               for (i = 0; i < btf_vlen(t); i++)
> +                       hash = hasher(hash, btf_enum(t)[i].name_off);
> +               break;
> +       case BTF_KIND_ENUM64:
> +               hash = hasher(hash, t->size);
> +               for (i = 0; i < btf_vlen(t); i++)
> +                       hash = hasher(hash, btf_enum64(t)[i].name_off);
> +               break;
> +       case BTF_KIND_STRUCT:
> +       case BTF_KIND_UNION: {
> +               const struct btf_member *m;
> +               const char *ftname;
> +
> +               hash = hasher(hash, t->size);
> +               for (i = 0; i < btf_vlen(t); i++) {
> +                       m = btf_members(t) + i;
> +                       hash = hasher(hash, m->name_off);
> +
> +                       /* resolve field type's name and hash it as well */
> +                       ftname = btf_type_sort_name(btf, m->type, false, "");
> +                       hash = hasher(hash, str_hash(ftname));
> +               }
> +               break;
> +       }
> +       default:
> +               break;
> +       }
> +       return hash;
>   }
>
>   static int btf_type_compare(const void *left, const void *right)
> @@ -596,7 +654,14 @@ static int btf_type_compare(const void *left,
> const void *right)
>          if (r)
>                  return r;
>
> -       return strcmp(d1->own_name, d2->own_name);
> +       r = strcmp(d1->own_name, d2->own_name);
> +       if (r)
> +               return r;
> +
> +       if (d1->disambig_hash != d2->disambig_hash)
> +               return d1->disambig_hash < d2->disambig_hash ? -1 : 1;
> +
> +       return d1->index < d2->index ? -1 : 1;
>   }
>
>   static struct sort_datum *sort_btf_c(const struct btf *btf)
> @@ -615,8 +680,9 @@ static struct sort_datum *sort_btf_c(const struct btf *btf)
>
>                  d->index = i;
>                  d->type_rank = btf_type_rank(btf, i, false);
> -               d->sort_name = btf_type_sort_name(btf, i, false);
> +               d->sort_name = btf_type_sort_name(btf, i, false, "");
>                  d->own_name = btf__name_by_offset(btf, t->name_off);
> +               d->disambig_hash = btf_type_disambig_hash(btf, i);
>          }
>
>          qsort(datums, n, sizeof(struct sort_datum), btf_type_compare);
>
Thanks for pointing to the bug of enum64 handling. I'll create a patch.
Reading the rest of the code, hashing struct/union/enum fields is 
introduced:
this is only useful for disambiguating ordering of the anonymous 
structs/unions/enums.

I suspect the biggest source of the issues are structs and unions, though.
Are definitions like this create problems?
typedef struct {...} foo_t;
?
I'll check what other differences this change makes.
>> [...]
>>


