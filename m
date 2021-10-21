Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AC74356AB
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 02:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhJUAKL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 20:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUAKL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 20:10:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C4AC06161C;
        Wed, 20 Oct 2021 17:07:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a15-20020a17090a688f00b001a132a1679bso1805364pjd.0;
        Wed, 20 Oct 2021 17:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JyQgagoQZSzTZxL2J4mkxpxPInrkdzrDivEAkUlihtQ=;
        b=p3pX7gihCX4twMBURgUKiz7Xe7Z8LQ1enaFG3QZahZhMU1ylIrxztbdqeUBQ9IaQwM
         I98Sz8Ikx9/qNv39F0M6AphOOFV0tZyBHsb7Q2mnO8EFa1MavBo2gcJ59pheeHj3xRf/
         y/hOTOnIPLu4WLBVyen+25AzMfuRHq93vGwEWWx+kGfBqTUVUQdhkazACUudPcG1Tehc
         w8P9T8u+2TTBXibAV96vp1PFPHcr/CoLxV4QbdOhTwGQh6pnjAEXPCVDwWxXZIVLfrOu
         LzF95xr81LhOY7HbNRnh/2+BnD+e04SwDrF3/N9IQjGlstkT1Rh1hbsOpkXLIWoTvUcS
         6pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JyQgagoQZSzTZxL2J4mkxpxPInrkdzrDivEAkUlihtQ=;
        b=XJ8m038rlZ50hEQd04jI0nAk5JJYAApc2nuyJPHaW/vI4WYud1k1YyCSXc9bxoDSkA
         iUJDcIOtBfKeShheuSQHgZ7lJD6B8CrrUm2EIETNuuzcDb5It5x0lgvUZH2E6SHSw6Wl
         YaIG9gNk7vO6BSP/xyvPS3YRqOasDi4gCLe14cSNaw6V72V23lXlFjcMTmx1diIa33ZH
         a61YeRtw1Yu4SSRQfYxD+jN/6Af1IkyIHAbKl1Wz5JUUcQP2mIN4huMhqIn2CQOiKrur
         poA3sUeppwRgIpN0vOqcn35huQSYFNMi4WHMoO5d8OH67GlTw82ttzqokzpAnFYsUEov
         0YQw==
X-Gm-Message-State: AOAM530Zn+lZdm/BLpQ7IwVw9p4pClfJEiGfOqkQxB+GlLTUr/zFBQbX
        vaAwBPQSs8LINx9pvd1B3JM=
X-Google-Smtp-Source: ABdhPJzBOT3rH5abeYVx7V2uFjlr74oQpHyMu5N8o/dH34j4QraK8a7aH/qnXruA7Q2ruFF7SWYe4g==
X-Received: by 2002:a17:902:d2c4:b0:13e:1272:884a with SMTP id n4-20020a170902d2c400b0013e1272884amr2085278plc.34.1634774875693;
        Wed, 20 Oct 2021 17:07:55 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8c95])
        by smtp.gmail.com with ESMTPSA id e2sm3637285pfd.137.2021.10.20.17.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 17:07:55 -0700 (PDT)
Date:   Wed, 20 Oct 2021 17:07:53 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <20211021000753.kdxtjl3nzre2zshb@ast-mbp.dhcp.thefacebook.com>
References: <20211020104442.021802560@infradead.org>
 <20211020105843.345016338@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020105843.345016338@infradead.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 20, 2021 at 12:44:56PM +0200, Peter Zijlstra wrote:
> +
> +	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_AMD)) {
> +		EMIT_LFENCE();
> +		EMIT2(0xFF, 0xE0 + reg);
> +	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
> +		emit_jump(&prog, reg_thunk[reg], ip);
> +	} else

One more question.
What's a deal with AMD? I thought the retpoline is effective on it as well.
lfence is an optimization or retpoline turned out to be not enough
in some cases?
