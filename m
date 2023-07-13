Return-Path: <bpf+bounces-4921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 919DD7517C1
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652431C21265
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90855808;
	Thu, 13 Jul 2023 04:56:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE81629
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 04:56:09 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8451BF9
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 21:56:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id B66CD5C006B;
	Thu, 13 Jul 2023 00:56:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 13 Jul 2023 00:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1689224166; x=1689310566; bh=wwE+9hVrkLq8K7DGtQiyjWY0IxvplK3clSY
	c273fHBw=; b=pBJz883PFL30HLDPzxYXRAQ1QdOOOr7kQFz6CCJ2jrCxaTljWDT
	MnWRracZJEpcnrmSbMcdQA8KpWIOYGiezGNaaF3wkTu7ZOEiilDnNXTQiPs9owqK
	Q2xsKgxb5NaDamY70GKY7H0p6pwvGRfZxvKCiok2rUKBYPW2QtJwWAwGeVi1F4MP
	ddZ72G1Nxc+H5a56A/QrAqKshBAUEd1WbF0C6fCReM4PjgfllML3E6Qf8lFYPbhr
	+Il/q33uXiB1SrfiYXJ4kp0my6GUcdpUlhnmWXz8ULFrmjTqSYCL+y9UKyZ+zddn
	psZPyFuHbazqRgwGmXasTW0b4w80lVc4Avw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1689224166; x=1689310566; bh=wwE+9hVrkLq8K7DGtQiyjWY0IxvplK3clSY
	c273fHBw=; b=mrauFplJReii+/IDNszDnP2Tcc5o9ahlTNNcFS2B5srQ7+fv/tS
	7zp9rqPb4egQroxzWyy42b0Kn/2A5alrzx8zreIpTgqkNPR8yzS9JEaUZ+ilCOAE
	KHbrPZOPyn3Q9S61mEhkiUTn8D/bhi+LJm+hAICKp+cC6ZgidXY5urGSMcoqwvr7
	UtGFxoPXHVQmY8qQ85va86ogfNjT27T7HX3qfD1wKgXysRfPvjyco0fC1NU8p090
	ZiAAOgwZv3EBBkWYK2Bgj5m41GBTarky7qF+zUM2FvESQ8v/ooqe3ttnTc07WAH+
	7PZjWVtSmQYw2WQj5ixQ+blTqNlZDsR/B9A==
X-ME-Sender: <xms:5oOvZG8Js8rZdoKXh50wVNc9jaq-rvpbyKl5c99HpjQMZv9fyzftlQ>
    <xme:5oOvZGva_mRkSRiVxe-AcnzwJsiPz5X3rsZ4BVICFfJXz86RyDRSs4wGL9kSZDSgS
    Ld2DIke7gNtkWtQxg>
X-ME-Received: <xmr:5oOvZMB5wxQ7YNVSP8Vd4PaqeYzFwgW6wNI1xoGBeRubLGzA_DNSjCDTO0ci_6r-DeTUa_WP15NPS2sx-gJ4S1T0YgSxvmoqSHEz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeefgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculddujedmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddt
    tdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueekffelteekkeekgeegffevtddv
    jeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:5oOvZOfCgHgkp7euC_m6CnFU59-37YQ-tdzJqN-wB3BRVF_bcZ0X3Q>
    <xmx:5oOvZLNKJjnIttfs9rgt-nphYtQ2-M4X0CAwqWwZr4CrYjeyRj7pkw>
    <xmx:5oOvZIk8VVTxXtl52yyTtJ3p7TUP8ba7covh1pDDGXBYgYIZ75oi3w>
    <xmx:5oOvZG1vINOGJDjCs8qW_j_yL1_YusXA4vmB4XwyW5wbkMFn6UV2VQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jul 2023 00:56:05 -0400 (EDT)
