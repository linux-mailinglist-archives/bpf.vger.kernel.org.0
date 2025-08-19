Return-Path: <bpf+bounces-65995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA636B2BFD0
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 13:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F601188D374
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED97326D4D;
	Tue, 19 Aug 2025 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ4wmScZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE426ACB
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601572; cv=none; b=tOY/VvTMXFQusKkIB3bLcl5h2ut8pDpH0no8V4ISLefYEV7brQYyNhVTJGilgUKwHnMP0tn66WCzqy1COoHmL0/5HL3HmkNH+YCpLoDMN0Hrp2pp7dqzC/u2XzUO5+1b/T6ivZeKWeGNdZElXIIvSUnsiTBqi1REnmt+atzEjPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601572; c=relaxed/simple;
	bh=BdnZGH3Lmze0V9vRylpxgRT9FmwLjtXEAuPuXk+ER3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiExio0Vf32DK1dpAq2RmzlN7rc89qCLex1hvAIF1RM7pwLVZqPQc5DSgIvi7XzNWNTDhACyMcZEoKF4jFUfik897gcmZSode2bw861flZUBhQ5cXe43q3Qd6wI7hOtLQXSCy6OlTvniwO/ejptj8Ozrjobk6CL+fKwmIMet8Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ4wmScZ; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-6188b7532f3so9282047a12.2
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755601569; x=1756206369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=InP4Ony/OBqhBOccnlxU9W8+6v43BsjhoJiFwGeu7WI=;
        b=cJ4wmScZlMk3mX50QVGM8qM/6D2Nof9YjAitlXTYjWCd7lclOCO3SslyRH/fnYPRi8
         E+tHFLS3IxF8HNsvp0p4k8ZizNPAYxYVVkY/zgo1yFAN1pqdHhHMnxoAFwCZ0uzRH1O9
         xprnJz5P2q4PPFovKKWYFo4NUWcaY3PlgDlcGu53jqPrrNeD3sMK01K4vLPhR7Sc4RiK
         yD4JJrltK0vvcGgdGadkv9PHX30AbuOiboDv6p4wRWErM2wA7jj1DFHwBeML47iTkytt
         Avmn9648MI0HOf0w+TIOpyg9ZbL/ftEaOWFplbbmq+bXspBEsYiXXcYQAsZAmHTEkw5r
         PA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755601569; x=1756206369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=InP4Ony/OBqhBOccnlxU9W8+6v43BsjhoJiFwGeu7WI=;
        b=DTmnv78t++SGAUNb7OPl12Qbs8o3Tmvr8MUe1ZAZNl0T6vKgnGdYOTvuuOg67sKb3k
         p5gp0bDNLyFWWG8voX8VwsS8Uno3rP0PtWm7Gmw1UUq/in/qSlCwTbpPaXe0fqclJ3pO
         7FSpbaP7c/rhwdixGdssAG86522bot1JzcP+zYYnbmg4OyutdhVa2767xNmnvyt5eApe
         qUMyqpQ0x0ND8AK9ncwJk4zcf1xqGyANcZX3sPdlA8aTGT+aP+sFiKTZOTVvhwycf4we
         sgsm6X2F4rtm6JgCJ9ATjVS31YmaX198jtxnBtFWaYKmik0P1M8FJgBeTRLv3AEG/dja
         DuvQ==
X-Gm-Message-State: AOJu0YyNNvP5k+4h3yQkL0T+gFaDTyc/ucpF4EaAiFHS4j83C6Q45YkN
	9T+xrTAO1/OrnppfyfqJq4TeRzR3xHtLPfhBFQFa7BAP1FzdVRJ8mDsnv7N9jknjqRvWnGbaTd4
	T4KeGBoxWdexsSCMNJ48g0zYnQGCZ5hI=
X-Gm-Gg: ASbGncuZWd8yTIecbYLy3HVRHHeM0XbtXOmkHlRK0uL8XflVAGzQF5xxHx338uQw0iI
	JseLXd6NTWuJtHewtsgrNNYTvafTMR/J7K6R1khJf8KrkJ0rNstcD0J1qG4drclYnS4EPJ1htiF
	xIQ8dHcQVJQzX9sRj21Clix4Zr2cy3fNlBHvqAsALSdzNI2izd+JO0GazeZoesUnWdONA54Yde8
	m7UOPPI4D8cpTH4X1tA
X-Google-Smtp-Source: AGHT+IEQHsyy63fXJuethN+7qlhKfMWdBoIIKAtgX8+PIN/Q2aA9rZT/XAkpJM9zRndcI7cp6o4KMXZzYNFJBbSi9uQ=
X-Received: by 2002:a05:6402:a0d5:b0:61a:343a:f2f5 with SMTP id
 4fb4d7f45d1cf-61a7e748d60mr1616821a12.27.1755601569152; Tue, 19 Aug 2025
 04:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com> <20250815192156.272445-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250815192156.272445-3-mykyta.yatsenko5@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 19 Aug 2025 13:05:32 +0200
X-Gm-Features: Ac12FXwuLiFZ0ht3L2K2nqnu3ZIc-bLnTPVcNRbZMFIxe6KdIJsKUPQA-B9EVVI
Message-ID: <CAP01T75inm3sHbtJs28zhMMWk6CZKrdKnFvr01BJ93K7ab5ZiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: extract map key pointer calculation
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Aug 2025 at 21:22, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Calculation of the BPF map key, given the pointer to a value is
> duplicated in a couple of places in helpers already, in the next patch
> another use case is introduced as well.
> This patch extracts that functionality into a separate function.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Please carry acks from v1.

>  [...]

