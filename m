Return-Path: <bpf+bounces-41269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7149955F0
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 19:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7C51C2574F
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 17:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B13520CCD6;
	Tue,  8 Oct 2024 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeXQv7TE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025AF20C498;
	Tue,  8 Oct 2024 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409596; cv=none; b=hp6JL6FaGfVvq3/reuquAP3RFVNLnE6yiM4jSZw57goQn/Vr1Br/02KES6UPYI4aqjQG3bwN0514c9xeSms70ADBN7t6JsgN7lqNSQpUlMi/j+lljW6DC9RcjBkMgUtiQRN4hj5dATGBV+7k2i6O7USixHuI9QNgaOhUgLhMs+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409596; c=relaxed/simple;
	bh=00RcSDQ5QOWQa6FBPeGWT/qT7CJH7Qs40/mQTyNy5u8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgNaxJ/vE57JgZCKWsJ8fRZG4yLo86cQPvJwQTbuy1FXR6XM/xch7cj9FHCcUrUj/hYIOUMR/CNAGfTFBXY/r8mNyedPkYUfgJBsqKBcfBH5yoWwyqwQg1YrYMn8olzT7tbsxMa9CvHFt+NeeaTVMp3eR2NA4MOJdqijYUByJRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeXQv7TE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37cc60c9838so28492f8f.1;
        Tue, 08 Oct 2024 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728409593; x=1729014393; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aFn8Ijs82v3ev2DjVxoJ4WsCFbjke8oB0jkDTciOX0g=;
        b=CeXQv7TENVbrpF9K/EoFUT+AnhCJYAUp/a5ZqMs/R+Og7xw/OdsuXZywVW67KYT4pL
         F3oY0e2D3ax5donE1UFrZewNTmCQQOkgXmQiWWUyUH342rdKxKj4I9G8GsVtQO1eQHVI
         3vxUvzyY69TVLycEjaRESg3qPHIY3ZEB/9AtRF6A3EG3PEJU5RliZPZx3exTVc1ZjK19
         M0j1Fydb6Rfl0pSQmHLrRMAbHw74fLiFCc2HgIHiMIPUs5MaVlJLHap+fTgjg2Z1KgDZ
         eE4am8uaydlJx4SlepoZhQh0pzCR026GsOIunP5wlbzzM8U4l2jkYCMMgq5Di86xH5PW
         5+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728409593; x=1729014393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFn8Ijs82v3ev2DjVxoJ4WsCFbjke8oB0jkDTciOX0g=;
        b=Oq9Fnp2CKA6Gi7vgbPUG9hkcNHpu+sltoyWjJxq5zpOu80JM+iD05hYdh6z8+GR3dg
         d5z1npU8dpJ9hN6Zbo+WsaE+cnm4q/8M+uLSvejJULNGdi9VjOIo/vQQ/N9yjznBTNOI
         lii0CfqcJ4LRQ/9TtUFfr8mcB+3GZ8PWmaiN8qaHGJE6zgPaKMWDwucLzRGhvar+/v1n
         CcXyEYeyZ7EGFXgpCwEJUWhxUF8MRCcYaWwKRn9yJTqi4ylUVrKvtJXlN+9Wvwakt9/V
         7AJc80F8t7SWmlBTDarAL1mmidxu8jwMUuFcoy/Ds+uwTG+DMsoJaQs+TVW0XBicxLXH
         RtCA==
X-Forwarded-Encrypted: i=1; AJvYcCV96vU0BVPtBuraZ9Nv0CunColQVSmbmm3Z8wIuT5qC8c0U+dPsT8THUfp260QanPyGXDzr+Zbg@vger.kernel.org, AJvYcCWg47f+G7I6ul0SOPzn5mmMMKL+Xm7Qw62HQkVi0d1DmDXupuhh4uhdE20PKvmLuu3oobg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2kBAmvc/PwTuGSsLrzehnwx9E1NNmPb/H3EtwLgwnRwBNb+D
	OKKmj61Xq4JPeE0bPD+vDlE3QWay7FMzeTdJki0UMNLBjdd0tz6O
X-Google-Smtp-Source: AGHT+IG/ysLouLqZ2ZYxJh9aXigMpDSbgZVLgg/68llLeMIiT8SsvSqf4POD5yIRn9X57wXz+kxPUA==
X-Received: by 2002:adf:e387:0:b0:37c:f561:1130 with SMTP id ffacd0b85a97d-37d38b07102mr634669f8f.18.1728409592866;
        Tue, 08 Oct 2024 10:46:32 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f1cfsm8526194f8f.10.2024.10.08.10.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 10:46:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 8 Oct 2024 19:46:29 +0200
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Simon Sundberg <simon.sundberg@kau.se>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf 1/4] bpf: fix kfunc btf caching for modules
Message-ID: <ZwVv9XR9kFCiqvx3@krava>
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-1-dfefd9aa4318@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008-fix-kfunc-btf-caching-for-modules-v1-1-dfefd9aa4318@redhat.com>

On Tue, Oct 08, 2024 at 12:35:16PM +0200, Toke Høiland-Jørgensen wrote:
> The verifier contains a cache for looking up module BTF objects when
> calling kfuncs defined in modules. This cache uses a 'struct
> bpf_kfunc_btf_tab', which contains a sorted list of BTF objects that
> were already seen in the current verifier run, and the BTF objects are
> looked up by the offset stored in the relocated call instruction using
> bsearch().
> 
> The first time a given offset is seen, the module BTF is loaded from the
> file descriptor passed in by libbpf, and stored into the cache. However,
> there's a bug in the code storing the new entry: it stores a pointer to
> the new cache entry, then calls sort() to keep the cache sorted for the
> next lookup using bsearch(), and then returns the entry that was just
> stored through the stored pointer. However, because sort() modifies the
> list of entries in place *by value*, the stored pointer may no longer
> point to the right entry, in which case the wrong BTF object will be
> returned.
> 
> The end result of this is an intermittent bug where, if a BPF program
> calls two functions with the same signature in two different modules,
> the function from the wrong module may sometimes end up being called.
> Whether this happens depends on the order of the calls in the BPF
> program (as that affects whether sort() reorders the array of BTF
> objects), making it especially hard to track down. Simon, credited as
> reporter below, spent significant effort analysing and creating a
> reproducer for this issue. The reproducer is added as a selftest in a
> subsequent patch.
> 
> The fix is straight forward: simply don't use the stored pointer after
> calling sort(). Since we already have an on-stack pointer to the BTF
> object itself at the point where the function return, just use that, and
> populate it from the cache entry in the branch where the lookup
> succeeds.
> 
> Fixes: 2357672c54c3 ("bpf: Introduce BPF support for kernel module function calls")
> Reported-by: Simon Sundberg <simon.sundberg@kau.se>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

nice catch

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/bpf/verifier.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 434de48cd24bd8d9fb008e4a1e9e0ab4d75ef90a..98d866ba90bf92e3666fb9a07b36f48d452779c6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2750,10 +2750,16 @@ static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
>  		b->module = mod;
>  		b->offset = offset;
>  
> +		/* sort() reorders entries by value, so b may no longer point
> +		 * to the right entry after this
> +		 */
>  		sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
>  		     kfunc_btf_cmp_by_off, NULL);
> +	} else {
> +		btf = b->btf;
>  	}
> -	return b->btf;
> +
> +	return btf;
>  }
>  
>  void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab)
> 
> -- 
> 2.47.0
> 

