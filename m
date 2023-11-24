Return-Path: <bpf+bounces-15789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8371D7F69F7
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 01:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422A2281770
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 00:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E12F639;
	Fri, 24 Nov 2023 00:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeWOwUPJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CBDD44;
	Thu, 23 Nov 2023 16:53:15 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-54af1776bc5so177403a12.0;
        Thu, 23 Nov 2023 16:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700787194; x=1701391994; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QS8CVpY2dRIE9/ItXow6oOuaCdUNl5jE9qUR+XAHyUg=;
        b=EeWOwUPJxFxlvwM4yQ5YQVNx5Lm/YwPaL4xaTXeO/p2p/dUi9e7fOnZoYlMOXhUkEH
         7bkZx+vSC1fKYq8CX06mPQxsn4kTlrqsGDfhogeYjYdiCtfVgyvgsgFXwDYdhoM9xUx1
         29wjCftqbAb9CdqJNwxzkKz4QMERgW7HzEixfmeMYa+B6ccQ1UjkROE232eMSrODFLex
         /3ZoxfN21fcyZ5Fphil4XV1gECeMqNs0VseVI+dlRvwhYwF4JrIxZgLitUFRFDPaKCtF
         Nk9874ToXRTcl55MJQ49HZkN3xEbaUtyFh5zPseCOTKlxmV/plduwdEm9lfl0BtKqm6B
         1sSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700787194; x=1701391994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QS8CVpY2dRIE9/ItXow6oOuaCdUNl5jE9qUR+XAHyUg=;
        b=cbwMMde1Pg+Owhti9hPORR25znQciK1+BZ2SNQvCSWors7oymlQ8shEDyLGRhCxaHF
         Is1IDBIIBsO0UeTY4IJDrrHwD+hexTAMaT5rbXdW8nryAZURCVj8mBaMMfj9pPg9GTvE
         FYIpSwnZo3E/iYq/OrIr1oAah0rltkaRkIGGcZWLMTJ0mVtoRRuqX5O1pvfFAdwiGknk
         nkN7RkdqSKFpx9OzrHEqzRYDPB5qA7CqOFGSwUI3QNb1jRIQ8gCChkur8jCmx82fgYDd
         L+zbTvPh7pP3SGzW26e7YOrh0phk6WdFcffUFLeMXbSuAuYlUrUHKGUgJus+/or3AuZZ
         W6Cg==
X-Gm-Message-State: AOJu0Yxuiqu4e5xnUbJ+tkfqLPFf/8MrdE0yubuDWEI65iKgf7AKJdlA
	cgdC6MGzk61YA4D5vGpTAEe6T2rGxhT3bMZsp//WAnJhUE0=
X-Google-Smtp-Source: AGHT+IGzTE1+5yQw2oSsdNswRImIAfvmmX9ZG1e7hUvEAb+IPtk3pOyxZFP19bVMuYBUEsKCVhKt0PWNrXikDt+qgIE=
X-Received: by 2002:a17:906:10d:b0:a03:d8ea:a263 with SMTP id
 13-20020a170906010d00b00a03d8eaa263mr587176eje.16.1700787194247; Thu, 23 Nov
 2023 16:53:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202311231458.61e2502f-oliver.sang@intel.com>
In-Reply-To: <202311231458.61e2502f-oliver.sang@intel.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 24 Nov 2023 01:52:38 +0100
Message-ID: <CAP01T74ibZtsdssLB9WsSxP0SPusaNqfmzsqWz83T2H5TV30SQ@mail.gmail.com>
Subject: Re: [linus:master] [bpf] f18b03faba: stress-ng.seccomp.ops_per_sec
 -2.0% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Nov 2023 at 01:41, kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a -2.0% regression of stress-ng.seccomp.ops_per_sec on:
>

Interesting. I'll take a look and investigate.
Thanks

>
> [...]

