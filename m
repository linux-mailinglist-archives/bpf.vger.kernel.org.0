Return-Path: <bpf+bounces-57515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A77AAAC66E
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 15:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32493AE4D2
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05395281520;
	Tue,  6 May 2025 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIGm5PC9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C32B25229A
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538377; cv=none; b=l+TLq/bJVIqN4wH1gxyqdbH/PAkEn5rJI5qKKn0labe/DE5PyG0zEU2nW61fuBnnCcl7IjCA1pHTkhxsaxe5PsYC7cH/Y0gK2GDt4/gf20knCjmNuMNh24cxSan0v3g7bvCq/qERgseDxMn64GfjKdzXgzi7OOYUuvydVVgrk3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538377; c=relaxed/simple;
	bh=SfhcJj9o5Ay9bxlonW9TlxyxfQeaheKEBgkmQgAGlIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeRT7BRlzSNZ6dvXvM5ev65FOT6PPpPCcS6IgJ0lj2daFNST2K1FscY5+Hw+CwYP3+knT2Fzv+ci6Cpw7SSxo3XUNsg+I0d/dPD/ymw/ApRzHzaMHlskyY67m5SBWcHpVQF5P82cn9ThAfM8ZHl+qR/A5eeddGxnkMAjNToXBCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIGm5PC9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c14016868so6628962f8f.1
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 06:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746538374; x=1747143174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1aBzrTeehXqgGiaQv5C/PRbstjR70BehZnLKOu5+QE=;
        b=GIGm5PC9yn9ZYFsY+TLoRUz4396fSBMuWeK5yktz8GwZSePGCNKMIRU+evNECDrxo+
         qru7ruckan1FCY2/AHVUZmKwdR3JenyQT8iG3t79tB7SnTnAcph2ix1KbFYqkAvmjlk/
         Wh4imRAOPz9bFhep2eSWq8gKfh6thbgKm7YR70ysClrdTZRFYvYTcYJpeQjaS0w7TocR
         LM7U+qZUJ5lhqAkHs20mGJ0UHZXfow7jgHkX434AfG6kwHCV+Ik/+EVC3ayGO0P5rNCz
         hjFZlBhdQU7O2pzm02icOGa8og+UMq7mDO7rw2V1NlnJG1w720ZdoqvSuA12nUg3g/Uy
         V7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746538374; x=1747143174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1aBzrTeehXqgGiaQv5C/PRbstjR70BehZnLKOu5+QE=;
        b=WsaaPKHr1WKBR3NnF1l6tSCrgP/3pOfkttJhPlU3fVzTKAFvbwXYg8eTerDEkenvWu
         h0TfndYwOGR/xvIVUoACiWGA40cwO36Q2GsHGVe/55NazjcvLFcP2qp/hl+81aj4FQjn
         QNd/E6nP6t1HTeQlsgOnTP7lRhJSXMlbciAjbz5FSmx9vNjaeS140bxMtU+MG7mXyH3y
         EpTaxR/sGKtbaWI52CEss5eimP4kK3LIgwnYbeKhVzIFyOy1q7IxrwtUjWwVevD1vs/s
         nlKQtjnW5M6p4MnDtBbu99umGbM1Htse9oFreGAMupPpKtGWSPUPP+TJgLNB7d5CoTjg
         3owg==
X-Gm-Message-State: AOJu0Yx7N29kZXJTco0VhaqU63Xqy+EBkzON7h4yLieuM5J1dlWlBiSv
	0ciVjoP/oBpGMuUtkt2At1Py9LRpEPxc9ro02ca4odSyDgpllGWA
X-Gm-Gg: ASbGncu++rG5iD9Go8BVG9TYEiIhR9M0yBO+FPRPvYg2OTmUczrrq9OTqBtZSoSDP8Z
	puws9x3igxIYtNkLKZIKOtItlBgN0wkfz9m6FZQw/BDGgz/CXIkCD0Nbs2ScdqurFEdlqn+zjZY
	j9H3MktdMlqgK4cFokLkPWKGOVWH9QSQIJ5hEK2iyavc1BSkNfTboASF1ZfsBHEjmIRjLAweQ4l
	dbR2asAwz3pNphHbNQNb3GIitx3Dx7f3faY4HKy5JAtI6FIl83Hhll1NaGaT+5HVOXtuWMC5zlG
	3+Pzn9PBzlDaAzyxuHOy6Gmqsrv4Jd9rygqwzT9y1VJBCBn/qt4SDCYjzVNCmuEvZ/USWg42MAs
	FwrzlnRvEiINiIXtryUqC5/5BSV/m/w0p
