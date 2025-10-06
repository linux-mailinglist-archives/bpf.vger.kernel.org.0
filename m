Return-Path: <bpf+bounces-70418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAE8BBDEAB
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 13:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DFC44EC747
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A82273D77;
	Mon,  6 Oct 2025 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYCKoe7Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DAC220F37
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751424; cv=none; b=hzOISo0+LU4HCN/HPTCr7pO6ThNd7Ts2nGSaetGovY9r1dYptlBLvCQeYXjjvCPgfeXn4b3Efur/kXiEO7uvYjU5UARTP8XWkS8efupTL+ogSxK5hCwhCXEy1lCRvZYJHdEp/rubCHIxIfvIs6hzTUPzmer8YH4ir9aCSInIgZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751424; c=relaxed/simple;
	bh=T/r6Hc8w6riMkZcl1AUW9uQevocc+gSz0mboT+dPELs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goK4wy8ZQGl8hq+QxUCuTBdu4cDPmMYM5g8O4WITmUWm0mIMpdUAOxPNfSHYTeiIcn97PxmI3PASTQWTI2cbKs3lAItibAiKFJCa3lJihld5I/YCsl5QcxQYUbTXabEnl1z/Hjn+EQxZIdDqBNV6xgWhli7krV1VL54TCmfOwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYCKoe7Y; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso2744512f8f.2
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 04:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759751421; x=1760356221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=scF228B0opz5cpAY58qygjOavkwWQDxd7YqNik/1L/U=;
        b=iYCKoe7Yg15RewfDNTSY3qHTc9eGAdKl99JwgLPHJgRJZXcibOILroFmgK2BFNB11O
         /5HYkB0aRAt5wuFF29zFGfO45men3nr+qhvwfll9yQXvByIqTGmAzhIPok4NYhXaaCln
         IZN5yDl3NtPF+7/GU+ADAAHubYCqupgNL3BJxUmhBDgLjaRAOngGlmBH2zsNEseWa8B+
         WtEdgGrGyN5PEFRNhAsSybZFYM7XusyZiC10iLylHulzI+n/ulIwvQF6qkYPujxJaYHP
         WpyvGBZQlE5Z2KcU/60SxGyNp0HYjETViDVylHIng0tc6ahUXUZ+RniNL73VeqKtHrV0
         vs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759751421; x=1760356221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=scF228B0opz5cpAY58qygjOavkwWQDxd7YqNik/1L/U=;
        b=lK5bKvXq38pBGmapIPsrmQECqZwdgVSup2WJJ++X7CbLExeXnRMCi0WWRRQhfYmK85
         6g8n+RkFlYgTLUfMIY1bOEWrBymHc2dDKwtHRUor4rot+5Oyk+gnlfE0oZD4mhMoyEs1
         mVWaP/cVOGASfls13z3A5uMT17q9VYX/fTTaXWuLdVRy5ZqlY60qwynee3PUsnMGe4QA
         /AkzChWiWWvlqe68LgN8vqrsAHJPiUWVfiLQYtlkfNQ+RxNR7J0HMmGNGwzwqLUBzB5v
         2+CDIqz7mo/0+Ck1d/G2psULKDv+STq62o+iprR9RAQAwVGLNr0Ot4oBJDWmKSxnJi4w
         cXNQ==
X-Gm-Message-State: AOJu0Yx8Fc38RSUnYd+hveTR9mqelmZUMPH5Uw6CB1LWT6zRVBUPaJXA
	I/eQ//X6pahzMIFzRRY0wJpgrFdfAY5GsKyfYarF23kXjpWsbY2iJXRk
X-Gm-Gg: ASbGncs4gxd1YdKW+4BRq5l1OAdscsYwMQZZtrbr+3Qt+TmxEr3UrTDLftgYJ6RClPO
	/oi1e8uur5E7+0o6vfONP3E8NxROMvmvApBmqmhRnAojI26HdVGGVgP51OMC4EQBHC8qWmwKGhY
	WtPEtrd0U9pJWMKMc2Xy3caLzA2hX97lf4wGRK9yPpeNVMNQBYK4nbxoC2oSB6+2nuJ1ZfSZuP8
	h+UlfGqJ+r8mPVmQ06hP7sk/vsEx0FlIlrcOQhJtJSIrH/MCs2NSTs4mH9Pj2LP+FQ1u/kwHBSf
	fQ0w+a/fA++mjVeP4A9rKOA3+0E7rdVGaWVeufHlqyyfz7e4v6fM/R5+WOszmvdaiGg0qflOJLv
	aqHBex+RtZ1d13bYAmo9KiSR4B4+VO4eSoRyfeh5eIVQldXPY7QEBj0PtaEUYTd8HQjjLbGbvxs
	q64eHbt92YvVZcL0P8gz1eyu0mhkBe
