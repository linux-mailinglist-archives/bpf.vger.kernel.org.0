Return-Path: <bpf+bounces-61406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D08AE6CF7
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 18:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF7D6A1EC0
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 16:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1542E6D11;
	Tue, 24 Jun 2025 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxeCCtqN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9842E610B
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783739; cv=none; b=jZvZxC1uZmm0Eq1MdoQfiDtcEsNE6Rycw6H7brEIV/qSt5QGV09O5yVrWa1dk12IApV55VEkzaq7sa2WymcQOKEK74noG6pz3T0yTvDCpV+Hp2AfEaaT9gV3iOoksP1IJ3hToyTqXsffcOYiCQNaWPba/469cYauHpFQVZPufEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783739; c=relaxed/simple;
	bh=5SSg8P7p1TEHCuL3avhxegrv7HLOU643GdlYEwMebyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxpQLj6B9Ent3oXNCcQFcqQfB0/udvwYtjPxKTfh+yA8eh9X0eIIryB0EF8EO9Ywf6ZsuBwWzlXHM+YoxXzZ1UKXDe/mypWTL2wZDYO3Ao4DUjL7VJgeH47p81jeZ8/1EZHHYgWpbUtBksuGuF212cT2tY2Q2UzO1KipztjJHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxeCCtqN; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-adb2e9fd208so115603666b.3
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 09:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750783736; x=1751388536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2SFGHN/n+CW9mG7m9+Nx8UJ4OEE2jt5GMBV1lHFRBFY=;
        b=fxeCCtqNuUzIszxuMGpu82fGxQM/1qeph086E2v54B7ABmvN76PToB3NDdcR+z76jc
         pNnhZgD7xywko4bg7lI6iU1KOqk+vP5st4GHOEidLNN9t41iznkKJrK1uJ/VZgg9v219
         SKQqIjtM94tZx9ImegOn6eE7gwKuYeB4jtZIh4ftCkTirubAKWvKBQhdU3LWySq2h4k6
         Ms/1/d+Nj10Y28XR2ZwajyX5QwnVaPtK2K2u+zIVphSd712h8zNbgLV7JzPnGYrNpWYp
         K/YavauP7UruI3gVrRKC27zQPteimE6KhHC56uxvsng9D/YnnJG46IMyvx6eBY56cX68
         A2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750783736; x=1751388536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SFGHN/n+CW9mG7m9+Nx8UJ4OEE2jt5GMBV1lHFRBFY=;
        b=B9zoHP9m2Vdh4q2L7YeitcCIogECUjwO7+5GvyG0+DL1iMxXj8m2YnwkvVxtEkMcwV
         Qmdn+u7+N9KCaNJoF6mbFWzsGYfPkbsIxRKYSebBxYR4IDY7nnAg9+NmlyHzj6jt4Rrg
         4Hcz86rvvndnL8OXjEPfsSF5oVR1XFYR5no5U1S5hpHXAHVVHv4j99SEZVPzGXr/YzE5
         f2Rvv7sBFTrAnQcT8M4/iE3cdSU75E2IsjdCpEJWiyfOseg8A86U3B4Z7r6u63XjhLsy
         iDUrmz8kkh/ddFkYbuDTJuVGEg3pDGxb44BN2q1ayQS0SmiYCtFYJEsH+DZHHFqGAhNQ
         YDRg==
X-Gm-Message-State: AOJu0YyUTElIcSgmwyO6URzadozPkPVXs1QUy5Ka5QPyWZsrjaYcPHS0
	tLdQnYyB0EFQv+hXl1Be8pwheb5EU8mVPZ7Ip7pOR1rniuU0yRDTGfpUKSnflfK1
