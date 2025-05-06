Return-Path: <bpf+bounces-57504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6C1AAC16D
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 12:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A06F4C82BF
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 10:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7EF27815B;
	Tue,  6 May 2025 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7YBYqPu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B154D27703B
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746527541; cv=none; b=ZELK8KIZFUrX+pSy7nVJksp40d68QoInkNLcEfzkBLIyChp4e/V5QrLLckwzf8C7fIxEjv2FTE/etLoBY9Ic1IGi2GINyW9exdZuBBe9DjCeoWz2f5TfpuOOdUl5LWP3jVip51dOO5cjYx9KSGZKPM2jHpMNVFWYLWoBBfkOJlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746527541; c=relaxed/simple;
	bh=LPAj4rzxDc1w7Ww1wTbpQ4fynILsD6KBrsSID7055cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJDphjfy1meUwy5+MOr2XTMHkXcus/TycGwDfkgnIkEDIdl7PjDJS8GsTW+EVtXFK47fvxZbQ0JpvEH2XoMbZawywhpeEam6Op/M94cf98kvLafaRlsQrrEepjuUj5dp3nik5MDpZr+V6DnMujU8fx8cS86R13eXPsB8T4ceiSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7YBYqPu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3913d129c1aso3357580f8f.0
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 03:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746527537; x=1747132337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kXjCsbcnmCVriwBfU5JhFpvnHM7Kq1vDRgyiMybQKI=;
        b=X7YBYqPufW27es9mnLPr78ooVXRXAT8e7VyprBQaL/vFF8M9mTNKPx4PlIyiKeV+Mr
         Pm1fMG5AqP25W9VQocxrassMfSFaCMKyNmXzB2cWtKi5XMQUHeeoVzXrAMX41iGyCixC
         gzRL6Z9gw/xIFImywejXRwLDI3QZLGx0IJLFFskNn7BmQQdQPjR6bvKZT0mzjkI+AYF6
         uVLzIYTExSWcaCqIA8R9LtmdJfZCowE0bBPNkiG2Uia577N2UfQRMoAQcx4cOKtj5JLA
         /RzSuUgauUH5siNArR1AZhAYJxeyNdf1ZJxZgue0DTNKVnexoEs/qcSv2dx7ceAPMavk
         GIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746527537; x=1747132337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9kXjCsbcnmCVriwBfU5JhFpvnHM7Kq1vDRgyiMybQKI=;
        b=ZW5aTobso3WSFO60/1xr7PEqpW4l9uy/PsjYvPz/K8X1Kav7p85JGSAEDNxk11wF/j
         TYHYQv7tWKqemSQ29zFllVBOarffALN0j57cn//uGbBq5LNdkdJIdN8tAzSZucMMmlba
         gGJFw2rqJ5FtQDdhkFMwoQGpXIQCtmMcGzxAXSTywoOaFYPBwblCgd3GlaudOl1Ve/U7
         jI5+1V74Uf0a7KqsX8g3m0jhL+gU6LRXNFS5oK+SdRey4T4z95GGiqI9X4gy+0fNRIdL
         5q+4OAE2CBbnNgndZH8oj8M74nFEJ63rZBX+ReSqgq0arakbNue4Qa+uZL/M8pE7HP2H
         yZPQ==
X-Gm-Message-State: AOJu0Yzpp/q8XHSbQLFNt4XfI+klG6J4LxsEl4q5ZD6py2DtHNfx+Mgb
	pJ5Tyw1v8/mKYz2Ckh9+LU5AVqy9f+pDIG2t4hiI3u0xyjsxaWIChZi+Hw==
X-Gm-Gg: ASbGncvbIhRAty5Ee+ffvTXWJZRkLIhaVT1/yDgF2jgVgc6TBD1N1X/AGzPrfN/UOoI
	jcYEe+lHYSrB8WtLSDCnVgvsiHqrJUKyeZhida9kNH+Z8biQ2FKZlPMPp5olgM71L2+98JVeYdl
	7vap0oP+AhXn8ZxWBSOBkhHMmrtPWwkWH4pHe4rMiWX9O5oBYBtQ69Sy33ZSVO/tJw0jt3zwXFS
	jnLz4mGycZVwBHXJtSWOptTgF7yoZXGna8xDaeNmrqPzxGqjJ5eEdsYfWLRUXLAnCADQM3vyIsX
	pYtQAJxS0EmysX3MadX6o8b+oL0fRiIqx83qqdq5wdRfmRLch6sZkEuQviGpphlP7XztRLyEssY
	GrQd9/K5iyKYpO1+bIr+HYQ==
