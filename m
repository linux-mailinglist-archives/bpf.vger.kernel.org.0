Return-Path: <bpf+bounces-54873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C25A750B4
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 20:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67CF3B61B4
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 19:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4041D61B7;
	Fri, 28 Mar 2025 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gg6YPvBl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCFC2BB15
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743189375; cv=none; b=rUogzGhiUhzJ6TnqFa7hab7OqmK6bpToBdcVXzwq8AMhQzeX83w8jt7efBBWdsk7F2K6qdQotY9sxvmYu9p34THqTT0MVL3FmRFJ7PaNy0+oxXx7LkuLwcCTonZgzmT31rgYl5q7rqzqBNQ+kShJuZ7V5tsip6EbPwoEyYfGOyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743189375; c=relaxed/simple;
	bh=2KgFrZGE+sa+GTybeOUTD4ECq83eRXhjesPYIq8ugUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRK4gWARAdHbrX8QLoQdhFaJO5DSERqiXNgG03BiXXc8+lpCimY9tJ33OrUHZ3tCZUsqtoEfSQ2Yj4ZkGi241mZkFjMefDvL8i6F2EMWCjt1nJzhUFIngfUz6m4uwJk3QWHPpslW0CV4cTmOTr8bifK1DepmJ2Cr06Oec40aFqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gg6YPvBl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-399749152b4so841720f8f.3
        for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 12:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743189371; x=1743794171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VnBDpX3rU3QekuOvYLYE3igRQJMETIDKkTgAkKNlceE=;
        b=Gg6YPvBlAMdQdsgP+9bZotdXck/wIrQA91v+pJB91T/+E1RbE16lazbrVYNIymhqOQ
         +7HR6qBjLVFdAWZOa7T3X1qUCtdQV1saTH70rEmJoi5qaChsWGlf4M/XsrXZ5iit1Zkr
         iS0xPOnuTHQVbuZlFpD5dGLOJ6lst8q69JOEH+3WOcz1eO2r1/JQO/pWnrC6cp7a6jFH
         lNBNB8aU0u++QBBqp9mTBg5uekr37S52vig/b8QoRUaer07RxTIEtyGsSongdzt5n/DC
         KlgNWWjfkHVocHA6qmCl4v/EvSh0TydbieK6Jj0RLgSSYF/PjV9EdFaKLSX/mLdUdGD1
         VJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743189371; x=1743794171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnBDpX3rU3QekuOvYLYE3igRQJMETIDKkTgAkKNlceE=;
        b=APjUnJOAmJyKwEicloJZV5WzKRZzUn3w72DRe3TNH9FW4zViFL2YXaJ9R3vqCSo3et
         ElwtXmxMbBF0+cKDN9TDKUg6qETZ7AJQh0Ay1HdsR+y1pvDeLsT/TInIaVAWzmVkKTx+
         QrX6ZJiAjc2A37iusbIRDhdgmcdhoOSwShv3r2n2a86CDkP8WiH6TQVXrJfsXZgtLg7w
         F7nNBfbwMw9SaBqtRpMuyDZ0crymnkyTZjMXU7IWfcwh/hnD5Fe1x1Cep1xfE698qs8F
         HH3KpWFCSTSEag5eOdDP+qgpEFwIN/fQXSB64Gkex4PSECsHZ1jrZ0hOm2sNnnUbYkrt
         abQQ==
X-Gm-Message-State: AOJu0YwTn5o5PDai2wF6oSgqtUzxEW23jOsXuVUvWC2UnA6BX8IfqDb7
	M3aYTb0+J7zBHqQxeGBHgjMliufQA5oBm38j5qxgSZRMZGVzaVZQ
X-Gm-Gg: ASbGncvHTMnmuMt9ssGZxhSLrM1yHi9G8/2+US+OSW9P8AOhLbA3CpWcZJ83PNR/7c4
	LGdEgBG12W8kSyMBQ5eOkTLC9F06QYA2ZYyGddNkVw1Exc03PhxzMmoLkd8OtWQcHqw8PCqYfnq
	J2oGjV4HOWy5WQUvysEHHNYWKb3XuuaOBopb4kAqDsBclKXiwh9S5miVxihplZRpbY6kpqmW6b0
	1ozKRQf26i8h4Xlppt5E7BW351P1pg4OOGoIuFvQZxXVT8W8Mbs0LZtfmYhku9rUVMSuWIWIuHt
	YKRyHOYbvfr3qyrNT5hWARvux0Tqyc4qEkx0VUxJGdOkDTWuJARF4NZlA+6BgdEm53JR4kjWxe4
	M77bkqfp05siw0aWcMV8vdVFVxYCCm2TxoWAW
X-Google-Smtp-Source: AGHT+IEGDJ0B/H0ReqWl+RTq0gPQS/jZoVcMLZKbJUTURJG6mRB7ddzdOntNXHEHRcTDQJy7/ndEPQ==
X-Received: by 2002:a05:6000:2d88:b0:39c:1257:feb9 with SMTP id ffacd0b85a97d-39c1257ff14mr105049f8f.57.1743189371079;
        Fri, 28 Mar 2025 12:16:11 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10? ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8fbc1716sm36018435e9.15.2025.03.28.12.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 12:16:10 -0700 (PDT)
Message-ID: <196c2eb9-aca9-4533-b927-255569154a73@gmail.com>
Date: Fri, 28 Mar 2025 19:16:09 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] libbpf: add getters for BTF.ext func and line
 info
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250326180714.44954-1-mykyta.yatsenko5@gmail.com>
 <CAEf4BzY_rbdXFDyYN=s7c25R5kwpBX5-zxQd8Q+6wX2N0r6Uhw@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzY_rbdXFDyYN=s7c25R5kwpBX5-zxQd8Q+6wX2N0r6Uhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/03/2025 17:14, Andrii Nakryiko wrote:
