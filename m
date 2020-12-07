Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779792D19F1
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 20:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgLGTop (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 14:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGTop (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 14:44:45 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7ECC061749
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 11:44:04 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id n26so21205612eju.6
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 11:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+ne0GIKqTiBoOHj/8BINlg1y+EHZi6FtbaG0qha9YKQ=;
        b=XMDhzv28iCECmyEscX+hfMAVVuWQzHZp21Zavjrcx4by2MNxNKPEGVN4xig6SqXmD6
         behzcE5w4VrBRU0Bm3KXkqIfRxMOGuZjmbXccGzOVMD+cmAwfmrOMV/8+7wBxpdibUdg
         azgPkB+oLeBs715NusjgSL+qzg4fnFZVxH9Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+ne0GIKqTiBoOHj/8BINlg1y+EHZi6FtbaG0qha9YKQ=;
        b=LaafTu9ZcHkBAUgwTQjk4rWOh6s5iQEGUflNDJbcw5IRk7ag8Oku1X+CUE6A4EYpKo
         nfN4cxvxIX37qfGxBIH16RoXzGlecX6oEov1VI6uFsIsDXDOHMADMecaBmzVrx8hemZf
         V/KmCFwxFLnSZ0pFuYIQAfroUR/aNaGlMpzDRFxkQB5/aungO22nL/LzkqIyIhxxjgfo
         RIzVMooOuEAs0lnbdscqCNJNhPqZ1JGwLy9SIyh3HZgULoiDFRdxPkxHp/BXWmKiM9hI
         Cj3h5oHfEc4GXtnBRJMY86SPMCrZA/NLNNzG391KKu0KY4snBLgmFKdL2aHMy2ADT1c8
         y+0w==
X-Gm-Message-State: AOAM533GlfhmH/zuAS1Xct2wh1DZ6tTNL1djhISkxGnO6VzBd1/sf4lF
        6mPH0fdEkq40wQYcDXZyvn33eA==
X-Google-Smtp-Source: ABdhPJzAqqtK5ms3jsKRJ7blt5YhUU/Pinq3V4LDDazyb22nUxTY2Foq5JSyPO8x0h93y+xc2Yqnew==
X-Received: by 2002:a17:906:c408:: with SMTP id u8mr20213768ejz.364.1607370243525;
        Mon, 07 Dec 2020 11:44:03 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id cc8sm14275838edb.17.2020.12.07.11.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:44:02 -0800 (PST)
Message-ID: <bc37337ff82e187e39d029ee9f488d81e2b4fb44.camel@chromium.org>
Subject: Re: linux-next: Tree for Dec 7 (bpf: sock_from_file)
From:   Florent Revest <revest@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florent Revest <revest@google.com>, bpf <bpf@vger.kernel.org>
Date:   Mon, 07 Dec 2020 20:44:01 +0100
In-Reply-To: <b8f2e76b-a35e-55c5-e937-eea81700c994@infradead.org>
References: <20201207202520.3ced306c@canb.auug.org.au>
         <b8f2e76b-a35e-55c5-e937-eea81700c994@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2020-12-07 at 10:39 -0800, Randy Dunlap wrote:
> On 12/7/20 1:25 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20201204:
> > 
> 
> on i386:
> # CONFIG_NET is not set
> 
> ld: kernel/trace/bpf_trace.o: in function `bpf_sock_from_file':
> bpf_trace.c:(.text+0xe23): undefined reference to `sock_from_file'
> 

Thanks Randy! I'm on it, I'll send a fix to bpf-next.

