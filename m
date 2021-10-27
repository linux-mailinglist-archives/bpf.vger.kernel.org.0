Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC8743C5CF
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 10:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbhJ0JA4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 05:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhJ0JAy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 05:00:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFD8C061570
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 01:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:To:From:Date:Message-ID:Sender
        :Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2tgLNRa9KFlUo9/a3EImq8cBVh4BIQaK/UEJaeUPph8=; b=bTmF3+ek3EoRKEBH36GjvdGau1
        p+f87AN0/cCrWYtehhZ8GV+8DWsFrJSpv/e9/nlizV+G7XRaWS8Aw4Y696RrnNVCj88uuaN9XAsas
        8gTasMC+CPIGV4l2sLlJsTD54Asbk/QVx4rlHZtpZU9GjqZRbjaQrye2ah2cYHsEmJ+uEOj9q5Rfx
        Cl/KXxpcWlsjJSdeO8WyA2N8lE/wJ8WA/9SjYSBVkduG9mJ+dBcLBgdPvCjbavQUX8+I+7PpdgAjT
        AGFPwYeWfWnlbLUm7FxKn2+j6xsIhSXqSgi552O3bKZl5ujtAcYsIK973mmkEwjeANwdC/gS/LJHM
        DFhWEXfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfelJ-00CWVt-By
        for bpf@vger.kernel.org; Wed, 27 Oct 2021 08:58:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A97830031A
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 63541236E43D7; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Message-ID: <20211027085243.008677168@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 10:52:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bpf@vger.kernel.org
Subject: [PATCH bpf-next 00/17] x86: Rewrite the retpoline rewrite logic
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For the BPF CI robots.

Rebased to bpf-next/master, one additional patch from tip/objtool/core to ease that.

Please don't reply to this, but instead comment on the thread here:

  https://lkml.kernel.org/r/20211026120132.613201817@infradead.org

