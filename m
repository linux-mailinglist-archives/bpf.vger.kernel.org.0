Return-Path: <bpf+bounces-40105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8893597CA5A
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 15:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03105B22DAA
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 13:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4658519F471;
	Thu, 19 Sep 2024 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLnXwY/P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2919F414;
	Thu, 19 Sep 2024 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726753570; cv=none; b=AFZRuvObS9d8rj2LX8/4AdsgSQZLTtmKyDeg9j3GlEljc/RXZj1MjuIbMjne83zO1HHzWzYYOk478iaM5YLj4tlIIFd9xQ6h5GmwxpsGBRf9CO55a3tkM/tYvJViZx22Mk7QwGc5orv/K1E9RxYm7JZAPJ78YO3BjvGVvGzB+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726753570; c=relaxed/simple;
	bh=TJXGBdhjECs1nxrMwVaHxIRZ7I1I6Fd4bTeaZwACRTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcqGi+/2tH7UjfIag1oUxBcn5Nblqtaaimm/B41Z9Jms1rlfZhX5iARKoGr9BYe7f1rtDS3BT2rzKCtHb9jHlFkhL9SJeW0KeKfFTFOxT5K/dgyavSBNSJ/clBhHtVQT3uheGMPSHIvvOUNJOz3ABwBgfgZaKM7+dyUMynmN8Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLnXwY/P; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7191fb54147so638096b3a.2;
        Thu, 19 Sep 2024 06:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726753569; x=1727358369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDD/hmh5p/hnVuAXd5jUE9QmV4PZ74xoj/KeQLWdWCY=;
        b=DLnXwY/P2u3GjnXDZvJRa8aGc9nadllhYzYa2V/5TyKsMlm5Y4cjEkg1F9E3X/lSp4
         T2m8B1LEFDxI5VEYeIRN0/rCJDEalTpWpqiqW43hWdiiupn0b8nEIVBe8Oqm7pOrsDpG
         x8dN9EwPQAURgUoV9TqDajaFR0D0+rD5PorIzG7XRqiygDZ91Oe9WhpU4loUVJZF4hTq
         1cEu+srboFaX4pvo/TUIEvq8sKcQ/UnKRGOgBrx1ossI0Tj6EXYBaRCwYCizhka5cHvk
         Rx/9nxY9MM/e526FzqhVsZmYKwezggi4TNxD8O8O3VZq5A6XRvczr/d68m0BVEf0vRSU
         nkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726753569; x=1727358369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nDD/hmh5p/hnVuAXd5jUE9QmV4PZ74xoj/KeQLWdWCY=;
        b=iB160uhj3jEinP0J7TuIpTN453Ymz049BgEGPNKzkeV0h4kSeDh4XM7nMt76FNKEWK
         svlVr1dExXVIBTgGTxrwRS/Xc0AtQwrzkajIHC0HlXaIvVDyBxIdI25rEiJdL0Zmq8+m
         sHcRg4pFXd1Qn/Yg9uxFo2Ci+wSaKV2Xwrvr1ZikbOcbBUcd2gKjrAYbUOzIz3oQraiP
         DN1X35RIJRRvi8BFkerQ3A9VyAbgU7IbEJkroSIR/1yAtvKRS2AQz0C6A0jdmNnRIEN3
         2Sbi45DtN3z0S7P+IOvsh1xUlX1H6EaRta4xsPHqW06GF/TvlijguOVEEn05NtCMyBSB
         Nf7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUA+za5Jgo7JtpmwCLt9EHM5O4aPH9/bA5+BEkYirdjzDr5or9Us6m+DbWaEi3xA5zQrUw=@vger.kernel.org, AJvYcCXUBR+eVDsLbtBqi8ImdUEXIrVqVIUucmIAKx/Va6Svm4IsLBpaZTfsmQNbyqWBUSzXRptzdDh/VYTkIMIZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxlRNyDUPmdDw03rMlRofwO7AugtYN36NUZSD2b49S5H689bjUj
	bHmiBM4wAywxKVLXkbohK/3tND9K4/8+FZfNAjJNmriMqeGY2D4h
X-Google-Smtp-Source: AGHT+IF8aHxbrDy8yuIW3KxWdlKQkLLu64Svz4YjS74lZgT3OVzFFCoAmgRC924b4qPGhE2gniWZqA==
X-Received: by 2002:a05:6a00:3e29:b0:70d:2b95:d9c0 with SMTP id d2e1a72fcca58-71926090ecdmr40262746b3a.14.1726753568360;
        Thu, 19 Sep 2024 06:46:08 -0700 (PDT)
