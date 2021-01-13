Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0D62F5206
	for <lists+bpf@lfdr.de>; Wed, 13 Jan 2021 19:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbhAMS2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jan 2021 13:28:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728291AbhAMS2x (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Jan 2021 13:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610562446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CkJfqlrhZCO/RL6+hkuCnLwCCDKQltu+1r15Qy5O0RU=;
        b=bWqfrKqBGgFjTNpUpMEWMFpmui8rScPS/cZD1I/SYMLdnDdadS2t+8FXYz1TcPypZdHX/X
        tkbpQ+CtaslntQWjA9ZxWC9YOx521Qn3IQTEMX7bF6qwdwORgzHwzFWA/XcaDteUvPguyS
        y3+4uTLSZuMBujizTMbg3KQ5aT26Lzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-91D2Uf0QNA62FVHRj9ejug-1; Wed, 13 Jan 2021 13:27:24 -0500
X-MC-Unique: 91D2Uf0QNA62FVHRj9ejug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D59BD15725;
        Wed, 13 Jan 2021 18:27:22 +0000 (UTC)
Received: from krava (unknown [10.40.195.134])
        by smtp.corp.redhat.com (Postfix) with SMTP id BCCEBE2EE;
        Wed, 13 Jan 2021 18:27:20 +0000 (UTC)
Date:   Wed, 13 Jan 2021 19:27:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Tom Stellard <tstellar@redhat.com>
Subject: Re: [PATCHv2] btf_encoder: Add extra checks for symbol names
Message-ID: <20210113182719.GA1358609@krava>
References: <20210113102509.1338601-1-jolsa@kernel.org>
 <2c933606-5591-cc20-9832-09a2549e9c58@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c933606-5591-cc20-9832-09a2549e9c58@fb.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 13, 2021 at 09:20:17AM -0800, Yonghong Song wrote:
> 
> 
> On 1/13/21 2:25 AM, Jiri Olsa wrote:
> > When processing kernel image build by clang we can
> > find some functions without the name, which causes
> > pahole to segfault.
> 
> Just curious. What kinds of functions gcc generates
> names and clang doesn't?

can't say.. I guess we could compare nm output
of both gcc and clang vmlinux for same .config

jirka

> 
> > 
> > Adding extra checks to make sure we always have
> > function's name defined before using it.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >    v2 changes:
> >      - reorg the code based on Andrii's suggestion
> > 
> >   btf_encoder.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 333973054b61..5557c9efd365 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -68,10 +68,14 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
> >   	struct elf_function *new;
> >   	static GElf_Shdr sh;
> >   	static int last_idx;
> > +	const char *name;
> >   	int idx;
> >   	if (elf_sym__type(sym) != STT_FUNC)
> >   		return 0;
> > +	name = elf_sym__name(sym, btfe->symtab);
> > +	if (!name)
> > +		return 0;
> >   	if (functions_cnt == functions_alloc) {
> >   		functions_alloc = max(1000, functions_alloc * 3 / 2);
> > @@ -94,7 +98,7 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
> >   		last_idx = idx;
> >   	}
> > -	functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
> > +	functions[functions_cnt].name = name;
> >   	functions[functions_cnt].addr = elf_sym__value(sym);
> >   	functions[functions_cnt].sh_addr = sh.sh_addr;
> >   	functions[functions_cnt].generated = false;
> > @@ -731,8 +735,13 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >   			continue;
> >   		if (functions_cnt) {
> >   			struct elf_function *func;
> > +			const char *name;
> > +
> > +			name = function__name(fn, cu);
> > +			if (!name)
> > +				continue;
> > -			func = find_function(btfe, function__name(fn, cu));
> > +			func = find_function(btfe, name);
> >   			if (!func || func->generated)
> >   				continue;
> >   			func->generated = true;
> > 
> 

