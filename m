Return-Path: <bpf+bounces-61112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE04AE0D22
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 20:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190C14A2FE8
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 18:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DF012FF69;
	Thu, 19 Jun 2025 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmBUSikP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BAA30E84E
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750358987; cv=none; b=YfbrCDwk9dh8Xm2DWAV+1FdPOHFycjgGoBP4vwuwNp7rqNBn5UvC8WXONL1StULjRzl/FqXo0Wv+lo2WoAxvpMo6nqPo5IYpyFLsitqdFxdQUE7uzvxN9JT3pNVsR4Lp2PALZ395YGFHVE9RKaYbCUU11TTQcG6YsG/sP7zemPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750358987; c=relaxed/simple;
	bh=aoqATHycuYPNbBna4eCZ91RqNcwIMordfcTwCFjipcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k49Yo2HRkVjJruz1vic4V8jf1GDfiCIq1kUQ1xLQXEyXW9InhziCidu8kjZ7gQlm/M8FhVgOxYe2Eh/h8+tf+FMOtZ+MDJuHPKlwGFJzwk3hNvkFs+FoZD2w5Z95S/kDpybYJU5iwx99pFgQRyJ7EyX5hqM5iAtSGepsJ0avrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmBUSikP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a5123c1533so553168f8f.2
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 11:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750358984; x=1750963784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+U71d4MSMfYJSMgHAEJLrFKT34pybEDnK0zGfnXqezw=;
        b=PmBUSikPhULmJAIvRirIW2Ywv23vtGqXDYgjRbOgQ8TLrKvMqz7B09ZCsg7nTTHpMc
         flzLRBKyb26NC0YvnGmxzuu0xZrSBkUJd/DUQr6zlwpcGjsurXwlPCQIrmE61J76eWVJ
         4TabwMkUdSV7mV5sHw3Dt7EHQPlcyFgyR2KQTHuEoWo9fgQKf1OP3iHI2XW4/E5Nc1iT
         usGJTjpP6lZTgdAnu4I02rz3yFzlOINFcY7INbCjLd3ByYZuYjF6YPmp786tsw2/iWCn
         NbqLeJShT2YW7b9aEd9kKm19Acft0VDQRZi1BHyK1Q/OoEiK/KB+QQqS81DC/mfMzIHn
         5CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750358984; x=1750963784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+U71d4MSMfYJSMgHAEJLrFKT34pybEDnK0zGfnXqezw=;
        b=v1nu1v0XLi56YxJRRZIqUcxzwP4cUuD1O1d55B2gbF0cMESJD7S+Jy42hR8JYRvsbV
         fsAqLayjtsLvvzFhxfc4+PZYYJ7oOstnnmiDEiXiGol33ag9uPUW4lSrH37nCukzhPk2
         8tW/oWYsPC3p5Xhf5zcNid+4OHJTE6QxEEmPawzGBFvtbHx7zPD8dzJHnpOJdjPDPgqM
         bsFyiWlB7exdq9711kk7UgG7pwgH+YhOqTFIakISaFfPe58EuHqIPMR20h7IxRMgZ8QU
         wF1Fo+OILohAnIpSGLaOk89xPbx72QXpZ+1PBtA8NUNbtX/e0QUyFRRRJw64BcPL+mhH
         v2fw==
X-Gm-Message-State: AOJu0YyfCjlxplGFPgAxgdfLGXHINlNkbM1mAyhNYtEUcSUHWn8r/SlS
	YGsTbZMi0EouD37XHGZSTPOzI/o8maFGmdudp2wtxJqX7WQ7xDy9z2RE
X-Gm-Gg: ASbGncvvCRazhKU1l2St5mulP37o32udYIY+ieyX1SwYIElhGLMOmn20P5JXDvW+0fu
	rShwJipAiXhMfkPojpCuZU0xmD+aHGURtDmaaiC3ElRtVgZD+5CHrPkPBUByx0IhQTaxTS3sWhI
	XmeIAGOwxvB4RskOFUgIJho0DOAmOxygYbYdqp+s2T9hQPfGv0vTIpsW87IjR18lH5RUAH3i33t
	bUPEokWNYFVJReORdNWNyGnufV7+JCRi1RCm6QI/9JtgToMyU98x1Pt/J200yFhrtH+VpoZuviO
	dqIkyxqxECwzCAraf9wM/CpCtByYteaQlNZhQyVssZcarkYOqMeUPTKNUxXB5VIx1AHNfxx6QQ=
	=
