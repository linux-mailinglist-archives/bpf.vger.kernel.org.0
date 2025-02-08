Return-Path: <bpf+bounces-50832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB90A2D2D7
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 03:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5271684A3
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 02:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE45919AD8D;
	Sat,  8 Feb 2025 02:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmnB8Qh/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BD21891AB;
	Sat,  8 Feb 2025 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738980091; cv=none; b=f7esbLgB24uSDLscosl/0UHl6Z9T6CvqvXM+zbH5rzc/Xx3syt3KUbLjLAIj/1XE+uRdoOpH2Bjdi0GV8q5yA8hw56ZBBnaW4IOPNmvl67CCo7Xamw2Cz46rZSRY3WXLlVlLqVXQTAk8sAq0gg/cZCZDwPYONGJBNLwXTMYl94U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738980091; c=relaxed/simple;
	bh=OS4CA+OBtLQhST1mmHsn/UlqfYyYFGggFfg0gQckuoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TU9DLvVkL5xs8/xQObGAA7Al/rDCymCwFQRyKDAnJ3iv0+db/s0DOwCBlr42JUXpPP4cwRPlgxkIr2J5GHJyXc8gT5jJIXnO9CZ+EG3kHRib/Ce3ePXgq6wPM90+YTvY51bwWaXjAWOreFMzu417a3VWI9LBf9zeH7fd/+MLUzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmnB8Qh/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38dcae0d6dcso691765f8f.1;
        Fri, 07 Feb 2025 18:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738980088; x=1739584888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGIrEua9iQ8bHgGdDw3wNHVLDjJrs0blGd4Py+scUxE=;
        b=cmnB8Qh/L0GTYP1f32KDHDYLGh2eWrE2T1HF5sP3uexlqq8735BfjpG4ezJjOp9jL3
         zLwZyykbe61NvFFPNFRHl7Hkp93BAKkIz+2EJz8do+6veSrp4M0DgyYByQctldEMsNWo
         HW1g3l+AAjE4qvC2SpYe9ruW7bUTMDq7R5ob2mUEYwebK5zqFGT4tkyZDjaNOVHf7InS
         qiqLfEW40YyHkoIKC26OOrRG+ONBDcRiaqmzxWetyc8YNZ1lR39eVB6RdmbREgKK/L8N
         8Q2Re3mkEBBO22XvRaygiTgPSN+aCkLFBMZ3+IVVlXdF+Z3SCETJ5TxOAyI0R3R9Z/CP
         /IKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738980088; x=1739584888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGIrEua9iQ8bHgGdDw3wNHVLDjJrs0blGd4Py+scUxE=;
        b=P5/JPm0Ys4nz39Xqsvh2tMag1xL0GwzC5gl1jCGZPupX6nzsRKkAb7+0LJ+20Ly8Zs
         pF4Lq5wJF3JBwzVcLt/PmCXTrwuTvyeOXeKCJcVVD9G4A6QE4iZk1DW0aoEyNQsnOacA
         9h3+oFz+PNInCgZemDuGM0wHF6QZRpPxpZ/B2IuCCymZN0eAKrd3yCcGug4LTHkJRhdr
         5opwAgg87Z7tx5IP9na/4jkjvIZhtDX7VTLKRGQQaFfTQw9UwZG+pbptCM82aK16Mo5d
         VmgfV71GbyNBj972+edsjkQISyxAKNzQKfGUVuOW7ztTTMUnoqrPHebT9l3bzp8RLnQZ
         TQAw==
X-Forwarded-Encrypted: i=1; AJvYcCVh+RLYFyMitzi2cse3AlYAqyMtpU3oE6nNmSfnt94JwSyqPwDhQQWZF1eoLUrY11sW29Lm/CYsAKZqE7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YykCOxUbE5WoV0K2kWTxd1rdhmYuu6lK/4UAWRUQdxoqJej8o5J
	rapLMhavOJjsTvA+QKMHCzyTXJKXxXz4MbaofX5xvKl8A/Kt8HFla6ZJlowRf5RqGxPOfijm87h
	o5WHpl7sjA4ydU3ZZ4Cdke3vAZdY=
X-Gm-Gg: ASbGncvL9SBIYgZHkCLQF7mFviBXZ4qs0d3v0A1XtnZZVyoBMJYuXoEGYM7pdWV/Gpr
	3UPqLq9eaDKySjLLR/MRYL7cFC88SbpGh73hhBCxuSLRYeAzbQHgvTmhdnnfDkcMSu0ull7Op7B
	wvM7cM8DNXXnSoBA8zKV5WDwFhV2oG
X-Google-Smtp-Source: AGHT+IEoZCtmd/odsNY1AueL2/BylkudMbYiLPnq+yVpZr8qNoJRC0tBlsOa6xLF9KZbqMlXnsMGY+t/Q+QTxpioknQ=
X-Received: by 2002:a05:6000:1865:b0:38d:bf57:f371 with SMTP id
 ffacd0b85a97d-38dc9373270mr4376973f8f.48.1738980087553; Fri, 07 Feb 2025
 18:01:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206105435.2159977-1-memxor@gmail.com> <20250206105435.2159977-20-memxor@gmail.com>
In-Reply-To: <20250206105435.2159977-20-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Feb 2025 18:01:16 -0800
X-Gm-Features: AWEUYZnUTy2itNVn48BldfC4LoMr601PCDOaBo1fZL0B5Yg1x-9oEAhlPjMvVFU
Message-ID: <CAADnVQLNovQYGy6_zGDi75vmNHfZ-hKz4G=gWF4Bis8b6iTYew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 19/26] bpf: Convert hashtab.c to rqspinlock
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, 
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:55=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Convert hashtab.c from raw_spinlock to rqspinlock, and drop the hashed
> per-cpu counter crud from the code base which is no longer necessary.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/hashtab.c | 102 ++++++++++++++-----------------------------
>  1 file changed, 32 insertions(+), 70 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 4a9eeb7aef85..9b394e147967 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -16,6 +16,7 @@
>  #include "bpf_lru_list.h"
>  #include "map_in_map.h"
>  #include <linux/bpf_mem_alloc.h>
> +#include <asm/rqspinlock.h>
>
>  #define HTAB_CREATE_FLAG_MASK                                          \
>         (BPF_F_NO_PREALLOC | BPF_F_NO_COMMON_LRU | BPF_F_NUMA_NODE |    \
> @@ -78,7 +79,7 @@
>   */
>  struct bucket {
>         struct hlist_nulls_head head;
> -       raw_spinlock_t raw_lock;
> +       rqspinlock_t raw_lock;

Pls add known syzbot reports as 'Closes:' to commit log.

