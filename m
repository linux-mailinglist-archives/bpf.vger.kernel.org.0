Return-Path: <bpf+bounces-70335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB258BB7F21
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 20:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4601894BDA
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 18:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A633B2DF127;
	Fri,  3 Oct 2025 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYfzekxF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F201F19A
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759517949; cv=none; b=l9+oHSW+oVZ8f8Tle+8EBylNKZF5pJ125gGVOy6hC5qYPKkpsWYlF1eYL0QLYCvtoSVHH/K0kEUch11icEOAmY+DHv3Xa7P81Twq+rWcY1Nx1EE0oHWffnSxnrVmAu4rSGy414nmnUm10j2jrU794o7/f6OiPug8VmZZPmm0PXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759517949; c=relaxed/simple;
	bh=jGTTM6TwwJHwJJrrRBjKauC+CwJ8GP/EPRWW6S7w++o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xu3H3JdxPj2YKqu4gI5omRihss/h81AFS68cZREF2Ty1lCaQVjcniuHGzNr58VGIvRnxC+aOaFDpYEXzDWx3nBZri7XL1JmX0NtpliJNKHwhtbE1VxTi9hc0yJWfk5E9rzGJh4hSNItXS4jL9E8AJjvHKRkzUova7nKVzFtV+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYfzekxF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso23428905e9.3
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759517946; x=1760122746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sn3ggau0iE1Hjga1dcp4Fl6odvr1hlzCibWKJ3eHUnE=;
        b=eYfzekxFLJKWO0bDQLtB1KITZVb1+gf4WQy4GqnYmenbZHP3B94aMQFTLaSfQ470yS
         LYZzqpiBaFqOAOGnOr6JpFUzSj+nFYEnCjpe/M3Vmub3bBnFJCop/b1IEETD9qekqJ59
         0EbXRqJzXAZwe2zb3aNSetcHq+a+lgGJWlxQ9rkntqQsDtj7GyZSW7oycK9909+VaPtP
         Fv6Bi3FGkwZeZFvVyFQeSd0UHgcBggSayupLcXXs84mpMKx4FQGFc6nDC+gHGrUVaTnv
         LtFXgx2ZYRSpJc0x/eNMesuFrNppb9Qdewy0BpQrUJRWB167lXZgZI1T3SDfhqUm68Eg
         BFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759517946; x=1760122746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sn3ggau0iE1Hjga1dcp4Fl6odvr1hlzCibWKJ3eHUnE=;
        b=KHq1TP79Zt2BlgaHS/P0W92Q/aAVXFjpd78WxBArwRjeiJLkpYYRXASXOG32XYYuH5
         gkgMgRk4Q6mKKrZuLkhtlakTNn5mUtHfbOgTWYpl4wLV9nPim1GQBoRHWMxXOMgE2jkD
         WafOoaAekGbKytH+xIB7FJHG5Hw+t1yDUnsUGS4X/0MKyr1aJNlUHSPbARO7hSgrHaZM
         baaLJKGXWU5Z0c48HHp7r84IomhmVFlPLt40ZfP92Y9a75g00e4rI/UfMGSPZgRbVzM6
         QyzgX76zi3okSmOUNwJJPe6McSzWnqrbyIFsCIM1MvYczI85FQgkkW+nQLRs1zByW4YS
         rcnA==
X-Gm-Message-State: AOJu0YzzoLNl7XAiuiJ01CyeFe1aX2klmtH2UwwP1Sgem4klkuPE2dsW
	9Ft1FrZUzYyQP1SjRe7MjyRpaQKj5ckPIGBqb9qQk4IyEaviW6kWy03j
