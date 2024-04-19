Return-Path: <bpf+bounces-27249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612AE8AB51D
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 20:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBC31F220A2
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 18:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F341F954;
	Fri, 19 Apr 2024 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxlyNHzo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1AAF9D9
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713551774; cv=none; b=pOkzaLSwkReaC9HkoIx0R5Vj7ejq3F6gPCZCXpDW6BeaIKfhy99POAjn7bf0d3/dOc35GfdUPZq0iD0crde+cclMDAPg3Zk3av5ocCmhECwlUn20fRNLHOxfKs/2VFV3pYkkIHXfL83aFzcgYCe58EqHswRjKNGgk2BmtUdtePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713551774; c=relaxed/simple;
	bh=Euitm+jxYtXyEfwv0goiuR4mh1vIWbABD5EMOXoKRY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEbtSIuKSgL3g8nbEjbWxhrJBrTVQxtl4uT15QanqUGo5rczHp+8n7oLdx4dRCq9t62vDbLAaZDS9qOvmZr2gyDJxWfN31HS9LvHGoAeMZD5sFWvxHwdSuckMx6gJ0k1AmdNI5p6uyU+LnCIm1UvKIlPItHgGv74iAGZUZ1AxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxlyNHzo; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5aa1fe2ad39so1310807eaf.2
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 11:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713551771; x=1714156571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fNH/GiNHtRCSl9YzepYUsHBpXc0Oxr/D999cbd5eivk=;
        b=VxlyNHzoOqHmhqb72oQ/aPyLAly4E7hQ0LIR70llts1TBnJs5Q7ed8j7RpJs5Ac1lb
         yWSSyoeKpxlWT+sJvjFw/KQutXhfQWWxw/VHi1ck1vU92DJhOYAvUwtAYGih43ZAQt/Q
         UvF5ueYLR+KwP1KfIPVWEdv1W19IOWLjusSG5RYevS8WJmV7Y3e4z2a7IHBL0Ue0QK6t
         HY/LTbXzWKCswTR/lwDpkJWLEY/ibupoqUaoIQ40zx0SGE4RMmkDo31+3/SBZW5fZI5v
         xhMpkzXgOmbYL9LL3aaOodInQUKlkxmIT5rxzXNvFbx7PodxcwiahKun9sFNGXSjWo88
         GBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713551771; x=1714156571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNH/GiNHtRCSl9YzepYUsHBpXc0Oxr/D999cbd5eivk=;
        b=rWRZCpPKD/+q/KNI4OGQQkow5qhfI70Op1TDu4p/VDzS115A72GrLtiwlczUjAif9+
         s0OtFO4G1/jVrYOJorgZ49DI0xFbw6DkX8DLXb7n4U0+tI9ikFkjqSxNUfX37xrAIivc
         m3595qx6kEytLOBz8L9ruWLQ1vb34hBD/T7+DRyBKM5wQqj7buVLsj9115VpSdT8Z4SJ
         jisghY70BOBYGHIJWExJs54/9XYZTJB6iEYaElvxaRTX1U69jV9A0kEwcDfUa7AzXQY0
         G81al+0CS7Z+vJiEBNYf3l30+c5UqYd3Ws3mEUC6/bqIrB1l3xWGB7kCHn3F+bZgqbaV
         eW+w==
X-Forwarded-Encrypted: i=1; AJvYcCUq4Bfrq0IvLkVUUjXdpkRuULmnzyiP5+CgIkDPJsTJhFgZhmcmNsJtWEAyJp7BXTUc1HEiuqO1lX6FX/iR25FklECO
X-Gm-Message-State: AOJu0YxUffQJ9ODn4prbr0IINcQ9uqenhKMUs37uvofHA12N7q4GTjZd
	j2SW1gPOCh7rHmYhMmgtJirKNwb5/rTV9KEGWdnltBOo3gtZPGIV
