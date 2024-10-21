Return-Path: <bpf+bounces-42680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1079A915F
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 22:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565A02832C4
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 20:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB2F1FDFB1;
	Mon, 21 Oct 2024 20:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUTQsbmS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5B21F9401
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 20:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543099; cv=none; b=AnZiuh9gxwbh5TrBBgaPrcysDga2wHoUutC572CQvH9TB818Zo52W6hRRHPcQtfp6ZVOEHIjngS0vfA1yGyxGoHzUzzPkC7+HjP890gQaTiRUERwZSyJjSa/MUh16qoAXvtSE0KzK1b2Kl9y2pMBk2MVuMvGa8RceV9CHnzSLLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543099; c=relaxed/simple;
	bh=MT7CRsc4iZKFbUhU71nmb8uvzd0zEkU33MZ+k2r0dYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6OrhiWu/7HqjKEOUgw0sUZp/Kn4Pa3QVIz+A9Wb8K2rf8ysDxFyFi4qehULmckeU9PECu8lV30L+EFfN2mEhxlVhXiIyCScvO/JN1K1NxLd0QECbcBSt9dHPKBsKl9yNt9+yu8UyD4JQMx+bTCfMRH/PN1Z2bwK1NF5ruQs4aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUTQsbmS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a68480164so451671566b.3
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 13:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729543095; x=1730147895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GI7DKjn52Dgf5DZAao+vX0QFa9uwL1ibDjNak6iGooc=;
        b=GUTQsbmS2fTS5FpJfBWD8Ok3/xizBudBM25c8MIXmMRFrFdQm6X4ZVnReR6g2vDK5+
         wNFM/p5q3S7A1+L7W0V4gFKjmPi8xDly4X+h2WxHNXV6VhU8JLqdCgm1VAdcb/4+XRgc
         HGsZdh0mQM7EcW6RamRu+wWbgcjAJ/v+yTiOYU5k/Q0aaQ6nXXpmv07HWxCJpVOB695D
         QIPljex8W5/Jfm8RLMLBeUKbc7PVPsMcOZzKuryVNfjk0NwpvmdhjjH+biCrg2pnVlwf
         7EjlCh95th5bf1v41N5YNQU9PUCt8SjIgtHO3jeZBvptUoxNRpTiglcSh0oZmnVFooUH
         GYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729543095; x=1730147895;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GI7DKjn52Dgf5DZAao+vX0QFa9uwL1ibDjNak6iGooc=;
        b=ggt/Yxpm5StrJUqlltyTVl/lBps76izAETLCJom9aiEQCtiBI2VHMPKkDSIC/tBDWJ
         u9XWbKeVR3P//0sioqr+TtsKmygtWHFI+JlG9HdnYlFsplgxL6wlYGKjEgPRXfgLlGKC
         GHJlngDlx+A5smkB8nsQV56LKUaFDWCb6kVjWlcj9gRkTS9icyCWhiZIJ/pC+GXII2UA
         GAGO0tfouXYqrB/lbqUIyldvX8x+B/GdYXHL0/Kntg5egrjUu/J8qmzo/XQmpr6mJWUb
         DLStexH6NpYQVWfLieU5dtbT0/9sJupcT/cXuVV8h2LJKepZKo1w5ee7VuGDJokDSXb+
         H5Ww==
X-Gm-Message-State: AOJu0YyBj7Vtv7AyHjMq2uhRqJCQfbDQs3HMQS0wlaZwfJiCcKECPeRJ
	oPIck/yElojxDuz7ZaAL2lMgn+/i0Cb0QX639EB0AVAAmKo1JCdt
