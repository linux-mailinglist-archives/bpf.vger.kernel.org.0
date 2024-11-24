Return-Path: <bpf+bounces-45547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0239D7818
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 21:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287E3162433
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 20:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B330A1514CC;
	Sun, 24 Nov 2024 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki85Mn4d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D92500A7;
	Sun, 24 Nov 2024 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732480421; cv=none; b=KMTJ2qBjjeEClkSnMLs8LvHCtvB65vcOVBde808o4Ezd+O0SuNOAZMpSLRrhA5GyIvpsqyPDQWxbUMZR/4xp4mLWhFPUV7/qq2GqO+qFiJjDlSGpVWsfQLPknY6TAv3yiPBoEn20Viq/ekNHEJ68r6bX5LSUYsqwi8UA3pLnW24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732480421; c=relaxed/simple;
	bh=orb+6Lh+Mvw+UsIrrtvkhg2HB2Y2dNPiP69h9SJhSV8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+kFoI3TPRhRYTUr7kyL3dKbOSA9WIFVbN3LeL1AZ36MbTxp6v2j9DVkbfRzY5oVhjQ91K6KrOfqIfc/38J1Dvxl+bvF6bxUZXRz87Xj82OMvQR51YVI3Rv/1LgAI7Gn0719OrQOy+BiGOrne7NMtc17F5mUP9IJp2874YhZutg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ki85Mn4d; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cf7aa91733so2177229a12.2;
        Sun, 24 Nov 2024 12:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732480418; x=1733085218; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qQ2bcCYDEj5ivdxpDRH7IqA9H1fx7+TQGm6qz9vLT0s=;
        b=ki85Mn4dAiMrrEYihePN7UhIfyBIwMDoTdXxeuIEsr388lkjBh/wEM1z5HFfsV5mdt
         zquLi7Ut8KziX33ckutdFpcygerm8G8QQdjllWVqxBaIrmVUquWRv+bBEVvD9Oj3WwMy
         iXTnexJDpSa6GNvIjJlzetqsUpyh2uck42O7DEUoUEURGpou6LpHjNC0zGozbMJlB7Uo
         CNd0DjY+L3c5g4l1JzH3628yHRvsODjeIUiQDv4vA7WdyBoCvoIPD16yhGTkXeqRtCI7
         YVa6pkdFCxYCQbroUC5Z+lmfzPBDwgU4M/9ca5yt1OXskCeo05ACrtYMtkbE5ZO57tLu
         Y1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732480418; x=1733085218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ2bcCYDEj5ivdxpDRH7IqA9H1fx7+TQGm6qz9vLT0s=;
        b=repLq5Tg7poE3sCfgTnWIujWNbwAAMVjV7z3iAa1n6Q8ufOdyl5pnsjLFnPYNu/fQ3
         3G4pO7kLl1ugN2VnVH+UAyMXJSx0OqkMY9BtnciD730wohmHuK1/z/QCNMSZHnmTKG0K
         5Rtp3hhfjJkUa8HiYn5cLOBL0QqRHF4mws3FW7pan2zGoXkTMAfkav5lHEU+nnzUvzjF
         0TAKN7/jh6iwOA3WRIiVofGxOd5/F64g68ZQ0//ychRSymriWFjUdn9iDQuVLTLiIDt0
         Kg27nv5SgCj9denf/pPMogq4Su8Z/ebobVXROl8hPVnbiOvYPOkMnecFuVjtryM30wK4
         xo/A==
X-Forwarded-Encrypted: i=1; AJvYcCUJ9NzuxX3KfLNPna3fe3T8D3gSWoAVT6tU5D51S+VlOmrAbwIZtBFehdhHC5pXfkR3jjI+6/SAq2Rsm9XJ@vger.kernel.org, AJvYcCVB+0d2gFdvgp8EJsf9erqoB8XSpaapW8XZbZsN4WcWZAqt/T21JCQ0OFOavKFjeplEiy0=@vger.kernel.org, AJvYcCWxyzaGGrqO3DE46Q92vGyw/55DmO9k8o5FIbGXBIwItWQJjxJHXXjFuQPj2MF7pDDXkYV3eFgDVjcm0JS4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvwb+/wpd5bqWe2GNgeM9siv7IyeVrPpLa1eYepNpr8yCKl96g
	1GzKEEeVK23GZCjifgqmDUoZcQVVjXpb7FSduMn7NDkkHqwNmT/k
X-Gm-Gg: ASbGnctHWb6CtH6K7HnetxpAubSVpXZmx2+aL7rRDDEmcRX/4PqvMmlRm11S4gVQYf9
	EULc52nHSzkXSPzKLREjSlifFTsXQ8qyeove9zkbzJcmNNw8YlI0itNZj9yoIIgrYP3wTlqcSMl
	dY4mUxbzZOL2uvTQ2QVtbn0ibfxwqz5N6cmDlUdq0LEVDSird9FllFbVnIl+a4Z+VrqRoLieX3T
	WqaoPj/jnjb4O/dIRTY8rYLk17JA/T+Ipw9oVDSaRbDtuofDo5CCYDdHLA=
X-Google-Smtp-Source: AGHT+IHjewQjkc1UmSFP7iWn3VpVAMGTmORHfXR5vI5QPYGQYQ94OoNTl37w+i596f67zZ3cMrSXvQ==
X-Received: by 2002:a05:6402:348e:b0:5d0:35ba:f12f with SMTP id 4fb4d7f45d1cf-5d035baf230mr8061427a12.14.1732480417629;
        Sun, 24 Nov 2024 12:33:37 -0800 (PST)
Received: from krava (85-193-35-130.rib.o2.cz. [85.193.35.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d401f64sm3346378a12.70.2024.11.24.12.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 12:33:37 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 24 Nov 2024 21:33:34 +0100
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/3] kbuild: add dependency from vmlinux to resolve_btfids
Message-ID: <Z0ONnhIVK1Sj9J09@krava>
References: <20241123-resolve_btfids-v1-0-927700b641d1@weissschuh.net>
 <20241123-resolve_btfids-v1-1-927700b641d1@weissschuh.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241123-resolve_btfids-v1-1-927700b641d1@weissschuh.net>

On Sat, Nov 23, 2024 at 02:33:37PM +0100, Thomas Weiﬂschuh wrote:
> resolve_btfids is used by link-vmlinux.sh.
> In contrast to other configuration options and targets no transitive
> dependency between resolve_btfids and vmlinux.
> Add an explicit one.

hi,
there's prepare dependency in root Makefile, isn't it enough?

ifdef CONFIG_BPF
ifdef CONFIG_DEBUG_INFO_BTF
prepare: tools/bpf/resolve_btfids
endif
endif

thanks,
jirka

> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  scripts/Makefile.vmlinux | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> index 1284f05555b97f726c6d167a09f6b92f20e120a2..599b486adb31cfb653e54707b7d77052d372b7c1 100644
> --- a/scripts/Makefile.vmlinux
> +++ b/scripts/Makefile.vmlinux
> @@ -32,6 +32,9 @@ cmd_link_vmlinux =							\
>  targets += vmlinux
>  vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) FORCE
>  	+$(call if_changed_dep,link_vmlinux)
> +ifdef CONFIG_DEBUG_INFO_BTF
> +vmlinux: $(RESOLVE_BTFIDS)
> +endif
>  
>  # module.builtin.ranges
>  # ---------------------------------------------------------------------------
> 
> -- 
> 2.47.0
> 

