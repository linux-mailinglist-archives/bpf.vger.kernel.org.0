Return-Path: <bpf+bounces-61328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B85AE583D
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 02:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C4F1B600DA
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 00:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8227C1E519;
	Tue, 24 Jun 2025 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWz5H5i4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D861179A3
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750723228; cv=none; b=hhFqs2M08tNsjfrf9eLxgPDAHFXaOcAF4hIAzrJe+x8VsqpanrABO/L4PvACm8gN6F/I3IjL1FNQcwBoT4RAMUykAABOvPuZN5rRikrv4JJwhQStnTinej7pm72+Bn7rfZxgj2S3VZGeuwedy2lh2PrjQgetyGBZ2I0NVmnjp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750723228; c=relaxed/simple;
	bh=4lSh4J76y7BBtHf521PCkH3HMoKDppUoHinPELV6tB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjAGFIik/rmYrfhSCZYxCnhPNp3XsqW26LGYmANXsr/xi4MXiJMGgwEAeW3SKYVMvontosF3PVi9WFOQbnRPFXKgn1h4ju1NvOE+nvurJfFOmnTneOAoPPtnKooL8QFrb22bclr2VXd30SbFsnSHUITKkRFyTpWlyN3Zx3gtE5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWz5H5i4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a365a6804eso2566117f8f.3
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 17:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750723224; x=1751328024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SjJnY/Gtzsl7gs6ZtcqnNvgBILy8O/Km/B0eRd//6kI=;
        b=FWz5H5i4GTjuUN/cmAALmoU/AWUgLuHXGtBcVFIaFJEWYh5dpzcvxjc5VgJBZ6bNj1
         0qwZrUpkyFRmaWqzLWUJm7u/GkzMz8nSUcthVrSrhbAfnoJ01KdcxzRHGNnR4nWun2SC
         z3olrwDi/F3CoEas+Pvt8Bp2AyiQGGSsuE8+xptlspl7UTedtZPWw8N5TadFfDE9V2Dn
         wr6nob+JINkJMjFtEfZvuAE4M7fUSdT2nXoLPbxKOr4V6CkybYr7QGqHE0wYU9+gLwlo
         wuXmmzIkQ5AaBCJSqKx7yo/q1gi2A78vyrr7HsACoa74q05KwnEJCul+lSypRj2oo0KR
         w99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750723224; x=1751328024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjJnY/Gtzsl7gs6ZtcqnNvgBILy8O/Km/B0eRd//6kI=;
        b=k1dQnYXAxj11iQ4Pwk2P4630Hx4NyQ81FCHSd2TWqWYuy/8h60+riE6yj7fp3Iwvhw
         1BZNgU2EBhlBGEAbX3PKan9ErK8b1q21rzZn+CUmsrw6GjuPxpT7IY0+F2vJ1uPr5VBH
         +iqYNZYA+0JmNPcsSopJUgHAqrcSYSc97/XRNBx2VyF74Td292EKcN281QW5KTtwsPmX
         LMKkBXIIvQP9ZXAluYZR3Vivn9itGX5yXDmBGJZtqTQU0b6tI+TRNZaTtzUW+3AuLHUg
         Af2vA+oxDCQC/lAxXDXSiArH07QwkB91cUOe5VYgv1g2J+NxXcQ3vLGGT9lNDaqAcJ0v
         bGNg==
X-Gm-Message-State: AOJu0YxFlJ/XlnbeF2W4UaG+CxH2Txmafazjk4tTcLlxbbeihrh5yNGF
	puShhNypepGYnGdDkXWMOYA9XOe8wz39kq/DdEZjElU9giHNj9oaEqI+rfm3gA==
X-Gm-Gg: ASbGncvfNTPXNSYq3TATeJ2ae9kb1VTAfPGZstIDCJkAun6EAN2cWQ0u6wL5RC90H2C
	0CT2DeBkWSVhwYpcCtU1UblZ517dxI2Ff7EnkPpMivoGzSSqlR7ZCDEgfmWl+nA6xGjisEF5lfv
	Yri4ipCeG64yanX08guIw7eAeb++R/5f7JMyOZgotlekrcPj7FTJzkp4lX8PnO+mlKvyjhA/2gH
	jBF5HcHdEVLXPN7TH1gthjOPnmIQbZTDcK8El+1Tksnsr+9qUzJuEqG7SQ7M4or5k9FdXyEajB8
	2NGZZFtIOTsHGJy+9WNIOfR1yyzg0536uaxQII9HXm7FNzZJ58LbSGgU5XjfB0Ww8kh52ZFlAXb
	2fg5B0JIuIZyOiVxMpKvvxi+jTNDpQfwq6xJHUdLrHc0axg==
