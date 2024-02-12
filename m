Return-Path: <bpf+bounces-21743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359898519F3
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 17:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681621C21D27
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91263C699;
	Mon, 12 Feb 2024 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSxTbqLr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD411E496
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756492; cv=none; b=qzT+cUxkpPIhF1Md3Sv2wnUVRvJXDXpY32oxgKDmDDWdsYNbYRCrzOg98riWb8KYsr4Pwl9M0oTa49iuP43siNe8jv+5DglMa4Zln9g7pvEa5A+UmfVUEIh28J30vq6+jVZdDktYTtPRmXuXvWjecbCSTTObV3HahCw3IqX9yN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756492; c=relaxed/simple;
	bh=7Ih+6Diod4XtrZGgi2IeWrkO360BpTeF9yty+o1zd0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o4ussImm1Axi3MUW+WLFQ7tZxX0MlQm0mkg7MHxtV2M8C2HwLLe8ndfDr0gkdDzty1eqWDnc/cZp2iWsfzjwW0btsGefBQSvYy/mGX50ai8p8rsu1STNytGOJsqGXBP4qkARVvoquj5yXXe4fbXrflP91dJ7BCpQdiBaen7IiUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jSxTbqLr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1d9df9a3ef3so34388965ad.0
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 08:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707756490; x=1708361290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BUtPRvYIVmTUqwi/RS8nZP0n6OBVGAfBS9HtWdoYT7c=;
        b=jSxTbqLrkf7GamIfMELQiLqkbG5Oa7X+4gMfOOEpQ5ngqLaAOuOEs/yMJK2oY/pGDg
         cSqJufEbofzFLsJoMaA5sEmC9DlHIR2wIRXHmORtC4DF20LpfGZfb9bnHgdhFNLNg/m+
         D2x9qWTGO6tBtZHw+6LZ0q67562xV0sDpmYRyPAlMoFtJE6FtwuQHbquD+Uiikb8w3qy
         Dr0LL1X2WEJT+BsX4LO34fBs6i9ZchXV+mM6Z2AB5Ze4kjcl42sBy7MeLvYVTnkTpilW
         pUNn9smtpliecx5TIW+HV+AwqSQH2OJBhBnZZB8yYaA5r2nwdk3PXSkzG/PdRpJxJiaS
         t2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707756490; x=1708361290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUtPRvYIVmTUqwi/RS8nZP0n6OBVGAfBS9HtWdoYT7c=;
        b=gQevsZU8c1MkZrmqhpMI4II14E5HWkFI/r28DZUPUqv/6xKwJsz4IceJe0/v6bKjO/
         4SYc5/8E0//jrKq3yStX8H37yAcNDHWcuX09n74xGemad+x7yLxHxSBA0kPDDX+5I+X8
         cN/oo6AqfTNZhsM4wcnAZCc3V7vTswhs2nkg52JaQtdeu+hGhyiThbCmRhlB08MIrNCu
         yDMGmb/Fy7hS+JXvrTAWxdODPB88dWNbk1JwPiEOpDDbrQYIf4ihJKtWWeXqVIkD2QjY
         0PfI4yIRKkNwMEz34tBElzfuuCv2XgTnp4sH/cK/FGtrogENuXhbuuwmZQGsFCPF6pMZ
         J3Og==
X-Gm-Message-State: AOJu0YzkENNuU6Ew+W067U1KofXl2+6TIzJYCpVi5LgHty9NaUqDxdYi
	zX8SRDLjaOEhh5QfGBKxgWY1hNb6exGMso3yAx9bVFTwbO8VwrQDealAfo+lHvIt+w==
X-Google-Smtp-Source: AGHT+IEYSGe33b1aNwrUH4ZgJdpAOKjNzhg0/+62Nd/4wOims16WFlsLyx5fXpvJNxl98RWMCIFWgPo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:191:b0:1da:16ec:a2 with SMTP id
 z17-20020a170903019100b001da16ec00a2mr156079plg.12.1707756490365; Mon, 12 Feb
 2024 08:48:10 -0800 (PST)
Date: Mon, 12 Feb 2024 08:48:08 -0800
In-Reply-To: <ZcnaW5hB8y3da3bI@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209123520.778599-1-hbathini@linux.ibm.com>
 <ZcZ6myvln-v0Y98S@google.com> <ZccAyalp+NyKQoGp@MiWiFi-R3L-srv> <ZcnaW5hB8y3da3bI@krava>
Message-ID: <ZcpLyKDulwlrhGd1@google.com>
Subject: Re: [PATCH linux-next] bpf: fix warning for crash_kexec
From: Stanislav Fomichev <sdf@google.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Baoquan He <bhe@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org, 
	Kexec-ml <kexec@lists.infradead.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="utf-8"

On 02/12, Jiri Olsa wrote:
> On Sat, Feb 10, 2024 at 12:51:21PM +0800, Baoquan He wrote:
> > On 02/09/24 at 11:18am, Stanislav Fomichev wrote:
> > > On 02/09, Hari Bathini wrote:
> > > > With [1], CONFIG_KEXEC & !CONFIG_CRASH_DUMP is supported but that led
> > > > to the below warning:
> > > > 
> > > >   "WARN: resolve_btfids: unresolved symbol crash_kexec"
> > > > 
> > > > Fix it by using the appropriate #ifdef.
> > > 
> > > Same question here: how did you find this particular kconfig option
> > > (CONFIG_CRASH_DUMP) to use? Looking at the code, crash_kexec is defined
> > > in kernel/kexec_core.c and it's gated by CONFIG_KEXEC_CORE. So the
> > > existing ifdef seems correct?
> > 
> > This patch is based on the latest next tree, I have made some changes to
> > split the crash code from kexec_core.c. If you check next/master branch,
> > crash_kexec is not in kernel/keec_core.c any more.
> 
> makes sense, it should have fixes tag:
> 
> Fixes: 29fd9ae62910 ("crash: split crash dumping code out from kexec_core.c")
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

+1, would've been nice to have more details in the commit description :-)

Acked-by: Stanislav Fomichev <sdf@google.com>

