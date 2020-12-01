Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA552C955B
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 03:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgLAClu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Nov 2020 21:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgLAClt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Nov 2020 21:41:49 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914B9C0613D3;
        Mon, 30 Nov 2020 18:41:09 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id x4so258888pln.8;
        Mon, 30 Nov 2020 18:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BrVuWJwHE9C9HRZa3NRj0IDooipk8e5AvGemnz8mYRM=;
        b=PIKbpzqAuWJPG0oIElTPcQ0eIgtZKO8Hh0sX3qC6sMiPGchjlwKZAa/f/VDVhb7ZGp
         W5SJ8lFKSuuDv+AS0PzMw/R7gSi+y/Yg6jWvlUsdDWZRR+ej89qF14ISUhz6JgN6Rdr0
         Gs5sf3s/YoPQLc7GlHAWzhKrbNI0yD8U0oBlrHuq1b2QO9cpgI46hyDDnJh6XbO52M1B
         iwnx1JIzG2UOLLoD0qjDIvKuAebQuuCizQpKq76T2ElNNPz0OfMT4th1JqLUnWKafqyU
         QAq9TvAw1VgbXw652YK9w3tFK8UzzehaJGgArpxP5jpdX2/JlzGsyZkGh0EAeHKtyOme
         qVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BrVuWJwHE9C9HRZa3NRj0IDooipk8e5AvGemnz8mYRM=;
        b=YKSSBnL2BufVlS4pKIxqrTO8n9qoiOvEKaIri07VC0ot9kVLe1MogOeG/lG7CAUYuW
         FI0jYT/EO1jDxC4OxMvvzLoK2eQEkWtcHCV2G+0szZ7BZsfilH0LN6XeM0GH8Dwpd1O4
         O6OtelqYyamKe7Z7kow7KbCn7w9K1866+9lygygByh3GJTavblEySuAb7EdEzTePxgRZ
         4eBDdhoNeK/aWnvO5lDCQD8iQVh91bTi7nv6Qtw4LGHKKo8XPpsRVTeP1P8Da5wlvhlN
         RJu3y2BAky6kPfSGC4xFKM4n3WP8h9rLzokpgEDX6zLcC2JXzUwyV0trSUwjC0+PWXVP
         5h+g==
X-Gm-Message-State: AOAM532EaNWgZbUZD3My+CPoZ9gjChHo5sEG8fhA7qxInN+MAPNnDKmP
        1gnBD0y6/go2uAb/Dl9nMXE=
X-Google-Smtp-Source: ABdhPJzhlxAWE5ydiJHchmaDYjh6Xplry78PBfwdCMXS4T6uBv4MgWtkPeWir7WCsK+zT/HtpUpuyA==
X-Received: by 2002:a17:902:c594:b029:da:8c9a:5d52 with SMTP id p20-20020a170902c594b02900da8c9a5d52mr689685plx.49.1606790469119;
        Mon, 30 Nov 2020 18:41:09 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:42ca])
        by smtp.gmail.com with ESMTPSA id j10sm292394pji.29.2020.11.30.18.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 18:41:08 -0800 (PST)
Date:   Mon, 30 Nov 2020 18:41:06 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
Message-ID: <20201201024106.k2jd5nysmokbymn5@ast-mbp>
References: <20201126165748.1748417-1-revest@google.com>
 <20201129010705.7djnqmztkjhqlrdt@ast-mbp>
 <7c75919c4b05cbe5952826d67b6e57a95b544a5a.camel@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c75919c4b05cbe5952826d67b6e57a95b544a5a.camel@chromium.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 30, 2020 at 05:23:22PM +0100, Florent Revest wrote:
> On Sat, 2020-11-28 at 17:07 -0800, Alexei Starovoitov wrote:
> > On Thu, Nov 26, 2020 at 05:57:47PM +0100, Florent Revest wrote:
> > > This helper exposes the kallsyms_lookup function to eBPF tracing
> > > programs. This can be used to retrieve the name of the symbol at an
> > > address. For example, when hooking into nf_register_net_hook, one
> > > can
> > > audit the name of the registered netfilter hook and potentially
> > > also
> > > the name of the module in which the symbol is located.
> > > 
> > > Signed-off-by: Florent Revest <revest@google.com>
> > > ---
> > >  include/uapi/linux/bpf.h       | 16 +++++++++++++
> > >  kernel/trace/bpf_trace.c       | 41
> > > ++++++++++++++++++++++++++++++++++
> > >  tools/include/uapi/linux/bpf.h | 16 +++++++++++++
> > >  3 files changed, 73 insertions(+)
> > > 
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index c3458ec1f30a..670998635eac 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -3817,6 +3817,21 @@ union bpf_attr {
> > >   *		The **hash_algo** is returned on success,
> > >   *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
> > >   *		invalid arguments are passed.
> > > + *
> > > + * long bpf_kallsyms_lookup(u64 address, char *symbol, u32
> > > symbol_size, char *module, u32 module_size)
> > > + *	Description
> > > + *		Uses kallsyms to write the name of the symbol at
> > > *address*
> > > + *		into *symbol* of size *symbol_sz*. This is guaranteed
> > > to be
> > > + *		zero terminated.
> > > + *		If the symbol is in a module, up to *module_size* bytes
> > > of
> > > + *		the module name is written in *module*. This is also
> > > + *		guaranteed to be zero-terminated. Note: a module name
> > > + *		is always shorter than 64 bytes.
> > > + *	Return
> > > + *		On success, the strictly positive length of the full
> > > symbol
> > > + *		name, If this is greater than *symbol_size*, the
> > > written
> > > + *		symbol is truncated.
> > > + *		On error, a negative value.
> > 
> > Looks like debug-only helper.
> > I cannot think of a way to use in production code.
> > What program suppose to do with that string?
> > Do string compare? BPF side doesn't have a good way to do string
> > manipulations.
> > If you really need to print a symbolic name for a given address
> > I'd rather extend bpf_trace_printk() to support %pS
> 
> We actually use this helper for auditing, not debugging.
> We don't want to parse /proc/kallsyms from userspace because we have no
> guarantee that the module will still be loaded by the time the event
> reaches userspace (this is also faster in kernelspace).

so what are you going to do with that string?
print it? send to user space via ring buffer?
Where are you getting that $pc ?
