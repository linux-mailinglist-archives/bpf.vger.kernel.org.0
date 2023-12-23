Return-Path: <bpf+bounces-18651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F24081D655
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 20:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D490E283376
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 19:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9EA14F62;
	Sat, 23 Dec 2023 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="DnbWeGoZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="naCCeF5K"
X-Original-To: bpf@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C1C14A9C
	for <bpf@vger.kernel.org>; Sat, 23 Dec 2023 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id BCD2D3200A27;
	Sat, 23 Dec 2023 14:40:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 23 Dec 2023 14:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1703360406; x=1703446806; bh=PsyJHYFlN6
	5AWJRCpGowtDVRq7sLGH3tCuO+n1h1wiU=; b=DnbWeGoZIi/7j7FI/SSQKiMpsy
	xQvJWR41jCmSl/XzYr0wB+JginZ6xZKOodpLW7IyPtx3Y2QF/Zn+hfLIramZBpKg
	NRfix9RWeHEaT6OoOjGH8R41po/rVHutHIjie6r5AiWJG7VVrD1Tjehb2MijCMkU
	98o/a0TC7skq9aYUMS8CB/TzjYitPvVnVxQJvumHMi6RVHf7BmqT+YJom91a7m8m
	iZ49xkAZFfsCgbBeMIKeaq00jG8SP/D5J/yssX1uvIfIaTOCuoHRkxQsoMKufRgt
	5lz+IrZTJi3Bht6zASre8K0fwix/YqMx77232UjrBs6DErvM1+xaSw8Eylig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703360406; x=1703446806; bh=PsyJHYFlN65AWJRCpGowtDVRq7sL
	GH3tCuO+n1h1wiU=; b=naCCeF5KfaYvqGPZYTxWPdM55Kgqn34vu432CfIfMTAd
	ZhYkbMO7funE7G2TVnetzyRTrRh2crNDgSehOE/FAS4ZcTZxvTM4+HAvgQuYKxYJ
	BcvE84tANu4R13vSBXBJMQAFU6JqIZ4Eqr1O8n3q51a2E4VRh2CzbBJLLunsBGHI
	cf1oH0TyL/td+ToM4npxvd3QXnluFTEq2X2Gbcusfo/g57Cvpe3mpCpfMEi9JrpB
	AP+RamViYf9wJhGOA2m8uWVDhLwrZF9tLkTf0sYRjFggNg/0VefPFbENT6H4ZQS7
	6ZGwOpsydChSXK5E+S2IGUKvbRDQKLqDlXBzch6+yQ==
X-ME-Sender: <xms:ljeHZS8BWmq1iDsl49KSZdVpy9_dd_wcN6iwm5f7OmHSp2WbGQNZMA>
    <xme:ljeHZSvXrEYkHWl1KYUOrGDaY-YB7tmgAgkigwlEs7q9Ug0kON6CqSBrOxfrxpynp
    LEAbD-m2mjnmIksYg>
X-ME-Received: <xmr:ljeHZYCX7P3bJejnxEs9LIhvL0WzkqUBmRohVfe5vGk7GoLOi3yAv34W5MdpDHWhd9_E5h3ug9IMmn0aBVqxOmcEj8xNRjSszY-wZpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduledgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdt
    tddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffff
    gfegiedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:ljeHZaftvJzqrZ9250e0D6O_hVwmrTb2A0OGLcPyXHjmu1iy-QPUFQ>
    <xmx:ljeHZXP-LJ6bk5HJVLrJC90fIuvEWMj5W-QltYzD0JRAG9wAJCSjbA>
    <xmx:ljeHZUlFrpKsoEATAQujS5OAw02FODM-68Y3u3UAHZWf0EHEEpMqZw>
    <xmx:ljeHZTAQlokjoIrVMlZjBRhpqntkvwaYAQQqyf4JGAglrIZUb8qkCA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Dec 2023 14:40:05 -0500 (EST)
Date: Sat, 23 Dec 2023 12:40:03 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: David Marchevsky <david.marchevsky@linux.dev>
Cc: acme@kernel.org, jolsa@kernel.org, quentin@isovalent.com, 
	andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
Message-ID: <4cgziyizxrdiw4trnaqabnaaf4jm7x5643r5biet7fcmu2ra3l@k7tvbrxxov5f>
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
 <98e76ea6-f45e-4ed5-9976-97f540032a55@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98e76ea6-f45e-4ed5-9976-97f540032a55@linux.dev>

Hi Dave,

