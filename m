Return-Path: <bpf+bounces-18669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4760781E501
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 06:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11071F2264A
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 05:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED8A4B13A;
	Tue, 26 Dec 2023 05:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YUUg6sp1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BA94AF9E
	for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 05:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-336c5b5c163so423270f8f.1
        for <bpf@vger.kernel.org>; Mon, 25 Dec 2023 21:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1703568569; x=1704173369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbB2JPqHEcTCfqFCHcMzuBq1bWzXZGI6RndxESie8U8=;
        b=YUUg6sp15WwM6Yn54TEVBwTj4AHGPl1eolhbEEU6wSOYuFgchFiLJBBg7laGkYekEh
         4UrrqZWjdR4mAzotaY5ifpGQW5fbyUcwWkuzV7YC0Yi0dsEABPU0X0JbSLDuILERYA9d
         3AE5w7PNL3hQFD3ro+S2UfcHafq2o+YXc0n/wYCTvg2jVADipcBDCemYDFBC7/7z+jer
         WZWHTnHfGZDDG3Cdm8A77tqcuSfnADIkejDhxwwEuNAJzGJcddQej6hidhB7seQKYWUb
         iOnWVgrIVgyauyoke9L0r2EPMA8tppaG2QYGsKlbZmKwMUDjLTYc+NQSWLzLOfuKFEFg
         LnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703568569; x=1704173369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbB2JPqHEcTCfqFCHcMzuBq1bWzXZGI6RndxESie8U8=;
        b=wjS2gGA+CSuDQMSZtFe7O2uzKjJqPCKizVJWAWRc/mgvI6mmMXhPD9uo+Q8IZsOB7v
         L1c5+UGnZlSLv/RWkJNDtzHEJotvJXmumi/OSqWsWlv7Xk5sYgiKqNOLhF0LBgSVk6rj
         o/aPG8smO9hqJ8aTWxkdS2YUMjCioHvS/THtDZAgi3EMCM7LlmcEjV3ryGz4/sbi9aga
         Uxdoa1nm7aoiE1zv1gSObDiW+1efnZv0E6Zv1/R03p0OLWdAeLbRqxkmKxhvVXbiENWQ
         T44bvmElAx7uNDRGNXRJkou3BTDEXqqR4AUpkWS0xJzXf9SpHyKGy6Ch6MWci3kywaJv
         5hig==
X-Gm-Message-State: AOJu0Yy99AFtqxYPvMUN5CkQzwvJPcInosfy2OC2+vUrC/9sNkCcwy0O
	zbTWrhtNmthwb9PfH5J7BYzrX6BVgajSWg==
X-Google-Smtp-Source: AGHT+IEf953HVDctk9IlkhTgEgejAotU3OGZ8nHJxwAuMB0A1IRaBlrVcMFQP6J2r3JX0NoQtXBwfg==
X-Received: by 2002:adf:f408:0:b0:336:746a:3ffb with SMTP id g8-20020adff408000000b00336746a3ffbmr3650586wro.27.1703568569052;
        Mon, 25 Dec 2023 21:29:29 -0800 (PST)
Received: from u94a ([2401:e180:8881:29fd:60cd:5854:a823:d51f])
        by smtp.gmail.com with ESMTPSA id w14-20020adfee4e000000b0033609750752sm11773892wro.8.2023.12.25.21.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 21:29:28 -0800 (PST)
Date: Tue, 26 Dec 2023 13:29:07 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Maxim Mikityanskiy <maxim@isovalent.com>
Subject: Re: [PATCH bpf-next 12/15] bpf: Preserve boundaries and track
 scalars on narrowing fill
Message-ID: <n5caqqppcgi5sjtfpobndbb7jswnfklyzpk2diocvuolw2kr26@vgsd2wnmpqp5>
References: <20231220214013.3327288-1-maxtram95@gmail.com>
 <20231220214013.3327288-13-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220214013.3327288-13-maxtram95@gmail.com>

On Wed, Dec 20, 2023 at 11:40:10PM +0200, Maxim Mikityanskiy wrote:
> When the width of a fill is smaller than the width of the preceding
> spill, the information about scalar boundaries can still be preserved,
> as long as it's coerced to the right width (done by coerce_reg_to_size).
> Even further, if the actual value fits into the fill width, the ID can
> be preserved as well for further tracking of equal scalars.
> 
> Implement the above improvements, which makes narrowing fills behave the
> same as narrowing spills and MOVs between registers.
> 
> Two tests are adjusted to accommodate for endianness differences and to
> take into account that it's now allowed to do a narrowing fill from the
> least significant bits.
> 
> reg_bounds_sync is added to coerce_reg_to_size to correctly adjust
> umin/umax boundaries after the var_off truncation, for example, a 64-bit
> value 0xXXXXXXXX00000000, when read as a 32-bit, gets umin = 0, umax =
> 0xFFFFFFFF, var_off = (0x0; 0xffffffff00000000), which needs to be
> synced down to umax = 0, otherwise reg_bounds_sanity_check doesn't pass.
> 
> Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> ---
>  kernel/bpf/verifier.c                         | 20 ++++++++++---
>  .../selftests/bpf/progs/verifier_spill_fill.c | 28 +++++++++++++------
>  2 files changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9b5053389739..b6e252539e52 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4772,7 +4772,13 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
>  			if (dst_regno < 0)
>  				return 0;
>  
> -			if (!(off % BPF_REG_SIZE) && size == spill_size) {
> +			if (size <= spill_size &&
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> +			    !(off % BPF_REG_SIZE)
> +#else
> +			    !((off + size - spill_size) % BPF_REG_SIZE)
> +#endif

If I understand correctly, it is preferred to keep endianess checking
macro out of verfier.c and have helper function handle them instead.

E.g. See bpf_ctx_narrow_access_offset() from include/linux/filter.h

> [...]

