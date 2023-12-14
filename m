Return-Path: <bpf+bounces-17871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BC4813AD3
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 20:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B33B216B4
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 19:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C67A69794;
	Thu, 14 Dec 2023 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx3c82aA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6F869798
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d0ccda19eeso52299065ad.1
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 11:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702582458; x=1703187258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFqSz+i9wEqlDdJsJxl/a8EVJkKLgaUdBFlWc/kGYJU=;
        b=Hx3c82aAoTYbQPQbSfzyod3Ct5Yv0P0lNSBnn0KxkG8HykpbaCKjt7FnbDk/MTnUsz
         yIDXp2ru1wsWBjTqhNC+NeGx/H9RJ79l/aObqssoh0UBB8JPLrmSYbViOIE4lbH9OH1c
         p2tCMoWpC7SNam7mz0LyVmtdSsTNqk/CAitnJCXoPfW55DQaa4XgmpBooJmIwe3Xsqap
         XZbnLcyveC4PcQLHdQDRiWmGPBPSJdHmAfi+Tebu0485df8eQOdNuZcUGmIcOoIXd1qx
         deA4s4anemJloBrjiAJKPyOXUOVt4Z684BmTvcCcdHsDnkxzK+gopkAIptfUnIhd2IvX
         4a8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702582458; x=1703187258;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IFqSz+i9wEqlDdJsJxl/a8EVJkKLgaUdBFlWc/kGYJU=;
        b=lBcmtA2Mw8+febZB4ZW55JOOi8SoiMsOJ26fyuhUlSKOeQ+D7wLn8l312NiiaGewb0
         Ae37DW5QW99WazZAsn+iYFuPdsesfERUQqFpiJyOrWgrzFR4bh3+/xShAOUFGhzScyqI
         PgDNH9TiWq2tVHcYmIyVrsUnV2V7uVCbK0utQrEQe3BU/mPVidIC6DyfmtcOWuQUEK+D
         tAiPyoH7lytW6zbTgKpqGxAzjYl1qMJGxOne78oVffNE+0sSWK8A0dBR5ARa7vgFaywa
         8cD8jBSv2WpyDfB+9yDRYxza/c/IDpBL6HfqoPchma4RT2zxakY3PcSvmrL4RJlZ8rZt
         nxdw==
X-Gm-Message-State: AOJu0YwhAfeoqZPMKktAf4JVyjDaHB15eTy3Dga6hNWnazxKZNuVH96L
	0+Wmv5rp/gAvpzl4O2G7+v4=
X-Google-Smtp-Source: AGHT+IGMl+1inxkvIIcxbJgy3wtYImIoRBCcDCMVjyXvmrAnsw9bZlbPcC7U3GBX+0wfz5SlrfSsjg==
X-Received: by 2002:a17:902:8608:b0:1d0:69ab:b0c8 with SMTP id f8-20020a170902860800b001d069abb0c8mr5556575plo.6.1702582458192;
        Thu, 14 Dec 2023 11:34:18 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902b58a00b001d331bd4d4csm5976540pls.95.2023.12.14.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:34:17 -0800 (PST)
Date: Thu, 14 Dec 2023 11:34:16 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, 
 Wentao Zhang <wentao.zhang@windriver.com>, 
 ast@kernel.org
Cc: bpf@vger.kernel.org
Message-ID: <657b58b8685ad_516b4208f1@john.notmuch>
In-Reply-To: <ca122e6f-19dc-d319-54f8-75e1dfa988c3@iogearbox.net>
References: <20231214075037.1981972-1-wentao.zhang@windriver.com>
 <ca122e6f-19dc-d319-54f8-75e1dfa988c3@iogearbox.net>
Subject: Re: [PATCH bpf-next] libbpf: Fix null pointer check in btf__add_str
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Borkmann wrote:
> On 12/14/23 8:50 AM, Wentao Zhang wrote:
> > The function btf_str_by_offset may return NULL when used as an
> > input argument for btf_add_str in the context of btf_rewrite_str.
> > The added check ensures that both the input string (s) and the
> > BTF object (btf) are non-null before proceeding with the function
> > logic. If either is null, the function returns an error code
> > indicating an invalid argument.
> > 
> > Found by our static analysis tool.
> > 
> > Signed-off-by: Wentao Zhang <wentao.zhang@windriver.com>
> > ---
> >   tools/lib/bpf/btf.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index fd2309512978..a6a00bdc7151 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -1612,6 +1612,8 @@ int btf__find_str(struct btf *btf, const char *s)
> >   int btf__add_str(struct btf *btf, const char *s)
> >   {
> >   	int off;
> 
> (nit: empty line after declaration)
> 
> > +	if(!s || !btf)
> > +		return libbpf_err(-EINVAL);
> >   
> >   	if (btf->base_btf) {
> >   		off = btf__find_str(btf->base_btf, s);
> > 
> 
> If feels a bit off that in this library helper function we'd validate the inputs
> but not in others. Alternative could be :
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 63033c334320..18574fc017d9 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1735,6 +1735,7 @@ static int btf_rewrite_str(__u32 *str_off, void *ctx)
>   {
>   	struct btf_pipe *p = ctx;
>   	long mapped_off;
> +	const char *s;
>   	int off, err;
> 
>   	if (!*str_off) /* nothing to do for empty strings */
> @@ -1746,7 +1747,11 @@ static int btf_rewrite_str(__u32 *str_off, void *ctx)
>   		return 0;
>   	}
> 
> -	off = btf__add_str(p->dst, btf__str_by_offset(p->src, *str_off));
> +	s = btf__str_by_offset(p->src, *str_off);
> +	if (!s)
> +		return -EINVAL;
> +
> +	off = btf__add_str(p->dst, s);
>   	if (off < 0)
>   		return off;
> 
> 

Agreed its a odd way to check input. Also I found a few cases where even if
you did check it in btf__find_str it also deref'd a few lines down in the
main code. I think the assumption throughout is that btf is !null. Or if  it
is null we abort much earlier in the code. Didn't study too thoroughly though
so perhaps I missed some cases. One in the below diff for example would be
nice I think.

Could likely get a more meaningful error up to user as well by failing early.

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 63033c334320..5e70dcecab27 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3470,6 +3470,9 @@ static int strs_dedup_remap_str_off(__u32 *str_off_ptr, void *ctx)
                return 0;
 
        s = btf__str_by_offset(d->btf, str_off);
+       if (s < 0)
+               return s;
+
        if (d->btf->base_btf) {
                err = btf__find_str(d->btf->base_btf, s);
                if (err >= 0) {

