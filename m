Return-Path: <bpf+bounces-34920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE09F932A1E
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 17:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374701F23CA2
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 15:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F247519E810;
	Tue, 16 Jul 2024 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DIOkgHeH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E66119DFA3
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142619; cv=none; b=JMgDo6FCbzeDq887e36IDRBE6Jfie7MHCXa6q6MGEC51jDE6EWUkxgg9JbR3OIC3Jkmv2ko0dl4veeHNvrBpX9XQna/mX5R7V3CQ2qmaDO2OrEzNs6mJDcj9SNRqN84tDYdWCdkl73tBb4atY/g7qMx7sMTbqEWqP1Gslsk4YJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142619; c=relaxed/simple;
	bh=ZSRehVcWplSUO1Ksx/9qV5ZPcn0gdNCaARNFWweijfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7wY5pTomteZobZj8ztN1gcBXzxQ9jZ3qTfJiqm1xxH+sSbEKknEBz4bvAa5Rzk3ha5xSqs7HOdVKBcvt51OJsp5j0Ibh7VqnGj6dIcHhK9G/0xkk4tzy8frKrDEIt0ebOG3LHXltjDePT4eHd8L5BbaoJ5TGbT0efexhXsdTLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DIOkgHeH; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eea7e2b0e6so76605951fa.3
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721142615; x=1721747415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4/wgiwAl+vPHpC6Ip5zX8zAjw09E1UUf/sCZNraOcw=;
        b=DIOkgHeHeW9nYAR3eJfvLkTqB0Rx9svaEi8pEyvfN+bPfyAnIfroCyPCSO5P3niF8L
         arb7HOBADctw3saDOxYZZ/wGwkL8bn/ZwtsMxuZ1p4gJTWzlCcO1U4rpz9WsAJHD+sJs
         MHdN/b9ODc5yFtX6dkaFkJg2ZgAXi11VMbxX91jlftJDybtLamznJZO01gghT1BkRosI
         a24712sdvquPRTAPyABgeeAakk/6nRzkvProjTWkMrO8VhZUek2ti4Gne12wwPKR4pHk
         0xePgko5jvLXEiABug45h56XFdpcAX75NhFgnDZ6KdD8Wqsz6tUhoumfMrxKbm5NzRJ4
         +UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721142615; x=1721747415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4/wgiwAl+vPHpC6Ip5zX8zAjw09E1UUf/sCZNraOcw=;
        b=kq1i/5VVHWbmLO99ptC9Wwq2MrnT1bH3E/o8kwAvDxM+zpAzpv8yGhysJ9ysAWsfkp
         8HaErYQ/R3v1KrzvZdARjXJAY5uRq5gVbmEA87KkbM+SFrDCSe3LYFV6g9EbW6IVV3zy
         C7SbXVOWTOKLPMsntGnfQui/UnfpF9wEqS/vl4cVuWfKIqCcn0JhDdAM3gR32JQ0gNFs
         pOiTCA/Z9R7Lnz5upGugRgM5GxdWr35vyQeLtxfELu6LoZa+xBzyOJXU/jo00LS8Exyl
         v8dcB19X4sGpvCnhgh8Iw4XjI3hC0fQWKYuIo9TBb05hGbE+lqNLHC8vuKz4Nhidf011
         7GeA==
X-Gm-Message-State: AOJu0YyQPuSIPWinMZ7WrIrkMBZZHwDB5e7I4kQKY1Rsgro6rWDqgBDD
	aAoZy/ubgEVqOg7B28+EbQWKwb4zzwoQKDXCd9is0jTuCG3hgHBjc8J40ojOCLs=
X-Google-Smtp-Source: AGHT+IFiOvaoUcwp4n9EIy0LxLIty7vY/0fRhdlSco0DZsnlkdLWGpnIHI8AOUzYc+quEeaYd/M8vg==
X-Received: by 2002:a2e:9bc9:0:b0:2ec:1f9f:a876 with SMTP id 38308e7fff4ca-2eef415febemr16662341fa.6.1721142615048;
        Tue, 16 Jul 2024 08:10:15 -0700 (PDT)