X-Google-Smtp-Source: AGHT+IH3SAEUSNmjVkgxN21BgoFYLbD1AwGLn9vYZclfyr8MX/VYyLCPJYT7/zMpV0gQduNUoUJq7g==
X-Received: by 2002:a4a:d04:0:b0:5aa:538a:ed60 with SMTP id 4-20020a4a0d04000000b005aa538aed60mr3370050oob.3.1713551771242;
        Fri, 19 Apr 2024 11:36:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:cccd:b556:7018:de66? ([2600:1700:6cf8:1240:cccd:b556:7018:de66])
        by smtp.gmail.com with ESMTPSA id 129-20020a4a1787000000b005aa4e48efc3sm946530ooe.37.2024.04.19.11.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 11:36:10 -0700 (PDT)
Message-ID: <4d3dc24f-fb50-4674-8eec-4c38e4d4b2c1@gmail.com>
Date: Fri, 19 Apr 2024 11:36:09 -0700
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


I have an implementation following with "nelems".
The basic idea is to introduce field type BPF_REPEAT_FIELDS to repeat
some btf_field immediately before if necessary.

For example,

   struct foo {
     struct bpf_cpumask __kptr *a;
     struct bpf_cpumask __kptr *b;
   };

   struct foo fooptrs[10];

it will create two btf_fields for a & b, like

   [kptr_a, kptr_b]

However, fooptrs is any array of size 10. It will create another field
of BPF_REPEAT_FIELDS to repeat two fields immediate before for 9 times.

   [kptr_a, kptr_b, repeat_fields(nelems=9, repeated_cnt=2)]

The size of the repeat_fields with be the size of an element times 9,
and offset of the  repeat_fields will be the offset of &fooptrs[1].

Even struct foo is in another struct nested, it would still create the
same/or similar result. For example,

   struct foo_deep {
     int dummy;
     struct foo inner;
   };

   struct foo_deep deep_ptrs[10];

it will create the similar fields with different offsets.

   [kptr_a, kptr_b, repeated_fields(nelems=9, repeated_cnt=2)]

What if nested with array?

   struct foo_deep_arr {
     int dummy;
     struct foo inner[4];
   }

it will create fields like,

   [kptr_a, kptr_b, repeated_fields(nelems=3, repeated_cnt=2),
    repeated_fields(nelems=9, repeated_cnt=3)]


diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b25dd498b737..bfd31d2a9770 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -202,6 +202,7 @@ enum btf_field_type {
  	BPF_GRAPH_NODE = BPF_RB_NODE | BPF_LIST_NODE,
  	BPF_GRAPH_ROOT = BPF_RB_ROOT | BPF_LIST_HEAD,
  	BPF_REFCOUNT   = (1 << 9),
+	BPF_REPEAT_FIELDS = (1 << 10),
  };

  typedef void (*btf_dtor_kfunc_t)(void *);
@@ -231,6 +232,7 @@ struct btf_field {
  	union {
  		struct btf_field_kptr kptr;
  		struct btf_field_graph_root graph_root;
+		u32 repeated_cnt;
  	};
  };

@@ -489,6 +491,21 @@ static inline void bpf_obj_memcpy(struct btf_record 
*rec,
  		u32 next_off = rec->fields[i].offset;
  		u32 sz = next_off - curr_off;

+		if (rec->fields[i].type == BPF_REPEAT_FIELDS) {
+			int cnt = rec->fields[i].repeated_cnt;
+			int elem_size = rec->fields[i].size / rec->fields[i].nelems;
+			int j, k;
+			for (j = 0; j < rec->fields[i].nelems; j++) {
+				for (k = i - cnt; k < i; k++) {
+					/* Use repated fields to copy */
+					next_off = rec->fields[k].offset + elem_size + elem_size * j;
+					sz = next_off - curr_off;
+					memcpy(dst + curr_off, src + curr_off, sz);
+					curr_off += rec->fields[k].size + sz;
+				}
+			}
+			continue;
+		}
  		memcpy(dst + curr_off, src + curr_off, sz);
  		curr_off += rec->fields[i].size + sz;
  	}
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ae17d3996843..b8acec702557 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3298,6 +3298,10 @@ struct btf_field_info {
  			const char *node_name;
  			u32 value_btf_id;
  		} graph_root;
+		struct {
+			u32 cnt;
+			u32 elem_size;
+		} repeat;
  	};
  };

