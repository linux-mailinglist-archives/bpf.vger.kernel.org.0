Return-Path: <bpf+bounces-54877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86844A751AE
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 21:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7E6189300E
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 20:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B991E9B0E;
	Fri, 28 Mar 2025 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9oPwOvb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007BC126C02
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743195282; cv=none; b=fYgrjy5fLUc5+RDqz9MbeiA04ofu2BGwwsH8gnC8h8iJkGI6bpevrVY1+777TdoWEqhtJVzQqF7nyh4MmMnjlPKFmuF9KcfF4gBHgqlSEIVqHHUoLs9ruWEmp/X86bBbYwl1BxOhgt0tJjeoYOIS1hDLhOv0KSUwwuK8e0Os1jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743195282; c=relaxed/simple;
	bh=xpIM2a0blNAHVqr21bsCjkCF7zbv7LgzB9cfad2OaQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4y1nha9B5zAZQxPSzaNkVeG7g3aqcpZWK31gYjCsO50axiB7u777FRe4EP/tufegw/kZ39ZsbQBnkZ3v+7RQnLU1gzVtz9l7iKXcAAFttefXKy0Ji4b94cSvv76aR0wJGvjFVeMveR1HmG3KrvVZGLIfeo3f0qQI+LZm7plYfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9oPwOvb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so15060395e9.2
        for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 13:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743195279; x=1743800079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IghnhvPVByGifBLY5vutYbNslNOARSAdR654BM9R5Zs=;
        b=S9oPwOvbY+zM9ef8T2gwcccCxOQ0+gQ5RPej8L1JRB5u+hEj4DN4iQgLusuEIf+Rhe
         BGWAV6IoTpLqxAuiXB8QwZtQ/ZvgSw1VGbZ6f7a0axBifV4NM/xu2ElFhMYScVMqN8HI
         4ruRWQT8ZsC+jECdO9eUlO8z/0nOdgeuVmSIIw/Jn4EXKVs0Iv7PTZoJ5ApTOfXflYEO
         7yrMeV/b8FQtn0T77auY630DYimYWIfEVIpIJ7sZniZwY7Jdmuz32R/jgWAT1xyUzs/B
         u2oCDzdlKsDmSjzrbxoyW6MnP5PUaP9BvF9EzmoIa0npaS6S2kiRqLD0rl+Jjb/16rKh
         3EbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743195279; x=1743800079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IghnhvPVByGifBLY5vutYbNslNOARSAdR654BM9R5Zs=;
        b=ZVMvfvwvKU842hwbfDaWOhj7mpr7VsBxTjLKdbGry5ZoO8LMbHWskfKyDyVqG2nSyX
         ZFrFKNYS4H6n5+B1HkY7ms6qGL4mw5G2EDnKvZCxYUrgzt3K9mIQFXgA2EhKHq5wgpQa
         Pp6K9XVSk0Xr9rP0/8txdYoaVdXtOtF5W3Wt5W5HAsnvZJRkaiWFugmKmswBGlATDjz9
         JmA8H8D4OIp26kFUc+/4LHT8fFwUPua7jFHjIaEhMSyb3w+wy1QvrFtTfuqcYvv0BPIg
         FJnJTZr5GSmMHwssCsOm3NdE8b/jA0zx216y7U9N66aXWeKyXzn/Bj4h0u4hA+XpP6qt
         9pqw==
X-Gm-Message-State: AOJu0YzdrDEydFwVqQDwk2vzNtCen05tq/m4JMQHNFt9vcrUJBtP7XKg
	cJSkofyHoKx969AurS/c2ry91d6oTaa5NS5taHHyGPLeOIXuLCnt
X-Gm-Gg: ASbGncsajCxKVSfPlzH5doFmDKUfcO/AfCIcTPTgbNxe8ghTvd8ovs9eKmZQBfjknWB
	bH4vT4edKDBB/Y+eIzODk+ztYHFYruAcBCyo/dc9UuiWHgwgNhEa+Xjuk5TbnTaRIMkJ0z+LzTk
	DKNEcK0dWTVbXZ3ZfZGztsTyCh5PDjjgHnzBqo88shnUkgNFj4pZG6HDE9jUiMQSF86uRnKM9WM
	hNbDMwHNP/BmgkrZizaq5sSi8Usbscsboulu+ekJmMYnZnyAppk5LesUBMRQWMZD09I/laFLawN
	b9YqwIrRn+RDKAeEDLJIpgSMz7MXu5rHjZU9FLwPOWI3qNALNTiiSchGaAybdx27aaKD2B+gHSd
	2CGLQtvcN7epJ/Dz6o3+V3wOhog==
