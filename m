Return-Path: <bpf+bounces-52096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E8BA3E36C
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 19:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648151776AF
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 18:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7607E214213;
	Thu, 20 Feb 2025 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5Kh2fht"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8760F1F892D;
	Thu, 20 Feb 2025 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074983; cv=none; b=oZPPlWGJkUtj3fmgause9xBQeWP1ib+63xSi7KgYX/lQ7itWMhF+fgyyi+UPbqaKDkpDKyxQuxF9/8hmg3zGLVswaLGpYQybywTpjqdYfJhxZGEFP6oA0fKKoqHkN1YISweI1FRAJq8hQfA0Govdkm6NLgsLCRVkJN7KKlP44GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074983; c=relaxed/simple;
	bh=QdZaPnPcljDb39RTNsoSRKxH+E0E0t7xExf0D2l8dP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dre4gDH8skBYwRwPW/8zfTFYY0ow9Om/mHIU63TVwa2h3eCXQREbhs0u53z4Ph3JaoyzJAYaaYvz/8Gr6IGsDLki/GfWdIH8cjLevToH7CCH1rOGQv0xvREy4AqOULb8T4p8kfKmmE9Bkmgm/vDIVYJ9+nBfRAaMZoJxbqQRSEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5Kh2fht; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc20e0f0ceso1949462a91.3;
        Thu, 20 Feb 2025 10:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740074981; x=1740679781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3l/TICtPB6aLyvVlXVnWR5r6Cz7ToaP43/KHj82QXRU=;
        b=N5Kh2fhtqrcGhs88zpMVpWSjLxkPOxNp8Q8bvckkHtNS/b1x7dntVEQ6rVAuru6Rd8
         XS5vvMRftTZVWF0LC0pNPi4rkOIPlz09HqoljMXb64ttUnxPk3jMF7YymF06zAmPeiU8
         Oyf6y20uRPiWK0+VKjJlk8YcBG+3vWedl8Io1VVfxLwDbclxaHL520VC/fVzqgTNiSWO
         cT+vM2kXpu2nmXzrYfiur92J3aSVZ4L21o6r9QoOu5Z/fxsmFO3iMb2Acq1hyoFclQy3
         RZhmJpr9yLcy7lQZ0cl+Ut/Tx0ATRWRic/yiaS8ybNy8nyQE5vpV/ggcg/k1+2ocal+i
         3w+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740074981; x=1740679781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3l/TICtPB6aLyvVlXVnWR5r6Cz7ToaP43/KHj82QXRU=;
        b=FhbpQOnX4rnqCeiF/8dkLepY8h6uxTJoIEMmI+ez7zVWMPCXnFFUg3xEBocxKw/+MA
         hTaGu4pCN83KXEBesUzgMHV/gc38d0Lc/Fzw2oLrbZQZbx0l2Npfo7Sa2OlF92x8Sowt
         JDEp2OKzb5KHCdlnGkcJBEhEoDezwJR87+UAiMPMdDE2VZWjNeU9dAOtPctAFhUgAFYv
         bKz+wrFUjnAkFKFgXebt9F7uW5BU+hFhEUxlHG/JAhtDjfWTZOUUH/CK0jF1ubswrBnL
         n3NvrFSxtxHHzTTlI0SSF2euCLpooOnXdR6bXn2hymEQIFLAcQUmAB7pAazR4N+4vdvo
         mo/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhx5h51a2to1Kur68v9ECbW4MA2sVPeaGdwI6JcA4s1q5sSPBRf6Z3GilvR++Yh1niOPDBPaRxJt36Y+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmE2gh2NqaQFQcVj7ZbjCX/2zf84J9MagkQKuyBzNl6wv0YFm1
	RI82ah3PgRQeTINdwB/ZhvfbC6TKKkhah2atuCqTelqVQOKV2XatHvQ/lg==
