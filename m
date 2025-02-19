Return-Path: <bpf+bounces-51972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28499A3C669
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 18:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE631896C61
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 17:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2688214226;
	Wed, 19 Feb 2025 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8G/vh3i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E018F7D
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986875; cv=none; b=VJqQSu52BGNmvSRWb4tL1nydDeup4Km0W7ITBypmDYdobytCWFMQa+JTb07tYTAlneUVZ/W0dXqitw89z7jg2h9wzz1zi01I+fNzVuaYccPlKs9BSYjxnh3LfpFGluNqwuDONOG8fEVIcDSbh09S9j5dl09oj8fU2ARLC4zJ7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986875; c=relaxed/simple;
	bh=WbPSvzfejrdu7OvQTIcXl/pRrqmFmVr4xJnMo1R19lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TuvLrSGTVJuJkUfrPgtC/9cIKTNlzMsJ/IGmSwif6P3QZVTgoBO5mM6ZQTZlGhks8tzhn5LBilZm62gymVbGicF4vz1AtB/x77yAqeB8isIh5H8OM0oAqHWZpXUZGFzHv2BjE8IG7rZ7JgZ3Sv/PtpTFsCb+iA9mIYx+swPJ0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8G/vh3i; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f1e8efe82so78936f8f.0
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 09:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739986872; x=1740591672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzmGyCAz8fbEz3m9su4F3Jndup7PQVeJCkZK3Ka+Ll8=;
        b=F8G/vh3iFu0HOgeScKMOL5BWbcnc/rzJnJKBt4DWZ1KhZnZU6W+K+qUsrE7hDAUohY
         1s31cSMCqMnctnwSqkVCg+HzQ+r8NKGmPjsa+agMSqDDFuG8a+cDTZdxhMN4uHB0UefD
         dne3kXJPBfVF28Ro+yVQnzfvk6h2LJM/jMrOwryz8K11uGnony9r3CgYsFvavzteN2iu
         hA7Uc7RaciM4XwZNNRV0ugtuaM0aAq1QUipdi5tzn6EsSo9koQ+DHM8CtJjatO/xeMee
         QbnquNF3hMdOtbsciWb0SwBdKoUO/lVhyvTfhB6EMBv+twLUREpMTEk0qN/BKLkWu63F
         LXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739986872; x=1740591672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzmGyCAz8fbEz3m9su4F3Jndup7PQVeJCkZK3Ka+Ll8=;
        b=bA94sJdMz+YHqlg1EsgY+1b1lfqJc3SqN2Y+oa3t7WkchfX9C/hlbxaiAUGnS9WnhM
         7eoQvLiI4numxWrdsqzXveiEoeopas8TLlHqIor60XZ58wc5AawQu2D7f0PiF/VAiObj
         dyAJ4YJGIyDCNSCpa77e+YcUgA08RTZooeQ1cZZW997j0ID8bg0v6EK0PiAAgNqdxuZb
         vBYeyeQlA0bwG4nHnVeJV4btRS/73HNCOnaUhh7c1ACodJLbqG8qV5qgUamYgqU0u/vx
         qX1RCsz3ZlJd6f8LwsTFtpw7I5SVv+hHBvK1zK3byJZ5X9w0bRrknRXVtY/EHGPIVnOy
         Itnw==
X-Gm-Message-State: AOJu0YyRNdeQvT/X6yHKXiurv219bOHlCTjsqfK/km2eZ87bRUSfjEPm
	ku5fOF/F3SWQLaUm+aBjAvUK3etmej/GhTn3ZGiqwDVUaAvZqJNC1FdtbeW/jfeGp76KiVNWMOE
	YBw/1Q+vgoWqChBzmm0hbLxqFCYOK0y9H
X-Gm-Gg: ASbGncv774F0mcBa1urqV3mcrDL0mQvJkD/9BG5rji/r0Q/efmiUbvvTpSFcVya4UcF
	08SSYhM1q3q2izRPXDQgJqi0qa/SaC6Kxf8Ma2LyiKOOQAf+K0ylu3aUKY7fq971q6EBtk6HrNd
	nBWG3VCyXWLzEL
X-Google-Smtp-Source: AGHT+IHBuKUbpj44KfFoVlm90tDiBbta9sxt3rqwuGI+XaoJYq68PmUWqvmZ7hBJnk2PiYqyatnI6ul1sjprVNleQSI=
X-Received: by 2002:a5d:5888:0:b0:38d:e33d:d0eb with SMTP id
 ffacd0b85a97d-38f33f125f7mr18841345f8f.9.1739986871864; Wed, 19 Feb 2025
 09:41:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219125117.1956939-1-memxor@gmail.com> <20250219125117.1956939-2-memxor@gmail.com>
In-Reply-To: <20250219125117.1956939-2-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 19 Feb 2025 09:41:00 -0800
X-Gm-Features: AWEUYZnULCFk6QKJYM3osgEia0aSgoq72XOe5kTMMtdR6Ylybec36lbvK6ZmtGU
Message-ID: <CAADnVQ+TBG+yAxtY1Q5D6HnhbvgusUVrzyRm7-8oF7wYw+Nqfw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/2] bpf: Explore PTR_TO_STACK as R0 for bpf_dynptr_slice_rdwr
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 4:51=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> For the bpf_dynptr_slice_rdwr kfunc, the verifier may return a pointer
> to the underlying packet (if the requested slice is linear), or copy out
> the data to the buffer passed into the kfunc. The verifier performs
> symbolic execution assuming the returned value is a PTR_TO_MEM of a
> certain size (passed into the kfunc), and ensures reads and writes are
> within bounds.

sounds like
check_kfunc_mem_size_reg() -> check_mem_size_reg() ->
check_helper_mem_access()
   case PTR_TO_STACK:
      check_stack_range_initialized()
         clobber =3D true
             if (clobber) {
                  __mark_reg_unknown(env, &state->stack[spi].spilled_ptr);

is somehow broken?

ohh. It might be:
|| !is_kfunc_arg_optional(meta->btf, buff_arg)

This bit is wrong then.
When arg is not-null check_kfunc_mem_size_reg() should be called.
The PTR_TO_STACK abuse is a small subset of issues
if check_kfunc_mem_size_reg() is indeed not called.