X-Google-Smtp-Source: AGHT+IFnmyf++AzoYGXFJU6V7aNpzMbQeF1xczSphJb+3yBhTnTJv0AShdHD4VPURVX2X40197j2Vg==
X-Received: by 2002:a05:6000:25f2:b0:3a4:f024:6717 with SMTP id ffacd0b85a97d-3a6d12e652bmr108412f8f.53.1750358983945;
        Thu, 19 Jun 2025 11:49:43 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c0f1sm108857f8f.53.2025.06.19.11.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 11:49:43 -0700 (PDT)
Date: Thu, 19 Jun 2025 18:55:23 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [RFC bpf-next 2/9] bpf, x86: add new map type: instructions set
Message-ID: <aFRdGxqIfB8SO4Xt@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-3-a.s.protopopov@gmail.com>
 <7edb47e73baa46705119a23c6bf4af26517a640f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7edb47e73baa46705119a23c6bf4af26517a640f.camel@gmail.com>

On 25/06/17 05:57PM, Eduard Zingerman wrote:
> On Sun, 2025-06-15 at 08:59 +0000, Anton Protopopov wrote:
> 
> Meta: "instruction set" is a super confusing name, at-least for me the
>       first thought is about actual set of instructions supported by
>       some h/w. instruction_info? instruction_offset? just
>       "iset"/"ioffset"?
> 
> [...]
> 
> > On map creation/initialization, before loading the program, each
> > element of the map should be initialized to point to an instruction
> > offset within the program. Before the program load such maps should
> > be made frozen. After the program verification xlated and jitted
> > offsets can be read via the bpf(2) syscall.
> 
> I think such maps would be a bit more ergonomic it original
> instruction index would be saved as well, e.g:
> 
>   (original_offset, xlated_offset, jitted_offset)
> 
> Otherwise user would have to recover original offset from some
> external mapping. This information is stored in orig_xlated_off
> anyway.

I do agree that this might be convenient to have the original_offset.
But the only use case I see here is "BPF debuggers". Such programs
will be able to build this mapping themselves.

I would add it as is, the only obstacle I see now is map key size.
Now from BPF point of view and from userspace point of view it is 8.
Userspace sees (u32 xlated, u32 jitted), and BPF sees *ip. I haven't
looked at how much work it is to have different key sizes for
userspace and BPF, and if this breaks things too much.

> [...]
> 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 15672cb926fc..923c38f212dc 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1615,6 +1615,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
> 
> [...]
> 
> > @@ -2642,6 +2645,14 @@ st:			if (is_imm8(insn->off))
> >  				return -EFAULT;
> >  			}
> >  			memcpy(rw_image + proglen, temp, ilen);
> > +
> > +			/*
> > +			 * Instruction sets need to know how xlated code
> > +			 * maps to jited code
> > +			 */
> > +			abs_xlated_off = bpf_prog->aux->subprog_start + i - 1 - adjust_off;
> 
> Nit: `adjust_off` is a bit hard to follow, maybe move the following:
> 
> 	abs_xlated_off = bpf_prog->aux->subprog_start + i - 1;
> 
>      to the beginning of the loop?

Thank, this isn't transparent indeed. I will move things to be more
readable.

> 
> > +			bpf_prog_update_insn_ptr(bpf_prog, abs_xlated_off, proglen, ilen,
> > +						 jmp_offset, image + proglen);
> 
> Nit: initialize `jmp_offset` at each loop iteration to 0?
>      otherwise it would denote jump offset of the last processed
>      jump instruction for all following non-jump instructions.

Yes, thanks.

