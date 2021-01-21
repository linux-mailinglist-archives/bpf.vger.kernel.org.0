Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDD52FEC7B
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 14:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbhAUNkF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 08:40:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730597AbhAUNjM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 08:39:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4ED9239EB;
        Thu, 21 Jan 2021 13:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611236310;
        bh=ZBJzqWqHWOBxIgOlok6VImUdP65BcvCHCmaZY8P6Pow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I2IdEpQsYE5SYLMTIadMkT/FDJ4AswfAx9zDUQWr7As8SKFCtON3STZ83NqoGjrYG
         U6+NeIlkl1aAeLej3cff+62o5fx8Bte1firgMOTO+wP3kSBlVi35yNlvV5gVFbQITn
         NB/p+Q6wZP3jBD4HE1OsstluuriuQX0gpCoqXoJSFkIA6fcfKZJJOgwjBIBjnXk3kY
         gOqBLDLHBTDMjYdU6IsMVN1yJrBd7Vw2xmLqtX5gsE8I3u0BcMlEs8vSXcYK8S0RsE
         vQCqZQldRCU69nJK2nDlrPbFGuGLlVoEtRSeWHDndYtnEzYn5gxnPmmu6f6Ku9fChj
         WX6klC6B+tV9w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CBA7640513; Thu, 21 Jan 2021 10:38:25 -0300 (-03)
Date:   Thu, 21 Jan 2021 10:38:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tom Stellard <tstellar@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] btf_encoder: Add extra checks for symbol names
Message-ID: <20210121133825.GB12699@kernel.org>
References: <20210112184004.1302879-1-jolsa@kernel.org>
 <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jan 12, 2021 at 04:27:59PM -0800, Tom Stellard escreveu:
> On 1/12/21 10:40 AM, Jiri Olsa wrote:
> > When processing kernel image build by clang we can
> > find some functions without the name, which causes
> > pahole to segfault.
> > 
> > Adding extra checks to make sure we always have
> > function's name defined before using it.
> > 
> 
> I backported this patch to pahole 1.19, and I can confirm it fixes the
> segfault for me.

I'm applying v2 for this patch and based on your above statement I'm
adding a:

Tested-by: Tom Stellard <tstellar@redhat.com>

Ok?

Who originally reported this?

- Arnaldo
 
> -Tom
> 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >   btf_encoder.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 333973054b61..17f7a14f2ef0 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -72,6 +72,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
> >   	if (elf_sym__type(sym) != STT_FUNC)
> >   		return 0;
> > +	if (!elf_sym__name(sym, btfe->symtab))
> > +		return 0;
> >   	if (functions_cnt == functions_alloc) {
> >   		functions_alloc = max(1000, functions_alloc * 3 / 2);
> > @@ -730,9 +732,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >   		if (!has_arg_names(cu, &fn->proto))
> >   			continue;
> >   		if (functions_cnt) {
> > -			struct elf_function *func;
> > +			const char *name = function__name(fn, cu);
> > +			struct elf_function *func = NULL;
> > -			func = find_function(btfe, function__name(fn, cu));
> > +			if (name)
> > +				func = find_function(btfe, name);
> >   			if (!func || func->generated)
> >   				continue;
> >   			func->generated = true;
> > 
> 

-- 

- Arnaldo
