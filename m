Return-Path: <bpf+bounces-61069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1EBAE024E
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 12:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A933B70C2
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 10:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EEA221733;
	Thu, 19 Jun 2025 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCbf5/sa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA7021FF38
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750327476; cv=none; b=IqrivPFLNSYvQKzU7z4vlMBbfnbSILRK1envg0iHNSDKospL8LAWzy1TujeFb0HqVMrNfTQcof0OTlDstHa352J2g+lTaSHcj4yis27AlPfV3EOijUjYL/BpwoUBpiptEazJaqbeSPEi0upEBYe4OA9r3cb92HqKJERNgWBpNWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750327476; c=relaxed/simple;
	bh=GksoWb9UA1unU75uMZV8pIjRmsJx8XvP4QafljQeYKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYHzNoROH8gaI6By/vilArGfxHS3a5aWu4dykgjJs+wm13GDz+cVAfPNlQ6Zasx7V8l2S44pP65/xQPIqC7rfHg0re+B2ak+8Z51wQtRQXzmKAu6UfgLesTMCT2unl6RKU45UDCzscYS94VYxNuRg9tTg7brrtw9u3iopNWs4ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCbf5/sa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so5095385e9.3
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 03:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750327473; x=1750932273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+wyjMeCyVh8m/SdgCbaGOPySphGaY24FLTC1uPvV4xg=;
        b=kCbf5/sarR+VNA8FavxYi4jGcVIGvo0Rcv5e2v7dcaF0ANLO9jMcLPahS69sY6iuf6
         s4kRazzVIOaArKpcDANt2U/1FKQzlLCRrJa8Vc9k2cJxa2vkgD5dpPDkasCbz/vo0E9w
         3jPUeyZFI3AnnJGXb8mFdW8jD1xU+2zLjauszbahjN6EeoZ/cr6maIuMMlUKm+f+vnuy
         OupsTlfyIRkUdn9A5ch7IfZpfcbEqH7BXd4jt/vgR1GrrzGOqoFpO9A5Djp4QTc5dyOT
         PqZAQEusT7KzvoIxfkV61Pvs/9NXac8IkqdCyPcBWFAcHJrPsfo74GjGWIVRSJ7UD8o3
         PpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750327473; x=1750932273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wyjMeCyVh8m/SdgCbaGOPySphGaY24FLTC1uPvV4xg=;
        b=vMN5SWMU7ZNReECYigWd4lP3uL3bKh8FGbjHaA1ayS6OVC/mTv8m+fuNxsXau6w+yK
         Vj6cZpzvZlgJd/B3Bs/FCSw0+FV08jy3O78B9GlYfI2GN7NeFcMA6j10QhLTdTYEs+tn
         umK/6OPJkXZFTCDHLvHzIg0vBAyZ3OfecaUfFAB2W8qkoI/s1QJFsDgy1Uw5TYi38JON
         9LYEQHEtSuLgayA0+xxTN4gQ0LZGXRhhNM/AFODDsNRLn/pndRSrnLi+L9MGthFK6jMj
         r3FidDVfSE03AsrLTMAUjBSBjy3IKOJOtUvNWgauAJXWT7spkp1j4LA7lRzBmWaC+sDl
         OuuA==
X-Forwarded-Encrypted: i=1; AJvYcCVeStQnRS1si4rjzwkIzRQoPtBtJ9T26Ytf9OHmjH8TYA3JtghwItJ6igjRJtCPb0xZtyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbZeZRvns06gG6Bf8PUN7cORiuyw7eyx0lDkPo5pSfiXmvlsVs
	boXThfNGgdNo0vTm0u0iFi2XmMlMiOX6vRVkKMBUqo1YTFj5iw79SJ7I
X-Gm-Gg: ASbGnctIP6N75rObk5UI72N1gOTyLBJZTScMbIJoPD0B93WecfqahdLNzndaOffZjNW
	lubd01Lv4nVrW7sw+wIgzIwXWumDVnhIRgKUwFVVgBLoXP6VJUM8PF21LkO00EgE8wQ4hxGAFnb
	QAbhqvu6PUwJd/c4hBHa7s7xiOnyilLuvzMOMd7TcTmHz1ZX+A/lB9T8xS0tLnIv8GKSRcJlj0x
	uxaCCUpwWOqfigpwrj4QMNgqfv9LUT8tnycPyYzyP6KghPlGVg76Mnr55cyNLgxGYbTT56tRmef
	qyJrw8e1f/Kg4BzJ9XYQ7fnA+JNOADE8v5ESoEvorQm3XA1vnXJTwBzPuSJhw1K2btoAqBbGcIK
	4v+Zx1tTE4054qtnH+n9//wQFsVGyLkgbYP9xaXaKgZGNYbFwXsT3CR3V
