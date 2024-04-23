Return-Path: <bpf+bounces-27498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3923E8ADC05
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 04:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FED1F2298A
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 02:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B31717C67;
	Tue, 23 Apr 2024 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1WA2hCT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5781095B
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713840353; cv=none; b=JXHMqvrZy0IfNU1QNAm8ZAu0ftjV0ATz2MZcUlF1NK6nEr9CdfXbKL4QLyuE8p91/eeTKA+zK+5jBlVnlsyN1a0tiu4pm9H/chQNsjUnX54L/g/YwA6IkeEFUUV9ouz1Qpk3DC9Yr9nPBpzWeEFduD6S7S6eNYxy3mPb6xYeBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713840353; c=relaxed/simple;
	bh=+V/Xb9o+U41FQpFly1vo3VExsw4Y79jyiOujzov3de8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXaHnb9fHr3n8b0sBfGIfz1ZFnpYe2iw5Jkv/V/QQx9stnognQE6Fg8E2lwvAGentDK+0u4bU5Z32vGX6C+Pw8/A5ecTF5edP3ByUaNzJxa4k9liOfmcaS1RqtqMh876Hr1HNcOjHyibHIuCQWRooB0/8alesSy70ZDI9AhcTxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1WA2hCT; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-22ec61aaf01so2198611fac.2
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 19:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713840351; x=1714445151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9J9vR+xWsici3rqcCMkw96N4Ux3kzQhvLesPL3Jusw=;
        b=C1WA2hCTQfYNLnKa7/GWeeSeRoKrJJAijTlVHijWa2WfB/ieKhnOyIztE5V/oNYAln
         yOqKNTOOFc8wTh12BG6f5cuRW1yzExubCMxvRZtZhiMQqQoWfXASVRxlWmO+JDZzedR9
         ebzpSHo7iMACckrVFUUsbCFI3PNAy4+i2arRkXNdrRBLAV0TVr/gE5eP6nt/f0CUrQlk
         sDuNfcjoUP9OixgN+xqrq2UFfWrCKMUqn3/u5fyDXeW5fI3PglNBZNdM2N5LX++HX8Qq
         RlqVXVNrOXjciTZ+ObIxbaHc2SBq6NStemxMcqHUcjyHNFWCzod7IUYvdp++RqVeGa6e
         7jNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713840351; x=1714445151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9J9vR+xWsici3rqcCMkw96N4Ux3kzQhvLesPL3Jusw=;
        b=lkIL7dIWy7pWFc0lTx2l5JBYRNEs0N9DE/tF84tly61z5kHl1GcWmdQXE+ExCiNgsh
         FaMo+2M6mHtjfyWRIQothLrqHUVWN7RPxgHAKYSZuzes1PoTg6Oip2U74p60OM7UHgyA
         YXjNYw36LkapFFKskOLiIt61+uV4BP/NLX/DHQs95QUGgpF5/+REQY8Tm8Ki2k0rwDkY
         R/U9wfBBF24virOpSkbPTrl8clWqJxLxiTb/o2j6dLR3nOUYAWRHRmXK7phb0MKNBwtT
         Km6cKoO/HY+6sjmXNz3mGfqaanPa3nztDGDpGxcqO6Nsez7zx5qpJ6aDTIooXyhTsrCG
         8cCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb1Xg/ESDPlkaveYaquq/g3/p5SlV3/HlX/cxew/MK+zAiXTH0TTQVtoQqhxfHqvJ2eLxtV6MOKmt3/abTPBsgUwdB
X-Gm-Message-State: AOJu0YzPThw5D928Al4N+BvBN8PRIcC1tva+vNop9miWHXOLGdmnWdMO
	So5u7wabFVKVnFThyjdwnWIBFW6cm5s2SPRoJebjFY+JePP8ggC6Rkv6aQ==
X-Google-Smtp-Source: AGHT+IGkrI1XEoNLBmN8n5trUj0wgrMQucd9IpasD6GkzTaXa6r0ApKukLhmfvuE429dlbouitktVA==
X-Received: by 2002:a05:6870:7254:b0:229:e38e:cd8 with SMTP id y20-20020a056870725400b00229e38e0cd8mr13537882oaf.26.1713840350683;
        Mon, 22 Apr 2024 19:45:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:70f9:8463:f3b1:c282? ([2600:1700:6cf8:1240:70f9:8463:f3b1:c282])
        by smtp.gmail.com with ESMTPSA id ca23-20020a056830611700b006eb7d98bcf0sm1885169otb.21.2024.04.22.19.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 19:45:50 -0700 (PDT)
Message-ID: <57b4d1ca-a444-4e28-9c22-9b81c352b4cb@gmail.com>
Date: Mon, 22 Apr 2024 19:45:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 00/11] Enable BPF programs to declare arrays
 of kptr, bpf_rb_root, and bpf_list_head.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Kui-Feng Lee <kuifeng@meta.com>
