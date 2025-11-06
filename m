Return-Path: <bpf+bounces-73800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA66C39F39
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 10:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088E51A419FA
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D6B30CD87;
	Thu,  6 Nov 2025 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAMyuG7J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ADE30C345
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422894; cv=none; b=hQU/KmU+C+iJgTnyKvJD+QPABu3Vi2B3cg6nn394Gw6xu23vvJOH0vFXWNDDDjtPEIRYlD16S8kvjFCzAOON6X5BVdX8DNWcJFtk6kDtB1dIoVTi0WGjyXwseph9QSyfNhYTBfNTp4Zj77RpNx04FFLTjJotNIDyGehttuviGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422894; c=relaxed/simple;
	bh=hkzp0rrjz3hGT96WzpjKOM/fKyhYg50nPuzQ5WoWmB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0sLWTSarI9pODor4Yjd3RisUuC5qO8SxeFj/LRWkK7HWPlSrNAy4yNTOhvlKGgV3EzrvxmMFtFL0MfakMEp/6Igf06AsKESdeyNP3PcuTfzIh5Hm0EWnkAt2LbTAW6nH8BUf/IDfElHMvfLnZWMpv68AArcZ+YrKCDO5ReBroQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAMyuG7J; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b70fb7b54cdso132960466b.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 01:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762422891; x=1763027691; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1onzjqP0E/lkEkmysCkSg3dnBeW6xsHh/HkgpgUnMF8=;
        b=fAMyuG7Jf2p0bW/5JXi+jqNyQZAgOer3sHk4Wsb9UYy3Lj54UtURCA2A2z6TbClIal
         y146J886z3WG5Qa5S+SN+mY6I/Huqme0OgMEhUP3vBP0gj3PkX50YFv841KKiSqo8mYc
         J7BfTWz6tZfvn+RHLvvDvAExCHxX2lyjOW2PtmRhMgy22NXE6ewjit7sLO1fIChVPTcT
         /URAOfBnntUAQWNBi6+0m/HgIy70B/9b/Xuonv+fNwP11QwvJVo5UCBFdxCQFzLNOXna
         51VAb8KUv3i7oMebEpG4guOwzF/mvmwFpk+x45022k3WiBjcq87qPm1I1VeSichTiVEO
         /Rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762422891; x=1763027691;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1onzjqP0E/lkEkmysCkSg3dnBeW6xsHh/HkgpgUnMF8=;
        b=dHwaDfr1aJ3ftju79o456OxclBKt+uB1mz11WkRl9C5J4MRsfnM6bFFBr5r2RbOCPd
         t2t+KuYGbvRT1uOufmc0CuELRo40PN8zvSsjrWzP8u8zLE8QS6UZNHl7+mwrvB2wN5AK
         5rcMSZlm2U3uc/ZXBCa9Igu6o/JR0ljvLTrd5VditA2HPqgWAZuq7DsxUzsWFnK3NMju
         TwxTad0ee+2f8ne9Vq5G04JVSDJ/Jn9kKpBX/4w+ZJV46c4zzGagz+awfadUwuRc/GHU
         4pX3TWM6LYjiWXThy1gIdMC9lILs4uY6jpcqMu3W90WObEHJBilOyZR73LdkhBanVHCo
         lOag==
X-Gm-Message-State: AOJu0YysEhXChvYAx8xtOej2rLouCzka8r2SnU+A+ndLJJAHhFfJvSrs
	RUiu6U3IB/djD5gHrpSH543iOrldrjIefbQK9V9dczaVy00R8CwtaU1M