X-Google-Smtp-Source: AGHT+IHp7s/zTT9qQyi3ALrvHzYZVuYL/5AzpjLy483VFfPnO/ukxyt5L1W3vVGB9340U49utIVF9g==
X-Received: by 2002:adf:9c8a:0:b0:39c:1258:2dc7 with SMTP id ffacd0b85a97d-39c12582deemr358976f8f.56.1743195278919;
        Fri, 28 Mar 2025 13:54:38 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10? ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efe9d1sm82045225e9.24.2025.03.28.13.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 13:54:38 -0700 (PDT)
Message-ID: <fe7db355-f363-46dc-95d4-9fbc39d5d925@gmail.com>
Date: Fri, 28 Mar 2025 20:54:32 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] libbpf: add getters for BTF.ext func and line
 info
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250326180714.44954-1-mykyta.yatsenko5@gmail.com>
 <CAEf4BzY_rbdXFDyYN=s7c25R5kwpBX5-zxQd8Q+6wX2N0r6Uhw@mail.gmail.com>
 <196c2eb9-aca9-4533-b927-255569154a73@gmail.com>
 <CAEf4BzYBWGHT56b5QAN9VD2viVpgLWTH-SXosPqYjqvfbLpqCg@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzYBWGHT56b5QAN9VD2viVpgLWTH-SXosPqYjqvfbLpqCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/03/2025 20:52, Andrii Nakryiko wrote:
> On Fri, Mar 28, 2025 at 12:16 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> On 28/03/2025 17:14, Andrii Nakryiko wrote:
>>> On Wed, Mar 26, 2025 at 11:07 AM Mykyta Yatsenko
>>> <mykyta.yatsenko5@gmail.com> wrote:
>>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>>
>>>> Introducing new libbpf API getters for BTF.ext func and line info,
>>>> namely:
>>>>     bpf_program__func_info
>>>>     bpf_program__func_info_cnt
>>>>     bpf_program__func_info_rec_size
>>>>     bpf_program__line_info
>>>>     bpf_program__line_info_cnt
>>>>     bpf_program__line_info_rec_size
>>>>
>>>> This change enables scenarios, when user needs to load bpf_program
>>>> directly using `bpf_prog_load`, instead of higher-level
>>>> `bpf_object__load`. Line and func info are required for checking BTF
>>>> info in verifier; verification may fail without these fields if, for
>>>> example, program calls `bpf_obj_new`.
>>>>
>>> Really, bpf_obj_new() needs func_info/line_info? Can you point where
>>> in the verifier we check this, curious why we do that.
>> Indirectly, yes:
>> in verifier.c function check_btf_info_early sets
>> `env->prog->aux->btf = btf;`
>> only if line_info_cnt or func_info_cnt are non zero.
>> and then there is a check that errors out:
>> `verbose(env, "bpf_obj_new/bpf_percpu_obj_new requires prog BTF\n");`
>> perhaps this can be improved as well, by setting aux->btf even if no
>> func info and line info
> lol, doesn't seem intentional (just in the early days prog BTF was
> only referenced and used with func_info/line_info, which isn't true
> anymore), we can probably swap the order and load and remember prog
> BTF regardless of func_info/line_info. Feel free to send a patch.
Sure, I'll do it.
>>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>>> ---
>>>>    tools/lib/bpf/libbpf.c   | 30 ++++++++++++++++++++++++++++++
>>>>    tools/lib/bpf/libbpf.h   |  8 ++++++++
>>>>    tools/lib/bpf/libbpf.map |  6 ++++++
>>>>    3 files changed, 44 insertions(+)
>>>>
> [...]
>
>>>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>>>> index d8b71f22f197..a5d83189c084 100644
>>>> --- a/tools/lib/bpf/libbpf.map
>>>> +++ b/tools/lib/bpf/libbpf.map
>>>> @@ -437,6 +437,12 @@ LIBBPF_1.6.0 {
>>>>                   bpf_linker__add_fd;
>>>>                   bpf_linker__new_fd;
>>>>                   bpf_object__prepare;
>>>> +               bpf_program__func_info;
>>>> +               bpf_program__func_info_cnt;
>>>> +               bpf_program__func_info_rec_size;
>>>> +               bpf_program__line_info;
>>>> +               bpf_program__line_info_cnt;
>>>> +               bpf_program__line_info_rec_size;
> nit: hm... please check tabs vs spaces, formatting looks off
>
>>>>                   btf__add_decl_attr;
>>>>                   btf__add_type_attr;
>>>>    } LIBBPF_1.5.0;
>>>> --
>>>> 2.48.1
>>>>


