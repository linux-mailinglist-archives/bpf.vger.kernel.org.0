Return-Path: <bpf+bounces-45497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE3C9D6903
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 13:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6F8161520
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FED189B80;
	Sat, 23 Nov 2024 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDnWeUWz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0208F62;
	Sat, 23 Nov 2024 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732365428; cv=none; b=SjyicnSpgtk/iDnKpjwtdJDlyDtynjCeF6UBjXmz6zMCQcElRojdw7FdNo0zXssIsBPuX4Ee1ygR8iZDmZ+UbNSzW/PUn6CyesRWQgFdl8E/0s1wupUyiliBc0wCxYeucINK5X8JaqQ8WwPIi/Ruv2gPP6ThIj1/V+/dTaGTIjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732365428; c=relaxed/simple;
	bh=/KqLI+c6V+eHCk3PcyFlMtCqEsq2g5NGUwg4Z3SZNO4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSxrEXz/PjbZ7KyHq9SDdpK5e6SAD5lqyBTxSj+/LEKapLj5ECWI08obbcnJr2mxtzFukilmrG26s2FgYIbL/ccDLPV0n+XUpGvRCMAXFTAtN62S63ZnrWLmNfm4kmpR2Gkk4I/QvCkAPYzo12qm8qK5eoFdMcNegpW0bnbDY1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDnWeUWz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-431616c23b5so16589915e9.0;
        Sat, 23 Nov 2024 04:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732365424; x=1732970224; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j+FIYWNxDRo9TU3lZYYljtUtoA1ai5ejfbOQhPyfFvI=;
        b=KDnWeUWzG7cuHyquu8J075LbsAPTI8lJImB+IQ/n+8xJlUunWsDaRG7xEUA+g0MuUY
         klolXIGrFuUAXajcRLvUfWPi4lyxh1KUD3Uw5fMqLBXrvV5Kz1FrEveVyHs/9pLIVBQj
         4rlwtNoWjXK6SLQlG0+aet0GdiR/fy5MDEh1YizTw4BUBoFGNPYTz4Ad/dUbTbybUaTq
         yi05xwsXbkXdf0B2Me8aKkdVOMH4yAmNk8jqo426nmGslHH+UYueTwG69DkTucVzkDFv
         7FJSSwGXvGOIO8WvUBniWg8mK8GNYaWcy364ITnC5ZI7FLil9Bx3gqDxMEqyTvrvlqOu
         j1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732365424; x=1732970224;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+FIYWNxDRo9TU3lZYYljtUtoA1ai5ejfbOQhPyfFvI=;
        b=Dl4PfRqjud3HYnRqo+8lIiywsJvjcrUQapXWqV+ID8Wv3lCEfDaRb+LAKWCRU6fZgV
         /9eb5CKBC8lwP7bXx+rTipFve28peKTAQe38g3ebk0nLyI93q4pW/8166AAx58UyDbN1
         KkGnl4vT+ttyxip52lMp0BTe6MQ8O+I8VAGfG2selUTsdRP2znZoJ5EPY4kmuA/wMK6T
         IHUEp4kxgqSn1jkBwHd5Vok7YfEFXRLwovXGi2yRdU70kpohRFBl3Upkg6loiiJNv01Y
         1/KVI7lBJxQi75bBD18efB+jtnSSQgvo6eTePtFUvhh5+O9JuhiJOI5pJC0lBW+zq3TA
         ytMg==
X-Forwarded-Encrypted: i=1; AJvYcCWOH/0VzFe3auhXNqyPIHdNY5HkLZ+pv0lzHCe2pRtoDt3H/2dp6sHqE0aQYLxnzNP5TZF9EcLp9kjVZPLU@vger.kernel.org, AJvYcCX6lR4KNipb73OQ/yQT/ah6PAP7uDvEcDrEgtTTaEO2M7sZatjB8tmfn9yisHKdI2o1tZ2L@vger.kernel.org, AJvYcCXI8sN0DafD2sdmnAF35WATy0W9C/GBrnYJ/G/YaHS8AkmpgC3yLSrMMVCU6brJDsXCK+B5z3UQVQ==@vger.kernel.org, AJvYcCXiQOSZLg6Qut3EbvkRMqpNuH0MV9iPKnKMOy41ItDu8NTKZIoHTL8FLVK5KTf6Ypkch0WbaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa265K8xLZfcqovMrgEMcA4tqRrJMv4tSO/dWIcJ/yuGoUF0Uf
	e3izegQhrPpzePWfxxSYz1cGVNzZ+ZUPbHczt58kStHNldptlB9o
