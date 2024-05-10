Return-Path: <bpf+bounces-29545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9518C2BF4
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 23:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB0CB212E6
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A6513BAD8;
	Fri, 10 May 2024 21:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDIq9HYH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1AB4DA16;
	Fri, 10 May 2024 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376815; cv=none; b=E9n/w+7wK8UP4TrkzcGUGZP7HQdxcEzZIinnmi2i3hUVjcx6n/joZt//E9T8IR26XuikMlU4WYh5z6MPB9Spuzsynkzo/PJSi1d+/ps5idpjJv7zkgA5gq2Pc2tJF6CopGZPNZfo3oJOwKKNooKxPfsSX8+zoepEyND0VT9cwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376815; c=relaxed/simple;
	bh=qJAuruMK4NePauEVRAdce/zUxbjNyiA1y+LP6RmJwR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iijq25pXfyveOhGG/glBOKl+M5b7Gz9agAs89WBxvzZSLx9E9GlPEgo1OkK3WBGj0VxlGHLTCJ21OFpqw2EP7hxKwWnRn2NnLuX2GbXujslIisnUddaLdA+qHAsMSL1Bd2sDnduiWr6J++ClbTU9JdQKv4nkeDYVIL78T5evdtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDIq9HYH; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f07115e6caso1383449a34.2;
        Fri, 10 May 2024 14:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715376813; x=1715981613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w7jCN7Tb/qp53kdU8f7DRADLT6XbW+S6zuM+QzCIcT8=;
        b=bDIq9HYHfq1VQZBNmRyRPP5V2CWiIG2ORRG/xqH7ileWoiBrhOkY8FjCUn96LE0QpA
         3hDEy/AALNv5uydmmr7TsJw4kKPaaI1+le2UOQpdj3O1t2Ms38i7ohUSNLaCOkVGJcLD
         OaUR/NDLr4lK0SixklvT+tVpJoxwVZp7FfOBeTxRvyVdz9b+O8W0fMltynHvtfKRxPi0
         Sg46/4NAcOWNZt/YojVyBDcv2DfhP2D5I8ukDhHNxGFjd7VpKpCObZmlz3oEpB5w73YX
         RA0fIZNLMRUgLHSy8Dbj2HSTjmIrSvsmeJwrF+RojArPjLaaeTSDPf+QTEpKs91FWcG7
         3x/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715376813; x=1715981613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7jCN7Tb/qp53kdU8f7DRADLT6XbW+S6zuM+QzCIcT8=;
        b=GgShBzFtzJNX4UuduqUmRgHgekx3YBDSNslXlsf8Jl0UHgS3L3+Nvls23iJ+kTEu08
         842NL9PP39hFbfqDg+9FLN9UwNXHfZBzQ6Ie1HkEhaNOGbF7RWunKCD5Lk0Rt+ylrTOa
         Z7LOe/nisuUZNQI/PLg6jrp3y5BPZXEA3gYzww7LYDtEmeNpyrDJMz1th+7TicM+/DNt
         /WjvR07bC+VcUFwQ+V0dKkNp6pzJOhHa2CDX1H5rluT4P+6wEZbIQr0LJxVHZPo0Bflc
         GCvP3jjH6VAIOOgogwSgVJyCSf0UaZL4G3ZmTwp5Wh6CVRkBGj1XQd5CoPLMhYl4mRTR
         3Tfg==
X-Forwarded-Encrypted: i=1; AJvYcCX3hEIQGcgWFZCsCYY0m4ykutX79KVhOGsQCebJ5xy2cnThwOr/YUnQGRYzQUq1WdBwoLYQzsyr7PZVEhBFJYRH1+9p4+UQ
X-Gm-Message-State: AOJu0YzhxfU6TrWwQKSGnV5KwCRfbpk6Pe5rgyJLcn2IMyqBVb+nzX9B
	E6Nz4hiVc2JmrzhMrBxMueQTqNN/m7IaUrai90HcbovtaFrYEDXa
X-Google-Smtp-Source: AGHT+IHJ2LWGxblIDSaQ9qYDlaIber8y049mEN3clexUmMm1/ZGGgaMp8xIB4bZpqSvB8TUfXtMhAA==
X-Received: by 2002:a05:6830:22e6:b0:6f0:7a2c:2b3f with SMTP id 46e09a7af769-6f0e92c9a65mr4545209a34.27.1715376813201;
        Fri, 10 May 2024 14:33:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:20fd:6927:f7be:d222? ([2600:1700:6cf8:1240:20fd:6927:f7be:d222])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0f679ca97sm7931a34.29.2024.05.10.14.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 14:33:32 -0700 (PDT)
Message-ID: <b2486867-0fee-4972-ad71-7b54e8a5d2b6@gmail.com>
Date: Fri, 10 May 2024 14:33:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 02/20] selftests/bpf: Test referenced kptr
 arguments of struct_ops programs
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, toke@redhat.com, jhs@mojatatu.com,
 jiri@resnulli.us, sdf@google.com, xiyou.wangcong@gmail.com,
 yepeilin.cs@gmail.com
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-3-amery.hung@bytedance.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240510192412.3297104-3-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/10/24 12:23, Amery Hung wrote:
> A reference is automatically acquired for a referenced kptr argument
> annotated via the stub function with "__ref_acquired" in a struct_ops
> program. It must be released and cannot be acquired more than once.
> 
> The test first checks whether a reference to the correct type is acquired
> in "ref_acquire". Then, we check if the verifier correctly rejects the
> program that fails to release the reference (i.e., reference leak) in
> "ref_acquire_ref_leak". Finally, we check if the reference can be only
> acquired once through the argument in "ref_acquire_dup_ref".
> 
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  7 +++
>   .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  2 +
>   .../prog_tests/test_struct_ops_ref_acquire.c  | 58 +++++++++++++++++++
>   .../bpf/progs/struct_ops_ref_acquire.c        | 27 +++++++++
>   .../progs/struct_ops_ref_acquire_dup_ref.c    | 24 ++++++++
>   .../progs/struct_ops_ref_acquire_ref_leak.c   | 19 ++++++
>   6 files changed, 137 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_ref_acquire.c
>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_ref_acquire.c
>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_ref_acquire_dup_ref.c
>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_ref_acquire_ref_leak.c
> 
> 
  ... skipped ...
> +
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_ref_acquire.c b/tools/testing/selftests/bpf/progs/struct_ops_ref_acquire.c
> new file mode 100644
> index 000000000000..bae342db0fdb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_ref_acquire.c
> @@ -0,0 +1,27 @@
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../bpf_testmod/bpf_testmod.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +void bpf_task_release(struct task_struct *p) __ksym;
> +
> +/* This is a test BPF program that uses struct_ops to access a referenced
> + * kptr argument. This is a test for the verifier to ensure that it recongnizes
> + * the task as a referenced object (i.e., ref_obj_id > 0).
> + */
> +SEC("struct_ops/test_ref_acquire")
> +int BPF_PROG(test_ref_acquire, int dummy,
> +	     struct task_struct *task)
> +{
> +	bpf_task_release(task);

This looks weird for me.

According to what you mentioned in the patch 1, the purpose is to
prevent acquiring multiple references from happening. So, is it possible
to return NULL from the acquire function if having returned a reference
before?


> +
> +	return 0;
> +}
> +
> +
... skipped ...

