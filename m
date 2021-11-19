Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177BB456EC0
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 13:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhKSMVG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 07:21:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234665AbhKSMVF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Nov 2021 07:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637324283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T5sacKdmvf7Zw/fCWtoiBAx64x6GCxsrBijsCkaBzNI=;
        b=bsg45TpLR2rm2OklCJ4K1dqrjicopCIQHOzZpQxHLmY+a6CNBcsPJ64kPStMhbjIMDb14S
        6lxviQKD6HzqSbiMhRbSdEm2lI/Q4Tek4MAnZoUwATyRe90SOpqguJ8ncBZeh5IpNWcbPx
        pFKQPqb8mNtlEzX9Jmv6yeyGulVMxrE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-3ptaR5_oOEGOfNdc_H-sDQ-1; Fri, 19 Nov 2021 07:18:02 -0500
X-MC-Unique: 3ptaR5_oOEGOfNdc_H-sDQ-1
Received: by mail-ed1-f71.google.com with SMTP id c1-20020aa7c741000000b003e7bf1da4bcso8193202eds.21
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 04:18:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=T5sacKdmvf7Zw/fCWtoiBAx64x6GCxsrBijsCkaBzNI=;
        b=IdtryFh8s/318Nl4IF6CHapLI3MKI7fpMgZn7aPvjKkm2jyBv4v2eI4nAB3ZZRBoEZ
         7sOYXbnSZ3kScJoKMgYu+KGOxc898wdxSAzKjMnRaoao/mllgmMqKg6jIwU2rTaSBQxL
         CVIQLi07LCKFu+0zFHZEkJuavdTSVJeicEEQn/pN5qsLl2C+R6JkKWoBLRGbM4NGxfY/
         d9RuSUnUeCQXkBySQSsnCwww3clwaxT8/vKVrupx/DyGA7G3JakU1tB1eSZLQLMwIULW
         xsHXNXBtTHy2xjVvz00U0IpseTXeWswApo8OZWQGcbxQBsRogvp8gTNCpR6YJta1PyPe
         56Gw==
X-Gm-Message-State: AOAM533qPewt8HBZ41jsjjEmnmOEpQJDYP9pYP+QMKFuWQk9H8fn2FhD
        jayJ68qMl8+2meSKMRp2naXk8w4xjYg6GMs9HLTRNOKpxpsUmW5/G9hE1bCOKPMtTKcKSsm1WlT
        LeBUqmZWpp96w
X-Received: by 2002:a50:bf01:: with SMTP id f1mr23493173edk.102.1637324281102;
        Fri, 19 Nov 2021 04:18:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYgh2ryKZ4i84VDb0X766eQxXPhAOxy2o2VGc0FX2bHGr10+KOByZ3Vc1MnHrG9bdcHWNCTg==
X-Received: by 2002:a50:bf01:: with SMTP id f1mr23493115edk.102.1637324280751;
        Fri, 19 Nov 2021 04:18:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id w5sm1521819edc.58.2021.11.19.04.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 04:18:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 508F1180270; Fri, 19 Nov 2021 13:17:59 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yonghong Song <yhs@fb.com>, Joanne Koong <joannekoong@fb.com>,
        bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, Kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Add bpf_for_each helper
In-Reply-To: <43eae5e9-1741-001f-45fa-a516f291fecb@fb.com>
References: <20211118010404.2415864-1-joannekoong@fb.com>
 <20211118010404.2415864-2-joannekoong@fb.com> <87wnl5en13.fsf@toke.dk>
 <43eae5e9-1741-001f-45fa-a516f291fecb@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 19 Nov 2021 13:17:59 +0100
Message-ID: <87fsrse3uw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> writes:

