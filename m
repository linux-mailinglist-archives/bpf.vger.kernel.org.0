Return-Path: <bpf+bounces-55416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDD6A7E726
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 18:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70E7421056
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2669920C034;
	Mon,  7 Apr 2025 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6Na7lQ+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28BE206F1B
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043722; cv=none; b=oDD7fxJaBY11Uysu8gPq9zjYCsZdxVdux+QVKGugCHXbq708SGJr9/yoHINEePkj+UZkq+e66xoPllcjESHW/cPneFor3CKoRAxR37xo6AfSUcbJ3zy1JWtvOuGm6WV4cnsqf9zVsEgbZRGLLS5mKLsmhFU7r5WdRka6X0o7Duw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043722; c=relaxed/simple;
	bh=f112ozrbONrnRA32CaFxRE4HU/5A6weh1XF94Sy0Ff4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gb9mtholsuqqjmRgAnSLv8uqvLNPisi8KeQCs7GOXqkO9EyQyZMnl2sPxURi1v82aPpvti67UCMoCjadq+GJbZqKZNzq6bq1h6CIYdCnGMswsThujzLpPCEzepJvseJOlsV0YEx2JBSpS2x9qrZ6XLX4KJhOrPC7IaqGHvXgAcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6Na7lQ+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-391342fc0b5so3616371f8f.3
        for <bpf@vger.kernel.org>; Mon, 07 Apr 2025 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744043718; x=1744648518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KWTT8wfnEjOLtiKIcrtKeaNaa8PM7RH1SbBofDUHWrA=;
        b=K6Na7lQ+A9XOhlMAjCtnK01G7ditdY58qQeHTC/9UwEY3TZY2yvheV2MaSE76r96ZK
         clutW7VL8x+MLln3hRYQVsztaB0Vg7KFFxcsGH0EGl5r2cqP6aMHHpHYBfFlvdatL1sV
         wOt2QZKcz4Jg8/UbrNs9t5dMEmBvvh/46o11Nm9J27nPoBg0l0vAVmbVLHusgs+tjG1v
         KwIJq/8dEIklMpdcd1nU0jCHiLCpNvdktxVldmvgCSv5PljdDn2IdLJXgrCJhOcHCguv
         ljFxwy9+ciRVlRg3WeaUpo/do3nxoZJ38SwF7dIVe3YnbjsOyZ1m8MM14wQJBylF0PzC
         zgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744043718; x=1744648518;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWTT8wfnEjOLtiKIcrtKeaNaa8PM7RH1SbBofDUHWrA=;
        b=oia60aM04/jwoGiUA3px2HlDKkj/b0M+QSwfWrjm2iJjQrgXl8Zy0y3kzhX70XNTYw
         AezDiNJ+LDwoaiyzLLLeP/LLCTsYxRWapdu6V8NUASLmcY2sYIolfrBzIdoqPCq4HnpY
         sbL1MnGnpLnG82HyVWHxjZHUJXpSwOxVNaoeZbxrpdTLoT59zKaznSh9nNIK8YoCmxrw
         s50+EO67i+rTO5GC3e0UDd8b8jDqnSUh4U308oH+Wrgo3089nhcFyO5xCjusC64/MMDb
         hBg+EzNiyRUwNq5K2N4oU+Q5VbcBQ2PQaHUGJ3R9MHcQlvCtcQ+j2nj8gXFIkGsXsVKO
         c6pg==
X-Gm-Message-State: AOJu0YyAXnXhluFc1P+Gbkbj7ZZWQj9UqHokt1rqjda/mGk6CZN1v0lg
	hmchE8s4lwBKUCDjfnaJ1GGvnu2979a2naxRUR70T5OZEUR63Yub
X-Gm-Gg: ASbGncvAx61OQZqjcwBGx4D36neD5U/yFYtbDfLGsmuOQZVreYy/2y7k8mDS968HfD7
	gP4r5xf07IJZlS8v1ByoDi0904M/PKerPrpptdw4IB8hT0iLF5LySwQWdY2nmOXeUa4KWVux16y
	l7zGbKPXLuYT8BPt7NvUDEvRP1gTi2EyuhLwwH1zSiysWRs3t+mRcw8ANqY4Two+PdYuKc1M2FW
	7QNvEhPG1Cq/DvcqqwKuL2tIt8W/TVRvcNxRoWGkWeLaCS6p4kkYGWPN75+jH4zCESQAAx/eJBB
	jX+2KKc1hsWBssLHWq+50XM+xSkHKr125WbM7AxLzAQ/otKa0w6lVGvROYPGLFpF8aCWcOKjZGs
	5J6dx8+omU2wpEpp/m23sYBbbhtEEJmUsviW1
