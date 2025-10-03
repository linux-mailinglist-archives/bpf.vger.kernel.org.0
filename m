Return-Path: <bpf+bounces-70282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4FEBB62CC
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 09:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127751AE09D3
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 07:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973C5246BB8;
	Fri,  3 Oct 2025 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXUaE4Vn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3783023CE
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759476790; cv=none; b=LY18uKGX0uGMlxw+IZ9lAHEV0JafMOllZSjYDlctMs6uSC73WstBRhbuIuTPy4TWjpAm1T5IP//EJnjEq8S6jSHgAWzWhKYHR8ZiyUErJO0Wc+pqtmHFzcl5Fy6TId8AIwvcHfAH4WB9teMl+d+C7yuRXlmqNUpsEEh0bb8DzY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759476790; c=relaxed/simple;
	bh=A1zAW1EUWknKEYem/Sy+UCvbVmEfhZTRUfTq/usFOIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLZHkgmhJFc9auNJhvlAGrSIcyjn8eqMcOI29cEBB42IkgGVTsvJXgRxp1K9i9EvYGMSFR+g7SkxLbm1/z7nTfkKPpM6tUI85l5kdOmJS/Q0nz2TX+u2lKuapgZo92+s9YhK99VzHpZWP2PhedoDwPTiOwsYG7DK05UMLgxRly8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXUaE4Vn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so1210599f8f.3
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 00:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759476786; x=1760081586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ot4Lo3yI3HyW1zb6Gz4s1he6coORp2U8lKWSNSqeVuA=;
        b=fXUaE4VnFcwVtsScpBvoYePVuRQierOqaDLi/SoyN21r/Zxa/bsAq7/9YsE+uhtBkS
         rfm/dFyG9cygFjpevh/0PdLbcz74ogCyk/hSeXoxDmU850Zwe5JHE2Qi+R0Iam+UL97b
         6W2gtEeGN+g3ZPUjx0t/nuxvSKmrMo4pt7kINyvPaLO7Q1zkq2yhnCOBOADdM1GYBHIE
         TxQHEqCUppDh+drRgN4aThdKmzHVpUoEKpf8+vXQks6lWGGVdCxnrYaIlV56ahQUJ4LT
         69k/DluknpUfmvIgMtQouFXFyP3S7rIPS2KdAEOs5TdzM0MUgFG9E+hVkmx9Ex3xSDuk
         mTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759476786; x=1760081586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ot4Lo3yI3HyW1zb6Gz4s1he6coORp2U8lKWSNSqeVuA=;
        b=NYiKHh4v3WGGqPN7AVgJFiE3kO37vxWdvV2XZrq1pFEKiqpqcJzTJXQWT9jHAV5MJV
         ZA1uHF0JkLlE4I2jrherAAATO19zc+YsM7NsEFOUzZpjsOZauty3762YAcc0ytPzyMMg
         SZ3rlgl6YB+pbx4wE4FyyhgHcxmaG1+Hf6WFz6WBP59HEpgTJvxNfwVNL2An2u4Du/3D
         SbSRzcCOVg5Kj5LMZhHe06VDFxqWty97uiu4Uypcqok0xWHh0L69FsDf/IrSdGVkZlCQ
         h6bJK20MGInNvIqyJOzUlCk8VHGclNCAis9A26HD9ywhXMMEEW/RBM4nVRw/OO50J9Hc
         QfNA==
X-Gm-Message-State: AOJu0Yzv7ePo0JGSdjvX0kygtRWzaI6j+zTVHGYM7VcZDlzYWk7oYxnq
	uxiwC8C3xKRP680eIyCOiWjQ4uTFAQiLAGb7lq4jq/UZft23g/KcN1dVqL9ZkA==
X-Gm-Gg: ASbGncuqFBGVgWwBr68t66k8HvBgN8C22SytoWQgxoR9EpBGnXFQp2yhB6js6+LSazG
	qxayMmyG9Y4nF3mfE/wiCldysTjpllNAVhqd8FEKSVUwLFHj4e162djP/eVwNdyDkv12pwpj0bJ
	/M378fbERndOF4wmjMLpglYk0WtfTW1rqJZMgf5U1uPM4PhKQ9o3avCep0Q0+Gmrgo2fmdFI46v
	+NI9lnNijIS44AEPv/NA6UYj6gE/nu94QvJ1VeN0uoV5pWRSY85LDs6JWhK4H8KoKPeRzs0H0UQ
	NBJkyH9VWAwUemI/i5IZKROcnGCnt71ov50vuwAH7zoDKU5rtetQGl2A3WDR5phLd+ybW/H51sE
	OJEo8uNfEcJp61IsBm/22ox36RJAaQ1oXFFzFBWE75YcY8I2GV2YUIYa2K016d1eHYis=
X-Google-Smtp-Source: AGHT+IH+Q4yiIWxE2SNq6mj8i98nycIMD1ppXXY99y1672QW1iiX7GD0b+Ns7TK1cO24/AliZA1AiA==
X-Received: by 2002:a05:6000:40da:b0:3e0:c28a:abbb with SMTP id ffacd0b85a97d-42567158fccmr1281526f8f.13.1759476786087;
        Fri, 03 Oct 2025 00:33:06 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e97f0sm6723747f8f.27.2025.10.03.00.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 00:33:05 -0700 (PDT)
