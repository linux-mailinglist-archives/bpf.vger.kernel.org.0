Return-Path: <bpf+bounces-46766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5879F0052
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A4C188D9FC
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73CD1DED7C;
	Thu, 12 Dec 2024 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Cr5nd9ba";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B9K2i4pL"
X-Original-To: bpf@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B8D1DED4C;
	Thu, 12 Dec 2024 23:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046912; cv=none; b=Vv9x+bb48kFreiz0UyCEDnmvvr4/naBJVq18ZBdIzfkjRGklhNLiyeSoZN7sZ3vj+0pYIcpISuVIMig+1loLYHYImdOgq+qdHtQehrEXY8GQV5qmGEimDa/Ck348v75yrUtBbOpncavoHneD+BRSy8X3xFpYC773BIVoSUky9RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046912; c=relaxed/simple;
	bh=0EfcN+Lb8+Gr9/AGepZG/uUIlT7TVkuzGBF+4biIAfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdAzTGHm7MP8ISu0LyRF4DWF8taUg5gvHU6JMDcDB0t9LwlxFCYfHo0Yb2ljqQdQHajVBezLhWA6YddrAOY6BQjytugdhnGYi4sBctoQ+Y5Upfu0qyAmlR7cxBwIpJxSm5AwjvFIRuV8sdAL2cId9DJnmJZl1VXNeyUJ+/w7sIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Cr5nd9ba; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B9K2i4pL; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id F08A720049B;
	Thu, 12 Dec 2024 18:41:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Dec 2024 18:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1734046908;
	 x=1734054108; bh=Xsk7X3/UkTfDfA4IJFdI69G+yLRSh7hTw4MpALt07mM=; b=
	Cr5nd9ba4FXZHzEWTYi+Rh9yBQO6c+qjKDGoJX143moXaA5i2FroQBDP7LHBMFMX
	YMV9QDVfo5memjolEePbZNIMuNL9iBI14eG/FjpdbDhO6RHoBeD3eYpV1ul0FxAT
	LmpLGLioF1Eltk0Qub/iYej97T1LduYyG5s7yJbyoQJR4O/QwVSRcKkDWLzxHLwU
	v/KDKDxVNeGHMjyMDDeUR4ZV9DQ5n/iSeYUwUFCy063GNpOzQNxUGc6ZtzVLjZeU
	/WAdDj+b7r/MErkk3EUGToWb068Dlvrh3RSKME/lLepAr+gaOK3o/J/B9fqa2fr0
	qMp6Wn3cjyVyhLfOmUzJJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734046908; x=
	1734054108; bh=Xsk7X3/UkTfDfA4IJFdI69G+yLRSh7hTw4MpALt07mM=; b=B
	9K2i4pLQ/Mci3TioKT2jryuSH36oJAQAfDvmTCd183UoBbahepNQyf8N9Z0ezpoN
	wHMFPBvbJamjN+h+ArKA4yUA2pH+xJqIkV8E75s6OYz3CqwfbmYjT5aJLt/V7Jqe
	fu1LIKKY/Eajb+rJ22Os230DMGHHF33HCmsSXQPAP99bSdjH1dlzz9kdZ1WpC4qu
	TCySo1UOmrBHmgmzhCBrYnc/ESzUIDElJskNh7lxAbESZy0ntrAMC0q8KrbWMJLL
	FgUNSKZfIP/bxD8m4cBp0LcomFqeYdwlWoaGjLG/aRe659/5+VhmcAvriLq4Q4t8
	vCXq7NvZg1I/Jfs/54wZA==
X-ME-Sender: <xms:vHRbZ-Zou_2if7EFRsBlv6l--FrjL6AiXGmc0vgbCPXg1BKMJvREuQ>
    <xme:vHRbZxZqCNnVKVSCmS1nJTCLzsZRG75ZGq1Hu4xkrwDDgRFvQqgvl9lgJxwlC8bOa
    YB96QL6WwjbMNUPow>