Date: Wed, 12 Jul 2023 22:56:04 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Jackie Liu <liu.yun@linux.dev>, Jiri Olsa <olsajiri@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, liuyun01@kylinos.cn
Subject: Re: [PATCH] libbpf: Support POSIX regular expressions for multi
 kprobe
Message-ID: <xzhh4o27vtnstev3i64wqwd4jkuatvqrgoev3fv4igequpjiye@wpsfpb4p4hr7>
References: <20230712010504.818008-1-liu.yun@linux.dev>
 <CAEf4Bzay5QC_pbH-Km-oqL8MzzyUCtKU3Xc2Jie5bbRc=PBi5A@mail.gmail.com>
 <CAADnVQ+KwbRo0QsNOZPVW2Xpn1x5=N6pNL1MwKGrNnbbtTX3Lg@mail.gmail.com>
 <CAEf4BzYyH1+_6_LCro9AYnWknrv7ZFW03+cqqkthyCdf7qQ10g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYyH1+_6_LCro9AYnWknrv7ZFW03+cqqkthyCdf7qQ10g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 09:13:04PM -0700, Andrii Nakryiko wrote:
> On Wed, Jul 12, 2023 at 8:05 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Jul 11, 2023 at 10:42 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Jul 11, 2023 at 6:05 PM Jackie Liu <liu.yun@linux.dev> wrote:
> > > >
> > > > From: Jackie Liu <liuyun01@kylinos.cn>
> > > >
> > > > Now multi kprobe uses glob_match for function matching, it's not enough,
> > > > and sometimes we need more powerful regular expressions to support fuzzy
> > > > matching, and now provides a use_regex in bpf_kprobe_multi_opts to support
> > > > POSIX regular expressions.
> > > >
> > > > This is useful, similar to `funccount.py -r '^vfs.*'` in BCC, and can also
> > > > be implemented with libbpf.
> > > >
> > > > Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> > > > ---
> > > >  tools/lib/bpf/libbpf.c | 52 ++++++++++++++++++++++++++++++++++++++----
> > > >  tools/lib/bpf/libbpf.h |  4 +++-
> > > >  2 files changed, 51 insertions(+), 5 deletions(-)
> > > >
> > >
> > > Let's hold off on adding regex support assumptions into libbpf API.
> > > Globs are pretty flexible already for most cases, and for some more
> > > advanced use cases users can provide an exact list of function names
> > > through opts argument.
> > >
> > > We can revisit this decision down the road, but right now it seems
> > > premature to sign up for such relatively heavy-weight API dependency.
> >
> > regexec() is part of glibc and we cannot link it statically,
> > so no change in libbpf.a/so size.
> 
> right, I wasn't worried about the code size increase of libbpf itself
> 
> > Are you worried about ulibc-like environment?
> 
> This is one part. musl, uclibc, and other alternative implementations
> of glibc: do they support same functionality with all the same options
> and syntax. I'd feel more comfortable if we understood well all the
> implications of relying on this regex API: which glibc versions
> support it, same for musl. Are there any extra library dependencies
> that we might need to add (like -lm for some math functions). I'm not
> very familiar also with what regex flavor is implemented by POSIX
> regex, is it the commonly-expected Perl-compatible one, or something
> else?
> 
> Also, we should have a good story on how this regex syntax is
> supported in SEC() definitions for both kprobe.multi and uprobe.multi.
> 
> Stuff like this.
> 
> But also, looking at bpftrace, I don't think it supports regex-based
> probe matching (e.g., I tried 'kprobe:.*sys_bpf' and it matched
> nothing; maybe there is some other syntax, but my Google-fu failed
> me). So assuming I didn't miss anything obvious with bpftrace, the
> fact that it's been around for so long with so many users and lack of
> regex doesn't seem to be the problem,

bpftrace only supports wildcard (`*`) operator like in globs. One thing
that might help bpftrace get away with that is being able to specify multiple 
attachpoints for a single probe. Eg.

```
tracepoint:foo:bar,
tracepoint:baz:something
{
        print("hi")
}
```

Thanks,
Daniel

