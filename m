Return-Path: <bpf+bounces-46881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CD69F14A1
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 19:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7A1161252
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E211E8841;
	Fri, 13 Dec 2024 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="qlCO3LtR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W9IeDx6+"
X-Original-To: bpf@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A93B53804;
	Fri, 13 Dec 2024 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112877; cv=none; b=saE1/K6eFhnR3lWOj8jtQL+sn91XC6kUztoIhLa0QnwQ7lUzL3vt2KqdvNAf2ksmtcEchby3lPEwgQspSnMXTCxcKkjsfgG6HHBqAo31WbSxwBOZnIZ28+ABVP8kqm8o7LdJy9CEaHI7LQHqJ+3+kQ0kRYVTM3k5Kle6lDTBsDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112877; c=relaxed/simple;
	bh=C1yCEIwt6l7ZvZTwD4u/ellvTelA5hZEluzmzVmSScA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6LapZkzK5KAm/w8JElS6v4PanrKlp1ldAMJXcMEGdyPDHP6DN/yl3G4KTG8KGaCMSvSh820f3b+8Tscluo+Z7IYE7RM5Ln5yDeVHjrOz/nvGGsBbnKrRXNXNV53KcDAkeC3CVQHbFR10xF98N6t/ZwQ2SM17dx9DAnD68e+SCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=qlCO3LtR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W9IeDx6+; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 61EA5200B16;
	Fri, 13 Dec 2024 13:01:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 13 Dec 2024 13:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734112874; x=1734120074; bh=Dmvw0rCsRR
	ueJvfdxfPSx1zC7SxhbRa0dqGAjjP6/Y0=; b=qlCO3LtR3dovJ+gjjYX5qVcBjB
	Xr2WAiDUN3GZUeePFZdbtkNJtRvnKggLKeQxAf8fz+N2uhNgW7QxJpTZrueWQiAS
	XJi/4VmYTFpqVEWcppKiSFzUOVATPcyqwOS3SpU1Rx40kqFHF9ON0mnivIc7JzEp
	pt4nAGdJANVih2eOhHDUUy3S2AcDJIzVmFudCvdor/n8KQtB99I062W08MRjFFJz
	us8zutv4RPMqrkZq0hJ9cIRaY7OwFstFIYTs7nnRNecaj6xmzeIKKVkWUQ2lcuE/
	QAfEmcuNEZ2SJh2mHzJ7w7ayi9vD+/jIMpdiih+dQ2hKf1UGaYv5M0/CYWdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734112874; x=1734120074; bh=Dmvw0rCsRRueJvfdxfPSx1zC7SxhbRa0dqG
	AjjP6/Y0=; b=W9IeDx6+d2Xzc4knja20KviN4c7A5Ak+W0xINAdfQwB6u8GOjDI
	gVDeTZmGVXAl5yEY6nAeskFrXn/whjJE9/YZ9uA3ACfeZA6lF+BCn345ktmHkKKe
	reiDPzw7lPy5anKD5X+Nu4b/T6B9YGwMqnfnw/AJvabtKbKeFW4CpsRLG5bV1Rxx
	7q/tBG2+FeuSO3uV599ZFyuqONHGlnxF8374bcMHpEM954juEtYRWKoQ4DsKywmY
	IX4Y0kDM7h7muDPG7ndyLlg/MuO237Wb73yUDb8c+uATcutKOrsVYG1t9YL/0Xmy
	Ui+T4UTaTvfpmKJgoz5+Qp2C7IXeVYikGEQ==
X-ME-Sender: <xms:aXZcZ2ylgbbwzrZTAz6ZyhIK__1jZSddyZJwetaqF6fq1iSJS-Vcaw>
    <xme:aXZcZySTWJ_jpWoDQVpOPT1Iam_3dSEqrGCD4AEVRYj_ULCd83eF1F4j2gF9XNjBV
    4SWkvVAXMiR_qEnhQ>
X-ME-Received: <xmr:aXZcZ4VWeUFt2lSrAwSDQVIwoJVEnuxcq9aYUIZescuODJCZsn7i3Z6BkBDeFuEvV_Gby_eRULTJj1u6i1Y2M46Li8lrTZnvfkkhmX1etBWpaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesug
    iguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnheptdejkeduleeitedvfeegvdegjeeh
    hfdvgffgjeduuedtgeevieevtdfhheefleeknecuffhomhgrihhnpehgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegu
    gihusegugihuuhhurdighiiipdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepqhhmoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgr
    fihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    ohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegrshhtse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidr
    nhgvthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpth
    htohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghv
X-ME-Proxy: <xmx:aXZcZ8jA5EFI3DuDP4YHH7Nn5wTwm3D0TKE9VxZUM9ZE9a8TQTe1gA>
    <xmx:aXZcZ4CJPfj55ggbMDuP9tElhqGASk1S-khhbJz8QImGO1EourG24Q>
    <xmx:aXZcZ9Inoz6UVWbPWOiWtYknRU1NIvPvhkH_IGCxG33_5TEnC-mEww>
    <xmx:aXZcZ_AxdIVFopb-IeVUmhzGD8FJiPJ9qJkrlhjltGUvAHpS7PPw8Q>
    <xmx:anZcZ7U04C5LRMkZ5HeW6UvPxGdAFeIQAohaZVtkKlDYrxX4WDJMEwJp>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 13:01:10 -0500 (EST)
Date: Fri, 13 Dec 2024 11:01:09 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Quentin Monnet <qmo@kernel.org>
Cc: hawk@kernel.org, kuba@kernel.org, andrii@kernel.org, 
	john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	andrii.nakryiko@gmail.com, antony@phenome.org, toke@kernel.org
Subject: Re: [PATCH bpf-next v4 3/4] bpftool: btf: Support dumping a specific
 types from file
Message-ID: <jhsgk2wajtebpwiivam5zdv7wr5rzmqjcdey6ad3gbvgiyjcpe@ff6xmxvadnkc>
References: <cover.1734052995.git.dxu@dxuuu.xyz>
 <5ec7617fd9c28ff721947aceb80937dc10fca770.1734052995.git.dxu@dxuuu.xyz>
 <7fa902e5-0916-4bc9-b1e0-2729903d3de0@kernel.org>
 <fojqbtlpjh3jrpzzctgllxtnyncbtbzw6q7qfrezrigpc2qqek@6m7cppwvgwb5>
 <0a8b9448-7e1c-4a30-8011-1505e2133263@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a8b9448-7e1c-4a30-8011-1505e2133263@kernel.org>

