Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8DD2FEB0A
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 14:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbhAUNE7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 08:04:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731298AbhAUNEx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 08:04:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8C55239FD;
        Thu, 21 Jan 2021 13:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611234251;
        bh=/JQOMKgFZd+MmDKBnQspohxdXPXaleKHP33NP0PpPco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o+bCStibUSXXjKXxfOirKViIt1Px9/Bk+ZRY0KJcm0PDR3lxal1dMvpPgbKGA/oqi
         Rr54LBSLaPSCBQCBOZehxClmsJFNVOdVHhDfbLEHbi/XOxilWEhdklBaPBNREgkYV0
         keaYVFQm+IXsOOOenzWllWMJEGw5HZS/ZXC1PK+1EobwPIXOEJNoWGRGl80XN/+7Gs
         o1in5IHlCcF8SYObrNPG/q39KRvQcgjBTklsqx4HUpAaoUBj4ZsXjkAfvEh9rfqdpj
         5nMMxSaQJ9EWj6LJJVFFF/1VMgsz9e0/Y0vxjjK7MvM5XqqImsd53wEulbz1ztgrbP
         nU+eDGKbiC7ow==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8EF3040513; Thu, 21 Jan 2021 10:04:09 -0300 (-03)
Date:   Thu, 21 Jan 2021 10:04:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Giuliano Procida <gprocida@google.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org, kernel-team@android.com,
        maennich@google.com, Alexei Starovoitov <ast@kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH 1/3] btf_encoder: Fix handling of restrict qualifier
Message-ID: <20210121130409.GW12699@kernel.org>
References: <20210118160139.1971039-1-gprocida@google.com>
 <20210118160139.1971039-2-gprocida@google.com>
 <CAEf4BzZ-ibm_gmbv+JgZH6mNEmz0OxoF_nD9tymo1tYeE_BAjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ-ibm_gmbv+JgZH6mNEmz0OxoF_nD9tymo1tYeE_BAjg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jan 20, 2021 at 11:07:44PM -0800, Andrii Nakryiko escreveu:
> On Mon, Jan 18, 2021 at 8:01 AM Giuliano Procida <gprocida@google.com> wrote:
> >
> > Fixes: 48efa92933e8 ("btf_encoder: Use libbpf APIs to encode BTF type info")
> >
> > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > ---
> 
> It's up to the maintainer, but some short commit message would be
> welcome. Also, it would be nice to have [PATCH dwarves] to distinguish
> this from patches targeted to bpf/bpf-next tree.

Yeah, this one looks obvious so I'll add the comment myself, please do
it next time.

- Arnaldo
 
> The fix itself looks good:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> >  libbtf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libbtf.c b/libbtf.c
> > index 16e1d45..3709087 100644
> > --- a/libbtf.c
> > +++ b/libbtf.c
> > @@ -417,7 +417,7 @@ int32_t btf_elf__add_ref_type(struct btf_elf *btfe, uint16_t kind, uint32_t type
> >                 id = btf__add_const(btf, type);
> >                 break;
> >         case BTF_KIND_RESTRICT:
> > -               id = btf__add_const(btf, type);
> > +               id = btf__add_restrict(btf, type);
> >                 break;
> >         case BTF_KIND_TYPEDEF:
> >                 id = btf__add_typedef(btf, name, type);
> > --
> > 2.30.0.284.gd98b1dd5eaa7-goog
> >

-- 

- Arnaldo