On Thu, Dec 21, 2023 at 05:57:18PM -0500, David Marchevsky wrote:
> 
> 
> On 12/20/23 5:19 PM, Daniel Xu wrote:
> > This commit teaches pahole to parse symbols in .BTF_ids section in
> > vmlinux and discover exported kfuncs. Pahole then takes the list of
> > kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> > 
> > This enables downstream users and tools to dynamically discover which
> > kfuncs are available on a system by parsing vmlinux or module BTF, both
> > available in /sys/kernel/btf.
> > 
> > Example of encoding:
> > 
> >         $ bpftool btf dump file .tmp_vmlinux.btf | rg DECL_TAG | wc -l
> >         388
> > 
> >         $ bpftool btf dump file .tmp_vmlinux.btf | rg 68940
> >         [68940] FUNC 'bpf_xdp_get_xfrm_state' type_id=68939 linkage=static
> >         [128124] DECL_TAG 'kfunc' type_id=68940 component_idx=-1
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  btf_encoder.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 202 insertions(+)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index fd04008..2697214 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -34,6 +34,9 @@
> >  #include <pthread.h>
> >  
> >  #define BTF_ENCODER_MAX_PROTO	512
> > +#define BTF_IDS_SECTION		".BTF_ids"
> > +#define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
> > +#define BTF_KFUNC_TYPE_TAG	"kfunc"
> 
> Can this be bpf_kfunc? Elaborated on elsewhere in this reply

Yeah, that's better. Good idea.

> 
> >  
> >  /* state used to do later encoding of saved functions */
> >  struct btf_encoder_state {
> > @@ -1352,6 +1355,200 @@ out:
> >  	return err;
> >  }
> >  
> > +/*
> > + * Parse BTF_ID symbol and return the kfunc name.
> > + *
> > + * Returns:
> > + *	Callee-owned string containing kfunc name if successful.
> 
> nit: Caller-owned, not callee-owned

Fixed, thanks.

> 
> > + *	NULL if !kfunc or on error.
> > + */
> > +static char *get_kfunc_name(const char *sym)
> > +{
> > +	char *kfunc, *end;
> > +
> > +	if (strncmp(sym, BTF_ID_FUNC_PFX, sizeof(BTF_ID_FUNC_PFX) - 1))
> > +		return NULL;
> > +
> > +	/* Strip prefix */
> > +	kfunc = strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
> > +
> > +	/* Strip suffix */
> > +	end = strrchr(kfunc, '_');
> > +	if (!end || *(end - 1) != '_') {
> > +		free(kfunc);
> > +		return NULL;
> > +	}
> > +	*(end - 1) = '\0';
> > +
> > +	return kfunc;
> > +}
> > +
> > +static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, const char *kfunc)
> > +{
> > +	int nr_types, type_id, err = -1;
> > +	struct btf *btf = encoder->btf;
> > +
> > +	nr_types = btf__type_cnt(btf);
> > +	for (type_id = 1; type_id < nr_types; type_id++) {
> > +		const struct btf_type *type;
> > +		const char *name;
> > +
> > +		type = btf__type_by_id(btf, type_id);
> > +		if (!type) {
> > +			fprintf(stderr, "%s: malformed BTF, can't resolve type for ID %d\n",
> > +				__func__, type_id);
> > +			goto out;
> > +		}
> > +
> > +		if (!btf_is_func(type))
> > +			continue;
> > +
> > +		name = btf__name_by_offset(btf, type->name_off);
> > +		if (!name) {
> > +			fprintf(stderr, "%s: malformed BTF, can't resolve name for ID %d\n",
> > +				__func__, type_id);
> > +			goto out;
> > +		}
> > +
> > +		if (strcmp(name, kfunc))
> > +		    continue;
> > +
> > +		err = btf__add_decl_tag(btf, BTF_KFUNC_TYPE_TAG, type_id, -1);
> 
> In an ideal world we'd just add this tag to __bpf_kfunc macro
> definition, right? Then bpftool can generate fwd decls from generated
> vmlinux w/o any pahole changes. But no gcc support for BTF tags, so need
> to do this workaround.
> 
> With that in mind, instead of unconditionally adding BTF_KFUNC_TYPE_TAG
> to funcs in btf id sets, can this code only do so if there isn't an
> existing BTF_KFUNC_TYPE_TAG pointing to it? It'd require another loop
> over btf types to built set of already-tagged funcs, but would
> future-proof this work. Alternatively, if existing btf__dedup call after
> btf_encoder__tag_kfuncs will get rid of these extraneous "tagged types"
> in the scenario where one already exists, then a comment here to that
> effect would be appreciated.

Yeah, I placed the call to btf_encoder__tag_kfuncs() right before the
call to btf__dedup() in btf_encoder__encode() cuz I was noticing
duplicates. After moving the call to the current location, I noticed the
duplicates went away.

I'll leave a comment to that effect.

Thanks,
Daniel

