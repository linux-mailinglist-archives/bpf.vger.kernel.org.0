Return-Path: <bpf+bounces-54284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 184CFA66EBF
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 09:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF097AD930
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 08:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103251FFC47;
	Tue, 18 Mar 2025 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AkN4sGLn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6348B1C860C
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287449; cv=none; b=XsgDx8VIq5AUAj9pS/XUOQN7xu6aLRZcPjWz8h9kQXBAFT1CGvGtYt5/pIp9OGv0dHvDyB+KrI34ofxBv6threVsF3OG4e4q4n5ae5pGf7NYv8zqW1TUX+DWvQRUh2N2fjVag2h0pg5WR3ghwnNbhWZepxlJlFZ/weFpUyFuN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287449; c=relaxed/simple;
	bh=iqTAtUJA/PJ9sl5PSweARZnanep8YR8kV1RNuLw431g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSaolrxktRWGFi4cDA8CPCRoqD9Cvi3WbQcrX6SMeHYuFPXkr3aRxoGMDzP063plZYap3QpsQ4EMKTx93N9ZxBjCuPPY4S5JQ1twdvdHce2V1s4AKVpKqy4gWuIB05yOglDLyLjlqSd6/Ms0o+ALwAIg60qeeORixM/i0Ybv5Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AkN4sGLn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913fdd003bso2607703f8f.1
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 01:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742287446; x=1742892246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qrTeCa77YMi64HxFdGCxWhuYvHt2lDA4l8yS4Og6Iog=;
        b=AkN4sGLnISpuNLWFJamL+ViEsv7UYRY5XaD0Z9JSZQyphCa6ropW01padIf5Rbf3/c
         X/8sy7m2Kubq6rwvrxmHJmMgiNgPAFd7nzor0Ze6IrZ8/rXAos0qZbNy9STPE1tk8JyX
         W9cz7H7wAPxwsLfyOXpl9NlU1qH+yRrFPI5qha1SyzGppJy+nQiKd6PtiCMocU2/1Mlk
         SXSKxwIRVMsAJ3l798gYp4aJ8OYkyW6xYVvdj8vO/PfuW4Grnyor7fGRGVc3ok005KLB
         XB5XkFumLNn8FRaxvnIqSVNuXEXBv5xLUKn6yhwe3EjS2hjOMFaaNSi8xunyQ2PcBLyn
         i9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742287446; x=1742892246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrTeCa77YMi64HxFdGCxWhuYvHt2lDA4l8yS4Og6Iog=;
        b=G5VzVvigZXzGhVftJv2j2veDusvE4p5rQ/zu+pW13tkFcQKAcyiyO5Ijzu+L1wxFA8
         mWzzRLd16a3LZvplT3G43RflyN+B16Cz81kNhL+B+1M99P3LykapkGlG00FHgSRh7n6n
         AWuXzh6Xb9S5kTWg+X8CCUd8NAhdPdop8snQT10rKRc2+mNz39bamaJvGvkUeyFCnoGj
         Y75bgMPppWs+UIoG3UA7jqwvmuQL22NeQOtVviwM0PwElx1kWfOgHpvvttpa3YeVh1fg
         5N50lIAlEpGua96QmMuYa+bVMN5o6ts6ymh8KRHPvI2kiEGBlzDvSa5g6kls8OzRbEZQ
         Ak+w==
X-Gm-Message-State: AOJu0YxAyR6ORcJZBV7Vla1YjB0L7T0RDJBbneAHajGFxjILguX2t21b
	GWxo85D6SSsT9IoXRXHgMhYu3dUGG7k1DmyZgULLe4azJBmtzH36KcR4JQMx3uo=
X-Gm-Gg: ASbGnct6ZrAlr7HtSSw3QbwC2f3vZPitmxeEsUE8zYusC7MFc+T/ANdnnClhQVzBQj4
	s53Y4GILK08/5W71w1VQbbkwmO/Pk6mtIoYcg9HTFgUkBjgOtqxPkW1CK1n3zE1hnZzJpRKEpHZ
	aiAjD61zXR7Re4vnhn+gV3f4iRccDJ+Cm9c1Rk2bLhtlSGess1a8Rs4YkTYlHpRcGeYPxlwMhrd
	koIVTr292FIKCb9bk9T9e25zzUwCtl9ljMO6p8D/2A434GoCjfp5v6IC+LboWnKI1m84vo+PUzx
	5Pl/5oIIHBXajNSfENMluN57Zn8vOPS+N9i3jV8l
X-Google-Smtp-Source: AGHT+IGggvjqtPvIae4sT84y4xyu6cPZKjVhsAYd+wRVhK50QGtX2jXahMbpPSeBaDTLxmnO0XkauQ==
X-Received: by 2002:a05:6000:1a85:b0:38d:d166:d44 with SMTP id ffacd0b85a97d-3996bb82729mr1960070f8f.23.1742287445649;
        Tue, 18 Mar 2025 01:44:05 -0700 (PDT)
Received: from u94a ([2401:e180:88a2:a1cd:5826:4468:5b75:b568])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68aa66esm89116945ad.91.2025.03.18.01.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:44:05 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:43:55 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrea Terzolo <andreaterzolo3@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf] bpf: clarify a misleading verifier error message
Message-ID: <l4kxrezqm4qli6ilr3vg33xh6eqjkrfaiff7uwfyxwzgl3v46m@rjgmcvjy7v52>
References: <20250318083551.8192-1-andreaterzolo3@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318083551.8192-1-andreaterzolo3@gmail.com>

On Tue, Mar 18, 2025 at 09:35:45AM +0100, Andrea Terzolo wrote:
> The current verifier error message states that tail_calls are not
> allowed in non-JITed programs with BPF-to-BPF calls. While this is
> accurate, it is not the only scenario where this restriction applies.
> Some architectures do not support this feature combination even when
> programs are JITed. This update improves the error message to better
> reflect these limitations.
> 
> Suggested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Signed-off-by: Andrea Terzolo <andreaterzolo3@gmail.com>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