> On 11/18/21 3:11 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Joanne Koong <joannekoong@fb.com> writes:
>>=20
>>> This patch adds the kernel-side and API changes for a new helper
>>> function, bpf_for_each:
>>>
>>> long bpf_for_each(u32 nr_interations, void *callback_fn,
>>> void *callback_ctx, u64 flags);
>>>
>>> bpf_for_each invokes the "callback_fn" nr_iterations number of times
>>> or until the callback_fn returns 1.
>>>
>>> A few things to please note:
>>> ~ The "u64 flags" parameter is currently unused but is included in
>>> case a future use case for it arises.
>>> ~ In the kernel-side implementation of bpf_for_each (kernel/bpf/bpf_ite=
r.c),
>>> bpf_callback_t is used as the callback function cast.
>>> ~ A program can have nested bpf_for_each calls but the program must
>>> still adhere to the verifier constraint of its stack depth (the stack d=
epth
>>> cannot exceed MAX_BPF_STACK))
>>> ~ The next patch will include the tests and benchmark
>>>
>>> Signed-off-by: Joanne Koong <joannekoong@fb.com>
>>=20
>> Great to see this! One small nit, below, but otherwise:
>>=20
>> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>>=20
>>> ---
>>>   include/linux/bpf.h            |  1 +
>>>   include/uapi/linux/bpf.h       | 23 +++++++++++++++++++++++
>>>   kernel/bpf/bpf_iter.c          | 32 ++++++++++++++++++++++++++++++++
>>>   kernel/bpf/helpers.c           |  2 ++
>>>   kernel/bpf/verifier.c          | 28 ++++++++++++++++++++++++++++
>>>   tools/include/uapi/linux/bpf.h | 23 +++++++++++++++++++++++
>>>   6 files changed, 109 insertions(+)
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index 6deebf8bf78f..d9b69a896c91 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -2107,6 +2107,7 @@ extern const struct bpf_func_proto bpf_get_socket=
_ptr_cookie_proto;
>>>   extern const struct bpf_func_proto bpf_task_storage_get_proto;
>>>   extern const struct bpf_func_proto bpf_task_storage_delete_proto;
>>>   extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
>>> +extern const struct bpf_func_proto bpf_for_each_proto;
>>>   extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
>>>   extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
>>>   extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index bd0c9f0487f6..ea5098920ed2 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -4750,6 +4750,28 @@ union bpf_attr {
>>>    *		The number of traversed map elements for success, **-EINVAL** for
>>>    *		invalid **flags**.
>>>    *
>>> + * long bpf_for_each(u32 nr_iterations, void *callback_fn, void *callb=
ack_ctx, u64 flags)
>>> + *	Description
>>> + *		For **nr_iterations**, call **callback_fn** function with
>>> + *		**callback_ctx** as the context parameter.
>>> + *		The **callback_fn** should be a static function and
>>> + *		the **callback_ctx** should be a pointer to the stack.
>>> + *		The **flags** is used to control certain aspects of the helper.
>>> + *		Currently, the **flags** must be 0.
>>> + *
>>> + *		long (\*callback_fn)(u32 index, void \*ctx);
>>> + *
>>> + *		where **index** is the current index in the iteration. The index
>>> + *		is zero-indexed.
>>> + *
>>> + *		If **callback_fn** returns 0, the helper will continue to the next
>>> + *		iteration. If return value is 1, the helper will skip the rest of
>>> + *		the iterations and return. Other return values are not used now.
>>=20
>> The code will actually return for any non-zero value, though? So
>> shouldn't the documentation reflect this? Or, alternatively, should the
>> verifier enforce that the function can only return 0 or 1?
>
> This is enforced in verifier.c prepare_func_exit().
>
>          if (callee->in_callback_fn) {
>                  /* enforce R0 return value range [0, 1]. */
>                  struct tnum range =3D tnum_range(0, 1);
>
>                  if (r0->type !=3D SCALAR_VALUE) {
>                          verbose(env, "R0 not a scalar value\n");
>                          return -EACCES;
>                  }
>                  if (!tnum_in(range, r0->var_off)) {
>                          verbose_invalid_scalar(env, r0, &range,=20
> "callback return", "R0");
>                          return -EINVAL;
>                  }
>          }

Ah, right! I went looking for this but couldn't find it - thanks for the
pointer!

-Toke

