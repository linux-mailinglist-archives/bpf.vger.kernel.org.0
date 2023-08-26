Return-Path: <bpf+bounces-8725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D65BD789318
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 03:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE29C1C2108A
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 01:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C06D397;
	Sat, 26 Aug 2023 01:32:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BBE37F;
	Sat, 26 Aug 2023 01:32:05 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3D41FC3;
	Fri, 25 Aug 2023 18:32:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c0d5b16aacso9923555ad.1;
        Fri, 25 Aug 2023 18:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693013524; x=1693618324;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxM42LCCBRiB6Q0CvcNJdV8hGhx4Rs0xMJ6jHxhjzrg=;
        b=sYJW7xLjWY3iSQhzr8tGNn0mbFOWq44QiPL8WNBrc3tgTAMqZJm/QmWQXOFpXLTNNX
         l0/XwNuAAfYHMtKhiV6J9MCY1PZMDSquBvkzcGLv24R3CxR+osYXnArjkCdmtCwouVeD
         Ytsk6CDN/0wiZrEPKv7yrXyWutC8wv95XbXO3YDV9k6dE9SWgRp/7EH3vrtefLhVb3fS
         PNUXoh+4OOj/GYUONWy527SMpc0ZMqT6TS/J1tUJUrCk4QFlaUD9njbnzhik4cngCvdZ
         L2Rnojjss/M6URZ/dY8DjGtlISYQLTx8V1CG/hsffQZI6PdMqTgArPCGHTOeVwTsv62Z
         XVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693013524; x=1693618324;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pxM42LCCBRiB6Q0CvcNJdV8hGhx4Rs0xMJ6jHxhjzrg=;
        b=BGQISMM8VjrEyxFOeWm78U3tqELXzwlONRFQu4eE6BKjrkNU1QabqAuXJeeV7fbRcQ
         SXCaAYYDMBkpCd6Xjlme2mHJta/nWfNnx74Ue7naBkfNIXSYroBEhZ66PRt66Xi1BHzX
         0EwpRa0iz9rcGFGUfjtFlILTARf5alMfi4ODKsjwm89IPSECegMx2kSd2HQR8HggrdYZ
         hz4MsHCQnYIVvEJG8jJsooavS65W0MUf7YO47WeTc/930fRHmUQHgTgO4qiFm4aq7KYk
         6PLs8jtlKHzaE655n8PLiIVeZFtNXg6T7KI9CJZzbKq/COYkskHaBtthEAGfrvgmXKOW
         Y7aQ==
X-Gm-Message-State: AOJu0YyRN6BOI41dS8oG72A/fWzf3n0QhhNGj3Tg3UX3X3nNZERnPk00
	hjKN4Mn376vqLcwSbeNANk0=
X-Google-Smtp-Source: AGHT+IGbWnWbeFo7egw/8baSDWPW+7koQyPahMck5oB7vQ9xGV8oKaOQfslcRlWBlNq8peT/0YhP7A==
X-Received: by 2002:a17:902:ec83:b0:1c0:d17a:bfe9 with SMTP id x3-20020a170902ec8300b001c0d17abfe9mr6083550plg.46.1693013523877;
        Fri, 25 Aug 2023 18:32:03 -0700 (PDT)
Received: from localhost ([98.97.117.85])
        by smtp.gmail.com with ESMTPSA id x19-20020a170902821300b001bbf7fd354csm2416186pln.213.2023.08.25.18.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 18:32:03 -0700 (PDT)
Date: Fri, 25 Aug 2023 18:32:01 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 Liu Jian <liujian56@huawei.com>
Cc: john.fastabend@gmail.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 kpsingh@kernel.org, 
 sdf@google.com, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <64e95611f1b33_1d0032088c@john.notmuch>
In-Reply-To: <87r0nr5j0a.fsf@cloudflare.com>
References: <20230824143959.1134019-1-liujian56@huawei.com>
 <20230824143959.1134019-2-liujian56@huawei.com>
 <87r0nr5j0a.fsf@cloudflare.com>