X-Google-Smtp-Source: AGHT+IFBA8qlk42BdMKi/l0UehmPnNe63r5uFR2QjW0lJygtVrxogQBFWGDoR45w8YbbIpllrvDdEQ==
X-Received: by 2002:a5d:47a6:0:b0:39c:dfa:d33e with SMTP id ffacd0b85a97d-3a09fd765f7mr7365470f8f.23.1746538373629;
        Tue, 06 May 2025 06:32:53 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10? ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc469sm172051875e9.6.2025.05.06.06.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 06:32:53 -0700 (PDT)
Message-ID: <e4555bd4-4830-4708-911e-e3cb48fa5815@gmail.com>
Date: Tue, 6 May 2025 14:32:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: introduce tests for dynptr
 copy kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250502190621.41549-1-mykyta.yatsenko5@gmail.com>
 <20250502190621.41549-4-mykyta.yatsenko5@gmail.com>
 <CAADnVQKLvOeN6sRctgna7BjU=3HeK+6Y1E-f1rmHEH7V8T00dw@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQKLvOeN6sRctgna7BjU=3HeK+6Y1E-f1rmHEH7V8T00dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/05/2025 22:34, Alexei Starovoitov wrote:
> On Fri, May 2, 2025 at 12:06 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Introduce selftests verifying newly-added dynptr copy kfuncs.
>> Covering contiguous and non-contiguous memory backed dynptrs.
>>
>> Disable test_probe_read_user_str_dynptr that triggers bug in
>> strncpy_from_user_nofault. Patch to fix the issue [1].
>>
>> [1] https://patchwork.kernel.org/project/linux-mm/patch/20250422131449.57177-1-mykyta.yatsenko5@gmail.com/
>>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/testing/selftests/bpf/DENYLIST          |   1 +
>>   .../testing/selftests/bpf/prog_tests/dynptr.c |  13 ++
>>   .../selftests/bpf/progs/dynptr_success.c      | 201 ++++++++++++++++++
>>   3 files changed, 215 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/DENYLIST b/tools/testing/selftests/bpf/DENYLIST
>> index f748f2c33b22..1789a61d0a9b 100644
>> --- a/tools/testing/selftests/bpf/DENYLIST
>> +++ b/tools/testing/selftests/bpf/DENYLIST
>> @@ -1,5 +1,6 @@
>>   # TEMPORARY
>>   # Alphabetical order
>> +dynptr/test_probe_read_user_str_dynptr # disabled until https://patchwork.kernel.org/project/linux-mm/patch/20250422131449.57177-1-mykyta.yatsenko5@gmail.com/ makes it into the bpf-next
>>   get_stack_raw_tp    # spams with kernel warnings until next bpf -> bpf-next merge
>>   stacktrace_build_id
>>   stacktrace_build_id_nmi
>> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
>> index e29cc16124c2..62e7ec775f24 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
>> @@ -33,10 +33,19 @@ static struct {
>>          {"test_dynptr_skb_no_buff", SETUP_SKB_PROG},
>>          {"test_dynptr_skb_strcmp", SETUP_SKB_PROG},
>>          {"test_dynptr_skb_tp_btf", SETUP_SKB_PROG_TP},
>> +       {"test_probe_read_user_dynptr", SETUP_XDP_PROG},
>> +       {"test_probe_read_kernel_dynptr", SETUP_XDP_PROG},
>> +       {"test_probe_read_user_str_dynptr", SETUP_XDP_PROG},
>> +       {"test_probe_read_kernel_str_dynptr", SETUP_XDP_PROG},
>> +       {"test_copy_from_user_dynptr", SETUP_SYSCALL_SLEEP},
>> +       {"test_copy_from_user_str_dynptr", SETUP_SYSCALL_SLEEP},
>> +       {"test_copy_from_user_task_dynptr", SETUP_SYSCALL_SLEEP},
>> +       {"test_copy_from_user_task_str_dynptr", SETUP_SYSCALL_SLEEP},
>>   };
>>
>>   static void verify_success(const char *prog_name, enum test_setup_type setup_type)
>>   {
>> +       char user_data[384] = {[0 ... 382] = 'a', '\0'};
>>          struct dynptr_success *skel;
>>          struct bpf_program *prog;
>>          struct bpf_link *link;
>> @@ -58,6 +67,10 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
>>          if (!ASSERT_OK(err, "dynptr_success__load"))
>>                  goto cleanup;
>>
>> +       skel->bss->user_ptr = user_data;
>> +       skel->data->test_len[0] = sizeof(user_data);
>> +       memcpy(skel->bss->expected_str, user_data, sizeof(user_data));
>> +
>>          switch (setup_type) {
>>          case SETUP_SYSCALL_SLEEP:
>>                  link = bpf_program__attach(prog);
>> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
>> index e1fba28e4a86..753d35eb47d9 100644
>> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
>> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
>> @@ -680,3 +680,204 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
>>          bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
>>          return XDP_DROP;
>>   }
>> +
>> +void *user_ptr;
>> +char expected_str[384]; /* Contains the copy of the data pointed by user_ptr */
> what so magic about 384?
It's MAX_BPF_STACK, but leaving some space for other things (temp buffer 
of this size is allocated on stack of each bpf prog)
The reason to use large buffer, is because when kfunc implementation 
falls back onto copying data chunk by chunk, the length of
chunk is 256 bytes, so I'm trying to force it copy more than 1 chunk.
>> +__u32 test_len[7] = {0/* placeholder */, 0, 1, 2, 255, 256, 257};
>> +
>> +typedef int (*bpf_read_dynptr_fn_t)(struct bpf_dynptr *dptr, u32 off,
>> +                                   u32 size, const void *unsafe_ptr);
>> +
>> +static __always_inline void test_dynptr_probe(void *ptr, bpf_read_dynptr_fn_t bpf_read_dynptr_fn)
> More __always_inline in the prog too?
> Why?
This one is a little bit tricky:
When removing always_inline, the generated bpf code does indirect call 
into bpf_read_dynptr_fn_t,
which errors out with "unknown opcode 8d", when trying to load the program.
An example of the generated code that fails to load:

