Return-Path: <bpf+bounces-27499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1128ADC10
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 04:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B07285131
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 02:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E742718032;
	Tue, 23 Apr 2024 02:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkQ44Yex"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CE428E8
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 02:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713840894; cv=none; b=inpAxq0BW+kB0MnFHxMtsRqZmKVXfF7niz/2c4L/tbHJRHkcmConXspMgDf5z18U68BqkeqxDLEmNhjH45a8n5yr5zAwJpz8JHHLPsiiyGBSwMOQz/mIx6i41dOfTKUxRrZN/he+z75ctCOtRljHDVlvrCfPod52RJyuBIXTOwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713840894; c=relaxed/simple;
	bh=2vv+/Isg8kq/MbXJvgjsalVdcFLZ3ewjXwuNNJXQeUI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FD/yowbm617EGLK5kPN2qdmMlHP5mKXW0q+hNWALyxSt8wOAks54UQmVShpZSP20y6+ByLM0OMV/OSv6ZLVbt85BVJjO9OLywwjdUbkgBEl8AqXnagxQPx/wm3U7u0KlarSI0mxBnY5Xpp7w8qYbrEaLQK14fNJSbA1LQDe8br4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkQ44Yex; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5af34b1d4d4so154653eaf.1
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 19:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713840892; x=1714445692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D+b/a22g/d+9POCsRdBLlwsbj/T3qCiV/OGrTX6ISVs=;
        b=TkQ44YexSp42neE7EB2irhIWdMsgNULlq8bXSPU7QBZ94t4Coon7eAuUcpE5zDG4Ko
         F1D/KUYXH/Giizi190DpkMCyh5Nt11CZ4zg7zmUvYSjR7sXpRlzN/LFqSvW/YGKs7Rji
         BnnpmdNb2XWVRbg9SFm2NjETuCdV4EoJUkU6zTr+OhTsXJXaGO7vp7Qasc7niD6tp9PE
         ZDItZ/cbCAM11qz1yuTxQZq56LjhfhZIhln5ITv4gRT0qLARsCs8anY9VtXjcT41o3O1
         p3SpuHKOWpC2ZMBKsxIw5fax6I4XhgxcvnoaV5KQXsksnfMpgLIMZh4T6ekU9kfTvibq
         +A4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713840892; x=1714445692;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+b/a22g/d+9POCsRdBLlwsbj/T3qCiV/OGrTX6ISVs=;
        b=qgUf/0AF4Ueu0d4jIFtVMH1kdwU7oJFUIQQX/OclvCApsClrEdC+EM+Go4/5D2e74r
         bh2aOrAQeb7tqUDscgNy50uypl4L1ACFevfUSO0bN1pNCMprH+k7JOIEQioR3fJ35iu4
         xRgMMSbh73osjrzQsUmCpHya+DlC0gJBhXzhIHaByXI6eevrYX4tJhu/xUb3N669uedl
         P1r51e5AyNmOBdfd47Ypgd8FMpkxn05Q1pOGvaY/XBhhvcG3DMvJusr6VMYZoD5fcuYX
         ws2SYU/Z3T+MLml8zFCWlf6Lhpoh+ZdvbY8DrggTUJy6S7wP64NpEvaQAIvcCDBnCMpt
         CzDA==
X-Forwarded-Encrypted: i=1; AJvYcCUseSpuq7gB1UF20hSNOj7YrTsA3Q4HUa4FeIi2Hsk2kn/4YkMQI4iakOEaNKdddj+570xvFmw9l3HzSY/urkYWBl3o
X-Gm-Message-State: AOJu0YxNZCKy9Fx2FTF/X7wsCqwtKIDrq0/Hsd6oztM0eZvtHLWcA5oH
	90iSvyLbd3IuQFSOS4/0x43SBd+F9Ic4yvhFlAnNB0Kmvgg0t2sq
