Return-Path: <bpf+bounces-45726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F329DABE9
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 17:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051ED2814E7
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78262200BAA;
	Wed, 27 Nov 2024 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9qjZEVt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECF1200132
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732725594; cv=none; b=Tc5c/P79FbjLrhL9PPmAvaygYjZS+tjpXzaOMa1qo3x9QbBKYJpSgcoHRQy+h8+E3PaVAxoM3XlBzR0Btljv8hTv0FmjGqud4dIoZGwhTFDWffQ3PdgA0loXQX2KKs/41pfe+Kv0rhzo64JmBE+uniAd3QsqcR9yDDWeuS1QGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732725594; c=relaxed/simple;
	bh=pg6axA3tlwjWkGQeT2gGN+QqsWd0popS/0n/EKpJJj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FA3yVCI0RGJVU9ZXGMgHogyhsMeOPbxy8DwDRFcc1IQbjPmjlrLXrjuVJ6kJ5xgSgYSLJ5kCgDdX5PNWbxC0D2VzqsPjstOoKzBMFWkqJlL+gNQS4v/6/t22+EgEMMkNfnebEHQHr5sswwNpFFwOy4N538uqpgCGMHfZn/aiGUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9qjZEVt; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so8107980a12.2
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 08:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732725590; x=1733330390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RjCKfzD5wv80V7qzr1EeW1MHrkqIpg75ZIN5g2E9FUM=;
        b=f9qjZEVtZzb73odQZmPHkaR6oX9HZAyDrkXSrocwWy+9Ner0WF/aVueKr1eXmUP3qL
         2B1QhoAIIixrrwzrP8RR9Dj6CHr7cZmK/q2Z8V+WtWwvjaOt/tclvY4b40MibWHOImr4
         RP2mYKz2cDMWBDH/i+eUG9vEdJP0zGIOFlCUzV5I5474kqWZH5aAsUfZ+EtJ0anGeYMg
         /omRh8+ze7liX4yoqhvS7WXsLVKdH+OReWCGG6khczIjcHfFZLtxpHh0V5tdCZQaRY2y
         BTLIXYWDmVfCh28uR0W7TnVwQRrVpEguCRrhPKPTtnWgCfyO0N4ysgbRoMyu/GIEKcY3
         OtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732725590; x=1733330390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjCKfzD5wv80V7qzr1EeW1MHrkqIpg75ZIN5g2E9FUM=;
        b=DHTL3+De+vp7tmvPxFtTGTcKOHXM5RpxUnBYaHEBm1QlXnOEx6r3jIa9AJefQy1K9j
         BiHyZIgW+7cyq06yzd9EVlwr/tvM8TNpCgkpktRz3068++pnt8fv3xSf4H7PHW2PbIsK
         Z5dySkgkNb++RKrGOWfqeN2ZWR0maIkw45btXzWcNNDNuAqTjRIA2i+xeQMvTRqwPwQo
         oh5pHKv1quErZPq6BhMNTCpbF8WAqoavP2sBYi4/AXYl4TJZoMokjwmjrAGCMGPW+yke
         pKlZWtiuSN5W1tmJXu+a00ggV3Nc3nIHzuzCLPOx44TyrPVYcYUHxrFGxAA6Ux1+bU69
         igzA==
X-Gm-Message-State: AOJu0YwNGVHeMRZ3kNkjNi5ll9AMWcD9WlxdNpKWbS+sZFqDAVJbiTFf
	8kSoNyvdFmV0d3lcvFH4vJ/p4ZdqqisVYiTWb7M9x0/A85reJa+kpd0+U/Pq5qv1rpUqpGcufXX
	DFh6FBR/F+CgmjpZIYU2sZlyybULpo7PzW78=
X-Gm-Gg: ASbGnculKqwUjQnBrjheO/C8o165VROydN1TWNNtU6VBmwSb0aDNZb7fIP6BBCzgI5J
	2kOddoV//6VJLjhTx8LBR32Hj1BCQBb/j