References: <20240412210814.603377-1-thinker.li@gmail.com>
 <CAADnVQKP4HESABxxjKXqkyAEC4i_yP7_CT+L=+vzOhnMr5LiXg@mail.gmail.com>
 <1ce45df0-4471-4c0c-b37e-3e51b77fa5b5@gmail.com>
 <CAADnVQKjGFdiy4nYTsbfH5rm7T9gt_VhHd3R+0s4yS9eqTtSaA@mail.gmail.com>
 <6d25660d-103a-4541-977f-525bd2d38cd0@gmail.com>
 <CAADnVQ+hGv0oVx4_uPs2yr=vWC80OEEXLm_FcZLBfsthu0yFbA@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQ+hGv0oVx4_uPs2yr=vWC80OEEXLm_FcZLBfsthu0yFbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/18/24 07:53, Alexei Starovoitov wrote:
> On Wed, Apr 17, 2024 at 11:07 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 4/17/24 22:11, Alexei Starovoitov wrote:
>>> On Wed, Apr 17, 2024 at 9:31 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 4/17/24 20:30, Alexei Starovoitov wrote:
>>>>> On Fri, Apr 12, 2024 at 2:08 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>>>>>
>>>>>> The arrays of kptr, bpf_rb_root, and bpf_list_head didn't work as
>>>>>> global variables. This was due to these types being initialized and
>>>>>> verified in a special manner in the kernel. This patchset allows BPF
>>>>>> programs to declare arrays of kptr, bpf_rb_root, and bpf_list_head in
>>>>>> the global namespace.
>>>>>>
>>>>>> The main change is to add "nelems" to btf_fields. The value of
>>>>>> "nelems" represents the number of elements in the array if a btf_field
>>>>>> represents an array. Otherwise, "nelem" will be 1. The verifier
>>>>>> verifies these types based on the information provided by the
>>>>>> btf_field.
>>>>>>
>>>>>> The value of "size" will be the size of the entire array if a
>>>>>> btf_field represents an array. Dividing "size" by "nelems" gives the
>>>>>> size of an element. The value of "offset" will be the offset of the
>>>>>> beginning for an array. By putting this together, we can determine the
>>>>>> offset of each element in an array. For example,
>>>>>>
>>>>>>        struct bpf_cpumask __kptr * global_mask_array[2];
>>>>>
>>>>> Looks like this patch set enables arrays only.
>>>>> Meaning the following is supported already:
>>>>>
>>>>> +private(C) struct bpf_spin_lock glock_c;
>>>>> +private(C) struct bpf_list_head ghead_array1 __contains(foo, node2);
>>>>> +private(C) struct bpf_list_head ghead_array2 __contains(foo, node2);
>>>>>
>>>>> while this support is added:
>>>>>
>>>>> +private(C) struct bpf_spin_lock glock_c;
>>>>> +private(C) struct bpf_list_head ghead_array1[3] __contains(foo, node2);
>>>>> +private(C) struct bpf_list_head ghead_array2[2] __contains(foo, node2);
>>>>>
>>>>> Am I right?
>>>>>
>>>>> What about the case when bpf_list_head is wrapped in a struct?
>>>>> private(C) struct foo {
>>>>>      struct bpf_list_head ghead;
>>>>> } ghead;
>>>>>
>>>>> that's not enabled in this patch. I think.
>>>>>
>>>>> And the following:
>>>>> private(C) struct foo {
>>>>>      struct bpf_list_head ghead;
>>>>> } ghead[2];
>>>>>
>>>>>
>>>>> or
>>>>>
>>>>> private(C) struct foo {
>>>>>      struct bpf_list_head ghead[2];
>>>>> } ghead;
>>>>>
>>>>> Won't work either.
>>>>
>>>> No, they don't work.
>>>> We had a discussion about this in the other day.
>>>> I proposed to have another patch set to work on struct types.
>>>> Do you prefer to handle it in this patch set?
>>>>
>>>>>
>>>>> I think eventually we want to support all such combinations and
>>>>> the approach proposed in this patch with 'nelems'
>>>>> won't work for wrapper structs.
>>>>>
>>>>> I think it's better to unroll/flatten all structs and arrays
>>>>> and represent them as individual elements in the flattened
>>>>> structure. Then there will be no need to special case array with 'nelems'.
>>>>> All special BTF types will be individual elements with unique offset.
>>>>>
>>>>> Does this make sense?
>>>>
>>>> That means it will creates 10 btf_field(s) for an array having 10
>>>> elements. The purpose of adding "nelems" is to avoid the repetition. Do
>>>> you prefer to expand them?
>>>
>>> It's not just expansion, but a common way to handle nested structs too.
>>>
>>> I suspect by delaying nested into another patchset this approach
>>> will become useless.
>>>
>>> So try adding nested structs in all combinations as a follow up and
>>> I suspect you're realize that "nelems" approach doesn't really help.
>>> You'd need to flatten them all.
>>> And once you do there is no need for "nelems".
>>
>> For me, "nelems" is more like a choice of avoiding repetition of
>> information, not a necessary. Before adding "nelems", I had considered
>> to expand them as well. But, eventually, I chose to add "nelems".
>>
>> Since you think this repetition is not a problem, I will expand array as
>> individual elements.
> 
> You don't sound convinced :)
> Please add support for nested structs on top of your "nelems" approach
> and prototype the same without "nelems" and let's compare the two.


