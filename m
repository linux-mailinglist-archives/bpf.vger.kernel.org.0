Return-Path: <bpf+bounces-6177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 703D576667A
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 10:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10811C211E5
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 08:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8D3D2F8;
	Fri, 28 Jul 2023 08:10:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EABC2C0
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 08:10:30 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6EA3A8B;
	Fri, 28 Jul 2023 01:10:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-307d58b3efbso1753792f8f.0;
        Fri, 28 Jul 2023 01:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690531824; x=1691136624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fSyIgkTDfn7ndWDwr/HaBWKVpiJ4+BDlR0fa7JayHA4=;
        b=ZP+2bbfBzI+b3U33eXkS1KQ/jjCW2VYAjtcdGLsL1h9UGXdOUFnM+qAhmCCz0W8zEb
         e3UMgxsQrbXrY4H7aoWtFraYsOg7LjO/X6j3CCB3atPLFUYA+Ep01mb7+bADPeSexU0x
         fFZOleqO5jPA8MVE7qu3vIY88XX4YJabF6URwG4d3dNLkOCR4z8KfjN+w6yW1ATi4C5i
         zsYkaLyjW1C9TzppCXnv1YYxjo6zMKP3mBBqAtsNNdF1yvJYf9l95mXZ29JGFgQGdboN
         ilBjgzVksHPSfgTRVyrvmwDwS1w/03bLZQWfFJT2dDNNT4Gk2E+haDmM9QLYb7UjDLt+
         PKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690531824; x=1691136624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSyIgkTDfn7ndWDwr/HaBWKVpiJ4+BDlR0fa7JayHA4=;
        b=RLnzW8T7DJhZLPv4QbCtDFdljkji+C9YgzuQ+7FBKY/5yrMK15w4LiOGX/OSCBj3DD
         izFZZLLCYYINouVYa1SiEamaYkfDD4hT3Pd/pIBHDPakSnldxm4IJ55AzSAGUlJD3A0J
         KYWxAfysEi53Ce2aM+L6ibslfnXiE5F3+4b0pSsAhtJe3kQwB0OnjCDur/kMD/miLKrW
         K9qfvABkZh2mXFZSjnCFojYg7iIFyz1Bu50L4Nf+FE0fCTISY6mgHYUlfHQdMwHCxa++
         6hEccfXAJxuigsLjSYwyMqMGi3eFWXIHzXZQXzJG3K86iUMRs6ueCxxYo+4QAoUfXjeO
         JuAg==
X-Gm-Message-State: ABy/qLawva2Efyy7fYdqUL0gje72C6QNY34UNJJ3d7f6obbQACMV0CWD
	n7KAsVfSJ+pMa8RVQfonY8jnavPZMHg=
X-Google-Smtp-Source: APBJJlHMs0ZDetkc/TNGE5H55EeL5CKUDJCN9vkd94gydoGyMGFzhJ7HNn/XgXZ+FrgNe2GhVRN9YQ==
X-Received: by 2002:a5d:474c:0:b0:30f:b7b4:3e55 with SMTP id o12-20020a5d474c000000b0030fb7b43e55mr1109497wrs.19.1690531824123;
        Fri, 28 Jul 2023 01:10:24 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id l6-20020adfe586000000b0031416362e23sm4191734wrm.3.2023.07.28.01.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 01:10:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 28 Jul 2023 10:10:21 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Xiangyu Chen <xiangyu.chen@eng.windriver.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libbpf: fix warnings "'pad_type' 'pad_bits' 'new_off'
 may be used uninitialized"
Message-ID: <ZMN37SAvuVxa2dcc@krava>
References: <20230727082536.1974154-1-xiangyu.chen@eng.windriver.com>
 <ZMJOl5uLrK9rucXB@krava>
 <87f58a7c-2dee-9dcd-156f-edc41bfea38a@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87f58a7c-2dee-9dcd-156f-edc41bfea38a@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 11:23:21AM -0700, Yonghong Song wrote:
> 
> 
> On 7/27/23 4:01 AM, Jiri Olsa wrote:
> > On Thu, Jul 27, 2023 at 04:25:36PM +0800, Xiangyu Chen wrote:
> > > From: Xiangyu Chen <xiangyu.chen@windriver.com>
> > > 
> > > When turn on the yocto DEBUG_BUILD flag, the build options for gcc would enable maybe-uninitialized,
> > > and following warnings would be reported as below:
> > 
> > curious, what's the gcc version? I can't reproduce that,
> > and we already have all warnings enabled:
> > 
> >    CFLAGS += -Werror -Wall
> > 
> > they seem like false warnings also, because ARRAY_SIZE(pads)
> > will be always > 0
> 
> Agree. This definitely a false positive.
> In kernel top Makefile, we have
> 
> # Enabled with W=2, disabled by default as noisy
> ifdef CONFIG_CC_IS_GCC
> KBUILD_CFLAGS += -Wno-maybe-uninitialized
> endif
> 
> That means gcc -maybe-uninitialized is very noisy.

nice, I think we should do the same then ;-)
bt not sure how to do the gcc check though

jirka

> 
> > 
> > jirka
> > 
> > > 
> > > | btf_dump.c: In function 'btf_dump_emit_bit_padding':
> > > | btf_dump.c:916:4: error: 'pad_type' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> > > |   916 |    btf_dump_printf(d, "\n%s%s: %d;", pfx(lvl), pad_type,
> > > |       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > |   917 |      in_bitfield ? new_off - cur_off : 0);
> > > |       |      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > | btf_dump.c:929:6: error: 'pad_bits' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> > > |   929 |   if (bits == pad_bits) {
> > > |       |      ^
> > > | btf_dump.c:913:28: error: 'new_off' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> > > |   913 |       (new_off == next_off && roundup(cur_off, next_align * 8) != new_off) ||
> > > |       |       ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > |   HOSTLD  scripts/mod/modpost
> > > 
> > > Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> > > ---
> > >   tools/lib/bpf/btf_dump.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > > index 4d9f30bf7f01..79923c3b8777 100644
> > > --- a/tools/lib/bpf/btf_dump.c
> > > +++ b/tools/lib/bpf/btf_dump.c
> > > @@ -867,8 +867,8 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
> > >   	} pads[] = {
> > >   		{"long", d->ptr_sz * 8}, {"int", 32}, {"short", 16}, {"char", 8}
> > >   	};
> > > -	int new_off, pad_bits, bits, i;
> > > -	const char *pad_type;
> > > +	int new_off = 0, pad_bits = 0, bits, i;
> > > +	const char *pad_type = NULL;
> > >   	if (cur_off >= next_off)
> > >   		return; /* no gap */
> > > -- 
> > > 2.34.1
> > > 
> > > 
> > 