X-Google-Smtp-Source: AGHT+IE5HYZiJw6TpSy9W894naS+8LCF3QjbB7pfaEJf+UXhrKAuMimbJdSywFu2IQd7+5nT6VHdeBSilYSGQU++MX0=
X-Received: by 2002:a05:6402:2353:b0:5cf:f1fd:c687 with SMTP id
 4fb4d7f45d1cf-5d080c97f34mr3301391a12.24.1732725589676; Wed, 27 Nov 2024
 08:39:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127153306.1484562-1-memxor@gmail.com> <20241127153306.1484562-5-memxor@gmail.com>
In-Reply-To: <20241127153306.1484562-5-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 27 Nov 2024 17:39:13 +0100
Message-ID: <CAP01T77e+OvrkayPr70MoantyCiaUe-HoRbSdSRzeRS+Vbaq0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/7] bpf: Introduce support for bpf_local_irq_{save,restore}
To: bpf@vger.kernel.org
Cc: kkd@meta.com, Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 16:33, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Teach the verifier about IRQ-disabled sections through the introduction
> of two new kfuncs, bpf_local_irq_save, to save IRQ state and disable
> them, and bpf_local_irq_restore, to restore IRQ state and enable them
> back again.
>
> For the purposes of tracking the saved IRQ state, the verifier is taught
> about a new special object on the stack of type STACK_IRQ_FLAG. This is
> a 8 byte value which saves the IRQ flags which are to be passed back to
> the IRQ restore kfunc.
>
> To track a dynamic number of IRQ-disabled regions and their associated
> saved states, a new resource type RES_TYPE_IRQ is introduced, which its
> state management functions: acquire_irq_state and release_irq_state,
> taking advantage of the refactoring and clean ups made in earlier
> commits.
>
> One notable requirement of the kernel's IRQ save and restore API is that
> they cannot happen out of order. For this purpose, when releasing reference
> we keep track of the prev_id we saw with REF_TYPE_IRQ. Since reference
> states are inserted in increasing order of the index, this is used to
> remember the ordering of acquisitions of IRQ saved states, so that we
> maintain a logical stack in acquisition order of resource identities,
> and can enforce LIFO ordering when restoring IRQ state. The top of the
> stack is maintained using bpf_verifier_state's active_irq_id.
>
> The logic to detect initialized and unitialized irq flag slots, marking
> and unmarking is similar to how it's done for iterators. No additional
> checks are needed in refsafe for REF_TYPE_IRQ, apart from the usual
> check_id satisfiability check on the ref[i].id. We have to perform the
> same check_ids check on state->active_irq_id as well.
>
> The kfuncs themselves are plain wrappers over local_irq_save and
> local_irq_restore macros.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h |   9 +-
>  kernel/bpf/helpers.c         |  17 +++
>  kernel/bpf/log.c             |   1 +
>  kernel/bpf/verifier.c        | 279 ++++++++++++++++++++++++++++++++++-
>  4 files changed, 303 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index af64b5415df8..81eebe449e6c 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -233,6 +233,7 @@ enum bpf_stack_slot_type {
>          */
>         STACK_DYNPTR,
>         STACK_ITER,
> +       STACK_IRQ_FLAG,
>  };
>
>  #define BPF_REG_SIZE 8 /* size of eBPF register in bytes */
> @@ -254,8 +255,11 @@ struct bpf_reference_state {
>          * default to pointer reference on zero initialization of a state.
>          */
>         enum ref_state_type {
> -               REF_TYPE_PTR = 0,
> -               REF_TYPE_LOCK,
> +               REF_TYPE_PTR    = 0,
> +               REF_TYPE_IRQ    = (1 << 0),
> +
> +               REF_TYPE_LOCK   = (1 << 1),
> +               REF_TYPE_LOCK_MASK = REF_TYPE_LOCK,

I'm thinking of reconsidering the bit above and below. When rebasing
other patches on top of this series, I sort of realized it might be
unnecessary to keep the mask, and just make REF_TYPE_PTR non-zero, and
always do s->type & type (which is needed by later patches for spin
locks).

 -               if (s->type == REF_TYPE_PTR || s->type != type)
> +               if (!(s->type & REF_TYPE_LOCK_MASK) || s->type != type)
>                         continue;
>
>                 if (s->id == id && s->ptr == ptr)
> @@ -3236,6 +3395,16 @@ static int mark_iter_read(struct bpf_verifier_env *env, struct bpf_reg_state *re
>         return mark_stack_slot_obj_read(env, reg, spi, nr_slots);
>  }
>
> [...]

