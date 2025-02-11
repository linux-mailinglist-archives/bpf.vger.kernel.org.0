Return-Path: <bpf+bounces-51152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61024A30EFA
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 16:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F068218868C2
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 15:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89BF250C13;
	Tue, 11 Feb 2025 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSas8dQf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93583D69
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286055; cv=none; b=WjN49ksM93oIcsHSn25cb8zoHvpFA+7e7qgXVnV81I/yvhRbOmGR+lCBuO6VM6XURR2JpfI/7K21IX8w/9NMyEGanwupjeDV02r0svLI8HGO3Z1YlTNt8YYZgJQ7O6g0bHgnxiJbID8+mEX3d08ysI71bo9TC7aocrR9pIGfqMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286055; c=relaxed/simple;
	bh=gv8DRz5+1+Qk5BNkttYcl2ki1BPduqMl2fM8oWJ+BKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmCnKmsCFHcwTk4wPVm7Tlpvvw6HRDnQS0Qb96dgOz1bdIHVWlbXxeZKIPT03VnGszQSO01BMFj1r1WRW72zguuokDTcc7g94FlfT2zNDn+RI+fgZOf7hunoEga5JU4BKMvUutTeuSgYxK2aL8p6GG3xNB8wxBuwj++gnqAfPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSas8dQf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5de6ff9643fso4874611a12.3
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 07:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739286051; x=1739890851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RDtiBCUe6sRYKx6S1068DbZ/Qluolk/gvzw0MPRaui8=;
        b=dSas8dQfi4qT5UazZvRYSq5lKhJmqa9PDZb6bWWEpW6skQSSZCemiQafFuqhE4D+Cd
         T2Uq1OS7nyxSKaCv90VVodLx1CLiktnD/iSDON2KrK3gfZyAnDZnzWXi40IsTiC5RIk8
         FUhy+7sS9qWNwEzQgCYP+CgI6eQnrTgeDGHwTXYWI+0VvKx+WD7VKcca0zr0rjQS2uvq
         F/S+ha6lKD95XLExsWbtRjlIa0UV8M1XUjin9b9qcBkB4OklNBzDoIJtGn1TCGsWAyHv
         JMxrJ8Wg24NNpZcV1UhMX/crwa+2h+n4Ebyv12109/2SESl1a7Paa9gNZa/3HUpVmp7K
         j5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739286051; x=1739890851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDtiBCUe6sRYKx6S1068DbZ/Qluolk/gvzw0MPRaui8=;
        b=Ws1D3GTHvvOSikIKDSnyqxjtMd0wL93k3S+OFdx9FIjXPcXyZmrozTQsJjABKEmpW7
         pb04Ae2XSWmfy6zxmTVpw/pfGRg4Zn9IoM1ao86fD+fPozg0sV0f8Gr2gTXz5F9Vymra
         1PqPiVv06hVG088C95DIaEkRCk24j2Xk2c/ooki+pha1uZL5pyYfhufdu5ZS56sXPdVu
         pHkQGldKSk27EEZXGGbLf2QM+jycwWcvZvlDvvzbCkr0zZVfcnek3q/8FQVRu+JZj7AL
         PgPPRJtJMQHRcGVBdLs7IrN80S63WgEBUHeLQ0yXYyQrT9AXb1X46T+LoqxeoeEizYCk
         5Myw==
X-Gm-Message-State: AOJu0YxRmaR+wHbzGUp5kCDizfxRSWjCA1QYehISjnUao7X1njYiqHZw
	Rt6tuMU9vxIxGWbeeIM6SXg8d6j+js/lLBL817QQzOjcGKDm00qa
X-Gm-Gg: ASbGncsGHFrYW6h7bke3eIhHZJmXkxbwkdf7MeT9ZT+RvTKBoAdTJCL0YxxB/nqfSCo
	hj4EtTJbHS4wiN+TK5FpGAGXPL0sWZlA5Ur5w8VvDp34gXuCrW2Fs9wPprTbwuXtUiohakwZXTY
	GnaQl0TLC6wR671PyGVTa46t8LCtEC0RyGrPsrk2APK33YYyVvoU0uk7nsbEeOyrd52sJCZOpJ6
	pb33kOFD/gjYeienHCtQpJEi4ae5vkz7ut1QqiHUjwpQ0/Dg2euWHrRUQjYXScYsjvIL+xgw0tS
	wTT5bw2qG+ywPnUxCoS+QUNwXZqkWKZGP7Mg5B+u8rW8MJR6eJWz
