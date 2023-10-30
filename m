Return-Path: <bpf+bounces-13617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF107DBF6C
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 18:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4267E1C20B77
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 17:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BCA18E37;
	Mon, 30 Oct 2023 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvr8rCHZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B2D27F
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 17:55:19 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B14EAB
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 10:55:18 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5b92b852442so2817640a12.2
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 10:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698688518; x=1699293318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DcElisrk/XXkJu0CEacVa7QcZbtidSjbj0fkDgwamoU=;
        b=cvr8rCHZ1oxsJjzytSFSpzvOvRd+oEWHJvjfCSjftOXQX5me71kHoHZrMdIUMUdc0H
         qSRewexY36qbYssJxmGwbWSc57Rx0btutZQrdD4meyxKWz/0yMh+8jJDRiNrkVmZGe9q
         ZcHlux23aH0EkoDQ+jpIkOHKpgg30ON4YMDM5KTx5bJkrynTtzA/Pm7lwdAuNnJm+EcZ
         nchFpdgIUy3EiFVVy3SfCwV22ngxeApIH0Ii95x93Ds3ptPupO05Q3E2kSq/l+2kOuiL
         lv7NbJ6B+J7GnA5WSwNXN3l3tROMIH592mRheuFEaA9tAxOVDlA7L+l5fa9OgQ0ekEdY
         6v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698688518; x=1699293318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcElisrk/XXkJu0CEacVa7QcZbtidSjbj0fkDgwamoU=;
        b=kcnmr0cA+HdNqFkQbjJvMpc2HKbfJsB30o8zA/7Ius3zDsMstiV5Y7EaUppyPfxTo7
         RJLQne9A00ot8tU2EysX4nqSynS3nH6pQIh0wIbxZ5ZVnqJ4jVqxusupeeaRvB7v1Y7K
         X4DjTO24T141vye9L0yabu/kiDvvXEZ1Nts9pg6WNJRoscU2G8HviF1Ni2A0hYTTQItA
         9k/0WTe/ZVNHTPyT7s2DAtv+Rw1Rw3AMGeddb8G22lUrwJBmkew5I6x/fds/DWmRvKyQ
         58+O9P3CdNuYK4a2ShkvhOmkXb3RucQSvykQb70vwx6fYOD2XgSalzO9nGeNrD7ylyuh
         K1oA==
X-Gm-Message-State: AOJu0Yw0/GtRcvKRUdcoCtaO+xgbS1ooAhO9ldOJIFcLd5EKSnRQ4cez
	72HEOPyAzQrpbnIii0VTsGY=
X-Google-Smtp-Source: AGHT+IGPX9RbXcoiduL5xlbFY5jmeZiaJj08bIR7sBEqxljGUiKejLBbTc3K6Uqbls19MtTByEqGqA==
X-Received: by 2002:a05:6a20:a897:b0:163:2da1:387f with SMTP id ca23-20020a056a20a89700b001632da1387fmr6887213pzb.50.1698688517781;
        Mon, 30 Oct 2023 10:55:17 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2620:10d:c090:500::7:f772])
        by smtp.gmail.com with ESMTPSA id t14-20020a62d14e000000b006bdf4dfbe0dsm6632086pfl.12.2023.10.30.10.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 10:55:17 -0700 (PDT)
Date: Mon, 30 Oct 2023 10:55:13 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v5 bpf-next 00/23] BPF register bounds logic and testing
 improvements
Message-ID: <20231030175513.4zy3ubkpse2f6gqz@MacBook-Pro-49.local>
References: <20231027181346.4019398-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027181346.4019398-1-andrii@kernel.org>

On Fri, Oct 27, 2023 at 11:13:23AM -0700, Andrii Nakryiko wrote:
> 
> Note, this is not unique to <range> vs <range> logic. Just recently ([0])
> a related issue was reported for existing verifier logic. This patch set does
> fix that issues as well, as pointed out on the mailing list.
> 
>   [0] https://lore.kernel.org/bpf/CAEf4Bzbgf-WQSCz8D4Omh3zFdS4oWS6XELnE7VeoUWgKf3cpig@mail.gmail.com/

Quick comment regarding shift out of bound issue.
I think this patch set makes Hao Sun's repro not working, but I don't think
the range vs range improvement fixes the underlying issue.
Currently we do:
if (umax_val >= insn_bitness)
  mark_reg_unknown
else
  here were use src_reg->u32_max_value or src_reg->umax_value
I suspect the insn_bitness check is buggy and it's still possible to hit UBSAN splat with
out of bounds shift. Just need to try harder.
if w8 < 0xffffffff goto +2;
if r8 != r6 goto +1;
w0 >>= w8;
won't be enough anymore.