X-Gm-Gg: ASbGncv2c8+s7MVmZKyVKlyjuWw7iORGtGptJ3E/z/QsYFVEdIJeSju0ZXDqJliBrKK
	w0BPRlAWzFmQYfmQeyuAv+x83bcMKnO+5OGsxy2IcZGXiGx43eneJ1VTVaoxcf91o04h+Gyasu1
	QJZ73gDWfserilgFazCXcalY7WEIxvGYhushHCvD2rFUVfa1OefC1JtE7iqWrkfYOpAjlYup3hP
	k2TSQfiEhLiOORsVyvwZlqngJnGsqh2QN0aYv4JDMB/FbrIcUobH4nK/fkIHFhUDVrZMj1l0/WC
	vyCXqWtz2OISTOVr7OualIthgi3w2r8GYw45S+SaANU24msmBRNx16dL3M99z2BhSmtlwhScaR8
	ReWaqWJLMu9U1D6XhZ1i/Pw==
X-Google-Smtp-Source: AGHT+IHAYMA3CHMuikKtIFrt/VJjpgixw63QCe98IfGBhub8TDBfL2h7tHEJ/9Zp+K6lPOnkELe5Sg==
X-Received: by 2002:a17:907:97d0:b0:adb:41e4:8c73 with SMTP id a640c23a62f3a-ae0bea3877amr41366b.55.1750783735523;
        Tue, 24 Jun 2025 09:48:55 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:534:a736:198c:eb59? ([2620:10d:c092:500::7:7a21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541bddc3sm900901366b.135.2025.06.24.09.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 09:48:55 -0700 (PDT)
Message-ID: <2ad1783d-2fc2-4dbd-bbea-0ff727764148@gmail.com>
Date: Tue, 24 Jun 2025 17:48:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: support array presets in
 veristat
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250618203903.539270-1-mykyta.yatsenko5@gmail.com>
 <20250618203903.539270-3-mykyta.yatsenko5@gmail.com>
 <CAEf4BzY8zDf4oZL=manmc_KsZpL8meC_m1jvp4EZ8MKnpkvFgQ@mail.gmail.com>
 <c05071fd-3e41-43ac-b1ff-1c002a107b24@gmail.com>
 <CAEf4BzbGvceJoCsa_PjjVOPY-CQ=uDW0EK4Vgdc+uSBrh5gNGQ@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzbGvceJoCsa_PjjVOPY-CQ=uDW0EK4Vgdc+uSBrh5gNGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/24/25 16:59, Andrii Nakryiko wrote:
> On Mon, Jun 23, 2025 at 5:00 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> On 6/23/25 23:10, Andrii Nakryiko wrote:
>>> On Wed, Jun 18, 2025 at 1:39 PM Mykyta Yatsenko
>>> <mykyta.yatsenko5@gmail.com> wrote:
>>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>>
>>>> Implement support for presetting values for array elements in veristat.
>>>> For example:
>>>> ```
>>>> sudo ./veristat set_global_vars.bpf.o -G "arr[3] = 1"
>>>> ```
>>>> Arrays of structures and structure of arrays work, but each individual
>>>> scalar value has to be set separately: `foo[1].bar[2] = value`.
>>>>
>>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>>> ---
>>>>    tools/testing/selftests/bpf/veristat.c | 226 ++++++++++++++++++++-----
>>>>    1 file changed, 180 insertions(+), 46 deletions(-)
>>>>
>>> [...]
>>>
>>>> +static int resolve_rvalue(struct btf *btf, const struct rvalue *rvalue, long long *result)
>>>> +{
>>>> +       int err = 0;
>>>> +
>>>> +       switch (rvalue->type) {
>>>> +       case INTEGRAL:
>>>> +               *result = rvalue->ivalue;
>>> return 0;
>>>
>>>> +               break;
>>>> +       case ENUMERATOR:
>>>> +               err = find_enum_value(btf, rvalue->svalue, result);
>>>> +               if (err)
>>>> +                       fprintf(stderr, "Can't resolve enum value %s\n", rvalue->svalue);
>>> if (err) {
>>>       fprintf(...);
>>>       return err;
>>> }
>>>
>>> return 0;
>>>
>>> ?
>>>
>>>> +               break;
>>> default: fprintf("unknown blah"); return -EOPNOTSUPP;
>>>
>>>
>>> I think I had a similar argument with Eduard before, so I'll explain
>>> my logic here again. Whenever you have some branching in your code and
>>> you know that branch's processing is effectively done and the only
>>> thing left is to return success/failure signal, *do return early* and
>>> explicitly ASAP (unless there is non-trivial clean up for error path,
>>> in which case not duplicating and spreading clean up logic outweighs
>>> the simplicity of early return code). Otherwise it takes *unnecessary*
>>> extra mental effort to trace through the rest of the code to make sure
>>> there is no extra common post-processing logic after that
>>> branch/switch/for loop.
>>>
>>> So if we know the INTEGRAL case is a success, then have `return 0;`
>>> right there, don't make anyone read through the rest of the function
>>> just to make sure we don't do anything extra.
>> I understand early returns, just in this case ditched it to make the
>> code more compact.
>> I'll change this.
>>>> +       }
>>>> +       return err;
>>>> +}
>>>> +
>>>> +/* Returns number of consumed atoms from preset, negative error if failed */
>>>> +static int adjust_var_secinfo_array(struct btf *btf, int tid, struct var_preset *preset,
>>>> +                                   int atom_idx, struct btf_var_secinfo *sinfo)
>>>> +{
>>>> +       struct btf_array *barr;
>>>> +       int i = atom_idx, err;
>>>> +       const struct btf_type *t;
>>>> +       long long off = 0, idx;
>>>> +
>>>> +       if (atom_idx < 1) /* Array index can't be the first atom */
>>> can atom_idx be -1 or negative? If not, then do `if (atom_idx == 0)`.
>>> It's another small mental overhead that we can easily avoid, and so we
>>> should.
>> sure
>>>> +               return -EINVAL;
>>>> +
>>>> +       tid = btf__resolve_type(btf, tid);
>>>> +       t = btf__type_by_id(btf, tid);
>>>> +       if (!btf_is_array(t)) {
>>>> +               fprintf(stderr, "Array index is not expected for %s\n",
>>>> +                       preset->atoms[atom_idx - 1].name);
>>>> +               return -EINVAL;
>>>> +       }
>>> [...]
>>>
>>>> @@ -1815,26 +1938,29 @@ const int btf_find_member(const struct btf *btf,
>>>>    static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
>>>>                                 struct btf_var_secinfo *sinfo, struct var_preset *preset)
>>>>    {
>>>> -       const struct btf_type *base_type, *member_type;
>>>> -       int err, member_tid, i;
>>>> -       __u32 member_offset = 0;
>>>> -
>>>> -       base_type = btf__type_by_id(btf, btf__resolve_type(btf, t->type));
>>>> -
>>>> -       for (i = 1; i < preset->atom_count; ++i) {
>>>> -               err = btf_find_member(btf, base_type, 0, preset->atoms[i].name,
>>>> -                                     &member_tid, &member_offset);
>>>> -               if (err) {
>>>> -                       fprintf(stderr, "Could not find member %s for variable %s\n",
>>>> -                               preset->atoms[i].name, preset->atoms[i - 1].name);
>>>> -                       return err;
>>>> +       const struct btf_type *base_type;
>>>> +       int err, i = 1, n;
>>>> +       int tid;
>>>> +
>>>> +       tid = btf__resolve_type(btf, t->type);
>>>> +       base_type = btf__type_by_id(btf, tid);
>>>> +
>>>> +       while (i < preset->atom_count) {
>>>> +               if (preset->atoms[i].type == ARRAY_INDEX) {
>>>> +                       n = adjust_var_secinfo_array(btf, tid, preset, i, sinfo);
>>>> +                       if (n < 0)
>>>> +                               return n;
>>>> +                       i += n;
>>>> +               } else {
>>>> +                       err = btf_find_member(btf, base_type, 0, preset->atoms[i].name, sinfo);
>>>> +                       if (err)
>>>> +                               return err;
>>>> +                       i++;
>>>>                   }
>>>> -               member_type = btf__type_by_id(btf, member_tid);
>>>> -               sinfo->offset += member_offset / 8;
>>>> -               sinfo->size = member_type->size;
>>>> -               sinfo->type = member_tid;
>>>> -               base_type = member_type;
>>>> +               base_type = btf__type_by_id(btf, sinfo->type);
>>>> +               tid = sinfo->type;
>>>>           }
>>>> +
>>>>           return 0;
>>>>    }
>>> Is there a good reason to have adjust_var_secinfo() separate from
>>> adjust_var_secinfo_array(). I won't know if I didn't miss anything
>>> non-obvious, but in my mind this whole adjust_var_sec_info() should
>>> look roughly like this:
>>>
>>> cur_type = /* resolve from original var */
>>> cur_off = 0;
>>>
>>> for (i = 0; i < preset->atom_count; i++) {
>>>       if (preset->atoms[i].type == ARRAY_INDEX) {
>>>           /* a) error checking: cur_type should be array */
>>>           /* b) resolve index (if it's enum)
>>>           /* c) error checking: index should be within bounds of
>>> cur_type (which is ARRAY)
>>>           /* d) adjust cur_off += cur_type's elem_size * index_value
>>>           /* e) cur_type = btf__resolve_type(cur_type->type) */
>>>       } else {
>>>           /* a) error checking: cur_type should be struct/union */
>>>           /* b) find field by name with btf_find_member */
>>>           /* c) cur_off += member_offset */
>>>           /* d) cur_type = btf__resolve_type(field->type) */
>>>       }
>>> }
>>>
>>> It seems inelegant that we have an outer loop over FIELD references
>>> (one at a time), but for ARRAY_INDEX we do N items skipping. Why? We
>>> have a set of "instructions", just execute them one at a time, and
>>> keep track of the current type and current offset we are at.
>>>
>>> Is there anything I am missing that would prevent this simple and more
>>> uniform approach?
>> yes, I think there is a small detail - `cur_type's elem_size`is not easy
>> to get for multi-dim array.
>> If we have 3 dim array `arr` of NxMxK, to find an index of
>> `arr[x][y][z]` we calculate `(x*M + y)*K + z`
>> This formula is tricky to integrate in the above loop an offset of the
>> current element depends on the next
>> `btf_arr`s. Though, I can see a couple of ways to do it:
>> 1) Look forward for the next array dimensions to multiply with current
>> index: `x*M*K +  y*K + z`.
> does it really matter if it's multi-dimenstional array or
> single-dimensional? In both cases you calculate the size of on array
> element (which for multi-dimensional will be another array with
> outermost dimension stripped, and in BTF that's a separate type
> referenced by array->type BTF ID), and multiply it by the index.
>
> So let's say you have
>
> struct my_struct {int x, y;};
>
> struct my_struct arr[10];
>
> And trying to calculate arr[5] offset (without yet going inside
> my_struct, one step only). You'll add 5 * sizeof(arr[0]) -> 5 * 8 = 40
> bytes.
>
> Now, let's say you have
>
> int arr[10][20];
>
> And you are processing the outermost array indexing step in arr[5][7].
> Here you'll adjust offset by 5 * sizeof(arr[0]) -> 5 * sizeof(int[20])
> -> 5 * 20 * 4 = 80 bytes.
>
> In both cases you can just use btf__resolve_size() on
> btf_array(cur_type)->type to get the size of the array's element.
>
> Would that work?
yeah, `btf__resolve_type_size` will do, did not know it exists.
Eduard mentioned that it would be great to have something like
btf__type_physical_size, apparently we do have it.
>> 2) Have a separate `array_off` variable, that will be multiplied with
>> current dimension and then zeroed when atom is non-array index:
>> ```
>>     array_off = 0;
>>     array_off *= N; array_off += x;
>>     array_off *= M; array_off += y;
>>     array_off *= K; array_off += z;
>> ...
>>      off += array_off; array_off = 0;
>> ```
>> I picked an option 2, but moved it into the separate function to make
>> things a little bit simpler.
>>> [...]