X-Google-Smtp-Source: AGHT+IECrtp+a9AwlSiCLwLOKJJYwHVduFmOFRWIC7oIlYZy3El2B6byDQnVuQxIUGYUAONxV0iE2A==
X-Received: by 2002:a05:6402:2383:b0:5d2:723c:a568 with SMTP id 4fb4d7f45d1cf-5de45003940mr17539405a12.10.1739286050749;
        Tue, 11 Feb 2025 07:00:50 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:3:8dd1:e06e:70b9:d7dc? ([2620:10d:c092:500::4:1255])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de38c0e993sm9006023a12.12.2025.02.11.07.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 07:00:49 -0800 (PST)
Message-ID: <e2f5ec85-f3ba-4bd5-bc04-e6d9bc8945e8@gmail.com>
Date: Tue, 11 Feb 2025 15:00:46 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: implement setting global
 variables in veristat
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250210135129.719119-1-mykyta.yatsenko5@gmail.com>
 <20250210135129.719119-2-mykyta.yatsenko5@gmail.com>
 <CAEf4BzYVWSogUYk8pEPGs0N4eNb5fcXtmFMLkicokmqHPpbZCg@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzYVWSogUYk8pEPGs0N4eNb5fcXtmFMLkicokmqHPpbZCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/02/2025 01:13, Andrii Nakryiko wrote:
> On Mon, Feb 10, 2025 at 5:51 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> To better verify some complex BPF programs we'd like to preset global
>> variables.
>> This patch introduces CLI argument `--set-global-vars` or `-G` to
>> veristat, that allows presetting values to global variables defined
>> in BPF program. For example:
>>
>> prog.c:
>> ```
>> enum Enum { ELEMENT1 = 0, ELEMENT2 = 5 };
>> const volatile __s64 a = 5;
>> const volatile __u8 b = 5;
>> const volatile enum Enum c = ELEMENT2;
>> const volatile bool d = false;
>>
>> char arr[4] = {0};
>>
>> SEC("tp_btf/sched_switch")
>> int BPF_PROG(...)
>> {
>>          bpf_printk("%c\n", arr[a]);
>>          bpf_printk("%c\n", arr[b]);
>>          bpf_printk("%c\n", arr[c]);
>>          bpf_printk("%c\n", arr[d]);
>>          return 0;
>> }
>> ```
>> By default verification of the program fails:
>> ```
>> ./veristat prog.bpf.o
>> ```
>> By presetting global variables, we can make verification pass:
>> ```
>> ./veristat wq.bpf.o  -G "a = 0" -G "b = 1" -G "c = 2" -G "d = 3"
>> ```
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/testing/selftests/bpf/veristat.c | 319 ++++++++++++++++++++++++-
>>   1 file changed, 307 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
>> index 06af5029885b..b4521ebb6e6a 100644
>> --- a/tools/testing/selftests/bpf/veristat.c
>> +++ b/tools/testing/selftests/bpf/veristat.c
>> @@ -154,6 +154,15 @@ struct filter {
>>          bool abs;
>>   };
>>
>> +struct var_preset {
>> +       char *name;
>> +       enum { INTEGRAL, NAME } type;
>> +       union {
>> +               long long ivalue;
>> +               char *svalue;
>> +       };
>> +};
>> +
>>   static struct env {
>>          char **filenames;
>>          int filename_cnt;
>> @@ -195,6 +204,8 @@ static struct env {
>>          int progs_processed;
>>          int progs_skipped;
>>          int top_src_lines;
>> +       struct var_preset *presets;
>> +       int npresets;
>>   } env;
>>
>>   static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
>> @@ -246,12 +257,16 @@ static const struct argp_option opts[] = {
>>          { "test-reg-invariants", 'r', NULL, 0,
>>            "Force BPF verifier failure on register invariant violation (BPF_F_TEST_REG_INVARIANTS program flag)" },
>>          { "top-src-lines", 'S', "N", 0, "Emit N most frequent source code lines" },
>> +       { "set-global-vars", 'G', "GLOBALS", 0, "Set global variables provided in the expression, for example \"var1 = 1\"" },
>>          {},
>>   };
>>
>>   static int parse_stats(const char *stats_str, struct stat_specs *specs);
>>   static int append_filter(struct filter **filters, int *cnt, const char *str);
>>   static int append_filter_file(const char *path);
>> +static int parse_var_presets(char *expr, struct var_preset **presets, int *capacity, int *size);
>> +static int parse_var_presets_from_file(const char *filename, struct var_preset **presets,
>> +                                      int *capacity, int *size);
> nit: append_filter vs append_filter_file would imply this should be
> parse_var_presets vs parse_var_presets_file, no?
Sure, makes sense.
>>   static error_t parse_arg(int key, char *arg, struct argp_state *state)
>>   {
>> @@ -363,6 +378,24 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
>>                          return -ENOMEM;
>>                  env.filename_cnt++;
>>                  break;
>> +       case 'G': {
>> +               static int presets_cap;
>> +               char *expr = strdup(arg);
>> +
>> +               if (expr[0] == '@') {
>> +                       if (parse_var_presets_from_file(expr + 1, &env.presets,
>> +                                                       &presets_cap, &env.npresets)) {
>> +                               fprintf(stderr, "Could not parse global variables preset: %s\n",
>> +                                       arg);
>> +                               argp_usage(state);
>> +                       }
>> +               } else if (parse_var_presets(expr, &env.presets, &presets_cap, &env.npresets)) {
>> +                       fprintf(stderr, "Could not parse global variables preset: %s\n", arg);
>> +                       argp_usage(state);
>> +               }
>> +               free(expr);
>> +               break;
>> +       }
> Can you please follow the append_filter pattern here? Consistency is
> good. I don't think we want presets_cap and expr here as well. Don't
> micro-optimize, it's ok to call realloc() for each entry for
> non-performance critical code. Internally libc won't really reallocate
> every single time.
>
>>          default:
>>                  return ARGP_ERR_UNKNOWN;
>>          }
>> @@ -1292,6 +1325,273 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>>          return 0;
>>   };
>>
>> +static int parse_var_presets(char *expr, struct var_preset **presets, int *capacity, int *size)
>> +{
>> +       char *eq_ptr = strchr(expr, '=');
>> +       char *name_ptr = expr;
>> +       char *name_end = eq_ptr - 1;
>> +       char *val_ptr = eq_ptr + 1;
>> +       long long value;
>> +
>> +       if (!eq_ptr) {
>> +               fprintf(stderr, "No assignment in expression\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       while (isspace(*name_ptr))
>> +               ++name_ptr;
>> +       while (isspace(*name_end))
>> +               --name_end;
>> +       while (isspace(*val_ptr))
>> +               ++val_ptr;
> here's  a pro tip: scanf() is pretty useful and powerful parser for
> simple stuff. scanf(" %s = %[^\n]\n") will trim spaces around variable
> name and equality and will capture the rest of string. Or if you do "
> %s = %s\n" it will trim spaces and do the right thing as long as we
> don't expect whitespace to be valid value (we can start there for now,
> because it's true for integers and enums)
>
>> +
>> +       if (name_ptr > name_end) {
>> +               fprintf(stderr, "Empty variable name in expression %s\n", expr);
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (*size >= *capacity) {
>> +               *capacity = max(*capacity * 2, 1);
>> +               *presets = realloc(*presets, *capacity * sizeof(**presets));
>> +       }
>> +
> as I mentioned above, don't bother optimizing and keeping track of
> capacity, just realloc() every single time, it's fine
>
>> +       if (isalpha(*val_ptr)) {
>> +               char *value_end = val_ptr + strlen(val_ptr) - 1;
>> +
>> +               while (isspace(*value_end))
>> +                       --value_end;
>> +               *(value_end + 1) = '\0';
>> +
>> +               (*presets)[*size].svalue = strdup(val_ptr);
>> +               (*presets)[*size].type = NAME;
>> +       } else if (*val_ptr == '-' || isdigit(*val_ptr)) {
>> +               errno = 0;
>> +               value = strtoll(val_ptr, NULL, 0);
>> +               if (errno == ERANGE) {
>> +                       errno = 0;
>> +                       value = strtoull(val_ptr, NULL, 0);
>> +               }
>> +               (*presets)[*size].ivalue = value;
>> +               (*presets)[*size].type = INTEGRAL;
>> +               if (errno) {
>> +                       fprintf(stderr, "Could not parse integer value %s\n", val_ptr);
>> +                       return -EINVAL;
>> +               }
>> +       } else {
>> +               fprintf(stderr, "Could not parse value %s\n", val_ptr);
>> +               return -EINVAL;
>> +       }
>> +       *(name_end + 1) = '\0';
>> +       (*presets)[*size].name = strdup(name_ptr);
>> +       (*size)++;
> ... maybe let's do something simpler and dumber? Try to parse provided
> string as integer, if it succeeds (and consumes entire string) --
> great, if not -- assume it's enum or true/false (if you support that)?
>
> btw, see scanf()'s %i modifier, it can parse both hex and dec numbers.
> You can just try with '-' and without.
>
> Basically, let's keep it straightforward, even if it's, technically
> speaking, suboptimal performance-wise.
>
>> +       return 0;
>> +}
>> +
>> +static int parse_var_presets_from_file(const char *filename, struct var_preset **presets,
>> +                                      int *capacity, int *size)
>> +{
>> +       FILE *f;
>> +       char line[256];
>> +       int err = 0;
>> +
>> +       f = fopen(filename, "rt");
>> +       if (!f) {
>> +               fprintf(stderr, "Could not open file %s\n", filename);
>> +               return -EINVAL;
>> +       }
>> +
>> +       while (fgets(line, sizeof(line), f)) {
>> +               int err = parse_var_presets(line, presets, capacity, size);
>> +
>> +               if (err)
>> +                       goto cleanup;
>> +       }
>> +
>> +cleanup:
>> +       fclose(f);
>> +       return err;
>> +}
> see append_filter_file(), we do similar stuff there, keep it consistent
>
>> +
>> +static bool is_signed_type(const struct btf_type *t)
>> +{
>> +       if (btf_is_int(t))
>> +               return btf_int_encoding(t) & BTF_INT_SIGNED;
>> +       if (btf_is_enum(t))
>> +               return btf_kflag(t);
> there is also enum64, use btf_is_any_enum()
>
>> +       return true;
>> +}
>> +
>> +static int enum_value_from_name(const struct btf *btf, const struct btf_type *t,
>> +                               const char *evalue, long long *retval)
>> +{
>> +       if (btf_is_enum(t)) {
>> +               struct btf_enum *e = btf_enum(t);
>> +               int i, n = btf_vlen(t);
>> +
>> +               for (i = 0; i < n; ++i) {
>> +                       const char *cur_name = btf__name_by_offset(btf, e[i].name_off);
>> +
>> +                       if (strcmp(cur_name, evalue) == 0) {
>> +                               *retval = e[i].val;
>> +                               return 0;
>> +                       }
>> +               }
>> +       } else if (btf_is_enum64(t)) {
>> +               struct btf_enum64 *e = btf_enum64(t);
>> +               int i, n = btf_vlen(t);
>> +
>> +               for (i = 0; i < n; ++i) {
>> +                       struct btf_enum64 *cur = e + i;
>> +                       const char *cur_name = btf__name_by_offset(btf, cur->name_off);
> you have two conceptually identical loops, but in one you do `cur = e
> + i` and in another you do `e[i]` access... why?
The difference is that for e64 case we get value by the 
`btf_enum64_value` function, which accepts pointer to `btf_enum64`,
I think it is a bit cleaner to have an explicit assignment `struct 
btf_enum64 *cur = e + i;`, instead of passing `&e[i]`
into  btf_enum64_value. Though, let's make both loops more consistent.
>> +                       __u64 value =  btf_enum64_value(cur);
>> +
>> +                       if (strcmp(cur_name, evalue) == 0) {
>> +                               *retval = value;
>> +                               return 0;
>> +                       }
>> +               }
>> +       }
>> +       return -EINVAL;
>> +}
>> +
>> +static bool is_preset_supported(const struct btf_type *t)
>> +{
>> +       return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
>> +}
>> +
>> +static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct btf_type *t,
>> +                         struct bpf_map *map, struct btf_var_secinfo *sinfo,
>> +                         struct var_preset *preset)
>> +{
>> +       const struct btf_type *base_type;
>> +       void *ptr;
>> +       size_t size;
>> +
>> +       base_type = btf__type_by_id(btf, btf__resolve_type(btf, t->type));
>> +       if (!base_type) {
>> +               fprintf(stderr, "Could not resolve type %d\n", t->type);
>> +               return -EINVAL;
>> +       }
>> +       if (!is_preset_supported(base_type)) {
>> +               fprintf(stderr, "Setting global variable for btf kind %d is not supported\n",
>> +                       btf_kind(base_type));
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (preset->type == NAME && btf_is_any_enum(base_type)) {
>> +               /* Convert enum element name into integer */
>> +               long long ivalue;
>> +
>> +               if (enum_value_from_name(btf, base_type, preset->svalue, &ivalue) != 0) {
>> +                       fprintf(stderr, "Could not find integer value for enum element %s\n",
>> +                               preset->svalue);
>> +                       return -EINVAL;
>> +               }
>> +               free(preset->svalue);
>> +               preset->ivalue = ivalue;
>> +               preset->type = INTEGRAL;
> but for different object file this value can change? You can cache for
> the same BTF, but once BTF changes, you'll have to recalculate it (I'd
> keep it simple and look it up every single time, for now)
>
>> +       }
>> +
>> +       /* Check if value fits into the target variable size */
>> +       if  (sinfo->size < sizeof(preset->ivalue)) {
>> +               bool is_signed = is_signed_type(base_type);
>> +               __u32 unsigned_bits = sinfo->size * 8 - (is_signed ? 1 : 0);
>> +               long long max_val = 1ll << unsigned_bits;
> what about u64? 1 << 64 ?

This should not be executed for u64, check `if (sinfo->size < 
sizeof(preset->ivalue))` is there for that.

>
>> +
>> +               if (preset->ivalue >= max_val || preset->ivalue < -max_val) {
>> +                       fprintf(stderr,
>> +                               "Variable %s value %lld is out of range [%lld; %lld]\n",
>> +                               btf__name_by_offset(btf, t->name_off), preset->ivalue,
>> +                               is_signed ? -max_val : 0, max_val - 1);
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>> +       ptr = (void *)bpf_map__initial_value(map, &size);
>> +       if (!ptr || (sinfo->offset + sinfo->size > size))
>> +               return -EINVAL;
>> +
>> +       if (__BYTE_ORDER == __LITTLE_ENDIAN) {
>> +               memcpy(ptr + sinfo->offset, &preset->ivalue, sinfo->size);
>> +       } else if (__BYTE_ORDER == __BIG_ENDIAN) {
>> +               __u8 src_offset = sizeof(preset->ivalue) - sinfo->size;
>> +
>> +               memcpy(ptr + sinfo->offset, (void *)&preset->ivalue + src_offset, sinfo->size);
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, int npresets)
>> +{
>> +       struct btf_var_secinfo *sinfo;
>> +       const char *sec_name;
>> +       const struct btf_type *type;
>> +       struct bpf_map *map;
>> +       struct btf *btf;
>> +       bool *set_var;
>> +       int i, j, k, n, cnt, err = 0;
>> +
>> +       if (npresets == 0)
>> +               return 0;
>> +
>> +       btf = bpf_object__btf(obj);
>> +       if (!btf)
>> +               return -EINVAL;
>> +
>> +       set_var = calloc(npresets, sizeof(bool));
>> +       for (i = 0; i < npresets; ++i)
>> +               set_var[i] = false;
> calloc() is zero-initializing, no need to set to false
>
>> +
>> +       cnt = btf__type_cnt(btf);
>> +       for (i  = 0; i != cnt; ++i) {
> double space
>
>> +               type = btf__type_by_id(btf, i);
> nit: type -> t, we use that convention when working with BTF types
> quite consistently (btw, zero is always VOID, so you can always skip
> it with `i = 1`)
>
>> +
>> +               if (!btf_is_datasec(type))
>> +                       continue;
>> +
>> +               sinfo = btf_var_secinfos(type);
>> +               sec_name = btf__name_by_offset(btf, type->name_off);
>> +               map = bpf_object__find_map_by_name(obj, sec_name);
>> +               if (!map)
>> +                       continue;
>> +
>> +               n = btf_vlen(type);
>> +               for (j = 0; j < n; ++j, ++sinfo) {
>> +                       const struct btf_type *var_type = btf__type_by_id(btf, sinfo->type);
>> +                       const char *var_name = btf__name_by_offset(btf, var_type->name_off);
> it's kind of bad style, IMO, to look something up for
> var_type->name_off before you are sure it's what you care about
> (btf_is_var()), move assignment to after the if?
Agree.
>> +
>> +                       if (!btf_is_var(var_type))
>> +                               continue;
>> +
>> +                       for (k = 0; k < npresets; ++k) {
>> +                               if (strcmp(var_name, presets[k].name) != 0)
>> +                                       continue;
>> +
>> +                               if (set_var[k]) {
> maybe just have an extra counter in preset itself, which you can clear
> between BPF program loads? Less trouble with extra dynamic memory
> allocation
>
>> +                                       fprintf(stderr, "Variable %s is set more than once",
>> +                                               var_name);
> I'd error out in this case, tbh (it's either user error or static
> global variables, which I'm sure is unintentional in 99% of cases)
>
>> +                               }
>> +
>> +                               err = set_global_var(obj, btf, var_type, map, sinfo, presets + k);
>> +                               if (err)
>> +                                       goto out;
>> +
>> +                               set_var[k] = true;
>> +                               break;
>> +                       }
>> +               }
>> +       }
>> +       for (i = 0; i < npresets; ++i) {
>> +               if (!set_var[i]) {
>> +                       fprintf(stderr, "Global variable preset %s has not been applied\n",
>> +                               presets[i].name);
>> +               }
>> +       }
>> +out:
>> +       free(set_var);
>> +       return err;
>> +}
>> +
>>   static int process_obj(const char *filename)
>>   {
>>          const char *base_filename = basename(strdupa(filename));
>> @@ -1299,7 +1599,7 @@ static int process_obj(const char *filename)
>>          struct bpf_program *prog, *tprog, *lprog;
>>          libbpf_print_fn_t old_libbpf_print_fn;
>>          LIBBPF_OPTS(bpf_object_open_opts, opts);
>> -       int err = 0, prog_cnt = 0;
>> +       int err = 0;
>>
>>          if (!should_process_file_prog(base_filename, NULL)) {
>>                  if (env.verbose)
>> @@ -1334,17 +1634,6 @@ static int process_obj(const char *filename)
>>
>>          env.files_processed++;
>>
>> -       bpf_object__for_each_program(prog, obj) {
>> -               prog_cnt++;
>> -       }
>> -
>> -       if (prog_cnt == 1) {
>> -               prog = bpf_object__next_program(obj, NULL);
>> -               bpf_program__set_autoload(prog, true);
>> -               process_prog(filename, obj, prog);
>> -               goto cleanup;
>> -       }
>> -
> I think this was an optimization to avoid a heavy-weight ELF parsing
> twice, why would we want to remove it?..
Thanks for explaining, this looked like unnecessary code duplication, 
I'll revert it.
> pw-bot: cr
>
>>          bpf_object__for_each_program(prog, obj) {
>>                  const char *prog_name = bpf_program__name(prog);
>>
>> @@ -1355,6 +1644,12 @@ static int process_obj(const char *filename)
>>                          goto cleanup;
>>                  }
>>
>> +               err = set_global_vars(tobj, env.presets, env.npresets);
>> +               if (err) {
>> +                       fprintf(stderr, "Failed to set global variables\n");
>> +                       goto cleanup;
>> +               }
>> +
>>                  lprog = NULL;
>>                  bpf_object__for_each_program(tprog, tobj) {
>>                          const char *tprog_name = bpf_program__name(tprog);
>> --
>> 2.48.1
>>