89: 79 a5 58 fe 00 00 00 00 r5 = *(u64 *)(r10 - 0x1a8) 90: 8d 05 00 00 
00 00 00 00 callx r5

I could not find another way of fixing this, I'll appreciate any 
alternative.

>> +{
>> +       char buf[sizeof(expected_str)];
>> +       struct bpf_dynptr ptr_buf;
>> +       int i;
>> +
>> +       err = bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(buf), 0, &ptr_buf);
>> +
>> +       bpf_for(i, 0, ARRAY_SIZE(test_len)) {
>> +               __u32 len = test_len[i];
>> +
>> +               err = err ?: bpf_read_dynptr_fn(&ptr_buf, 0, test_len[i], ptr);
>> +               if (len > sizeof(buf))
>> +                       break;
>> +               err = err ?: bpf_dynptr_read(&buf, len, &ptr_buf, 0, 0);
>> +
>> +               if (err || bpf_memcmp(expected_str, buf, len))
>> +                       err = 1;
>> +
>> +               /* Reset buffer and dynptr */
>> +               __builtin_memset(buf, 0, sizeof(buf));
>> +               err = err ?: bpf_dynptr_write(&ptr_buf, 0, buf, len, 0);
>> +       }
>> +       bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
>> +}
>> +
>> +static __always_inline void test_dynptr_probe_str(void *ptr,
>> +                                                 bpf_read_dynptr_fn_t bpf_read_dynptr_fn)
>> +{
>> +       char buf[sizeof(expected_str)];
>> +       struct bpf_dynptr ptr_buf;
>> +       __u32 cnt, i;
>> +
>> +       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(buf), 0, &ptr_buf);
>> +
>> +       bpf_for(i, 0, ARRAY_SIZE(test_len)) {
>> +               __u32 len = test_len[i];
>> +
>> +               cnt = bpf_read_dynptr_fn(&ptr_buf, 0, len, ptr);
>> +               if (cnt != len)
>> +                       err = 1;
>> +
>> +               if (len > sizeof(buf))
>> +                       continue;
>> +               err = err ?: bpf_dynptr_read(&buf, len, &ptr_buf, 0, 0);
>> +               if (!len)
>> +                       continue;
>> +               if (err || bpf_memcmp(expected_str, buf, len - 1) || buf[len - 1] != '\0')
>> +                       err = 1;
>> +       }
>> +       bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
>> +}
>> +
>> +static __always_inline void test_dynptr_probe_xdp(struct xdp_md *xdp, void *ptr,
>> +                                                 bpf_read_dynptr_fn_t bpf_read_dynptr_fn)
>> +{
>> +       struct bpf_dynptr ptr_xdp;
>> +       char buf[sizeof(expected_str)];
>> +       __u32 off, i;
>> +
>> +       /* Set offset near the seam between buffers */
>> +       off = 3500;
> what is 3500 ?
This is an offset into the xdp-backed dynptr that is close to the end of 
the first fragment.
As far as I understand the size of the fragment is: `max_data_sz = 4096 
- headroom - tailroom;`,
I found it in `bpf_prog_test_run_xdp()` from net/bpf/test_run.c. I'd 
like my writes to go into multiple
fragments so that dynptr does not have a contiguous buffer of the 
requested size and chunking logic is hit.



