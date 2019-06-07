Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75F0D38213
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2019 02:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfFGAXR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 20:23:17 -0400
Received: from hermes.domdv.de ([193.102.202.1]:3912 "EHLO hermes.domdv.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbfFGAXQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 20:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=domdv.de;
         s=dk3; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=t/CvURF1J8FjGfutT+vOH29IsXY8PPAy08YxlKcW2sI=; b=LESZEO1CZs6FpQ8nXMCtvTHM3b
        Z9mZMOo9VjdMekzbJV2CASgUhdB9K5lnbS1j0No/UJz039Y6x7/trKAwg4f0vw4e4kwVJ5PfDytp4
        qdB/WxgBLHNO7ldA7ZA2+PT0BrDJE/UEMEEKQV5kz+3X51QDI/ZWMH7vMr/axNjH5hfU=;
Received: from [fd06:8443:81a1:74b0::212] (port=3802 helo=castor.lan.domdv.de)
        by zeus.domdv.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <ast@domdv.de>)
        id 1hZ2f4-0002Pq-HH; Fri, 07 Jun 2019 02:23:14 +0200
Received: from woody.lan.domdv.de ([10.1.9.28] helo=host028-server-9.lan.domdv.de)
        by castor.lan.domdv.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <ast@domdv.de>)
        id 1hZ2eN-0000OZ-UY; Fri, 07 Jun 2019 02:22:31 +0200
Message-ID: <e9f7226d1066cb0e86b60ad3d84cf7908f12a1cc.camel@domdv.de>
Subject: Re: eBPF verifier slowness, more than 2 cpu seconds for about 600
 instructions
From:   Andreas Steinmetz <ast@domdv.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Date:   Fri, 07 Jun 2019 02:22:47 +0200
In-Reply-To: <CAADnVQLmrF579H6-TAdMK8wDM9eUz2rP3F6LmhkSW4yuVKJnPg@mail.gmail.com>
References: <f0179a5f61ecd32efcea10ae05eb6aa3a151f791.camel@domdv.de>
         <CAADnVQLmrF579H6-TAdMK8wDM9eUz2rP3F6LmhkSW4yuVKJnPg@mail.gmail.com>
Organization: D.O.M. Datenverarbeitung GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 2019-06-01 at 22:03 -0700, Alexei Starovoitov wrote:
> On Fri, May 31, 2019 at 3:55 PM Andreas Steinmetz <ast@domdv.de> wrote:
> > I do have a working eBPF program (handcrafted assembler) that has about
> > 600 instructions. This programs takes more than 2 CPU seconds to load.
> > 
> > In short, the eBPF program selects and redirects packets, does MSS
> > clamping and sends ICMPs where required for IPv4 and IPv6. The eBPF
> > program is part of a project that will be GPLed when sufficiently
> > ready.
> > 
> > I am willing to cobble something testable together and post it
> > (attachment only) or send it directly, if somebody on this list is
> > willing to investigate, why the verifier is having lots of CPU for
> > breakfast.
> 
> Please post it to the bpf mailing list if it's reproducible on the
> latest kernel.

Will do, probably over the weekend - I have to do this as an attached tgz,
though.

Regards,
Andreas