X-ME-Received: <xmr:vHRbZ49Hjc_drZUX76dDuaOiatygbBOlAo5TiEnWTp1KZORd-Q829FNXhWAQ525w9TLCI2KQHyOJne2U1UTGqpfenF3ttn3DOfqtYTSqNBYBCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhgg
    tggugfgjsehtkefstddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesug
    iguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepffffgeegkeejvdejgeehteekudfh
    gfefgeevkeelhfegueeljefhleejtdekveffnecuffhomhgrihhnpehgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegu
    gihusegugihuuhhurdighiiipdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheprghnughrihhirdhnrghkrhihihhkohesghhmrghilhdrtgho
    mhdprhgtphhtthhopehhrgifkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohh
    hnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghstheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepqhhmoheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegurghnihgv
    lhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vHRbZwpeKYwydy07I0zy8XIwo_giI6SuJwP8hwxI3K15tQT9eU7fVg>
    <xmx:vHRbZ5rKlXHpj4wzUWbdn5bf4VhgfBOE_jddaIapGpbXB_qKBGKQ1w>
    <xmx:vHRbZ-Q7rMMrjmyEFzN1XEzTgKZPTB0tnlcprVbMQAknJA0MlkGeRQ>
    <xmx:vHRbZ5rp8W4v-M0Cu0e3569qasezkBGhTuqT3x7WA4LysOnwLSkVMA>
    <xmx:vHRbZ4ex_sqDOfLhf14PNui0a5nOLckCg_-JtrCIMKD1W3D-0WbO-zBB>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 18:41:45 -0500 (EST)
Date: Thu, 12 Dec 2024 16:41:43 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: hawk@kernel.org, john.fastabend@gmail.com, ast@kernel.org, 
	qmo@kernel.org, davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org, 
	kuba@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, antony@phenome.org, toke@kernel.org
Subject: Re: [PATCH bpf-next v3 3/4] bpftool: btf: Support dumping a single
 type from file
Message-ID: <zf62rqtgvl63sawxltmpgcnpek5bt3w5pleznby3zqb7ezhvdz@wqlwxy2f43wt>
References: <cover.1733787798.git.dxu@dxuuu.xyz>
 <3bc17d33161961409dc77a5de29761bf2bed4980.1733787798.git.dxu@dxuuu.xyz>
 <CAEf4BzaA9_up=3npADgJv8pCVg4eVzsWevef69c3PkdyuWNXDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaA9_up=3npADgJv8pCVg4eVzsWevef69c3PkdyuWNXDQ@mail.gmail.com>

On Thu, Dec 12, 2024 at 11:09:34AM GMT, Andrii Nakryiko wrote:
> On Mon, Dec 9, 2024 at 3:45 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
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
> >  .../bpf/bpftool/Documentation/bpftool-btf.rst |  7 +++++--
> >  tools/bpf/bpftool/btf.c                       | 21 ++++++++++++++++++-
> >  2 files changed, 25 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> > index 245569f43035..4899b2c10777 100644
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
> > @@ -67,6 +67,9 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*]
> >      formatting, the output is sorted by default. Use the **unsorted** option
> >      to avoid sorting the output.
> >
> > +    **root_id** option can be used to filter a dump to a single type and all
> > +    its dependent types. It cannot be used with any other types of filtering.
> > +
> >  bpftool btf help
> >      Print short help message.
> >
> > diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> > index 3e995faf9efa..18b037a1414b 100644
> > --- a/tools/bpf/bpftool/btf.c
> > +++ b/tools/bpf/bpftool/btf.c
> > @@ -993,6 +993,25 @@ static int do_dump(int argc, char **argv)
> >                                 goto done;
> >                         }
> >                         NEXT_ARG();
> > +               } else if (is_prefix(*argv, "root_id")) {
> > +                       __u32 root_id;
> > +                       char *end;
> > +
> > +                       if (root_type_cnt) {
> > +                               p_err("cannot use root_id with other type filtering");
> 
> this is a confusing error if the user just wanted to provide two
> root_id arguments... Also, why don't we allow multiple root_ids?
> 
> I'd bump root_type_ids[] to have something like 16 elements or
> something (though we can always do dynamic realloc as well, probably),
> and allow multiple types to be specified.
> 
> Thoughts?

That's a good point. I added this check b/c I didn't think it would
make sense to allow `root_id` filtering in combination with map dump
filtering (which uses same root_type_ids param):

        map MAP [{key | value | kv | all}]

But code can easily be tweaked to still block combination but allow
multiple `root_id`s when used alone. 16 seems sufficient to me.

Do you think it'd be more bpftool-y to require "root_id" each time or to
just take a comma separated value?

