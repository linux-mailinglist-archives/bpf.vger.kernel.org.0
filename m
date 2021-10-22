Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C931E4373B4
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 10:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhJVIgH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 04:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhJVIgH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 04:36:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A17AC061764;
        Fri, 22 Oct 2021 01:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BKRfgbYmOOsvcoj4JpPtR+W/t5uf0jYICwx+zjBD2hE=; b=DU/nbmq7hazCDHsgFDmXyJN5vh
        f0q9gcfoxsf+74dSRH/Ur/1n0ZhjWIwdrkdDKsDblEvlRMdhhOLoP2P0/El+YBCCUFgxAJDUe+Y9k
        YN5/0qXEBgZovDnjRoaI4eTMKL8RtdLvQxQW7sERw/9UgRjkcDIsaHNaW9TqwRpecVrCvOnBQayYL
        ZBMsgXfbmnhqky9GnESCz6UbhePos0uMFKib8DEUhY8AJgv2e/d3D+xY3JVwe3JG5e92sfXrKPsLb
        PNoy2My0cRp9QBUYLPTDVeomw2Xo5Bq2CvY6j3fXUhtS9ThsYaGDJ2+yTfv+PfbsqhDVnk/EIXUyT
        xlL3jGyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdpzW-00BXp0-JD; Fri, 22 Oct 2021 08:33:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B02433002BC;
        Fri, 22 Oct 2021 10:33:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 967D42CCDF6C8; Fri, 22 Oct 2021 10:33:28 +0200 (CEST)
Date:   Fri, 22 Oct 2021 10:33:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zvi Effron <zeffron@riotgames.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, x86@kernel.org,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <YXJ3WPu1AxHd1cLq@hirez.programming.kicks-ass.net>
References: <20211020104442.021802560@infradead.org>
 <20211020105843.345016338@infradead.org>
 <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net>
 <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
 <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net>
 <CAC1LvL33KYZUJTr1HZZM_owhH=Mvwo9gBEEmFgdpZFEwkUiVKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC1LvL33KYZUJTr1HZZM_owhH=Mvwo9gBEEmFgdpZFEwkUiVKw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 21, 2021 at 04:51:08PM -0700, Zvi Effron wrote:

> > What's a patchwork and where do I find it?
> >
> 
> Patchwork[0] tracks the status of patches from submission through to merge (and
> beyond?).

Yeah, I sorta know that :-) Even though I loathe the things because
web-browser, but the second part of the question was genuine, there's a
*lot* of patchwork instances around, not everyone uses the new k.org
based one.