Received: from [192.168.50.122] ([117.147.90.205])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71972bf3999sm4340785b3a.48.2024.09.19.06.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 06:46:07 -0700 (PDT)
Message-ID: <5310a4f2-3b45-4a3e-b05c-fcc5faba7c0e@gmail.com>
Date: Thu, 19 Sep 2024 21:45:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] libbpf: Fix expected_attach_type set when
 kernel not support
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240914154040.276933-1-chen.dylane@gmail.com>
 <8bcac2c4-80fc-4807-9e77-5dc253b10568@gmail.com>
 <CAEf4BzZpdMx7ZV6V6pJKLkq3BtdRrqj8Vo09YVSN5YApNtCa3Q@mail.gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <CAEf4BzZpdMx7ZV6V6pJKLkq3BtdRrqj8Vo09YVSN5YApNtCa3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/9/19 12:20, Andrii Nakryiko 写道:
> On Thu, Sep 19, 2024 at 4:05 AM Tao Chen <chen.dylane@gmail.com> wrote:
>>
>> 在 2024/9/14 23:40, Tao Chen 写道:
>>> The commit "5902da6d8a52" set expected_attach_type again with
>>> field of bpf_program after libpf_prepare_prog_load, which makes
>>> expected_attach_type = 0 no sense when kenrel not support the
>>> attach_type feature, so fix it.
>>>
>>> Fixes: 5902da6d8a52 ("libbpf: Add uprobe multi link support to bpf_program__attach_usdt")
>>> Suggested-by: Jiri Olsa <jolsa@kernel.org>
>>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>>> ---
>>>    tools/lib/bpf/libbpf.c | 12 ++++++++----
>>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> Change list:
>>> - v2 -> v3:
>>>       - update BPF_TRACE_UPROBE_MULTI both in prog and opts suggedted by
>>>         Andrri
>>> - v1 -> v2:
>>>       - restore the original initialization way suggested by Jiri
>>>
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index 219facd0e66e..a78e24ff354b 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>> @@ -7352,8 +7352,14 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
>>>                opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
>>>
>>>        /* special check for usdt to use uprobe_multi link */
>>> -     if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK))
>>> +     if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK)) {
>>> +             /* for BPF_TRACE_KPROBE_MULTI, user might want to query exected_attach_type
>>> +              * in prog, and expected_attach_type we set in kenrel is from opts, so we
>>> +              * update both.
>>> +              */
>>>                prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
>>> +             opts->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
>>> +     }
>>>
>>>        if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
>>>                int btf_obj_fd = 0, btf_type_id = 0, err;
>>> @@ -7443,6 +7449,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>>>        load_attr.attach_btf_id = prog->attach_btf_id;
>>>        load_attr.kern_version = kern_version;
>>>        load_attr.prog_ifindex = prog->prog_ifindex;
>>> +     load_attr.expected_attach_type = prog->expected_attach_type;
>>>
>>>        /* specify func_info/line_info only if kernel supports them */
>>>        if (obj->btf && btf__fd(obj->btf) >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
>>> @@ -7474,9 +7481,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>>>                insns_cnt = prog->insns_cnt;
>>>        }
>>>
>>> -     /* allow prog_prepare_load_fn to change expected_attach_type */
>>> -     load_attr.expected_attach_type = prog->expected_attach_type;
>>> -
>>>        if (obj->gen_loader) {
>>>                bpf_gen__prog_load(obj->gen_loader, prog->type, prog->name,
>>>                                   license, insns, insns_cnt, &load_attr,
>>
>> Hi, guys, please review this patch again, the previous versions:
> 
> It looks good, but bpf-next is closed right now due to merge window.
> I'll apply when the tree is open again.

Hi，Andrii, thank you for your response! I’ll wait for the next window.

> 
>> v1:
>> https://lore.kernel.org/bpf/20240913121627.153898-1-chen.dylane@gmail.com/
>> v2:
>> https://lore.kernel.org/bpf/20240913164355.176021-1-chen.dylane@gmail.com/
>>
>> --
>> Best Regards
>> Dylane Chen


-- 
Best Regards
Dylane Chen

