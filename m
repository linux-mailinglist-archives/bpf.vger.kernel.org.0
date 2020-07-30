Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8133232EB5
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 10:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgG3I3M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jul 2020 04:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgG3I3L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jul 2020 04:29:11 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C340FC061794
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 01:29:10 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id g19so13291904ejc.9
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 01:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YBY55dkNJa6MNA1jcnxEfs+ZojHip66cdlon0CLkLZo=;
        b=fBwCfM3rpVy2pygAPHKVmWM18+gil7jTPat96H4u/Gm1341wxS3sJ+mdOPhd0Ut2gt
         RGcV9uVmJNYF/aox3YJfC339GEOZyKzkvnig7ENn+Ejdhc3AjAgNrZhFKAgMljasBEz1
         HJDwzRVIamhLhFbHFIM5sP6ok6r4YcePymvRopVYR31uyoVTYDKPtjD/kaUQNEMsbrWe
         fPrrd+MBFMzEcT8plABi1N+MFxOSMXtsug3boBgJitNyx6gMbxnULwyy8moTml4yYj7h
         bTR4nD9JeIEUG8hkrNRaXL9u4HeGM1UIvKJCsKhfWnw1LUsAHJTCdFyno5UVFlf+gTKU
         JtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YBY55dkNJa6MNA1jcnxEfs+ZojHip66cdlon0CLkLZo=;
        b=rHQ1S6H4a+MQwAhPB37rP8slHiLgcSvpD4tiBD+vsfYRPbWHwo54dKUFebD/jxYCgx
         13Wn0xxUbOZ8YzZj7ak/7kE3aNf7Ka1Dzm8fKEmZZr6CLhAXc74IBhwO/AcC57kffmk0
         Q4oyPlXwH8GFcMmXlSj/taBi7zsUdbkMwDQL3r0DK2JGgOFniQBbEtokRrgybTT7pz8O
         8jBZ9ai6P3nWVYt8BfqIGBLq6SW7GQCB8mV6JjIsrk7oJNKrXkX9DEWhpfKQXA3MaFIN
         kgOX3QFO1nS7F+xd1Erww507Aso37ghM5fZmflVPPVEwcqOKXruwS3OLU4ouNblLgcSV
         zCPg==
X-Gm-Message-State: AOAM5301ONXrTw/YXdEHtofexLq75eP+IJWRJaO8HagOcPq7f44eJku0
        HvzgIM+mMtV8BQFUpxdCWEcvjA==
X-Google-Smtp-Source: ABdhPJxdK8dE2vli7YDSeq7BM4kuHoJGKCZ1PXuThc9tOBZnCVx4E2ji9ZYap5m6mQi1LmC8Wm6O8g==
X-Received: by 2002:a17:907:204e:: with SMTP id pg14mr1606214ejb.324.1596097749512;
        Thu, 30 Jul 2020 01:29:09 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id ay5sm5190070edb.2.2020.07.30.01.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 01:29:08 -0700 (PDT)
Date:   Thu, 30 Jul 2020 10:28:53 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Song Liu <song@kernel.org>, linux-arm-kernel@lists.infradead.org,
        bpf <bpf@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, zlim.lnx@gmail.com,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH bpf-next 1/1] arm64: bpf: Add BPF exception tables
Message-ID: <20200730082853.GA1529030@myrica>
References: <20200728152122.1292756-1-jean-philippe@linaro.org>
 <20200728152122.1292756-2-jean-philippe@linaro.org>
 <CAPhsuW5CmQzELjc8+tQVWZStjPxENhGB7066YJLp=ANs8BYiHA@mail.gmail.com>
 <4791872a-9f7e-1c1c-392c-8b68a13091e3@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4791872a-9f7e-1c1c-392c-8b68a13091e3@iogearbox.net>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 29, 2020 at 11:29:43PM +0200, Daniel Borkmann wrote:
> On 7/29/20 7:28 PM, Song Liu wrote:
> > On Tue, Jul 28, 2020 at 8:37 AM Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > > 
> > > When a tracing BPF program attempts to read memory without using the
> > > bpf_probe_read() helper, the verifier marks the load instruction with
> > > the BPF_PROBE_MEM flag. Since the arm64 JIT does not currently recognize
> > > this flag it falls back to the interpreter.
> > > 
> > > Add support for BPF_PROBE_MEM, by appending an exception table to the
> > > BPF program. If the load instruction causes a data abort, the fixup
> > > infrastructure finds the exception table and fixes up the fault, by
> > > clearing the destination register and jumping over the faulting
> > > instruction.
> > > 
> > > To keep the compact exception table entry format, inspect the pc in
> > > fixup_exception(). A more generic solution would add a "handler" field
> > > to the table entry, like on x86 and s390.
> > > 
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > This patch looks good to me.
> > 
> > Acked-by: Song Liu <songliubraving@fb.com>
> 
> +1, applied, thanks a lot!
> 
> > It is possible to add a selftest for this? I thought about this a
> > little bit, but
> > didn't get a good idea.
> 
> Why not adding a test_verifier.c test case which calls into bpf_get_current_task()
> to fetch pointer to current and then read out some field via BPF_PROBE_MEM which
> should then succeed on x86/s390x/arm64 but be skipped on the other archs? Jean-Philippe,
> could you look into following up with such test case(s)?

Sure I'll take a look. Ilya also added a selftests to trigger exceptions
in https://lore.kernel.org/bpf/20200715233301.933201-5-iii@linux.ibm.com/
It's useful but I think it relies on the verifier not mandating NULL
checks for next-level pointers (they are ptr_ instead of ptr_or_null_),
which might change in the future. So I'm wondering if we can deliberately
access an invalid pointer with the help of bpf_test_run, and check that
the result is zero. 

Thanks,
Jean
