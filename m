Return-Path: <bpf+bounces-33649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31038924352
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 18:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B3F289531
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 16:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00611BD030;
	Tue,  2 Jul 2024 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9m/LTV0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0701BBBD7;
	Tue,  2 Jul 2024 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936668; cv=none; b=VO3kOS4PBuFIod9P2vo69utvRVvEM4zHJi/wco3zoFhXnV0V0jHILrZo8DzyknL1LqNCdXe7R4dAsP8tgYoz+C8G4cPXbaow8JGLKRgJlt/0u/pHt2pIIIMdZW8tv+9vqqJVxi4+/b4p4GqqKqq/8bE7GDl+wUuu2Igsa/HQv+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936668; c=relaxed/simple;
	bh=3xJuzOTRMluaoR8nsvkgFb7mnpaY4B66CdYGgij2JvE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLQWsGBu6IvSSPci6YHZyXVXlj4isoz4ZldA8XTWeoldpIamBCCNKibaS52fUi+y/xQ1njVeQhUFUojqA8/kpbsDBsXphG06sFNt70RYmPDz8zy+5cUyYMbCjNfM14RvWgS84YjH9psnmaZWjrL92rR+Sxe37KdO7GzCwjDUa7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9m/LTV0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-424ad289912so31011965e9.2;
        Tue, 02 Jul 2024 09:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719936665; x=1720541465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V0Qz98KWmiG+EMpaS/dWI6Z22uc/M7LVTuKKam6RTUU=;
        b=i9m/LTV0N2dD9sCg8hGwELfMHD3G5FA986CUb6JKsSpzcaOdYKfpTXLioFueKzfi3N
         NcapAMkIt6RgcwoKynRcdaQwjBVU2tcGN4F2y/ngQtZZzrHfe6h4y3W+a8gvG8eHYl6c
         NN/oKRTjKcD+mMNd35nhjNtegKsBs405FIdaGMvtVCo1mKOJmLNsIHmHt/AbcY0CO30w
         0YHWocDVLcBT2G6obGZgjI1TOKHACR2Ny70pmaRDXItsqtiGbkMn0aFBeOFSmfVXPP2K
         elB1V0fvfcqomAx2GH3IUHXDrQzgqENmqECfwKS11eytMaxaHCy9qB6EVTzoaXx1O02w
         YTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719936665; x=1720541465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0Qz98KWmiG+EMpaS/dWI6Z22uc/M7LVTuKKam6RTUU=;
        b=uPG47nBl6mkqjxmvgA6GBym23DTXHNmWwoIRoMpZ6ae348hRMaLI45EJVQUQhPUVMa
         U0g5OfZjUgUdBM6Wujmlvq+VAiE12sIdBr4GRNaKKWbD8u86WOD0cy1J9QZlIbH/Ahlb
         RXJoarFlUhlRAH5sTMgMZKguMaF/qfeCzuepAD1fYNC3HO/+Y3HJVH38bLbhGqh06HJh
         u3Dhk4TPrMv9fVr7B9MygGzTOjW1Zm/WuQ/853crCtMAPNyvazjf9ux+E2/JCG/fvGYo
         SDxfrn1x5fnaHeSXuUd12wlpxTZHR8tvMSym9Rq+IS1LweyEW7t/1cnpfr5hQDh3Axhi
         Uupw==
X-Forwarded-Encrypted: i=1; AJvYcCVgl6b5s9Ww/L/ijwZk7l0AC7ibuypsaboscgFdXRsdtSjNwCF6L7oeXkE8PQ7+Pjee9Dh/HmEY+WS2jE9NzwZzX3jwoDM7axaP8VJCfvnJSptz0JcNjpkXwqIk5iQrpaBM/j+BPxpoAMd7yHvwQvEezt1unjT4yTuBSc5/8SqDprzccpo8
X-Gm-Message-State: AOJu0Yxym2InxVnFwMTpiRoVIpvze0y1gla0JRbdqMWMQC5BMb+vS+Fv
	UQ2Wa9D2hVXxCzhR3sZKVc7BLUNo+dUYbFFAskFyn0FoJ+TZ9TYM
X-Google-Smtp-Source: AGHT+IFxlAlKL7CVEdpm+YsZgzcGzjI937/84Y3tdXQrGJ2iODKxpg6z2gXa40cQl9BEceDHAi8nvQ==
X-Received: by 2002:a05:600c:4da1:b0:424:acf6:6068 with SMTP id 5b1f17b1804b1-4257a03479emr70285705e9.34.1719936664991;
        Tue, 02 Jul 2024 09:11:04 -0700 (PDT)
Received: from krava ([176.105.156.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09a2bcsm202179825e9.36.2024.07.02.09.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 09:11:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 2 Jul 2024 18:10:58 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
Message-ID: <ZoQmkiKwsy41JNt4@krava>
References: <20240701164115.723677-1-jolsa@kernel.org>
 <20240701164115.723677-2-jolsa@kernel.org>
 <20240702130408.GH11386@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702130408.GH11386@noisy.programming.kicks-ass.net>

On Tue, Jul 02, 2024 at 03:04:08PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 01, 2024 at 06:41:07PM +0200, Jiri Olsa wrote:
> 
> > +static void
> > +uprobe_consumer_account(struct uprobe *uprobe, struct uprobe_consumer *uc)
> > +{
> > +	static unsigned int session_id;
> > +
> > +	if (uc->session) {
> > +		uprobe->sessions_cnt++;
> > +		uc->session_id = ++session_id ?: ++session_id;
> > +	}
> > +}
> 
> The way I understand this code, you create a consumer every time you do
> uprobe_register() and unregister makes it go away.
> 
> Now, register one, then 4g-1 times register+unregister, then register
> again.
> 
> The above seems to then result in two consumers with the same
> session_id, which leads to trouble.
> 
> Hmm?

ugh true.. will make it u64 :)

I think we could store uprobe_consumer pointer+ref in session_consumer,
and that would make the unregister path more interesting.. will check

thanks,
jirka

