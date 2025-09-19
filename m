Return-Path: <bpf+bounces-68955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA9FB8AE07
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 492857BA84E
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A01625D536;
	Fri, 19 Sep 2025 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9RyELWQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CFD2571C5
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305592; cv=none; b=pFzYrPZyQN+kyg3NAiRuwBWyd7Lj1z0px1AcjcmKlWjXkvcZWige6jEUYvwraSjTnknd5pYh3Oa0nlaH4Dy11y5CL16fE1+ZGjnkMRTVAH6V06mY97IHoMfQhp5B7zW5ad/SM2Fqac6j+3e4dchjG6rAsYfG1Is773eoquhJxtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305592; c=relaxed/simple;
	bh=jaY6ejGzMgXQA75oPGEkZmUwMwJGET/08F5M8zlsd2s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=K6lhNvYYevwOGsHqalGGgCjaJIUvxa7napNV4Ila3Ny+fI0uufoXJXCoomjGj5yoiRWe1taMDOD/ngxICSCtmCUyuzY74c7PTcuLsnnOILMT+ThBB7gS7/Q81oQUHqu4IiOF3fqKVCgYDKiCSuf3UZ3Tp+hMTVJAAEw5QSfpR5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9RyELWQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5526b7c54eso471761a12.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305590; x=1758910390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1ZeJg5CWqbF3IY/EPyUo+KxVGz14Tjmz+KQ4KkqtqRM=;
        b=b9RyELWQX9tH9bmkLO8H3gDwXIkxu59MYmPpC+QOswfqorSHdg7AoYsQRYbpE72IQ4
         jeeqhAKmj05S6ElXWguEwK6RfpR0v/8PBxZRhYW/zgSC2NgTT72fEKJlk5bL8OlFD7Bj
         RR/DuXz6moGLTEmd89+5sz2e1SmPLdYnCjPKpwQkz90vuC3eUOcCW+ZqXhMZNRVcbCSF
         /0GXTfsk0K9U3fxT1opp0hrfMHSRRIjWjBTMaMIT65hhudpiueJCI62tppTOhbugeHHs
         ZXCwowRTC8B+L775x4N+cBT9jsVigIz9yWr/cDj6nphhZuuBYD9hNIOTrUTx/qKIr8uj
         IVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305590; x=1758910390;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZeJg5CWqbF3IY/EPyUo+KxVGz14Tjmz+KQ4KkqtqRM=;
        b=HZTG/QqXmKc/ekuo+JPQ4VDXQ278RXMU+LFS+Dsf1YIETLaWnhaxMUBWRk2VaowSwQ
         6saERxB+vUEVykd5KMvT8wE9VszAax85UBmdJ/92Ky89lApyzOVVV0PeV4PFx5o6V32u
         qj/AsobGfdRnc2OIao+HHzZhOoP4HC8nS+pgzdRjOaMJ7Sdw8CZK8Y6vhqSNJXMD7iIM
         08qI4B4WsfNiCYW4QiaTPAKMJaa9oxe36ohT1xO7vPRKqnIQ3JJ7NOYS35CYGnj9ryq9
         sYEWHw51w5e3lVm8UVZN62Z3aSE83LMbXEJK/GRHPlXF8U/QnLyxyS68wWAbFK80QR+T
         6Tsg==
X-Gm-Message-State: AOJu0Yxw5ey5YYmYcOmXJBxVXo4fgIWfGhJr/+B2Xw1noL4Jag6qlaQb
	gUOafwU1lOV0byf6DllK/n3m3e+R0/uql2engELqe8f0NDfNxzl+EoBZ9G7FEg==
X-Gm-Gg: ASbGnctyC+Msg6k2xQW4UDUFpE+JNI776y/WMDRJkPNXIpNl+ntxS4/FazhFV4z/DB8
	JTRz/8WrBGUd6MxdRANPHfxEroa6P+Zm5IpjLU9cms0fZ+Kaztd1kkhUpVzJiuRn5TAS/ymadHB
	VcPtkbDow86ewwav0/I3ASkloZPn5/tju3EJ+2Dz6iVjf0WuJ92mBxUvK1d2U5+//H1LnX9sCHA
	gRSnp3crZ2b9gSmh1+yYL8OaMBG9wuoUyQZqjiaFuazz4+4XeIa4zvmLBCwIG7WKfUB/QG2mhpg
	gQ3HrPs0AUN8HAT8sF1a6yBnLE8gPy+xB8kCTpjq13LZkQk7vQw2q6MIMMVqEtI+rehcYgc9O5h
	nz2nt3XmFM+PT8hHQY9YlE+DYTb1Kw4FU1Ex959pr2MpoVB//77u/o6rKPLb/DhHxbYDUiccJdQ
	==