X-Gm-Gg: ASbGncsjZmwhfG/GYFoo9tvTWKYdmnRsb5f395JSjnDSjGLOvVwAP4xX4r5mK/LzC6l
	rthDn3dpvM1++W19s9g9zhWHsatrUKZzRP0DFAzFEiR0f/iGjL+rewiMIhzyvruPxFzVMpmn0gY
	wJVgiK/iCw5D9u8Sbmj3QvByWd2WchCqquoSNg4QXOQQ/Cho6VgWPYBbEgptarZO/WGHtm/9vv6
	TDzTW200egtMerJZHTJpulgF72QYODvRWahz/Yhcly6liXq1YFRjM1dpoiZ439dHkLHLj4=
X-Google-Smtp-Source: AGHT+IGHNtE8JDX0+q6Lv6PMJPfhfsNRALK4ZhqFSQb8QeR03JV46vW7ocE89UcLvWXZNiEP33bteQ==
X-Received: by 2002:a05:600c:1ca1:b0:431:559d:4103 with SMTP id 5b1f17b1804b1-433cdb0b2ffmr52512575e9.7.1732365424054;
        Sat, 23 Nov 2024 04:37:04 -0800 (PST)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43498a31432sm3012315e9.28.2024.11.23.04.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 04:37:03 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 23 Nov 2024 13:37:00 +0100
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
	Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH] bpf, lsm: Fix getlsmprop hooks BTF IDs
Message-ID: <Z0HMbErrqgrklLSC@krava>
References: <20241123-bpf_lsm_task_getsecid_obj-v1-1-0d0f94649e05@weissschuh.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241123-bpf_lsm_task_getsecid_obj-v1-1-0d0f94649e05@weissschuh.net>

On Sat, Nov 23, 2024 at 11:19:01AM +0100, Thomas Weiﬂschuh wrote:
> The hooks got renamed, adapt the BTF IDs.
> Fixes the following build warning:
> 
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol bpf_lsm_task_getsecid_obj
> WARN: resolve_btfids: unresolved symbol bpf_lsm_current_getsecid_subj
> 
> Fixes: 37f670aacd48 ("lsm: use lsm_prop in security_current_getsecid")
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Jiri Olsa <olsajiri@gmail.com>

thanks,
jirka

> ---
>  kernel/bpf/bpf_lsm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 3bc61628ab251e05d7837eb27dabc3b62bcc4783..5be76572ab2e8a0c6e18a81f9e4c14812a11aad2 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -375,8 +375,8 @@ BTF_ID(func, bpf_lsm_socket_socketpair)
>  
>  BTF_ID(func, bpf_lsm_syslog)
>  BTF_ID(func, bpf_lsm_task_alloc)
> -BTF_ID(func, bpf_lsm_current_getsecid_subj)
> -BTF_ID(func, bpf_lsm_task_getsecid_obj)
> +BTF_ID(func, bpf_lsm_current_getlsmprop_subj)
> +BTF_ID(func, bpf_lsm_task_getlsmprop_obj)
>  BTF_ID(func, bpf_lsm_task_prctl)
>  BTF_ID(func, bpf_lsm_task_setscheduler)
>  BTF_ID(func, bpf_lsm_task_to_inode)
> 
> ---
> base-commit: 228a1157fb9fec47eb135b51c0202b574e079ebf
> change-id: 20241123-bpf_lsm_task_getsecid_obj-afdd47f84c7f
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 

