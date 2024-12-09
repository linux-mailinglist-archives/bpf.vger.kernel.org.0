Return-Path: <bpf+bounces-46430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2A59EA232
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 23:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5113282CA8
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 22:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A0519DF66;
	Mon,  9 Dec 2024 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ICRb2dDs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EmpgCrFZ"
X-Original-To: bpf@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418C12C9A;
	Mon,  9 Dec 2024 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733784994; cv=none; b=ovm9BIrYnSajwN14pcNQo4NHe182vfpvJgOrtq4PsqhHg8CM3G9XctAaPfaYcNiCMSay/Ci41CW/x5VfNn9zQCQi9xdOtSki1ghuiQcyCQ+71hrThQdubSLOrxfGj2j65f05AljvntPgMT+FyFETz6+bsEnPie0V0+jb5P5GY4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733784994; c=relaxed/simple;
	bh=FWAPSD3ySfuVCHGAqDOalTu3XFlI4ajnWwxMP7v6+uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzhtczQG/DMi2CfoIPp6K1NDnlYWL9oJoTfVb0vTzuiXqOwJIq9wNAR8L9odAMoXkPjwfkD5uPfx7w78E1Dou1fFTywX9mI3ltg3IiVHK6mD5BvbO5cV74VZe6dWi3JB61GGD5TslEUV0xXsOcyFRlVUDJOuWBHXURlsBMaBG9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=ICRb2dDs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EmpgCrFZ; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id B5D071D4067A;
	Mon,  9 Dec 2024 17:56:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 09 Dec 2024 17:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733784990; x=1733792190; bh=75T33NDjZB
	kRHc5ziCu4Lwwg211OEKZg+3cebXXYZNE=; b=ICRb2dDsHo12hmlK/D+33l6aVq
	6ph7AZNxpUM4ItJr59Mxozv/gwuN+3oG4sMbq+yDoMLJD5XO0TpoGZR0pmZ9bEbb
	qqCEcgGZWocP1af6eOiHfdzpfN2gND8mBuCtumtPxp7/FKngqyuJIbGuQrat4Zxm
	n9EnpqnzDP0hFh5bjLkbRBgjIibEi7iZAusv1qxoko1b7tVXBKTHH4WVMxe+S1Nw
	m7uWOBRkeHbyTetYxE2Wl7MruhsW+0anWBUjfqSkWI2EvMdDbhnPOWSbt2ybarqZ
	NJ7jaVsAYauUFKclZNt3JJzytpSq15RqhdDRBHvYIreZZ2cnMkL4xDFvOgEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733784990; x=1733792190; bh=75T33NDjZBkRHc5ziCu4Lwwg211OEKZg+3c
	ebXXYZNE=; b=EmpgCrFZl1dp7QX76IMFPgYNn4M8ANXEhFiNonCoiGOGSBkSHMq
	bsOD1kZnfwyiqoZtxwdyRK8NASdhPsDrECbrrlc0yhaldCy/fZZ6CHT6Pgaup+hn
	TeaLBvRjnrMScpBofM0lsR9m3djL0S7hoKeRyT51UVByU73VuQQpEZ5WAaJpP6Yh
	vDXrRoGbjPbiYYH5M9jglwM5yjXiVoKarhvXKZywF2wC4OZ4m+1wUfqCautoR9SX
	NHCR276KSPhix0l0vO3vYeEUl02i3f1iQkdzZyhM02/Gxi2yLafjXVfGDeNDU129
	AHSiVEXUNuaKHg/JjfdLVQWtkNtwWmSad/Q==
X-ME-Sender: <xms:nXVXZ7kHxRajlucqBJdh_KGv0RtUvdznaiaTHsuEZBezTY1WMd5P8w>
    <xme:nXVXZ-2bVot-RkbM_EOKooEwkd6TsloRHy0ijYqxlGeOMIFeDKEoCHV2faKeKTbzF
    cr7bXnVHP7ouiK_Ww>
