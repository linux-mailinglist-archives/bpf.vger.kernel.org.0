Return-Path: <bpf+bounces-3578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D071074016B
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 18:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21531C20AA9
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 16:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7607A13067;
	Tue, 27 Jun 2023 16:37:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98513060
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 16:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C08C433C8;
	Tue, 27 Jun 2023 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687883872;
	bh=r1Zn6rFZGv2qCvkWHTzQxNdBye9pe1D7vb/SPlI/qbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C4sU5FTF50gx4fEW/KwomVCXzjlQ0STh011IYkVtvtkf/gW6FaqcH8Fpjp0t9yo3a
	 WZ7nQB8HeKw5NPArG9XUsJv+8LcFaW7UwizPmu1X468YnnvlTXwjpHXG5Zm4tDSqtE
	 0lE5l3zYl98koHR0IET+i9SoEAF916ruVeS4I/tPNwigdvOlOE9Wg4FGX/5UF2DBwj
	 lPV9MXmtvk/hx5VtCvvJ1lkmFoOyzPC3/Au45/E/uESULHcSTgnxfVo76Jo8WejzfA
	 3jb5jEfpALpNNRVZKOLY29z/cyF+BWAHjneLc4fFzGVmV0aYCvtyd9nGouPEvSnRIP
	 mx5CQucrlwWnw==
From: SeongJae Park <sj@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	martin.lau@linux.dev,
	ast@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Egorenkov <Alexander.Egorenkov@ibm.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] btf: warn but return no error for NULL btf from __register_btf_kfunc_id_set()
Date: Tue, 27 Jun 2023 16:37:50 +0000
Message-Id: <20230627163750.81178-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZJsMVxGVCJoF19wQ@krava>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiri,

On Tue, 27 Jun 2023 18:20:39 +0200 Jiri Olsa <olsajiri@gmail.com> wrote:

> On Mon, Jun 26, 2023 at 06:11:20PM +0000, SeongJae Park wrote:
> > __register_btf_kfunc_id_set() assumes .BTF to be part of the module's
> > .ko file if CONFIG_DEBUG_INFO_BTF is enabled.  If that's not the case,
> > the function prints an error message and return an error.  As a result,
> > such modules cannot be loaded.
> > 
> > However, the section could be stripped out during a build process.  It
> > would be better to let the modules loaded, because their basic
> > functionalities have no problem[1], though the BTF functionalities will
> > not be supported.  Make the function to lower the level of the message
> > from error to warn, and return no error.
> > 
> > [1] https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
> > 
> > Reported-by: Alexander Egorenkov <Alexander.Egorenkov@ibm.com>
> > Link: https://lore.kernel.org/bpf/87y228q66f.fsf@oc8242746057.ibm.com/
> > Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Link: https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
> > Fixes: dee872e124e8 ("bpf: Populate kfunc BTF ID sets in struct btf")
> 
> should it be this one in Fixes instead?
>   c446fdacb10d bpf: fix register_btf_kfunc_id_set for !CONFIG_DEBUG_INFO_BTF

The commit c446fdacb10d was trying to fix commit dee872e124e8, which this patch
is claiming to fix, by relaxing the check.  Nevertheless, it seems the check
need to further relaxed, and therefore I wrote this patch.

For the reason, I was thinking this patch is directly fixing c446fdacb10d, but
is also fixing a problem originally introduced by dee872e124e8.   Nevertheless,
as the dee872e124e8 also has the Fixes tag, I think your suggestion makes
sense. 

I will fix so in the next spin.

> 
> other than that looks good
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thank you, I will also add this to the next version of this patch :)


Thanks,
SJ

> 
> jirka
> 
> > Cc: <stable@vger.kernel.org> # 5.17.x
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  kernel/bpf/btf.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 6b682b8e4b50..d683f034996f 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -7848,14 +7848,10 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
> >  
> >  	btf = btf_get_module_btf(kset->owner);
> >  	if (!btf) {
> > -		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
> > -			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
> > -			return -ENOENT;
> > -		}
> > -		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)) {
> > -			pr_err("missing module BTF, cannot register kfuncs\n");
> > -			return -ENOENT;
> > -		}
> > +		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
> > +			pr_warn("missing vmlinux BTF, cannot register kfuncs\n");
> > +		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
> > +			pr_warn("missing module BTF, cannot register kfuncs\n");
> >  		return 0;
> >  	}
> >  	if (IS_ERR(btf))
> > -- 
> > 2.25.1
> > 
> > 