X-Google-Smtp-Source: AGHT+IFN2RGnFCTyP1vYeytTrHJTu5Z1PyEbhFqOXz/lvSpykUpxPFSyni9pka4Yfq2QBLOrUxuN6w==
X-Received: by 2002:a17:906:7309:b0:a9a:b9d:bd93 with SMTP id a640c23a62f3a-a9a69a64dafmr1550974666b.4.1729543094618;
        Mon, 21 Oct 2024 13:38:14 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a302:ae00:2a0:8923:a788:9a73? ([2a02:8109:a302:ae00:2a0:8923:a788:9a73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a913706d3sm251448966b.134.2024.10.21.13.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 13:38:14 -0700 (PDT)
Message-ID: <62548877-522e-42bb-83c9-588e02c2bbb4@gmail.com>
Date: Mon, 21 Oct 2024 21:38:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: increase verifier log limit in
 veristat
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20241021141616.95160-1-mykyta.yatsenko5@gmail.com>
 <ZxaE_C_Im9-I8OSa@krava>
 <CAEf4BzZ6b7drmHJN=Sf8Mjq6VB1Drg5g0LyeyN4URCRS63qTzA@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzZ6b7drmHJN=Sf8Mjq6VB1Drg5g0LyeyN4URCRS63qTzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/10/2024 21:14, Andrii Nakryiko wrote:
> On Mon, Oct 21, 2024 at 9:44 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>> On Mon, Oct 21, 2024 at 03:16:16PM +0100, Mykyta Yatsenko wrote:
>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>
>>> The current default buffer size of 16MB allocated by veristat is no
>>> longer sufficient to hold the verifier logs of some production BPF
>>> programs. To address this issue, we need to increase the verifier log
>>> limit.
>>> Commit 7a9f5c65abcc ("bpf: increase verifier log limit") has already
>>> increased the supported buffer size by the kernel, but veristat users
>>> need to explicitly pass a log size argument to use the bigger log.
>>>
>>> This patch adds a function to detect the maximum verifier log size
>>> supported by the kernel and uses that by default in veristat.
>>> This ensures that veristat can handle larger verifier logs without
>>> requiring users to manually specify the log size.
>>>
>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>> ---
>>>   tools/testing/selftests/bpf/veristat.c | 40 +++++++++++++++++++++++++-
>>>   1 file changed, 39 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
>>> index c8efd44590d9..1d0708839f4b 100644
>>> --- a/tools/testing/selftests/bpf/veristat.c
>>> +++ b/tools/testing/selftests/bpf/veristat.c
>>> @@ -16,10 +16,12 @@
>>>   #include <sys/stat.h>
>>>   #include <bpf/libbpf.h>
>>>   #include <bpf/btf.h>
>>> +#include <bpf/bpf.h>
>>>   #include <libelf.h>
>>>   #include <gelf.h>
>>>   #include <float.h>
>>>   #include <math.h>
>>> +#include <linux/filter.h>
> this is kernel-internal header, which will be a problem for Github mirror, so...
>
>>>   #ifndef ARRAY_SIZE
>>>   #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>>> @@ -1109,6 +1111,42 @@ static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const ch
>>>        return;
>>>   }
>>>
>>> +static int max_verifier_log_size(void)
>>> +{
>>> +     const int big_log_size = UINT_MAX >> 2;
>>> +     const int small_log_size = UINT_MAX >> 8;
> nit: MAKE_ALL_CAPS, given they are fixed constants
>
>>> +     struct bpf_insn insns[] = {
>>> +             BPF_MOV64_IMM(BPF_REG_0, 0),
>>> +             BPF_EXIT_INSN(),
> ... let's instead either define these macro locally or just hard-code
> bpf_insn structs as is (thankfully we need just two)
>
>>> +     };
>>> +     int ret, insn_cnt = ARRAY_SIZE(insns);
>>> +     char *log_buf;
>>> +     static int log_size;
>>> +
>>> +     if (log_size != 0)
>>> +             return log_size;
>>> +
>>> +     log_size = small_log_size;
>>> +     log_buf = malloc(big_log_size);
> we don't really need to allocate anything. We can pass (void*)-1 as
> log_buf (invalid pointer), set size to UINT_MAX >> 8, log_level = 4.
> If the kernel doesn't support big log_size, we'll get -EINVAL. If it
> does, we'll get -EFAULT when the verifier will try to write something
> to the buffer. No allocation.
>
> pw-bot: cr
>
>> IIUC this would try to use 1GB by default? seems to agresive.. could we perhaps
>> do that gradually and double the size on each failed load attempt?
> The idea is that verifier will only page in as many pages as there is
> an actual log content (which normally would be much smaller than a
> full 1GB). Doing gradual size increase is actually pretty annoying in
> terms of how the code and logic is structured. So I think this
> approach is fine, overall.
>
>> jirka
>>
>>
>>> +
>>> +     if (!log_buf)
>>> +             return log_size;
>>> +
>>> +     LIBBPF_OPTS(bpf_prog_load_opts, opts,
>>> +                 .log_buf = log_buf,
>>> +                 .log_size = big_log_size,
>>> +                 .log_level = 2
> no need for log_level = 2, just use 4, we don't need to fill out the
> buffer, we need a verifier to check parameters.
>
>>> +     );
> LIBBPF_OPTS() macro define a variable, so please move it to the
> variable declaration block above.
>
>>> +     ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &opts);
> nit: let's use TRACEPOINT instead, we had some problems with
> SOCKET_FILTER on some old Red Hat distro due to how they did selective
> backport, so best to avoid it, if possible.
>
>>> +     free(log_buf);
>>> +
>>> +     if (ret > 0) {
>>> +             log_size = big_log_size;
>>> +             close(ret);
>>> +     }
>>> +     return log_size;
>>> +}
>>> +
>>>   static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
>>>   {
>>>        const char *base_filename = basename(strdupa(filename));
>>> @@ -1132,7 +1170,7 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>>>        memset(stats, 0, sizeof(*stats));
>>>
>>>        if (env.verbose || env.top_src_lines > 0) {
>>> -             buf_sz = env.log_size ? env.log_size : 16 * 1024 * 1024;
>>> +             buf_sz = env.log_size ? env.log_size : max_verifier_log_size();
>>>                buf = malloc(buf_sz);
>>>                if (!buf)
>>>                        return -ENOMEM;
>>> --
>>> 2.47.0
>>>
>>>
Thanks for taking a look, I'll apply your suggestions for v2.



