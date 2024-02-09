Return-Path: <bpf+bounces-21645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B8584FCB5
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 20:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0701C23EB4
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 19:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EEE84A33;
	Fri,  9 Feb 2024 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIjrsUPX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FFD8288B
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506335; cv=none; b=MhT+H5+/DLEt4tr9KllZ+7OHOmV2ad0YHIE/+uP5uRAnpuK5XR9on2DS8z6S4g1Hx/5FjK+RvrEyPW7PJ7ApNqtJFw9Hyb6TxeztOgmbTrT41dJv0AiMyixZpRopoLrGpwVx3ETQkbzhjmfUmgbVEfS04xN7He8k50k+Vaes/mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506335; c=relaxed/simple;
	bh=X8KmDiQk+SpKWveRC9xGKFa6VFjhwQ1gk8oIZP9gixA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hqay4wIOWIbKmiVkHKiTizlavauLYlZCaidukFsyhnhLqv9NtH5iiVsidzrPOddA0Y6i9M6fXaq/evgRWufs7xP0FG8CVmcQ6LCJdBM7ktlMw/s1we3q42mAedHJYbMLESUCTKfmTHmyoRvujaUSl4dmww4tqTOXhRczrCERQp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIjrsUPX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ade10cb8so3001955276.0
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 11:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707506333; x=1708111133; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRnCwxFaBlHNvNYdy1hYfoY/u+PniTnXvczChOkbnWY=;
        b=uIjrsUPXymSzFWM92J5azeth8k8SAMbNHzynctbWufPBhfaguBrVkTO5Oh0lljjkz3
         hZQSEZF0brxXsKeorNrHmFZd4WhV7DFQpGVqqhbqz3IAGqnsUkWFLBHWA1YOrDA4FzyV
         6tyVIc5HJsP+HXUh4uo+Kw9Ffrea3sT6gXlKj/7qMzD6Gosxqv6lgcDRKlWYm6SUXxBe
         h46SoNyAubH2kx5ZBpCPxkbFvZSx8TNKNqKlTOJ58gWfNFjI/0BJCu8qnA95d42vd/7O
         q4HjonYWRtX9mpLGVnpWKB7ZmwEmY4oLg/S27goz+xqKcaYHUeF/v2XNrvR/TUVAx+5H
         ea0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707506333; x=1708111133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRnCwxFaBlHNvNYdy1hYfoY/u+PniTnXvczChOkbnWY=;
        b=Z+1PCMUX2BI8O+/o6JkAXGTnxfODpY7CQV4iF14vR2ZX8ihFCJ5hdwYpuUiPVnbUZ3
         6g6F/j8Drnevr+NTfMo/dgz/4XkeDPE8ho0WBWaR18mtbd775YJQrpgRuAzkqbJGasi2
         MRxMHAp8dOvIF1w49kAZ3/RD6NwxzR56JOHcY+dZe7tLofPaNIk0eBYvMIjEGwlTClBC
         v2Coh8AolxZdZZYfd/CKTYkZ0KI/rYgSnXbAZI+Y9PpsDt0FPaM/i+CfWUX1nzYqZazq
         SpRP13JPje8n/L09hKULqN1w6IHEVblB/D6uR7XmNjYCB3VPIm+ovMOsowvYzgq/LScB
         ghGw==
X-Gm-Message-State: AOJu0YwkjnlahTCA7c6jHNBGPaUFo87vV2XYQX0uy3IHElkdvNRguDnd
	P+vYKNXCb9/ELn0MdbtFail93JUVLF6Mz56JtEBaN/JVscxLcJfwZRiWJGSVLjociQ==
X-Google-Smtp-Source: AGHT+IE2D/9dq1G+XGY3EnJfEpYpWhoRXnUadsjTmnQ9jUN0w+KcMdMs6s8yG0RaRANU9GOhtzoNUc0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1002:b0:dc6:e884:2342 with SMTP id
 w2-20020a056902100200b00dc6e8842342mr13939ybt.5.1707506333090; Fri, 09 Feb
 2024 11:18:53 -0800 (PST)
Date: Fri, 9 Feb 2024 11:18:51 -0800
In-Reply-To: <20240209123520.778599-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209123520.778599-1-hbathini@linux.ibm.com>
Message-ID: <ZcZ6myvln-v0Y98S@google.com>
Subject: Re: [PATCH linux-next] bpf: fix warning for crash_kexec
From: Stanislav Fomichev <sdf@google.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, Kexec-ml <kexec@lists.infradead.org>, 
	Baoquan He <bhe@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="utf-8"

On 02/09, Hari Bathini wrote:
> With [1], CONFIG_KEXEC & !CONFIG_CRASH_DUMP is supported but that led
> to the below warning:
> 
>   "WARN: resolve_btfids: unresolved symbol crash_kexec"
> 
> Fix it by using the appropriate #ifdef.

Same question here: how did you find this particular kconfig option
(CONFIG_CRASH_DUMP) to use? Looking at the code, crash_kexec is defined
in kernel/kexec_core.c and it's gated by CONFIG_KEXEC_CORE. So the
existing ifdef seems correct?

