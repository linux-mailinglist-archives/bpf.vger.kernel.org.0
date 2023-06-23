Return-Path: <bpf+bounces-3301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDCA73BDC9
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 19:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262EE281C9A
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25574100D7;
	Fri, 23 Jun 2023 17:29:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED816100B8
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 17:29:10 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EC21993
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:29:09 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7C882C169512
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1687541349; bh=AEkLB33sOYj7UwGunIEVp3IIDnE7rTkbiKavVrDic2o=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=kYK+GDR7q4gfHMSwhFa+qfoh0Mahv10n6uqsxYkkYmV9tGCaAJ0pV/yGLXl2azlvI
	 uNhaAmoLgB66dc0Ja1BBOCFpQQGVVWH+tWdwc1QmoMuYzm2xGg7qjOqtms9z0yq4wI
	 wdbBBtV9WJJthrq5PYm1fCGYNfF/UhvM7b1MmjGY=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jun 23 10:29:09 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 485A0C13AE40;
	Fri, 23 Jun 2023 10:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1687541349; bh=AEkLB33sOYj7UwGunIEVp3IIDnE7rTkbiKavVrDic2o=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=kYK+GDR7q4gfHMSwhFa+qfoh0Mahv10n6uqsxYkkYmV9tGCaAJ0pV/yGLXl2azlvI
	 uNhaAmoLgB66dc0Ja1BBOCFpQQGVVWH+tWdwc1QmoMuYzm2xGg7qjOqtms9z0yq4wI
	 wdbBBtV9WJJthrq5PYm1fCGYNfF/UhvM7b1MmjGY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 4B493C13AE40
 for <bpf@ietfa.amsl.com>; Fri, 23 Jun 2023 10:29:08 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.55
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p1DvI7eG-Aan for <bpf@ietfa.amsl.com>;
 Fri, 23 Jun 2023 10:29:07 -0700 (PDT)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id A00C1C1516E1
 for <bpf@ietf.org>; Fri, 23 Jun 2023 10:29:07 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-763e1a22a68so77586885a.0
 for <bpf@ietf.org>; Fri, 23 Jun 2023 10:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687541346; x=1690133346;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M3JcekgH5UueNtQ04NsuTURZ3aF3QjcmVWOdkwFLDic=;
 b=jBNDeCjRTcsnig3xRcwZ2cJUg1lH/r/I+Wtmf6LsHHCu/0/Ne4kSJvhcLOrzLp2zSX
 RmmN3sw247e/YY78ubuBvpcVb+2bVdiZRLxeO4U9UZaYsRMOVay5XZ8f5fvBIzGvnBnY
 wa+Rtam2mDpj7rirJ42IAsICnXa3cZEzOpZ8BdjUP0LyPS1Rmio7ktsXYBkENhlxgdF+
 /5lVRDDUCokxcFz6XrlkBzlUbTfmib3dsSXPmHhMH9qnAeS0sU3xWWQb6zrkSHfAM8KN
 Djr3eO6NwgtDOPqNfNKWrKJIf24KYzGh3Imj027PbwKDYBACu01Ayqs74/6ZolLMfTWx
 55yg==
X-Gm-Message-State: AC+VfDx8aW2NeqeWrM5BHuOcOM8Kh7m2k6QZb1OA0jAcz2jcIfexftwM
 72lVKNqv7pkwEEUpvJa5JTa6YL0bLp3knA==
X-Google-Smtp-Source: ACHHUZ70629Sm6QvzJNyHCnj7sXsSWIhlXFihLeVNb2iGVCY22kIWoSFKiWteTSUmdQGvoCgXPqMMg==
X-Received: by 2002:a05:620a:3e0c:b0:763:df67:5c11 with SMTP id
 tt12-20020a05620a3e0c00b00763df675c11mr6854308qkn.65.1687541346514; 
 Fri, 23 Jun 2023 10:29:06 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:d965])
 by smtp.gmail.com with ESMTPSA id
 c24-20020a05620a11b800b00763b7b8f3c4sm600062qkk.98.2023.06.23.10.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 10:29:06 -0700 (PDT)
Date: Fri, 23 Jun 2023 12:29:04 -0500
From: David Vernet <void@manifault.com>
To: Suresh Krishnan <suresh.krishnan@gmail.com>
Cc: bpf@ietf.org, Erik Kline <ek.ietf@gmail.com>, bpf@vger.kernel.org
Message-ID: <20230623172904.GC116849@maniforge>
References: <5ECFE30A-D708-4F99-9321-CF1FE787D1B8@gmail.com>
 <20230623172513.GB116849@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230623172513.GB116849@maniforge>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/bWr64Uuta-9vukoW7eA9iL6OKsE>
Subject: Re: [Bpf] Call for agenda items
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

