Return-Path: <bpf+bounces-38318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647DD9633C0
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 23:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8564B213A9
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 21:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919D61ABED5;
	Wed, 28 Aug 2024 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwqI1Yc5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C513545C1C
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880038; cv=none; b=AV3prBSnI1HYjEuCbXY9qcib2wl4Q8m5crypS+tMq4At22XOHQsKboPeo++U3vq11Ce70kapPlVNK9k/cFkmYfj6O2UHB05ggIsuW0GUfbB+hKxg0WiQS07WCNVSvS6s+yge5Ty/+wbSvrkHij6CX9zU4bddXZgNuamE5+6UTPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880038; c=relaxed/simple;
	bh=kvDuwAOs7TCM40B45T0t5H69LrbW/urAXc0l8LDV9kI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VZWdxP30h76btObMFTUj105/n9b3X5LdNd4qZSlXuurP6ElfhcE6knt22h5SSkBtWerzYB9S4ZQO7gjzQyzpo0yU/qkBxAeaTHLbbo2OJavTpJ+xjOKZ5BSPjOMmne5wpY7V8StpLnej3203+/7MSwH0lvD4A8mfAN1Grw/RklM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwqI1Yc5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71423704ef3so5750321b3a.3
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 14:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724880036; x=1725484836; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n3hTMCTFK0/pctwJLG7Q3l3Ya58pKe3B4qTuXSlQk8U=;
        b=XwqI1Yc5EvBifZOIQtJbE7KiRBGbg/PFYqNeoFPj34JrW6oo+vr5O6JXDOW8o9RxGc
         /xTc538MDSoHlgn+gxtCRDy6QGMxh1dLukjVCjfNGZtwnKCFwI+ehReehSh7+mNwjRo1
         sfLsSLDpPzD4drlnp2yGEABtOlF2ItXf8Bf6Y1DBSbfWFaPedj0ST9hCl3+x8yY1N2ii
         f3I0SBVjpW7cAYTIN4NCELQjKxZSbXGaWg0+nYz/rUrMdfT7h/6YUXazH7GVJGIhdbvz
         kh08zpPp69LrlxKkNjXD4ogqNsnbfwG2n/AKwUZM4lDN6ZSTf5xzvMimAqs4UyYX/sXi
         D5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724880036; x=1725484836;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n3hTMCTFK0/pctwJLG7Q3l3Ya58pKe3B4qTuXSlQk8U=;
        b=rAZq3NIqQ+Ub7Jwlc/TO0ELHX03kAUi7tOvqT3RcLyNzBdkxkjVplR4Wa18euJFTKQ
         Jqwa0TTHKtmz6R27KcV03PuTl9hT/v7X2ZIbHdy7YgFHnoDeihhYew4F/DPM9f3h8ePW
         5wJcJmAGDmBQYlhpert1VtMuZBxract2Q3q4KMTymRFoKu2Tngw7S86DIgD3/q+8uPlh
         DlDxwJqAkL7WfVw/l9ONP3GmCkdPrB25NZVII4p6jIjMoGqssLpVjCDgLUUKw3Xc8a8F
         UG9GA3xFTJXr0+CSMXCaXHtINxnj9LOS5cK87IliqHjYWf6uocIohL+S75QjQMcICO+p
         f6Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVlgKo1DucLX9CMp7Nx03maMJZppB+f979iqwX98P+Uf53NBRNHOInhcAD/lJqdDGxrTJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+B90hyWSkJO2gpI2AQum6fkwX2uY0c+DZu/a3x9fxtr7zo70j
	6DT+bE+9R4l1QaTRrLAZ9Am3ZHv0DxdGPIYjGmONE8+l3GKw0GZV
X-Google-Smtp-Source: AGHT+IG7nVKMQGfb/UM1skURJ0qLGAUUUu0kS1mG1fT6I1E3GZjyYkg3k+FGSM9xphLKKi/HQRwLwA==
X-Received: by 2002:a05:6a21:1191:b0:1c0:f1ea:adf with SMTP id adf61e73a8af0-1cce1012c2emr753850637.16.1724880035911;
        Wed, 28 Aug 2024 14:20:35 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434315b02sm10526823b3a.152.2024.08.28.14.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:20:35 -0700 (PDT)
Message-ID: <ade54d9b9422e514f053ab38582a3758e6fb0325.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: specify libbpf headers
 required for %.bpf.o progs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org,
 andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com
Date: Wed, 28 Aug 2024 14:20:30 -0700
In-Reply-To: <20240828174608.377204-1-ihor.solodrai@pm.me>
References: <20240828174608.377204-1-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-28 at 17:46 +0000, Ihor Solodrai wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index c120617b64ad..53cc13b92ee2 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -516,6 +516,12 @@ xdp_features.skel.h-deps :=3D xdp_features.bpf.o
>  LINKED_BPF_OBJS :=3D $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
>  LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
> =20
> +HEADERS_FOR_BPF_OBJS :=3D $(wildcard $(BPFDIR)/*.bpf.h)		\
> +			$(addprefix $(BPFDIR)/,	bpf_core_read.h	\
> +			                        bpf_endian.h	\
> +						bpf_helpers.h	\
> +			                        bpf_tracing.h)
> +

Note, this states dependency on bpf_helpers.h and excludes
bpf_helpers_defs.h, however bpf_helpers.h includes bpf_helpers_defs.h.
Granted, bpf_helpers_defs.h is automatically generated so it probably
needs some trick similar to vmlinux.h?

>  # Set up extra TRUNNER_XXX "temporary" variables in the environment (rel=
ies on
>  # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
>  # Parameters:
> @@ -566,8 +572,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
>  		     $(TRUNNER_BPF_PROGS_DIR)/%.c			\
>  		     $(TRUNNER_BPF_PROGS_DIR)/*.h			\
>  		     $$(INCLUDE_DIR)/vmlinux.h				\
> -		     $(wildcard $(BPFDIR)/bpf_*.h)			\
> -		     $(wildcard $(BPFDIR)/*.bpf.h)			\
> +		     $(HEADERS_FOR_BPF_OBJS)				\
>  		     | $(TRUNNER_OUTPUT) $$(BPFOBJ)
>  	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
>  					  $(TRUNNER_BPF_CFLAGS)         \



