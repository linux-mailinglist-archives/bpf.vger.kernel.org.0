Return-Path: <bpf+bounces-58672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01384ABFD2F
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 21:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186921BC3173
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 19:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C653928F947;
	Wed, 21 May 2025 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7xVyFda"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0427E22CBC6;
	Wed, 21 May 2025 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747854827; cv=none; b=KpSLH1z5rAkMxuyc7kRPXTI2l6Xo7u4m9nEwfzWJgq67NyjaCO1guEXfZvRoxcx+6dsT2wZuHLshBMlDNYrb1CARHVEyXSN33Gtt7HIdI+K8xBTbFqgWRFBG56u0QC9oGGLOShJhDfJrdZ6Q7TqyvpwrT4iC5kepAXKiB6yUX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747854827; c=relaxed/simple;
	bh=h8z4yhhXuRBFOc9JsFLEsXQ/WRuBjiDDDT1yt8/OPN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AP24lE0deffIukMT6S7yg0rr3GTzFPIM3pW807C3CS7Z2sHWUH8FnDxE/s8ZDasU/5J764Ly2KB2qC/c2GIzmC48aNfxVyyTyRZ1qy4KsdyU2R/xkH9SzDO2CVzlOq3iK24Ezvme8gB81m01vIKSA9hSZAjXAjbZnCY02xLEy88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7xVyFda; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742c9907967so3940463b3a.1;
        Wed, 21 May 2025 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747854825; x=1748459625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kouGhQ38YMvNxE0ZyAw9NOKjlr5ySTT7TYWCAnm7A2A=;
        b=N7xVyFdaK+KOpvEKxb2qlgNrb1stPVsNJ6a5RWdbJXH3lPdVowmm2lRXvAuDm7pL1u
         PjiFSiWA40Qv9EVun7oyCnywBeGAlDV4P/veyQWPl6JIosEydDOQB01h+RRwYK82MDPj
         rAaff2TEos42U6Pen/FIOsZOyQYQtNSoh+DUw18vU8t4UyLXQZEg/hUNhFbggcyEjJYL
         LrUMI7171o/Hd9z+3q+nqKRSJ1J8s5ShLGToRXQul9aIajQjt4VaaJ6ppzxlu4lyU6qv
         K0J76gFE8vuVFD2Ex3UaBl6MG85G5vCWis6AkYAX1Vn93gjhqs0iFjxbJCr4t2pgdKyE
         /6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747854825; x=1748459625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kouGhQ38YMvNxE0ZyAw9NOKjlr5ySTT7TYWCAnm7A2A=;
        b=aqTNNA8qHq8Mo4x56FfQuDn3rtLUvmEuDoFuu11OeEocBRBPVa2h6hFMNDdYhtCEbO
         H59chQQo1wi82aPvJdfow4HsdRCaWu4D8kJgf4TYvzD+m8fHvYK0WtvThbgbdL0oZfYx
         8IQOzWynQeDdx32tX8XV0bB5Ti6T2CgS66F3hTDYair7pnK1PVPkZOrP1TN/VIXxKeG+
         aRLNKDzA5XfCh9uTlS02HtgTZmMVb5uDWk87Z5+NVqU5GquE+B9vlg5oxpl5hCENKM6K
         4GJ2ITc4HGudWLgvXXu/gQEXYoi6HUCEVPlnDEtRRD5Owhs+/pH71Y0HdspFeWkoVoSh
         v7vg==
X-Forwarded-Encrypted: i=1; AJvYcCVl3dlVnIQZBeqPRGS/QwEQTVJXRHHAbGk1VVTp8Drp0m7GtR4vmu+jgouedG8Mm4VqKyU=@vger.kernel.org, AJvYcCVn6Tpv5QtZgE6R1VS5kqAbzw31j4uKTq4JoLU67LJGKFzTN3gzGNrRxi5NUKU+V69gqRYmOPruEflNtef/@vger.kernel.org
X-Gm-Message-State: AOJu0YxJlIuvfP0Hbi6RDBGGm5M5+4e4DU+enkzu25QZCuYI2Mnny4k0
	DBpSlsoONeDiLXdzhJiWxvuvcAo5QA8BJsVjIcyBY5/R2zCEuw1tqDVb
X-Gm-Gg: ASbGncs3BT9j9ayJBktjVpCZ58EWu/uau5jFt7JuiomUkwRVtDR+9vJ7P+GfM/csckK
	uC/pkev6Z0yvEOqsL49/HPO1J1SVMnCcKxj7FvEoNNKJIKO2fXBiS1OJlkVAL8Hz6sgvNTeK0yR
	4uATY3a5PhCwS6dtPnsEFOK9cKXs//JlPoFkxoCmC5WvOHpd5wg0yASPMZsQRyx9dV1n7FSHHmG
	Pb2s5SuuA1gt8K3kP/CVbtBJpc/B60UGiLPx528Jh/DTk+VpZtCGgQNqp0FHkn5u0hMNs/A3IeO
	XjCQZEUDBOnTO+cD1KU9tV096XSwMTp5HPnaSJGbjauaEGHK8dk1fwm/gfeU6bkUbVLHs7vGAkG
	4Oc7YAK0en9DL+Zj0
X-Google-Smtp-Source: AGHT+IETVXf/pJCr3yvNQ3km9Cql6QIOavSXNWpJeEA0hoFsEcbecpccFFQ5Gxt8IGgp4bqlyE8/cg==
X-Received: by 2002:a05:6a00:3a20:b0:732:a24:7354 with SMTP id d2e1a72fcca58-742a97a70d3mr29767080b3a.4.1747854825120;
        Wed, 21 May 2025 12:13:45 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:115c:1:cb3:38cf:dbbe:7f85? ([2620:10d:c090:500::6:8d1a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970e1a3sm9829587b3a.71.2025.05.21.12.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 12:13:44 -0700 (PDT)
Message-ID: <80ef5e2e-c2d9-45b7-9a48-f8c1a4767eae@gmail.com>
Date: Wed, 21 May 2025 12:13:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: verifier: support BPF_LOAD_ACQ in
 insn_def_regno()
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250521183911.21781-1-puranjay@kernel.org>
Content-Language: en-CA
From: Eduard Zingerman <eddyz87@gmail.com>
In-Reply-To: <20250521183911.21781-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-05-21 11:39, Puranjay Mohan wrote:
[...]
> @@ -3643,6 +3643,9 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   /* Return the regno defined by the insn, or -1. */
>   static int insn_def_regno(const struct bpf_insn *insn)
>   {
> +	if (is_atomic_load_insn(insn))
> +		return insn->dst_reg;
> +
>   	switch (BPF_CLASS(insn->code)) {
>   	case BPF_JMP:
>   	case BPF_JMP32:

I'm confused, is_atomic_load_insn() is defined as:

          return BPF_CLASS(insn->code) == BPF_STX &&
                 BPF_MODE(insn->code) == BPF_ATOMIC &&
                 insn->imm == BPF_LOAD_ACQ;

And insn_def_regno() has the following case:

          case BPF_STX:
                  if (BPF_MODE(insn->code) == BPF_ATOMIC ||
                      BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
                          if (insn->imm == BPF_CMPXCHG)
                                  return BPF_REG_0;
                          else if (insn->imm == BPF_LOAD_ACQ)
                                  return insn->dst_reg;
                          else if (insn->imm & BPF_FETCH)
                                  return insn->src_reg;
                  }
                  return -1;

Why is it not triggering?

Also, can this be tested with a BPF_F_TEST_RND_HI32 flag?
E.g. see verifier_scalar_ids.c:linked_regs_and_subreg_def() test case.


