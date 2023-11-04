Return-Path: <bpf+bounces-14210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148E97E10F3
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 21:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64CECB20F1E
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 20:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AC3C133;
	Sat,  4 Nov 2023 20:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PZhJTyxs"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A480B1A584
	for <bpf@vger.kernel.org>; Sat,  4 Nov 2023 20:45:23 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14330194
	for <bpf@vger.kernel.org>; Sat,  4 Nov 2023 13:45:22 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-5872b8323faso1752853eaf.1
        for <bpf@vger.kernel.org>; Sat, 04 Nov 2023 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699130721; x=1699735521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cqLx4B4eYaCl63fe+v3lssTiz/E1t615IQY+jLEC5QU=;
        b=PZhJTyxscLdurdTo4s0iF7exkH5ePveQrcDu8lF5bdDDOAKcmAKftldy/h1SqZmHaM
         alQaJ23ik20LS8hxmY4GauKrpkGlcCZcKYL+2RhW+5CzKAHxibFm07IvcHR2TUjtg/Qv
         +/h+2CDQ7JKqbq3PZCOnbEMJxhYhty6Apn73Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699130721; x=1699735521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqLx4B4eYaCl63fe+v3lssTiz/E1t615IQY+jLEC5QU=;
        b=vSgQ+U7Vfov8fNPqZDLQf0ePmcROYONF5R9Hk8irabAeo9WX/ricG2cEzEa2Q4SUC2
         ECudPYV1kTvXL6jYUR0KH2q4qThegBhTWZpnzilghfN5E04kKFi/XmSKVZssmnaYUUsI
         06JyrRsSVRNnHgGuL1qcoTE9C1HqbytyIjol9dDk+aXg2BKD77ULA2nJLNzdi0Oc1yGl
         aEYzD2raoyVSt9jZsfynJidFN7NsN+figTouYogEoDMCEgoVIWlu7fTuv6M+kRQsYu+6
         JwZOhnsnZ7BXa2CCzDdATWARqMJomobXvyWOlM47tRF46FSAIQdw/m6NDK9X+13fpkg9
         UyRQ==
X-Gm-Message-State: AOJu0YxYyFb9zwrolcSivYrvxN7QaazfwfpTc0XaDu6aLgWphrHC+45d
	DUai1ruUFJy5fFmIl2fFumG3RJAao+A586bQ6yOphA==
X-Google-Smtp-Source: AGHT+IGp32yGTqWv49b30WDAhnS22OWCItyJAuD53Fbd9/R1DAB9OVndnlGCgESoyNtM6mbiZdjQxQ==
X-Received: by 2002:a05:6808:181e:b0:3ae:4cad:91a0 with SMTP id bh30-20020a056808181e00b003ae4cad91a0mr33411223oib.6.1699130721428;
        Sat, 04 Nov 2023 13:45:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m24-20020aa78a18000000b0068fcb70ccafsm3240757pfa.129.2023.11.04.13.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 13:45:20 -0700 (PDT)
Date: Sat, 4 Nov 2023 13:45:20 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH v7 0/5] Reduce overhead of LSMs with static calls
Message-ID: <202311041343.03239A8AC1@keescook>
References: <20231102005521.346983-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102005521.346983-1-kpsingh@kernel.org>

On Thu, Nov 02, 2023 at 01:55:16AM +0100, KP Singh wrote:
> NOTE: The warning shown by the kernel test bot is spurious, there is no flex array
> and it seems to come from an older tool chain.
> 
> https://lore.kernel.org/bpf/202310111711.wLbijitj-lkp@intel.com/

I was finally able to reproduce this and tracked it down. Fix is here:
https://lore.kernel.org/lkml/20231104204334.work.160-kees@kernel.org/

-Kees

-- 
Kees Cook

