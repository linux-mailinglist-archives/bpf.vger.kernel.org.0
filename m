Return-Path: <bpf+bounces-53760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10A1A5A2EB
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 19:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286A43ADBA6
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 18:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345A0155393;
	Mon, 10 Mar 2025 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HSX7AOME"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DC22356D1
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631411; cv=none; b=PxgvkRSxE8ZqfRCIytL3E34o5bHDbltRAUC4ghq46slf+ymijBOivsDQExP3KCHc7v94+zxJ4uxPAANs4OZe3HzQy0NjiMJ65QljqHguyxgx3MzHG/wdzbQCx7DklMGzPJNGt0621dBHB9UVYOIJOZ0YY5eOO4cJsoxYiz2yQzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631411; c=relaxed/simple;
	bh=+ZP3jmvStE6Qrdwff9NEI7qBygDbUmljM374r5sKJW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/lsKnS18oKW+h7fK36WukDHdVPIFZ6yTTiJQWR0HACeTPdL3z7SUnqjWuoWxT4G5Y9pgpxIHdld+sh0ncoB9srzEJCIKJGfZ7+3eU/e5Mi2+IOqUp2VCpDF9/gugxFR6Ut0qBosFDlECSCaI/i0E9/pXEPza85rDeI190xUoWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HSX7AOME; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <215a0921-5c62-4fae-b968-6151d3152244@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741631405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K44AZmozAvm6vRdyBP23AJYQ5IMnWIJEcIatFnuHX+c=;
	b=HSX7AOMEzmU70ZUDHjPju8Cgl2VcU4uOmmirK5rRPVmCD+OLmbjfIveM3+R+smrrm3u3vf
	43rTN7idPnQZKj09rGrSgPuvfn/0oUtkOiQrzPjRqYjbxS4pCHpSdutn13FxDcF7lZVGfr
	PrDK786vRI/q3M3S1OYzAQycMc2wSck=
Date: Mon, 10 Mar 2025 11:29:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/4] bpf: BPF token support for
 BPF_BTF_GET_FD_BY_ID
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, olsajiri@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250310001319.41393-1-mykyta.yatsenko5@gmail.com>
 <20250310001319.41393-2-mykyta.yatsenko5@gmail.com>
 <CAEf4BzbwD62Q1W6KQnjzAvKULcihKG0VtYdJRr1wD0RS9=eJAw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzbwD62Q1W6KQnjzAvKULcihKG0VtYdJRr1wD0RS9=eJAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 3/10/25 8:57 AM, Andrii Nakryiko wrote:
> On Sun, Mar 9, 2025 at 5:13 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Currently BPF_BTF_GET_FD_BY_ID requires CAP_SYS_ADMIN, which does not
>> allow running it from user namespace. This creates a problem when
>> freplace program running from user namespace needs to query target
>> program BTF.
>> This patch relaxes capable check from CAP_SYS_ADMIN to CAP_BPF and adds
>> support for BPF token that can be passed in attributes to syscall.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   include/uapi/linux/bpf.h                      |  1 +
>>   kernel/bpf/syscall.c                          | 21 ++++++++++++++++---
>>   tools/include/uapi/linux/bpf.h                |  1 +
>>   .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |  3 +--
>>   4 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index bb37897c0393..73c23daacabf 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1652,6 +1652,7 @@ union bpf_attr {
>>                  };
>>                  __u32           next_id;
>>                  __u32           open_flags;
>> +               __s32           token_fd;
>>          };
>>
>>          struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 57a438706215..eb3a31aefa70 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -5137,17 +5137,32 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
>>          return btf_new_fd(attr, uattr, uattr_size);
>>   }
>>
>> -#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
>> +#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD token_fd
>>
>>   static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
>>   {
>> +       struct bpf_token *token = NULL;
>> +
>>          if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
>>                  return -EINVAL;
>>
>> -       if (!capable(CAP_SYS_ADMIN))
>> -               return -EPERM;
>> +       if (attr->open_flags & BPF_F_TOKEN_FD) {
>> +               token = bpf_token_get_from_fd(attr->token_fd);
>> +               if (IS_ERR(token))
>> +                       return PTR_ERR(token);
>> +               if (!bpf_token_allow_cmd(token, BPF_BTF_GET_FD_BY_ID))
>> +                       goto out;
> Look at map_create() and its handling of BPF token. If
> bpf_token_allow_cmd() returns false, we still perform
> bpf_token_capable(token, <cap>) check (where token will be NULL, so
> it's effectively just capable() check). While here you will just
> return -EPERM *even if the process actually has real CAP_SYS_ADMIN*
> capability.
>
> Instead, do:
>
> bpf_token_put(token);
> token = NULL;
>
> and carry on the rest of the logic

It looks like my earlier suggestion, which leads to this version,
is incorrect. Sorry about this. I need to dig out a little more
for func cap_capable_helper(). But it is apparent that
task cred is used for capability checking.

>
> pw-bot: cr
>
>
>> +       }
>> +
>> +       if (!bpf_token_capable(token, CAP_SYS_ADMIN))
>> +               goto out;
>> +
>> +       bpf_token_put(token);
>>
>>          return btf_get_fd_by_id(attr->btf_id);
>> +out:
>> +       bpf_token_put(token);
>> +       return -EPERM;
>>   }
>>
>>   static int bpf_task_fd_query_copy(const union bpf_attr *attr,
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index bb37897c0393..73c23daacabf 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -1652,6 +1652,7 @@ union bpf_attr {
>>                  };
>>                  __u32           next_id;
>>                  __u32           open_flags;
>> +               __s32           token_fd;
>>          };
>>
>>          struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
>> diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
>> index a3f238f51d05..976ff38a6d43 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
>> @@ -75,9 +75,8 @@ void test_libbpf_get_fd_by_id_opts(void)
>>          if (!ASSERT_EQ(ret, -EINVAL, "bpf_link_get_fd_by_id_opts"))
>>                  goto close_prog;
>>
>> -       /* BTF get fd with opts set should not work (no kernel support). */
>>          ret = bpf_btf_get_fd_by_id_opts(0, &fd_opts_rdonly);
>> -       ASSERT_EQ(ret, -EINVAL, "bpf_btf_get_fd_by_id_opts");
>> +       ASSERT_EQ(ret, -ENOENT, "bpf_btf_get_fd_by_id_opts");
> Why would your patch change this behavior? and if it does, should it?
> This looks fishy.
>
>>   close_prog:
>>          if (fd >= 0)
>> --
>> 2.48.1
>>