X-ME-Received: <xmr:nXVXZxqq01-30N7dBE6OdJaQJHbZb9bvqSlrEE9q5DZAt2OavyRsj0SctZOY4bzgzsNLgdqVsSgTQEW2bcXZiGogmewN1nKzq2AasoZ9H91H_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhgg
    tggujgesthdtsfdttddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugi
    huuhhurdighiiiqeenucggtffrrghtthgvrhhnpedtjeekudelieetvdefgedvgeejhefh
    vdfggfejudeutdegveeivedthfehfeelkeenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugig
    uhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehqmhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgif
    kheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhguse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurg
    hvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohig
    rdhnvghtpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehmrghrthhinhdrlhgruheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:nXVXZzk1zpg03J8eB6Hk4hoJz3LLjDubJpZ8vlCe8f2lLFVJudUFwQ>
    <xmx:nXVXZ52jbQ7whlKEbE2Pak3Pu_dOOCvHJGOcT_7a_RWeEHwaQKrC8g>
    <xmx:nXVXZytUUCEkf2WekjP_p1zjsUrsLqOxZCLdlNEtUBW7SVUmiLr8FQ>
    <xmx:nXVXZ9UJFK_4iASHlAuRfgpyUWS89wfqhiG0IgJB5dPyKfaXk5WDCg>
    <xmx:nnVXZwvj0mr1htwkBsI3L-2XG7xzIfn_PUlRXmZIX778UrvaeU260nVd>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 17:56:27 -0500 (EST)
Date: Mon, 9 Dec 2024 15:56:26 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Quentin Monnet <qmo@kernel.org>
Cc: hawk@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, 
	ast@kernel.org, davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	antony@phenome.org, toke@kernel.org
Subject: Re: [PATCH bpf-next v2] bpftool: btf: Support dumping a single type
 from file
Message-ID: <rphope3vevqgjbq3uh5l3wrtvlcls2dc3abi5caxfbemjgztuy@5qvyeoove3nr>
References: <c8e6a2dfb64d76e61a20b1e2470fccbddf167499.1733613798.git.dxu@dxuuu.xyz>
 <92b28250-acd8-4ca7-8a0e-09e1338113f0@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92b28250-acd8-4ca7-8a0e-09e1338113f0@kernel.org>

Hi Quentin,

On Mon, Dec 09, 2024 at 12:26:50PM GMT, Quentin Monnet wrote:
> On 07/12/2024 23:24, Daniel Xu wrote:
> > Some projects, for example xdp-tools [0], prefer to check in a minimized
> > vmlinux.h rather than the complete file which can get rather large.
> > 
> > However, when you try to add a minimized version of a complex struct (eg
> > struct xfrm_state), things can get quite complex if you're trying to
> > manually untangle and deduplicate the dependencies.
> > 
> > This commit teaches bpftool to do a minimized dump of a single type by
> > providing an optional root_id argument.
> > 
> > Example usage:
> > 
> >     $ ./bpftool btf dump file ~/dev/linux/vmlinux | rg "STRUCT 'xfrm_state'"
> >     [12643] STRUCT 'xfrm_state' size=912 vlen=58
> > 
> >     $ ./bpftool btf dump file ~/dev/linux/vmlinux root_id 12643 format c
> >     #ifndef __VMLINUX_H__
> >     #define __VMLINUX_H__
> > 
> >     [..]
> > 
> >     struct xfrm_type_offload;
> > 
> >     struct xfrm_sec_ctx;
> > 
> >     struct xfrm_state {
> >             possible_net_t xs_net;
> >             union {
> >                     struct hlist_node gclist;
> >                     struct hlist_node bydst;
> >             };
> >             union {
> >                     struct hlist_node dev_gclist;
> >                     struct hlist_node bysrc;
> >             };
> >             struct hlist_node byspi;
> >     [..]
> > 
> > [0]: https://github.com/xdp-project/xdp-tools/blob/master/headers/bpf/vmlinux.h
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> > Changes in v2:
> > * Add early error check for invalid BTF ID
> > 
> >  .../bpf/bpftool/Documentation/bpftool-btf.rst |  5 +++--
> >  tools/bpf/bpftool/btf.c                       | 19 +++++++++++++++++++
> >  2 files changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> > index 3f6bca03ad2e..5abd0e99022f 100644
> > --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> > +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> > @@ -27,7 +27,7 @@ BTF COMMANDS
> >  | **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*]
> >  | **bpftool** **btf help**
> >  |
> > -| *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
> > +| *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* [**root_id** *ROOT_ID*] }
> 
> 
> Thanks for this!