Received: from u94a (2001-b011-fa04-1e5c-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:1e5c:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc509d2sm59569005ad.281.2024.07.16.08.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:10:14 -0700 (PDT)
Date: Tue, 16 Jul 2024 23:10:06 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Matan Shachnai <m.shachnai@rutgers.edu>
Subject: Re: [RFC bpf-next] bpf, verifier: improve signed ranges inference
 for BPF_AND
Message-ID: <x47edrodilp3jeqdvhsoint7vyi4h6q7utsnnidn4aqu67imge@4fwj55m5o7cq>
References: <20240711113828.3818398-1-xukuohai@huaweicloud.com>
 <20240711113828.3818398-4-xukuohai@huaweicloud.com>
 <phcqmyzeqrsfzy7sb4rwpluc37hxyz7rcajk2bqw6cjk2x7rt5@m2hl6enudv7d>
 <4ff2c89e-0afc-4b17-a86b-7e4971e7df5b@huaweicloud.com>
 <ykuhustu7vt2ilwhl32kj655xfdgdlm2xkl5rff6tw2ycksovp@ss2n4gpjysnw>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bxzhch5mkzhbw5rv"
Content-Disposition: inline
In-Reply-To: <ykuhustu7vt2ilwhl32kj655xfdgdlm2xkl5rff6tw2ycksovp@ss2n4gpjysnw>


--bxzhch5mkzhbw5rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 16, 2024 at 10:52:26PM GMT, Shung-Hsi Yu wrote:
> This commit teach the BPF verifier how to infer signed ranges directly
> from signed ranges of the operands to prevent verifier rejection
...
> ---
>  kernel/bpf/verifier.c | 62 +++++++++++++++++++++++++++++--------------
>  1 file changed, 42 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8da132a1ef28..6d4cdf30cd76 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13466,6 +13466,39 @@ static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
>  	}
>  }
>  
> +/* Clears all trailing bits after the most significant unset bit.
> + *
> + * Used for estimating the minimum possible value after BPF_AND. This
> + * effectively rounds a negative value down to a negative power-of-2 value
> + * (except for -1, which just return -1) and returning 0 for non-negative
> + * values. E.g. masked32_negative(0xff0ff0ff) == 0xff000000.

s/masked32_negative/negative32_bit_floor/

> + */
> +static inline s32 negative32_bit_floor(s32 v)
> +{
> +	/* XXX: per C standard section 6.5.7 right shift of signed negative
> +	 * value is implementation-defined. Should unsigned type be used here
> +	 * instead?
> +	 */
> +	v &= v >> 1;
> +	v &= v >> 2;
> +	v &= v >> 4;
> +	v &= v >> 8;
> +	v &= v >> 16;
> +	return v;
> +}
> +
> +/* Same as negative32_bit_floor() above, but for 64-bit signed value */
> +static inline s64 negative_bit_floor(s64 v)
> +{
> +	v &= v >> 1;
> +	v &= v >> 2;
> +	v &= v >> 4;
> +	v &= v >> 8;
> +	v &= v >> 16;
> +	v &= v >> 32;
> +	return v;
> +}
> +
>  static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
>  				 struct bpf_reg_state *src_reg)
>  {
> @@ -13485,16 +13518,10 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
>  	dst_reg->u32_min_value = var32_off.value;
>  	dst_reg->u32_max_value = min(dst_reg->u32_max_value, umax_val);
>  
> -	/* Safe to set s32 bounds by casting u32 result into s32 when u32
> -	 * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
> -	 */
> -	if ((s32)dst_reg->u32_min_value <= (s32)dst_reg->u32_max_value) {
> -		dst_reg->s32_min_value = dst_reg->u32_min_value;
> -		dst_reg->s32_max_value = dst_reg->u32_max_value;
> -	} else {
> -		dst_reg->s32_min_value = S32_MIN;
> -		dst_reg->s32_max_value = S32_MAX;
> -	}
> +	/* Rough estimate tuned for [-1, 0] & -CONSTANT cases. */
> +	dst_reg->s32_min_value = negative32_bit_floor(min(dst_reg->s32_min_value,
> +							  src_reg->s32_min_value));
> +	dst_reg->s32_max_value = max(dst_reg->s32_max_value, src_reg->s32_max_value);
>  }
>  
>  static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
> @@ -13515,16 +13542,11 @@ static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
>  	dst_reg->umin_value = dst_reg->var_off.value;
>  	dst_reg->umax_value = min(dst_reg->umax_value, umax_val);
>  
> -	/* Safe to set s64 bounds by casting u64 result into s64 when u64
> -	 * doesn't cross sign boundary. Otherwise set s64 bounds to unbounded.
> -	 */
> -	if ((s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
> -		dst_reg->smin_value = dst_reg->umin_value;
> -		dst_reg->smax_value = dst_reg->umax_value;
> -	} else {
> -		dst_reg->smin_value = S64_MIN;
> -		dst_reg->smax_value = S64_MAX;
> -	}
> +	/* Rough estimate tuned for [-1, 0] & -CONSTANT cases. */
> +	dst_reg->smin_value = negative_bit_floor(min(dst_reg->smin_value,
> +						     src_reg->smin_value));
> +	dst_reg->smax_value = max(dst_reg->smax_value, src_reg->smax_value);
> +
>  	/* We may learn something more from the var_off */
>  	__update_reg_bounds(dst_reg);
>  }

