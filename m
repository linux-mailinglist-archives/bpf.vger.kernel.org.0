Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB04A46A900
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 22:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhLFVF0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 16:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhLFVF0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 16:05:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04408C061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 13:01:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFB0DB8110F
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 21:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1074CC341C1;
        Mon,  6 Dec 2021 21:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638824514;
        bh=GyMzhM6yNZ6LpLYZLrckQyrBkwzgt4mDR9duTDpRGEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D/eHBFxzfQpqs5fVH9fiAkl7aiXOBFQ9sTSwjKLKElejRBqPOCW9Ef2/BKjwAhg1L
         GSdd9Sf1jIwhruwPOANip0VOa+cjFZIzF/nixsB2w1wmVRDwqo1rNYSgKHDXwc+mED
         KOe5NzokE/74H16zVmbASONJYsFVZlBQ9hwp0pjplFRWmfhhX8azeVyjYMI6E2IHDX
         M2jwt5E4U/8x59GO5gERv2t/4IyZnxMvC2ATE7Xys63PK6t1B9vfg/jdvochJNCaNp
         CRLl3K6FVhfMEbCIz4thZZwz8I4ETCiwZcpUeFL/JGUGDaPz0v17AyfqasaZGtLbGQ
         Vd1Z7ERxNAFHg==
Date:   Mon, 6 Dec 2021 13:01:54 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, bpf@vger.kernel.org,
        kbuild-all@lists.01.org, axboe@kernel.dk,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com
Subject: Re: [kbuild-all] Re: [PATCH bpf] treewide: add missing includes
 masked by cgroup -> bpf dependency
Message-ID: <20211206130154.6aab7d7b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <576e09b1-eb25-955b-9a7c-53b1b56b8dbd@intel.com>
References: <20211120035253.72074-1-kuba@kernel.org>
        <202111201602.tm0dlDfP-lkp@intel.com>
        <20211120073431.363c2819@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <576e09b1-eb25-955b-9a7c-53b1b56b8dbd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 6 Dec 2021 10:21:00 +0800 Rong Chen wrote:
> > False positive, riscv seems to have a broken module.h so including
> > it in more places results in more of the same errors.  
> 
> Thanks for the feedback, the bot can't always find the first introduced 
> commit with the bisection method,
> we hope someone can fix the reported issues if interested.

FWIW I realized later that kbuild bot was actually correct, although 
the chain of dependencies which cause this wasn't obvious. Apologies.