X-Google-Smtp-Source: AGHT+IELMfEFpr6CpGDyTbjSRb2ydfqazpbaKlYp8LVnP7FklO9Lu1Qi01LCwmxBrrgPnrbKxM1A8Q==
X-Received: by 2002:a05:6000:1a8f:b0:3a5:5298:ce28 with SMTP id ffacd0b85a97d-3a6d12fb253mr12017642f8f.4.1750723224093;
        Mon, 23 Jun 2025 17:00:24 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9? ([2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8051018sm443825f8f.16.2025.06.23.17.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 17:00:23 -0700 (PDT)
Message-ID: <c05071fd-3e41-43ac-b1ff-1c002a107b24@gmail.com>
Date: Tue, 24 Jun 2025 01:00:23 +0100
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
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzY8zDf4oZL=manmc_KsZpL8meC_m1jvp4EZ8MKnpkvFgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/23/25 23:10, Andrii Nakryiko wrote:
> On Wed, Jun 18, 2025 at 1:39 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Implement support for presetting values for array elements in veristat.
>> For example:
>> ```
>> sudo ./veristat set_global_vars.bpf.o -G "arr[3] = 1"
>> ```
>> Arrays of structures and structure of arrays work, but each individual
>> scalar value has to be set separately: `foo[1].bar[2] = value`.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/testing/selftests/bpf/veristat.c | 226 ++++++++++++++++++++-----
>>   1 file changed, 180 insertions(+), 46 deletions(-)
>>
> [...]
>
>> +static int resolve_rvalue(struct btf *btf, const struct rvalue *rvalue, long long *result)
>> +{
>> +       int err = 0;
>> +
>> +       switch (rvalue->type) {
>> +       case INTEGRAL:
>> +               *result = rvalue->ivalue;
> return 0;
>
>> +               break;
>> +       case ENUMERATOR:
>> +               err = find_enum_value(btf, rvalue->svalue, result);
>> +               if (err)
>> +                       fprintf(stderr, "Can't resolve enum value %s\n", rvalue->svalue);
> if (err) {
>      fprintf(...);
>      return err;
> }
>
> return 0;
>
> ?
>
>> +               break;
> default: fprintf("unknown blah"); return -EOPNOTSUPP;
>
>
> I think I had a similar argument with Eduard before, so I'll explain
> my logic here again. Whenever you have some branching in your code and
> you know that branch's processing is effectively done and the only
> thing left is to return success/failure signal, *do return early* and
> explicitly ASAP (unless there is non-trivial clean up for error path,
> in which case not duplicating and spreading clean up logic outweighs
> the simplicity of early return code). Otherwise it takes *unnecessary*
> extra mental effort to trace through the rest of the code to make sure
> there is no extra common post-processing logic after that
> branch/switch/for loop.
>
> So if we know the INTEGRAL case is a success, then have `return 0;`
> right there, don't make anyone read through the rest of the function
> just to make sure we don't do anything extra.
I understand early returns, just in this case ditched it to make the 
code more compact.
I'll change this.
>> +       }
>> +       return err;
>> +}
>> +
>> +/* Returns number of consumed atoms from preset, negative error if failed */
>> +static int adjust_var_secinfo_array(struct btf *btf, int tid, struct var_preset *preset,
>> +                                   int atom_idx, struct btf_var_secinfo *sinfo)
>> +{
>> +       struct btf_array *barr;
>> +       int i = atom_idx, err;
>> +       const struct btf_type *t;
>> +       long long off = 0, idx;
>> +
>> +       if (atom_idx < 1) /* Array index can't be the first atom */
> can atom_idx be -1 or negative? If not, then do `if (atom_idx == 0)`.
> It's another small mental overhead that we can easily avoid, and so we
> should.
sure
>
>> +               return -EINVAL;
>> +
>> +       tid = btf__resolve_type(btf, tid);
>> +       t = btf__type_by_id(btf, tid);
>> +       if (!btf_is_array(t)) {
>> +               fprintf(stderr, "Array index is not expected for %s\n",
>> +                       preset->atoms[atom_idx - 1].name);
>> +               return -EINVAL;
>> +       }
> [...]
>
>> @@ -1815,26 +1938,29 @@ const int btf_find_member(const struct btf *btf,
>>   static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
>>                                struct btf_var_secinfo *sinfo, struct var_preset *preset)
>>   {
>> -       const struct btf_type *base_type, *member_type;
>> -       int err, member_tid, i;
>> -       __u32 member_offset = 0;
>> -
>> -       base_type = btf__type_by_id(btf, btf__resolve_type(btf, t->type));
>> -
>> -       for (i = 1; i < preset->atom_count; ++i) {
>> -               err = btf_find_member(btf, base_type, 0, preset->atoms[i].name,
>> -                                     &member_tid, &member_offset);
>> -               if (err) {
>> -                       fprintf(stderr, "Could not find member %s for variable %s\n",
>> -                               preset->atoms[i].name, preset->atoms[i - 1].name);
>> -                       return err;
>> +       const struct btf_type *base_type;
>> +       int err, i = 1, n;
>> +       int tid;
>> +
>> +       tid = btf__resolve_type(btf, t->type);
>> +       base_type = btf__type_by_id(btf, tid);
>> +
>> +       while (i < preset->atom_count) {
>> +               if (preset->atoms[i].type == ARRAY_INDEX) {
>> +                       n = adjust_var_secinfo_array(btf, tid, preset, i, sinfo);
>> +                       if (n < 0)
>> +                               return n;
>> +                       i += n;
>> +               } else {
>> +                       err = btf_find_member(btf, base_type, 0, preset->atoms[i].name, sinfo);
>> +                       if (err)
>> +                               return err;
>> +                       i++;
>>                  }
>> -               member_type = btf__type_by_id(btf, member_tid);
>> -               sinfo->offset += member_offset / 8;
>> -               sinfo->size = member_type->size;
>> -               sinfo->type = member_tid;
>> -               base_type = member_type;
>> +               base_type = btf__type_by_id(btf, sinfo->type);
>> +               tid = sinfo->type;
>>          }
>> +
>>          return 0;
>>   }
> Is there a good reason to have adjust_var_secinfo() separate from
> adjust_var_secinfo_array(). I won't know if I didn't miss anything
> non-obvious, but in my mind this whole adjust_var_sec_info() should
> look roughly like this:
>
> cur_type = /* resolve from original var */
> cur_off = 0;
>
> for (i = 0; i < preset->atom_count; i++) {
>      if (preset->atoms[i].type == ARRAY_INDEX) {
>          /* a) error checking: cur_type should be array */
>          /* b) resolve index (if it's enum)
>          /* c) error checking: index should be within bounds of
> cur_type (which is ARRAY)
>          /* d) adjust cur_off += cur_type's elem_size * index_value
>          /* e) cur_type = btf__resolve_type(cur_type->type) */
>      } else {
>          /* a) error checking: cur_type should be struct/union */
>          /* b) find field by name with btf_find_member */
>          /* c) cur_off += member_offset */
>          /* d) cur_type = btf__resolve_type(field->type) */
>      }
> }
>
> It seems inelegant that we have an outer loop over FIELD references
> (one at a time), but for ARRAY_INDEX we do N items skipping. Why? We
> have a set of "instructions", just execute them one at a time, and
> keep track of the current type and current offset we are at.
>
> Is there anything I am missing that would prevent this simple and more
> uniform approach?
yes, I think there is a small detail - `cur_type's elem_size`is not easy 
to get for multi-dim array.
If we have 3 dim array `arr` of NxMxK, to find an index of 
`arr[x][y][z]` we calculate `(x*M + y)*K + z`
This formula is tricky to integrate in the above loop an offset of the 
current element depends on the next
`btf_arr`s. Though, I can see a couple of ways to do it:
1) Look forward for the next array dimensions to multiply with current 
index: `x*M*K +  y*K + z`.
2) Have a separate `array_off` variable, that will be multiplied with 
current dimension and then zeroed when atom is non-array index:
```
   array_off = 0;
   array_off *= N; array_off += x;
   array_off *= M; array_off += y;
   array_off *= K; array_off += z;
...
    off += array_off; array_off = 0;
```
I picked an option 2, but moved it into the separate function to make 
things a little bit simpler.
>
> [...]


