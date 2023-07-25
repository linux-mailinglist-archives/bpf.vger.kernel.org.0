Return-Path: <bpf+bounces-5884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7A8762704
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 00:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABDF1C2103D
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 22:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E877926B19;
	Tue, 25 Jul 2023 22:47:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A168462
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 22:47:10 +0000 (UTC)
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC676E8F
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 15:46:46 -0700 (PDT)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-57059f90cc5so75715327b3.0
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 15:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690324824; x=1690929624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NiMTN0rMxISrPavJuhLij0ZZFeIfou/gU+GcauPEaWc=;
        b=l+F6L4Y2jK0wqpPmXgxnATvxDjh9nYNbwPKvjTlG1sF+oQUZXxXA3StckaHdexEtLt
         9bMPDGL+JExkZXt4kGyPq9ukhflar5vApaRy2PbDkAw/XQ/J4DUh5AY1KfWg3dLMk28c
         SRuA1yKnEohEZMH3ngQygTNW/R747mupfIkIxSjaOhOPkhrYYV7OeO6Nlp1wo46o/I6z
         UOVRo9YjoB2Fuwpo0Xds91ANzgXdSuUNMFVxftcW5tX0Ok2cnGKJFzIYp+zCdW1EkVOM
         cLX2THwSoLbFzKluchTcEwvcew5kH9PzW49NYeixr0WzPA9sR3dlmccE5FAZWS73y9NB
         3f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690324824; x=1690929624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NiMTN0rMxISrPavJuhLij0ZZFeIfou/gU+GcauPEaWc=;
        b=i7xTze0JXHHkApqUNNe9NZV6L3oDyOCRK+A9nw7o2uzogd8lCNXde3XJjuTuKB5K94
         gFzyTy0UqYYHbL5KKBLBEFrFktdLLtQcVFQgDCv4hhrbombIhh4KTDp+6BGzoPr0VLM3
         jeMkjSqiGBaPb5E8/uZaS93O0EmIky17kGViNopwzmYNTYxyTqesumz2JKNa5WzliwBQ
         t+hGMNvftokUGX/TRzqEC/Aq6BRW/QHkESc0H97v1fLQyJ5SvYHvqKorWIIxYXT/Ma6z
         rAGplpE/w+87t0hUHkBoXhdGlJQjb1iq3DLHAJyoFtjNvYpflszif5rs33/z7KGviZ6B
         DsPQ==
X-Gm-Message-State: ABy/qLaeroxM4GpSjab/IDvz2D3mQpcNuSVugV+WMGoSuyfTqq5g5MFI
	wEv0YRvdI/W5pouhhXpkUPIlj8Q=
X-Google-Smtp-Source: APBJJlG73PW2XF1DZfFfJbP9BuKp+qu3Y09U3Xnul7jVcOuNxW9ZWzIO+z21TOakhR1JRQG+dwcSi88=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:ae4e:0:b0:583:3609:50d2 with SMTP id
 g14-20020a81ae4e000000b00583360950d2mr4664ywk.8.1690324824202; Tue, 25 Jul
 2023 15:40:24 -0700 (PDT)
Date: Tue, 25 Jul 2023 15:40:22 -0700
In-Reply-To: <20230725142811.07f4faa2@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724235957.1953861-1-sdf@google.com> <20230724235957.1953861-3-sdf@google.com>
 <ZMAiYibjYzVTBjEF@corigine.com> <ZMAxAmg187DgPCAr@google.com> <20230725142811.07f4faa2@kernel.org>
Message-ID: <ZMBPVqyUb9N8OEWL@google.com>
Subject: Re: [RFC net-next v4 2/8] xsk: add TX timestamp and TX checksum
 offload support
From: Stanislav Fomichev <sdf@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <simon.horman@corigine.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, hawk@kernel.org, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/25, Jakub Kicinski wrote:
> On Tue, 25 Jul 2023 13:30:58 -0700 Stanislav Fomichev wrote:
> > > I know that it isn't the practice in this file.
> > > but adding the following makes kernel-doc happier
> > > about NETDEV_XSK_FLAGS_MASK not being documented.
> > > 
> > > 	/* private: */  
> > 
> > This is autogenerated file :-( But I guess I can try to extend ynl
> > scripts to put this comment before the mask. Let me look into that...
> 
> Yes, please! I think I even wrote a patch for it at some point...
> but then we realized that enums didn't support /* private: */.
> Commit e27cb89a22ada4 has added the support, so we can get back
> to getting the YNL changes in place.

Let me actually route these separately to you. I'll fix mxdp_zc_max_seg
thing as well..

