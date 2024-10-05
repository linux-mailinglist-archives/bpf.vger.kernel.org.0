Return-Path: <bpf+bounces-41056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D16991710
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 15:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2A51F227E7
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 13:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B2713C3D3;
	Sat,  5 Oct 2024 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBtNq19g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C1213C8F6;
	Sat,  5 Oct 2024 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728135930; cv=none; b=GpZMoxxR7QNv/l4duxbmMXRBbtIEWCOYSGOPC6NCWhey1nBuZFUlJFYHK+7b1KVCp7KE0msPXIFSGGHbk803dPuengibzuObKtoNYMXQH/qgV5nt2oS5/Zf7E4n7EO2Pi5Zfss9swLGsnz+0mA3iQxktP+ykMr5VpwUyEZAEDlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728135930; c=relaxed/simple;
	bh=6WMCleyRf9rkTC7gpicSmXoOJzsha0XAiXyxm4lH0Vg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8pylDCRjECzr0c8DdXjtOdn98g24R0TJu15F7Jsc/Rov+gytBjYXUxHUnlFjIKld1zSFnZRfWCKhUa3FT0IsHxOOiLUq56i9wqYHjiqFlNMhpxPMJpe9HDwj0fOAtAtCHAC1yVm6/i77gkfRYJ8d1/qLftKoGCQXeU0DOZ1n4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBtNq19g; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so502529266b.1;
        Sat, 05 Oct 2024 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728135926; x=1728740726; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kx4yHJPGBMBusL2+jeuSBsTQGYeHDWUiK8Vz71jCsnA=;
        b=HBtNq19gn9CIlORP6VpK8JD2xwk8i5KScTrqJYcWmC9irdn0gxFTD5luei+IM7/Bqq
         x5iX3q3GjcQ1MfqHDbsi52ByUepz+hoyIRerhoHL5GmsgHde1JG2WOWREfMJLXIu99oi
         9x7mibhnfSLODAIAUJ1uA9vD0awp1VrghCa4alZgYumESe08Kci/r4hk+4bqVP/xxi9I
         NtyKTYqa5+UDnQ4LNoCWR4a7v516HTYv8HrNE+UiZrIk1jZaL+IAzdp+ZGzDA5tVBUyo
         SL2TREJO3DnRuDaYE3//M8rvkuGUadDUXlVY3UUHfvzi8SM+cTcOvvBdFf5+8zjMUe4o
         GbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728135926; x=1728740726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kx4yHJPGBMBusL2+jeuSBsTQGYeHDWUiK8Vz71jCsnA=;
        b=WWbrgPH/hB8YnB+Bn9ggwVt61HFLfqNm479HNXeVk4euDOUJN0nphowEQ4Kw4DaoB0
         4e6q/vsX42f+4VlIXN26eQ58RvUmJ7vJBXt/4DdlmTvfG3lt7y9z4bC2sDWxwTaLRmGw
         VgczDmHXB3DTwEw2h7SkiRk+R1XEGhctFsekQFFH+dTcI/qCu9nByNcbRdpBS+0KXy+9
         GXhy9+czn3MskcATo2a0ASvOMXmhEkyLT0Kr3jJCyk/XmW+S19zQjGmHiyx5zOwpwNhO
         VcLxTPsHzJsEoevTv96wraNpJtfmCOP4G4z3Yn0QCuAqBuxXJVUhBEX6CFaEBm7yNKVn
         9vdw==
X-Forwarded-Encrypted: i=1; AJvYcCVLz7aEofRh/5Lc4xaxFcLvyhhvc2eGpBOE40uR4+0hGsrgQrCyDQ2XdSw5w4LQfGhu1O6lbdEHpxXGWFFI@vger.kernel.org, AJvYcCVf/TKstbbu6YOJJ3kRZKp+1rVPmSJ+aD1JLen0jaCXzFfTybOKuuF8sLA6vFDOK63A8a0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg7t2wxaSgAyrsL0d06ZyrTwwskmAjh4F6n/LGgtTtdNXlAI2t
	/jRedpWpuGycPW2kqFwWi/cZGK9JOBfiCgOFr8Gj/a7Xdk2DPv60
X-Google-Smtp-Source: AGHT+IGEpWpCDACNRAEu30MNVIKtG/hJJxxoBLsghEuDe35isIBnrPXgxEeDiOjY/mAC0CF5YpPX0Q==
X-Received: by 2002:a17:907:e668:b0:a99:32f8:781a with SMTP id a640c23a62f3a-a9932f878bdmr236709666b.61.1728135926199;
        Sat, 05 Oct 2024 06:45:26 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e784ee4sm134046666b.105.2024.10.05.06.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 06:45:25 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 5 Oct 2024 15:45:23 +0200
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Paul Moore <paul@paul-moore.com>,
	John Johansen <john.johansen@canonical.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf, lsm: Remove bpf_lsm_key_free hook
Message-ID: <ZwE_veRD7f2ir6mS@krava>
References: <20241005-lsm-key_free-v1-1-42ea801dbd63@weissschuh.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241005-lsm-key_free-v1-1-42ea801dbd63@weissschuh.net>

On Sat, Oct 05, 2024 at 02:06:28AM +0200, Thomas Weiﬂschuh wrote:
> The key_free LSM hook has been removed.
> Remove the corresponding BPF hook.
> 
> Avoid warnings during the build:
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol bpf_lsm_key_free

nice, I was wondering about that, lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> Fixes: 5f8d28f6d7d5 ("lsm: infrastructure management of the key security blob")
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> I don't know much about LSMs, so please disregard if this is wrong.
> ---
>  kernel/bpf/bpf_lsm.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 6292ac5f9bd139dafb39ecd8bb180be46cd7c7fd..3bc61628ab251e05d7837eb27dabc3b62bcc4783 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -339,10 +339,6 @@ BTF_ID(func, bpf_lsm_path_chmod)
>  BTF_ID(func, bpf_lsm_path_chown)
>  #endif /* CONFIG_SECURITY_PATH */
>  
> -#ifdef CONFIG_KEYS
> -BTF_ID(func, bpf_lsm_key_free)
> -#endif /* CONFIG_KEYS */
> -
>  BTF_ID(func, bpf_lsm_mmap_file)
>  BTF_ID(func, bpf_lsm_netlink_send)
>  BTF_ID(func, bpf_lsm_path_notify)
> 
> ---
> base-commit: 0c559323bbaabee7346c12e74b497e283aaafef5
> change-id: 20241005-lsm-key_free-b47445ee523d
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 

