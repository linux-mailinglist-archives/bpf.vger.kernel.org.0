Return-Path: <bpf+bounces-72087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD14C06286
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 14:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D901C0071A
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 12:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEAA313527;
	Fri, 24 Oct 2025 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5CH/WnK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD81313523
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761307563; cv=none; b=tKhxIsxBVATQqZB72tfbNhitPYf8/oHjURIWd4D0DTZ5ueXavFIyNEABGS83Q1UEaiSxZkPr42oHjs/XRNG/IcjpKV9KassezQKhQUR8xuulHOLckAlUHCAWOVrbvSh2m2s3kifbgaaPftRnXPekZGx328HPMxEOpO9UjgRfCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761307563; c=relaxed/simple;
	bh=Fg6Pk2I4A5R8bs3eObdkYdM8yn28BraoXajxxhdB+Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=to07TprrzyINvNR18wxIdqE+cenGUGGj47WJ/wtsHYJ5LM3ftytJNrtNqx2ZE0bltoZy42kOMhPgCMWSilquTYWlMf2Bi2cu6teYeK7Fr+gHNjJ/bO++hNjDoacqZ27UQ9sGZfQT/yb7v9L8QEZ2/E8XvoMM9Qgu0jnwly9lUdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5CH/WnK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47112a73785so12894945e9.3
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 05:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761307560; x=1761912360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aZXHbrL2qazmoiG4kXCviJKbECM7eQb1f3rp2mwTHuM=;
        b=K5CH/WnK/+Vs7vz4ydOkkjogsEa0o78oRsoklSgv1JzBJR77acV/X/uur5FuROOuZT
         U5GUJoQ3TipDFlCVIG5m456CHx36S0uXn61fEVDzj5/o2jcQ6Z2tsYdL58DcVCumQauR
         +9Zma4b2eYKAB5+6LpLJ2aK2kSr7ltH2XgV3Aatt6nw/EzJEu4LbitSt+liBmsyV/mO7
         iM+L1XfcmgNemfCIaDf3lkEYNe+p3ifBfi9NRGeYO8lxFKgODSv10uvTqUMOhskOLkPB
         lmo9AZV4+tEpb3LVy62bCktqfOZpSdsewF8iJ9gkVPNaJuriMU+qTwmQJT3QLRUMGL64
         6sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761307560; x=1761912360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZXHbrL2qazmoiG4kXCviJKbECM7eQb1f3rp2mwTHuM=;
        b=Y/brR+3YaHssWyUs3DsoyG9WAW+TG8bW0JG+u8GtsOpc2LPNUdWwp1ce+p7PXdajk3
         n4Njuubwxg2EzDOpsVcYXKSfLjtDsxKKIdICsA6idsK6s9sEZzssJS0bKv1Qu/7u5VE1
         rCEqTEr6hy+XT1FvNixtJEp1b9xRxyLr1DCh8KFdxk+bjcuT+/1k7xQZz+FZVkm3+1uH
         veODUYoeiZc67j9ybCGEpQ2hMfXN69J4eFgeN7aTEYQkimm8t23nzgOJZ2nmycTJJi/B
         xp8jfMtQqOGI4kUvfVY0+KlKdT7rKFG99rwhRAcHPdA8RWSC5lH9IVJgU50jv4KJ5u1W
         brpg==
X-Gm-Message-State: AOJu0YzrZSFcoWf5jMYfSrtHinBz1W04T5LeNN0u+AfWGuPCmvAzzxvJ
	0u5fetbDxBTLDGd2n4B89oHblf7Q9P7KBQyDeT7uPXiWsST2WaNXl1rG
X-Gm-Gg: ASbGncsR4Voy0YdXpzpDRNieHFE8ljpeJejEs2jCN9Xr660gxa5E/hyj9G6smlNXdWh
	cnjdQGRH3UrMqMSysYBwDLxqMT8QRAWkEWnmMfURTWRphIQ2f/2OmWPR+jw4nhyiVCvnfWBtLra
	lrPMAFenbuN5+dVr/0rbDGiD6sFJ7kAINp/8bnjGJ8qRyOYKPLTER0d/O0Ktb+FiR4siX/HiIMl
	IH1JNWmsgQL6w0jBhv11SyGs/oN1tpDhqxa86PjyzbRaB7IB2UsmwX3L/UnUyjZoHCK0sn2AMi3
	gwNGe+Ku0/XVcFXF72dmp3tEN6mq9zmDqRh2hmRVxQpN/QQD7FOCV3NlBF76g69Yx6prIumKkM+
	7Rg2ygkPtCYW9jEm0ogA9805tU5+jQS62k8+on/kEk4BMEQM45ACtDPaXiZN09qGQ92jej8St3i
	BamMUXzZ4ZBNm9GnuR8MRyuNczhKs/KY0=