X-Google-Smtp-Source: AGHT+IG6Jj0AZb7bRot/ble05QZsMxZH4ZHfPjcxSN+wxVTdmn7s0VrsYIKQpyxq6o/LPg5sSpcP7Q==
X-Received: by 2002:a5d:6d88:0:b0:39c:3122:ad0c with SMTP id ffacd0b85a97d-39cb36b2a5fmr13054963f8f.11.1744043717541;
        Mon, 07 Apr 2025 09:35:17 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10? ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d92dsm12694665f8f.71.2025.04.07.09.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 09:35:17 -0700 (PDT)
Message-ID: <8dc17d02-91e8-4720-8f4d-33a450eddcc8@gmail.com>
Date: Mon, 7 Apr 2025 17:35:16 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: support struct/union presets
 in veristat
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250331211217.201198-1-mykyta.yatsenko5@gmail.com>
 <CAEf4BzbD1SP=fv0cG81HBS6Ld_v07f4RXgDDR_EMhEYAkHjx9Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEf4BzbD1SP=fv0cG81HBS6Ld_v07f4RXgDDR_EMhEYAkHjx9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/04/2025 19:39, Andrii Nakryiko wrote:
> On Mon, Mar 31, 2025 at 2:12 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko<yatsenko@meta.com>
>>
>> Extend commit e3c9abd0d14b ("selftests/bpf: Implement setting global
>> variables in veristat") to support applying presets to members of
>> the global structs or unions in veristat.
>> For example:
>> ```
>> ./veristat set_global_vars.bpf.o  -G "union1.struct3.var_u8_h = 0xBB"
>> ```
>>
>> Signed-off-by: Mykyta Yatsenko<yatsenko@meta.com>
>> ---
>>   .../selftests/bpf/prog_tests/test_veristat.c  |   5 +
>>   tools/testing/selftests/bpf/progs/prepare.c   |   1 -
>>   .../selftests/bpf/progs/set_global_vars.c     |  40 +++++++
>>   tools/testing/selftests/bpf/veristat.c        | 106 ++++++++++++++++--
>>   4 files changed, 144 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
>> index a95b42bf744a..47b56c258f3f 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
>> @@ -63,6 +63,9 @@ static void test_set_global_vars_succeeds(void)
>>              " -G \"var_eb = EB2\" "\
>>              " -G \"var_ec = EC2\" "\
>>              " -G \"var_b = 1\" "\
>> +           " -G \"struct1.struct2.u.var_u8 = 170\" "\
>> +           " -G \"union1.struct3.var_u8_l = 0xaa\" "\
>> +           " -G \"union1.struct3.var_u8_h = 0xaa\" "\
>>              "-vl2 > %s", fix->veristat, fix->tmpfile);
>>
>>          read(fix->fd, fix->output, fix->sz);
>> @@ -78,6 +81,8 @@ static void test_set_global_vars_succeeds(void)
>>          __CHECK_STR("_w=12 ", "var_eb = EB2");
>>          __CHECK_STR("_w=13 ", "var_ec = EC2");
>>          __CHECK_STR("_w=1 ", "var_b = 1");
>> +       __CHECK_STR("_w=170 ", "struct1.struct2.u.var_u8 = 170");
>> +       __CHECK_STR("_w=0xaaaa ", "union1.var_u16 = 0xaaaa");
>>
>>   out:
>>          teardown_fixture(fix);
>> diff --git a/tools/testing/selftests/bpf/progs/prepare.c b/tools/testing/selftests/bpf/progs/prepare.c
>> index 1f1dd547e4ee..cfc1f48e0d28 100644
>> --- a/tools/testing/selftests/bpf/progs/prepare.c
>> +++ b/tools/testing/selftests/bpf/progs/prepare.c
>> @@ -2,7 +2,6 @@
>>   /* Copyright (c) 2025 Meta */
>>   #include <vmlinux.h>
>>   #include <bpf/bpf_helpers.h>
>> -//#include <bpf/bpf_tracing.h>
>>
>>   char _license[] SEC("license") = "GPL"; diff --git a/tools/testing/selftests/bpf/progs/set_global_vars.c 
>> b/tools/testing/selftests/bpf/progs/set_global_vars.c index 
>> 9adb5ba4cd4d..187e9791e72e 100644 --- 
>> a/tools/testing/selftests/bpf/progs/set_global_vars.c +++ 
>> b/tools/testing/selftests/bpf/progs/set_global_vars.c @@ -24,6 +24,43 
>> @@ const volatile enum Enumu64 var_eb = EB1; const volatile enum 
>> Enums64 var_ec = EC1; const volatile bool var_b = false; +struct 
>> Struct { + int:16; + __u16 filler; + struct { + const __u16 filler2; 
>> + }; + struct Struct2 { + __u16 filler; + volatile struct { + const 
>> __u32 filler2; + union { + const volatile __u8 var_u8; + const 
>> volatile __s16 filler3; + } u; + }; + } struct2; +}; + +const 
>> volatile __u32 stru = 0; /* same prefix as below */ +const volatile 
>> struct Struct struct1 = {.struct2 = {.u = {.var_u8 = 1}}}; + +union 
>> Union { + __u16 var_u16; + struct Struct3 { + struct { + __u8 
>> var_u8_l; + }; + struct { + struct { + __u8 var_u8_h; + }; + }; + } 
>> struct3; +}; + +const volatile union Union union1 = {.var_u16 = -1}; 
>> + char arr[4] = {0}; SEC("socket")
>> @@ -43,5 +80,8 @@ int test_set_globals(void *ctx)
>>          a = var_eb;
>>          a = var_ec;
>>          a = var_b;
>> +       a = struct1.struct2.u.var_u8;
>> +       a = union1.var_u16;
>> +
>>          return a;
>>   }
>> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
>> index a18972ffdeb6..727ef80a1e47 100644
>> --- a/tools/testing/selftests/bpf/veristat.c
>> +++ b/tools/testing/selftests/bpf/veristat.c
>> @@ -1486,7 +1486,89 @@ static bool is_preset_supported(const struct btf_type *t)
>>          return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
>>   }
>>
>> -static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct btf_type *t,
>> +struct btf_anon_stack {
>> +       const struct btf_type *type;
>> +       __u32 offset;
>> +};
>> +
> unused leftover
>
>> +const int btf_find_member(const struct btf *btf,
>> +                         const struct btf_type *parent_type,
>> +                         __u32 parent_offset,
>> +                         const char *member_name,
>> +                         int *member_tid,
>> +                         __u32 *member_offset)
>> +{
>> +       int i;
>> +
>> +       if (!btf_is_composite(parent_type))
>> +               return -EINVAL;
>> +
>> +       for (i = 0; i < btf_vlen(parent_type); ++i) {
>> +               const struct btf_member *member;
>> +               const struct btf_type *member_type;
>> +               int tid;
>> +
>> +               member = btf_members(parent_type) + i;
>> +               tid =  btf__resolve_type(btf, member->type);
>> +               if (tid < 0)
>> +                       return -EINVAL;
>> +
>> +               member_type = btf__type_by_id(btf, tid);
>> +               if (member->name_off) {
>> +                       const char *name = btf__name_by_offset(btf, member->name_off);
>> +
>> +                       if (strcmp(member_name, name) == 0) {
>> +                               *member_offset = parent_offset + member->offset;
>> +                               *member_tid = tid;
>> +                               return 0;
>> +                       }
>> +               } else if (btf_is_composite(member_type)) {
>> +                       int err;
>> +
>> +                       err = btf_find_member(btf, member_type, parent_offset + member->offset,
>> +                                             member_name, member_tid, member_offset);
>> +                       if (!err)
>> +                               return 0;
>> +               }
>> +       }
>> +
>> +       return -EINVAL;
>> +}
>> +
>> +static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
>> +                             struct btf_var_secinfo *sinfo, const char *var)
>> +{
>> +       char expr[256], *saveptr;
>> +       const struct btf_type *base_type, *member_type;
>> +       int err, member_tid;
>> +       char *name;
>> +       __u32 member_offset = 0;
>> +
>> +       base_type = btf__type_by_id(btf, btf__resolve_type(btf, t->type));
>> +       strncpy(expr, var, 255);
>> +       expr[255] = '\0';
> strncpy() isn't a great API, and compilers have problems
> false-reporting non-zero-termination for them. I found that snprintf()
> works better
>
> snprintf(expr, sizeof(expr), "%s", var);
>
> ?
>
>> +       strtok_r(expr, ".", &saveptr);
>> +
>> +       while ((name = strtok_r(NULL, ".", &saveptr))) {
>> +               err = btf_find_member(btf, base_type, 0, name, &member_tid, &member_offset);
>> +               if (err) {
>> +                       fprintf(stderr, "Could not find member %s for variable %s\n", name, var);
>> +                       return err;
>> +               }
>> +               if (btf_kflag(base_type)) {
> hm... doesn't kflag on, say, STRUCT, just mean that there are *some*
> fields that are bitfields? If we don't reference those fields, it
> should be fine, no?
>
> So, instead, I think we should just check that
> btf_member_bitfield_size() for that field is zero, and if not --
> complain.
>
> Can you please also add a test case where we have a struct with
> bitfields, but we set only non-bitfield values and it all should work
> just fine. Thanks.

There is already a test with bitfield struct, this behavior does not 
repro, though
(btf_kflag is not set for structs with bitfields).
I think it's better to move this check out of the loop and only run on 
the final type
  we return in sinfo, either way it makes no sense to do it on structs, 
as you noticed.
I think I'll also move

+               sinfo->size = member_type->size;
+               sinfo->type = member_tid;
out, as we only care for the last type in the chain.

> pw-bot: cr
>
>> +                       fprintf(stderr, "Bitfield presets are not supported %s\n", name);
>> +                       return -EINVAL;
>> +               }
>> +               member_type = btf__type_by_id(btf, member_tid);
>> +               sinfo->offset += member_offset / 8;
>> +               sinfo->size = member_type->size;
>> +               sinfo->type = member_tid;
>> +               base_type = member_type;
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int set_global_var(struct bpf_object *obj, struct btf *btf,
>>                            struct bpf_map *map, struct btf_var_secinfo *sinfo,
>>                            struct var_preset *preset)
>>   {
>> @@ -1495,9 +1577,9 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct
>>          long long value = preset->ivalue;
>>          size_t size;
>>
>> -       base_type = btf__type_by_id(btf, btf__resolve_type(btf, t->type));
>> +       base_type = btf__type_by_id(btf, btf__resolve_type(btf, sinfo->type));
>>          if (!base_type) {
>> -               fprintf(stderr, "Failed to resolve type %d\n", t->type);
>> +               fprintf(stderr, "Failed to resolve type %d\n", sinfo->type);
>>                  return -EINVAL;
>>          }
>>          if (!is_preset_supported(base_type)) {
>> @@ -1530,7 +1612,7 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct
>>                  if (value >= max_val || value < -max_val) {
>>                          fprintf(stderr,
>>                                  "Variable %s value %lld is out of range [%lld; %lld]\n",
>> -                               btf__name_by_offset(btf, t->name_off), value,
>> +                               btf__name_by_offset(btf, base_type->name_off), value,
>>                                  is_signed ? -max_val : 0, max_val - 1);
>>                          return -EINVAL;
>>                  }
>> @@ -1583,14 +1665,20 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
>>                  for (j = 0; j < n; ++j, ++sinfo) {
>>                          const struct btf_type *var_type = btf__type_by_id(btf, sinfo->type);
>>                          const char *var_name;
>> +                       int var_len;
>>
>>                          if (!btf_is_var(var_type))
>>                                  continue;
>>
>>                          var_name = btf__name_by_offset(btf, var_type->name_off);
>> +                       var_len = strlen(var_name);
>>
>>                          for (k = 0; k < npresets; ++k) {
>> -                               if (strcmp(var_name, presets[k].name) != 0)
>> +                               struct btf_var_secinfo tmp_sinfo;
>> +
>> +                               if (strncmp(var_name, presets[k].name, var_len) != 0 ||
>> +                                   (presets[k].name[var_len] != '\0' &&
>> +                                    presets[k].name[var_len] != '.'))
>>                                          continue;
>>
>>                                  if (presets[k].applied) {
>> @@ -1598,13 +1686,17 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
>>                                                  var_name);
>>                                          return -EINVAL;
>>                                  }
>> +                               memcpy(&tmp_sinfo, sinfo, sizeof(*sinfo));
> isn't this just:
>
> tmp_sinfo = *sinfo;
>
> why memcpy?
Right, makes sense.
>> +                               err = adjust_var_secinfo(btf, var_type,
>> +                                                        &tmp_sinfo, presets[k].name);
>> +                               if (err)
>> +                                       return err;
>>
>> -                               err = set_global_var(obj, btf, var_type, map, sinfo, presets + k);
>> +                               err = set_global_var(obj, btf, map, &tmp_sinfo, presets + k);
>>                                  if (err)
>>                                          return err;
>>
>>                                  presets[k].applied = true;
>> -                               break;
>>                          }
>>                  }
>>          }
>> --
>> 2.49.0
>>


