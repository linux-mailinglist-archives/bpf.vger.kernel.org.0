Return-Path: <bpf+bounces-49570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C85CDA1A152
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 10:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69039188F796
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1A020D518;
	Thu, 23 Jan 2025 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwc7Tq6d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C9420CCFF;
	Thu, 23 Jan 2025 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737626251; cv=none; b=dQ25IK36hNE1LwOsVKtcrsu9zzH7mQTYQiWI9RvPjeU/mCCyBdH964hYTGL1fh+3MxvCM52EBoUv7+/WiQCBWqLJs2ac0ob4oB6LALP7wkUPgX4fA6XqDvfmt+und2lUTTZ+XBIVm9kj4SesiUspj4M6IH58osQMdLyL9zqqKfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737626251; c=relaxed/simple;
	bh=/vAEK52q7uBJNkrN4G6SdTENXpvA0w8tJR9aBwTVdFM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qQIr551j6zbJ9UUTczeo4A585tPTHSeCEc9vTgxdDRvXDaGtTDt1XnKyjPznJHv8zC6D4iFRIfhIHTaq0z6PdsNuG7ojNB832KoCoEoIdScsNQIuc3LIebdCoI1bQOrH1NLdZzTFTVDyZylrRXbNq6qp+EZKr74KACRyTXsF+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwc7Tq6d; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so1327070a91.3;
        Thu, 23 Jan 2025 01:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737626250; x=1738231050; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sw7VZyJdBYUXtGkbOvHh8/tK+Oja2s5my7IQAmAEvDk=;
        b=jwc7Tq6dN68QOiHztn0mZWCcVfVTgRGCpq7pAn2W28oizDFi67dpLcUFd/8PzRMQQw
         tUAU8LZtpOhlO4aa4zitzXnH+I6yuDg0j238ujSpWfdffR4P5jt80EHXL0hiAxfXSygE
         k/CMTjdL5dEHn2DMho0AoNlT7Ab+8WwJcX73p/Ox/8hejxquC1xIkfnlJQlVMdYqBdQT
         tkJuZ9Wxm4iXr5jfRg/Ma8o6DiLiztCjXH+cWyWGwP6GC1l1ght9R+Y5+73KwNrKwsge
         oAFmRNaJAkpoROmOfQ8oFF5wvsbvBXNizoyrKT9PvrUaUmV+A5ExqP+P4QIQoiKu7SwM
         TT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737626250; x=1738231050;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sw7VZyJdBYUXtGkbOvHh8/tK+Oja2s5my7IQAmAEvDk=;
        b=HeuPi8XVb0HDxU3S3cUNeO02HKNFbvgL5KTdL+XVyLrNoxufpJz9V0C2NoNm/ryKmA
         Ame8FV+QlAaqVUWJz87QrEHQl8MFFaV6tSiSSMFVlw/917xQtGi09jwtzODCL/0WoKx0
         NQ38GQUXsH7csQRMb7eHa2LU4cl/wNUEm+h25Qu/8RVj4bafatS7zcbxAMeuOOAqFxuQ
         OZiZ43Tx4QHCOXMyE+ukKI5OQN6ssUzLKjrMC12BnV0avDG5U6TW//+eXwClBH033j29
         ywlAQbI7UapSDl3ZQvsQWCUOK6x1m/DiFeHotGrEEkGcEOHpjXi5FnbzpUSOak3azUKQ
         9/qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO+0EAyPZqnuaKaxut0hpg/UVQzgvaT/d/3I/DinYoFUk3xVVozRpPCqfXVu1Y1VLvlvo7Fw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6TC9rJacL0u9usq4lNiqVE0LaloIsliwMll1qQS9SwUYdp7f
	/N/yjcpfTe54vvlKx0OMrBT1yo5wyMboo7jBvwknsiPPPJDgdHaJ
X-Gm-Gg: ASbGncvmfG+Jbe326oYLx5bHRsNsxki+JNJy2cJNCB/YJ9gmuIxe4j+QTxpjc9MnCYI
	ni6TJ3jbCH9cfVx8CuIxZZXE5y92mTRpuw9rX1wJG8Yb6LEBPkbcUMornNnwdCrMSwCmAql4KU+
	bbifMEdG0St2wyKkqL75Q9Lio3qZDollOgtc5+4E3jEDxjU81/u2D4LKvIBoCrRnGFEamCxZMzT
	g2c/fMtVnIXbfDzQFAd1K4bXFxN0es1dSY7rHfI5PMcjATECxjDi383YLRrMi2HuMMzeyeOSOXB
	mw==
X-Google-Smtp-Source: AGHT+IEDyxRuhjSThiXv9pfK8LxzqGHri8hLpIB9QRvMrHjzDNHLJwt848w3innMNoBeQmA7MhCeAw==
X-Received: by 2002:a17:90b:258c:b0:2ee:c9b6:c266 with SMTP id 98e67ed59e1d1-2f782c71d97mr37848806a91.13.1737626249633;
        Thu, 23 Jan 2025 01:57:29 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6abedd9sm3469039a91.32.2025.01.23.01.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 01:57:29 -0800 (PST)
Message-ID: <16c2f9b5d9c91bf5b8ee8c18a17c9cf846b394e8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 02/14] selftests/bpf: Test referenced kptr
 arguments of struct_ops programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com, 
	toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, stfomichev@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com, amery.hung@bytedance.com
Date: Thu, 23 Jan 2025 01:57:24 -0800
In-Reply-To: <20241220195619.2022866-3-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
		 <20241220195619.2022866-3-amery.hung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-20 at 11:55 -0800, Amery Hung wrote:

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail=
__global_subprog.c b/tools/testing/selftests/bpf/progs/struct_ops_refcounte=
d_fail__global_subprog.c
> new file mode 100644
> index 000000000000..43493a7ead39
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__globa=
l_subprog.c
> @@ -0,0 +1,37 @@
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../test_kmods/bpf_testmod.h"
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +extern void bpf_task_release(struct task_struct *p) __ksym;
> +
> +__noinline int subprog_release(__u64 *ctx __arg_ctx)
> +{
> +	struct task_struct *task =3D (struct task_struct *)ctx[1];
> +	int dummy =3D (int)ctx[0];
> +
> +	bpf_task_release(task);
> +
> +	return dummy + 1;
> +}
> +
> +/* Test that the verifier rejects a program that contains a global
> + * subprogram with referenced kptr arguments
> + */
> +SEC("struct_ops/test_refcounted")

Nit: I'd add a __msg("Validating subprog_release() func#1...")
     before the error message match, just to make sure that
     error is reported when subprog_release() is verified.

> +__failure __msg("invalid bpf_context access off=3D8. Reference may alrea=
dy be released")
> +int refcounted_fail__global_subprog(unsigned long long *ctx)
> +{
> +	struct task_struct *task =3D (struct task_struct *)ctx[1];
> +
> +	bpf_task_release(task);
> +
> +	return subprog_release(ctx);
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod_ref_acquire =3D {
> +	.test_refcounted =3D (void *)refcounted_fail__global_subprog,
> +};

[...]


