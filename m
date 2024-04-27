Return-Path: <bpf+bounces-28000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01C48B4305
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 02:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7C82845DD
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 00:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A20017D2;
	Sat, 27 Apr 2024 00:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhXV7EdK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A4AECC
	for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714176569; cv=none; b=RpJ6x5sYrC8ft3Ihbo5OeY7+zGpjU9R6Rnv8C50GolPKcborYFeZNlwyB4A+0LtBr/uaEpHxNC5ixKZ9cSInc6PgOgALYvJnZduGUDcNCVU6y7KKE+ODf7DMB3c9qFGidKdywwhsLRyzy7whuA1iE3adr3Nb5iGsGPmByoZpAqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714176569; c=relaxed/simple;
	bh=SiVyelQECn3r03Qo3Hb9otui6S4pAu5MVtvRxfR0pE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5XYs1Mgoodk7388ii8Z+0drZ5RE47RixI6AfVSjWNoRmFQgmoMttUZ8iA+/zsg3GwYtGYXcCMNRpwajFfAxnt54dC6zZgGYZlP1v2Txq3K73Ws70E+pSHwcZXXoladdGA13OgBYv+IH/6sc/rbu2x3sK+VoLIF4qpO7f+coD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhXV7EdK; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-57258c90899so1900573a12.1
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 17:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714176566; x=1714781366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SiVyelQECn3r03Qo3Hb9otui6S4pAu5MVtvRxfR0pE4=;
        b=LhXV7EdKTH/CXLDGGk+qIbpMStRhrMb8iPWqvKdzhwUnaivrtuVAbsTOISyeiD6KUH
         lfShurQuySNAePM+qjRHFiMJ3rVfRMXCylPGINof14sD7lSVr20jMT/3l0Xc+ny1/5if
         ufJdf4AnhE2b1q9qRm6Mio4ofIim4kHVBdlMb29iUYxmSkUqLHhNUzeccLrimFyINT7X
         ZY2TCVcyRucJpE36n082B7Cmu2QQkS001SfsIyz8fgMTkgJMNCurMjD2XGKDnvZeCTAu
         HzdQ5Ref72Olq/KzwIrgZIhlriBelYf0Fq3ohYfuNAoOpstC5SJk3LR4CSOSS12+bolT
         XhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714176566; x=1714781366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SiVyelQECn3r03Qo3Hb9otui6S4pAu5MVtvRxfR0pE4=;
        b=BPdkDxT+uS/icI/44UolQchVUpJjjawEY9HthdsmioXJ6KgyQ49SBJH4nnXYj7jL4Q
         SzegIxlQ1wLlyjhSSteAJdsyYQijuMeoJQEdfWmyHh4YfdzNcG8cdqEqEacrahwZLpiw
         HfDRzJdwhIyeHJdhzvLB3TjwtuAUQCX8P//869YRlHjXXeM94uOQxT8ajZCtOgeuofty
         D0I9l327DhmPWmRQ9TrzfauXPblrQa0KjPNW+iv+3tMa3JdSA8OtcMIa4NuFeo//iNbv
         YYi6naVSuEIRQXpIfUNSOV+KKw4ONH2BEbM4/dBj26CoAGyB+auBbBOHuNEYGWQYbkmd
         otow==
X-Gm-Message-State: AOJu0YxbYS6DJLqW7jmtQnjn31VjPyUeFfF+ccT5WtFV4uQpcWFG2HvQ
	IgHvsOHNLVhvp000PTxKvLzZYls6Hvq4mLTfZIYFEFrDBtvpyUDijYI42ubYttpYzvNNYyVBCFD
	KK7Gz77afDXedt5iqRqx08EYe9z8=
X-Google-Smtp-Source: AGHT+IGXk0TvBEeB0bSgOfVMy0vcfVH6vLcU5IkraEN2egXP0Iyyovy6RWJfS0WINWP4YEbKjQG6MfYHZS7iyPXhYuU=
X-Received: by 2002:a50:f614:0:b0:572:3f71:161f with SMTP id
 c20-20020a50f614000000b005723f71161fmr1027297edn.12.1714176565721; Fri, 26
 Apr 2024 17:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426185630.17938-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240426185630.17938-1-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 27 Apr 2024 02:08:49 +0200
Message-ID: <CAP01T74R0QAdeMKj8QSJR79Od5CQgx-fago80mvbR6S42MmZRQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix verifier assumptions about socket->sk
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, eddyz87@gmail.com, liamwisehart@meta.com, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Apr 2024 at 20:56, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> The verifier assumes that 'sk' field in 'struct socket' is valid
> and non-NULL when 'socket' pointer itself is trusted and non-NULL.
> That may not be the case when socket was just created and
> passed to LSM socket_accept hook.
> Fix this verifier assumption and adjust tests.
>
> Reported-by: Liam Wisehart <liamwisehart@meta.com>
> Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