@@ -3485,6 +3489,39 @@ static int btf_get_field_type(const char *name, 
u32 field_mask, u32 *seen_mask,

  #undef field_mask_test_name

+static int btf_find_struct_field(const struct btf *btf,
+				 const struct btf_type *t, u32 field_mask,
+				 struct btf_field_info *info, int info_cnt);
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
+	for (i = 0; i < ret; i++)
+		info[i].off += off;
+
+	if (nelems > 1) {
+		if (ret >= info_cnt)
+			return -E2BIG;
+		info[ret].type = BPF_REPEAT_FIELDS;
+		info[ret].off = off + t->size;
+		info[ret].nelems = nelems - 1;
+		info[ret].repeat.cnt = ret;
+		info[ret].repeat.elem_size = t->size;
+		ret += 1;
+	}
+
+	return ret;
+}
+
  static int btf_find_struct_field(const struct btf *btf,
  				 const struct btf_type *t, u32 field_mask,
  				 struct btf_field_info *info, int info_cnt)
@@ -3497,9 +3534,26 @@ static int btf_find_struct_field(const struct btf 
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

-		field_type = btf_get_field_type(__btf_name_by_offset(btf, 
member_type->name_off),
-						field_mask, &seen_mask, &align, &sz);
+		if ((field_mask & BPF_REPEAT_FIELDS) &&
+		    __btf_type_is_struct(member_type))
+			field_type = BPF_REPEAT_FIELDS;
+		else
+			field_type = btf_get_field_type(__btf_name_by_offset(btf, 
member_type->name_off),
+							field_mask, &seen_mask, &align, &sz);
  		if (field_type == 0)
  			continue;
  		if (field_type < 0)
@@ -3541,6 +3595,15 @@ static int btf_find_struct_field(const struct btf 
*btf,
  			if (ret < 0)
  				return ret;
  			break;
+		case BPF_REPEAT_FIELDS:
+			ret = btf_find_nested_struct(btf, member_type, off, nelems, field_mask,
+						    &info[idx], info_cnt - idx);
+			if (ret < 0)
+				return ret;
+			idx += ret;
+			if (idx >= info_cnt)
+				return -E2BIG;
+			continue;
  		default:
  			return -EFAULT;
  		}
@@ -3549,7 +3612,7 @@ static int btf_find_struct_field(const struct btf 
*btf,
  			continue;
  		if (idx >= info_cnt)
  			return -E2BIG;
-		info[idx].nelems = 1;
+		info[idx].nelems = nelems;
  		++idx;
  	}
  	return idx;
@@ -3581,8 +3644,13 @@ static int btf_find_datasec_var(const struct btf 
*btf, const struct btf_type *t,
  		if (nelems == 0)
  			continue;

-		field_type = btf_get_field_type(__btf_name_by_offset(btf, 
var_type->name_off),
-						field_mask, &seen_mask, &align, &sz);
+		if ((field_mask & BPF_REPEAT_FIELDS) &&
+		    __btf_type_is_struct(var_type)) {
+			field_type = BPF_REPEAT_FIELDS;
+			sz = var_type->size;
+		} else
+			field_type = btf_get_field_type(__btf_name_by_offset(btf, 
var_type->name_off),
+							field_mask, &seen_mask, &align, &sz);
  		if (field_type == 0)
  			continue;
  		if (field_type < 0)
@@ -3624,6 +3692,15 @@ static int btf_find_datasec_var(const struct btf 
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
+			if (idx >= info_cnt)
+				return -E2BIG;
+			continue;
  		default:
  			return -EFAULT;
  		}
@@ -3634,6 +3711,7 @@ static int btf_find_datasec_var(const struct btf 
*btf, const struct btf_type *t,
  			return -E2BIG;
  		info[idx++].nelems = nelems;
  	}
+
  	return idx;
  }

@@ -3835,19 +3913,24 @@ struct btf_record *btf_parse_fields(const struct 
btf *btf, const struct btf_type
  	rec->timer_off = -EINVAL;
  	rec->refcount_off = -EINVAL;
  	for (i = 0; i < cnt; i++) {
-		field_type_size = btf_field_type_size(info_arr[i].type) * 
info_arr[i].nelems;
+		if (info_arr[i].type == BPF_REPEAT_FIELDS)
+			field_type_size = info_arr[i].repeat.elem_size * info_arr[i].nelems;
+		else
+			field_type_size = btf_field_type_size(info_arr[i].type) * 
info_arr[i].nelems;
  		if (info_arr[i].off + field_type_size > value_size) {
  			WARN_ONCE(1, "verifier bug off %d size %d", info_arr[i].off, 
value_size);
  			ret = -EFAULT;
  			goto end;
  		}
-		if (info_arr[i].off < next_off) {
+		if (info_arr[i].off < next_off &&
+		    info_arr[i].type != BPF_REPEAT_FIELDS) {
  			ret = -EEXIST;
  			goto end;
  		}
  		next_off = info_arr[i].off + field_type_size;

-		rec->field_mask |= info_arr[i].type;
+		if (info_arr[i].type != BPF_REPEAT_FIELDS)
+			rec->field_mask |= info_arr[i].type;
  		rec->fields[i].offset = info_arr[i].off;
  		rec->fields[i].type = info_arr[i].type;
  		rec->fields[i].size = field_type_size;
@@ -3889,6 +3972,10 @@ struct btf_record *btf_parse_fields(const struct 
btf *btf, const struct btf_type
  		case BPF_LIST_NODE:
  		case BPF_RB_NODE:
  			break;
+
+		case BPF_REPEAT_FIELDS:
+			rec->fields[i].repeated_cnt = info_arr[i].repeat.cnt;
+			break;
  		default:
  			ret = -EFAULT;
  			goto end;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1c8a9bc00d17..0effa1daf2ca 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -532,15 +532,27 @@ static int btf_field_cmp(const void *a, const void *b)
  struct btf_field *btf_record_find(const struct btf_record *rec, u32 
offset,
  				  u32 field_mask)
  {
+	const struct btf_field *fields;
  	struct btf_field *field;
  	struct btf_field key = {
  		.offset = offset,
  		.size = 0,	/* as a label for this key */
  	};
+	u32 cnt, elem_size;

  	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & field_mask))
  		return NULL;
-	field = bsearch(&key, rec->fields, rec->cnt, sizeof(rec->fields[0]), 
btf_field_cmp);
+	fields = rec->fields;
+	cnt = rec->cnt;
+	while ((field = bsearch(&key, fields, cnt, sizeof(rec->fields[0]), 
btf_field_cmp)) && field->type == BPF_REPEAT_FIELDS) {
+		cnt = field->repeated_cnt;
+		fields = field - cnt;
+		elem_size = field->size / field->nelems;
+		/* Redirect to the offset of repeated fields */
+		offset = offset - field->offset;
+		offset = field->offset + (offset % elem_size) - elem_size;
+		key.offset = offset;
+	}
  	if (!field || !(field->type & field_mask))
  		return NULL;
  	if ((offset - field->offset) % (field->size / field->nelems))
@@ -1106,7 +1118,7 @@ static int map_check_btf(struct bpf_map *map, 
struct bpf_token *token,

  	map->record = btf_parse_fields(btf, value_type,
  				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
-				       BPF_RB_ROOT | BPF_REFCOUNT,
+				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_REPEAT_FIELDS,
  				       map->value_size);
  	if (!IS_ERR_OR_NULL(map->record)) {
  		int i;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 67b89d4ea1ba..45b2da8a00d1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5416,6 +5416,7 @@ static int check_map_access(struct 
bpf_verifier_env *env, u32 regno,
  	struct bpf_reg_state *reg = &state->regs[regno];
  	struct bpf_map *map = reg->map_ptr;
  	struct btf_record *rec;
+	u32 cnt;
  	int err, i;

  	err = check_mem_region_access(env, regno, off, size, map->value_size,
@@ -5426,7 +5427,8 @@ static int check_map_access(struct 
bpf_verifier_env *env, u32 regno,
  	if (IS_ERR_OR_NULL(map->record))
  		return 0;
  	rec = map->record;
-	for (i = 0; i < rec->cnt; i++) {
+	cnt = rec->cnt;
+	for (i = 0; i < cnt; i++) {
  		struct btf_field *field = &rec->fields[i];
  		u32 p = field->offset, var_p, elem_size;

@@ -5461,6 +5463,18 @@ static int check_map_access(struct 
bpf_verifier_env *env, u32 regno,
  					return -EACCES;
  				}
  				break;
+			case BPF_REPEAT_FIELDS:
+				var_p = off + reg->var_off.value;
+				if (var_p < p || var_p >= p + field->size)
+					break;
+				elem_size = field->size / field->nelems;
+				/* Redirect to the offset of repeated
+				 * fields
+				 */
+				off = p + ((var_p - p) % elem_size) - reg->var_off.value - elem_size;
+				cnt = i;
+				i -= field->repeated_cnt + 1;
+				break;
  			default:
  				verbose(env, "%s cannot be accessed directly by load/store\n",
  					btf_field_type_name(field->type));
diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c 
b/tools/testing/selftests/bpf/prog_tests/cpumask.c
index bba601e235f6..2570bd4b0cb2 100644
--- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -21,6 +21,8 @@ static const char * const cpumask_success_testcases[] = {
  	"test_global_mask_array_one_rcu",
  	"test_global_mask_array_rcu",
  	"test_global_mask_array_l2_rcu",
+	"test_global_mask_nested_rcu",
+	"test_global_mask_nested_deep_rcu",
  	"test_cpumask_weight",
  };

diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c 
b/tools/testing/selftests/bpf/progs/cpumask_success.c
index 9d76d85680d7..0de6bc115f55 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -11,9 +11,21 @@
  char _license[] SEC("license") = "GPL";

  int pid, nr_cpus;
+struct kptr_nested {
+	struct bpf_cpumask __kptr * mask;
+};
+struct kptr_nested_mid {
+	int dummy;
+	struct kptr_nested m;
+};
+struct kptr_nested_deep {
+	struct kptr_nested_mid ptrs[2];
+};
  private(MASK) static struct bpf_cpumask __kptr * global_mask_array[2];
  private(MASK) static struct bpf_cpumask __kptr * 
global_mask_array_l2[2][1];
  private(MASK) static struct bpf_cpumask __kptr * global_mask_array_one[1];
+private(MASK) static struct kptr_nested global_mask_nested[2];
+private(MASK) static struct kptr_nested_deep global_mask_nested_deep;

  static bool is_test_task(void)
  {
@@ -553,6 +565,71 @@ int BPF_PROG(test_global_mask_array_rcu, struct 
task_struct *task, u64 clone_fla
  	return 0;
  }

+static int _global_mask_nested_rcu(struct bpf_cpumask **mask0,
+				       struct bpf_cpumask **mask1)
+{
+	struct bpf_cpumask *local;
+
+	if (!is_test_task())
+		return 0;
+
+	/* Check if two kptrs in the array work and independently */
+
+	local = create_cpumask();
+	if (!local)
+		return 0;
+
+	bpf_rcu_read_lock();
+
+	local = bpf_kptr_xchg(mask0, local);
+	if (local) {
+		err = 1;
+		goto err_exit;
+	}
+
+	/* [<mask 0>, NULL] */
+	if (!*mask0 || *mask1) {
+		err = 2;
+		goto err_exit;
+	}
+
+	local = create_cpumask();
+	if (!local) {
+		err = 9;
+		goto err_exit;
+	}
+
+	local = bpf_kptr_xchg(mask1, local);
+	if (local) {
+		err = 10;
+		goto err_exit;
+	}
+
+	/* [<mask 0>, <mask 1>] */
+	if (!*mask0 || !*mask1 || *mask0 == *mask1) {
+		err = 11;
+		goto err_exit;
+	}
+
+err_exit:
+	if (local)
+		bpf_cpumask_release(local);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_global_mask_nested_rcu, struct task_struct *task, u64 
clone_flags)
+{
+	return _global_mask_nested_rcu(&global_mask_nested[0].mask, 
&global_mask_nested[1].mask);
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_global_mask_nested_deep_rcu, struct task_struct 
*task, u64 clone_flags)
+{
+	return 
_global_mask_nested_rcu(&global_mask_nested_deep.ptrs[0].m.mask, 
&global_mask_nested_deep.ptrs[1].m.mask);
+}
+
  SEC("tp_btf/task_newtask")
  int BPF_PROG(test_global_mask_array_l2_rcu, struct task_struct *task, 
u64 clone_flags)
  {