X-Google-Smtp-Source: AGHT+IHPpOBimbfOS+4YbtFfL00RpXX0EWAUXqaJgi4cmGRbPkDRDz1Wgiw7fTt4yEATXU5tw8tKEQ==
X-Received: by 2002:a4a:d04:0:b0:5aa:538a:ed60 with SMTP id 4-20020a4a0d04000000b005aa538aed60mr11990700oob.3.1713840891670;
        Mon, 22 Apr 2024 19:54:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:70f9:8463:f3b1:c282? ([2600:1700:6cf8:1240:70f9:8463:f3b1:c282])
        by smtp.gmail.com with ESMTPSA id cj18-20020a056820221200b005acb0e90e39sm2270987oob.28.2024.04.22.19.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 19:54:51 -0700 (PDT)
Message-ID: <90652139-f541-4a99-837e-e5857c901f61@gmail.com>
Date: Mon, 22 Apr 2024 19:54:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 00/11] Enable BPF programs to declare arrays
 of kptr, bpf_rb_root, and bpf_list_head.
From: Kui-Feng Lee <sinquersw@gmail.com>
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
 <57b4d1ca-a444-4e28-9c22-9b81c352b4cb@gmail.com>
Content-Language: en-US
In-Reply-To: <57b4d1ca-a444-4e28-9c22-9b81c352b4cb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/22/24 19:45, Kui-Feng Lee wrote:
> 
> 
> On 4/18/24 07:53, Alexei Starovoitov wrote:
>> On Wed, Apr 17, 2024 at 11:07 PM Kui-Feng Lee <sinquersw@gmail.com> 
>> wrote:
>>>
>>>
>>>
>>> On 4/17/24 22:11, Alexei Starovoitov wrote:
>>>> On Wed, Apr 17, 2024 at 9:31 PM Kui-Feng Lee <sinquersw@gmail.com> 
>>>> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 4/17/24 20:30, Alexei Starovoitov wrote:
>>>>>> On Fri, Apr 12, 2024 at 2:08 PM Kui-Feng Lee 
>>>>>> <thinker.li@gmail.com> wrote:
>>>>>>>
>>>>>>> The arrays of kptr, bpf_rb_root, and bpf_list_head didn't work as
>>>>>>> global variables. This was due to these types being initialized and
>>>>>>> verified in a special manner in the kernel. This patchset allows BPF
>>>>>>> programs to declare arrays of kptr, bpf_rb_root, and 
>>>>>>> bpf_list_head in
>>>>>>> the global namespace.
>>>>>>>
>>>>>>> The main change is to add "nelems" to btf_fields. The value of
>>>>>>> "nelems" represents the number of elements in the array if a 
>>>>>>> btf_field
>>>>>>> represents an array. Otherwise, "nelem" will be 1. The verifier
>>>>>>> verifies these types based on the information provided by the
>>>>>>> btf_field.
>>>>>>>
>>>>>>> The value of "size" will be the size of the entire array if a
>>>>>>> btf_field represents an array. Dividing "size" by "nelems" gives the
>>>>>>> size of an element. The value of "offset" will be the offset of the
>>>>>>> beginning for an array. By putting this together, we can 
>>>>>>> determine the
>>>>>>> offset of each element in an array. For example,
>>>>>>>
>>>>>>>        struct bpf_cpumask __kptr * global_mask_array[2];
>>>>>>
>>>>>> Looks like this patch set enables arrays only.
>>>>>> Meaning the following is supported already:
>>>>>>
>>>>>> +private(C) struct bpf_spin_lock glock_c;
>>>>>> +private(C) struct bpf_list_head ghead_array1 __contains(foo, node2);
>>>>>> +private(C) struct bpf_list_head ghead_array2 __contains(foo, node2);
>>>>>>
>>>>>> while this support is added:
>>>>>>
>>>>>> +private(C) struct bpf_spin_lock glock_c;
>>>>>> +private(C) struct bpf_list_head ghead_array1[3] __contains(foo, 
>>>>>> node2);
>>>>>> +private(C) struct bpf_list_head ghead_array2[2] __contains(foo, 
>>>>>> node2);
>>>>>>
>>>>>> Am I right?
>>>>>>
>>>>>> What about the case when bpf_list_head is wrapped in a struct?
>>>>>> private(C) struct foo {
>>>>>>      struct bpf_list_head ghead;
>>>>>> } ghead;
>>>>>>
>>>>>> that's not enabled in this patch. I think.
>>>>>>
>>>>>> And the following:
>>>>>> private(C) struct foo {
>>>>>>      struct bpf_list_head ghead;
>>>>>> } ghead[2];
>>>>>>
>>>>>>
>>>>>> or
>>>>>>
>>>>>> private(C) struct foo {
>>>>>>      struct bpf_list_head ghead[2];
>>>>>> } ghead;
>>>>>>
>>>>>> Won't work either.
>>>>>
>>>>> No, they don't work.
>>>>> We had a discussion about this in the other day.
>>>>> I proposed to have another patch set to work on struct types.
>>>>> Do you prefer to handle it in this patch set?
>>>>>
>>>>>>
>>>>>> I think eventually we want to support all such combinations and
>>>>>> the approach proposed in this patch with 'nelems'
>>>>>> won't work for wrapper structs.
>>>>>>
>>>>>> I think it's better to unroll/flatten all structs and arrays
>>>>>> and represent them as individual elements in the flattened
>>>>>> structure. Then there will be no need to special case array with 
>>>>>> 'nelems'.
>>>>>> All special BTF types will be individual elements with unique offset.
>>>>>>
>>>>>> Does this make sense?
>>>>>
>>>>> That means it will creates 10 btf_field(s) for an array having 10
>>>>> elements. The purpose of adding "nelems" is to avoid the 
>>>>> repetition. Do
>>>>> you prefer to expand them?
>>>>
>>>> It's not just expansion, but a common way to handle nested structs too.
>>>>
>>>> I suspect by delaying nested into another patchset this approach
>>>> will become useless.
>>>>
>>>> So try adding nested structs in all combinations as a follow up and
>>>> I suspect you're realize that "nelems" approach doesn't really help.
>>>> You'd need to flatten them all.
>>>> And once you do there is no need for "nelems".
>>>
>>> For me, "nelems" is more like a choice of avoiding repetition of
>>> information, not a necessary. Before adding "nelems", I had considered
>>> to expand them as well. But, eventually, I chose to add "nelems".
>>>
>>> Since you think this repetition is not a problem, I will expand array as
>>> individual elements.
>>
>> You don't sound convinced :)
>> Please add support for nested structs on top of your "nelems" approach
>> and prototype the same without "nelems" and let's compare the two.
> 
> 
> The following is the prototype that flatten arrays and struct types.
> This approach is definitely simpler than "nelems" one.  However,
> it will repeat same information as many times as the size of an array.
> For now, we have a limitation on the number of btf_fields (<= 10).
> 
> The core part of the "nelems" approach is quiet similar to this
> "flatten" version.  However, the following function has to be modified
> to handle "nelem" and fields in "BPF_REPEAT_FIELDS" type.
> 
>   - bpf_obj_init_field() & bpf_obj_free_fields()
>   - btf_record_find()
>   - check_map_access()
>   - btf_record_find()
>   - check_map_access()
>   - bpf_obj_memcpy()
>   - bpf_obj_memzero()
> 
> 


