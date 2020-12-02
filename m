Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B732CC3F0
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 18:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgLBRgl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 12:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgLBRgl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 12:36:41 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C13C0613CF;
        Wed,  2 Dec 2020 09:36:00 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id y74so2391894oia.11;
        Wed, 02 Dec 2020 09:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pLAAu7+sji8IJoCg+8UXEel91VK0p8PGWM0v3i7M3IE=;
        b=FF5+khDygMun8kdp3GfHydtG9WE1iWBNpgElfJAP6GPilfEqENd8MzWLR5qhXhhIel
         8mzLZ8yYy2NKZ8PkWWtL8pSu4xcmB2KjyRfLJHYJ+Vbq1hnxYrCqemJ72RY7MGxYEtl5
         j+NPbGQi5W1Qqm78GpuCUZaYio+/RMaWPOypPIHMlvwa1wSbiWvrOYmdJi0BaCnkEoUX
         9G07SOnsbDFJQHmTiR7LKiLVqNJlgbeoo05pNRdbA4Befbqf6AjgSPAE2dS/kz3zJMUu
         epNSrcQTsbVi73sGFtY3QBDObXVpVaRnGxNMY8D3q5VlCW+FwLM6+NNGqaQafDej2mq9
         ybCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLAAu7+sji8IJoCg+8UXEel91VK0p8PGWM0v3i7M3IE=;
        b=hRChTGqDT3M5tGheotIxlDrr1pWAzvNVx/yKEtoPlG9WJhTWbjc2NiRPW0MDCKMTMX
         3esDud4g/zypvkiGPSSyZaXTQPEu/qHGZ+4URWlUg8KTc5Fq1KyihPYC2JOyfcpdBFz4
         D6zPN7L7aiLxQQJ5zMg1LbF0joOUa8raflqN8+apj6bJK572QV6GSk6Lt+Tf8j5ly7W7
         0nS5RG31AIsD7uAyJUTegSLINMfk5RSaRA878USxf4JRVZeTkcBkAYebe1wusxU9aSnz
         Ps0gyIWRIuHvGadb3We49JvUizKRNK7yATgpBANGls6PNcKaPV7cG2Lxm4yFshbpxZXY
         7w7Q==
X-Gm-Message-State: AOAM531yHEhXAQWrhdR87hYfsEUCfHG2arcRpGvHZZN9g5iPTK6mQHBy
        92q10ZRmX8VC0RwWNAQrmBXL5Lff/4qzoDbqbrNjEbep
X-Google-Smtp-Source: ABdhPJzflpE5g+va0hQ1zauT1Uz1LkNKIltAwQzrnETknXlx5hyAE14jVC2GOBOmUJGoLNV4WTmBvSKKWFccWuABT5E=
X-Received: by 2002:a05:6808:562:: with SMTP id j2mr2375423oig.1.1606930560156;
 Wed, 02 Dec 2020 09:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com> <20201127175738.1085417-2-jackmanb@google.com>
 <20201129011552.jbepegeeo2lqv6ke@ast-mbp> <20201201121437.GB2114905@google.com>
 <CAADnVQJci_Fqq7d6GbUtivcmSgnPLbkwuH9MN30BhFomff=5rg@mail.gmail.com> <20201202105248.GA9710@google.com>
In-Reply-To: <20201202105248.GA9710@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 2 Dec 2020 09:35:49 -0800
Message-ID: <CAADnVQJNEcWgjH_HOwg=RSfLsbtD7NPtabVms=GoXwfNueb_+g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/13] bpf: x86: Factor out emission of ModR/M
 for *(reg + off)
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 2, 2020 at 2:52 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> Tue, Dec 01, 2020 at 09:50:00PM -0800, Alexei Starovoitov wrote:
> > On Tue, Dec 1, 2020 at 4:14 AM Brendan Jackman <jackmanb@google.com> wrote:
> > >
> > > On Sat, Nov 28, 2020 at 05:15:52PM -0800, Alexei Starovoitov wrote:
> > > > On Fri, Nov 27, 2020 at 05:57:26PM +0000, Brendan Jackman wrote:
> > > > > +/* Emit the ModR/M byte for addressing *(r1 + off) and r2 */
> > > > > +static void emit_modrm_dstoff(u8 **pprog, u32 r1, u32 r2, int off)
> > > >
> > > > same concern as in the another patch. If you could avoid intel's puzzling names
> > > > like above it will make reviewing the patch easier.
> > >
> > > In this case there is actually a call like
> > >
> > >   emit_modrm_dstoff(&prog, src_reg, dst_reg)
> >
> > emit_insn_prefix() ?
>
> Ah sorry, I thought you were talking about the _arg_ names.

I meant both. Arg names and helper name. Sorry for the confusion.
