Return-Path: <bpf+bounces-13044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4E27D3D90
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 19:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B231C20A48
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 17:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8252A20B38;
	Mon, 23 Oct 2023 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="La4P4/iv"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FFA14A91
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:27:33 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9541A2
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 10:27:32 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c9d4e38f79so24864075ad.2
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 10:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698082052; x=1698686852; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3x8IWIHro6S9iAiivi1t4u4+ws/ekOvXOMLmQjoGqFc=;
        b=La4P4/ivZkYzIjME+1oVKgWoVGOTjaoGXgTDFj48gOY3O/Pps+1NdY8I+3Dz0w2TPy
         acmtnK8f2FKBk+WKgTOBjjZuZVGkvaxHDqpOrMcSW8710tKADG3zZT+DzI8iQ1xCNOMo
         kh9JgZOg96Qm6072YPrBtvXNI6PWonrB8N1sg1Rcm9QXG6yUt7m2aH6COaqg2CRzJ7hl
         owJFLDR5o5iXjEpMuMIFZj+3ejFgrWXcQV668obsFwYlE9mVObkwgf+Q/htAjl5S5vq2
         fRrWRyfCLvEXG+H8x95hvyzqcfFEiPfvvbJ0Hl3YlhhTWqI52eioUZxXJtXnIDWkKrwp
         Rnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082052; x=1698686852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3x8IWIHro6S9iAiivi1t4u4+ws/ekOvXOMLmQjoGqFc=;
        b=Ww7j8X2zfq8mOrb2pF3soFRI1Qi4u8L9SNMEY6jkx3czWXArn1rDI6CzlmZKwp+U48
         2ZMJ71stpHWrGAgzzsgzDtGpFFks3Js1Dp49lmNeG9AAxhqGrXTEHexe4MAm6g/NLVSl
         72D7xX86aWF+vGcamy1sQjhvojXwU40+8SLsaZJbEypzIxhCU1hsYJb3NCyxOdOZBnKP
         AQ4tvmmVFHzvs2TuDm7yMWMobIrbHSM8d1yoGQbd0TGCB9c5ubRFxy6AGZzYpmmGwVtn
         tIr4v84rD7YOEYC8Fm/+5oSvkQLa0nUfzzee8iDrV55fApovV99scJnhtAFbNbO8tx8o
         NbIA==
X-Gm-Message-State: AOJu0YySlXomhITlnwPof4JeqsEPunbw/SeD0wk6QpKVHemefqrZQC3q
	0t5NXJuUGMYoQNcjGmKLEZraUd8=
X-Google-Smtp-Source: AGHT+IHtHb2TP4Bg/q0ofYthEqbM7EIFTc9eSERbDcHP6IVJIP3T1WRVi+WZBJOXifgu6e7wWDmbqyY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:c942:b0:1c9:bdc5:c34d with SMTP id
 i2-20020a170902c94200b001c9bdc5c34dmr220149pla.11.1698082052176; Mon, 23 Oct
 2023 10:27:32 -0700 (PDT)
Date: Mon, 23 Oct 2023 10:27:30 -0700
In-Reply-To: <20231020180631.0f7eaebb@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com> <20231019174944.3376335-4-sdf@google.com>
 <20231020180631.0f7eaebb@kernel.org>
Message-ID: <ZTatAlRkP4htsLUS@google.com>
Subject: Re: [PATCH bpf-next v4 03/11] tools: ynl: Print xsk-features from the sample
From: Stanislav Fomichev <sdf@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"

On 10/20, Jakub Kicinski wrote:
> On Thu, 19 Oct 2023 10:49:36 -0700 Stanislav Fomichev wrote:
> > Regenerate the userspace specs and print xsk-features bitmask.
> 
> I'm afraid you regenerated in previous patch already :]
> Perhaps we should add an easy-to-use flag to ynl-regen to skip tools/ ?

Oops, leftover :-(

I do find it useful that we now regenerate everything, so not sure the
flag is needed (I'm probably missing the intent). I hope we eventually can
drop those generated files altogether from the tree and generate everything
during the build.

> > diff --git a/tools/net/ynl/samples/netdev.c b/tools/net/ynl/samples/netdev.c
> > index b828225daad0..da7c2848f773 100644
> > --- a/tools/net/ynl/samples/netdev.c
> > +++ b/tools/net/ynl/samples/netdev.c
> > @@ -44,6 +44,12 @@ static void netdev_print_device(struct netdev_dev_get_rsp *d, unsigned int op)
> >  			printf(" %s", netdev_xdp_rx_metadata_str(1 << i));
> >  	}
> >  
> > +	printf(" xsk-features (%llx):", d->xsk_features);
> > +	for (int i = 0; d->xsk_features > 1U << i; i++) {
> 
> Shouldn't this be >= ?

Oh, good catch, will fix the other ones as well. But this is subtle and
still mostly works during my tests.

For bits 1 and 2 we get 3 and 'd->xsk_features > 1U << i' is always
true for both 1 and 2.

