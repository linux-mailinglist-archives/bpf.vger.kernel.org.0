Return-Path: <bpf+bounces-59641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DB8ACE19E
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 17:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B227A10BC
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 15:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A245018B47D;
	Wed,  4 Jun 2025 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/PhBZgT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D0C4C6D
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749051236; cv=none; b=atQR0oPOobxf7D+ie9s55o1wSiuwn/OJkk6ux7WxQ3fsGW4aiN7LxL/a1927we1jPBPT5vWXbkh88wPRCg5iWME10qf8eWk49+M9VmJBi/TlaTbSgOymG3MZIhZpmYmfW2EWiNLIMjcL1AR+5mN2Xyvb62j0DPX0C9yrKndLtLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749051236; c=relaxed/simple;
	bh=6b3zxrb+PozCfbXK7eS8mAVfZVdd5sPvpgXkc9wx0NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nrj9O8dxTVawlbG28m/opk04cJC2GH5FHliaNvhnpI8QyeCmumFctWabnRQqH6QAzYXUBDG5Tm57XhDhDng/bJ0cbZF8ov/T/TIg3VDreCblY3SFCw894GmyfFM1uXs7SFfECQXxsUGvEi/5zySNQhVrYZrtC8+kawg0ULvykOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/PhBZgT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-606b6dbe316so3214743a12.3
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749051232; x=1749656032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9yrFrvYUOHlu8TBn2+VpeGXDGgpFbCCMLs57kDqroA=;
        b=G/PhBZgTgktmcfW4ZLYAAdl5YjhIL3ssi07S1tYdLjYtx8TXQqmp2cuUp/SqdLLELC
         MP8HtkqL1tQdaUFQoCA0YG00yAgXJIQJrjRMVAm1vBgDcfGAVvg1JiBEzWCDWhq0PPkQ
         2doG7IojzluADfLkv1QMkaGRZ9IeU6lFjCPT5DhAM7JWW0dHgolBn/oV4SPyC9hqFZJL
         /foMWFV6OolZc+jBEquCd8nV3aHTuqxd/aUh21rQYk/ji7oJc5pDte1iP2rRfNaEb1Co
         YZRDm05oADWaRy33l/21oR4x5NVhGIiKYXBRC3UIe2bgWSCCV88kMhSeWHI5eqHMTJT+
         rWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749051232; x=1749656032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9yrFrvYUOHlu8TBn2+VpeGXDGgpFbCCMLs57kDqroA=;
        b=qc0SCLLtqefZozOlDGfMMYFKIJMYpqBlSE91T3PQfE6JH/6oUGbY1uiihTtFXObPFe
         AG0Fassa3cSjAsDAcwq0+dJDy7ke6SyOEbQ8njMP+dxpwk/047Dw5mt//5+C+lB6qibn
         bCEHa9o5KxM/gpa3TT/bUfjUoVx+3JPZNGf7Sop6tq7JGLU/frLoFfMzXaw/AVIEYyzm
         pm9ptMe1FbyAxvEMs2AB80sVOFiHniKQqJGazzLowE3wXBYNGJGcre0PkdQFjrJ48mMo
         XVawxkzZZRh36XuvI45lsrXM34dHvZXpBIukTgqRiqBCFuHq/r1UiAfg9Cdec335a85R
         V0KQ==
X-Gm-Message-State: AOJu0YxuEdE47YDVW5XKZfvwvxAAyR1IcBEfF/IUY8D1PaUNCzbZl+V0
	OkgkviBqq1Mjl+lxoSOqqWxhxZzTvuZ7Uf7Sq+dNq1KU/atKAuXcYiqO