X-Gm-Gg: ASbGnct8/2FNzN+gdf5H49cX055DTFyc6d8PfKA9L9wAR29ZEoNfuY2XyT0bSGvopdo
	qNDTWEflTrJr93pfnoytdgnUbudNH/9qQeOYmqTluvfDjaPbg9dduQl6rA1mQV2KWGMckfjthn4
	wwhrIDsrDU9SL3HA0LEiw0kfWVrllmNFdw0siqhGAI7NhSNShu51s+O0HWyPXtFfktINwBujd2F
	urNzMHzotr8HBMxmhPvnJJjcajkbJqtQ0r3hDAU3dkDTxXeg4rt37TInSkTSo73nYxL62By5OxC
	Eazo2+15/uWqxlhq08YptCvQAdpLwFSqBA==
X-Google-Smtp-Source: AGHT+IFIiFKS1AS0Perub9V9/ASX6RDyGF1r5Cyup5Iyx3RkGjzyuclfJ7/ErYNUHDlLELKMZn7HJQ==
X-Received: by 2002:a17:90b:2792:b0:2ee:bbe0:98c6 with SMTP id 98e67ed59e1d1-2fce78aa3e2mr181511a91.8.1740074980380;
        Thu, 20 Feb 2025 10:09:40 -0800 (PST)