Subject: Re: [PATCH bpf-next v3 1/7] bpf, sockmap: add BPF_F_PERMANENT flag
 for skmsg redirect
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Sitnicki wrote:
> On Thu, Aug 24, 2023 at 10:39 PM +08, Liu Jian wrote:
> > If the sockmap msg redirection function is used only to forward packets
> > and no other operation, the execution result of the BPF_SK_MSG_VERDICT
> > program is the same each time. In this case, the BPF program only needs to
> > be run once. Add BPF_F_PERMANENT flag to bpf_msg_redirect_map() and
> > bpf_msg_redirect_hash() to implement this ability.
> >
> > Then we can enable this function in the bpf program as follows:
> > bpf_msg_redirect_hash(xx, xx, xx, BPF_F_INGRESS | BPF_F_PERMANENT);
> >
> > Test results using netperf  TCP_STREAM mode:
> > for i in 1 64 128 512 1k 2k 32k 64k 100k 500k 1m;then
> > netperf -T 1,2 -t TCP_STREAM -H 127.0.0.1 -l 20 -- -m $i -s 100m,100m -S 100m,100m
> > done
> >
> > before:
> > 3.84 246.52 496.89 1885.03 3415.29 6375.03 40749.09 48764.40 51611.34 55678.26 55992.78
> > after:
> > 4.43 279.20 555.82 2080.79 3870.70 7105.44 41836.41 49709.75 51861.56 55211.00 54566.85
> >
> > Signed-off-by: Liu Jian <liujian56@huawei.com>

[...]

> >  /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > index a29508e1ff35..df1443cf5fbd 100644
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
> > @@ -885,6 +885,11 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
> >  			goto out;
> >  		}
> >  		psock->redir_ingress = sk_msg_to_ingress(msg);
> > +		if (!msg->apply_bytes && !msg->cork_bytes)
> > +			psock->redir_permanent =
> > +				msg->flags & BPF_F_PERMANENT;
> > +		else
> > +			psock->redir_permanent = false;
> 
> Above can be rewritten as:
> 
> 		psock->redir_permanent = !msg->apply_bytes &&
> 					 !msg->cork_bytes &&
> 					 (msg->flags & BPF_F_PERMANENT);
> 
> But as I wrote earlier, I don't think it's a good idea to ignore the
> flag. We can detect this conflict at the time the bpf_msg_sk_redirect_*
> helper is called and return an error.
> 
> Naturally that means that that bpf_msg_{cork,apply}_bytes helpers need
> to be adjusted to return an error if BPF_F_PERMANENT has been set.

So far we've not really done much to protect a user from doing
rather silly things. The following will all do something without
errors,

  bpf_msg_apply_bytes()
  bpf_msg_apply_bytes() <- reset apply bytes

  bpf_msg_cork_bytes()
  bpf_msg_cork_bytes() <- resets cork byte

also,

  bpf_msg_redirect(..., BPF_F_INGRESS);
  bpf_msg_redirect(..., 0); <- resets sk_redir and flags

maybe there is some valid reason to even do above if further parsing
identifies some reason to redirect to a alert socket or something.

My original thinking was in the interest of not having a bunch of
extra checks for performance reasons we shouldn't add guard rails
unless something really unexpected might happen like a kernel
panic or what not.

This does feel a bit different though because before we
didn't have calls that could impact other calls. My best idea
is to just create a precedence and follow it. I would propose,

'If BPF_F_PERMANENT is set apply_bytes and cork_bytes are
 ignored.'

The other direction (what is above?) has a bit of an inconsistency
where these two flows are different?

  bpf_apply_bytes()
  bpf_msg_redirect(..., BPF_F_PERMANENT)

and

  bpf_msg_redirect(..., BPF_F_PERMANENT)
  bpf_apply_bytes()

It would be best if order of operations doesn't change the
outcome because that starts to get really hard to reason about.

This avoids having to add checks all over the place and then
if users want we could give some mechanisms to read apply
and cork bytes so people could write macros over those if
they really want the hard error.

WDYT?

[...]

Thanks!

