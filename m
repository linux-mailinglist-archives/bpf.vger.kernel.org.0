Return-Path: <bpf+bounces-21732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB0F8512EC
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 13:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C17284432
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 12:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5061D3A1C7;
	Mon, 12 Feb 2024 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK2gtqlG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D0D39AE8
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739100; cv=none; b=Y8XQBIZ/XfLJHtB91cz6BpKkgcoAtelEVAs4f05cCjFGBdDEvefNbwzE2RY8YsUPQjydJSc8hyk6nq/RopPLbexPQl03n6tellLmuBTkpsOpi0QKimmgQqMInJrIY9hg8AfyuWbRDeGUGDFfgXUjy/PCNVovM8xDufrBiDCzqpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739100; c=relaxed/simple;
	bh=NCONwA8p7+gk6XZaA6lSqJbY4O0g+Ob2eF4QniRa1I8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmgESMo0xe2eSOml1nKJoEcxbg+9qJgNeP1iX8rUfPvCvEIbAfUbzbpekETOngw7Vj3Th0AWNTzPMqLsX2CBmb3KvttnadvC03vU+e1AyoGAOS78TKUojn+td5/uZAeEmwfCabnYKOTzVjZl+DXVeyxXJgLNbhlWxrojfhhBG1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PK2gtqlG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so541964866b.1
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 03:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707739097; x=1708343897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t9K7bGJVYvqqmuWvP3639VBhvRZmo29jADni8X7vX54=;
        b=PK2gtqlGr4v9cDIpcpA9fVdXfUuDiFHAKQj7EoT3Qan8k7y+ZlS8ruhQ8QBqTRb1CU
         k33qhq/qpkGoVIQBPErx1FzgtkkNHii36NUJPm8LlcwjdDEXw1XBP25Fyb0rMPrNKOPD
         3giywEhtf0pIsUAzUyJbM3uktOgsTWM4S3LNRFGQM4fgcj319Wf5Bg5PR0fola4w9jo/
         NjAcXhtV0miGIo5EIW4JaZs4iB9+HS6qxGbjjbHLHhpqwiJLADKgVe44dyQc+h8B09Ab
         NMkLu0UyHR+DR63IQDDqD1/TBeDspMAwk6AOtbCkCA8rqU+ToROwkZjaXak/fhRUonaq
         Exdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707739097; x=1708343897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9K7bGJVYvqqmuWvP3639VBhvRZmo29jADni8X7vX54=;
        b=r/ISsrbUbIMxgnEmH8pQhe9a7F5JaTO4xGGlHlFE9YNAdOviUejNE2UlklvowTVmWm
         9ngEinNOoEE/rsv+o60imVvOacQgeBbzmBnu7WD7hOzAe0j3uT9/v5Y8k3OPggfcLv4G
         B1thrPOTAeJ7dJmym37v7UtFRNRCSXn6GKMajum3dA3kZBlGlAWnOqPGbjSedlCArCEL
         5YaPv/jduNFxlq+qPO/9bpx0cFkZ1r8KhKueIkTgpdgjP/EruHb3RyCW7arKBLV7RArt
         xlgVq0lLzJG/e9WgHOR/ph38vDahzX5lAsTWye3XQjKPqg5nG6DiHn7zUVsnd4IqBS6M
         9gSQ==
X-Gm-Message-State: AOJu0YzG7DoK0WCylnC3/v87aWx4nTjAmy3fNj03Pl9vPHjjTjJU5+/U
	4a3KXOHpE8tUdIY+nOoJHmlMtDt/nLxkOBt3S1kThNbXwGScGPBya83wQxCL
X-Google-Smtp-Source: AGHT+IEL2dlgYy6fDITzIGW4I0GmzR0XR0QdfRnKJejTONk7ytz8l3ZPjs+2muCS78rzYDd1zGcIwQ==
X-Received: by 2002:a17:906:230e:b0:a3c:a655:379f with SMTP id l14-20020a170906230e00b00a3ca655379fmr2044027eja.24.1707739097123;
        Mon, 12 Feb 2024 03:58:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpWrI0UBrJ9nEPD6WrLl4/yUWJWFr6FE7aWt5oi9P30WY0F/wgYknfVq76kEAdERV22VHQ3Kt40vIbymMOM2uU5PD4QAq07bsEieQ0MB3Xl7qOt2S3Nb4+UBpUeaorTLiY/vWkpUwQug==
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id cf11-20020a170906b2cb00b00a37ad2c72dasm133829ejb.183.2024.02.12.03.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:58:16 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 12 Feb 2024 12:58:14 +0100
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, void@manifault.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] bpf: fix warning for bpf_cpumask in verifier
Message-ID: <ZcoH1hcJ2chyjLaw@krava>
References: <20240208100115.602172-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208100115.602172-1-hbathini@linux.ibm.com>

On Thu, Feb 08, 2024 at 03:31:15PM +0530, Hari Bathini wrote:
> Compiling with CONFIG_BPF_SYSCALL & !CONFIG_BPF_JIT throws the below
> warning:
> 
>   "WARN: resolve_btfids: unresolved symbol bpf_cpumask"
> 
> Fix it by adding the appropriate #ifdef.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/bpf/verifier.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 65f598694d55..b263f093ee76 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5227,7 +5227,9 @@ BTF_ID(struct, prog_test_ref_kfunc)
>  #ifdef CONFIG_CGROUPS
>  BTF_ID(struct, cgroup)
>  #endif
> +#ifdef CONFIG_BPF_JIT
>  BTF_ID(struct, bpf_cpumask)
> +#endif
>  BTF_ID(struct, task_struct)
>  BTF_SET_END(rcu_protected_types)
>  
> -- 
> 2.43.0
> 
> 

