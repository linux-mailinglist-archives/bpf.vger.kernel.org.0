Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D393A4B0E
	for <lists+bpf@lfdr.de>; Sat, 12 Jun 2021 01:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFKXIw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 19:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhFKXIv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 19:08:51 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330A6C061574;
        Fri, 11 Jun 2021 16:06:52 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 9EA4EC025; Sat, 12 Jun 2021 01:06:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1623452809; bh=xMk/mRnt+0x6uvbOOBrPm78VeRQG1jWN2+kTnIFkaA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ccOHO2qgJ0m56nZzgLr/x63jOtSMUmb/9QtJv6kfWKJTQGoP8EBjcJuBlHLXfQ77o
         z30w12i9GjZ57Q4PrBy+V/+i0ayiy2Nduy6WIkdv08p5p6LcnCVHiW+MshXZyDE2ws
         XbKeb5w6mq2SJXZ8lfIgy/dNvLPYHgEUHZPIeJVeX4hJ1LK1dJvlk1Vv+OeO1OnyYo
         ggT5m9IfWuNI+W9IuxDo5HG1rXqvdssgNFnHocSNMWyrkaUDmqJk+kWXcKz/GZfy/U
         J+HugX+JWLEwf103UHgV+IxB2fJw10SvAoeJcAiQMN6m1ktzpIETHbZ1pJwr+i5dX0
         2ErwJgAsUCs1g==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 6BA51C01F;
        Sat, 12 Jun 2021 01:06:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1623452809; bh=xMk/mRnt+0x6uvbOOBrPm78VeRQG1jWN2+kTnIFkaA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ccOHO2qgJ0m56nZzgLr/x63jOtSMUmb/9QtJv6kfWKJTQGoP8EBjcJuBlHLXfQ77o
         z30w12i9GjZ57Q4PrBy+V/+i0ayiy2Nduy6WIkdv08p5p6LcnCVHiW+MshXZyDE2ws
         XbKeb5w6mq2SJXZ8lfIgy/dNvLPYHgEUHZPIeJVeX4hJ1LK1dJvlk1Vv+OeO1OnyYo
         ggT5m9IfWuNI+W9IuxDo5HG1rXqvdssgNFnHocSNMWyrkaUDmqJk+kWXcKz/GZfy/U
         J+HugX+JWLEwf103UHgV+IxB2fJw10SvAoeJcAiQMN6m1ktzpIETHbZ1pJwr+i5dX0
         2ErwJgAsUCs1g==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 149329d1;
        Fri, 11 Jun 2021 23:06:43 +0000 (UTC)
Date:   Sat, 12 Jun 2021 08:06:28 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Deepak Kumar Mishra <deepakkumar.mishra@arm.com>,
        dwarves@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, siudin@fb.com,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] CMakeLists.txt: enable SHARED and STATIC lib
 creation
Message-ID: <YMPsdB9LZATwmn4m@codewreck.org>
References: <cover.1623091959.git.deepakkumar.mishra@arm.com>
 <70cb7cb534af9850dc5fe3c4b9f4366ce7dc6316.1623091959.git.deepakkumar.mishra@arm.com>
 <YMJMdQvCWHd5J0M1@kernel.org>
 <CAEf4BzZEmLbKtUMkbV4+3rDFrSwP9Eu-tO_GvYRgRvdsQqrWTQ@mail.gmail.com>
 <YMPA1T0Cuo7xw/Sp@kernel.org>
 <CAEf4BzYwf0fO5Y9pVKPg3TOwMcq-HneG-BGU8M+oAjMyhXBwQA@mail.gmail.com>
 <9b4bcb2372f00c9ffa1b3d5d30a84755d8a3896c.camel@debian.org>
 <49ebd74aac20b3896996c3b1fdcc14e35c7a05ec.camel@debian.org>
 <8471df5c1e5aa52bedb032b2fcb3b6ce7722de6b.camel@debian.org>
 <YMPpfzNCSE8DxvOA@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMPpfzNCSE8DxvOA@codewreck.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dominique Martinet wrote on Sat, Jun 12, 2021 at 07:53:51AM +0900:
> changing btf_loader.c to include bpf/btf.h instead fixes the issue for me:

Sorry that was a bit quick on my part, it's not the proper solution if
there are worse conflicts and I'm actually not sure why that worked...
It still includes the wrong btf.h -- Luca's patch is much better

/me goes back to bed
-- 
Dominique