On Fri, Dec 13, 2024 at 04:55:34PM GMT, Quentin Monnet wrote:
> 2024-12-13 09:45 UTC-0700 ~ Daniel Xu <dxu@dxuuu.xyz>
> > Hi Quentin,
> > 
> > On Fri, Dec 13, 2024 at 03:17:36PM GMT, Quentin Monnet wrote:
> >> 2024-12-12 18:24 UTC-0700 ~ Daniel Xu <dxu@dxuuu.xyz>
> >>> Some projects, for example xdp-tools [0], prefer to check in a minimized
> >>> vmlinux.h rather than the complete file which can get rather large.
> >>>
> >>> However, when you try to add a minimized version of a complex struct (eg
> >>> struct xfrm_state), things can get quite complex if you're trying to
> >>> manually untangle and deduplicate the dependencies.
> >>>
> >>> This commit teaches bpftool to do a minimized dump of a specific types by
> >>> providing a optional root_id argument(s).
> >>>
> >>> Example usage:
> >>>
> >>>     $ ./bpftool btf dump file ~/dev/linux/vmlinux | rg "STRUCT 'xfrm_state'"
> >>>     [12643] STRUCT 'xfrm_state' size=912 vlen=58
> >>>
> >>>     $ ./bpftool btf dump file ~/dev/linux/vmlinux root_id 12643 format c
> >>>     #ifndef __VMLINUX_H__
> >>>     #define __VMLINUX_H__
> >>>
> >>>     [..]
> >>>
> >>>     struct xfrm_type_offload;
> >>>
> >>>     struct xfrm_sec_ctx;
> >>>
> >>>     struct xfrm_state {
> >>>             possible_net_t xs_net;
> >>>             union {
> >>>                     struct hlist_node gclist;
> >>>                     struct hlist_node bydst;
> >>>             };
> >>>             union {
> >>>                     struct hlist_node dev_gclist;
> >>>                     struct hlist_node bysrc;
> >>>             };
> >>>             struct hlist_node byspi;
> >>>     [..]
> >>>
> >>> [0]: https://github.com/xdp-project/xdp-tools/blob/master/headers/bpf/vmlinux.h
> >>>
> >>> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> >>> ---
> >>>  .../bpf/bpftool/Documentation/bpftool-btf.rst |  8 +++-
> >>>  tools/bpf/bpftool/btf.c                       | 39 ++++++++++++++++++-
> >>>  2 files changed, 43 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> >>> index 245569f43035..dbe6d6d94e4c 100644
> >>> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> >>> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> >>> @@ -24,7 +24,7 @@ BTF COMMANDS
> >>>  =============
> >>>  
> >>>  | **bpftool** **btf** { **show** | **list** } [**id** *BTF_ID*]
> >>> -| **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*]
> >>> +| **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*] [**root_id** *ROOT_ID*]
> >>>  | **bpftool** **btf help**
> >>>  |
> >>>  | *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
> >>> @@ -43,7 +43,7 @@ bpftool btf { show | list } [id *BTF_ID*]
> >>>      that hold open file descriptors (FDs) against BTF objects. On such kernels
> >>>      bpftool will automatically emit this information as well.
> >>>  
> >>> -bpftool btf dump *BTF_SRC* [format *FORMAT*]
> >>> +bpftool btf dump *BTF_SRC* [format *FORMAT*] [root_id *ROOT_ID*]
> >>>      Dump BTF entries from a given *BTF_SRC*.
> >>>  
> >>>      When **id** is specified, BTF object with that ID will be loaded and all
> >>> @@ -67,6 +67,10 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*]
> >>>      formatting, the output is sorted by default. Use the **unsorted** option
> >>>      to avoid sorting the output.
> >>>  
> >>> +    **root_id** option can be used to filter a dump to a single type and all
> >>> +    its dependent types. It cannot be used with any other types of filtering.
> >>> +    It can be passed multiple times to dump multiple types.
> >>> +
> >>>  bpftool btf help
> >>>      Print short help message.
> >>>  
> >>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> >>> index 3e995faf9efa..2636655ac180 100644
> >>> --- a/tools/bpf/bpftool/btf.c
> >>> +++ b/tools/bpf/bpftool/btf.c
> >>> @@ -27,6 +27,8 @@
> >>>  #define KFUNC_DECL_TAG		"bpf_kfunc"
> >>>  #define FASTCALL_DECL_TAG	"bpf_fastcall"
> >>>  
> >>> +#define MAX_ROOT_IDS		16
> >>> +
> >>>  static const char * const btf_kind_str[NR_BTF_KINDS] = {
> >>>  	[BTF_KIND_UNKN]		= "UNKNOWN",
> >>>  	[BTF_KIND_INT]		= "INT",
> >>> @@ -880,7 +882,8 @@ static int do_dump(int argc, char **argv)
> >>>  {
> >>>  	bool dump_c = false, sort_dump_c = true;
> >>>  	struct btf *btf = NULL, *base = NULL;
> >>> -	__u32 root_type_ids[2];
> >>> +	__u32 root_type_ids[MAX_ROOT_IDS];
> >>> +	bool have_id_filtering;
> >>>  	int root_type_cnt = 0;
> >>>  	__u32 btf_id = -1;
> >>>  	const char *src;
> >>> @@ -974,6 +977,8 @@ static int do_dump(int argc, char **argv)
> >>>  		goto done;
> >>>  	}
> >>>  
> >>> +	have_id_filtering = !!root_type_cnt;
> >>> +
> >>>  	while (argc) {
> >>>  		if (is_prefix(*argv, "format")) {
> >>>  			NEXT_ARG();
> >>> @@ -993,6 +998,36 @@ static int do_dump(int argc, char **argv)
> >>>  				goto done;
> >>>  			}
> >>>  			NEXT_ARG();
> >>> +		} else if (is_prefix(*argv, "root_id")) {
> >>> +			__u32 root_id;
> >>> +			char *end;
> >>> +
> >>> +			if (have_id_filtering) {
> >>> +				p_err("cannot use root_id with other type filtering");
> >>> +				err = -EINVAL;
> >>> +				goto done;
> >>> +			} else if (root_type_cnt == MAX_ROOT_IDS) {
> >>> +				p_err("only %d root_id are supported", MAX_ROOT_IDS);
> >>
> >>
> >> I doubt users will often reach this limit, but if they do, the message
> >> can be confusing, because MAX_ROOT_IDS also accounts for root_type_ids[]
> >> cells used when we pass map arguments ("key" or "value" or "kv"), so you
> >> could pass 15 "root_id" on the command line and get a message telling
> >> only 16 are supported.
> >>
> >> Maybe add a counter to tell how many were defined from the rest of the
> >> command line, and adjust the value in the error message?
> > 
> > The above `if (have_id_filtering)` check prevents mixing key/value/kv
> > map args with root_id. That ought to prevent overcounting, right?
> 
> Ah, you're right, you even mentioned it in the docs, sorry. All good on
> that side, then.
> 
> Regarding the restriction, would you mind making the mention from the
> man page a bit more explicit, please? Something along:
> 
>     [...] It cannot be used with any other types of filtering, such as
>     the "key", "value", or "kv" arguments when dumping BTF for a map.
>     **root_id** can be passed multiple times...

Ack, will do.

