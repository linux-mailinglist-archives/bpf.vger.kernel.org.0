Return-Path: <bpf+bounces-55512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95056A820E8
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 11:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5EF19E83AB
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 09:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F5025D1FB;
	Wed,  9 Apr 2025 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ron52JK5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8259325A338
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744190362; cv=none; b=nUZXAns7U6eQSJBKXRbnQYw8QyNoRcBemKiknTfkoc/S0ZchSohBrTXiYl7q/fLMG817loFIU4bGe6xskFRxKLUaZ5bi1imwuKvg+mx5Xv+GAcnmJsUF9Ke8/ioL/hSh1LtJtRwSLW3vLr/fJqOa44Qik5vNtwM47nEHtvwg/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744190362; c=relaxed/simple;
	bh=Cfd6taZ1XReawrgJXmD5rJvLa2bX28eDDbODjWV3A7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MqNmtUQcLViqffyfHKHPCxOQPaO3clMKAc7dhApJxosLUkPItGT4jK8TMrVTbLGHRtrA2I8O/Cp/bWHi5y1bTsVJhWrv0b/lMgh9fVJjpi5BUN+qPaXS9GBUj5kayMGssWfvve0vW+y0dUk3Xzg9eDdTrKi+nQ5nobwSUep32Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ron52JK5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c1efc4577so3559913f8f.0
        for <bpf@vger.kernel.org>; Wed, 09 Apr 2025 02:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744190359; x=1744795159; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BnvAuD5LYuYp+IrGs5WCzF6uFd7AghllYpVWvB/imFY=;
        b=ron52JK5l48UYgA1b6Z8AwfLI8k+dCXa8kaJXfoHly9kb7EoFNqPPu2+YnRYH1UzwI
         m+SxwgB6c85gcrDPINkGzsBp/n26taZ9/XNhh/ysCb07Jek5RXXbZHe8ZXg6G3dLdrdb
         3XN7c/R5kUoObRKIszKi+0fSVRc9xRQak65E0FIOM5w5cYaqV54pQBg/7JGLBxtBxSow
         sCU2rzJElEGMNyu9K3FKxwe8crLmx9f2kjpQip9aoP+TzcXYkEEsQoFDyJNeCcWY015K
         uxSybcgyCF2jK6TlMoaUeFHGLusV5J+eilzfixUrbO1NIQ0zu8Cu796aSjITIcHvDrxg
         dyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744190359; x=1744795159;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BnvAuD5LYuYp+IrGs5WCzF6uFd7AghllYpVWvB/imFY=;
        b=COvvall5VJelVsl+VmXwE8d70H/HL4yzWd5chirIcpJ/gVtXhA+4Vqo4LjRFP+SL8t
         J4QUB6I+ZHf+b3SO3tcuesnyWjghg0fKOI8XAkXMzBqRQ9EZHNMAnxFTXGGEBVpmryGK
         Wp/xdbZCn1FpUsW9arHbPyMPsq26qrcG0kcI6Gi9OY1aW36uKWojQi9tAULffGg7SUTL
         yMn5xvZhvxR86YeoggWxgq7WiRfzV8xgQAwkZnXtTkGczpj9fIMp2hMfIHiOrJDdHaw3
         O2vLsPJkptmrriIyFFREjnypbHR0mq9aaNcnsjUgTa/Qv3DCLMZNEyUW2ogZRM8/pY2q
         nurQ==
X-Gm-Message-State: AOJu0Ywn7gowuA82NNPxBf0I8FVrUJdhIKlTjdtrZP40CQiV+aWrQUqi
	fxaqlwr9X2pGMh3D6UXGlFqYygEvhipIPH9F+BW1NPpGRKoZqQTz3DzCQOqkMWE=
X-Gm-Gg: ASbGncviUKTvMXByY1mL6UA08lEI6fQCSoZneeEQQvk9dYZR7VtuF9Qs7HarIEpnLKK
	fOYWBPAldeR+4iMVorOP/U2QWNoiCx6Zsq9+28R3qgJpn7dOWXDWP59UypsqeSVM3LgvFmcCmYg
	XtVAubO2DTM7Dv6jpSHGqG9fTP7XJ9QzFJIepVUAPblV6TNGnnXKgmhMc91fPkJm0NF2tkSBxeV
	VrwbcNfrLpudE0V+JmFdkjjhFfomVyZ3iPUrQpA/H2UO4o6T9lZjrjxrNg/kF6JLDvZgVtMD6MP
	jc1JhIsysSR7BSjwCtbpSK6YQjAZ8S5k+FlJP/Jp6BKFiw==
X-Google-Smtp-Source: AGHT+IE4ppIX6lojvphZF721IXqNkby2jKURMZ2AEr6A+yNFFriezPurU8sORfsHksfqW0Pmeg8uAg==
X-Received: by 2002:a5d:648a:0:b0:39c:1257:feb9 with SMTP id ffacd0b85a97d-39d87ce3c43mr1922196f8f.57.1744190358674;
        Wed, 09 Apr 2025 02:19:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39d893f0a3dsm1048659f8f.78.2025.04.09.02.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 02:19:18 -0700 (PDT)
Date: Wed, 9 Apr 2025 12:19:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org
Subject: [bug report] bpf: Augment raw_tp arguments with PTR_MAYBE_NULL
Message-ID: <843a3b94-d53d-42db-93d4-be10a4090146@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Kumar Kartikeya Dwivedi,

Commit 838a10bd2ebf ("bpf: Augment raw_tp arguments with
PTR_MAYBE_NULL") from Dec 13, 2024 (linux-next), leads to the
following Smatch static checker warning:

kernel/bpf/btf.c:6832 btf_ctx_access() warn: should '(1 << (arg * 4))' be a 64 bit type?
kernel/bpf/btf.c:6835 btf_ctx_access() warn: should '(2 << (arg * 4))' be a 64 bit type?

kernel/bpf/btf.c
    6822                         return false;
    6823                 tname = btf_name_by_offset(btf, t->name_off);
    6824                 if (!tname)
    6825                         return false;
    6826                 /* Checked by bpf_check_attach_target */
    6827                 tname += sizeof("btf_trace_") - 1;
    6828                 for (i = 0; i < ARRAY_SIZE(raw_tp_null_args); i++) {
    6829                         /* Is this a func with potential NULL args? */
    6830                         if (strcmp(tname, raw_tp_null_args[i].func))
    6831                                 continue;
--> 6832                         if (raw_tp_null_args[i].mask & (0x1 << (arg * 4)))
                                                         ^^^^

    6833                                 info->reg_type |= PTR_MAYBE_NULL;
    6834                         /* Is the current arg IS_ERR? */
    6835                         if (raw_tp_null_args[i].mask & (0x2 << (arg * 4)))
                                                         ^^^^
.mask is a u64 but "(0x2 << (arg * 4))" will shift wrap if arg is more
than 7.

    6836                                 ptr_err_raw_tp = true;
    6837                         break;
    6838                 }
    6839                 /* If we don't know NULL-ness specification and the tracepoint
    6840                  * is coming from a loadable module, be conservative and mark
    6841                  * argument as PTR_MAYBE_NULL.
    6842                  */
    6843                 if (i == ARRAY_SIZE(raw_tp_null_args) && btf_is_module(btf))
    6844                         info->reg_type |= PTR_MAYBE_NULL;

regards,
dan carpenter

