Return-Path: <bpf+bounces-8940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487FD78CF7E
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 00:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE0E1C20A64
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 22:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCBC182DF;
	Tue, 29 Aug 2023 22:24:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F36F182D4
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 22:24:22 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6F01A4
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 15:24:21 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68bed286169so4229825b3a.1
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 15:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1693347860; x=1693952660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+YYrVRvFGP8cHlPGoJT9wVJUhY8GN/rwR0tzqEGpip4=;
        b=HGN6wzE0Z+22ftS0x+nuWnCprmDpb/v0SZ86HyOgWputm+heKUXR2mnqzErStq72tE
         c4zpJAZLjtl3kqpneEua/+I1WrnSnldvcrdEQdT7A5hy/DT7Q29PJg5ZsJoNRAT7q9t5
         0pNXHfsoylRRBs84O2jg2jQ44b0YU6QiALeVPzBfC77m+1icx0TiWZM2135zoO1fYz30
         Gm9oV5xtAaqTC6GGk81p9SW1a+4NDotdsld40wB+14KpNtaDa2zplFhdZqkhACTXNKdX
         846zMFSDYPBeCRHYzXhz0Q3MFtvLKbd7Qz/i6wN3kFU3FU+6W9fVtld63qMKc3qTQ68j
         7KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693347860; x=1693952660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YYrVRvFGP8cHlPGoJT9wVJUhY8GN/rwR0tzqEGpip4=;
        b=LT2SBI/aU1WC/lvZBGruzl91LgULALipPCarZznaXpzCtOgLpAFDQPVRCg6lJKBq5d
         DWkHQ5706G3jvc+pnkhW7oDZ+bu+mmxTPTXFtCucc+bNn4J+4+quPPFg7VxySrDv6oRE
         8JxEh0Xs1rR8IanwH1qVVlvvfG3QzYHlkG1qrlcaXQhSvz5xJX5UDKjM48SYlqZD40lh
         x/N5eXJUfqkexzp5puPxuT24vyIR2ID538Aue7VxbOUYQ3ACt3yGf5n7NtqvIRFxNuop
         yGZqPNS08WcPxKmprmwtgSLe2BrG+ogLCLFnqlzTuPUzT2FeNLpE8ysfF8Q01rfatP4N
         7h+w==
X-Gm-Message-State: AOJu0Yw3B2x+e79SVx2YRoMFBhSk2qmBnEGWoS7zJRe5QolSIoMDoknU
	7GEF9gBQ5enKrjafPy/iywgS2g==
X-Google-Smtp-Source: AGHT+IFPNsEXPkaJPGMeeiEFHipjnGseCng4DOTgYsmDDTAwZXJBdp93d1gYNXCJe3ucMHjD39GcnA==
X-Received: by 2002:a05:6a20:9746:b0:148:656b:9a1f with SMTP id hs6-20020a056a20974600b00148656b9a1fmr654936pzc.20.1693347860454;
        Tue, 29 Aug 2023 15:24:20 -0700 (PDT)
Received: from medusa.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id v12-20020a170902b7cc00b001993a1fce7bsm9798784plz.196.2023.08.29.15.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 15:24:20 -0700 (PDT)
Date: Tue, 29 Aug 2023 15:24:18 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Eric Dumazet <edumazet@google.com>
Cc: willemjdebruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	David Howells <dhowells@redhat.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:BPF [MISC]" <bpf@vger.kernel.org>
Subject: Re: [PATCH] skbuff: skb_segment, Update nfrags after calling zero
 copy functions
Message-ID: <20230829222418.GB1473980@medusa>
References: <20230828233210.36532-1-mkhalfella@purestorage.com>
 <64ed7188a2745_9cf208e1@penguin.notmuch>
 <20230829065010.GO4091703@medusa>
 <CANn89iLbNF_kGG9S3R9Y8gpoEM71Wesoi1mTA3-at4Furc+0Fg@mail.gmail.com>
 <20230829093105.GA611013@medusa>
 <CANn89iLzOFikw2A8HJJ0zvg1Znw+EnOH2Tm2ghrURkE7NXvQSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLzOFikw2A8HJJ0zvg1Znw+EnOH2Tm2ghrURkE7NXvQSg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-29 12:09:15 +0200, Eric Dumazet wrote:
> Another way to test this path for certain (without tcpdump having to race)
> is to add a temporary/debug patch like this one:
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a298992060e6efdecb87c7ffc8290eafe330583f..20cc42be5e81cdca567515f2a886af4ada0fbe0a
> 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1749,7 +1749,8 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
>         int i, order, psize, new_frags;
>         u32 d_off;
> 
> -       if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
> +       if (skb_shared(skb) ||
> +           pskb_expand_head(skb, 0, 0, gfp_mask))
>                 return -EINVAL;
> 
>         if (!num_frags)
> 
> Note that this might catch other bugs :/

I was not able to make it allocate a new frags by running tcpdump while
reproing the problem. However, I was able to do it with your patch.

