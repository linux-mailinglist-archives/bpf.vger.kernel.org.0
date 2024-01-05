Return-Path: <bpf+bounces-19097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3DB824C8D
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 02:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D5A284C8E
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 01:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4161FA3;
	Fri,  5 Jan 2024 01:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Clbt61oB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i+l8k8Vu"
X-Original-To: bpf@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9D81C10;
	Fri,  5 Jan 2024 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 24AD23200B83;
	Thu,  4 Jan 2024 20:24:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 04 Jan 2024 20:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1704417841;
	 x=1704504241; bh=8oxbnZeja7VLjsmNqyq5U5Vh+kwCbUgeDbgUqppXGZw=; b=
	Clbt61oBxHKzbCGy07g4rOxFGxLX2tL7ztb/4TkbPXfZQuKZQ/QyOJQC/agh/u3h
	4fxlz6ral5PdX4FkRqJWcF6oOsXVYXhgCtHv1LjN2lvqDGU7s0B9cTK1b0BBwMSN
	Z21AW0UE1OfncoCrqw/ZTJ03MT0LBK7yK5qE9/P+P351qT15DP1nWGH4RNBxBmGb
	tO6f5eGnKgZ1kbYkENSmdY8a4F2wJztAWfX5xOY89USB7OLTQuskrt4lGgi3cc9T
	w7b9FmxorG2Xa4WFoaEXObUiXijrMNw7TQkTptGio3KGcNk8JF3fr8BDUWUuZWqW
	oKTxhIxshUpNCydt78/Q0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704417841; x=
	1704504241; bh=8oxbnZeja7VLjsmNqyq5U5Vh+kwCbUgeDbgUqppXGZw=; b=i
	+l8k8VuIIdFlO50LVgUeJ1KML/J4piu+x2pGugwd5FztWf51/Ha/wIbikIFRayzp
	T7n59YgISpvOMgNWfbOfEuBVVvKfosnDYq6HPcq5F1UX6AmEMkdiAIGBHevcT/Dm
	S2EUPLEmdWoad7JyXOn3jWXU7RWYCArPyw3wcR4dk1suiIFlEOhaMmkts8ndy248
	9tDIS1kH9aqutke0Bfh6+hh3+vQGe3Af4gHoOI3D7L0FAvpWUBIWHpzgWAsUQlD0
	PM+Nmh7bZ8JinIJP3b/Ox/mxbQbRQkLLTndWItk2SNGEQRo4mXSvM982IvCXhiQR
	DjV2EM404gB2LJeKh54tA==
X-ME-Sender: <xms:MVqXZSKBaN7TBhy4Zc2VdmVgU2iOjocnFdMiSSbj67X6d8369G6Ugw>
    <xme:MVqXZaKj0WUXZtlpI0oTrRKBjodl_ocKWNAYGm1i6MNkSwITV2NiXAl395E-aWn6-
    L0B9LCLdQuyStiJ0w>
X-ME-Received: <xmr:MVqXZSuQ_v8RvaMsu0noBR27s66DAhhJndwlJlMp5FBIwU845HUb6zYQoIxDtwjSyMxcp4UUBAbEpjxAhOsfvQAgaXUxjOPCktOCE2c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegkedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpeffffeggeekjedvjeegheetkeduhffgfeegveeklefhgeeu
    leejhfeljedtkeevffenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdr
    giihii
X-ME-Proxy: <xmx:MVqXZXZwcSucBHIhiIBwPwtGo9-q9c77HCauzLkeGXV8HjMuHQH7pw>
    <xmx:MVqXZZaqYqcT9VxtI0DGRaCm_ZP9bPeKhD8rUgvJ66XIhiV9dl2TcA>
    <xmx:MVqXZTACdMHw1kpLkYuwllTDf7gxzqYcenRHKF_77XgrFHA__kvrTg>
    <xmx:MVqXZSIUUz5GnIstwKXA44tQlTXR3xA31LFZ7_wMUlud7BuBd_h6yQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 20:24:00 -0500 (EST)
Date: Thu, 4 Jan 2024 18:23:58 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: btf: Support optional flags for
 BTF_SET8 sets
