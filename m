Return-Path: <bpf+bounces-63281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67CDB04D40
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 03:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14953A7063
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 01:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519CC145346;
	Tue, 15 Jul 2025 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QeCyX4pO"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6887D07D
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 01:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542200; cv=none; b=j3w2YTYyVQ+VmBqRYgTtMHBYxnJG2xbRKQCFhu3DPyhJ2BCc28+CLdU+mF18ko1+KuwuqmoS00zFApKzVgsx81+72OniIO/DXQlAcHh7BbW1XlYv81wyGSb3/GTgMfQPFX5S9d7j6XK0Yj83EKbzXlcDBdxVXaNQZm5bNZScY0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542200; c=relaxed/simple;
	bh=9k92YKaptooa+VBpByWXJfvSKO0YKIDW9HKV5jRCgw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaO4JNjixl0xm6ycFxvsWux77EI4OqnXzRhhrlFVs622hLA8ZnZHmQ/PZS126vowddrkgzdEr+vlkgMcyhvOU5H6L4T6fM848qSEs1HlpbrHQKk5IQ1OSA507HDPZcK2iyXojOQ1eaQcR9G/RIUoIUwclNGFEuU6ewrHefcmsCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QeCyX4pO; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d49172ce-c0d8-43df-bba9-d88a681228c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752542184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eI4+Uj5ZHVWz4/NaIet5nhFdtjuYqT3loM5WDkPMnQ8=;
	b=QeCyX4pOW+TVla4xi3+UbJxvIQFXlYpvof+nKNpjIWzeMka0G+4rLE9S6XDYHxdrpYy7nL
	e8qd3xN6BsmO8fZkRCeOhD9PMN6iAIBDTDaNWOv067a7kTl/zzAUgiQ9VwcBg295nPd9u0
	PaCbe+n9FtLkyZFF2/mBGxEROZnJyWA=
Date: Tue, 15 Jul 2025 09:15:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 12/18] libbpf: don't free btf if tracing_multi
 progs existing
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, rostedt@goodmis.org, jolsa@kernel.org,
 bpf@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 linux-kernel@vger.kernel.org
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-13-dongml2@chinatelecom.cn>
 <CAEf4Bza9mRvjwXU5gbOmOg_Ns=5OAX7-ybE=_wh79i7dwL=ZEw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Menglong Dong <menglong.dong@linux.dev>
In-Reply-To: <CAEf4Bza9mRvjwXU5gbOmOg_Ns=5OAX7-ybE=_wh79i7dwL=ZEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/15/25 06:07, Andrii Nakryiko wrote:
> On Thu, Jul 3, 2025 at 5:21 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
>> By default, the kernel btf that we load during loading program will be
>> freed after the programs are loaded in bpf_object_load(). However, we
>> still need to use these btf for tracing of multi-link during attaching.
>> Therefore, we don't free the btfs until the bpf object is closed if any
>> bpf programs of the type multi-link tracing exist.
>>
>> Meanwhile, introduce the new api bpf_object__free_btf() to manually free
>> the btfs after attaching.
>>
>> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>> ---
>>   tools/lib/bpf/libbpf.c   | 24 +++++++++++++++++++++++-
>>   tools/lib/bpf/libbpf.h   |  2 ++
>>   tools/lib/bpf/libbpf.map |  1 +
>>   3 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index aee36402f0a3..530c29f2f5fc 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -8583,6 +8583,28 @@ static void bpf_object_post_load_cleanup(struct bpf_object *obj)
>>          obj->btf_vmlinux = NULL;
>>   }
>>
>> +void bpf_object__free_btfs(struct bpf_object *obj)
> let's not add this as a new API. We'll keep BTF fds open, if
> necessary, but not (yet) give user full control of when those FDs will
> be closed, I'm not convinced yet we need that much user control over
> this


Okay! I previously thought that this would take up a certain amount of
memory, but it seems I was overthinking :/

I'll remove this API in the next version.

Thanks!
Menglong Dong


>
>
>> +{
>> +       if (!obj->btf_vmlinux || obj->state != OBJ_LOADED)
>> +               return;
>> +
>> +       bpf_object_post_load_cleanup(obj);
>> +}
>> +
>> +static void bpf_object_early_free_btf(struct bpf_object *obj)
>> +{
>> +       struct bpf_program *prog;
>> +
>> +       bpf_object__for_each_program(prog, obj) {
>> +               if (prog->expected_attach_type == BPF_TRACE_FENTRY_MULTI ||
>> +                   prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
>> +                   prog->expected_attach_type == BPF_MODIFY_RETURN_MULTI)
>> +                       return;
>> +       }
>> +
>> +       bpf_object_post_load_cleanup(obj);
>> +}
>> +
>>   static int bpf_object_prepare(struct bpf_object *obj, const char *target_btf_path)
>>   {
>>          int err;
>> @@ -8654,7 +8676,7 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
>>                          err = bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_maps);
>>          }
>>
>> -       bpf_object_post_load_cleanup(obj);
>> +       bpf_object_early_free_btf(obj);
>>          obj->state = OBJ_LOADED; /* doesn't matter if successfully or not */
>>
>>          if (err) {
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index d1cf813a057b..7cc810aa7967 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -323,6 +323,8 @@ LIBBPF_API struct bpf_program *
>>   bpf_object__find_program_by_name(const struct bpf_object *obj,
>>                                   const char *name);
>>
>> +LIBBPF_API void bpf_object__free_btfs(struct bpf_object *obj);
>> +
>>   LIBBPF_API int
>>   libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
>>                           enum bpf_attach_type *expected_attach_type);
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index c7fc0bde5648..4a0c993221a5 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -444,4 +444,5 @@ LIBBPF_1.6.0 {
>>                  bpf_program__line_info_cnt;
>>                  btf__add_decl_attr;
>>                  btf__add_type_attr;
>> +               bpf_object__free_btfs;
>>   } LIBBPF_1.5.0;
>> --
>> 2.39.5
>>
>>

