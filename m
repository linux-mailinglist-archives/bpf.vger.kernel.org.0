Return-Path: <bpf+bounces-11320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AAF7B741C
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 00:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 907791C2074D
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 22:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E7E3D97B;
	Tue,  3 Oct 2023 22:31:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA373D96C
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 22:31:33 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35BEAB
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 15:31:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso262773866b.0
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 15:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696372290; x=1696977090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFvPkdJeu7+VN5vuwQIIRhCQzw/PrpiLWzyABOBTtdk=;
        b=IR6tMH8dKXDr6V9tp1hBf+4mT8sX56wSnmPMMfIOunU3VsEk9bJlpKXPFtJX++yujN
         S6rY3hxKRfyOuUr0X/C4Z94vZBETsyXqi8qOsxwqp8nlzzDQXEIQcclY6AytKw7K8N0I
         N3Dr4ur5iPYT4UPjoj1G3c883NN5TqqewrojYUsfirGt+mF1y+H3o9Zxkn+bWSBbbijt
         zsSDfAxBK9phF8k/k/5BGr1EQAgpYy+KzFSgQpgDpLW1cPjyQ3FR7FnqDAcwB2BQxvAY
         FPVYoiRtpvBDgAF9gjb74maqyCwMyaDlqLkuRDhszGkFZFLOkEhHaw1TDHPZ+VKRyu9n
         tiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696372290; x=1696977090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFvPkdJeu7+VN5vuwQIIRhCQzw/PrpiLWzyABOBTtdk=;
        b=Or++L/RFilTIyUY7AyvYH8X6llLKU3eF2htrVTPO8gtA3LpQBnqs6aDjW/vKD4QlaT
         m8N0kJ6EhiRfdE53B9LxWZURJyjFH6qcwKLEYDXy/qLXXiqFdpBDDZRk7KeHnQ1zib7g
         98WTRoviGQyK+xA9dp+m/82Jdd4U997Gj4MrzCmGxRhjXAtnvg14IIwUQ6L19FPXhWnQ
         DK4xo+Wj8tShcMs8IqTFN5L6i4tt5ObSLnJAoimlu7X/6TZMRqqnrVBlhQqZUh33m037
         HS+pu+hmO8F6g15FIuTndY5sw+Jllwj95/W4zxl2j0xXzhNxH/zNxZRjs+ZNoFbO0uXB
         2VbQ==
X-Gm-Message-State: AOJu0Yz2i8OaJUtjjQBUywnPyedNyNL0OpGLBnepb/hjvvutNNRwqyaV
	PKAdT6YWPfB2BwYvwwjGm0/96TLbWvt5XPRyxoQ=
X-Google-Smtp-Source: AGHT+IGYjorOvxtMTFyUgiHp4+iN8NFzNCz7YGhzCTy2CRisi2yr6SWleAFbJR0i2HcRxV45tU+rVcxct4wV9J/nWVo=
X-Received: by 2002:a17:907:7888:b0:9b2:bcd5:8d37 with SMTP id
 ku8-20020a170907788800b009b2bcd58d37mr456742ejc.6.1696372290296; Tue, 03 Oct
 2023 15:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003200434.3154797-1-song@kernel.org>
In-Reply-To: <20231003200434.3154797-1-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Oct 2023 15:31:19 -0700
Message-ID: <CAEf4BzZ3iWhdtGSR326zKx0CUUHkO4mQA4ie2sY51SSTUqHM=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Avoid unnecessary -EBUSY from htab_lock_bucket
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, kernel-team@meta.com, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 1:05=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> htab_lock_bucket uses the following logic to avoid recursion:
>
> 1. preempt_disable();
> 2. check percpu counter htab->map_locked[hash] for recursion;
>    2.1. if map_lock[hash] is already taken, return -BUSY;
> 3. raw_spin_lock_irqsave();
>
> However, if an IRQ hits between 2 and 3, BPF programs attached to the IRQ
> logic will not able to access the same hash of the hashtab and get -EBUSY=
.
> This -EBUSY is not really necessary. Fix it by disabling IRQ before
> checking map_locked:
>
> 1. preempt_disable();
> 2. local_irq_save();
> 3. check percpu counter htab->map_locked[hash] for recursion;
>    3.1. if map_lock[hash] is already taken, return -BUSY;
> 4. raw_spin_lock().
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/bpf/hashtab.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index a8c7e1c5abfa..347af4476662 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -155,13 +155,15 @@ static inline int htab_lock_bucket(const struct bpf=
_htab *htab,
>         hash =3D hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets=
 - 1);
>
>         preempt_disable();
> +       local_irq_save(flags);
>         if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) !=
=3D 1)) {
>                 __this_cpu_dec(*(htab->map_locked[hash]));
> +               local_irq_restore(flags);
>                 preempt_enable();
>                 return -EBUSY;
>         }
>
> -       raw_spin_lock_irqsave(&b->raw_lock, flags);
> +       raw_spin_lock(&b->raw_lock);
>         *pflags =3D flags;
>

I might be wrong, but I think it's dangerous to have raw_spin_lock() +
raw_spin_unlock_irqrestore() (in htab_unlock_bucket). Looking at the
implementation of raw_spin_lock_irqsave() and
raw_spin_unlock_irqrestore(), they do their own
preempt_disable/preempt_enable, and so with your change I think we
have imbalance, one preempt_disable() in htab_lock_bucket(), but two
preempt_enable (one explicit in htab_unlock_bucket, and one implicit
inside raw_spin_unlock_irqrestore).

I'd say let's use plain raw_spin_unlock() + explicit
local_irq_restore(flags) in htab_unlock_bucket?


>         return 0;
> --
> 2.34.1
>

