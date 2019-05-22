Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4026A2651B
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 15:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfEVNvY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 09:51:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfEVNvY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 09:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7PcrUJpAN8FUR5Os5eZdN4/qfIg3FFf2/UF6cSYu22g=; b=FRneyTJ1KPX9uILNf6OYwDJke
        r1sUw/VWN1m3p5ISAdhvMbPPFLADQ764Wp+ofMRLOF1Ixa1dwIVr6HuEH1GwdoVNpR1adztp+plZM
        E5nO+VcZVOteXU3qtxUFly2BizAYJ05PghzY3RDhVnreLVIzynopkKDkQjFKDx8OYMYYkpUq+fTfC
        VjvPSZzzwkCVzVocdTUB7rmIgRtTiiqU/QyTwWtgpOSbpOaQY5FJB/4+D3t1nvn7jqG8kGJ6dW53O
        d5rXWNcHyUIkUJNOQMtQpHqRF3BK9F5pEp15zu04Mfn07X1V1MjGQYFVY14F6Zu2MJEDnGekXk3Hb
        L8vU2JuXA==;
Received: from [31.161.185.207] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTRe7-0001EA-LX; Wed, 22 May 2019 13:51:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FCCB984E09; Wed, 22 May 2019 15:51:06 +0200 (CEST)
Date:   Wed, 22 May 2019 15:51:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Kairui Song <kasong@redhat.com>, Alexei Starovoitov <ast@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Message-ID: <20190522135106.GA16275@worktop.programming.kicks-ass.net>
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
 <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net>
 <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net>
 <8C814E68-B0B6-47E4-BDD6-917B01EC62D0@fb.com>
 <c881767d-b6f3-c53e-5c70-556d09ea8d89@fb.com>
 <8449BBF3-E754-4ABC-BFEF-A8F264297F2D@fb.com>
 <CACPcB9emh9T23sixx-91mg2wL6kgrYF4MVfmuTCE0SsD=8efcQ@mail.gmail.com>
 <842A0302-9B36-4FBF-ADF7-9C6749E8C5BE@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <842A0302-9B36-4FBF-ADF7-9C6749E8C5BE@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 20, 2019 at 05:22:12PM +0000, Song Liu wrote:
> I think this is still the best fix/workaround here? And only one level 
> of stack trace should be OK for tracepoint? 

No. That's still completely broken.
