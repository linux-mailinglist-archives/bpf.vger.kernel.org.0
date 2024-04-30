Return-Path: <bpf+bounces-28231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6A78B6C9C
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 10:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0504283E09
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 08:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0924A54792;
	Tue, 30 Apr 2024 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpHxsGRq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A04652F;
	Tue, 30 Apr 2024 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465006; cv=none; b=bvdtiuSS6e/crdyhKBqqSCS6fINhseHAb0TiyxHERJkIF0KnzlChHrFnuTt//oCS2ErnZRmAUL5fIEJSL5f6kwavn/rXy8oOvOs9E6Mc/ffrLrf3P2WraGNTAPoAcxEu2Y7D9a8OMJBFxlE+Tj+ZHiGqushKFaRNvh7MM9EBKSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465006; c=relaxed/simple;
	bh=inL/XvzDhd0iPly7we3AMxXncMjUERjQL1IhMhYqtlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPnz2kP64eygCYcSTZUitrbpV10EMhOPhq/YnKYL8oXxK6wFEHAJTAlc21X62Kj/1jlF7rUjiMakjhbHoTx5pJ627RMRDs4CahHi/iCiat46cK2oL26bubDYfoKeCeDqZ/PUmsRkM7IPevE4XqA2nHr4Ur2BrPPVPmwxz2FRIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpHxsGRq; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6993585a900so4670546d6.0;
        Tue, 30 Apr 2024 01:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714465004; x=1715069804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TksqOAIu2i4/rI92X8m6pgc9vby4aRKpp0NW3wHgUh4=;
        b=RpHxsGRqvBFkcGgkK/eOuB/o47bj5zoUlM9cqwNsaoTRkFfRTKhYEwnwb/Dqz4QqMd
         8tBiC72hg/J36PVmciX7/SpbsSP97q4RZc3d+pqh4ygrhaLIOYEpkn/8VP5PclBkBdqj
         BXaJUIW1Mh+zcdrRkGaXvU0FXM5Mv+4KtY/qNhJd7Ulb+Q7zuZGeNqJJqemBo3UThuwb
         0wV5lvTrUNKUDQuVD2qhbUB2MxM23F37gvImmU6QM2hIyXkn8nXPtpjz0PijFLQJxzhs
         ZCwj3MULhj3xVoxmVqvbvwvSXRY8nfC+lXNGo+pQJwIigSiV/rnXc5hRnKbN/wPpqcRh
         2plA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714465004; x=1715069804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TksqOAIu2i4/rI92X8m6pgc9vby4aRKpp0NW3wHgUh4=;
        b=ZMo+EfL9hJYhy2l9eHDO73zp1V8c3/IFTwT037TtBd8NjOynPwIZzIID5kQ0he0zVm
         FsBEVHkVADW9qc5VUG1tRRH8xzatYKHYfxCl5ENaU/++uhb2UtwG60t2R2/kR5/JFXtS
         vtz1ZWCe5LqKDng3nGdQrmIZFDcFw4xf4HbSmwOK7KDrV3tPGL1RPIYJQVyYje44PyqQ
         T07xidiT7qPRg/Pe9fhdvjleRn6QElPVTeH1+jlQqZ0J7QjIs1ysz8kIPNyJ7KLBwqrj
         z7Z5oRje9v/xarRzul9rqnUlug5CqKiMjAGLwPzPcybLbfUSpCqokQkF8WFA2/S/Dz/4
         uqUA==
X-Forwarded-Encrypted: i=1; AJvYcCVzUJI/4dqLYJ5DOFTcAtCjlrRd0lKMFbqGqe/u/d0ZhmuWV9LbBkkVX1pyXgk5TiMhYPVzMDd/GwvCl9v9FaBZifInO+EwOmC44V/+lwm3raaETCmNvV0uRVZa
X-Gm-Message-State: AOJu0Yz64LSUYFiGygAFLyhj46+ZgYHJKFE33eoEipYUQ1zl9rCt3v60
	OalQp+9vyopOxlsbhF28CJxVPH5p4nK1ksl2P/PB4bAwRaQlo10+CrQ5uvRDLq7ze4YojHwxukV
	qKPmYVE4QWf07h2Mcd2Aa6TR5XkU=
X-Google-Smtp-Source: AGHT+IG+5JvIAjMBROiCYndF2c1uH8MKiTzfF0au8SpB+e5CkI4bM8NwaoNPxnK0AJkWeGKvClzCrrCPssu2bqV++dk=
X-Received: by 2002:a05:6214:124d:b0:6a0:b4fd:cc7a with SMTP id
 r13-20020a056214124d00b006a0b4fdcc7amr12127328qvv.6.1714465004040; Tue, 30
 Apr 2024 01:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429131657.19423-1-daniel@iogearbox.net> <20240429132207.58ecf430@kernel.org>
In-Reply-To: <20240429132207.58ecf430@kernel.org>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 30 Apr 2024 10:16:33 +0200
Message-ID: <CAJ8uoz3jzO=nRTRH9OPjTu0iBn9Gdjn0pbgVGdjDKbV=Q_BUMg@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2024-04-29
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 22:22, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 29 Apr 2024 15:16:57 +0200 Daniel Borkmann wrote:
> >       tools: Add ethtool.h header to tooling infra
>
> Could you follow up to remove this header?
> Having to keep multiple headers in sync is annoying, and using
> 'make headers' or including in-tree headers directly is not rocket
> science.

Just because I am curious, what was the reason/history behind the
tools/include directory to start with? Most headers seem to be copies
there.

Thanks: Magnus

