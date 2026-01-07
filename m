Return-Path: <bpf+bounces-78115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 176A0CFEA2E
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 16:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55A7E304485A
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 15:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B53357A26;
	Wed,  7 Jan 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyZCt7UO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8366E33C192
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798393; cv=none; b=kExKBBr3xGqboWdANTC+ksVexjjBrTWuH+E2kGBzLpfleL3uLagqy/meAcVsdYdmwtyvXZLzQbUlnKAt5k+FkGsOToQ2HAwamoM+2Aa8sBwvNpKGraSsBAHLPKL6Z+UacTnvcxa7OFp802UJRpEI+sQDLJ86qZ6I5B05qfCv/xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798393; c=relaxed/simple;
	bh=nRzEKcnodrdmLOT68bKUkftXlKNUGFjzka5YXEhqvZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+HhmjREsBLrIPQNW+NVbIXKYz+xx+6eZMyUuPa89Kvi5LZjY+B+OoBAlww0f6ESQftkmyMrJriN4FByazUgfeVNzwtlLAkIDaoCJRKQORms1WodXLqYgqC35rzSudlT+gjVHW6pFx7CibAgJK1P+E22WjQdMkit1tJwxXkkZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyZCt7UO; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6505cbe47d8so3458276a12.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 07:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767798390; x=1768403190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3uIR9HTLjoZ4sczTjOd7p4sVCibBxQvhYaojSMiHmj0=;
        b=XyZCt7UOGsMYv+KZ4eeM03leGEGLDSvL57DnYVU5Gu92AaXgEntPoJD/silGVD1afC
         lwa8fHHZBT86CPSgJ1o6GaosbPzDka0f/c+V/CVxNgnAvhEWlwFGO4S55QCT6KLL+7sX
         KKwVbVck7kqmwEEz66Ozkzd8t5zdYSmbwO6QbecSi966nQVzbR2dCcZdGqA1m143ugxo
         utydplDMr/yNARphrFFHjgjG7gFCw7lhwWAapO7kNfCfnNqDA6nkpas7yvFeClDSTo/k
         a9nQNdnjMEllesVV/s1565uKSmGDjYnLKhEtU9agRI6jWX5Q9tDAF4fKQh6rEIcD6ntb
         IZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767798390; x=1768403190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uIR9HTLjoZ4sczTjOd7p4sVCibBxQvhYaojSMiHmj0=;
        b=wsKMdhGum8brbZwFJKZ7vhhDqF0/Bv8dVxEdSJgLlPYlGf+vhYILOuZFRsh5lvU5qB
         hqES/q9YPMRq5lz10vCUUXKywerQfX0u4U7ZvQA4NcSvhGyNIIkbg/0N992iZpnQlvqd
         sV+HcnEDu3DqFlAWdiENetCFlCa4Wo0MWeTouwy9+4OQGeWPfizwol+F7wxFPUw8lKD0
         ei1pagTXBsEAPgiPSTfEntwXKe8ghVsp/XanTikQsyaOY5o/fSovBWYopVYMMDusRaue
         OSQlPfC/ojrtrRhVie3LaDO2qNmXs0KVf5OVGGKnIEya4aGGdjzhwCiPg+yBknqTaLfj
         3tsg==
X-Forwarded-Encrypted: i=1; AJvYcCVCeru/NLfrCiLCfnDbdjCfG5f3GLNlfp7r9ReBNN37ESgSoOQJbWdx7ZMOrvDC6MNDMM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYdFtF+nwtm0dUTXyFqQjjqkQIBWYFWvMuInFN8sMyOE1wUUD0
	jKNsvg3uz++vosps8BroJwijM5lcPJ/x6OtaS1ZPmYgahP7KeoUyqXKI
X-Gm-Gg: AY/fxX7MF6m7PWUvTRspR8RAhyN2YMQUJE9BAjs5iZTzW8fRq7BN3oEWesmMIN6q+5v
	Cs7PmKyvaNYAhw/k52gJseCgSS5mp/uIDYGlWe+ePCjh+7Kfo7lBZtxuSGVcrsi+oYz2wqtOGcn
	HEdL9+RVNPPKSS7e7NT++0P0GfqJwHfgyQ7/caWDVh283Oe8w0BEwgL3AnYFL8u/EgwAmlcdC8F
	4wS2Yf7dsoNhU6SiJVc4KPXkNeGuAW+6q39IVohOeUq0Fl7slpXjhvgcYZAZJWeAciiu5yONxxF
	Smnxvn38H+oa+NWOPDP3DJiUV0Q+Fs0DqkccOiXLnJbeVx6xRejS82/emPLgkbwOWVgBk8tGphd
	k5QbLOX71vDuh1Igxjr4pl867hl+9QjdDiJx+kVJ9Ck12/63XRWFLz63mIyTowE+uB+A5V1dY1G
	pj0y59Axupnv/u4xtzv9jE
X-Google-Smtp-Source: AGHT+IGcUjLtmqammuUY5/5e9+ebHEbXFlq3HVVRDEEFsa5885mTL91FVn6Ih8ghp5wb7VofdeQMRA==
X-Received: by 2002:a05:6402:254c:b0:649:815e:3fac with SMTP id 4fb4d7f45d1cf-65097e5d180mr2289193a12.23.1767798389602;
        Wed, 07 Jan 2026 07:06:29 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4048sm5007292a12.2.2026.01.07.07.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:06:29 -0800 (PST)
Date: Wed, 7 Jan 2026 15:14:03 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+2c29addf92581b410079@syzkaller.appspotmail.com
Subject: Re: [PATCH] bpf: Reject BPF_MAP_TYPE_INSN_ARRAY in
 check_reg_const_str()
Message-ID: <aV54O3KWzy5GLuyj@mail.gmail.com>
References: <20260107021037.289644-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107021037.289644-1-kartikey406@gmail.com>

On 26/01/07 07:40AM, Deepanshu Kartikey wrote:
> BPF_MAP_TYPE_INSN_ARRAY maps store instruction pointers in their
> ips array, not string data. The map_direct_value_addr callback for
> this map type returns the address of the ips array, which is not
> suitable for use as a constant string argument.
> 
> When a BPF program passes a pointer to an insn_array map value as
> ARG_PTR_TO_CONST_STR (e.g., to bpf_snprintf), the verifier's
> null-termination check in check_reg_const_str() operates on the
> wrong memory region, and at runtime bpf_bprintf_prepare() can read
> out of bounds searching for a null terminator.
> 
> Reject BPF_MAP_TYPE_INSN_ARRAY in check_reg_const_str() since this
> map type is not designed to hold string data.
> 
> Reported-by: syzbot+2c29addf92581b410079@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2c29addf92581b410079
> Tested-by: syzbot+2c29addf92581b410079@syzkaller.appspotmail.com
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  kernel/bpf/verifier.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f0ca69f888fa..3135643d5695 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9609,6 +9609,11 @@ static int check_reg_const_str(struct bpf_verifier_env *env,
>  	if (reg->type != PTR_TO_MAP_VALUE)
>  		return -EINVAL;
>  
> +	if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY) {
> +		verbose(env, "R%d points to insn_array map which cannot be used as const string\n", regno);
> +		return -EACCES;
> +	}
> +
>  	if (!bpf_map_is_rdonly(map)) {
>  		verbose(env, "R%d does not point to a readonly map'\n", regno);
>  		return -EACCES;
> -- 
> 2.43.0
> 

Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>

