Return-Path: <bpf+bounces-15049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7957EAC00
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 09:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE20D281055
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 08:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C09C14F7B;
	Tue, 14 Nov 2023 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky6C859l"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5756E14AA0
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 08:48:49 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F44D5D
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 00:48:47 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9e62f903e88so572783166b.2
        for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 00:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951725; x=1700556525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGd5GbNcrcb6EqLFiZCnrcK2mof7l6JaU5Pg0zmy42g=;
        b=ky6C859l2hyf2vAE8IiTCA88ogX9RkMzbPTQa1B6I/QeJToqF/l7k36qFNVLSLZbfh
         qly2S8rZk5Ess21AiCC/1kkKe7UDeYbudk/1ha5BIVv6Oc5dEqeBVsUZoW2Xc+4JbN+F
         W4iGENf9P8EIPAFUDgtLrito/lAP+cawQJzOU3VdHEjzojGaCYsFYv4cXeTMikn6h65d
         Hu0nx6Yj8kEh1Z6WzBqXs3gpV9kC8whF35gg0RCL6xVHdSRmoGVrj3Aywtf78amoH2AH
         119jXkPcjGgp/e9zO86W2Q43XeN4vqihnTB1L1Q5WA183D5VoVVBtxslND21BC3//ZHc
         wvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951725; x=1700556525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGd5GbNcrcb6EqLFiZCnrcK2mof7l6JaU5Pg0zmy42g=;
        b=FvNx4iggDMesSQLK/aJpeMMoc+Y71zBxAfSAm37rtr1cj7YEzWyeciOEq8lGFdE+4j
         dWB4sc6uPcHbEyWz2OoH468oNdP7hSxcs5vHfNN2Ib1pWd6zzpNupRFTYu+eIMX49N9q
         cANhSiZ5u1SYLyqucc7InL3LiNLRcagg48PIQDIFyWRG7SdXJ9K4LsTqEPAzc2kOaodZ
         oIiHS0O3M/k2iQnHNmc2X4UOYCUedgxRGx3IcAOFBbo1j0eF9rS/nmd39YVlPweaRmZS
         8Bj4vzsv2tyAEULpgyXGaY6sXGIYO84u2Xk4uVk8+ok4M0S4O2eIaCCHRUjnbcQMcrSC
         5nag==
X-Gm-Message-State: AOJu0YzApiXmMqOoP7Mrmesl+GH/dO8IZfZhb0xG5txnFYHVqHa6khgX
	thYWCo/EcYRUU5mxqD5uY9qLF0NQxc2PaA==
X-Google-Smtp-Source: AGHT+IFxe49+3LTKudXwTqKwF+74lxrZL5ZdRUnVF9yep+kUcTCzd8CXITvQbouK0BtoKtzn6ts11A==
X-Received: by 2002:a17:906:3655:b0:9ae:5253:175b with SMTP id r21-20020a170906365500b009ae5253175bmr7530610ejb.34.1699951725256;
        Tue, 14 Nov 2023 00:48:45 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709066c8c00b0099cd008c1a4sm5218090ejr.136.2023.11.14.00.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:48:44 -0800 (PST)
Date: Tue, 14 Nov 2023 09:45:12 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev
Subject: Re: [RFC PATCH bpf-next] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <20231114084512.zaqcwqohu3syy7tx@erthalion.local>
References: <20231114084118.11095-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114084118.11095-1-9erthalion6@gmail.com>

> On Tue, Nov 14, 2023 at 09:41:17AM +0100, Dmitrii Dolgov wrote:
> Currently, it's not allowed to attach an fentry/fexit prog to another
> one of the same type. At the same time it's not uncommon to see a
> tracing program with lots of logic in use, and the attachment limitation
> prevents usage of fentry/fexit for performance analysis (e.g. with
> "bpftool prog profile" command) in this case. An example could be
> falcosecurity libs project that uses tp_btf tracing programs.
>
> Following the corresponding discussion [1], the reason for that is to
> avoid tracing progs call cycles without introducing more complex
> solutions. Relax "no same type" requirement to "no progs that are
> already an attach target themselves" for the tracing type. In this way
> only a standalone tracing program (without any other progs attached to
> it) could be attached to another one, and no cycle could be formed. To
> implement, add a new field into bpf_prog_aux to track the fact of
> attachment in the target prog.
>
> As a side effect of this change alone, one could create an unbounded
> chain of tracing progs attached to each other. Similar issues between
> fentry/fexit and extend progs are addressed via forbidding certain
> combinations that could lead to similar chains. Introduce an
> attach_depth field to limit the attachment chain, and display it in
> bpftool.

From what I see currently it's not possible to achieve such a call cycle
with tracing programs (even without the verifier check addressed in this
patch), so I had to test this change on a modified kernel with a couple
of other checks disabled as well. But otherwise I would appreciate
feedback about whether it's a reasonable thing to do.