The following is the prototype that flatten arrays and struct types.
This approach is definitely simpler than "nelems" one.  However,
it will repeat same information as many times as the size of an array.
For now, we have a limitation on the number of btf_fields (<= 10).

The core part of the "nelems" approach is quiet similar to this
"flatten" version.  However, the following function has to be modified
to handle "nelem" and fields in "BPF_REPEAT_FIELDS" type.

  - bpf_obj_init_field() & bpf_obj_free_fields()
  - btf_record_find()
  - check_map_access()
  - btf_record_find()
  - check_map_access()
  - bpf_obj_memcpy()
  - bpf_obj_memzero()


---
  include/linux/bpf.h |   1 +
  kernel/bpf/btf.c    | 125 +++++++++++++++++++++++++++++++++++++++++---
  2 files changed, 118 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5034c1b4ded7..b5d3d5e39d48 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -202,6 +202,7 @@ enum btf_field_type {
  	BPF_GRAPH_NODE = BPF_RB_NODE | BPF_LIST_NODE,
  	BPF_GRAPH_ROOT = BPF_RB_ROOT | BPF_LIST_HEAD,
  	BPF_REFCOUNT   = (1 << 9),
+	BPF_REPEAT_FIELDS = (1 << 10),
  };

  typedef void (*btf_dtor_kfunc_t)(void *);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 3233832f064f..0cc91f00d872 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3484,6 +3484,50 @@ static int btf_get_field_type(const char *name, 
u32 field_mask, u32 *seen_mask,

  #undef field_mask_test_name

+static int btf_find_struct_field(const struct btf *btf,
+				 const struct btf_type *t, u32 field_mask,
+				 struct btf_field_info *info, int info_cnt);
+
+static void btf_repeat_fields(struct btf_field_info *info, u32 first_field,
+			      u32 field_cnt, u32 repeat_cnt, u32 elem_size)
+{
+	u32 i, j;
+	u32 cur;
+
+	cur = first_field + field_cnt;
+	for (i = 0; i < repeat_cnt; i++) {
+		memcpy(&info[cur], &info[first_field], field_cnt * sizeof(info[0]));
+		for (j = 0; j < field_cnt; j++)
+			info[cur++].off += (i + 1) * elem_size;
+	}
+}
+
+static int btf_find_nested_struct(const struct btf *btf, const struct 
btf_type *t,
+				  u32 off, u32 nelems,
+				  u32 field_mask, struct btf_field_info *info,
+				  int info_cnt)
+{
+	int ret, i;
+
+	ret = btf_find_struct_field(btf, t, field_mask, info, info_cnt);
+
+	if (ret <= 0)
+		return ret;
+
+	/* Shift the offsets of the nested struct fields to the offsets
+	 * related to the container.
+	 */
+	for (i = 0; i < ret; i++)
+		info[i].off += off;
+
+	if (nelems > 1) {
+		btf_repeat_fields(info, 0, ret, nelems - 1, t->size);
+		ret *= nelems;
+	}
+
+	return ret;
+}
+
  static int btf_find_struct_field(const struct btf *btf,
  				 const struct btf_type *t, u32 field_mask,
  				 struct btf_field_info *info, int info_cnt)
@@ -3496,9 +3540,26 @@ static int btf_find_struct_field(const struct btf 
*btf,
  	for_each_member(i, t, member) {
  		const struct btf_type *member_type = btf_type_by_id(btf,
  								    member->type);
+		const struct btf_array *array;
+		u32 j, nelems = 1;
+
+		/* Walk into array types to find the element type and the
+		 * number of elements in the (flattened) array.
+		 */
+		for (j = 0; j < MAX_RESOLVE_DEPTH && btf_type_is_array(member_type); 
j++) {
+			array = btf_array(member_type);
+			nelems *= array->nelems;
+			member_type = btf_type_by_id(btf, array->type);
+		}
+		if (nelems == 0)
+			continue;

  		field_type = btf_get_field_type(__btf_name_by_offset(btf, 
member_type->name_off),
-						field_mask, &seen_mask, &align, &sz);
+							field_mask, &seen_mask, &align, &sz);
+		if ((field_type == BPF_KPTR_REF || !field_type) &&
+		    __btf_type_is_struct(member_type))
+			field_type = BPF_REPEAT_FIELDS;
+
  		if (field_type == 0)
  			continue;
  		if (field_type < 0)
@@ -3522,7 +3583,12 @@ static int btf_find_struct_field(const struct btf 
*btf,
  					      idx < info_cnt ? &info[idx] : &tmp);
  			if (ret < 0)
  				return ret;
-			break;
+			if (ret == BTF_FIELD_IGNORE)
+				continue;
+			if (idx >= info_cnt)
+				return -E2BIG;
+			idx++;
+			continue;
  		case BPF_KPTR_UNREF:
  		case BPF_KPTR_REF:
  		case BPF_KPTR_PERCPU:
@@ -3540,15 +3606,24 @@ static int btf_find_struct_field(const struct 
btf *btf,
  			if (ret < 0)
  				return ret;
  			break;
+		case BPF_REPEAT_FIELDS:
+			ret = btf_find_nested_struct(btf, member_type, off, nelems, field_mask,
+						    &info[idx], info_cnt - idx);
+			if (ret < 0)
+				return ret;
+			idx += ret;
+			continue;
  		default:
  			return -EFAULT;
  		}

  		if (ret == BTF_FIELD_IGNORE)
  			continue;
-		if (idx >= info_cnt)
+		if (idx + nelems > info_cnt)
  			return -E2BIG;
-		++idx;
+		if (nelems > 1)
+			btf_repeat_fields(info, idx, 1, nelems - 1, sz);
+		idx += nelems;
  	}
  	return idx;
  }
