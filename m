Return-Path: <bpf+bounces-74573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7633C5F5E9
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E7DB4E4CD1
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4A23557EB;
	Fri, 14 Nov 2025 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvsmQ0gi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CD73557E6
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763155679; cv=none; b=m5U4gG7MjGeFx8h9DC8SFxkrmZLCnTktbv7/4ItbhYA3jR2oFfiwm8saRy9UWDkpzeXZWGsnvpKoCfVbCFKy0bzVHZfr9Pu45no8KQL3YbR3fTTtXzOJIv44irtN2vZoDI+EV1S8idylEbjVLp52jSPSu9cdHJqqh5iCQMweLM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763155679; c=relaxed/simple;
	bh=BLimGNNyXokaD6HLAbCnVpW49Qop1JILg6bcFsNjI8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdxsyEpyNjVPIbO10Nle6qcs61mlWpqEVRYLAl6jdKTrTLlAOVGPkZnrkTCKHySN5sRy13LbCANFVV8pKHrjKLFxSeYGM4ySlDsDGWuJIQl1TbVySrEyeLC9SvAcar9s/3Xwu/l6SGAxy5GzF2uYTIKue66fnWQfzAKMyYkp5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvsmQ0gi; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so1300209f8f.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 13:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763155677; x=1763760477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FLr1niG3yRo2eJllJHnuSkVrsfDm0+EfQ91GhNfUzE=;
        b=fvsmQ0gi56Ej2dFL/+m+QwpOn1Rj///KpyYXAlZqWKA3QunPwB0X12Xyw+L6YmA2DX
         8T9+5lnEGNTK5h1YJ4aqBwEHMKw+0wNszgq/Bq9GePubB0w86tTN8DzMiSUqENKz7D0O
         xCKO8QOJb7rzlp//b/nzYpci6G8I6PRKNXfOHFP79qxAv8+4SE3Osw5RHppag+BblUxY
         c+8lCs17IKha+8OuN7/vnPzq2xvEGDgHCoqaHPTEJ6SLSQESCGyDbXoWNwZ742vgsJi6
         sCYF2xuEc6RqHWPLFJiUzs4kIQ9oW8FSeFcZanHA9yFe5cUu+zf3/XL+Fk48pFIw9h1d
         PZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763155677; x=1763760477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3FLr1niG3yRo2eJllJHnuSkVrsfDm0+EfQ91GhNfUzE=;
        b=ebG52kFXVu5kmdQ8ZPwhp4pAKIKCdGoj6KgkFT+vF2jYT7fPQhJlciEICBYVrz7zW4
         AJH/fiLfr8XDemb7w7BrH56xGjDzbtx8vALEn0nDk1hO2udDiIpt8k2WjV1KTUeOuyFm
         3HEroe/Kl+nwKz4vzXlTNgA9PaelhyVw4s6Vi4v6+T6Mw8heX+oRKbQAUajJdI2N25DP
         hmp+n2bFUp27e4QNpn1/WDETRclMPrhSR2TLz5KVsZwnXnvZZZV+1+CYi7XJbldtTtUz
         9XXFsDHe9RI8od1g7LNyGtAELjHxszKRWwrJjbABJe8UUI+JEW2TM0zdDSQ09BpAx7bz
         vjRg==
X-Gm-Message-State: AOJu0YxjRRRuRJu1au28kBCCV2BtJIiXS6m1FHb18YwgmXLt6Var1WOe
	7+X1F4E/yC0toFcRwKajlnhb7eBERmhBxPX7qCrXcr6KXwrLtNJ4UBpngKpKH6pV3oGUM5KevqJ
	AG/tiPNuFyeeMdZ19IoWEfk5eRoIsj13Tuw==
X-Gm-Gg: ASbGnctgknGXlxQN7PwRqlrB4oDRgqCScI2EdJYXgEJc8xqXPBcozhoWHQhso8jp7wt
	KRIxt1huFzIQ9BZ98lemS3m4mUPWdFGMlKgv2EKmJt9RPNYwQiwzzdLjIwdfLl1r1gyJlXlKQVW
	Iv+nyFnAm9Rn33PLjbL3BBaavDtVzEljPOtybH+A/pv9ILahBCBBp9CkWZcWkgjs3QfoX7Ngqj2
	NHg0T7fWYoV8rAzxnEPegVo28loQJmrpoIA0s3L+iTjVztoakk+SbIPIc5XxRBsMkmxIVA7srVU
	Bv66yYyvbyHSVgNVBRp4ZoDzLsVn
X-Google-Smtp-Source: AGHT+IFWiXecOjonEgSXCov1n9JVRZ8xjuiBqe/vxEb7NXLHPZ3GalE7MoN4810nTrAJ+wGNFSDHeSlHFd+T1WVzVbo=
X-Received: by 2002:a05:6000:1846:b0:42b:41dc:1b5f with SMTP id
 ffacd0b85a97d-42b593742b1mr3697627f8f.32.1763155676511; Fri, 14 Nov 2025
 13:27:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114111700.43292-1-puranjay@kernel.org> <20251114111700.43292-4-puranjay@kernel.org>
In-Reply-To: <20251114111700.43292-4-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 13:27:45 -0800
X-Gm-Features: AWmQ_bk__cPdR5EVajBEX7FVUJBint-j1dgWQ6f0TJ2qCCeH7LRvaHAfswD9DtY
Message-ID: <CAADnVQLyv-90hcgrp+DkmSv1b3bt4V8Nz6mdeiLJxV-w0oztjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: arena: make arena kfuncs any context safe
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 3:17=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
>
> +       init_llist_head(&free_pages);
> +       /* clear ptes and collect struct pages */
> +       apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SH=
IFT,
> +                                    apply_range_clear_cb, &free_pages);
> +
> +       /* drop the lock to do the tlb flush and zap pages */
> +       raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +
> +       /* ensure no stale TLB entries */
> +       flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SIZE));
> +
>         if (page_cnt > 1)
>                 /* bulk zap if multiple pages being freed */
>                 zap_pages(arena, full_uaddr, page_cnt);
>
> -       kaddr =3D bpf_arena_get_kern_vm_start(arena) + uaddr;
> -       for (i =3D 0; i < page_cnt; i++, kaddr +=3D PAGE_SIZE, full_uaddr=
 +=3D PAGE_SIZE) {
> -               page =3D vmalloc_to_page((void *)kaddr);
> -               if (!page)
> -                       continue;
> +       llist_for_each_safe(pos, t, llist_del_all(&free_pages)) {

llist_del_all() ?! Why? it's a variable on stack. There is no race.

