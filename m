Return-Path: <bpf+bounces-66554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A99E9B36EEA
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 17:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BF21BC25D2
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 15:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B83369328;
	Tue, 26 Aug 2025 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hyw4JxfZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D70C30FC31
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223195; cv=none; b=Mv9w8HTXcmJ/VDgkzCxoX8JDKGkLWVuxbJNKAPtrcE7Sq76PqnZ8sPE6Ax4edBL3EPtSBUbaK3L/kAND8JuXOV+OMB38e2f3n0d51at2OsE0PYLKCwnALX3ICA6l94usL2qzfUE9Ofm2yP/Q7ik/LBrzWK42/PRjcWQvK1THiGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223195; c=relaxed/simple;
	bh=uvcjg7oKWcwVNbvZVCrnktFRjoyOmXeKIF0X29soOzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndFX5c/cCj2iJ2wGy2xW5TD4n+SRh7esonhk+nqaLJ1umsHMqlptjQzdI1kKQpoAcSlzcN8C9oGsL8XiU4LQXJRsPVA2NDTcZKTLOMwbfviaioHyWpOu17Fjp8XR9WrvkHrOeOh2JRcP+SzhoiBHfz/BmjAii/4YuV8BFvv8r8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hyw4JxfZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c854b6459fso1810744f8f.3
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 08:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756223191; x=1756827991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5l1kjBq06/RL80snbLwvltlBf6aptCHGB2zbuDkWZwk=;
        b=Hyw4JxfZt4zpC96MqutugoM+zE2Za18gv/3bcw0IxgIF4EpnapSVBlfseqrurGrX0l
         sytBzBKWd4ti4tHZUUqIGGSSqUaBFAPSrspFPyTzFNh31pTCpsgn3rxmXZ3VmBa7CtoZ
         obJ+xfZtSiZd9OfaNJpZ+CGKOd8IzWDhkTxipzz74G/6ujofx8UNf0DbLqN/coaUbtF+
         ScjGXCD6Ff78TRZFbf8sPsTBXVUKUG2PsZDEraJXSDZitQDDwdHp2NsSM0I3ktnY8mXw
         82i2gAsnsmOVcBa+EQRSJ87oNhepYW6Q5AdltYdCRBSl+AiTpicxLkLAlj+2qURGNxJh
         kn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756223191; x=1756827991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5l1kjBq06/RL80snbLwvltlBf6aptCHGB2zbuDkWZwk=;
        b=D6u+e34hYGYtcW+jeNPJ7ioa+w6g0nKecRmkiDfkOXKt/VrHp6/2Snigcv7BlulJEI
         Ghzh0eFwJr1zmN105UL04OGomfn6CPejF/zcwz5o3K/HaBGqm1ARGFx0DVcWx1yvhaD0
         44k05Zq7WdwD3lh1r852TBpco0fFXA0RJJ0zD9EdDJBKGIftnBCuYZIb+1zMK4xxX3GW
         Q3f9VMQa7KtiuZhhIRk9y1ougWt9p7sLX+/oKylps7+wP7NPw5Jv6BbJr2MsDAKf1iY2
         fbsxMoig0OwVhiRLLKfydEBZlx1ND11OmzunUEu/kHcAhSYZ4zey+eAzoRze/e2M+SCD
         MzXw==
X-Gm-Message-State: AOJu0YxhKzfiY91H2Gm6Up+cwuWDBwVUYvOwSRFrUtkzJO0zCQNKwPCK
	+SKH93GqAltb4buMzmDvVafIJA+oGkdYK5eQot2WB+61qqSzvvTRkBeo
X-Gm-Gg: ASbGncs65/AWAVlrBTjz5VsZclcLm3eKJzDUIeoD/JwJVoEKon8kGmPDfgKOXr1ovL/
	vFXh6XZUqLapJ1+guZg4/vZeFnAAlZhVhxzRYXUGeFksWK+q+nUqOrun9eO4T5I89wVy7y2+9w5
	4+PcxTKWe8ygfXhpyFvd3/MACZMe+1avr/92d7qjb25/BxgqMZlqIZOi13NkVgV5qmPFpIA7FM9
	iKV8KbF3hVI6wtRY8ogqhcP8fkgnHXvcPAv6lIXpkkk1dgFnRyZb55M3YjBihjMmdK0gS7tOCy/
	NOHd+JxFZkckgPEqKau/bkMFN4JnXM1SrgJrZWageBK1CUSJXfmJWnFKfgtT8Ash7jpDkcjH0Rm
	t2Gu4kIchqKM8l6A+JoUqDNmaeSPeCZCv5A==
X-Google-Smtp-Source: AGHT+IEl+VN5Sqq0SHRdQJTK+h1gNZkVdxN2tHE/yoGfAdzRBGTHwaOQ+vNuGWUKXGFXUS4GOmsdpg==
X-Received: by 2002:a5d:5d0d:0:b0:3c7:9150:509e with SMTP id ffacd0b85a97d-3c791505b0emr8263830f8f.49.1756223191329;
        Tue, 26 Aug 2025 08:46:31 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57589c42sm155323345e9.17.2025.08.26.08.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:46:30 -0700 (PDT)
Date: Tue, 26 Aug 2025 15:52:36 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 03/11] bpf, x86: add new map type:
 instructions array
Message-ID: <aK3YRDJyZOYU9LTW@mail.gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
 <20250816180631.952085-4-a.s.protopopov@gmail.com>
 <8443ca8f17708fa22a3f3b60018513735b6dff5b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8443ca8f17708fa22a3f3b60018513735b6dff5b.camel@gmail.com>

On 25/08/25 02:05PM, Eduard Zingerman wrote:
> On Sat, 2025-08-16 at 18:06 +0000, Anton Protopopov wrote:
> 
> [...]
> 
> > --- /dev/null
> > +++ b/kernel/bpf/bpf_insn_array.c
> 
> [...]
> 
> > +int bpf_insn_array_ready(struct bpf_map *map)
> > +{
> > +	struct bpf_insn_array *insn_array = cast_insn_array(map);
> > +	guard(mutex)(&insn_array->state_mutex);
> > +	int i;
> > +
> > +	for (i = 0; i < map->max_entries; i++) {
> > +		if (insn_array->ptrs[i].user_value.xlated_off == INSN_DELETED)
> > +			continue;
> > +		if (!insn_array->ips[i]) {
> > +			/*
> > +			 * Set the map free on failure; the program owning it
> > +			 * might be re-loaded with different log level
> > +			 */
> > +			insn_array->state = INSN_ARRAY_STATE_FREE;
> > +			return -EFAULT;
> 
> This shouldn't happen, right?
> If so, maybe use verifier_bug here with some description?
> (and move bpf_insn_array_ready() call to verifier.c:bpf_check(),
>  so that the log pointer is available).

Shouldn't happen. But, unfortunately, only after
bpf_prog_select_runtime() which is executed after bpf_check(). Might
be nice to allow jit/bpf_prog_select_runtime to use the verifier
environment.

(Not 100% similar, but related to blinding part of this series:
blinding is happening as the very first step of every jit (initially
was implemented for x86, and then copy/pasted to everywhere else).
Might be nice to move it to be one of the last stages of verifier,
then code is shared and env is available as well. For this series I
had to add a bit of custom code to support instruction arrays at this
blinding stage.)

> > +		}
> > +	}
> > +
> > +	insn_array->state = INSN_ARRAY_STATE_READY;
> > +	return 0;
> > +}
> 
> [...]

