Return-Path: <bpf+bounces-26141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F2389B702
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 06:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3321C20D4B
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 04:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A326FBE;
	Mon,  8 Apr 2024 04:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TMKi3eW0"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8041FC8
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 04:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712552063; cv=none; b=NlBNkITG6yHKAZjgwn041ZkFhC1iYYR3YEOli1InhUWBhzc4REhkmi7PxAq5XHcel/hCNjoAqCbBF+4lt2Vtda0B9FZxzZEyt4KkJHbZhAeaMtR2fh7W85carfNts8SvEt5E8bdetGr+X8NuVzlJFaFo7GnAjxm3tOpmZwIUZ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712552063; c=relaxed/simple;
	bh=hZyBsAl4qJ87Ia9PLQz2+BSVk/ugNbtDPlsYxYvd6bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OavaevNG0XzB8lSFmSajlrZxnPDoDy2bkO37jWZzN6oHpFTkNgfiqhB0rhnJNxadpZqtvbiu7trFklQVu2+Qx9TY7NQo8z2hdsrOeejgLT/aOGZtmO9MPjYuG/08BNYciYACLHQSmappPbnqkc05uV/FGN80WbEvsWhiaCvBfzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TMKi3eW0; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7ee00a0b-0899-4911-9b68-babf3bc07c3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712552059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcCh29ZsIZYAK1F/eg2mgtTrkUlkBI9tArVddzqZ33c=;
	b=TMKi3eW0kUU/plV38wIviGXa9Kbvv0wtciwHc0Ye/SAKEprkfCFC/bvXGjiXtKQSJUzKSi
	0evc76HIK4GJTKXyMHz8Ynp5yjj1hiRAGkxDQCr3FGwtFkFcAqlk28QGJywZEnGjUb99yS
	vIJKvZGn4ipISqB3eVuypPtYEYjmNsE=
Date: Sun, 7 Apr 2024 21:54:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/5] libbpf: Add bpf_link support for
 BPF_PROG_TYPE_SOCKMAP
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>
References: <20240406160359.176498-1-yonghong.song@linux.dev>
 <20240406160409.178297-1-yonghong.song@linux.dev>
 <CAEf4BzYpoANeuoWX4EHktf3hffDejLYmvL89sjy3NZv35aC+3A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzYpoANeuoWX4EHktf3hffDejLYmvL89sjy3NZv35aC+3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/6/24 11:49 AM, Andrii Nakryiko wrote:
> On Sat, Apr 6, 2024 at 9:04 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Introduce a libbpf API function bpf_program__attach_sockmap()
>> which allow user to get a bpf_link for their corresponding programs.
>>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/lib/bpf/libbpf.c         | 7 +++++++
>>   tools/lib/bpf/libbpf.h         | 2 ++
>>   tools/lib/bpf/libbpf.map       | 5 +++++
>>   tools/lib/bpf/libbpf_version.h | 2 +-
>>   4 files changed, 15 insertions(+), 1 deletion(-)
>>
> I feel like I mentioned this before, but maybe not. Besides there
> high-level attach APIs, please also add bpf_link_create() support, it
> should be very straightforward, just follow the pattern for other link
> types.

I checked bpf_link_create() in bpf.c. bpf_link_create() works now
without any additional change sicne it does not need to set anything
in option arguments. I will add a test to use bpf_link_create()
for one of sk_msg or sk_skb programs.

>
> You'll also get a conflict in libbpf.map given I just applied another
> libbpf patches (ring_buffer__consume_n). So please rebase.

Ack.

>
> pw-bot: cr
>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index b091154bc5b5..97eb6e5dd7c8 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -149,6 +149,7 @@ static const char * const link_type_name[] = {
>>          [BPF_LINK_TYPE_TCX]                     = "tcx",
>>          [BPF_LINK_TYPE_UPROBE_MULTI]            = "uprobe_multi",
>>          [BPF_LINK_TYPE_NETKIT]                  = "netkit",
>> +       [BPF_LINK_TYPE_SOCKMAP]                 = "sockmap",
>>   };
>>
>>   static const char * const map_type_name[] = {
>> @@ -12533,6 +12534,12 @@ bpf_program__attach_netns(const struct bpf_program *prog, int netns_fd)
>>          return bpf_program_attach_fd(prog, netns_fd, "netns", NULL);
>>   }
>>
>> +struct bpf_link *
>> +bpf_program__attach_sockmap(const struct bpf_program *prog, int map_fd)
>> +{
>> +       return bpf_program_attach_fd(prog, map_fd, "sockmap", NULL);
>> +}
>> +
>>   struct bpf_link *bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex)
>>   {
>>          /* target_fd/target_ifindex use the same field in LINK_CREATE */
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index f88ab50c0229..4c7ada03bf4f 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -795,6 +795,8 @@ bpf_program__attach_cgroup(const struct bpf_program *prog, int cgroup_fd);
>>   LIBBPF_API struct bpf_link *
>>   bpf_program__attach_netns(const struct bpf_program *prog, int netns_fd);
>>   LIBBPF_API struct bpf_link *
>> +bpf_program__attach_sockmap(const struct bpf_program *prog, int map_fd);
>> +LIBBPF_API struct bpf_link *
>>   bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex);
>>   LIBBPF_API struct bpf_link *
>>   bpf_program__attach_freplace(const struct bpf_program *prog,
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 51732ecb1385..2d0ca3e8ec18 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -416,3 +416,8 @@ LIBBPF_1.4.0 {
>>                  btf__new_split;
>>                  btf_ext__raw_data;
>>   } LIBBPF_1.3.0;
>> +
>> +LIBBPF_1.5.0 {
>> +       global:
>> +               bpf_program__attach_sockmap;
>> +} LIBBPF_1.4.0;
>> diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
>> index e783a47da815..d6e5eff967cb 100644
>> --- a/tools/lib/bpf/libbpf_version.h
>> +++ b/tools/lib/bpf/libbpf_version.h
>> @@ -4,6 +4,6 @@
>>   #define __LIBBPF_VERSION_H
>>
>>   #define LIBBPF_MAJOR_VERSION 1
>> -#define LIBBPF_MINOR_VERSION 4
>> +#define LIBBPF_MINOR_VERSION 5
>>
>>   #endif /* __LIBBPF_VERSION_H */
>> --
>> 2.43.0
>>

