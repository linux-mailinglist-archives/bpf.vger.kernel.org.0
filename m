Return-Path: <bpf+bounces-44896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCE29C9695
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 01:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5069DB2130D
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEE05228;
	Fri, 15 Nov 2024 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWxQhVXB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659061FC8
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731629825; cv=none; b=eoLRSqcFyol3FZ8blEZlG2QD/VFU2/DKb/OXM/BC6Gap3XeyAJ7vuj5jR6oSHgyEJAyOzLYbqOg9ziOPm5PLYAOwnaYsAO+YxRwiU3Bw07Wor49NEdBZbZnvkMJQ0kT04Hnt2fIQsCOgNbVigqLDqCxbXgVtqz4fHpB53LHgR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731629825; c=relaxed/simple;
	bh=5XGFtjGulYf4K0oYnjMIJip2tpkn8DYlL1mNd2EzHfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkCwlFBVBymuCB/eIEKKCXyiTDQxnlcd3mTv/VWknIzCTb478pEfJhU/sjL53CyugDm6cwNk96EQmDtaQWvZPJKGYqTdmu/oIkOXe99gjyp8kczrcy5TRFZLvM+eEYnlAszUTVZur+B8T+0ujIvraT23XCeuMPd0tTau35ZSVWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWxQhVXB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7242f559a9fso1180121b3a.1
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 16:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731629823; x=1732234623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZUuBmZUao3Xfv1S43bfVXqIOFlQe+tOL+qz8f4htlA=;
        b=jWxQhVXBaleaYibz20IGusYzz3moZ4/SfnGo042O5Lw3bqXmZBhbwhxCbXeg1t8+Vw
         gy1L6G5aPq4W9Ul2PlxOkdEc7QdRvEA45qTf0GBiFAK4+ubwbW8yTVLmP1+fS0ZzhdGR
         5BF7Y8HsPrutqq3RoTgQb8hhd2eYgAWMa+I+hspmWIq4jL9o8vp86CdWf8L1aX3pyk5J
         cXM8pz1yNXnUO9B26+V5Q4GEuDgD4nIzh/Rk0ukY/9LhftccE5ZPpZ/t9K+xmwRVYWmL
         a4W0xV7EW3oedAblOgrgSblt0UwtYyeR4An1DQouy1fdZoWRla2YQf7Wg2+LEW1pRZB7
         keBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731629823; x=1732234623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZUuBmZUao3Xfv1S43bfVXqIOFlQe+tOL+qz8f4htlA=;
        b=Aqfl6kh2srzkd3aqv5tD9cb9dJZJeyQO8YY5R3OeLCKrSY2Zbsqw7aCKdI6MykHC25
         uYCUm2QTAKe0jYC4hO+VPvUnaF9/bVba8QghzO9wNRlII+4SKimcFF50GBye7cheqs0J
         5LzIUAKPM4Zbhohlt8yKR9098BCbBi4CRiuVsdWwhvBcZb+5jYvhYFxAp+NZuRt8jQvy
         xBSY1aR5RvHJtdr6/UVqydFXt92bErnqNOhevXxYjZgAcqXIjHmubkiNc51LiITTJu0l
         pDy4YTnGLlPPiQIu995tGwe2k1MDe9fdCGcUt3fxuwNV0UCTwhfaOdAHZxTYifeIScCE
         ac/A==
X-Gm-Message-State: AOJu0YzBuBuS47uvDKzj64Ouo8pXGqrN/5f0uQeX7zd1JTWUxVzeEf7f
	xOl4DEiOtxzW2WMsYSYJbNvcUCV7D5aLG0CWuQLBWruJfs/tDIWiEdZ0Ns+eZdx18ZPqDO91+xq
	wpjI8pSOIddca7AnQWTxtr96QCx+ANw==
X-Google-Smtp-Source: AGHT+IF4z/VwUadLIp1QnVz2P4KFgc1htAN6qbJb1BPSuiGS37zFD9Uungf174wO56LidFlbscdGHk5jnNRrELfTTGg=
X-Received: by 2002:a17:90b:3e84:b0:2e2:8472:c350 with SMTP id
 98e67ed59e1d1-2ea15515b42mr1195003a91.17.1731629823660; Thu, 14 Nov 2024
 16:17:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107175040.1659341-1-eddyz87@gmail.com> <20241107175040.1659341-2-eddyz87@gmail.com>
In-Reply-To: <20241107175040.1659341-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Nov 2024 16:16:51 -0800
Message-ID: <CAEf4BzYKfJ1GZUrmgTfSNkzzhhmAL1K-PCc9qs8qTjqk+yneCg@mail.gmail.com>
Subject: Re: [RFC bpf-next 01/11] bpf: use branch predictions in opt_hard_wire_dead_code_branches()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 9:51=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Consider dead code elimination problem for program like below:
>
>     main:
>       1: r1 =3D 42
>       2: call <subprogram>;
>       3: exit
>
>     subprogram:
>       4: r0 =3D 1
>       5: if r1 !=3D 42 goto +1
>       6: r0 =3D 2
>       7: exit;
>
> Here verifier would visit every instruction and thus
> bpf_insn_aux_data->seen flag would be set for both true (7)
> and falltrhough (6) branches of conditional (5).
> Hence opt_hard_wire_dead_code_branches() will not replace
> conditional (5) with unconditional jump.
>
> To cover such cases:
> - add two fields in struct bpf_insn_aux_data:
>   - true_branch_taken;
>   - false_branch_taken;
> - adjust check_cond_jmp_op() to set the fields according to jump
>   predictions;
> - handle these flags in the opt_hard_wire_dead_code_branches():
>   - true_branch_taken && !false_branch_taken
>     always jump, replace instruction with 'goto off';
>   - !true_branch_taken && false_branch_taken
>     always falltrhough, replace with 'goto +0';
>   - true_branch_taken && false_branch_taken
>     jump and falltrhough are possible, don't change the instruction;
>   - !true_branch_taken && !false_branch_taken
>     neither jump, nor falltrhough are possible, if condition itself
>     must be a dead code (should be removed by opt_remove_dead_code).
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  4 +++-
>  kernel/bpf/verifier.c        | 16 ++++++++++++----
>  2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4513372c5bc8..ed4eacfd4db7 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -570,7 +570,9 @@ struct bpf_insn_aux_data {
>         struct btf_struct_meta *kptr_struct_meta;
>         u64 map_key_state; /* constant (32 bit) key tracking for maps */
>         int ctx_field_size; /* the ctx field size for load insn, maybe 0 =
*/
> -       u32 seen; /* this insn was processed by the verifier at env->pass=
_cnt */
> +       bool seen; /* this insn was processed by the verifier at env->pas=
s_cnt */
> +       bool true_branch_taken; /* for cond jumps, set if verifier ever t=
ook true branch */
> +       bool false_branch_taken; /* for cond jumps, set if verifier ever =
took false branch */

we'll now have 12 bool fields in bpf_insn_aux_data, probably it's time
to switch to bitfields for those (even though you are trading 4 for 3
bytes here), 72+ bytes per instruction is not unnoticeable, especially
for big BPF programs

>         bool sanitize_stack_spill; /* subject to Spectre v4 sanitation */
>         bool zext_dst; /* this insn zero extends dst reg */
>         bool needs_zext; /* alu op needs to clear upper bits */

[...]

