Return-Path: <bpf+bounces-49549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CFFA19BB9
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 01:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E07167FA4
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 00:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6958F5A;
	Thu, 23 Jan 2025 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YM8BBgm0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949EA4A23;
	Thu, 23 Jan 2025 00:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737591814; cv=none; b=tEuYYt2kPswgQ8zatyrzsXyY2ldHZIb4GFdQnRepSd5rTooDUk6HSXiXPIkw7MyaPx0IboKOdeOYRLmG77wFKton9spmVHlViwcLJ3CvHPqnup4jdTceFeK3y7WFu3iIX5DV2IOiiqKWDkrYyGiFx/T3Y31aXoaTrfRE3TaG1Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737591814; c=relaxed/simple;
	bh=DdpAUxsuV2VApq6E8d6I5DkZ/cVJFMrRyio/Q37tkx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIt4T5Prpml1YXEaN3NspdvaLKXhOTjEdctfjskLoaTMI8Yk0NXFJD5qn1O/VwlhJGU2VSqe8aFm/bbkkucJc3rHfe5Z5Tdign6iazGiv0zq2uLVPVDiwjpRu3gzcZo4oPbaNUa/0UhjFPDN+oE6vbacioCC6XIVt8lkSfwOPXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YM8BBgm0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4362f61757fso3295275e9.2;
        Wed, 22 Jan 2025 16:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737591811; x=1738196611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MkEtBhWCxhlln/nkrMfjHbQdVAW/I3csf80FLWugeM=;
        b=YM8BBgm03xhxkAEXlzINMPetUbkpnVMbDFldzaePcaHfvAhMr8aF2fDgMfXO0/4q5m
         Ag3Jyx64OPnZA+CwktDj0AaUpEzKmiEGSrLpZkWIwFA7wfEDagNilN8lDSymsLueNVlN
         dM8/ER8XHbqbKOOuYy4RefIMqM9F52K73nvnWKqyJyl6aeNCctonqU04o29pesOkNFZV
         6/XntCCEJcPzzTXvQVgEufSMZK+aqX/03UNZ5N/c9SvxM4rvGXayQOiD90M3IBCvbJox
         3bOnp35Mu6AbMofhBDoQ2Dc85qI96BHelZgrQ5x7d44AyQQilQaBDD7GnU5Mb6TF9aIu
         AkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737591811; x=1738196611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MkEtBhWCxhlln/nkrMfjHbQdVAW/I3csf80FLWugeM=;
        b=KucohtXLR+uDJjdjTlza+JpA2xb3ff+xoVh087P29OrTRGO463vMoAP3JMRUG8EMP0
         W8GJs90suPEzhh8/Bm9hYT5k/KYHuueEObTPgKe3/pTAnn1V1e2oJbl1ymBFPuPzOm5q
         fN0nmsR70+e+csLh1zHX3Bl7kK7oF6UgiZoRW7qRFJYs7joPUVpw8bSQWeXk58Xqybj6
         eaCuiAFaootF3T5XkxRHQ3doe7y0++TEyRMrfgRw0/MMMqtkIyU7wchqhcMzzIbNcH2h
         CGay0tgiJXPEaX7dE+RO0ktO6X/RYNyXuRDmR8QMasqgHonDWtpaLjOtesRWV0WDTUck
         iOkA==
X-Forwarded-Encrypted: i=1; AJvYcCVdmLULmhz+wLeaQLg+YDJv09eXzERqIxotp8xwVsFK9TO/dqfU5L5iGdRgCLmu8xnEEd8=@vger.kernel.org, AJvYcCXK/aKp36nVbAvPmiWDBwl0EbNDY5R8ZfX35meivjDM/9SxiOGuQqqk5X7X1qTFTBFtmdKAEu97HwwnYA6D@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/mqKmhGohLA/qaxK65Gi+CjfKfgLWi6EVklVvWcBEsF+dSZ1Z
	Hmm856RKDRHls/UcXxWNHXH1vL5+XI+dW7jvnnWVNseFzeV/EUh3Bg6UYaznl5UScsfOWWGgwyC
	cZnqhFD6LBIHCTk6StIWi+jV3RnFsZg==
X-Gm-Gg: ASbGnctGHbiZi9Io4vGUJ9lkPCHaawW0j5QK9K/TGE6avTJM+yJA8EKJ0m3YYyqEuAr
	UWcWJRLVXYrPX10Je6BwcyjRcsEEurzciOn/U0EzmT8Jdl7B6yd8yAj2/7mvpylilWY3sEAW8hR
	qn9sUlYKg=
X-Google-Smtp-Source: AGHT+IE3ENBSSIdZWvXcV4RCAHzFHdnl1EwufqPaTCFFwv0rE68iljYBZPFD+SbMlGCYbKhLXQezqMZdq8Xd8xZUSxk=
X-Received: by 2002:a05:6000:1a8c:b0:385:e5d8:2bea with SMTP id
 ffacd0b85a97d-38bf56639c9mr20494190f8f.20.1737591810546; Wed, 22 Jan 2025
 16:23:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737433945.git.dxu@dxuuu.xyz> <222efbc63de2519fd345e558cf27649220ccffa2.1737433945.git.dxu@dxuuu.xyz>
In-Reply-To: <222efbc63de2519fd345e558cf27649220ccffa2.1737433945.git.dxu@dxuuu.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Jan 2025 16:23:19 -0800
X-Gm-Features: AWEUYZmDAoEz7uMI_QtwpNGtl1ynTVIqVi9LENjh1xKU2x85B_xxZ8wwkSbKKmw
Message-ID: <CAADnVQ+eynNC0Hs0pd2adZX3Ryi3buAHkbvD3HT92Gg=ZJvDxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: verifier: Store null elision decision
 in insn_aux_data
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 8:35=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Save the null elision decision from verification so that it can be
> reused later during bpf_map_lookup_elem inlining. There's a generated
> jump that can be omitted if the null was elided.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  include/linux/bpf_verifier.h | 4 ++++
>  kernel/bpf/verifier.c        | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 32c23f2a3086..1bcd6d66e546 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -515,6 +515,10 @@ struct bpf_map_ptr_state {
>         struct bpf_map *map_ptr;
>         bool poison;
>         bool unpriv;
> +       /* true if instruction is a bpf_map_lookup_elem() with statically
> +        * known in-bounds key.
> +        */
> +       bool inbounds;
>  };
>
>  /* Possible states for alu_state member. */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 74525392714e..e83145c2260d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11265,8 +11265,10 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>                 if (func_id =3D=3D BPF_FUNC_map_lookup_elem &&
>                     can_elide_value_nullness(meta.map_ptr->map_type) &&
>                     meta.const_map_key >=3D 0 &&
> -                   meta.const_map_key < meta.map_ptr->max_entries)
> +                   meta.const_map_key < meta.map_ptr->max_entries) {
>                         ret_flag &=3D ~PTR_MAYBE_NULL;
> +                       env->insn_aux_data[insn_idx].map_ptr_state.inboun=
ds =3D true;
> +               }

I don't think it handles the case where the same call insn
is used with const key and non-const/out-of-range.
insn_aux_data will be sticky and incorrect.

pw-bot: cr

