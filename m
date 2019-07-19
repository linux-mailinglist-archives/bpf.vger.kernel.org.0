Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E406EA42
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2019 19:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfGSRh0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jul 2019 13:37:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45099 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfGSRh0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Jul 2019 13:37:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id x22so26932565qtp.12
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2019 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=md74l1tP+3MjgDMecOFujGhSYnRDKsU/DGj+r4fcaKA=;
        b=o0Or+ROwXh+YLyB2aEGTFyHtfesjXiXIrpdbAQngHhqLThjapIYUAKcKkSwpSvvl0C
         6Bb7CdHSj8RIZVo9EMGHiHAwtG17xnYj8cEcTIPN9dw1lVp8Zj98kld9AjS6rancgC95
         h6iu/SBUsb6MNuXMSoJ35lfRyq06SMeSxnmKjahz/szhJUZbIg3Cz9QxhDwmcAfhwtsK
         PeZrXA9EGYXyqOYkZPdiXFeSX+UTHZppUXB9BhbDxL6Wc29cBH56F5wtXszmV0r22vKE
         EY04IV/7FDZDKevCpYxfbMtqtThoMmWe62dDtELeuw19XspEjp60gxcV8OYubnS4OKlS
         jgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=md74l1tP+3MjgDMecOFujGhSYnRDKsU/DGj+r4fcaKA=;
        b=bLzGdpXMDVxf2dv+o098JuAGY8jG668Y+kQ8FOt1ew/Q0LkpdkqmXpxXDzI+Bjnl6+
         p3itC3XEIGOJXWi/1sEI/jlSHcpoZrygkOX1AQ0xAeavuj487E/hsHQwl2AxiY0DOIsC
         gdycylGN6enrT6WQCz0Mn2jrM6BqEQnX1BQi2pVQFG9D8c7bh8zYaRnwhYANCNoWmFR7
         c1jpMut9VJTRMd17qdrii+EO/tI3/JhTCsqXpsuvY0MnFU1OdEfGzAJcoLxskWG538Oi
         bJQJvc/GQo/UeIou7msrilf6eCytTbypcEtEgLdz42PD+mCLwtrOUuyofgCNjwVlfBQw
         V2Mg==
X-Gm-Message-State: APjAAAXPCqrD47BzLp9t21BJ/Gmc2n5ikSZcAPCJM7lJRn109bx41A2Z
        as4uSpApIr0LFrTPamXILEf0EQ==
X-Google-Smtp-Source: APXvYqxdzwTKTjLFLIHtd2+PRC5rnYBA36IJhJcYj1ZBcnYvlY4HaoSFJLg5LS84k7nO7zA0WHFzbQ==
X-Received: by 2002:aed:3e96:: with SMTP id n22mr32894870qtf.247.1563557845634;
        Fri, 19 Jul 2019 10:37:25 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id z33sm14605101qtc.56.2019.07.19.10.37.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 10:37:25 -0700 (PDT)
Date:   Fri, 19 Jul 2019 10:37:21 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     john.fastabend@gmail.com, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net
Cc:     edumazet@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH bpf v4 00/14] sockmap/tls fixes
Message-ID: <20190719103721.558d9e7d@cakuba.netronome.com>
In-Reply-To: <20190719172927.18181-1-jakub.kicinski@netronome.com>
References: <20190719172927.18181-1-jakub.kicinski@netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 19 Jul 2019 10:29:13 -0700, Jakub Kicinski wrote:
> John says:
> 
> Resolve a series of splats discovered by syzbot and an unhash
> TLS issue noted by Eric Dumazet.

Sorry for the delay, this code is quite tricky. According to my testing
TLS SW and HW should now work, I hope I didn't regress things on the
sockmap side.

This is not solving all the issues (ugh), apart from HW needing the
unhash/shutdown treatment, as discussed we may have a sender stuck in
wmem wait while we free context underneath. That's a "minor" UAF for
another day..