X-Gm-Gg: ASbGncvppQmXtTOdQaJLYYePPfBfPyWuKBad/HAeuqmwz70pvEZrx23kv7pTWz19D+H
	d2JW6tj4oOBb9+qW9NrmCgVCO/JxJWaXyzytYsB1FX90T4yJG2KqCdKSrbsU/hJUuDdooylA0yG
	NfzSnLyFrIihDfIAyoI87hW+fAJVEbVHuTf++OYfUa+CvuoLMq6m5YMAcfWKS2jmmNwFnvmlTH1
	Z1N/W9nscVoCm3CnkqByj+PZDIbSg1315Nd8ry1C1M0I++km5TwLCYpjFJmtwF+P05v9fXcKsK8
	WlXpUSnudq8Uyqyu1LHin0xXOCCxqF+CuUxk5+fUm79R7boZbVgXxfwn6l6frvMvOIEUXIeqEjo
	0gMlTr88Fqa9yD1EkDQx/WLkgLWyk5borJhZbOIwHvqGWySxJemL+VxNdeoerluzxnICb2J4=
X-Google-Smtp-Source: AGHT+IHFgQOpFNXqp4czVBnNdYOYQbcXn2V9Asl+J3Hb4MrIvRVPTFmZK0F2aZkpiR4lpe6pQrEBvQ==
X-Received: by 2002:a05:600c:3151:b0:46e:4c7c:5140 with SMTP id 5b1f17b1804b1-46e71142eeamr28437985e9.18.1759517945785;
        Fri, 03 Oct 2025 11:59:05 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0c3:1130::123d? ([2620:10d:c092:400::5:5b97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723437d8sm41858435e9.3.2025.10.03.11.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 11:59:05 -0700 (PDT)
Message-ID: <8b38e920-4317-4c0a-8f1a-7354ca2b53d1@gmail.com>
Date: Fri, 3 Oct 2025 19:59:04 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 07/10] bpf: add kfuncs and helpers support for file
 dynptrs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
 <20251003160416.585080-8-mykyta.yatsenko5@gmail.com>
 <CAEf4BzYunpO3hBb3T_RGEUcYJBk=awgx+jCS8Naw1nK_SUEHUw@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzYunpO3hBb3T_RGEUcYJBk=awgx+jCS8Naw1nK_SUEHUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/3/25 19:38, Andrii Nakryiko wrote:
> On Fri, Oct 3, 2025 at 9:04 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Add support for file dynptr.
>>
>> Introduce struct bpf_dynptr_file_impl to hold internal state for file
>> dynptrs, with 64-bit size and offset support.
>>
>> Introduce lifecycle management kfuncs:
>>    - bpf_dynptr_from_file() for initialization
>>    - bpf_dynptr_file_discard() for destruction
>>
>> Extend existing helpers to support file dynptrs in:
>>    - bpf_dynptr_read()
>>    - bpf_dynptr_slice()
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   kernel/bpf/helpers.c | 97 +++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 95 insertions(+), 2 deletions(-)
>>
> [...]
>
>> +static int bpf_file_fetch_bytes(struct bpf_dynptr_file_impl *df, u64 offset, void *buf, u64 len)
>> +{
>> +       const void *ptr;
>> +
>> +       if (!buf || len == 0)
> len == 0 doesn't return error for LOCAL and RINGBUF (at least), I
> don't think we should deviate. Just treat len == 0 as no-op.
>
>> +               return -EINVAL;
>> +
>> +       df->freader.buf = buf;
>> +       df->freader.buf_sz = len;
>> +       ptr = freader_fetch(&df->freader, offset + df->offset, len);
>> +       if (!ptr)
>> +               return df->freader.err;
>> +
>> +       if (ptr != buf) /* Force copying into the buffer */
>> +               memcpy(buf, ptr, len);
>> +
>> +       return 0;
>> +}
>> +
>>   void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
>>                       enum bpf_dynptr_type type, u32 offset, u32 size)
>>   {
>> @@ -1782,6 +1832,8 @@ static int __bpf_dynptr_read(void *dst, u64 len, const struct bpf_dynptr_kern *s
>>          case BPF_DYNPTR_TYPE_SKB_META:
>>                  memmove(dst, bpf_skb_meta_pointer(src->data, src->offset + offset), len);
>>                  return 0;
>> +       case BPF_DYNPTR_TYPE_FILE:
>> +               return bpf_file_fetch_bytes(src->data, offset, dst, len);
>>          default:
>>                  WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
>>                  return -EFAULT;
>> @@ -2177,6 +2229,35 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
>>          }
>>   }
>>
>> +enum bpf_is_sleepable {
>> +       MAY_SLEEP,
>> +       MAY_NOT_SLEEP,
>> +};
> might be a bit of an overkill to have enum for this, but I don't feel
> strongly about this
>
>> +
>> +static int make_file_dynptr(struct file *file, u32 flags, enum bpf_is_sleepable sleepable,
>> +                           struct bpf_dynptr_kern *ptr)
>> +{
> nit: put it right before bpf_dynptr_from_file()?
No problem, but that makes patch look uglier, bpf_dynptr_from_file is 
substituted with make_file_dynptr.
>
>> +       struct bpf_dynptr_file_impl *state;
>> +
>> +       /* flags is currently unsupported */
>> +       if (flags) {
>> +               bpf_dynptr_set_null(ptr);
>> +               return -EINVAL;
>> +       }
>> +
>> +       state = bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_dynptr_file_impl));
>> +       if (!state) {
>> +               bpf_dynptr_set_null(ptr);
>> +               return -ENOMEM;
>> +       }
>> +       state->offset = 0;
>> +       state->size = U64_MAX; /* Don't restrict size, as file may change anyways */
>> +       freader_init_from_file(&state->freader, NULL, 0, file, sleepable == MAY_SLEEP);
>> +       bpf_dynptr_init(ptr, state, BPF_DYNPTR_TYPE_FILE, 0, 0);
>> +       bpf_dynptr_set_rdonly(ptr);
>> +       return 0;
>> +}
>> +
>>   __bpf_kfunc_start_defs();
>>
>>   __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>> @@ -2720,6 +2801,9 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
>>          }
>>          case BPF_DYNPTR_TYPE_SKB_META:
>>                  return bpf_skb_meta_pointer(ptr->data, ptr->offset + offset);
>> +       case BPF_DYNPTR_TYPE_FILE:
>> +               err = bpf_file_fetch_bytes(ptr->data, offset, buffer__opt, buffer__szk);
>> +               return err ? NULL : buffer__opt;
>>          default:
>>                  WARN_ONCE(true, "unknown dynptr type %d\n", type);
>>                  return NULL;
>> @@ -2814,7 +2898,7 @@ __bpf_kfunc int bpf_dynptr_adjust(const struct bpf_dynptr *p, u64 start, u64 end
>>          if (start > size || end > size)
>>                  return -ERANGE;
>>
>> -       ptr->offset += start;
>> +       bpf_dynptr_advance_offset(ptr, start);
>>          bpf_dynptr_set_size(ptr, end - start);
>>
>>          return 0;
>> @@ -4201,11 +4285,20 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct b
>>
>>   __bpf_kfunc int bpf_dynptr_from_file(struct file *file, u32 flags, struct bpf_dynptr *ptr__uninit)
>>   {
>> -       return 0;
>> +       return make_file_dynptr(file, flags, MAY_NOT_SLEEP, (struct bpf_dynptr_kern *)ptr__uninit);
>>   }
>>
>>   __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
>>   {
>> +       struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)dynptr;
>> +       struct bpf_dynptr_file_impl *df;
>> +
>> +       if (bpf_dynptr_get_type(ptr) == BPF_DYNPTR_TYPE_INVALID)
>> +               return 0;
> nit: let's just do what dynptr_read does:
>
> if (!dynptr->data)
>      return 0;
Thanks for nits, I'll apply them.
>> +
>> +       df = ptr->data;
>> +       freader_cleanup(&df->freader);
>> +       bpf_mem_free(&bpf_global_ma, df);
>>          return 0;
>>   }
>>
>> --
>> 2.51.0
>>