> >  		}
> >  		proglen += ilen;
> >  		addrs[i] = proglen;
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 8189f49e43d6..008bcd44c60e 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3596,4 +3596,25 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
> >  	return prog->aux->func_idx != 0;
> >  }
> >
> > +int bpf_insn_set_init(struct bpf_map *map, const struct bpf_prog *prog);
> > +int bpf_insn_set_ready(struct bpf_map *map);
> > +void bpf_insn_set_release(struct bpf_map *map);
> > +void bpf_insn_set_adjust(struct bpf_map *map, u32 off, u32 len);
> > +void bpf_insn_set_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
> > +
> > +struct bpf_insn_ptr {
> 
> Could you please add comments describing each field?
> E.g.: "address of the instruction in the jitted image",
>       "for jump instructions, the relative offset of the jump target",
>       "index of the original instruction",
>       "original value of the corresponding bpf_insn_set_value.xlated_off".

Sure, will add.

(Also, not to repeat "yes" many times, all your comments below look
to make sense, will address them. Thanks.)

> > +	void *jitted_ip;
> > +	u32 jitted_len;
> > +	int jitted_jump_offset;
> > +	struct bpf_insn_set_value user_value; /* userspace-visible value */
> > +	u32 orig_xlated_off;
> > +};
> 
> [...]
> 
> > diff --git a/kernel/bpf/bpf_insn_set.c b/kernel/bpf/bpf_insn_set.c
> > new file mode 100644
> 
> [...]
> 
> > +static int insn_set_check_btf(const struct bpf_map *map,
> > +			      const struct btf *btf,
> > +			      const struct btf_type *key_type,
> > +			      const struct btf_type *value_type)
> > +{
> > +	u32 int_data;
> > +
> > +	if (BTF_INFO_KIND(key_type->info) != BTF_KIND_INT)
> > +		return -EINVAL;
> > +
> > +	if (BTF_INFO_KIND(value_type->info) != BTF_KIND_INT)
> > +		return -EINVAL;
> > +
> > +	int_data = *(u32 *)(key_type + 1);
> 
> Nit: use btf_type_int() accessor?
> 
> > +	if (BTF_INT_BITS(int_data) != 32 || BTF_INT_OFFSET(int_data))
> > +		return -EINVAL;
> > +
> > +	int_data = *(u32 *)(value_type + 1);
> > +	if (BTF_INT_BITS(int_data) != 32 || BTF_INT_OFFSET(int_data))
> 
> Should this check for `BTF_INT_BITS(int_data) != 64`?
> 
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> 
> [...]
> 
> > +int bpf_insn_set_init(struct bpf_map *map, const struct bpf_prog *prog)
> > +{
> > +	struct bpf_insn_set *insn_set = cast_insn_set(map);
> > +	int i;
> > +
> > +	if (!is_frozen(map))
> > +		return -EINVAL;
> > +
> > +	if (!valid_offsets(insn_set, prog))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * There can be only one program using the map
> > +	 */
> > +	mutex_lock(&insn_set->state_mutex);
> > +	if (insn_set->state != INSN_SET_STATE_FREE) {
> > +		mutex_unlock(&insn_set->state_mutex);
> > +		return -EBUSY;
> > +	}
> > +	insn_set->state = INSN_SET_STATE_INIT;
> > +	mutex_unlock(&insn_set->state_mutex);
> > +
> > +	/*
> > +	 * Reset all the map indexes to the original values.  This is needed,
> > +	 * e.g., when a replay of verification with different log level should
> > +	 * be performed.
> > +	 */
> > +	for (i = 0; i < map->max_entries; i++)
> > +		insn_set->ptrs[i].user_value.xlated_off = insn_set->ptrs[i].orig_xlated_off;
> > +
> > +	return 0;
> > +}
> > +
> > +int bpf_insn_set_ready(struct bpf_map *map)
> 
> What is the reasoning for not needing to take the mutex here and in
> the bpf_insn_set_release?
> 
> > +{
> > +	struct bpf_insn_set *insn_set = cast_insn_set(map);
> > +	int i;
> > +
> > +	for (i = 0; i < map->max_entries; i++) {
> > +		if (insn_set->ptrs[i].user_value.xlated_off == INSN_DELETED)
> > +			continue;
> > +		if (!insn_set->ips[i])
> > +			return -EFAULT;
> > +	}
> > +
> > +	insn_set->state = INSN_SET_STATE_READY;
> > +	return 0;
> > +}
> > +
> > +void bpf_insn_set_release(struct bpf_map *map)
> > +{
> > +	struct bpf_insn_set *insn_set = cast_insn_set(map);
> > +
> > +	insn_set->state = INSN_SET_STATE_FREE;
> > +}
> 
> [...]
> 
> (... I'll continue reading through patch-set a bit later ...)

