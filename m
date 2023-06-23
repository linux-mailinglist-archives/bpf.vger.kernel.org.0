Return-Path: <bpf+bounces-3300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AA473BDC8
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 19:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4896281C65
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 17:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA15100D1;
	Fri, 23 Jun 2023 17:29:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC0B100B8
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 17:29:08 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3651993
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:29:07 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7624e8ceef7so76564585a.2
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687541346; x=1690133346;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3JcekgH5UueNtQ04NsuTURZ3aF3QjcmVWOdkwFLDic=;
        b=LZWEHmdwu5njScq9gBT8jLZ8XVHJGkjFOhK2a00Nh7e4obCx35ZiJNzdgxF2xXLYRM
         yfx+51K3wGzSKmrXNbnwGlvTpWnWnr0mpUcjoKRecc6zmfE8emDIWWDIv1Bl2My8MHrQ
         P4DV0qwLEOuUc+zWzLl7fBtvJiLyPuNV9h4EMY/VTZZrbCCHbkjflwugctyeDrbjNwo9
         grq/J5HUa/Kku+9AL8z1Ec5WH9ryz57yOgC/RvCa8kj2v1TWGDbcHtQcdYBJAO6yNV+y
         CopElpPjd4ez6TQMUiabJIuc9rQx7oUK9RK2seNILbvfwcLqjqcxnd4IbXes99M4OIUz
         LRJA==
X-Gm-Message-State: AC+VfDwh3rDcVLnqOWBDXvNABMaMpK62EpkpADrp2fAtB4KAZPPw4bJF
	W52A3lJhofhiCtYYgmQx7k4=
X-Google-Smtp-Source: ACHHUZ70629Sm6QvzJNyHCnj7sXsSWIhlXFihLeVNb2iGVCY22kIWoSFKiWteTSUmdQGvoCgXPqMMg==
X-Received: by 2002:a05:620a:3e0c:b0:763:df67:5c11 with SMTP id tt12-20020a05620a3e0c00b00763df675c11mr6854308qkn.65.1687541346514;
        Fri, 23 Jun 2023 10:29:06 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:d965])
        by smtp.gmail.com with ESMTPSA id c24-20020a05620a11b800b00763b7b8f3c4sm600062qkk.98.2023.06.23.10.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 10:29:06 -0700 (PDT)
Date: Fri, 23 Jun 2023 12:29:04 -0500
From: David Vernet <void@manifault.com>
To: Suresh Krishnan <suresh.krishnan@gmail.com>
Cc: bpf@ietf.org, Erik Kline <ek.ietf@gmail.com>, bpf@vger.kernel.org
Subject: Re: Call for agenda items
Message-ID: <20230623172904.GC116849@maniforge>
References: <5ECFE30A-D708-4F99-9321-CF1FE787D1B8@gmail.com>
 <20230623172513.GB116849@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623172513.GB116849@maniforge>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 12:25:13PM -0500, David Vernet wrote:
> On Thu, Jun 22, 2023 at 09:01:07AM -0400, Suresh Krishnan wrote:
> > Hi all, 
> >  The newly formed bpf WG will be holding a meeting at IETF117 in a two
> >  hour slot. The chairs are in the process of setting the agenda. We
> >  would like to solicit agenda items that would be of interest to the
> >  WG participants with a preference to the items that address the
> >  topics of interest covered by the charter . Please send us your
> >  request for slots to bpf-chairs@ietf.org
> >  <mailto:shmoo-chairs@ietf.org> detailing
> > 
> > * Topic and presenter info
> > * Name of associated draft (if any)
> > * Requested slot duration.
> 
> Hi everyone,
> 
> Adding the bpf@vger list to this thread as well.

My sincere apologies - I forgot to actually include the bpf@vger list
despite that being the (intended) point of my last email.  Email copied
again below for convenience.

>  The newly formed bpf WG will be holding a meeting at IETF117 in a two
>  hour slot. The chairs are in the process of setting the agenda. We
>  would like to solicit agenda items that would be of interest to the
>  WG participants with a preference to the items that address the
>  topics of interest covered by the charter . Please send us your
>  request for slots to bpf-chairs@ietf.org
>  <mailto:shmoo-chairs@ietf.org> detailing
>
> * Topic and presenter info
> * Name of associated draft (if any)
> * Requested slot duration.

Hi everyone,

As mentioned above, the newly-formed BPF working group will be holding a
meeting at IETF117 in a two hour slot, and we are in the process of
soliciting agenda items that would be of interest to the WG
parcitipants. If there are any agenda items that you would like to
discuss, please send us your request for slots to bpf-chairs@ietf.org
detailing:

* Topic and presenter info
* Name of associated draft (if any)
* Requested slot duration.

Please note that while any agenda item may be requested and discussed,
there is a preference for agenda items that address topics of interest
covered by the working group charter [0].

[0]: https://datatracker.ietf.org/doc/charter-ietf-bpf/

Thanks,
Suresh and David