The following is the core part that I extracted from the patchset.
It doesn't include the change on the functions mentioned above.


---
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index caea4e560eb3..bd9d56b9b6e4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -202,6 +202,7 @@ enum btf_field_type {
  	BPF_GRAPH_NODE = BPF_RB_NODE | BPF_LIST_NODE,
  	BPF_GRAPH_ROOT = BPF_RB_ROOT | BPF_LIST_HEAD,
  	BPF_REFCOUNT   = (1 << 9),
+	BPF_REPEAT_FIELDS = (1 << 10),
  };

  typedef void (*btf_dtor_kfunc_t)(void *);
@@ -226,10 +227,12 @@ struct btf_field_graph_root {
  struct btf_field {
  	u32 offset;
  	u32 size;
+	u32 nelems;
  	enum btf_field_type type;
  	union {
  		struct btf_field_kptr kptr;
  		struct btf_field_graph_root graph_root;
+		u32 repeated_cnt;
  	};
  };

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 3233832f064f..005e530bf7e5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3289,6 +3289,7 @@ enum {
  struct btf_field_info {
  	enum btf_field_type type;
  	u32 off;
+	u32 nelems;
  	union {
  		struct {
  			u32 type_id;
@@ -3297,6 +3298,10 @@ struct btf_field_info {
  			const char *node_name;
  			u32 value_btf_id;
  		} graph_root;
+		struct {
+			u32 cnt;
+			u32 elem_size;
+		} repeat;
  	};
  };

@@ -3484,6 +3489,43 @@ static int btf_get_field_type(const char *name, 
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
+	/* Shift the offsets of the nested struct fields to the offsets
+	 * related to the container.
+	 */
+	for (i = 0; i < ret; i++)
+		info[i].off += off;
+
+	if (nelems > 1) {
+		/* Repeat fields created for nested struct */
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
@@ -3496,9 +3538,26 @@ static int btf_find_struct_field(const struct btf 
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
@@ -3540,6 +3599,13 @@ static int btf_find_struct_field(const struct btf 
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
+			continue;
  		default:
  			return -EFAULT;
  		}
@@ -3548,6 +3614,7 @@ static int btf_find_struct_field(const struct btf 
*btf,
  			continue;
  		if (idx >= info_cnt)
  			return -E2BIG;
+		info[idx].nelems = nelems;
  		++idx;
  	}
  	return idx;
@@ -3565,16 +3632,35 @@ static int btf_find_datasec_var(const struct btf 
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
@@ -3582,9 +3668,11 @@ static int btf_find_datasec_var(const struct btf 
*btf, const struct btf_type *t,
  		switch (field_type) {
  		case BPF_SPIN_LOCK:
  		case BPF_TIMER:
+		case BPF_REFCOUNT:
  		case BPF_LIST_NODE:
  		case BPF_RB_NODE:
-		case BPF_REFCOUNT:
+			if (nelems != 1)
+				continue;
  			ret = btf_find_struct(btf, var_type, off, sz, field_type,
  					      idx < info_cnt ? &info[idx] : &tmp);
  			if (ret < 0)
@@ -3607,6 +3695,13 @@ static int btf_find_datasec_var(const struct btf 
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
@@ -3615,8 +3710,9 @@ static int btf_find_datasec_var(const struct btf 
*btf, const struct btf_type *t,
  			continue;
  		if (idx >= info_cnt)
  			return -E2BIG;
-		++idx;
+		info[idx++].nelems = nelems;
  	}
+
  	return idx;
  }

@@ -3818,7 +3914,10 @@ struct btf_record *btf_parse_fields(const struct 
btf *btf, const struct btf_type
  	rec->timer_off = -EINVAL;
  	rec->refcount_off = -EINVAL;
  	for (i = 0; i < cnt; i++) {
-		field_type_size = btf_field_type_size(info_arr[i].type);
+		if (info_arr[i].type == BPF_REPEAT_FIELDS)
+			field_type_size = info_arr[i].repeat.elem_size * info_arr[i].nelems;
+		else
+			field_type_size = btf_field_type_size(info_arr[i].type) * 
info_arr[i].nelems;
  		if (info_arr[i].off + field_type_size > value_size) {
  			WARN_ONCE(1, "verifier bug off %d size %d", info_arr[i].off, 
value_size);
  			ret = -EFAULT;
@@ -3830,10 +3929,12 @@ struct btf_record *btf_parse_fields(const struct 
btf *btf, const struct btf_type
  		}
  		next_off = info_arr[i].off + field_type_size;

-		rec->field_mask |= info_arr[i].type;
+		if (info_arr[i].type != BPF_REPEAT_FIELDS)
+			rec->field_mask |= info_arr[i].type;
  		rec->fields[i].offset = info_arr[i].off;
  		rec->fields[i].type = info_arr[i].type;
  		rec->fields[i].size = field_type_size;
+		rec->fields[i].nelems = info_arr[i].nelems;

  		switch (info_arr[i].type) {
  		case BPF_SPIN_LOCK:
@@ -3871,6 +3972,10 @@ struct btf_record *btf_parse_fields(const struct 
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