X-Google-Smtp-Source: AGHT+IGCL/sBx9Oro0ib1IiABvpyb8htBPym0mj+EhPRxKOWXoR2p/j0I4C4V+8NTmnuKjfjEwIE6w==
X-Received: by 2002:a17:902:d2d2:b0:25c:e4ab:c424 with SMTP id d9443c01a7336-269ba534e05mr69731175ad.33.1758305589727;
        Fri, 19 Sep 2025 11:13:09 -0700 (PDT)
Received: from [192.168.1.77] (c-76-146-12-100.hsd1.wa.comcast.net. [76.146.12.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980368dc1sm59570565ad.152.2025.09.19.11.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 11:13:09 -0700 (PDT)
Message-ID: <bb70ed5e-48cb-41e2-921f-591fd619f304@gmail.com>
Date: Fri, 19 Sep 2025 11:13:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/6] Add kfunc bpf_xdp_pull_data
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, paul.chaignon@gmail.com, kuba@kernel.org,
 stfomichev@gmail.com, martin.lau@kernel.org, mohsin.bashr@gmail.com,
 noren@nvidia.com, dtatulea@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, maciej.fijalkowski@intel.com, kernel-team@meta.com
References: <20250919180926.1760403-1-ameryhung@gmail.com>
Content-Language: en-US
In-Reply-To: <20250919180926.1760403-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/19/25 11:09 AM, Amery Hung wrote:

I sent the wrong one. I will resend v5. Sorry for spamming the list...

> v3 -> v4
>    patch 2
>    - Improve comments (Jakub)
>    - Drop new_end and len_free to simplify code (Jakub)
>
>    patch 4
>    - Instead of adding is_xdp to bpf_test_init, move lower-bound check
>      of user_size to callers (Martin)
>    - Simplify linear data size calculation (Martin)
>
>    patch 5
>    - Add static function identifier (Martin)
>    - Free calloc-ed buf (Martin)
>
> v2 -> v3
>    Separate mlx5 fixes from the patchset
>
>    patch 2
>    - Use headroom for pulling data by shifting metadata and data down
>      (Jakub)
>    - Drop the flags argument (Martin)
>
>    patch 4
>    - Support empty linear xdp data for BPF_PROG_TEST_RUN
>
>    Link: https://lore.kernel.org/bpf/20250915224801.2961360-1-ameryhung@gmail.com/
>
> v1 -> v2
>    Rebase onto bpf-next
>
>    Try to build on top of the mlx5 patchset that avoids copying payload
>    to linear part by Christoph but got a kernel panic. Will rebase on
>    that patchset if it got merged first, or separate the mlx5 fix
>    from this set.
>
>    patch 1
>    - Remove the unnecessary head frag search (Dragos)
>    - Rewind the end frag pointer to simplify the change (Dragos)
>    - Rewind the end frag pointer and recalculate truesize only when the
>      number of frags changed (Dragos)
>
>    patch 3
>    - Fix len == zero behavior. To mirror bpf_skb_pull_data() correctly,
>      the kfunc should do nothing (Stanislav)
>    - Fix a pointer wrap around bug (Jakub)
>    - Use memmove() when moving sinfo->frags (Jakub)
>
>    Link: https://lore.kernel.org/bpf/20250905173352.3759457-1-ameryhung@gmail.com/
>    
> ---
>
> Hi all,
>
> This patchset introduces a new kfunc bpf_xdp_pull_data() to allow
> pulling nonlinear xdp data. This may be useful when a driver places
> headers in fragments. When an xdp program would like to keep parsing
> packet headers using direct packet access, it can call
> bpf_xdp_pull_data() to make the header available in the linear data
> area. The kfunc can also be used to decapsulate the header in the
> nonlinear data, as currently there is no easy way to do this.
>
> Tested with the added bpf selftest using bpf test_run and also on
> mlx5 with the tools/testing/selftests/drivers/net/{xdp.py, ping.py}.
> mlx5 with striding RQ enabled always passse xdp_buff with empty linear
> data to xdp programs. xdp.test_xdp_native_pass_mb would fail to parse
> the header before this patchset.
>
> Thanks!
> Amery
>
> Amery Hung (6):
>    bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
>    bpf: Support pulling non-linear xdp data
>    bpf: Clear packet pointers after changing packet data in kfuncs
>    bpf: Support specifying linear xdp packet data size for
>      BPF_PROG_TEST_RUN
>    selftests/bpf: Test bpf_xdp_pull_data
>    selftests: drv-net: Pull data before parsing headers
>
>   include/net/xdp_sock_drv.h                    |  21 ++-
>   kernel/bpf/verifier.c                         |  13 ++
>   net/bpf/test_run.c                            |   9 +-
>   net/core/filter.c                             | 119 ++++++++++--
>   .../bpf/prog_tests/xdp_context_test_run.c     |   4 +-
>   .../selftests/bpf/prog_tests/xdp_pull_data.c  | 176 ++++++++++++++++++
>   .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
>   .../selftests/net/lib/xdp_native.bpf.c        |  89 +++++++--
>   8 files changed, 445 insertions(+), 34 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
>