Received: from [192.168.50.123] ([117.147.90.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fcbdd600b2sm3249443a91.20.2025.02.20.10.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 10:09:39 -0800 (PST)
Message-ID: <0eee016f-2d37-4c80-98cf-fc134d3ad917@gmail.com>
Date: Fri, 21 Feb 2025 02:09:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND bpf-next v7 0/4] Add prog_kfunc feature probe
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, haoluo@google.com,
 jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250212153912.24116-1-chen.dylane@gmail.com>
 <2b025df3-144b-4909-a2b4-66356540f71c@gmail.com>
 <598a7d089936b18472937679d4131286f102cb18.camel@gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <598a7d089936b18472937679d4131286f102cb18.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/2/19 06:51, Eduard Zingerman 写道:
> On Mon, 2025-02-17 at 13:21 +0800, Tao Chen wrote:
>> 在 2025/2/12 23:39, Tao Chen 写道:
>>> More and more kfunc functions are being added to the kernel.
>>> Different prog types have different restrictions when using kfunc.
>>> Therefore, prog_kfunc probe is added to check whether it is supported,
>>> and the use of this api will be added to bpftool later.
>>>
>>> Change list:
>>> - v6 -> v7:
>>>     - wrap err with libbpf_err
>>>     - comments fix
>>>     - handle btf_fd < 0 as vmlinux
>>>     - patchset Reviewed-by: Jiri Olsa <jolsa@kernel.org>
>>> - v6
>>>     https://lore.kernel.org/bpf/20250211111859.6029-1-chen.dylane@gmail.com
>>>
>>> - v5 -> v6:
>>>     - remove fd_array_cnt
>>>     - test case clean code
>>> - v5
>>>     https://lore.kernel.org/bpf/20250210055945.27192-1-chen.dylane@gmail.com
>>>
>>> - v4 -> v5:
>>>     - use fd_array on stack
>>>     - declare the scope of use of btf_fd
>>> - v4
>>>     https://lore.kernel.org/bpf/20250206051557.27913-1-chen.dylane@gmail.com/
>>>
>>> - v3 -> v4:
>>>     - add fd_array init for kfunc in mod btf
>>>     - add test case for kfunc in mod btf
>>>     - refactor common part as prog load type check for
>>>       libbpf_probe_bpf_{helper,kfunc}
>>> - v3
>>>     https://lore.kernel.org/bpf/20250124144411.13468-1-chen.dylane@gmail.com
>>>
>>> - v2 -> v3:
>>>     - rename parameter off with btf_fd
>>>     - extract the common part for libbpf_probe_bpf_{helper,kfunc}
>>> - v2
>>>     https://lore.kernel.org/bpf/20250123170555.291896-1-chen.dylane@gmail.com
>>>
>>> - v1 -> v2:
>>>     - check unsupported prog type like probe_bpf_helper
>>>     - add off parameter for module btf
>>>     - check verifier info when kfunc id invalid
>>> - v1
>>>     https://lore.kernel.org/bpf/20250122171359.232791-1-chen.dylane@gmail.com
>>>
>>> Tao Chen (4):
>>>     libbpf: Extract prog load type check from libbpf_probe_bpf_helper
>>>     libbpf: Init fd_array when prog probe load
>>>     libbpf: Add libbpf_probe_bpf_kfunc API
>>>     selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests
>>>
>>>    tools/lib/bpf/libbpf.h                        |  19 ++-
>>>    tools/lib/bpf/libbpf.map                      |   1 +
>>>    tools/lib/bpf/libbpf_probes.c                 |  86 +++++++++++---
>>>    .../selftests/bpf/prog_tests/libbpf_probes.c  | 111 ++++++++++++++++++
>>>    4 files changed, 201 insertions(+), 16 deletions(-)
>>>
>>
>> Ping...
>>
>> Hi Andrii, Eduard,
>>
>> I've revised the previous suggestions. Please review it again. Thanks.
>>
> 
> I tried the test enumerating all kfuncs in BTF and doing
> libbpf_probe_bpf_kfunc for BPF_PROG_TYPE_{KPROBE,XDP}.
> (Source code at the end of the email).
> 
> The set of kfuncs returned for XDP looks correct.
> The set of kfuncs returned for KPROBE contains a few incorrect entries:
> - bpf_xdp_metadata_rx_hash
> - bpf_xdp_metadata_rx_timestamp
> - bpf_xdp_metadata_rx_vlan_tag
> 
> This is because of a different string reported by verifier for these
> three functions.
> 
> Ideally, I'd write some script looking for
> register_btf_kfunc_id_set(BPF_PROG_TYPE_***, kfunc_set)
> calls in the kernel source code and extracting the prog type /
> functions in the set, and comparing results of this script with
> output of the test below for all program types.
> But up to you if you'd like to do such rigorous verification or not.
> 
> Otherwise patch-set looks good to me, for all patch-set:
> 
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> 

Hi Eduard,

I try to run your test case, but it seems btf_is_decl_tag always return 
false, Are there any special restrictions for the tag feature of btf？

My compilation environment：

pahole --version
v1.29
clang --version
Ubuntu clang version 18.1.3 (1ubuntu1)

> --- 8< -----------------------------------------------------
> 
> static const struct {
> 	const char *name;
> 	int code;
> } program_types[] = {
> #define _T(n) { #n, BPF_PROG_TYPE_ ## n }
> 	_T(KPROBE),
> 	_T(XDP),
> #undef _T
> };
> 
> void test_libbpf_probe_kfuncs_many(void)
> {
> 	int i, kfunc_id, ret, id;
> 	const struct btf_type *t;
> 	struct btf *btf = NULL;
> 	const char *kfunc;
> 	const char *tag;
> 
> 	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
> 	if (!ASSERT_OK_PTR(btf, "btf_parse"))
> 		return;
> 
> 	for (id = 0; id < btf__type_cnt(btf); ++id) {
> 		t = btf__type_by_id(btf, id);
> 		if (!btf_is_decl_tag(t))
> 			continue;
> 		tag = btf__name_by_offset(btf, t->name_off);
> 		if (strcmp(tag, "bpf_kfunc") != 0)
> 			continue;
> 		kfunc_id = t->type;
> 		t = btf__type_by_id(btf, kfunc_id);
> 		if (!btf_is_func(t))
> 			continue;
> 		kfunc = btf__name_by_offset(btf, t->name_off);
> 		printf("[%-6d] %-42s ", kfunc_id, kfunc);
> 		for (i = 0; i < ARRAY_SIZE(program_types); ++i) {
> 			ret = libbpf_probe_bpf_kfunc(program_types[i].code, kfunc_id, -1, NULL);
> 			if (ret < 0)
> 				printf("%-8d  ", ret);
> 			else if (ret == 0)
> 				printf("%8s  ", "");
> 			else
> 				printf("%8s  ", program_types[i].name);
> 		}
> 		printf("\n");
> 	}
> 	btf__free(btf);
> }
> 
> ----------------------------------------------------- >8 ---
> 


-- 
Best Regards
Tao Chen

