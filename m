Return-Path: <bpf+bounces-72612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7A9C1661F
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 19:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77F2E355DF2
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 18:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B55034BA5B;
	Tue, 28 Oct 2025 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs3woLT9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EAB23D2A3
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674731; cv=none; b=Eq5CZhnGPt8Md98sstUsGNenKzUPdLggbrh9XPnfTGwkofZEmlNenLFyHpNYXlxQa+qxeN8Cl9WW9C1hQEAAKYcsANZbCv5yIQbJkScfvwZx8UlVi54+apJrmMtdsTusnhI6szOgf0z3NXcmUyr7wp6iPqPdXTFqa8ZQ89801h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674731; c=relaxed/simple;
	bh=cn/C25Rbz1g7ApkaIAu6c0yNtzInMistPhKCeEWzQMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsrUKPl68qNjOdQGv80KPRrBejRo3acKVUAq1tmpO5VYvAyWqjCJ4AshE00kZMKNNe2f0xZ2Yc/Dusofsrbgn6kVHBQcRyIGSmfhSN+pMoG/I2AHkH0gcRJAuG1aLO+UhZ+5VRN3zhHFHzkjMeI9FYcpHv/ARL7jxkgjMwdWQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hs3woLT9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34029c5beabso1365299a91.1
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 11:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761674729; x=1762279529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yk6w8rVYaZcWTSTnE7iPwtQqPowVrL1jgYD+HQnj6UI=;
        b=Hs3woLT9P6CfNwm6zmoW+BWsTMRdxwHNk7VjdvMXUUiCmeQXpYIvJaMWXvFTOce+zk
         0bfeZVdepvmZ7wv+7fNtNDG7qCtWrqtlN+cITVFnlgUZfUa4Jo4ulrv9yWXbNUVlabls
         gwwGrEvQC7ZYHuQXfHV6Vm064uKRQH9gFU2eHAb5CuIfy/m1y6m2Nq1K17nbKHZeleXE
         06mr2thlk6C7dKfAY4LYZhg1NpB7SoPC1eS2MinA+jFTlk4siQAt+CxhewBdIQJRpDTU
         iupTW7KDxwKfna+LK2sHSYs6SEGmitc53H7cBwtuh2QhFatxVreUCODKHT0ZxIb1OW5z
         VLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674729; x=1762279529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yk6w8rVYaZcWTSTnE7iPwtQqPowVrL1jgYD+HQnj6UI=;
        b=iDggaBEnXXSL3we8nReBu8jF7oqo0WZU0hpYp6bxsKOX+N9clwPI847PCs7Bj+1g5j
         n5b1IJGNIUPVfFteG6+fH8eR99mYgeX4GDR2QlvsZR+TRDa5PmLlJHtb4bOFTw6RAf0w
         maMnc2hJ3MwpQcfpd8VPMd76yi01q10+CCSDYyQTRUIx98j3rvkVtDSDPRuzroms0UEQ
         0o+d4b7X30YEThpNN6Z16e/58woF/KJ3jKRiE2DPAxMj8t7mm8hGiDruWjs42fxi/2gI
         kgSitm0e3uI55FwvBJNOuHf2wDfLjMwxBL94lOmqaWuhRjjnJ/Z2XXcHw+Go9H6h0iTi
         JE5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlWORlNr7qLzpwbVYdsB8d6fMhXwdOx/EdnM8Q7AhBt4kfDEHlNQsM3p1b+Ig5L1Ler9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2h58kEC1u282VPfC9hRBPdNYf10TABjNIev1H/9XYTBEeJjAE
	9kdzCTHJ7UliuS90dNxbpnfgkgl0hxsG+zpuifKGaBA/UPYcyz8HeXWhlfUbxIL8ocKhGxhOJ+A
	coFShe5UNS7v6fJomaRsS4ujQ0Ms0vd4=
X-Gm-Gg: ASbGncszwjV2UQNszSBoHOUlXwdHWFJDFzEuH7GWGKOePEXIAlabZRqo2/A02uy0nqr
	q13dwB5gI7ZbWO5OiXRtecaaz+B600wfCiKA02WOD0cC62WK90PpUtlXMvU427IYps+MqeGc7bg
	i/WEYM47veoWF6CQeYptV1wawKi0nEf06mE/CM9KnFn5uGYEs7xG3XihxVxPSK4MGao4qf/Mlj4
	ZrE5T6h6Urd7u2vDtX5hgM2MvP5v2BWI75AveqobfgdgwdUFbv9+JstKer2yoyQM5OaogQE7/65
X-Google-Smtp-Source: AGHT+IGDWFPgY7P0J0rgoNRTpXkV9IpxvVzPeFO9NpOmpx7n8IIeQPH2id5pD0zxVQQqtPdTX8VbDivieGgcF2cpwKU=
X-Received: by 2002:a17:90b:58ef:b0:33b:c5f6:40ef with SMTP id
 98e67ed59e1d1-34027bda889mr5099562a91.24.1761674729195; Tue, 28 Oct 2025
 11:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028135732.6489-1-cuibixuan@vivo.com>
In-Reply-To: <20251028135732.6489-1-cuibixuan@vivo.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 11:05:14 -0700
X-Gm-Features: AWmQ_bkJMeV6sNPrCRGI7CcuEc5yewkxYrithOiGgXmBNzkm4G-mk86H_tT3dWE
Message-ID: <CAEf4Bzbp2FYvTVz6SStj_p_ok+LLeXEAxcUiCkyWRf3wyjwi_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Ignore the modules that failed to load
 BTF object
To: Bixuan Cui <cuibixuan@vivo.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 6:57=E2=80=AFAM Bixuan Cui <cuibixuan@vivo.com> wro=
te:
>
> Register kfunc in self-developed module but run error in other modules:
>     libbpf: btf: type [164451]: referenced type [164446] is not FUNC_PROT=
O
>     libbpf: failed to load module [syscon_reboot_mode]'s BTF object #2: -=
22
>
> It is usually skipping the error does not affect the search for the next =
module.
>
> Then ignoring the failed modules, load the bpf process:
>     libbpf: btf: type [164451]: referenced type [164446] is not FUNC_PROT=
O
>     libbpf: failed to load module [syscon_reboot_mode]'s BTF object #3: -=
22
>     libbpf: extern (func ksym) 'bpf_kfunc': resolved to bpf_module [16444=
2]
>     ...
>
> Signed-off-by: Bixuan Cui <cuibixuan@vivo.com>
> ---
>  tools/lib/bpf/libbpf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 711173acbcef..0fa0d89da068 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5702,7 +5702,8 @@ static int load_module_btfs(struct bpf_object *obj)
>                 if (err) {
>                         pr_warn("failed to load module [%s]'s BTF object =
#%d: %d\n",
>                                 name, id, err);
> -                       goto err_out;
> +                       close(fd);
> +                       continue;
>                 }

It's not an expected condition to have kernel module with corrupted
BTF, so I don't think we should be doing this.

pw-bot: cr


>
>                 err =3D libbpf_ensure_mem((void **)&obj->btf_modules, &ob=
j->btf_module_cap,
> --
> 2.39.0
>

