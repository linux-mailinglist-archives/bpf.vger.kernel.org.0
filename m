Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696BD36C61B
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 14:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbhD0MfR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 08:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235428AbhD0MfQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 08:35:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97F2760E09;
        Tue, 27 Apr 2021 12:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619526873;
        bh=9HTD8AyiNxGbA62qZdwNweo+GCKnEX4tk5LaRu3ggeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hG0YSkvC7zYZJI1hksjzkJvsn0OdcnpYxPDXK57rrDRACmeUOKWsFkQI29u1/buMF
         kpcUFHY6pu8lH2MrxRbM0k1hdoGOxn7ptnTI+a7c1dL6JVZ/BQJIo3e7UdMiX4Y8iP
         fqNcUITMvUib/lCPtF/IF1HadV/1UnOLt+owYqbrbI6ieFXQCBuNAaBnS+uKaa6SjH
         k90dEGB8oMjtKhjVcvO4ksL/lXZnJ7twOViNyzfkU/G/EV8Ey9S0/HG/Jxc/SkJ3wR
         QKEbBos9L8FkvOEpf4UnHQZYLWTDObOtGmQ0iLjeljwJm/j2Cp4ZEKnBOjdE55Pbqd
         UNr0hp/s9pG0Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B5F0140647; Tue, 27 Apr 2021 09:34:30 -0300 (-03)
Date:   Tue, 27 Apr 2021 09:34:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH dwarves] btf: Generate btf for functions in the .BTF_ids
 section
Message-ID: <YIgE1hAaa3Hzwni8@kernel.org>
References: <20210423213728.3538141-1-kafai@fb.com>
 <CAEf4BzY16ziMkOMdNGNjQOmiACF3E5nFn2LhtUUQbo-y-AP7Tg@mail.gmail.com>
 <YIf3rHTLqW7yZxFJ@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIf3rHTLqW7yZxFJ@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Apr 27, 2021 at 01:38:20PM +0200, Jiri Olsa escreveu:
> On Mon, Apr 26, 2021 at 04:26:11PM -0700, Andrii Nakryiko wrote:
> > On Fri, Apr 23, 2021 at 2:37 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > BTF is currently generated for functions that are in ftrace list
> > > or extern.
> > >
> > > A recent use case also needs BTF generated for functions included in
> > > allowlist.  In particular, the kernel
> > > commit e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist for bpf-tcp-cc")
> > > allows bpf program to directly call a few tcp cc kernel functions.  Those
> > > functions are specified under an ELF section .BTF_ids.  The symbols
> > > in this ELF section is like __BTF_ID__func__<kernel_func>__[digit]+.
> > > For example, __BTF_ID__func__cubictcp_init__1.  Those kernel
> > > functions are currently allowed only if CONFIG_DYNAMIC_FTRACE is
> > > set to ensure they are in the ftrace list but this kconfig dependency
> > > is unnecessary.
> > >
> > > pahole can generate BTF for those kernel functions if it knows they
> > > are in the allowlist.  This patch is to capture those symbols
> > > in the .BTF_ids section and generate BTF for them.

> > I wonder if we just record all functions how bad that would be. Jiri,
> > do you remember from the time you were experimenting with static
> > functions how much more functions we'd be recording if we didn't do
> > ftrace filtering?
 
> hum, I can't find that.. but should be just matter of removing
> that is_ftrace_func check
 
> if we decided to do that, maybe we could add some bit indicating
> that the function is traceable? it would save us check with
> available_filter_functions file

You mean encoding it in BTF, in 'struct btf_type'? Seems important to
have it, there are free bits there:

/* Max # of type identifier */
#define BTF_MAX_TYPE    0x000fffff
/* Max offset into the string section */
#define BTF_MAX_NAME_OFFSET     0x00ffffff
/* Max # of struct/union/enum members or func args */
#define BTF_MAX_VLEN    0xffff

struct btf_type {
        __u32 name_off;
        /* "info" bits arrangement
         * bits  0-15: vlen (e.g. # of struct's members)
         * bits 16-23: unused
         * bits 24-27: kind (e.g. int, ptr, array...etc)
         * bits 28-30: unused
         * bit     31: kind_flag, currently used by
         *             struct, union and fwd
         */
        __u32 info;
        /* "size" is used by INT, ENUM, STRUCT, UNION and DATASEC.
         * "size" tells the size of the type it is describing.
         *
         * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
         * FUNC, FUNC_PROTO and VAR.
         * "type" is a type_id referring to another type.
         */
        union {
                __u32 size;
                __u32 type;
        };
};

And tools that expect to trace a function can get that information from
the BTF info instead of getting some failure when trying to trace those
functions, right?

- Arnaldo