X-Gm-Gg: ASbGncspCgf/7dRfqNg7Vytna1Baq1l14vibN9S1aA5z3jVe9IMfDPtiI8FK+yGIpCg
	svCsnuzkkDhL3/9AE0CH+t4kc2QPJEzfUlIhaY0k2LJ5ynHEMG2MARFstLxpnyrgn+PAoxsppZ2
	is2KUQn+E+CvUfJNoNgc7BlMdAOOFLje2fPA32hme6WOyHRK8ga45HsiBwF23ueQPaUyxuRoOFa
	j5b3b+6sgokGGhl4aBOzLWYaHawurU3psn2r4yye/7IrztbQhlE3SlOm6pUCMZp/ttDAVx+SQci
	50VTz5GN3Zkes9gmFvTddVp7AD7Qn/hw+TozcjMiDd8GCN8wLPFizD2k/7P1VHLdUL5TXuiLWQf
	gTGa0BbSSSqOT
X-Google-Smtp-Source: AGHT+IH8iPp7tMkQQNeMbI97hUASF6CgmSyGFZQMn/orSpy+WtvU5PLLAMJCz92VlmbRVP3/NyzfxQ==
X-Received: by 2002:a17:907:7b82:b0:ad8:a4a8:102c with SMTP id a640c23a62f3a-addf8c98f79mr286277766b.11.1749051232082;
        Wed, 04 Jun 2025 08:33:52 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:49bb:abfc:9369:86b1? ([2620:10d:c092:500::7:8931])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c59f81sm8945990a12.18.2025.06.04.08.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 08:33:51 -0700 (PDT)
Message-ID: <e4738330-e6e8-4950-9226-36a5090736a3@gmail.com>
Date: Wed, 4 Jun 2025 16:33:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: support array presets in veristat
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250603141539.86878-1-mykyta.yatsenko5@gmail.com>
 <CAEf4Bzb3=brMXMBZ-AGj8xdr80XEs2Og0XeZ1zuiHnFNWWPJJQ@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4Bzb3=brMXMBZ-AGj8xdr80XEs2Og0XeZ1zuiHnFNWWPJJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/3/25 22:24, Andrii Nakryiko wrote:
> On Tue, Jun 3, 2025 at 7:15 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Implement support for presetting values for array elements in veristat.
>> For example:
>> ```
>> sudo ./veristat set_global_vars.bpf.o -G "struct1[2].struct2[1].u.var_u8[2] = 3" -G "arr[3] = 9"
>> ```
>> Arrays of structures and structure of arrays work, but each individual
>> scalar value has to be set separately: `foo[1].bar[2] = value`.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   .../selftests/bpf/prog_tests/test_veristat.c  |  9 +--
>>   .../selftests/bpf/progs/set_global_vars.c     | 12 ++--
>>   tools/testing/selftests/bpf/veristat.c        | 63 +++++++++++++++++--
>>   3 files changed, 70 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
>> index 47b56c258f3f..1af5d02bb2d0 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
>> @@ -60,12 +60,13 @@ static void test_set_global_vars_succeeds(void)
>>              " -G \"var_s8 = -128\" "\
>>              " -G \"var_u8 = 255\" "\
>>              " -G \"var_ea = EA2\" "\
>> -           " -G \"var_eb = EB2\" "\
>> -           " -G \"var_ec = EC2\" "\
>> +           " -G \"var_eb  =  EB2\" "\
>> +           " -G \"var_ec=EC2\" "\
> What was the problem previously with not handling this case?
%s consumes input until whitespace or end of string, so var=val will be 
written to a single string.
>
>>              " -G \"var_b = 1\" "\
>> -           " -G \"struct1.struct2.u.var_u8 = 170\" "\
>> +           " -G \"struct1[2].struct2[1].u.var_u8[2]=170\" "\
>>              " -G \"union1.struct3.var_u8_l = 0xaa\" "\
>>              " -G \"union1.struct3.var_u8_h = 0xaa\" "\
>> +           " -G \"arr[2] = 0xaa\" "    \
>>              "-vl2 > %s", fix->veristat, fix->tmpfile);
>>
>>          read(fix->fd, fix->output, fix->sz);
> [...]
>
>> @@ -81,8 +80,9 @@ int test_set_globals(void *ctx)
>>          a = var_eb;
>>          a = var_ec;
>>          a = var_b;
>> -       a = struct1.struct2.u.var_u8;
>> +       a = struct1[2].struct2[1].u.var_u8[2];
>>          a = union1.var_u16;
>> +       a = arr[3];
>>
> let's add tests for at least:
>    a) multi-dimensional arrays
>    b) arrays of pointers (that's unlikely to happen in practice, but
> still, we should avoid just messing stuff up silently). We can also
> explicitly error out on pointers, I suppose.
>    c) what about using enums as indices?
>    d) can we have some typedef'ed types both with array-based and
> direct accesses (to validate we skipped typedefs where appropriate)
Should we support multi-dimensional arrays?
How to implement enum indexes, iterate over all btf and check if the 
name equals?
>
> I'd suggest splitting selftests from veristat changes. They are in the
> same selftests/bpf directory, but conceptually they are tool vs tests
> patches, so better kept separate, IMO.
>
> pw-bot: cr
>
>>          return a;
>>   }
>> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
>> index b2bb20b00952..79c5ea6476ca 100644
>> --- a/tools/testing/selftests/bpf/veristat.c
>> +++ b/tools/testing/selftests/bpf/veristat.c
>> @@ -1379,7 +1379,7 @@ static int append_var_preset(struct var_preset **presets, int *cnt, const char *
>>          memset(cur, 0, sizeof(*cur));
>>          (*cnt)++;
>>
>> -       if (sscanf(expr, "%s = %s %n", var, val, &n) != 2 || n != strlen(expr)) {
>> +       if (sscanf(expr, "%[][a-zA-Z0-9_.] = %s %n", var, val, &n) != 2 || n != strlen(expr)) {
>>                  fprintf(stderr, "Failed to parse expression '%s'\n", expr);
>>                  return -EINVAL;
>>          }
>> @@ -1486,6 +1486,39 @@ static bool is_preset_supported(const struct btf_type *t)
>>          return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
>>   }
>>
>> +static int adjust_array_secinfo(const struct btf *btf, const struct btf_type *t,
>> +                               struct btf_var_secinfo *sinfo, const char *var)
>> +{
>> +       struct btf_array *barr;
>> +       const struct btf_type *type;
>> +       char arr[64], idx[64];
>> +       int i = 0, tid;
>> +
>> +       if (!btf_is_array(t))
>> +               return 0;
> this shouldn't be called for non-array, no? if yes, then we should
> either drop unnecessary safety check or error out
>
>> +
>> +       barr = btf_array(t);
>> +       tid = btf__resolve_type(btf, barr->type);
>> +       type = btf__type_by_id(btf, tid);
>> +
>> +       /* var may contain chained expression e.g.: foo[1].bar */
> this feels a bit hacky that we re-parse those string specifiers...
> maybe we should parse them once, prepare some structured
> representation such that the rest of the code can easily check whether
> each access is array or non-array, and have parsed index number for
> arrays
>
>> +       if (sscanf(var, "%[a-zA-Z0-9_][%[a-zA-Z0-9]]", arr, idx) != 2) {
>> +               fprintf(stderr, "Could not parse array expression %s\n", var);
>> +               return -EINVAL;
>> +       }
>> +       errno = 0;
>> +       i = strtol(idx, NULL, 0);
>> +       if (errno || i < 0 || i >= barr->nelems) {
>> +               fprintf(stderr, "Preset index %s is invalid or out of bounds [0, %d]\n",
>> +                       idx, barr->nelems);
>> +               return -EINVAL;
>> +       }
>> +       sinfo->size = type->size;
> hm... what if type is another array? we need to calculate the size
> properly, not just take type->size directly. Or what if it's a pointer
> type and type->size is actually type->type?
Is type an another array in case of multidimensional arrays?
>> +       sinfo->type = tid;
>> +       sinfo->offset += i * type->size;
>> +       return 0;
>> +}
>> +
>>   const int btf_find_member(const struct btf *btf,
>>                            const struct btf_type *parent_type,
>>                            __u32 parent_offset,
>> @@ -1493,7 +1526,7 @@ const int btf_find_member(const struct btf *btf,
>>                            int *member_tid,
>>                            __u32 *member_offset)
>>   {
>> -       int i;
>> +       int i, err;
>>
>>          if (!btf_is_composite(parent_type))
>>                  return -EINVAL;
>> @@ -1511,8 +1544,12 @@ const int btf_find_member(const struct btf *btf,
>>                  member_type = btf__type_by_id(btf, tid);
>>                  if (member->name_off) {
>>                          const char *name = btf__name_by_offset(btf, member->name_off);
>> +                       int name_len = strlen(name);
>>
>> -                       if (strcmp(member_name, name) == 0) {
>> +                       if (strcmp(member_name, name) == 0 ||
>> +                           (btf_is_array(member_type) &&
>> +                            strncmp(name, member_name, name_len) == 0 &&
>> +                            member_name[name_len] == '[')) {
> It looks like you are trying to do too much here at the same time...
> Why not handle array case separately and explicitly? And we can
> provide a nice message if array vs non-array access is detected
>
> Let's also restructure btf_find_member loop logic a bit to reduce nestedness:
>
> const char *name = ...;
>
> if (name[0] == '\0' && btf_is_composite(...)) { /* anon struct/union */
>      /* recur btf_find_member in hope to find a match */
>      ...
> } else if (name[0] && btf_is_array(member_type)) {
>      /* if member_name is *NOT* blah[something] - nice error, exit with
> -EINVAL */
>      ... new array element-specific logic
> } else if (name[0]) {
>      /* if member_name *IS* blah[something] - nice error, exit with -EINVAL */
>      ... old logic ...
> }
>
>
> BTW, we should probably use -ESRCH to specify "we didn't find match"
> (and that's ok, we keep backtracking) vs -EINVAL due to array vs
> non-array mismatch or bitfield usage. The latter are real error
> conditions, while the former should be silently ignored.
>
>
>>                                  if (btf_member_bitfield_size(parent_type, i) != 0) {
>>                                          fprintf(stderr, "Bitfield presets are not supported %s\n",
>>                                                  name);
>> @@ -1520,6 +1557,16 @@ const int btf_find_member(const struct btf *btf,
>>                                  }
>>                                  *member_offset = parent_offset + member->offset;
>>                                  *member_tid = tid;
>> +                               if (btf_is_array(member_type)) {
>> +                                       struct btf_var_secinfo sinfo = {.offset = 0};
>> +
>> +                                       err = adjust_array_secinfo(btf, member_type,
>> +                                                                  &sinfo, member_name);
>> +                                       if (err)
>> +                                               return err;
>> +                                       *member_tid = sinfo.type;
>> +                                       *member_offset += sinfo.offset * 8;
>> +                               }
>>                                  return 0;
>>                          }
>>                  } else if (btf_is_composite(member_type)) {
>> @@ -1548,6 +1595,13 @@ static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
>>          snprintf(expr, sizeof(expr), "%s", var);
>>          strtok_r(expr, ".", &saveptr);
>>
>> +       if (btf_is_array(base_type)) {
>> +               err = adjust_array_secinfo(btf, base_type, sinfo, var);
>> +               if (err)
>> +                       return err;
>> +               base_type = btf__type_by_id(btf, sinfo->type);
>> +       }
>> +
>>          while ((name = strtok_r(NULL, ".", &saveptr))) {
>>                  err = btf_find_member(btf, base_type, 0, name, &member_tid, &member_offset);
>>                  if (err) {
>> @@ -1673,7 +1727,8 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
>>
>>                                  if (strncmp(var_name, presets[k].name, var_len) != 0 ||
>>                                      (presets[k].name[var_len] != '\0' &&
>> -                                    presets[k].name[var_len] != '.'))
>> +                                    presets[k].name[var_len] != '.' &&
>> +                                    presets[k].name[var_len] != '['))
>>                                          continue;
>>
>>                                  if (presets[k].applied) {
>> --
>> 2.49.0
>>