> On Wed, Mar 26, 2025 at 11:07 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Introducing new libbpf API getters for BTF.ext func and line info,
>> namely:
>>    bpf_program__func_info
>>    bpf_program__func_info_cnt
>>    bpf_program__func_info_rec_size
>>    bpf_program__line_info
>>    bpf_program__line_info_cnt
>>    bpf_program__line_info_rec_size
>>
>> This change enables scenarios, when user needs to load bpf_program
>> directly using `bpf_prog_load`, instead of higher-level
>> `bpf_object__load`. Line and func info are required for checking BTF
>> info in verifier; verification may fail without these fields if, for
>> example, program calls `bpf_obj_new`.
>>
> Really, bpf_obj_new() needs func_info/line_info? Can you point where
> in the verifier we check this, curious why we do that.
Indirectly, yes:
in verifier.c function check_btf_info_early sets
`env->prog->aux->btf = btf;`
only if line_info_cnt or func_info_cnt are non zero.
and then there is a check that errors out:
`verbose(env, "bpf_obj_new/bpf_percpu_obj_new requires prog BTF\n");`
perhaps this can be improved as well, by setting aux->btf even if no 
func info and line info
>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/lib/bpf/libbpf.c   | 30 ++++++++++++++++++++++++++++++
>>   tools/lib/bpf/libbpf.h   |  8 ++++++++
>>   tools/lib/bpf/libbpf.map |  6 ++++++
>>   3 files changed, 44 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 6b85060f07b3..bc15526ed84c 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -9455,6 +9455,36 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
>>          return 0;
>>   }
>>
>> +void *bpf_program__func_info(struct bpf_program *prog)
> const struct bpf_program, here and everywhere else
>
>> +{
>> +       return prog->func_info;
>> +}
>> +
>> +__u32 bpf_program__func_info_cnt(struct bpf_program *prog)
>> +{
>> +       return prog->func_info_cnt;
>> +}
>> +
>> +__u32 bpf_program__func_info_rec_size(struct bpf_program *prog)
>> +{
>> +       return prog->func_info_rec_size;
>> +}
>> +
>> +void *bpf_program__line_info(struct bpf_program *prog)
> should be `const void *`, if we went with `void *`, but see below about types
>
>> +{
>> +       return prog->line_info;
>> +}
>> +
>> +__u32 bpf_program__line_info_cnt(struct bpf_program *prog)
>> +{
>> +       return prog->line_info_cnt;
>> +}
>> +
>> +__u32 bpf_program__line_info_rec_size(struct bpf_program *prog)
>> +{
>> +       return prog->line_info_rec_size;
>> +}
>> +
> As Eduard mentioned, I don't think `void *` is a good interface. We
> have bpf_line_info_min and bpf_func_info_min structs in
> libbpf_internal.h. We have never changed those types, so at this point
> I feel comfortable enough to expose them as API types. Let's drop the
> _min suffix, and move definitions to btf.h?
>
> The only question is whether to document that each record could be
> bigger in size than sizeof(struct bpf_func_info) (and similarly for
> bpf_line_info), and thus user should always care about
> func_info_rec_size? Or, to keep it ergonomic and simple, and basically
> always return sizeof(struct bpf_func_info) data (and if it so happens
> that we'll in the future have different record sizes, then we'll
> create a local trimmed representation for user; it's a pain, but we
> won't be really stuck from API compatibility standpoint).
>
> I'd go with simple and ergonomic, given we haven't ever extended these
> records, and it's unlikely we will. Those types work well and provide
> enough information as is. So let's not even add _rec_size() APIs (at
> least for now; we can always revisit this later)
>
> pw-bot: cr
Thanks for reviewing, I'll send v2.
>>   #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {                       \
>>          .sec = (char *)sec_pfx,                                             \
>>          .prog_type = BPF_PROG_TYPE_##ptype,                                 \
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index e0605403f977..29a5fd7f51f0 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -940,6 +940,14 @@ LIBBPF_API int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_le
>>   LIBBPF_API const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_size);
>>   LIBBPF_API int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size);
>>
>> +LIBBPF_API void *bpf_program__func_info(struct bpf_program *prog);
>> +LIBBPF_API __u32 bpf_program__func_info_cnt(struct bpf_program *prog);
>> +LIBBPF_API __u32 bpf_program__func_info_rec_size(struct bpf_program *prog);
>> +
>> +LIBBPF_API void *bpf_program__line_info(struct bpf_program *prog);
>> +LIBBPF_API __u32 bpf_program__line_info_cnt(struct bpf_program *prog);
>> +LIBBPF_API __u32 bpf_program__line_info_rec_size(struct bpf_program *prog);
>> +
>>   /**
>>    * @brief **bpf_program__set_attach_target()** sets BTF-based attach target
>>    * for supported BPF program types:
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index d8b71f22f197..a5d83189c084 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -437,6 +437,12 @@ LIBBPF_1.6.0 {
>>                  bpf_linker__add_fd;
>>                  bpf_linker__new_fd;
>>                  bpf_object__prepare;
>> +               bpf_program__func_info;
>> +               bpf_program__func_info_cnt;
>> +               bpf_program__func_info_rec_size;
>> +               bpf_program__line_info;
>> +               bpf_program__line_info_cnt;
>> +               bpf_program__line_info_rec_size;
>>                  btf__add_decl_attr;
>>                  btf__add_type_attr;
>>   } LIBBPF_1.5.0;
>> --
>> 2.48.1
>>


