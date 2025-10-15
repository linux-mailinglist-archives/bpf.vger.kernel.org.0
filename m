Return-Path: <bpf+bounces-71060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D0ABE0EAC
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 00:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C110E4823BB
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 22:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E26304BD8;
	Wed, 15 Oct 2025 22:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvqF1SI7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185FA2566E2
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566584; cv=none; b=Lm2AscJ2IAq/1hLz84hj4cPys3hr7Ww9sIK/U1sHtq16NVmZgrT0oQRPvmFxRja80JqD/cliTnDZP2K9n8t7CXXmLu3JmIqRiA4bNBSjbkRQjo6STDhFB6uDyu8fw2Q89iQjJ0tmoemZrrW5yJeSCfJtOBsVWM4wy0UANh6jNGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566584; c=relaxed/simple;
	bh=y2aFEspC4qvGl6I+JvU7ebmHHyWdqwfjc7KvycGDyXg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A966WVOGryg/2wNYHvNkF5U4WzlFdxa3gcb2z+R78F/ZQwSUCtkucsWVpG0j7pZ/bhqYaWaCUcwGvjb7XSoQbYTyouYeuCTHIMJ/xU9T2R4GP/xVLXGA/DmptV/ozIrWlHz8/ydAhE17NkB9c8xM8YD3yeFA1pzPZC4/sqmbos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvqF1SI7; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so140041a91.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 15:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760566582; x=1761171382; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tor/6/gXgo4Gucr5LW4nRDaDR/oTlJOqbqjjwX4NAhI=;
        b=HvqF1SI7HO2yuMbjtiVrlzlpuNjhEJ//yhGzfz/8sPqqQLxcbW87Paux/MW2MAOWlf
         RU4dEe1jPexRCYQ/+WQt/6dEgS5noYFTlDd8wPLnb4qiAi//a0IV2cqfqZBFCZMn/2ut
         qc7uyfbge5QAhccPSJrNCj2+timxsLJO1YlJBKc8+s0Ti25QrhqmtQmD7djXO4pAYnFi
         I6mWntXEOVfgrN/JH8qu9pW3m4XR5X/g9vFl0sWyy48L7F67su1nBdQVq/8q2oShME0x
         uA9ZSrOooly7LdFk/gV0auY4CuBYTtZfMwdj2VTCoCQjXWqvCz/gHs9ugJDxRQCO+sM1
         Ynbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760566582; x=1761171382;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tor/6/gXgo4Gucr5LW4nRDaDR/oTlJOqbqjjwX4NAhI=;
        b=GlEcgE9gNKALADDlrQAMMKImtndEJgeqTPkydjXPI7HV8j5gr26fPeR6xTix1s/PHt
         v5WfMQDU+uICL4t3B0NCE3oLNfqEFoAz7bTjNleTWWGDYq7hr0Tgz2f5re7o4VDWRRWc
         IBDMQNGGiKGnAGVFhk8C3YYacsh1UYJg6YcTIL2zlR0bZ7NWjM1Y6Mtg3Sz4BBuOxnFX
         4/b6d5au1Ng8rb5xoQM0VpKn2O13B/XXDG9vxbSVv6UQ1nbdCd4PRTYeOFqL9D04rlsW
         Hn2fBiZ0mM8HLMRbDjccQkqSy8noXCwfG96f6pdlCwl3sj9VkBH5qbEaf/rdMHB4oeI+
         j9FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhNU0tcaA5kJL0+4mucUkfyhLCnPgCpolWFQMBr5HYgeOnBNCQwNpx+T8K6OEScjkj0mI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ftHdgG1o5HzPSFCu8Acdc908MvUiZBPpnJKlXAo3MzSmwYXH
	2w5/kKNUd59tS8o6IbfzyYYzGup8dm/7DwDJG6bCD92rc9yAF/dWyvB/
X-Gm-Gg: ASbGncvb3FTTqpescwORX0UdgOYQdHX8P1cS5241L0haBE7dSA7V6aFen1A+ttgP7X2
	UualWlZ4mVvau28k0hDWbnlmYxpjJTSBtr3fut3TEEgr6mf6vz8omUVncEX4NzUfazTrcCHOBu0
	uBhNRaZoBo7gnLgiMpMCgbMV1ej8kd5WL/Kt+io6GaTLABnGdEencg94sPsvk09eMo7wrdnRxiq
	idb9rtBE6ZxBetR1IxenSGGf+48Q87BbJROYR4HTaZ1gdTaH/M5AacJ+FVt87UwRijm+t9hkCM1
	Fc2RHG3zP9c9kD591MbnncDeIoJRfCLCm5NlGZb9sNubJAxsNvK4RYtOHi80xa6lNP822lJjyo/
	sePPTZsd75n6D18DaPzniVwjaDSbFZbC8iNJTPi2y5KcChrwX4HCPu6VWSX2RHelqpPv+kmkOzH
	suBKTz3//g0IEa8iuRLsc=
X-Google-Smtp-Source: AGHT+IEHtqzO/J0SvwRFkgsQcvsRpnailGk13QW5llw8dY9eRPZJGtiD4lj3syPaH8IMA3qeSYuxOA==
X-Received: by 2002:a17:90b:1d85:b0:335:28ee:eebe with SMTP id 98e67ed59e1d1-33b5138e625mr39477711a91.30.1760566582209;
        Wed, 15 Oct 2025 15:16:22 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33ba927394csm202485a91.0.2025.10.15.15.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:16:21 -0700 (PDT)
Message-ID: <a2b0241a646c991c280fbc35925e0a52d01b419a.camel@gmail.com>
Subject: Re: [RFC PATCH v2 08/11] bpf: add kfuncs and helpers support for
 file dynptrs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 15 Oct 2025 15:16:19 -0700
In-Reply-To: <20251015161155.120148-9-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
	 <20251015161155.120148-9-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:

Overall, lgtm.

[...]

> @@ -4253,13 +4308,45 @@ __bpf_kfunc int bpf_task_work_schedule_resume(str=
uct task_struct *task, struct b
>  	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, =
TWA_RESUME);
>  }
> =20
> -__bpf_kfunc int bpf_dynptr_from_file(struct file *file, u32 flags, struc=
t bpf_dynptr *ptr__uninit)
> +static int make_file_dynptr(struct file *file, u32 flags, bool may_sleep=
,
> +			    struct bpf_dynptr_kern *ptr)
>  {
> +	struct bpf_dynptr_file_impl *state;
> +
> +	/* flags is currently unsupported */
> +	if (flags) {
> +		bpf_dynptr_set_null(ptr);
> +		return -EINVAL;
> +	}
> +
> +	state =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_dynptr_file_i=
mpl));
> +	if (!state) {
> +		bpf_dynptr_set_null(ptr);
> +		return -ENOMEM;
> +	}
> +	state->offset =3D 0;
> +	state->size =3D U64_MAX; /* Don't restrict size, as file may change any=
ways */

If ->size field can't be relied upon, why tracking it at all?
Why not just return U64_MAX from __bpf_dynptr_size()?

> +	freader_init_from_file(&state->freader, NULL, 0, file, may_sleep);
> +	bpf_dynptr_init(ptr, state, BPF_DYNPTR_TYPE_FILE, 0, 0);
> +	bpf_dynptr_set_rdonly(ptr);
>  	return 0;
>  }

[...]

