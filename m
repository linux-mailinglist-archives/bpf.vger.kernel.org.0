Return-Path: <bpf+bounces-3484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EB173EB29
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 21:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824D4280E06
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 19:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF4A13AD5;
	Mon, 26 Jun 2023 19:23:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E3134CE
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 19:23:27 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E61AE74
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 12:23:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-991aac97802so212556166b.1
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 12:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687807405; x=1690399405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKDV9EaPXzzO9137s6AMawEI5tA2ZgGj0pPYaUQ7hIo=;
        b=MO+r0V947lPTD80avba8zH6ZO0OXkROSu67Ck14jPD/2uKUL64MdfCjBsBHM09SwYg
         iJS/4lMMwCD/qdYOCFfxCXq8ka46c0q1PBIuEweqwRxdstz4uhhos79aHLJxcaw9URNl
         9z87iW2XzA4YmB8ne/wIFU0aG5MHD0+2DNEKulTYlNnfl4v/V7Gu3dk1ki1Fdv9NWR5Y
         nIeBV5Xu7pVoqaAfCHvATde7YDtbCKS2KD3zicapOUBeReD9yuRFIAuA6LzL8atRR89V
         HtJZLr3bbhskbzHuoRTcdcg0zwu3LOrZAy5TddkogI0ZOthucboNjlL4NS7m+zX43Aw/
         lC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687807405; x=1690399405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKDV9EaPXzzO9137s6AMawEI5tA2ZgGj0pPYaUQ7hIo=;
        b=X5DE6UWJw9a5/PK/XNXBXsaCPvzxD2hy5p7PrvK15uCj8TxutpfuhQjRPc6P4bqKO6
         w2jRqe2UAGjbBswac1loTc8V3hJ+TiEnTzVmEojMkXDDd16nj8eToOA4X+83t/5cJvxJ
         2N7u59HC6v7ihOctfKWDyo21PUAVZgx26DPbkJxERs7J1666Wfzp9T5iVGmGeH1aGXmj
         Z2EYKO7OLnnYLLY1wA+gtMpjb7LvBC2SXMCkde/jB0m7kUG/hOoaRul1MgN71iMkCD+s
         t3MqsP3Gfa/vIdLXwnLj0wcII8/WjP+DXSKeK5rt9cXJruCcE71SeA1z5xpzXQGi17xE
         oYEQ==
X-Gm-Message-State: AC+VfDyhfi7KMyTslDmEC/rF3ZmfQQhNeM22kADipjsP+H4gggsJR3zH
	2fxuCt7LUeI9o2WczbXB/us=
X-Google-Smtp-Source: ACHHUZ6kQb245Z4+Bttfxo7L4smbQpK3kPsTw4XJcPejlCrySpvLuipvRXot9TazTBSphmeqzqwZ0Q==
X-Received: by 2002:a17:907:96ab:b0:991:d2a8:658a with SMTP id hd43-20020a17090796ab00b00991d2a8658amr2511745ejc.34.1687807404723;
        Mon, 26 Jun 2023 12:23:24 -0700 (PDT)
Received: from krava (net-93-65-241-219.cust.vodafonedsl.it. [93.65.241.219])
        by smtp.gmail.com with ESMTPSA id k13-20020a17090646cd00b009889c4bd8absm3557987ejs.216.2023.06.26.12.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 12:23:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 26 Jun 2023 21:23:20 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 01/24] bpf: Add multi uprobe link
Message-ID: <ZJnlqOlGhztFCyah@krava>
References: <20230620083550.690426-1-jolsa@kernel.org>
 <20230620083550.690426-2-jolsa@kernel.org>
 <CAEf4BzZnn-m-5sTQEmCSyaQPNNyreE37Vu2GWtdLT=k+zR+kDA@mail.gmail.com>
 <ZJVViQEvUnMQN43b@krava>
 <CAEf4BzaQGqhO3hoGW-zvhioE=VKVpuMw5NTTvUw=sXTEoFptxA@mail.gmail.com>
 <ZJeWAiW5qxQPghGm@krava>
 <CAEf4BzYq6DJhWbVFnb2W_qWNDjObAHcd6agRdmp=OsP23A7O7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYq6DJhWbVFnb2W_qWNDjObAHcd6agRdmp=OsP23A7O7w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 11:27:25AM -0700, Andrii Nakryiko wrote:

SNIP

> > > > > bpf_link_cleanup() will do this through
> > > > > bpf_uprobe_multi_link_release(), no? So you are double unregistering?
> > > > > Either drop cnt to zero, or just don't do this here? Latter is better,
> > > > > IMO.
> > > >
> > > > bpf_link_cleanup path won't call release callback so we have to do that
> > >
> > > bpf_link_cleanup() does fput(primer->file); which eventually calls
> > > release callback, no? I'd add printk and simulate failure just to be
> > > sure
> >
> > I recall we had similar discussion for kprobe_multi link ;-)
> >
> > I'll double check that but I think bpf_link_cleanup calls just
> > dealloc callback not release
> 
> Let's document this in comments for bpf_link_cleanup() so we don't
> have to discuss this again :)
> 
> I think you are right, btw. I see that bpf_link_cleanup() sets
> link->prog to NULL, and bpf_link_free() won't call
> link->ops->release() if link->prog is NULL.
> 
> Tricky, I keep forgetting this. Let's explicitly explain this in a comment.

ok, will add the comment

jirka

> 
> >
> > jirka
> >
> > >
> > > >
> > > > I think I can add simple selftest to have this path covered
> > > >
> > > > thanks,
> > > > jirka
> >
> > SNIP