@@ -3565,16 +3640,35 @@ static int btf_find_datasec_var(const struct btf 
*btf, const struct btf_type *t,
  	for_each_vsi(i, t, vsi) {
  		const struct btf_type *var = btf_type_by_id(btf, vsi->type);
  		const struct btf_type *var_type = btf_type_by_id(btf, var->type);
+		const struct btf_array *array;
+		u32 j, nelems = 1;
+
+		/* Walk into array types to find the element type and the
+		 * number of elements in the (flattened) array.
+		 */
+		for (j = 0; j < MAX_RESOLVE_DEPTH && btf_type_is_array(var_type); j++) {
+			array = btf_array(var_type);
+			nelems *= array->nelems;
+			var_type = btf_type_by_id(btf, array->type);
+		}
+		if (nelems == 0)
+			continue;

  		field_type = btf_get_field_type(__btf_name_by_offset(btf, 
var_type->name_off),
  						field_mask, &seen_mask, &align, &sz);
+		if ((field_type == BPF_KPTR_REF || !field_type) &&
+		    __btf_type_is_struct(var_type)) {
+			field_type = BPF_REPEAT_FIELDS;
+			sz = var_type->size;
+		}
+
  		if (field_type == 0)
  			continue;
  		if (field_type < 0)
  			return field_type;

  		off = vsi->offset;
-		if (vsi->size != sz)
+		if (vsi->size != sz * nelems)
  			continue;
  		if (off % align)
  			continue;
@@ -3589,7 +3683,12 @@ static int btf_find_datasec_var(const struct btf 
*btf, const struct btf_type *t,
  					      idx < info_cnt ? &info[idx] : &tmp);
  			if (ret < 0)
  				return ret;
-			break;
+			if (ret == BTF_FIELD_IGNORE)
+				continue;
+			if (idx >= info_cnt)
+				return -E2BIG;
+			idx++;
+			continue;
  		case BPF_KPTR_UNREF:
  		case BPF_KPTR_REF:
  		case BPF_KPTR_PERCPU:
@@ -3607,16 +3706,26 @@ static int btf_find_datasec_var(const struct btf 
*btf, const struct btf_type *t,
  			if (ret < 0)
  				return ret;
  			break;
+		case BPF_REPEAT_FIELDS:
+			ret = btf_find_nested_struct(btf, var_type, off, nelems, field_mask,
+						     &info[idx], info_cnt - idx);
+			if (ret < 0)
+				return ret;
+			idx += ret;
+			continue;
  		default:
  			return -EFAULT;
  		}

  		if (ret == BTF_FIELD_IGNORE)
  			continue;
-		if (idx >= info_cnt)
+		if (idx + nelems > info_cnt)
  			return -E2BIG;
-		++idx;
+		if (nelems > 1)
+			btf_repeat_fields(info, idx, 1, nelems - 1, sz);
+		idx += nelems;
  	}
+
  	return idx;
  }

-- 
2.34.1

