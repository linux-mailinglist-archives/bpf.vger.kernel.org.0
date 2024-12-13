Return-Path: <bpf+bounces-46869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818939F12A4
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 17:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1671637D9
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 16:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F3E1F37B4;
	Fri, 13 Dec 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="C7KF+J7s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zVCX1jg+"
X-Original-To: bpf@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94441F12FB;
	Fri, 13 Dec 2024 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108325; cv=none; b=fOml831qFtw0k9/Dp6xu0ZWzgnG+EKk8Xmny7PHem65fZMWeSqaOa8DlL6rEd3k0pwjRB07QJy0Wjk84BI+TrSGhrfjvLEdK3bv7+LX62UXwsSmKSXv6cC6vRKahp1C1Scs/lb/iym8KLuXCoRjdp8iYvNkj51omLZYSz+hyRKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108325; c=relaxed/simple;
	bh=FlPMyiGb4GDg6SDbTjAK9Jyl2l4pk+M3GxvkYl8VfIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmIyCbBFHzZgNgX0U6M+bZm9ON13hw0qXl1oXpsgORbAj4gsl+4P+p+kESJyNQ1tN/6Y6VofqSvT9rkn+Hc9d/E8O9l3eL5CZYDWsOTUJO42rFW7qpOvgEBEtqq7rn0NDTE/Lt+AQsw4NFdpMJ/PnZQJtpuRBQwksKU8YPwJKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=C7KF+J7s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zVCX1jg+; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 26AA01D409D8;
	Fri, 13 Dec 2024 11:45:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 13 Dec 2024 11:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734108321; x=1734115521; bh=kk8bI5G+ni
	7zW/QRSUhOc2AkfvUuTUQ3G7B4U74SJnE=; b=C7KF+J7sN/ckCHwK51tdhKgW4c
	Pxx+cHTfj0AAwdc/q8/uMLYIHnSEer2O9a54MREd4ropCvHwEbQgTNKBaz8o+n7k
	0Qz2HvU/TafwgNvU/3ucTXlVdIh4AKrxDEgZ+Dp9XNphc3U93f8eTgtFyCL0YEG3
	GmiGlqn/YSzfdWgn0l+vTJ3PrXJkFZMKFdZxQvbRqARXYX/R8hYiR4KjYxF/mroS
	MJytMNmggFvyGgdbpP22u3TtC5JIMXkyg5bBcmaxfTI0SI2iorjy/go5ajwaZlIE
	Nz/hIoc1mm9XIUAWxeH0VfABTsLMUpzOjp9w1nZoAuSSQ4/eFRw/TFQIY+yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734108321; x=1734115521; bh=kk8bI5G+ni7zW/QRSUhOc2AkfvUuTUQ3G7B
	4U74SJnE=; b=zVCX1jg+vt8psI79Dx2HU24Y3OSWiQK5ytYrWsQl1wqVNqjOB8U
	ViSBqcMl++DTgLl2BdMIikYlxThmmVJhB3pxh0Vd/PcsRilYQFpI0d5IJyGA5mdL
	FGbzbIKpkmDr3Hf/O6x7eHMHA80ngcf3/+oTkquznkrI+yPNlVHCbMc3AmwrzMts
	0m3JMxhekwRS8Acaa4X21DfrnkcU9TZ8DsJKoY88nDSaHyZnJbomvnWYl0gkxklw
	+O0YPM4lUXuDiE4UlU5MRKgzgjRASaU4HrDdn7m4xViHx6w/v3HZRQ46CyZzrq0+
	pDQKkicHBoicaIyTdmwU5hKu8Bp0R8dqf6g==
X-ME-Sender: <xms:oGRcZ_asy4a5roNTlZjDkFXz9ph3fqO_jl0FP3WirqEPCvY5O-osEw>
    <xme:oGRcZ-bE23Au7TKifYfXoUUa4YfvAMyKSCZxPwqz5uaEbS-tPETkTZRgdG9cBMtfq
    CNGEoM9sSiSvaehjw>
X-ME-Received: <xmr:oGRcZx_S4W8jbvSIhrSzUn-vvIWl9NOZZRTcqV-ihI4fakDcn8-KK3zakZWjkc0JDMouBtCFMdKYD_-WFDYij7nx6w9bialF610XCQ750LOlaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhgg
    tggujgesthdtsfdttddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugi
    huuhhurdighiiiqeenucggtffrrghtthgvrhhnpedtjeekudelieetvdefgedvgeejhefh
    vdfggfejudeutdegveeivedthfehfeelkeenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugig
    uhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehqmhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgif
    kheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhho
    hhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghstheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhn
    vghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtth
    hopehmrghrthhinhdrlhgruheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:oGRcZ1q9ZWE-Hgfvb-IW9CKDiHXrxeYLnDxJV5zB8vgfviyz1jsSfw>
    <xmx:oGRcZ6o_rLdlMydvk7aFvDI9_HwFnW9fxzYYbz9EaLo0HGIitfxRSQ>
    <xmx:oGRcZ7RzKJMqTXbHmMQSjQaX6k7ZXXmYZguadNJ73OuJfx_y7_Bh8w>
    <xmx:oGRcZyqNujQWwm8vX9fxH-AiL7iEp_ARS1F1I2IweAe3p0KLuzRjSQ>
    <xmx:oGRcZ1cnGG4sqeWZvv6Am-X6krtXd2IpYZ87qua_RRrd_UQ8wR3sYl5a>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 11:45:17 -0500 (EST)
