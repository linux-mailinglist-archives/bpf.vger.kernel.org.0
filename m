Return-Path: <bpf+bounces-11291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CF17B7075
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 20:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6AF9B2813ED
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 18:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7EF3B7B2;
	Tue,  3 Oct 2023 18:01:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8783B2AC
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 18:01:57 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E547B8E
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 11:01:55 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c63164a2b6so749865ad.0
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696356115; x=1696960915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WIEs0spWhvaEHG95pFwuv48zQavbPlVczjWUoofRLvY=;
        b=Q07yIE+9jrF6GbHU+6dioZLA/BkJE7GfUkZxXGIV29uqDGdBoSscyMPRxTxUkHTek3
         vPGCAiB1rWQFUFYLJB2C38oa/3b2Tj5Tiq1mfPPkUxDU70Kzz3VFET3NAFXz+/APmVCG
         oW8lNredpQ+e3ijEmsS5qKia1XGDy3ZnS7ZAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696356115; x=1696960915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIEs0spWhvaEHG95pFwuv48zQavbPlVczjWUoofRLvY=;
        b=ToFsNmp9Sg+/L/7GNRFgTD1AdOD4xFf13wMIFFRaXiWDoHm4OTqev8XWalq9EFYWgZ
         ZFYj4BWV1iF21pjfXk0z3DUemBN2ykC2OSi3E8N3b88QpQtxE+80i/5/SfmIg5q1lirJ
         WDi2Lg/IxMFn6kZRQZRinemHukhR2/mMNnI6UUU20MtLtHiULCv2P2qgNetXhiphstPu
         Wxotb/mineMRXM1xCj5jinhwslFwYgTvzl9eYIhYdHIO8YMWLRjp7FzDXGwOIF2HuXHy
         7RKVp0t0aLmdKOm79N8IvHN4iKVAEUzZXqqVXC3DWxlTOcNXoEuG3LLJo/nfZqaxlpcR
         3aaw==
X-Gm-Message-State: AOJu0YxjkotcILZihXQwq/AlWpdBI57AxEbc0G+t9yNk3MaCOu2SE2wE
	MXOCL50l86AWiGoyDzZMpVw89gzf77kIDaxJAoo=
X-Google-Smtp-Source: AGHT+IGQuYedujS5kNDFRvw8q00AWr3VtUBV4px6923t5RAzuQtWsRlCcwky6+l2eLHYCuoFEf4m6w==
X-Received: by 2002:a17:902:ab4a:b0:1c6:2866:5aeb with SMTP id ij10-20020a170902ab4a00b001c628665aebmr4179906plb.9.1696356115345;
        Tue, 03 Oct 2023 11:01:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id be8-20020a170902aa0800b001c74876f032sm1888209plb.162.2023.10.03.11.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 11:01:54 -0700 (PDT)
Date: Tue, 3 Oct 2023 11:01:52 -0700
From: Kees Cook <keescook@chromium.org>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, luto@amacapital.net,
	wad@chromium.org, alexyonghe@tencent.com
Subject: Re: [RFC PATCH 0/2] seccomp: Split set filter into two steps
Message-ID: <202310031055.3F19F87@keescook>
References: <20231003083836.100706-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003083836.100706-1-hengqi.chen@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 08:38:34AM +0000, Hengqi Chen wrote:
> This patchset introduces two new operations which essentially
> splits the SECCOMP_SET_MODE_FILTER process into two steps:
> SECCOMP_LOAD_FILTER and SECCOMP_ATTACH_FILTER.
> 
> The SECCOMP_LOAD_FILTER loads the filter and returns a fd
> which can be pinned to bpffs. This extends the lifetime of the
> filter and thus can be reused by different processes.
> With this new operation, we can eliminate a hot path of JITing
> BPF program (the filter) where we apply the same seccomp filter
> to thousands of micro VMs on a bare metal instance.
> 
> The SECCOMP_ATTACH_FILTER is used to attach a loaded filter.
> The filter is represented by a fd which is either returned
> from SECCOMP_LOAD_FILTER or obtained from bpffs using bpf syscall.

Interesting! I like this idea, thanks for writing it up.

Two design notes:

- Can you reuse/refactor seccomp_prepare_filter() instead of duplicating
  the logic into two new functions?

- Is there a way to make sure the BPF program coming from the fd is one
  that was built via SECCOMP_LOAD_FILTER? (I want to make sure we can
  never confuse a non-seccomp program into getting loaded into seccomp.)

-Kees

-- 
Kees Cook