X-Google-Smtp-Source: AGHT+IGCD/DMBQCSvnw9MUDNxa1AHC62POn1n0qOZB6RjnLHXle4rNiNv41qEvV3VGEA+NPhtcKLsw==
X-Received: by 2002:a05:600c:4f53:b0:453:5d8d:d1b8 with SMTP id 5b1f17b1804b1-4535d8ddc69mr42754575e9.30.1750327472527;
        Thu, 19 Jun 2025 03:04:32 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9? ([2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535a14221csm32066605e9.1.2025.06.19.03.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 03:04:32 -0700 (PDT)
Message-ID: <c8039d72-23bc-4318-a7c8-2f6b1a2c6f84@gmail.com>
Date: Thu, 19 Jun 2025 11:04:31 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: support array presets in
 veristat
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250618203903.539270-1-mykyta.yatsenko5@gmail.com>
 <20250618203903.539270-3-mykyta.yatsenko5@gmail.com>
 <9bb199046f0b55ea4952ee028fc242db7a56bcc3.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <9bb199046f0b55ea4952ee028fc242db7a56bcc3.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/25 08:34, Eduard Zingerman wrote:
> On Wed, 2025-06-18 at 21:39 +0100, Mykyta Yatsenko wrote:
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
>> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
>> index 483442c08ecf..9942adbda411 100644
>> --- a/tools/testing/selftests/bpf/veristat.c
>> +++ b/tools/testing/selftests/bpf/veristat.c
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
>> @@ -1670,7 +1706,7 @@ static int append_var_preset(struct var_preset **presets, int *cnt, const char *
>>   	memset(cur, 0, sizeof(*cur));
>>   	(*cnt)++;
>>   
>> -	if (sscanf(expr, "%s = %s %n", var, val, &n) != 2 || n != strlen(expr)) {
>> +	if (sscanf(expr, "%[][a-zA-Z0-9_.] = %s %n", var, val, &n) != 2 || n != strlen(expr)) {
> Out of curiosity, won't match if the pattern would remain "%s = %s %n"?
"foo=1" won't be parsed correctly, as the entire string will be consumed 
by the first %s.
>
>>   		fprintf(stderr, "Failed to parse expression '%s'\n", expr);
>>   		return -EINVAL;
>>   	}
>> @@ -1763,17 +1799,103 @@ static bool is_preset_supported(const struct btf_type *t)
>>   	return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
>>   }
>>   
>> +static int find_enum_value(const struct btf *btf, const char *name, long long *value)
>> +{
>> +	const struct btf_type *t;
>> +	int cnt, i;
>> +	long long lvalue;
>> +
>> +	cnt = btf__type_cnt(btf);
>> +	for (i = 1; i != cnt; ++i) {
>> +		t = btf__type_by_id(btf, i);
>> +
>> +		if (!btf_is_any_enum(t))
>> +			continue;
>> +
>> +		if (enum_value_from_name(btf, t, name, &lvalue) == 0) {
>> +			*value = lvalue;
>> +			return 0;
>> +		}
>> +	}
>> +	return -ESRCH;
>> +}
>> +
> [...]
>
>> @@ -1815,26 +1938,29 @@ const int btf_find_member(const struct btf *btf,
>>   static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
>>   			      struct btf_var_secinfo *sinfo, struct var_preset *preset)
>>   {
>> -	const struct btf_type *base_type, *member_type;
>> -	int err, member_tid, i;
>> -	__u32 member_offset = 0;
>> -
>> -	base_type = btf__type_by_id(btf, btf__resolve_type(btf, t->type));
>> -
>> -	for (i = 1; i < preset->atom_count; ++i) {
>> -		err = btf_find_member(btf, base_type, 0, preset->atoms[i].name,
>> -				      &member_tid, &member_offset);
>> -		if (err) {
>> -			fprintf(stderr, "Could not find member %s for variable %s\n",
>> -				preset->atoms[i].name, preset->atoms[i - 1].name);
>> -			return err;
>> +	const struct btf_type *base_type;
>> +	int err, i = 1, n;
>> +	int tid;
>> +
>> +	tid = btf__resolve_type(btf, t->type);
>> +	base_type = btf__type_by_id(btf, tid);
>> +
>> +	while (i < preset->atom_count) {
>> +		if (preset->atoms[i].type == ARRAY_INDEX) {
>> +			n = adjust_var_secinfo_array(btf, tid, preset, i, sinfo);
>> +			if (n < 0)
>> +				return n;
>> +			i += n;
> Having a nested loop to consume all indices looks annoying.
> On the other hand, there is not much one can do w/o some kind of
> btf__type_physical_size.
>
>> +		} else {
>> +			err = btf_find_member(btf, base_type, 0, preset->atoms[i].name, sinfo);
>> +			if (err)
>> +				return err;
>> +			i++;
>>   		}
>> -		member_type = btf__type_by_id(btf, member_tid);
>> -		sinfo->offset += member_offset / 8;
>> -		sinfo->size = member_type->size;
>> -		sinfo->type = member_tid;
>> -		base_type = member_type;
>> +		base_type = btf__type_by_id(btf, sinfo->type);
>> +		tid = sinfo->type;
>>   	}
>> +
>>   	return 0;
>>   }
>>   
> [...]
>


