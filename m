Return-Path: <bpf+bounces-8410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145AF786005
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 20:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3717E1C20CB8
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982441F943;
	Wed, 23 Aug 2023 18:43:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5725B1FAA
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 18:43:23 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A100E6C;
	Wed, 23 Aug 2023 11:43:21 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 5720D5C018F;
	Wed, 23 Aug 2023 14:43:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 23 Aug 2023 14:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1692816198; x=1692902598; bh=Lf0TK4b0kz3ZTddMClnpqPUYI5onbONBpkw
	ylHQPOO4=; b=LDEVsRp1ZoH3vtP4T0b4mspjoxXr4rKZcOOmCkQIPI0QD66pBGq
	DUS6hEZLZBcl0tCKOX6orUIFChH/Aw9QN8CCe4Sc/wphnQW9fzfDzSrtA0MpcRA5
	J9tah14JVB5f/hLoz51f4glFoZ2rWZWjJVTgRHzhZTquGXaMFq1Qx1ug64/j0Zbx
	BFYrwy7LLlm5czknV3nhoajeD3HedZlmFbafDyfi1t/IIe09bL+SRmjGAXSbccH2
	MvbIuH/uSKYD78N3Fn/V/ONkTRaklhx6DcTljq/S9vnOD+GCFg9DkEXa/wFseR53
	qHzSvX4KET+wmaSivfx0oFE+vZ8nDGeJjSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1692816198; x=1692902598; bh=Lf0TK4b0kz3ZTddMClnpqPUYI5onbONBpkw
	ylHQPOO4=; b=k92Rj8m8RayyoWyKyft2/QjhXz6D6zvA5fDHuLXoVe0SFKfAFdi
	4ZWCfbdxJFXbeZvSz9oXpJEpOPqhLZmIrUluzIUVWIEDMjz2Hq2vxZHw2y1iVEUk
	Byzw5MdHCPVG7epa7pAdRV6wMb/Pgp7Xjik/+XIAKVc87CFa9ekpoR1+uaiUuEiE
	S4WAC0FruCBoUvE7ofZMH+2AwlJvWIFLWEk+amqW9O8RS/I0vt3V5NbbtuXDz3TR
	LVKPAprmn9IKqQPOYViNpTIwzrTlrlYCg73nJgbyrg8ewchXrLvelBSD0Q15ON+v
	pLeka/MWhupL8wC00vaK+DuYvh/pUBD2xAA==
X-ME-Sender: <xms:RVPmZHtr7Jg-axTKrwq7C3M5O-_eU43ceAAIAXZmHIxF4encS3DDXQ>
    <xme:RVPmZIdhlIzG5zwcNBivUg1QFQtnFi_C3oOMq05v4nONOB8Oxd_JCM070fWjS1piW
    gwrOUp5QPo4jRf0pw>
X-ME-Received: <xmr:RVPmZKwooRwDEs6wtBxayeP9G_zVIIfqf5drFzg_16b-mXUdIfDDZglTKKpYtfh51g6ZeXx0OSnsxGY2E-zg7NFwQJ3agAgwrncSlT0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefs
    tddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueekffelteekkeekgeegffev
    tddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:RlPmZGNFnOaMDbTDjSOABTeMWu_Xt6pG2KgYUN5YyIsmUKBv_vBr1w>
    <xmx:RlPmZH9BaKRH_k11aS6oNB5pLM93vv7cKUxFjlEU5xzD94AofHT7tw>
    <xmx:RlPmZGWZNq88WGFK0R46JTvTl-YTK1TypB2i6JOCrWU8mg74cgBbbA>
    <xmx:RlPmZKWPSK-iiIPVWhwnp8V0nJnb54D-U7cpE2wGhSJLxuqiyNuGTw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 14:43:16 -0400 (EDT)
Date: Wed, 23 Aug 2023 12:43:15 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] libbpf: Add bpf_object__unpin()
Message-ID: <gu4eynktnim7l2oln4i4sgmziluhdfmzgcbbukfebv5bo57g5r@5kxyfar7tlzv>
References: <aeb83832ae61bbf463e1b2e39c1e30c3b227f5a5.1692769396.git.dxu@dxuuu.xyz>
 <CAEf4BzbGhhOyeWLuP95K20344aZnQ61TjiQ=scd5TKz_fiP_AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbGhhOyeWLuP95K20344aZnQ61TjiQ=scd5TKz_fiP_AQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 10:19:10AM -0700, Andrii Nakryiko wrote:
> On Tue, Aug 22, 2023 at 10:44 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > For bpf_object__pin_programs() there is bpf_object__unpin_programs().
> > Likewise bpf_object__unpin_maps() for bpf_object__pin_maps().
> >
> > But no bpf_object__unpin() for bpf_object__pin(). Adding the former adds
> > symmetry to the API.
> >
> > It's also convenient for cleanup in application code. It's an API I
> > would've used if it was available for a repro I was writing earlier.
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  tools/lib/bpf/libbpf.c   | 15 +++++++++++++++
> >  tools/lib/bpf/libbpf.h   |  1 +
> >  tools/lib/bpf/libbpf.map |  1 +
> >  3 files changed, 17 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 4c3967d94b6d..96ff1aa4bf6a 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -8376,6 +8376,21 @@ int bpf_object__pin(struct bpf_object *obj, const char *path)
> >         return 0;
> >  }
> >
> > +int bpf_object__unpin(struct bpf_object *obj, const char *path)
> > +{
> > +       int err;
> > +
> > +       err = bpf_object__unpin_programs(obj, path);
> > +       if (err)
> > +               return libbpf_err(err);
> > +
> > +       err = bpf_object__unpin_maps(obj, path);
> > +       if (err)
> > +               return libbpf_err(err);
> > +
> > +       return 0;
> > +}
> > +
> 
> pin APIs predate me, and I barely ever use them, but I wonder if
> people feel fine with the fact that if any single unpin fails, all the
> other programs/maps will not be unpinned? I also wonder if the best
> effort unpinning of everything (while propagating first/last error) is
> more practical? Looking at bpf_object__pin_programs, we try unpin
> everything, even if some unpins fail.
> 
> Any thoughts or preferences?

Yeah, I noticed bpf_object__pin_programs() tries to simulate some
transactionality. However, bpf_object__unpin_programs() and
bpf_object__unpin_maps() both do not try rollbacks and have already been
exposed as public API. So I thought it would be best to stay consistent.

I also figured it's unlikely only a single unpin() fails. For pin(), you
could have name collisions. But not for unpin(). I suppose the main
error case is if some 3rd party (or yourself) comes in and messes with
your objects in bpffs.

In general, though, there are other places where transactionality would
be a nice property. For example, if I have a TC prog that I want to
attach to, say, _all_ ethernet interfaces, I have to be careful about
rollbacks in the event of failure on a single iface.

It would be really nice if the kernel  had a general way to provide
atomicity w.r.t. multiple operations. But I suppose that's a hard
problem.

[...]

Thanks,
Daniel