X-Google-Smtp-Source: AGHT+IGmciW8Mf3tUy4xX9Uoq+hnEYtTdV0Cb0gIpXX4vtn4t93wwzSzouD0+R6dey930JDwpMJECQ==
X-Received: by 2002:a05:6000:220b:b0:3e1:9b75:f0b8 with SMTP id ffacd0b85a97d-425671be248mr7723233f8f.47.1759751420750;
        Mon, 06 Oct 2025 04:50:20 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:7da0:ba20:3ec:edc7? ([2620:10d:c092:500::5:6287])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6c49sm20657717f8f.3.2025.10.06.04.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 04:50:20 -0700 (PDT)
Message-ID: <62376422-6d60-42b9-b09e-393396fb7302@gmail.com>
Date: Mon, 6 Oct 2025 12:50:19 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 10/10] selftests/bpf: add file dynptr tests
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
 <20251003160416.585080-11-mykyta.yatsenko5@gmail.com>
 <CAEf4Bzbw+udD6Fud2WshVrCK=mGqisjagZrapsQwM=0G9ipesg@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4Bzbw+udD6Fud2WshVrCK=mGqisjagZrapsQwM=0G9ipesg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/3/25 21:02, Andrii Nakryiko wrote:
> On Fri, Oct 3, 2025 at 9:04 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Introducing selftests for validating file-backed dynptr works as
>> expected.
>>   * validate implementation supports dynptr slice and read operations
>>   * validate destructors should be paired with initializers
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   .../selftests/bpf/prog_tests/file_reader.c    |  81 ++++++
>>   .../testing/selftests/bpf/progs/file_reader.c | 241 ++++++++++++++++++
>>   .../selftests/bpf/progs/file_reader_fail.c    |  57 +++++
>>   3 files changed, 379 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/file_reader.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/file_reader.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/file_reader_fail.c
> Non-sleepable file dynptr can fail to read, so this test is a bit
> fragile. Let's have a sleepable test (fentry.s or something like
> that?)
This is sleepable, because it runs in task work callback.
>
> Plus, can you please add a test that validates that we do page in file
> contents even if it was not physically in memory? see madvise(addr,
> page_sz, MADV_PAGEOUT) in selftests
I tried to tell kernel to evict those pages via: posix_fadvise(fd, 0, 0, 
POSIX_FADV_DONTNEED);
I'll rework to madvise(addr, page_sz, MADV_PAGEOUT)
>
>> +int err;
>> +void *user_ptr;
>> +char buf[1024];
>> +char *user_buf;
>> +volatile const __u32 user_buf_sz;
>> +volatile const __s32 test_type = -1;
>> +
>> +static int process_vma(struct task_struct *task, struct vm_area_struct *vma, void *data);
>> +static int search_elf(struct file *file);
>> +static int validate_large_file_read(struct file *file);
>> +static int task_work_callback(struct bpf_map *map, void *key, void *value);
>> +
>> +SEC("raw_tp/sys_enter")
>> +int on_getpid(void *ctx)
>> +{
>> +       struct task_struct *task = bpf_get_current_task_btf();
>> +       struct elem *work;
>> +       int key = 0;
> this will be called for every syscall in the system, regardless of the
> process, so you probably need to filter this by process ID?
>
>> +
>> +       work = bpf_map_lookup_elem(&arrmap, &key);
>> +       if (!work) {
>> +               err = 1;
>> +               return 0;
>> +       }
>> +       bpf_task_work_schedule_signal(task, &work->tw, &arrmap, task_work_callback, NULL);
>> +       return 0;
>> +}
>> +
> [...]
>
>> +static long process_vma_unreleased_ref(struct task_struct *task, struct vm_area_struct *vma,
>> +                                      void *data)
>> +{
>> +       struct bpf_dynptr dynptr;
>> +
>> +       if (!vma->vm_file)
>> +               return 1;
>> +
>> +       err = bpf_dynptr_from_file(vma->vm_file, 0, &dynptr);
>> +       return err ? 1 : 0;
>> +}
>> +
>> +SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
>> +__failure __msg("Unreleased reference id=") int on_nanosleep_unreleased_ref(void *ctx)
> nit: keep annotations on separate line from the function itself
>
>> +{
>> +       struct task_struct *task = bpf_get_current_task_btf();
>> +
>> +       bpf_find_vma(task, (unsigned long)user_ptr, process_vma_unreleased_ref, NULL, 0);
>> +       return 0;
>> +}
>> +
>> +SEC("xdp")
>> +__failure __msg("Expected a dynptr of type file as arg #0")
>> +int xdp_wrong_dynptr_type(struct xdp_md *xdp)
>> +{
>> +       struct bpf_dynptr dynptr;
>> +
>> +       bpf_dynptr_from_xdp(xdp, 0, &dynptr);
>> +       bpf_dynptr_file_discard(&dynptr);
>> +       return 0;
>> +}
>> +
>> +SEC("xdp")
>> +__failure __msg("Expected an initialized dynptr as arg #0")
>> +int xdp_no_dynptr_type(struct xdp_md *xdp)
>> +{
>> +       struct bpf_dynptr dynptr;
>> +
>> +       bpf_dynptr_file_discard(&dynptr);
>> +       return 0;
>> +}
>> --
>> 2.51.0
>>