Date: Fri, 3 Oct 2025 07:39:24 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v5 bpf-next 04/15] bpf, x86: add new map type:
 instructions array
Message-ID: <aN99rP7iS2O0kJMN@mail.gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
 <20250930125111.1269861-5-a.s.protopopov@gmail.com>
 <7f2e28c4cee292fb6eb5785830d5e572b7bd59c2.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f2e28c4cee292fb6eb5785830d5e572b7bd59c2.camel@gmail.com>

On 25/10/02 05:50PM, Eduard Zingerman wrote:
> On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
> 
> Overall I think this patch is fine.
> We discussed this some time ago, but I can't find the previous discussion:
> would it be possible to make this map element a tuple of three elements
> (orig_off, xlated_off, jitted_off)?
> Visible to user as well.

See https://lore.kernel.org/bpf/8ff2059d38afbd49eccb4bb3fd5ba741fefc5b57.camel@gmail.com/

In short, this will make the map element to be of different size
from userspace and kernel (BPF) perspective.

(Userspace can build the orig_off -> xlated_off mapping easily, if needed,
just keep a copy of the map before the load.)

> [...]
> 
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 4c497e839526..cc06e6d57faa 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> 
> [...]
> 
> > @@ -7645,4 +7646,14 @@ enum bpf_kfunc_flags {
> >  	BPF_F_PAD_ZEROS = (1ULL << 0),
> >  };
> >  
> > +/*
> > + * Values of a BPF_MAP_TYPE_INSN_ARRAY entry must be of this type.
> > + * On updates jitted_off must be equal to 0.
> > + */
> > +struct bpf_insn_array_value {
> > +	__u32 jitted_off;
> > +	__u32 xlated_off;
> > +};
> 
> Could you please expand the comment a bit?  Describe the meaning of
> the fields both before and after program load.

Sure.

> > +
> > +
> >  #endif /* _UAPI__LINUX_BPF_H__ */
> 
> [...]
> 
> > @@ -0,0 +1,285 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2025 Isovalent */
> > +
> > +#include <linux/bpf.h>
> > +
> > +#define MAX_INSN_ARRAY_ENTRIES 256
> 
> Hm, did not notice this before.  We probably need an option limiting
> max number of jump table alternatives.
> 
> Yonghong, wdyt?

This one comes from the fact I've mentioned in the other place: need
to optimize the lookup from jit (not it is brute force). Then this
limitation will go away.

But also curious, what LLVM thinks about this. Will it,
theoretically, create say 65K tables or so?

> [...]
> 
> > +void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len)
> > +{
> > +	struct bpf_insn_array *insn_array = cast_insn_array(map);
> > +	int i;
> > +
> > +	for (i = 0; i < map->max_entries; i++) {
> > +		if (insn_array->ptrs[i].user_value.xlated_off < off)
> > +			continue;
> > +		if (insn_array->ptrs[i].user_value.xlated_off == INSN_DELETED)
> > +			continue;
> > +		if (insn_array->ptrs[i].user_value.xlated_off >= off &&
>                                                               ^^^^^^
> Nit:                                       this condition is redundant

True, thanks, will remove it.

> 
> > +		    insn_array->ptrs[i].user_value.xlated_off < off + len)
> > +			insn_array->ptrs[i].user_value.xlated_off = INSN_DELETED;
> > +		else
> > +			insn_array->ptrs[i].user_value.xlated_off -= len;
> > +	}
> > +}
> > +
> > +void bpf_prog_update_insn_ptr(struct bpf_prog *prog,
> > +			      u32 xlated_off,
> > +			      u32 jitted_off,
> > +			      void *jitted_ip)
> > +{
> > +	struct bpf_insn_array *insn_array;
> > +	struct bpf_map *map;
> > +	int i, j;
> > +
> > +	for (i = 0; i < prog->aux->used_map_cnt; i++) {
> > +		map = prog->aux->used_maps[i];
> > +		if (!is_insn_array(map))
> > +			continue;
> > +
> > +		insn_array = cast_insn_array(map);
> > +		for (j = 0; j < map->max_entries; j++) {
> > +			if (insn_array->ptrs[j].user_value.xlated_off == xlated_off) {
> 
> If this would check for `insn_array->ptrs[j].orig_xlated_off == xlated_off`
> there would be no need in `user_value.xlated_off = orig_xlated_off`
> in the `bpf_insn_array_init()`, right?

The copy of the original offset is kept inside the map for the
following reason.  When the map is first loaded, it is frozen. Thus
user can't update it anymore.  During load some of xlated_off are
changed (together with program code). If the program load fails, it
is common to reload it with a log buffer. If map was changed, it now
will point to incorrect instructions. So in this case the map should
be seen as the original one, and the orig_xlated_off is used to reset
it.

> > +				insn_array->ips[j] = (long)jitted_ip;
> > +				insn_array->ptrs[j].jitted_ip = jitted_ip;
> > +				insn_array->ptrs[j].user_value.jitted_off = jitted_off;
> > +			}
> > +		}
> > +	}
> > +}
> 
> [...]

