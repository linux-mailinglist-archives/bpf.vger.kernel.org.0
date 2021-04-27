Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354BF36C63D
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 14:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbhD0MoR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 08:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237609AbhD0MoM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 27 Apr 2021 08:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619527408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=07wOgPW9dB/cel9XTXNEQi8cZjIP+YUY1hWOxH332nY=;
        b=ZtL9xOIsschrJ8v5YuRGgj1jsGIGk0OxSmruQJifSWmceqZqjuCCxa6LP3G1GbwDk3ZNJ2
        sGVURK4/UKQ9o/soSBlQeqlkB2kjjVe+1aFWA3YGAKnm7fSwQLgTfIK3mCj452NERw7hKy
        9fcDMuTVgpJBxYrgnyb2p2xjHcIXINU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-M9K6e4PCOSSJwhWL53KjTA-1; Tue, 27 Apr 2021 08:43:26 -0400
X-MC-Unique: M9K6e4PCOSSJwhWL53KjTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEFE36D241;
        Tue, 27 Apr 2021 12:43:24 +0000 (UTC)
Received: from krava (unknown [10.40.192.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id E96906064B;
        Tue, 27 Apr 2021 12:43:22 +0000 (UTC)
Date:   Tue, 27 Apr 2021 14:43:22 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH dwarves] btf: Generate btf for functions in the .BTF_ids
 section
Message-ID: <YIgG6hIgbYqICJxl@krava>
References: <20210423213728.3538141-1-kafai@fb.com>
 <CAEf4BzY16ziMkOMdNGNjQOmiACF3E5nFn2LhtUUQbo-y-AP7Tg@mail.gmail.com>
 <YIf3rHTLqW7yZxFJ@krava>
 <YIgE1hAaa3Hzwni8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIgE1hAaa3Hzwni8@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 27, 2021 at 09:34:30AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Apr 27, 2021 at 01:38:20PM +0200, Jiri Olsa escreveu:
> > On Mon, Apr 26, 2021 at 04:26:11PM -0700, Andrii Nakryiko wrote:
> > > On Fri, Apr 23, 2021 at 2:37 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > BTF is currently generated for functions that are in ftrace list
> > > > or extern.
> > > >
> > > > A recent use case also needs BTF generated for functions included in
> > > > allowlist.  In particular, the kernel
> > > > commit e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist for bpf-tcp-cc")
> > > > allows bpf program to directly call a few tcp cc kernel functions.  Those
> > > > functions are specified under an ELF section .BTF_ids.  The symbols
> > > > in this ELF section is like __BTF_ID__func__<kernel_func>__[digit]+.
> > > > For example, __BTF_ID__func__cubictcp_init__1.  Those kernel
> > > > functions are currently allowed only if CONFIG_DYNAMIC_FTRACE is
> > > > set to ensure they are in the ftrace list but this kconfig dependency
> > > > is unnecessary.
> > > >
> > > > pahole can generate BTF for those kernel functions if it knows they
> > > > are in the allowlist.  This patch is to capture those symbols
> > > > in the .BTF_ids section and generate BTF for them.
> 
> > > I wonder if we just record all functions how bad that would be. Jiri,
> > > do you remember from the time you were experimenting with static
> > > functions how much more functions we'd be recording if we didn't do
> > > ftrace filtering?
>  
> > hum, I can't find that.. but should be just matter of removing
> > that is_ftrace_func check
>  
> > if we decided to do that, maybe we could add some bit indicating
> > that the function is traceable? it would save us check with
> > available_filter_functions file
> 
> You mean encoding it in BTF, in 'struct btf_type'? Seems important to
> have it, there are free bits there:
> 
> /* Max # of type identifier */
> #define BTF_MAX_TYPE    0x000fffff
> /* Max offset into the string section */
> #define BTF_MAX_NAME_OFFSET     0x00ffffff
> /* Max # of struct/union/enum members or func args */
> #define BTF_MAX_VLEN    0xffff
> 
> struct btf_type {
>         __u32 name_off;
>         /* "info" bits arrangement
>          * bits  0-15: vlen (e.g. # of struct's members)
>          * bits 16-23: unused
>          * bits 24-27: kind (e.g. int, ptr, array...etc)
>          * bits 28-30: unused
>          * bit     31: kind_flag, currently used by
>          *             struct, union and fwd
>          */
>         __u32 info;
>         /* "size" is used by INT, ENUM, STRUCT, UNION and DATASEC.
>          * "size" tells the size of the type it is describing.
>          *
>          * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
>          * FUNC, FUNC_PROTO and VAR.
>          * "type" is a type_id referring to another type.
>          */
>         union {
>                 __u32 size;
>                 __u32 type;
>         };
> };
> 
> And tools that expect to trace a function can get that information from
> the BTF info instead of getting some failure when trying to trace those
> functions, right?

yep, if it's possible to spare some bit for this info

jirka

