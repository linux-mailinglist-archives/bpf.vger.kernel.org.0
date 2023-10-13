Return-Path: <bpf+bounces-12143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA397C87A6
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 16:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4811C20C85
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 14:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ABE18E38;
	Fri, 13 Oct 2023 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPypQU/P"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978CE37A
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 14:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7BEC433C7;
	Fri, 13 Oct 2023 14:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697206657;
	bh=q77CitOeoYfhb4N6ZOBp1/jCah8FaTVDvpWPLmYetho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPypQU/P0HkFzcQSOuUf+FhN2+nd5qgSA4bv3mixQS3ShnkKWSMfPH95fdsRDCkeu
	 lC5pQ+0Piq57gcR9PCkTmPAOmMSfVIFcUZgXhNvY8iN5m22DsHe87MDOLw59+vS/GF
	 H3zNUbQLNlwaGYfI8S/bN+ZWt96RVoogOCWhRhP26h8NgVa683s5M27FaousdTUVV7
	 kD6lAQgeooP3kDPg/leXZgkxfJGaF7K6qdbU0GjIGvA7+15bWyNVDrsl3QxZd7RO2R
	 gcQw8lPPzLysmh8RjpSV++hdgMB+FjW9aq27m22pMubV7lzMbvI9qSjrX5PnMdO2B4
	 XPOAbk9PAVoug==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id CD1F040016; Fri, 13 Oct 2023 11:17:34 -0300 (-03)
Date: Fri, 13 Oct 2023 11:17:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, andrii.nakryiko@gmail.com,
	jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [RFC dwarves 3/4] pahole: add
 --btf_features=feature1[,feature2...] support
Message-ID: <ZSlRftMvOpscFe2S@kernel.org>
References: <20231011091732.93254-1-alan.maguire@oracle.com>
 <20231011091732.93254-4-alan.maguire@oracle.com>
 <b7b61031f41ab4082205ed061bb66cb859bd1f0d.camel@gmail.com>
 <f822334f-335e-bd38-09c7-95c69086ba6f@oracle.com>
 <5b40ffbfa5949c24dad44ed6adf70d35cf72f757.camel@gmail.com>
 <7b4ff1c8-f8c7-b96e-c581-f27a389379f0@oracle.com>
 <07a9eb9eaa6cd424ac5025f76ea620eae6062c54.camel@gmail.com>
 <401a9b36-9a4c-db0a-272c-e85eb31aeccd@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401a9b36-9a4c-db0a-272c-e85eb31aeccd@oracle.com>
X-Url: http://acmel.wordpress.com

Em Thu, Oct 12, 2023 at 01:35:41PM +0100, Alan Maguire escreveu:
> On 11/10/2023 23:14, Eduard Zingerman wrote:
> > On Wed, 2023-10-11 at 23:05 +0100, Alan Maguire wrote:
> > [...]
> >>>>> I'm not sure I understand the logic behind "skip" features.
> >>>>> Take `decl_tag` for example:
> >>>>> - by default conf_load->skip_encoding_btf_decl_tag is 0;
> >>>>> - if `--btf_features=decl_tag` is passed it is still 0 because of the
> >>>>>   `skip ? false : true` logic.
> >>>>>
> >>>>> If there is no way to change "skip" features why listing these at all?
> >>>>>
> >>>> You're right; in the case of a skip feature, I think we need the
> >>>> following behaviour
> >>>>
> >>>> 1. we skip the encoding by default (so the equivalent of
> >>>> --skip_encoding_btf_decl_tag, setting skip_encoding_btf_decl_tag
> >>>> to true
> >>>>
> >>>> 2. if the user however specifies the logical inversion of the skip
> >>>> feature in --btf_features (in this case "decl_tag" - or "all")
> >>>> skip_encoding_btf_decl_tag is set to false.
> >>>>
> >>>> So in my code we had 2 above but not 1. If both were in place I think
> >>>> we'd have the right set of behaviours. Does that sound right?
> >>>
> >>> You mean when --features=? is specified we default to
> >>> conf_load->skip_encoding_btf_decl_tag = true, and set it to false only
> >>> if "all" or "decl_tag" is listed in features, right?
> >>>
> >>
> >> Yep. Here's the comment I was thinking of adding for the next version,
> >> hopefully it clarifies this all a bit more than the original.
> >>
> >> +/* --btf_features=feature1[,feature2,..] allows us to specify
> >> + * a list of requested BTF features or "all" to enable all features.
> >> + * These are translated into the appropriate conf_load values via
> >> + * struct btf_feature which specifies the associated conf_load
> >> + * boolean field and whether its default (representing the feature being
> >> + * off) is false or true.
> >> + *
> >> + * btf_features is for opting _into_ features so for a case like
> >> + * conf_load->btf_gen_floats, the translation is simple; the presence
> >> + * of the "float" feature in --btf_features sets conf_load->btf_gen_floats
> >> + * to true.
> >> + *
> >> + * The more confusing case is for features that are enabled unless
> >> + * skipping them is specified; for example
> >> + * conf_load->skip_encoding_btf_type_tag.  By default - to support
> >> + * the opt-in model of only enabling features the user asks for -
> >> + * conf_load->skip_encoding_btf_type_tag is set to true (meaning no
> >> + * type_tags) and it is only set to false if --btf_features contains
> >> + * the "type_tag" feature.
> >> + *
> >> + * So from the user perspective, all features specified via
> >> + * --btf_features are enabled, and if a feature is not specified,
> >> + * it is disabled.
> >>   */
> > 
> > Sounds reasonable. Maybe also add a line saying that
> > skip_encoding_btf_decl_tag defaults to false if --btf_features is not
> > specified to remain backwards compatible?
> >
> 
> good idea, will do! Thanks!

I have to catch up with all the comments on this thread, but does this
mean you're respinning the series now?

- Arnaldo