Date: Fri, 13 Dec 2024 09:45:16 -0700
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
Message-ID: <fojqbtlpjh3jrpzzctgllxtnyncbtbzw6q7qfrezrigpc2qqek@6m7cppwvgwb5>
References: <cover.1734052995.git.dxu@dxuuu.xyz>
 <5ec7617fd9c28ff721947aceb80937dc10fca770.1734052995.git.dxu@dxuuu.xyz>
 <7fa902e5-0916-4bc9-b1e0-2729903d3de0@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fa902e5-0916-4bc9-b1e0-2729903d3de0@kernel.org>

Hi Quentin,

On Fri, Dec 13, 2024 at 03:17:36PM GMT, Quentin Monnet wrote:
> 2024-12-12 18:24 UTC-0700 ~ Daniel Xu <dxu@dxuuu.xyz>
> > Some projects, for example xdp-tools [0], prefer to check in a minimized
> > vmlinux.h rather than the complete file which can get rather large.
> > 
> > However, when you try to add a minimized version of a complex struct (eg
> > struct xfrm_state), things can get quite complex if you're trying to
> > manually untangle and deduplicate the dependencies.
> > 
> > This commit teaches bpftool to do a minimized dump of a specific types by
> > providing a optional root_id argument(s).
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
> >  .../bpf/bpftool/Documentation/bpftool-btf.rst |  8 +++-
> >  tools/bpf/bpftool/btf.c                       | 39 ++++++++++++++++++-
> >  2 files changed, 43 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> > index 245569f43035..dbe6d6d94e4c 100644
> > --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> > +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> > @@ -24,7 +24,7 @@ BTF COMMANDS
> >  =============
> >  
> >  | **bpftool** **btf** { **show** | **list** } [**id** *BTF_ID*]
> > -| **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*]
> > +| **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*] [**root_id** *ROOT_ID*]
> >  | **bpftool** **btf help**
> >  |
> >  | *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
> > @@ -43,7 +43,7 @@ bpftool btf { show | list } [id *BTF_ID*]
> >      that hold open file descriptors (FDs) against BTF objects. On such kernels
> >      bpftool will automatically emit this information as well.
> >  
> > -bpftool btf dump *BTF_SRC* [format *FORMAT*]
> > +bpftool btf dump *BTF_SRC* [format *FORMAT*] [root_id *ROOT_ID*]
> >      Dump BTF entries from a given *BTF_SRC*.
> >  
> >      When **id** is specified, BTF object with that ID will be loaded and all
> > @@ -67,6 +67,10 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*]
> >      formatting, the output is sorted by default. Use the **unsorted** option
> >      to avoid sorting the output.
> >  
> > +    **root_id** option can be used to filter a dump to a single type and all
> > +    its dependent types. It cannot be used with any other types of filtering.
> > +    It can be passed multiple times to dump multiple types.
> > +
> >  bpftool btf help
> >      Print short help message.
> >  
> > diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> > index 3e995faf9efa..2636655ac180 100644
> > --- a/tools/bpf/bpftool/btf.c
> > +++ b/tools/bpf/bpftool/btf.c
> > @@ -27,6 +27,8 @@
> >  #define KFUNC_DECL_TAG		"bpf_kfunc"
> >  #define FASTCALL_DECL_TAG	"bpf_fastcall"
> >  
> > +#define MAX_ROOT_IDS		16
> > +
> >  static const char * const btf_kind_str[NR_BTF_KINDS] = {
> >  	[BTF_KIND_UNKN]		= "UNKNOWN",
> >  	[BTF_KIND_INT]		= "INT",
> > @@ -880,7 +882,8 @@ static int do_dump(int argc, char **argv)
> >  {
> >  	bool dump_c = false, sort_dump_c = true;
> >  	struct btf *btf = NULL, *base = NULL;
> > -	__u32 root_type_ids[2];
> > +	__u32 root_type_ids[MAX_ROOT_IDS];
> > +	bool have_id_filtering;
> >  	int root_type_cnt = 0;
> >  	__u32 btf_id = -1;
> >  	const char *src;
> > @@ -974,6 +977,8 @@ static int do_dump(int argc, char **argv)
> >  		goto done;
> >  	}
> >  
> > +	have_id_filtering = !!root_type_cnt;
> > +
> >  	while (argc) {
> >  		if (is_prefix(*argv, "format")) {
> >  			NEXT_ARG();
> > @@ -993,6 +998,36 @@ static int do_dump(int argc, char **argv)
> >  				goto done;
> >  			}
> >  			NEXT_ARG();
> > +		} else if (is_prefix(*argv, "root_id")) {
> > +			__u32 root_id;
> > +			char *end;
> > +
> > +			if (have_id_filtering) {
> > +				p_err("cannot use root_id with other type filtering");
> > +				err = -EINVAL;
> > +				goto done;
> > +			} else if (root_type_cnt == MAX_ROOT_IDS) {
> > +				p_err("only %d root_id are supported", MAX_ROOT_IDS);
> 
> 
> I doubt users will often reach this limit, but if they do, the message
> can be confusing, because MAX_ROOT_IDS also accounts for root_type_ids[]
> cells used when we pass map arguments ("key" or "value" or "kv"), so you
> could pass 15 "root_id" on the command line and get a message telling
> only 16 are supported.
> 
> Maybe add a counter to tell how many were defined from the rest of the
> command line, and adjust the value in the error message?

The above `if (have_id_filtering)` check prevents mixing key/value/kv
map args with root_id. That ought to prevent overcounting, right?

Thanks,
Daniel

