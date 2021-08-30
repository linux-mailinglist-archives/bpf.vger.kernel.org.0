Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35AA3FB684
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 14:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhH3M4C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 08:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhH3M4B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Aug 2021 08:56:01 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77357C061575
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 05:55:07 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id l4so8138273qvl.12
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 05:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ttVYJm0Znr1K2DxkaN4d1dJSR/5BjfnpqwfsdarTcD0=;
        b=PYbIDPGALPnr0kfAXg9anSnoJo9L9FhtF5RFh3ymr0vTO5jOH6wmhUMEO3kTCAqMcq
         QD5zYX/Z8DlUrvnBu2W4I7f4qqY42QkACBDUO7zL++tGFz2rGgZQKPksKuj6D576MZ/5
         j6cVzgEOQeztsOe9vkaF1TIMzF9Q1TvsTrwdNHpL2KidJ5xK+WqcqD02vb7sYFK1hf2l
         EJXOfNeccgkd3fANJjX7zy/8JWOEwMDJmB/WY99mMgoBLLFW9/XWs6FCvuNgfvM7fQQh
         2Mf2POf+qLn4A7kiLq60xAONdbu+CrSRLHFg7hZ7V86Y3R6fciS+bt6L4PIVIV7+iWiW
         njVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ttVYJm0Znr1K2DxkaN4d1dJSR/5BjfnpqwfsdarTcD0=;
        b=bk65bSYhAC8wTf/eRLKNkKUfpam8dsTcXKNljxj0bXxzZdwGDflpjiJA/a8BtCt3jX
         NLtVaz2u4Y0znFWnla8Bafg2BSdsIDu7Wa5uzW3SeUnLWX9t0/Os5fPhiX4uIca1022Z
         N2Eq4/azjc6fi/5a7aSVpVzlSWCW0WDHgyrQQs1P6x+icI52ph0dUmZK6/YLgXX1ZcxB
         NN1MmcqX82WCoAanAVPQZQPCmhxzs1PgmpmtFj2kDW8+ohxBe/N1aRK187UYI5krzuYU
         wyZl6VRvUOXjopjo7X4SdfwfsloggyXKi9lVybdxByI0EtXLYduFeLIhAWksdXArk49c
         /h4w==
X-Gm-Message-State: AOAM531szz8CMMCc+oSylvE5JTvwVmUVpr4aMLRYig9dovmuid622wga
        wb5YFa+thQSs0t38mdhIf1I+7AD9XBTvLQ/s
X-Google-Smtp-Source: ABdhPJxgzwbE+xmU9zO6xzPk3YKnV07LLPiBvSAGkgUbDSWpMlcO1XLGu16IkJ8h0pD4orpRAWvTrQ==
X-Received: by 2002:a05:6214:84c:: with SMTP id dg12mr23168511qvb.29.1630328106662;
        Mon, 30 Aug 2021 05:55:06 -0700 (PDT)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id w20sm8324418qtj.72.2021.08.30.05.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:55:06 -0700 (PDT)
Date:   Mon, 30 Aug 2021 16:54:59 +0400
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     Raymond Burkholder <ray@oneunified.net>
Cc:     bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 00/13] bpfilter
Message-ID: <20210830125459.qk62gb5ak6xij4ug@amnesia>
References: <20210829183608.2297877-1-me@ubique.spb.ru>
 <42c5e32a-edb9-08a3-f37f-9def9583f5fc@oneunified.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42c5e32a-edb9-08a3-f37f-9def9583f5fc@oneunified.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 29, 2021 at 01:13:53PM -0600, Raymond Burkholder wrote:
> On 8/29/21 12:35 PM, Dmitrii Banshchikov wrote:
> > The patchset is based on the patches from David S. Miller [1] and
> > Daniel Borkmann [2].
> > 
> > The main goal of the patchset is to prepare bpfilter for
> > iptables' configuration blob parsing and code generation.
> 
> The referenced patches are from 2018.  Since then, and since this is
> bpf-next, places like [1] indicate that we are moving on from iptables
> towards nftables.
> 
> Any thoughts?

I'm not sure what kind of thoughts you expect.

If your question is why to use an outdated interface the answer
is - this is just a starting point and nothing prevents us from
having our own interface in future .

> 
> [1] https://wiki.archlinux.org/title/Iptables
> 

-- 

Dmitrii Banshchikov
