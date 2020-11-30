Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3E42C895F
	for <lists+bpf@lfdr.de>; Mon, 30 Nov 2020 17:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgK3QYG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Nov 2020 11:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgK3QYG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Nov 2020 11:24:06 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD1FC0613D2
        for <bpf@vger.kernel.org>; Mon, 30 Nov 2020 08:23:25 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id d18so16904969edt.7
        for <bpf@vger.kernel.org>; Mon, 30 Nov 2020 08:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Q8duByOZefS2/jFG8Hwrvsv86yFk6gZ1iSV/8ksBpEE=;
        b=aGQcYePTV/wvNSWnQBw6+ya55y+q5crY2e4Y8IevpRwx21mtQtQApt1FSnbE7J4/F3
         5j3JpPOaRWlJmrf8+dPPtWBvtivavKiAI+/OByT96s1pGNhsCoWLN53hoBNDX3kBszBm
         cdupVX2e2SE29fn8cvvi0iGle82ASmeamS5rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Q8duByOZefS2/jFG8Hwrvsv86yFk6gZ1iSV/8ksBpEE=;
        b=pUqH6tfcX1BKMen8rXrxyJ7a1hA7kEPJqwp9Ahup6f2+TmryqtqeFbM40LTHfar39p
         MzyqBKs3LpNXZ+B8H6SJ27Tvz7xEA77tzUZvS/LnarCRqKT0kcdench15EQRrc4J2xlt
         8J2/CC1A6kFb3+GUaVYWLAgQSW6IP0l7Be/hJyd2vhKF0slFT61I8opSEkc5Y/WZr/l0
         AOHu516PuVFsQlmLAYME/ICzv4Yw+PxYQCUfRrlWJ90gNB0njA4wxBQ2NR4bwHAkmdqb
         FiXbj5immhRyTD7z6/tBZ74oSGk2X+fm3vWN0+kONjgDvEjFi9GpNdHk/Qi8x7uqsb6o
         5wDw==
X-Gm-Message-State: AOAM533R63hXNd8AFqHrHqPC7YSMObTEoQ4ejRJ5F+gG069wLr2mu7Vq
        0CPiBd4vC/QVh+FcKy6180Vorg==
X-Google-Smtp-Source: ABdhPJxCdI1Ss0iIn1vBl8ai9BuEF5tfnbRaliQ6HICmvY7HSX/0aopwWSQDPjKfYpD8cgDzLyz+pw==
X-Received: by 2002:aa7:d545:: with SMTP id u5mr22345779edr.113.1606753404199;
        Mon, 30 Nov 2020 08:23:24 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id f13sm8667325ejf.42.2020.11.30.08.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 08:23:23 -0800 (PST)
Message-ID: <7c75919c4b05cbe5952826d67b6e57a95b544a5a.camel@chromium.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
From:   Florent Revest <revest@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 30 Nov 2020 17:23:22 +0100
In-Reply-To: <20201129010705.7djnqmztkjhqlrdt@ast-mbp>
References: <20201126165748.1748417-1-revest@google.com>
         <20201129010705.7djnqmztkjhqlrdt@ast-mbp>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 2020-11-28 at 17:07 -0800, Alexei Starovoitov wrote:
> On Thu, Nov 26, 2020 at 05:57:47PM +0100, Florent Revest wrote:
> > This helper exposes the kallsyms_lookup function to eBPF tracing
> > programs. This can be used to retrieve the name of the symbol at an
> > address. For example, when hooking into nf_register_net_hook, one
> > can
> > audit the name of the registered netfilter hook and potentially
> > also
> > the name of the module in which the symbol is located.
> > 
> > Signed-off-by: Florent Revest <revest@google.com>
> > ---
> >  include/uapi/linux/bpf.h       | 16 +++++++++++++
> >  kernel/trace/bpf_trace.c       | 41
> > ++++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h | 16 +++++++++++++
> >  3 files changed, 73 insertions(+)
> > 
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index c3458ec1f30a..670998635eac 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -3817,6 +3817,21 @@ union bpf_attr {
> >   *		The **hash_algo** is returned on success,
> >   *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
> >   *		invalid arguments are passed.
> > + *
> > + * long bpf_kallsyms_lookup(u64 address, char *symbol, u32
> > symbol_size, char *module, u32 module_size)
> > + *	Description
> > + *		Uses kallsyms to write the name of the symbol at
> > *address*
> > + *		into *symbol* of size *symbol_sz*. This is guaranteed
> > to be
> > + *		zero terminated.
> > + *		If the symbol is in a module, up to *module_size* bytes
> > of
> > + *		the module name is written in *module*. This is also
> > + *		guaranteed to be zero-terminated. Note: a module name
> > + *		is always shorter than 64 bytes.
> > + *	Return
> > + *		On success, the strictly positive length of the full
> > symbol
> > + *		name, If this is greater than *symbol_size*, the
> > written
> > + *		symbol is truncated.
> > + *		On error, a negative value.
> 
> Looks like debug-only helper.
> I cannot think of a way to use in production code.
> What program suppose to do with that string?
> Do string compare? BPF side doesn't have a good way to do string
> manipulations.
> If you really need to print a symbolic name for a given address
> I'd rather extend bpf_trace_printk() to support %pS

We actually use this helper for auditing, not debugging.
We don't want to parse /proc/kallsyms from userspace because we have no
guarantee that the module will still be loaded by the time the event
reaches userspace (this is also faster in kernelspace).