No problem!

> 
> root_id is not part of the BTF_SRC, I think it should be an option on
> the command line itself (3 lines above), after "format". And the change
> should also be repeated below in the description (the "format" option is
> missing, by the way, let's fix it too).

Sure, will do. I was originally thinking it would conflict with `map`
subcommand, as it also sets the root_type_ids, but we can just error out
if root_type_cnt > 0 and root_id is pased.

Will send v3 with below suggestions as well.

> 
> Can you please also update the interactive help message at the end of
> btf.c?
> 
> Can you please also update the bash completion file? I think it should
> look like this:
> 
> 
> ------
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 0c541498c301..097d406ee21f 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -930,6 +930,9 @@ _bpftool()
>                          format)
>                              COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
>                              ;;
> +                        root_id)
> +                            return 0;
> +                            ;;
>                          c)
>                              COMPREPLY=( $( compgen -W "unsorted" -- "$cur" ) )
>                              ;;
> @@ -937,13 +940,13 @@ _bpftool()
>                              # emit extra options
>                              case ${words[3]} in
>                                  id|file)
> -                                    _bpftool_once_attr 'format'
> +                                    _bpftool_once_attr 'format root_id'
>                                      ;;
>                                  map|prog)
>                                      if [[ ${words[3]} == "map" ]] && [[ $cword == 6 ]]; then
>                                          COMPREPLY+=( $( compgen -W "key value kv all" -- "$cur" ) )
>                                      fi
> -                                    _bpftool_once_attr 'format'
> +                                    _bpftool_once_attr 'format root_id'
>                                      ;;
>                                  *)
>                                      ;;
> ------
> 
> 
> >  | *FORMAT* := { **raw** | **c** [**unsorted**] }
> >  | *MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
> >  | *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
> > @@ -60,7 +60,8 @@ bpftool btf dump *BTF_SRC*
> >  
> >      When specifying *FILE*, an ELF file is expected, containing .BTF section
> >      with well-defined BTF binary format data, typically produced by clang or
> > -    pahole.
> > +    pahole. You can choose to dump a single type and all its dependent types
> > +    by providing an optional *ROOT_ID*.
> >  
> >      **format** option can be used to override default (raw) output format. Raw
> >      (**raw**) or C-syntax (**c**) output formats are supported. With C-style
> > diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> > index d005e4fd6128..a75e17efaf5e 100644
> > --- a/tools/bpf/bpftool/btf.c
> > +++ b/tools/bpf/bpftool/btf.c
> > @@ -953,6 +953,8 @@ static int do_dump(int argc, char **argv)
> >  		NEXT_ARG();
> >  	} else if (is_prefix(src, "file")) {
> >  		const char sysfs_prefix[] = "/sys/kernel/btf/";
> > +		__u32 root_id;
> > +		char *end;
> 
> 
> I think we could move these declarations to a lower scope, under your
> "if (argc && is_prefix(...))".
> 
> 
> >  
> >  		if (!base_btf &&
> >  		    strncmp(*argv, sysfs_prefix, sizeof(sysfs_prefix) - 1) == 0 &&
> > @@ -967,6 +969,23 @@ static int do_dump(int argc, char **argv)
> >  			goto done;
> >  		}
> >  		NEXT_ARG();
> > +
> > +		if (argc && is_prefix(*argv, "root_id")) {
> > +			NEXT_ARG();
> > +			root_id = strtoul(*argv, &end, 0);
> > +			if (*end) {
> > +				err = -1;
> > +				p_err("can't parse %s as root ID", *argv);
> > +				goto done;
> > +			}
> > +			if (root_id >= btf__type_cnt(btf)) {
> > +				err = -EINVAL;
> > +				p_err("invalid root ID: %u", root_id);
> > +				goto done;
> > +			}
> > +			root_type_ids[root_type_cnt++] = root_id;
> > +			NEXT_ARG();
> > +		}
> >  	} else {
> >  		err = -1;
> >  		p_err("unrecognized BTF source specifier: '%s'", src);
> 
> 
> Same comment as above, it seems to be that the root_id controls the
> output for the command rather than the source, and I'd rather move this
> to the "while (argc)" loop where we process the "format" option rather
> than when parsing the source.
> 
> 
> pw-bot: cr