Checked that this passes BPF CI[0] (except s390x-gcc/test_verifier,
which seems stucked), and verified the logic with z3 (see attached
Python script, adapted from [1]); so it seems to work.

Will try running tools/testing/selftests/bpf/prog_tests/reg_bounds.c
against it next.

0: https://github.com/kernel-patches/bpf/actions/runs/9958322024
1: https://github.com/bpfverif/tnums-cgo22/blob/main/verification/tnum.py

--bxzhch5mkzhbw5rv
Content-Type: text/x-python; charset=us-ascii
Content-Disposition: inline

#!/usr/bin/env python3
# Need python3-z3/Z3Py to run
from math import floor, log2
from z3 import *

SIZE = 32
SIZE_LOG_2 = floor(log2(SIZE))


class SignedRange:
    name: str
    min: BitVecRef
    max: BitVecRef

    def __init__(self, name, min=None, max=None):
        self.name = name
        if min is None:
            self.min = BitVec(f'SignedRange({self.name}).min', bv=SIZE)
        elif isinstance(min, int):
            self.min = BitVecVal(min, bv=SIZE)
        else:
            self.min = min
        if max is None:
            self.max = BitVec(f'SignedRange({self.name}).max', bv=SIZE)
        elif isinstance(max, int):
            self.max = BitVecVal(max, bv=SIZE)
        else:
            self.max = max

    def wellformed(self):
        return self.min <= self.max

    def contains(self, val):
        if isinstance(val, int):
            val = BitVecVal(val, bv=SIZE)
        return And(self.min <= val, val <= self.max)


def negative_bit_floor(x: BitVecRef):
    for i in range(0, SIZE_LOG_2):
        shift_count = 2**i
        # Use arithmetic right shift to preserve leading signed bit
        x &= x >> shift_count
    return x


s = Solver()
premises = []

# Given x that is within a well-formed srange1, and y that is within a
# well-formed srange2
x = BitVec('x', bv=SIZE)
srange1 = SignedRange('srange1')
premises += [
    srange1.wellformed(),
    srange1.contains(x),
]

y = BitVec('y', bv=SIZE)
srange2 = SignedRange('srange2')
premises += [
    srange2.wellformed(),
    srange2.contains(y),
]

# Calculate x & y
actual = x & y

# x & y will always be LESS than or equal to max(srange1.max, srange2.max)
guessed_max = BitVec('guessed_max', bv=SIZE)
premises += [
    guessed_max == If(srange1.max > srange2.max, srange1.max, srange2.max)
]

# x & y will always be GREATER than or equal to negative_bit_floor(min(srange1.min, srange2.max)
guessed_min = BitVec('guessed_min', bv=SIZE)
premises += [
    guessed_min == negative_bit_floor(If(srange1.min > srange2.min, srange2.min, srange1.min)),
]

# Check result
s.add(Not(
    Implies(
        And(premises),
        And(guessed_min <= actual, actual <= guessed_max))
))
result = s.check()

if result != sat:
    print('Proved!')
else:
    print('Found counter example')
    print(s.model())

--bxzhch5mkzhbw5rv--

