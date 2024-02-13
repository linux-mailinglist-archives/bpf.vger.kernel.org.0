Return-Path: <bpf+bounces-21915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639D9854010
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2030F28FC54
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AF363099;
	Tue, 13 Feb 2024 23:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J0w7Thui"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEC363101
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866860; cv=none; b=PsknzWXhMMVBtxdjOQTW8bZA+S6LxulMDta4uXdMWeEmhp9pweX6IGzsfZQQ0bZoVgQiIAM27GjV41eBtYNX7bz9q7cuI/cD/0cRKGNQBnVzRYE/kaaHB8uwYAWADeGaLGc7yZUVzX2TEgVRHm1GM39VnYNdCT/MYK1tEVF0wo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866860; c=relaxed/simple;
	bh=ObmfnwfKemHbBRQs/7JpZdRVJQjcMZAKaipVsK5zeOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wd/ElVbzCtORVvrtGItFIOrdVfbRamyOtulZJPLlT6Cs4JY6MJ5UfsHZjcsFSj9PCZS+ZHzAyHFgNTanEFaPxtvYAQVRJXQUIELtyYSfUbSZUBwSAa9otioEfVqy/ROaMzwFXNWHrmI8eKmLFopbGBnO7w61t0Kzc/UwnPGh2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J0w7Thui; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8e0ba6bf-1bb0-4b02-8c2f-e24383f8c8fe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707866857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mm1Ct2DrgIc++SW9V0pE+n50JVvxeCOM0EHg77Egyx4=;
	b=J0w7Thui8e8UJrzOKSD06iV270Q5r/7dM6Dk9Y3iTlyoAhVk/fhQFreJie/21/b40dBhuy
	t2Zty4QYri2LddAilheLX38inuj8iRn/Ismz2cPeYmyflP4aYW8MRLm0z/PZvcLXzucDSW
	GrxFVzR+VjKldIO3CXKHYiYWvwqjk4k=
Date: Tue, 13 Feb 2024 15:27:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 3/4] bpf: Create argument information for
 nullable arguments.
To: Jiri Olsa <olsajiri@gmail.com>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, davemarchevsky@meta.com,
 dvernet@meta.com, sinquersw@gmail.com, kuifeng@meta.com
References: <20240209023750.1153905-1-thinker.li@gmail.com>
 <20240209023750.1153905-4-thinker.li@gmail.com> <ZcoEzyRzxLUWWhw4@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ZcoEzyRzxLUWWhw4@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/12/24 3:45 AM, Jiri Olsa wrote:
> On Thu, Feb 08, 2024 at 06:37:49PM -0800, thinker.li@gmail.com wrote:
> 
> SNIP
> 
>>   enum bpf_struct_ops_state {
>> @@ -1790,6 +1806,7 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>>   			     struct btf *btf,
>>   			     struct bpf_verifier_log *log);
>>   void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
>> +void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc);
>>   #else
>>   #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
>>   static inline bool bpf_try_module_get(const void *data, struct module *owner)
>> @@ -1814,6 +1831,10 @@ static inline void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struc
>>   {
>>   }
>>   
>> +static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc, int len)
>> +{
>> +}
> 
> extra len argument?

Good catch. Fixed and applied. Also changed some inconsistent integer usage by 
s/s32/u32/ (e.g. s/s32/u32/ arg_btf_id)