Message-ID: <dpjloyytomne6efi76qe4mmh3mdjp67penogwbak7ojznf23wc@5gs6o7gc2gdt>
References: <cover.1704324602.git.dxu@dxuuu.xyz>
 <29644dc7906c7c0e6843d8acf92c3e29089845d0.1704324602.git.dxu@dxuuu.xyz>
 <ZZaVFxMvmMjbOlra@krava>
 <CAADnVQKZZw-e12-BOJsMMiA3s+vOskQEYRqhviQC2rBMf4AckA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKZZw-e12-BOJsMMiA3s+vOskQEYRqhviQC2rBMf4AckA@mail.gmail.com>

On Thu, Jan 04, 2024 at 09:11:56AM -0800, Alexei Starovoitov wrote:
> On Thu, Jan 4, 2024 at 3:23 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Jan 03, 2024 at 04:31:55PM -0700, Daniel Xu wrote:
> > > This commit adds support for optional flags on BTF_SET8s.
> > > struct btf_id_set8 already supported 32 bits worth of flags, but was
> > > only used for alignment purposes before.
> > >
> > > We now use these bits to encode flags. The next commit will tag all
> > > kfunc sets with a flag so that pahole can recognize which
> > > BTF_ID_FLAGS(func, ..) are actual kfuncs.
> > >
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > ---
> > >  include/linux/btf_ids.h | 14 +++++++++-----
> > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > > index a9cb10b0e2e9..88f914579fa1 100644
> > > --- a/include/linux/btf_ids.h
> > > +++ b/include/linux/btf_ids.h
> > > @@ -183,17 +183,21 @@ extern struct btf_id_set name;
> > >   * .word (1 << 3) | (1 << 1) | (1 << 2)
> > >   *
> > >   */
> > > -#define __BTF_SET8_START(name, scope)                        \
> > > +#define ___BTF_SET8_START(name, scope, flags)                \
> > >  asm(                                                 \
> > >  ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"   \
> > >  "." #scope " __BTF_ID__set8__" #name ";        \n"   \
> > >  "__BTF_ID__set8__" #name ":;                   \n"   \
> > > -".zero 8                                       \n"   \
> > > +".zero 4                                       \n"   \
> > > +".long " #flags                               "\n"   \
> > >  ".popsection;                                  \n");
> > >
> > > -#define BTF_SET8_START(name)                         \
> > > +#define __BTF_SET8_START(name, scope, flags, ...)    \
> > > +___BTF_SET8_START(name, scope, flags)
> > > +
> > > +#define BTF_SET8_START(name, ...)                    \
> > >  __BTF_ID_LIST(name, local)                           \
> > > -__BTF_SET8_START(name, local)
> > > +__BTF_SET8_START(name, local, ##__VA_ARGS__, 0)
> >
> > I think it'd better to use something like:
> >
> >   BTF_SET8_KFUNCS_START(fsverity_set_ids)
> >
> > instead of:
> >
> >   BTF_SET8_START(fsverity_set_ids, BTF_SET8_KFUNC)
> >
> > and to keep current BTF_SET8_START without flags argument, like:
> >
> >   #define BTF_SET8_START(name) \
> >     __BTF_SET8_START(... , 0, ...
> >
> >   #define BTF_SET8_KFUNCS_START(name) \
> >     __BTF_SET8_START(... , BTF_SET8_KFUNC, ...
> 
> I was about to suggest the same :)
> 
> We can drop SET8 part as well, since it's implementation detail.
> Just BTF_KFUNCS_START and pair it with BTF_KFUNCS_END
> that will be the same as BTF_SET8_END.
> Until we need to do something else with these macros.

Ack, will change.

> 
> >
> > also I'd rename BTF_SET8_KFUNC to BTF_SET8_KFUNCS (with S)
> >
> > do you have the pahole changes somewhere? would be great to
> > see all the related changes and try the whole thing
> 
> +1
> without corresponding pahole changes it's not clear whether
> it actually helps.

Here's a checkpointed branch: https://github.com/danobi/pahole/tree/kfunc_btf-mailed .
I won't force push to it.

It should work against this patchset. I might need to clean it up a bit still.

Thanks,
Daniel