X-Google-Smtp-Source: AGHT+IHZT7tQaoXRLHeVkkt9dhITJCDdOXEFhmdEBJVymE4w11wIUrG7GC+Js2RsNpRCzTqmy1pMTw==
X-Received: by 2002:a05:600c:548a:b0:46f:b42e:edce with SMTP id 5b1f17b1804b1-47117925db7mr195960185e9.39.1761307559587;
        Fri, 24 Oct 2025 05:05:59 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cae92067sm92613795e9.4.2025.10.24.05.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 05:05:58 -0700 (PDT)
Date: Fri, 24 Oct 2025 12:12:40 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v6 bpf-next 04/17] bpf, x86: add new map type:
 instructions array
Message-ID: <aPttOC+/x//4YN4u@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
 <20251019202145.3944697-5-a.s.protopopov@gmail.com>
 <fb8a2c83a6041cb8b2285d91dba87b1c860e948c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb8a2c83a6041cb8b2285d91dba87b1c860e948c.camel@gmail.com>

On 25/10/21 04:26PM, Eduard Zingerman wrote:
> On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> 
> [...]
> 
> > The functionality provided by this patch will be extended in consequent
> > patches to implement BPF Static Keys, indirect jumps, and indirect calls.
> > 
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> 
> Aside from what Alexei pointed out, I only have a nit regarding jitted_ip.
> 
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]
> 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index e53cda0aabb6..363355628d2e 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3789,4 +3789,40 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
> >  			   const char **linep, int *nump);
> 
> [...]
> 
> > +/*
> > + * The struct bpf_insn_ptr structure describes a pointer to a
> > + * particular instruction in a loaded BPF program. Initially
> > + * it is initialised from userspace via user_value.xlated_off.
> > + * During the program verification all other fields are populated
> > + * accordingly:
> > + *
> > + *   jitted_ip:       address of the instruction in the jitted image
> > + *   user_value:      user-visible original, xlated, and jitted offsets
> > + */
> > +struct bpf_insn_ptr {
> > +	void *jitted_ip;
> 
> I think this one is no longer used anywhere.
> I see it set in bpf_prog_update_insn_ptr() but it is not read anywhere.

Nice, thanks :)

> > +	struct bpf_insn_array_value user_value;
> > +};
> > +
> 
> [...]
> 
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 6829936d33f5..805d441363cd 100644
> 
> [...]
> 
> > @@ -7645,4 +7646,24 @@ enum bpf_kfunc_flags {
> >  	BPF_F_PAD_ZEROS = (1ULL << 0),
> >  };
> >  
> > +/*
> > + * Values of a BPF_MAP_TYPE_INSN_ARRAY entry must be of this type.
> > + *
> > + * Before the map is used the orig_off field should point to an
> > + * instruction inside the program being loaded. The other fields
> > + * must be set to 0.
> > + *
> > + * After the program is loaded, the xlated_off will be adjusted
> > + * by the verifier to point to the index of the original instruction
> > + * in the xlated program. If the instruction is deleted, it will
> > + * be set to (u32)-1. The jitted_off will be set to the corresponding
> > + * offset in the jitted image of the program.
> > + */
> > +struct bpf_insn_array_value {
> > +	__u32 orig_off;
> > +	__u32 xlated_off;
> > +	__u32 jitted_off;
> > +	__u32 :32;
> 
> This :u32, is it for alignment or for future extensibility?

Both. We maybe might have some flags added in future for different use cases...

> > +
> 
> [...]
> 
> > diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> > new file mode 100644
> 
> [...]
> 
> > @@ -0,0 +1,288 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2025 Isovalent */
> > +
> > +#include <linux/bpf.h>
> > +
> > +#define MAX_INSN_ARRAY_ENTRIES 256
> > +
> > +struct bpf_insn_array {
> > +	struct bpf_map map;
> > +	atomic_t used;
> > +	long *ips;
> > +	DECLARE_FLEX_ARRAY(struct bpf_insn_ptr, ptrs);
> > +};
> 
> [...]
> 
> > +static inline u32 insn_array_alloc_size(u32 max_entries)
> > +{
> > +	const u32 base_size = sizeof(struct bpf_insn_array);
> > +	const u32 entry_size = sizeof(struct bpf_insn_ptr);
> > +
> > +	return base_size + entry_size * max_entries;
> > +}
> 
> Since this is doing a flexible array thing anyway, maybe also include
> size for `ips` here? And in insn_array_alloc() point it at the tail
> area.

Yes, great idea.

> [...]

