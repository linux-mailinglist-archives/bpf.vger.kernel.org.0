Return-Path: <bpf+bounces-59043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A63AC5E5C
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B865B3A4FC3
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 00:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EF73596A;
	Wed, 28 May 2025 00:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjOuat6P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CF11E4B2
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 00:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392429; cv=none; b=HS9z+BfQXRnPZRZhnA0IITz4gsURqSexIUDeNvdJ/x2NNRkN5AcbWqPnpAR5XX081senC3Y8pduLcFLVcLK475KegOSMA/uf7XFVJVsDeqN2++5K+vsH7i8bd7wbnZknohXVpdtDYF5iHOinqzL4L/kJb++BoydF0MMuWajUNEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392429; c=relaxed/simple;
	bh=lA6fQGdxEJbVnfvsaXlTsHNwkM1GhUlJAKKY/vQ7g2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kWyasenZWYHejzM+TFnHX7nzUczhbLjc+FlNwxRBOy+EKVjudhXpSr6HUC2IDHlxGbya2PbslxJWfkWvasghUmeXFWVpslkRDaL62iTsKtoyaeDhREFnZ3EUdC7FMzmdkZI7X78NbfDX0uSRNVL/8hANzjtm72vL8on6+pYFJsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjOuat6P; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23476a0a7c0so2783335ad.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 17:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748392428; x=1748997228; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lA6fQGdxEJbVnfvsaXlTsHNwkM1GhUlJAKKY/vQ7g2M=;
        b=GjOuat6Pd/pNDnMn+dArCmQIdoLiaQKm1Evdc/Dfsv2J5belmACLF8dXy3b29Xheeq
         tbi97qgrAYzrURm4r3FxxRs2YzfJ2ybe+IMR4BdVMvnc0eKMQ2jlfpyf4NXMiHRPUUgF
         5shx1/QHlzBWKMKoCX2O7lU7Qn6NrhNuvpkO4hI0B1zyW9TTM9CE3OBM5NhERTtfy5MX
         Utb1PhCTldFTvPtUN+EzFU5/os+RjN3rOLBk4gIGB56R2PA/oq3SsKnBQwRm6muxMZ1Z
         z4tY86SelXrC+dBUaI+ird3I2oZdUjwKbEDfsj1XreAN1Ew7rd4xdnVF7aw2iwIMOd5B
         i33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748392428; x=1748997228;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lA6fQGdxEJbVnfvsaXlTsHNwkM1GhUlJAKKY/vQ7g2M=;
        b=X06tUXoL1OyAwX5ewpB4LMemYbCNTNInzSc9fSQmuq3iv7YvcHdl0xaXIKnw0F/e1F
         TTUyj/irH6lwCFoPRTPXKMD2uA3pLw0c92def3a+XuIitL8nxGe6obzdnJDY66hIxNpU
         9cNjLjT8z0300DbarNyS1+4v2o7x+BGrAtTw4BLUbI1Rx8F5cGxAlHIG1442GIqQmyvP
         KH311mf+1TwLjQ1drYk1R1G2b7qLSJ66PB0qSKTbUGmzMUFXAUt1Wa10xAvXUNdoZAVE
         QbKmu9IYQc5YO/hwz151hk40t0wxgSmG6fz/IzTOkvIza5VsocSDsH46wDa1gVXO7C4w
         AHeg==
X-Gm-Message-State: AOJu0Yz3qm3UV20j3b6VnU6fU9jxzKhdMoucCCspnod5HeAjbtMGIoFw
	BSHVSCLYRgHYrPJO5dWHFMtlJcDwaTduwGOH17iM57+QmxQ/qdxDnfE2
X-Gm-Gg: ASbGnct2zKejkUbLSo3Muzah+hGzO+ce+Ep8EcStnHfr90jW2UEXkmku6kry8E3tBZD
	RbcQkQDxkF61LDyRUqcwzZnQ1DtM8B++CCJ2t1yUwzSH5fgvrWdbqVuXPl+SUR4z2pszOHlkQY1
	jFB7aMf0pP2m2FVIpeRR008REpsKHVCloSIgZHiftnHBuTotgVjs4NLANXho6Els/G6e/vT1MFc
	ALKTrFjS/oKGXWdPWj+fQL2fqOytGTkUEFgcXwJEEw/2vErBR0UrbTgV6DGfntazd5n40v2Ty6U
	dK/1asieJ9XIqyVWkI0bvSJI3hxYbwVhjmBOsUj78ItB7hgjuFfYRGI=
X-Google-Smtp-Source: AGHT+IEHh+2MfwdEMQka5LR6NBcZvDCz1XpQk+0lNIdEbPU7Gsi8FSGSKJsBhKLPBSs1svMEYXHgbQ==
X-Received: by 2002:a17:902:cf08:b0:231:c3c1:babb with SMTP id d9443c01a7336-234b74d46d5mr36600025ad.18.1748392427685;
        Tue, 27 May 2025 17:33:47 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::7:461c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d358f167sm127765ad.130.2025.05.27.17.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 17:33:47 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  kkd@meta.com,  kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 04/11] bpf: Hold RCU read lock in
 bpf_prog_ksym_find
In-Reply-To: <CAP01T76h+=QCerjcJZy_LE6UgF6Gu1mmfLbi10OJjDRK=JrrpA@mail.gmail.com>
	(Kumar Kartikeya Dwivedi's message of "Wed, 28 May 2025 02:27:37
	+0200")
References: <20250524011849.681425-1-memxor@gmail.com>
	<20250524011849.681425-5-memxor@gmail.com>
	<CAP01T76sCLH8qCrEqr=oYLW3CpbZA-+ifbA3DOCXT93Lk0LN5Q@mail.gmail.com>
	<m2o6vd4ml8.fsf@gmail.com>
	<CAP01T76h+=QCerjcJZy_LE6UgF6Gu1mmfLbi10OJjDRK=JrrpA@mail.gmail.com>
Date: Tue, 27 May 2025 17:33:45 -0700
Message-ID: <m25xhl4lqu.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

[...]

> Alternatively, we can add WARN_ON_ONCE(rcu_read_lock_held()) as a requirement.

I think this is a good option.

[...]

