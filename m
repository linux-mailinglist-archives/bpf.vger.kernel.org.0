Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1586F2C772E
	for <lists+bpf@lfdr.de>; Sun, 29 Nov 2020 02:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgK2B2d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Nov 2020 20:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgK2B2d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Nov 2020 20:28:33 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A97C0613D1;
        Sat, 28 Nov 2020 17:27:52 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id x24so7788347pfn.6;
        Sat, 28 Nov 2020 17:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xSepgUsabX0Wg6pRxscpQnFOnEiJ3js6nPX8R9LyS6Y=;
        b=CrhDf1sYjGXlvu6QFXpmI1d/2nB7ib0Vfz0AIWLxIigzjlq6a6tRaUOuIHagMq1zKT
         ZcirxUxx/d9hTI750lp6KFEhvk5ya6Z4eZ1+0GYVb41L6rq+nxVByq+XyWUrXNKBUjqu
         +YF2rrjvv3ptqYl+aIEquDuERh/5WzAE6B0SJqMa1F64m3zyzjGVhk2w9rfhGrZBXNIN
         Xlf9drPcob5NSpstSS3PaRTouLLyhawl6yQstLO8fLwmE5bJ2jZDb17dWRNImUi0IBKo
         Wf3VeX+wQrca96hMdrtN0np5f0Zecrx8er+T1u00/wC7634fyISps0P0A6buveK2Qrfw
         1eJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xSepgUsabX0Wg6pRxscpQnFOnEiJ3js6nPX8R9LyS6Y=;
        b=lZ1/UElNIx7KdwfLQI3X0UjHT27WPnNqpIgfEoS4tvMjrwepOGMFAqSP0STFa6d2Bn
         1HEVMZjRwTxs9T33QCI/+TBsm3jbKELpNTwJYiwiHxhHdF/ikKiDljYag19JHkIu983M
         Jq3zv5KUU+Tf5yn0PBHL0d+kE0Dm6ffsMd58ePcoimjQm7PcqPL8MAGEotbNkGk3uen5
         mGpY/riABy/l+TZCoe3UN72xVYKR282urIYZj9h7YcDd+z+AcEbHf42a18tEEpsggASP
         pTPMjJBAJkgAfrf30xMzxPL6d6JhnxO/wvuEWVKo31iL9ae8kyraf//CynI94C/XWi3a
         c4rw==
X-Gm-Message-State: AOAM531QM7HTiIlX0VDrMZNqH+le9pOFZkqYF68uEiRahlPqDMJoYn1u
        ZTG8RBqUn48HVi9+ebb33xM=
X-Google-Smtp-Source: ABdhPJy2zpMy2mmRQQzsnccVtoSiEyaulhPuhYnGA3z4qzmLEAqRLD6KVEqx/mWymFuloLBoY8moCg==
X-Received: by 2002:aa7:9429:0:b029:197:f974:c989 with SMTP id y9-20020aa794290000b0290197f974c989mr13379152pfo.30.1606613272273;
        Sat, 28 Nov 2020 17:27:52 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:5925])
        by smtp.gmail.com with ESMTPSA id fu5sm16620576pjb.11.2020.11.28.17.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 17:27:51 -0800 (PST)
Date:   Sat, 28 Nov 2020 17:27:48 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 08/13] bpf: Add instructions for
 atomic_[cmp]xchg
Message-ID: <20201129012748.i5rws2hvmqptfmy7@ast-mbp>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-9-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127175738.1085417-9-jackmanb@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 27, 2020 at 05:57:33PM +0000, Brendan Jackman wrote:
>  
>  /* atomic op type fields (stored in immediate) */
> -#define BPF_FETCH	0x01	/* fetch previous value into src reg */
> +#define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
> +#define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
> +#define BPF_FETCH	0x01	/* fetch previous value into src reg or r0*/

I think such comment is more confusing than helpful.
I'd just say that the fetch bit is not valid on its own.
It's used to build other instructions like cmpxchg and atomic_fetch_add.

> +		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> +			   insn->imm == (BPF_CMPXCHG)) {

redundant ().

> +			verbose(cbs->private_data, "(%02x) r0 = atomic%s_cmpxchg(*(%s *)(r%d %+d), r0, r%d)\n",
> +				insn->code,
> +				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
> +				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
> +				insn->dst_reg, insn->off,
> +				insn->src_reg);
> +		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> +			   insn->imm == (BPF_XCHG)) {

redundant ().
