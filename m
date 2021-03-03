Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDBE32C1B3
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449559AbhCCWwf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241168AbhCCR3q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 12:29:46 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A11C061756;
        Wed,  3 Mar 2021 09:29:05 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B41E52CD;
        Wed,  3 Mar 2021 17:25:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B41E52CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614792316; bh=stUJ13VskkGN0mdPm02DMITNl2re2BbdECPeoNTlQuY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dGirZviqdmXr1dYOksWyVIUnGlTy7Q9EP66d1x2lzljJOX6QSDiyUXGFXsRSUz3gi
         BYTJTXvzfM2h9KK6F35HbwnzkizIk2gW3FLoO/MExhy9m+5rbdR/4c5lkE3Dz5XRDN
         M5p8aDonI1ykkZVI6usnCGOTdLDuf+kCOBt3scdSg9Pdy6HhIoA0XHVlPO1M7fpj6m
         g/0RKoaFCO3y49b3kjiqDRnslxn/iUpnCgvyDVV/qVXyyD5rClGofGJIn30AQ8DSmB
         WvLFkh2pRo2ejN0ANSBvvZffq6tFMRPjeRqYGica/yNRJjCKrO92F8n7+8s77ikZZ6
         0BQkZgi2FHMVw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joe Stringer <joe@cilium.io>
Cc:     bpf@vger.kernel.org, linux-man@vger.kernel.org,
        linux-doc@vger.kernel.org, mtk.manpages@gmail.com, ast@kernel.org,
        brianvv@google.com, daniel@iogearbox.net, daniel@zonque.org,
        john.fastabend@gmail.com, ppenkov@google.com,
        quentin@isovalent.com, sean@mess.org, yhs@fb.com
Subject: Re: [PATCHv2 bpf-next 00/15] Improve BPF syscall command documentation
References: <20210302171947.2268128-1-joe@cilium.io>
Date:   Wed, 03 Mar 2021 10:25:16 -0700
In-Reply-To: <20210302171947.2268128-1-joe@cilium.io> (Joe Stringer's message
        of "Tue, 2 Mar 2021 09:19:32 -0800")
Message-ID: <87y2f4up37.fsf@meer.lwn.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joe Stringer <joe@cilium.io> writes:

> Following that, the series enhances the python scripting around parsing
> the descriptions from the header files and generating dedicated
> ReStructured Text and troff output. Finally, to expose the new text and
> reduce the likelihood of having it get out of date or break the docs
> parser, it is added to the selftests and exposed through the kernel
> documentation web pages.

You can leave me off CC, but I have eyes everywhere :)

Anyway, I like this version much better, thanks for making the
adjustments.  Feel free to stick an

Acked-by: Jonathan Corbet <corbet@lwn.net>

on it if you feel so inclined.

Thanks,

jon
