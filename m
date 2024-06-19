Return-Path: <bpf+bounces-32507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3834890E678
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 11:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9AF1C21AD3
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 09:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D827E56C;
	Wed, 19 Jun 2024 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYS+LnQx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875477E0E8
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787775; cv=none; b=tMycyZiqs6BISKYDbRsSQd7SjUdvUjCvIG7p7hpcpXnW2J1d6wUpFYlo6HUOlnvY7qU4wi7qf3zNVPcg275waVvG/0176FOKYehDsYYtTopiKiWpIfXVAfdsSbaMDESzMsAK3HfOiyvVdhYAtzVNej74C7bHH0mLwfdqOOzbDGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787775; c=relaxed/simple;
	bh=rxMMV+a2ma1mrpn4bdY/CV34RcYnXiUiEtvuGPEPgBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UztQAZCywm2XZLS4iOt9IAIPQivp6aGjRiXaxrq/IYi437vnWpdHRZddk8ME+rOp8uEpi+tHCytEachDy8wFYKS/TDeN0km0ATKxI5SRHhGHocH1aziuK6Mj4QklPBeJXciRZKk3o/b4iUGXECcqykPNZxSkUvYJumSE9VyBZ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYS+LnQx; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a6fb696d2d8so29635766b.1
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718787772; x=1719392572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VujBZSVuwesR66fGZp0t+WEoaz3C9H+jqXQk1TWK8bU=;
        b=VYS+LnQxEljMTpC5D72HdtfVeStjZvbZ6tiqNdoJI8IVQ3LeUO4EiPUaQlH7ktDhU3
         HstZ32oHWKtp1NyG9ELuK0winiQ3MkcUSEEe7GkTBB/lEaV8XJcjbH214w66JzO1VOSw
         DIiY9JR+u2tQTKOvj3yTzcSIg1TsR279kfVA1UtqwjbweVDsCHTPPiom113cgirXHGGY
         3+hBVfrsTq0o3MkZF4XX1Uy9wyRZUJHhzSYvJp49iVPcW0+d62py/FVOE3JQI6t47647
         0NJ76+RAb4itiE6HT5P3zanmI/mCc2AK17n4G5dGi2UsqLGBUw8K8V5cYdQ6NqAO9hEL
         cDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718787772; x=1719392572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VujBZSVuwesR66fGZp0t+WEoaz3C9H+jqXQk1TWK8bU=;
        b=ZKgrUVZaDe+6mEsQmPgrnWqR18eZidQAZQXOUmAxiwS5cptDqMz/L8njNsv0aqT0lD
         bJYM/D8ISMVYd4TJavw9rbZqIVES6S+eyc67SKSCa7JoEymP0qdTNWam/qb3CTYMEqWf
         L6KfTPd8d3PSVSinJmhmLEIvmtyiiNrDr7/TTWhe8GtHF54Iix567cFzHc1gvW5lShRz
         wiKT4mcYxFW/awbVOgZSQo71DU3WNHt6gHzUex5+vGl6DBhTjyf7Mfj6CjqhLm2o+PJl
         eulk/vd1Kfd850cfS7kJaVuSfjWGIVo5lwDBxTwe+dJ+OBl1yYWFc4oB5AS0f9A49MLz
         vCmw==
X-Gm-Message-State: AOJu0Ywb3G1gsNPt8aEc66yuowEPciiz7vXu/H/pl8JAvximTVt3OpQf
	vdtjseNs9tSOrWcTuTWLSRCnQ4JEj3BASgAN0A5Y/GOWAeozNaQ9UFMlJI2w0slNa3L4RSoHjCY
	njXOMORh+vbwIrTUeAw7YTI+dCr4=
X-Google-Smtp-Source: AGHT+IF4rPYGHo/tXc6DUDr1kREaxWzPzOXms0OXUEnTKyhX6wvJ0NQ92exOfcuMC8aCyvkGoFCh+qWtTYp+LLWai14=
X-Received: by 2002:a17:906:f343:b0:a6f:5765:671f with SMTP id
 a640c23a62f3a-a6fab7d0bc6mr109028166b.68.1718787771514; Wed, 19 Jun 2024
 02:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZnA9osZKFOPFwvxa@google.com>
In-Reply-To: <ZnA9osZKFOPFwvxa@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 19 Jun 2024 11:02:15 +0200
Message-ID: <CAP01T75s_8yN6B6DB8+Be7oHjuEx8J8pG65eYkwUHbSGZ1mMSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/bpf: add negative tests for relaxed fixed
 offset constraint on trusted pointer arguments
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, song@kernel.org, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, void@manifault.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Jun 2024 at 15:44, Matt Bobrowski <mattbobrowski@google.com> wrote:
>
> Adding some new negative selftests which are responsible for asserting
> that the new relaxed fixed offset constraints applicable to BPF
> helpers and kfuncs taking trusted pointer arguments are enforced
> correctly by the BPF verifier.
>
> The BPF programs contained within the new negative selftests are
> mainly responsible for triggering the various branches and checks
> performed within the check_release_arg_reg_off() helper.
>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---

With the stuff below addressed, please add:
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

I believe sockmap map_update and dynptr ones are also providing
positive coverage (given previous versions made them fail), so I think
focusing on negative cases is good enough here. I guess bpf_sk_release
is also covered by existing ones.

Still it'd be good to add a few more cases if you find any, as Eduard
suggested, just to make sure we're not missing anything.

> [...]
> +SEC("tp_btf/task_newtask")
> +__failure
> +__msg("variable trusted_ptr_ access var_off=(0x0; 0xffffffffffffffff) disallowed")
> +int BPF_PROG(trusted_type_match_mismatch_neg_var_off, struct task_struct *task,
> +            u64 clone_flags)
> +{
> +       s64 var_off = task->start_time;
> +       task = bpf_get_current_task_btf();
> +
> +       bpf_assert_range(var_off, -64, 64);
> +       /* Need one bpf_throw() reference, otherwise BTF gen fails. */
> +       if (!task)
> +               bpf_throw(1);

It seems s390x is failing because it doesn't have support for throw.
So I'd just drop this selftest, since on second thought I think it
doesn't provide any additional coverage than the pos var_off one.

> +
> +       task = (void *)task + var_off;
> +       /* Passing a trusted pointer with an incorrect variable offset, type
> +        * match will succeed due to reg->off == 0, but the later call to
> +        * __check_ptr_off_reg should fail as it's responsible for checking
> +        * reg->var_off.
> +        */
> +       task = bpf_task_acquire(task);
> +       return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.45.2.627.g7a2c4fd464-goog
>
> /M

