Return-Path: <bpf+bounces-33780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BFD9265C9
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 18:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401CE1F236AF
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 16:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED32181D02;
	Wed,  3 Jul 2024 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHt2/dWa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B9C442C
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023201; cv=none; b=ur2yGX7ZYcVbbazcyL7o+jTkVCHI+pgdarTOy1UXkgVrRxytGkPWD0EYuxckfqXGkgz/RfByp2upxG59VEOq8gIoaIcv3QuM4hKzgd5/cDwmozke792mAZ7iWyLt77C63eN0bu+Cx96xZZLhEtTaUtECe7e+rEIdLbEKlUhFUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023201; c=relaxed/simple;
	bh=coOXWJWYM8FuAsdeC7a2lIDEkcYsI6kKK3KaTAbl1ac=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dArgpHLujzrcJ4CTXFSp9F6fvOHsBB9iaGCHcloSwbxESKyCbcexw39V78EMGCrxh3u1BGqDY7jTikfZuE7NO/RA1gWXeG7Fj30T8E5JzTRexlpprQMuofJQGWC7UFngKhIXNay6KvSPgVjhafRlfzN+IQl275LuxhDegktoyWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHt2/dWa; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7594c490b04so579735a12.3
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2024 09:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720023199; x=1720627999; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DQwaqdtfZpqmvUW+XEH+jYS+rHaQUaLMUZKwPrJxafo=;
        b=gHt2/dWaJk/zKzrII9X876evPjuJ398jcFh1xVuy+fcP0eHin01zQkjJD4P0c+qPDx
         8fRUFdKPZPwDXT2yKCvlU/TgGxIgnKTRjSH5vljhfeP32k/w9xf3RWveRLC9r+PydLDp
         V8otNhaVKC72XIo7u4DkH9jQIO5UtgAc9uxDHtUhVPApArU7isn0XwdWHq7HQuGpz5E3
         hoawzjfryN9JrwWIRDUKtl/z6Yv0zkdBDQ7/pFUS4wqBcHQWuK3thv7aoH1wOt9enKUP
         5zd9dUB/eAwd8dcCJRO5RZrFuNb4MD0XTmG7tL5hNTOjKjVnRcV4MEpEhTDOW0mxF5Ol
         xUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023199; x=1720627999;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQwaqdtfZpqmvUW+XEH+jYS+rHaQUaLMUZKwPrJxafo=;
        b=fb5FUUM6qbqXcXv4YY5sisisHGf4k+Y+cl6z33Ngkxr980kpFsLQ/JpRoslJwnOjvI
         gCS4PDzQ8rO0cNwdcyqMnS7U23pxGfxVKlZQM5am2LN0D1jt0ZFLF7bXysxfRqOMhZ1E
         EpB04JnAvAlNki23r8CwGAYM7136L3WUMB7JSXo229QuoLp0Bor558obxEGRpdNN95+R
         QwJ+YQjZEMC1oRyt6Pve/l9QpTLFVmXTCqVWns8RYmHu/uU/iBAdUoWfoRYeYzd1MV6k
         Jkyg6fSi4iVMQVn5WoiMoacxpgVl2wtWRKPW9Ci+XaiEyrmLWErtCjOZ25DnsWiHkxMQ
         AbGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU0fCoV5X0hB6b7cVX870fsmHVPbMZS45SHmCAVjhQG6g4PsIgSSxP3wDpdCohGqD3K0TE/B7pXOKR+m7hjw0/RYTk
X-Gm-Message-State: AOJu0YxnHtAIgFW/kXsOxqfz+au2nq1IrsvJrjoPCxb17FcYXeqkp6A2
	rDHyXAUQdlDgP8GJJAPgGvhzPKDPegMZlxQMmoviY+3TOXJA9eW4
X-Google-Smtp-Source: AGHT+IG4/ICs/wDb7J+URJ8pufMV0DsfMiq8n01TDYd+DTNj+whNgDZG+eRdGU9a+Y6f9FiS2q5Erw==
X-Received: by 2002:a05:6a20:3ca2:b0:1be:c965:2567 with SMTP id adf61e73a8af0-1bef620cdc4mr18873276637.47.1720023199027;
        Wed, 03 Jul 2024 09:13:19 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c7f6db9sm8287130a12.72.2024.07.03.09.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 09:13:18 -0700 (PDT)
Message-ID: <b60d6b6a385fc7fa2c323a2122660fdd9fd6f6f0.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 2/8] bpf: no_caller_saved_registers attribute
 for helper calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
 kernel-team@fb.com, yonghong.song@linux.dev, jose.marchesi@oracle.com,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, puranjay12@gmail.com
Date: Wed, 03 Jul 2024 09:13:13 -0700
In-Reply-To: <mb61pbk3ek7rf.fsf@kernel.org>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
	 <20240629094733.3863850-3-eddyz87@gmail.com> <mb61pbk3ek7rf.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-03 at 11:57 +0000, Puranjay Mohan wrote:

[...]

> > +static u32 call_csr_mask(struct bpf_verifier_env *env, struct bpf_insn=
 *insn)
> > +{
> > +	const struct bpf_func_proto *fn;
> > +
> > +	if (bpf_helper_call(insn) &&
> > +	    verifier_inlines_helper_call(env, insn->imm) &&
>=20
> This should also check bpf_jit_inlines_helper_call(insn->imm) as the JIT
> can also inline helper calls separately from the verifier.
>=20
>     if (bpf_helper_call(insn) &&
>         (verifier_inlines_helper_call(env, insn->imm) || bpf_jit_inlines_=
helper_call(insn->imm)) &&
>=20
> This is currently being done by the arm64 and risc-v JITs and they don't
> scratch any register except R0 (The helpers inlined by these JITs are
> non-void).

Hello Puranjay, thank you for commenting.
In a sibling email Andrii suggested to also add a function like below:

    __weak bool bpf_jit_supports_helper_nocsr(s32)

At the moment I see the following helpers inlined by jits:
- arm64:
  - BPF_FUNC_get_smp_processor_id
  - BPF_FUNC_get_current_task
  - BPF_FUNC_get_current_task_btf
- riscv:
  - BPF_FUNC_get_smp_processor_id

I suspect (but need to double check) that all of these patches conform
to nocsr. If so, what are you thoughts regarding bpf_jit_supports_helper_no=
csr():
do we need it, or should inlining imply nocsr?

Thanks,
Eduard