X-Google-Smtp-Source: AGHT+IGTCkDzqi1BQrFXp8JjPtVlbV7y7VXaoPszc+RCWV/ZCdbSk2SE2TCI1D6P6gXPKw571qjj1Q==
X-Received: by 2002:a05:6000:1789:b0:39f:cf7:2127 with SMTP id ffacd0b85a97d-3a0ab58231bmr2246324f8f.14.1746527536696;
        Tue, 06 May 2025 03:32:16 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10? ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0f14esm13402864f8f.64.2025.05.06.03.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 03:32:16 -0700 (PDT)
Message-ID: <2f0665c3-9b8b-4069-a751-6054cbb68b88@gmail.com>
Date: Tue, 6 May 2025 11:32:15 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] bpf: implement dynptr copy kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250502190621.41549-1-mykyta.yatsenko5@gmail.com>
 <20250502190621.41549-3-mykyta.yatsenko5@gmail.com>
 <CAADnVQ+PyzpJutq44dWtfX+YfkKuzRtmLTB7f7vgFtY+P-rjog@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQ+PyzpJutq44dWtfX+YfkKuzRtmLTB7f7vgFtY+P-rjog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/05/2025 22:32, Alexei Starovoitov wrote:
> On Fri, May 2, 2025 at 12:06 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> This patch introduces a new set of kfuncs for working with dynptrs in
>> BPF programs, enabling reading variable-length user or kernel data
>> into dynptr directly. To enable memory-safety, verifier allows only
>> constant-sized reads via existing bpf_probe_read_{user|kernel} etc.
>> kfuncs, dynptr-based kfuncs allow dynamically-sized reads without memory
>> safety shortcomings.
>>
>> The following kfuncs are introduced:
>> * `bpf_probe_read_kernel_dynptr()`: probes kernel-space data into a dynptr
>> * `bpf_probe_read_user_dynptr()`: probes user-space data into a dynptr
>> * `bpf_probe_read_kernel_str_dynptr()`: probes kernel-space string into
>> a dynptr
>> * `bpf_probe_read_user_str_dynptr()`: probes user-space string into a
>> dynptr
>> * `bpf_copy_from_user_dynptr()`: sleepable, copies user-space data into
>> a dynptr for the current task
>> * `bpf_copy_from_user_str_dynptr()`: sleepable, copies user-space string
>> into a dynptr for the current task
>> * `bpf_copy_from_user_task_dynptr()`: sleepable, copies user-space data
>> of the task into a dynptr
>> * `bpf_copy_from_user_task_str_dynptr()`: sleepable, copies user-space
>> string of the task into a dynptr
>>
>> The implementation is built on two generic functions:
>>   * __bpf_dynptr_copy
>>   * __bpf_dynptr_copy_str
>> These functions take function pointers as arguments, enabling the
>> copying of data from various sources, including both kernel and user
>> space. Notably, these indirect calls are typically inlined.
>>
>> Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   kernel/bpf/helpers.c     |   8 ++
>>   kernel/trace/bpf_trace.c | 199 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 207 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 2aad7c57425b..7d72d3e87324 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -3294,6 +3294,14 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
>>   BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>>   BTF_ID_FLAGS(func, bpf_local_irq_save)
>>   BTF_ID_FLAGS(func, bpf_local_irq_restore)
>> +BTF_ID_FLAGS(func, bpf_probe_read_user_dynptr)
>> +BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr)
>> +BTF_ID_FLAGS(func, bpf_probe_read_user_str_dynptr)
>> +BTF_ID_FLAGS(func, bpf_probe_read_kernel_str_dynptr)
>> +BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLEEPABLE)
>> +BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
>> +BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE)
>> +BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE)
> They need to have KF_TRUSTED_ARGS, otherwise legacy ptr_to_btf_id
> can be passed in.
>
>>   BTF_KFUNCS_END(common_btf_ids)
>>
>>   static const struct btf_kfunc_id_set common_kfunc_set = {
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 52c432a44aeb..52926d572006 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -3499,6 +3499,147 @@ static int __init bpf_kprobe_multi_kfuncs_init(void)
>>
>>   late_initcall(bpf_kprobe_multi_kfuncs_init);
>>
>> +typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struct *tsk);
>> +
>> +static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dptr, u32 doff, u32 size,
> why always_inline?
Just wanted to get rid of the overhead of having implementation in the 
generic __bpf_dynptr_copy()
(Removes one jmp, perhaps not a big deal)
>
> patch 1 already adds overhead in non-LTO build,
> since small helper bpf_dynptr_check_off_len() will not be inlined.
Thanks for pointing this one, I guess bpf_dynptr_check_off_len() 
implementation should be moved to header
and be inlined?
> This __always_inline looks odd and probably wrong
> from optimizations pov.
>
> All other __always_inline look wrong too.
>
>
>> +                                                const void __user *unsafe_src,
>> +                                                copy_fn_t str_copy_fn,
>> +                                                struct task_struct *tsk)
>> +{
>> +       struct bpf_dynptr_kern *dst;
>> +       u32 chunk_sz, off;
>> +       void *dst_slice;
>> +       int cnt, err;
>> +       char buf[256];
>> +
>> +       dst_slice = bpf_dynptr_slice_rdwr(dptr, doff, NULL, size);
>> +       if (likely(dst_slice))
>> +               return str_copy_fn(dst_slice, unsafe_src, size, tsk);
>> +
>> +       dst = (struct bpf_dynptr_kern *)dptr;
>> +       if (bpf_dynptr_check_off_len(dst, doff, size))
>> +               return -E2BIG;
>> +
>> +       for (off = 0; off < size; off += chunk_sz - 1) {
>> +               chunk_sz = min_t(u32, sizeof(buf), size - off);
>> +               /* Expect str_copy_fn to return count of copied bytes, including
>> +                * zero terminator. Next iteration increment off by chunk_sz - 1 to
>> +                * overwrite NUL.
>> +                */
>> +               cnt = str_copy_fn(buf, unsafe_src + off, chunk_sz, tsk);
>> +               if (cnt < 0)
>> +                       return cnt;
>> +               err = __bpf_dynptr_write(dst, doff + off, buf, cnt, 0);
>> +               if (err)
>> +                       return err;
>> +               if (cnt < chunk_sz || chunk_sz == 1) /* we are done */
>> +                       return off + cnt;
>> +       }
>> +       return off;
>> +}
>> +
>> +static __always_inline int __bpf_dynptr_copy(const struct bpf_dynptr *dptr, u32 doff,
>> +                                            u32 size, const void __user *unsafe_src,
>> +                                            copy_fn_t copy_fn, struct task_struct *tsk)
>> +{
>> +       struct bpf_dynptr_kern *dst;
>> +       void *dst_slice;
>> +       char buf[256];
>> +       u32 off, chunk_sz;
>> +       int err;
>> +
>> +       dst_slice = bpf_dynptr_slice_rdwr(dptr, doff, NULL, size);
>> +       if (likely(dst_slice))
>> +               return copy_fn(dst_slice, unsafe_src, size, tsk);
>> +
>> +       dst = (struct bpf_dynptr_kern *)dptr;
>> +       if (bpf_dynptr_check_off_len(dst, doff, size))
>> +               return -E2BIG;
>> +
>> +       for (off = 0; off < size; off += chunk_sz) {
>> +               chunk_sz = min_t(u32, sizeof(buf), size - off);
>> +               err = copy_fn(buf, unsafe_src + off, chunk_sz, tsk);
>> +               if (err)
>> +                       return err;
>> +               err = __bpf_dynptr_write(dst, doff + off, buf, chunk_sz, 0);
>> +               if (err)
>> +                       return err;
>> +       }
>> +       return 0;
>> +}
>> +
>> +static __always_inline int copy_user_data_nofault(void *dst, const void __user *unsafe_src,
>> +                                                 u32 size, struct task_struct *tsk)
>> +{
>> +       if (WARN_ON_ONCE(tsk))
>> +               return -EFAULT;
>> +
>> +       return copy_from_user_nofault(dst, unsafe_src, size);
>> +}
>> +
>> +static __always_inline int copy_user_data_sleepable(void *dst, const void __user *unsafe_src,
>> +                                                   u32 size, struct task_struct *tsk)
>> +{
>> +       int ret;
>> +
>> +       if (!tsk) /* Read from the current task */
>> +               return copy_from_user(dst, unsafe_src, size);
>> +
>> +       ret = access_process_vm(tsk, (unsigned long)unsafe_src, dst, size, 0);
>> +       if (ret != size)
>> +               return -EFAULT;
>> +       return 0;
>> +}
>> +
>> +static __always_inline int copy_kernel_data_nofault(void *dst, const void *unsafe_src,
>> +                                                   u32 size, struct task_struct *tsk)
>> +{
>> +       if (WARN_ON_ONCE(tsk))
>> +               return -EFAULT;
> Why ? Let's not do defensive programming.
> The caller clearly passes NULL.
> Just drop this line.
got it.
>> +
>> +       return copy_from_kernel_nofault(dst, unsafe_src, size);
>> +}
>> +
>> +static __always_inline int copy_user_str_nofault(void *dst, const void __user *unsafe_src,
>> +                                                u32 size, struct task_struct *tsk)
>> +{
>> +       if (WARN_ON_ONCE(tsk))
>> +               return -EFAULT;
> same here and further down.
>
> pw-bot: cr