X-Gm-Gg: ASbGncvmYLyo1CdgUFonegH4OnZXUBBnyLfvN2UP6JNNZgWEXmaka4sTJimNV6T2w/9
	Wx/dUYyzHUJmLNSQZ6NPL3B1Xj4jN1v0K3Epq7TD+0PSUk1OVcjlRh8EfCATN+K7/VbfN8pM84G
	Id0XAwZYnC3ZLRtFvl89wT6PwLQmnEkc56lcfSc22EbZnlNeo0/mnmANApvnxnkRQi9WYM3N/kj
	q3yXCjJIMqu4gdPqKqKtfyD0urO2/nlmTERzzZ6XluB4nUTKQCWFXuNSUyG87l8WcG78LFQQIJu
	XsMmcvMVV47ph6W2zGUkkh9jFO8aS2XCN6kSyFRtJUE5g/R5u4LwF2kc/OkzekKmJGBSNVudMOF
	bNCJE+Buj615tONNfDm9eeOFXpR2DIVuHOQO0DXj7+/vpyUrizukP34YfovBMFyGpySOoUWOmd1
	36GqxrLsHLiQ==
X-Google-Smtp-Source: AGHT+IFvNLOK1VgBZHrBzOcuNDWdT8jVzYI6HBGE3FLrRpUiyb83VCXJSROHa3m3ivMGrbIvqVbQjA==
X-Received: by 2002:a17:906:dc8f:b0:b72:8a4e:8fb9 with SMTP id a640c23a62f3a-b728a4e963dmr308843366b.7.1762422890506;
        Thu, 06 Nov 2025 01:54:50 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896c8ee6sm173292566b.67.2025.11.06.01.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 01:54:50 -0800 (PST)
Date: Thu, 6 Nov 2025 10:01:01 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v11 bpf-next 01/12] bpf, x86: add new map type:
 instructions array
Message-ID: <aQxx3Zphpu43l1/p@mail.gmail.com>
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
 <20251105090410.1250500-2-a.s.protopopov@gmail.com>
 <CAADnVQ+MmpDpSsQZW42K3nozcuM5yJMRRZRABjiTiybNQpBJRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+MmpDpSsQZW42K3nozcuM5yJMRRZRABjiTiybNQpBJRA@mail.gmail.com>

On 25/11/05 06:03PM, Alexei Starovoitov wrote:
> On Wed, Nov 5, 2025 at 12:58 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> > @@ -21695,6 +21736,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> >                 func[i]->aux->jited_linfo = prog->aux->jited_linfo;
> >                 func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
> >                 func[i]->aux->arena = prog->aux->arena;
> > +               func[i]->aux->used_maps = env->used_maps;
> > +               func[i]->aux->used_map_cnt = env->used_map_cnt;
> 
> ...
> 
> > It might be called before the used_maps are copied into aux...
> 
> wat?

It is called from fixup_call_arg() which happens before
the env->prog->aux->used_maps is populated as a copy of
env->used_maps.

In any case, I will take a closer look and follow up on
this after Kubecon (which is the next week).

> on top of the set:
> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> index 61ce52882632..97fcde6d7f07 100644
> --- a/kernel/bpf/bpf_insn_array.c
> +++ b/kernel/bpf/bpf_insn_array.c
> @@ -278,8 +278,8 @@ void bpf_prog_update_insn_ptrs(struct bpf_prog
> *prog, u32 *offsets, void *image)
>         if (!offsets || !image)
>                 return;
> 
> -       for (i = 0; i < prog->aux->used_map_cnt; i++) {
> -               map = prog->aux->used_maps[i];
> +       for (i = 0; i < prog->aux->main_prog_aux->used_map_cnt; i++) {
> +               map = prog->aux->main_prog_aux->used_maps[i];
>                 if (!is_insn_array(map))
>                         continue;
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1268fa075d4c..53b9a6cee156 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -22096,8 +22096,6 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>                 func[i]->aux->jited_linfo = prog->aux->jited_linfo;
>                 func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
>                 func[i]->aux->arena = prog->aux->arena;
> -               func[i]->aux->used_maps = env->used_maps;
> -               func[i]->aux->used_map_cnt = env->used_map_cnt;
>                 num_exentries = 0;
>                 insn = func[i]->insnsi;
>                 for (j = 0; j < func[i]->len; j++, insn++) {
> 
> 
> all tests still pass.
> 
> If I'm not missing anything, please send a follow up.
> 
> The plan is to split prog_aux into main and subprog,
> and subprog will be a fraction of main.
> Right now we copy more and more fields for no good reason.
> Let's avoid this.

