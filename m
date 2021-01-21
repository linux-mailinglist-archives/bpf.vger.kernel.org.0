Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104602FF4BC
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 20:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbhAUTiF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 14:38:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbhAUThu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 14:37:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 244F623A3A;
        Thu, 21 Jan 2021 19:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611257829;
        bh=w7Mf+/YQ7cizKFbhh9DbozTH0EVRXMR4priG6Ci2Prw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldB52ZcBArYQG4KuBdXkJBLmSmWn+3uuvsH2LwM2HS0we/TpcHHYxrYx6/jnEGvws
         glpDHOg6NrgfnxKB62Qs4Oh8zrJ84ojXq9hGBR1u4mkDJdf4+PUeH+2VQJUtXo92yp
         3TpVyL7+eQogDiOeSX5HocSH7kifpaWigCh5AfieZl8kmIHA6twNKBqV46aXjH2RFO
         +SbanMwFtjXgkxgw2rkV1tjjjzGzrOTTm2rQnEz/HOBVs+x4x97uRWgwM9KGzvrIAe
         w5Fyf+beFXDnFX5SxNuxOV2zohd/0tfHH4jabopXp0iURDMaiyaUYf0t24TkG5Wgo6
         1KqKeliqR+zIw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 35A2340513; Thu, 21 Jan 2021 16:37:05 -0300 (-03)
Date:   Thu, 21 Jan 2021 16:37:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Tom Stellard <tstellar@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH] btf_encoder: Add extra checks for symbol names
Message-ID: <20210121193705.GA354859@kernel.org>
References: <20210112184004.1302879-1-jolsa@kernel.org>
 <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
 <20210121133825.GB12699@kernel.org>
 <CA+icZUVsdcTEJjwpB7=05W5-+roKf66qTwP+M6QJKTnuP6TOVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUVsdcTEJjwpB7=05W5-+roKf66qTwP+M6QJKTnuP6TOVQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jan 21, 2021 at 05:06:25PM +0100, Sedat Dilek escreveu:
> On Thu, Jan 21, 2021 at 2:38 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Tue, Jan 12, 2021 at 04:27:59PM -0800, Tom Stellard escreveu:
> > > On 1/12/21 10:40 AM, Jiri Olsa wrote:
> > > > When processing kernel image build by clang we can
> > > > find some functions without the name, which causes
> > > > pahole to segfault.
> > > >
> > > > Adding extra checks to make sure we always have
> > > > function's name defined before using it.
> > > >
> > >
> > > I backported this patch to pahole 1.19, and I can confirm it fixes the
> > > segfault for me.
> >
> > I'm applying v2 for this patch and based on your above statement I'm
> > adding a:
> >
> > Tested-by: Tom Stellard <tstellar@redhat.com>
> >
> > Ok?
> >
> > Who originally reported this?
> >
> 
> The origin was AFAICS the thread where I asked initially [1].
> 
> Tom reported in the same thread in [2] that pahole segfaults.
> 
> Later in the thread Jiri offered a draft of this patch after doing some tests.
> 
> I have tested all diffs and v1 and v2 of Jiri's patch.
> ( Anyway, latest pahole ToT plus Jiri's patch did not solve my origin problem. )
> 
> So up to you Arnaldo for the credits.

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Tom Stellard <tstellar@redhat.com>

is how I'm going about it.

Thanks for clarifying,

- Arnaldo
 
> - Sedat -
> 
> [1] https://marc.info/?t=161036949500004&r=1&w=2
> [2] https://marc.info/?t=161036949500004&r=1&w=2
> 
> > - Arnaldo
> >
> > > -Tom
> > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >   btf_encoder.c | 8 ++++++--
> > > >   1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > > index 333973054b61..17f7a14f2ef0 100644
> > > > --- a/btf_encoder.c
> > > > +++ b/btf_encoder.c
> > > > @@ -72,6 +72,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
> > > >     if (elf_sym__type(sym) != STT_FUNC)
> > > >             return 0;
> > > > +   if (!elf_sym__name(sym, btfe->symtab))
> > > > +           return 0;
> > > >     if (functions_cnt == functions_alloc) {
> > > >             functions_alloc = max(1000, functions_alloc * 3 / 2);
> > > > @@ -730,9 +732,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > > >             if (!has_arg_names(cu, &fn->proto))
> > > >                     continue;
> > > >             if (functions_cnt) {
> > > > -                   struct elf_function *func;
> > > > +                   const char *name = function__name(fn, cu);
> > > > +                   struct elf_function *func = NULL;
> > > > -                   func = find_function(btfe, function__name(fn, cu));
> > > > +                   if (name)
> > > > +                           func = find_function(btfe, name);
> > > >                     if (!func || func->generated)
> > > >                             continue;
> > > >                     func->generated = true;
> > > >
> > >
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
