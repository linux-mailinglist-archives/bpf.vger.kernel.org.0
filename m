Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758DB38D73F
	for <lists+bpf@lfdr.de>; Sat, 22 May 2021 21:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhEVTgK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 May 2021 15:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhEVTf7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 May 2021 15:35:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9BDC061574;
        Sat, 22 May 2021 12:34:33 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 22so17109559pfv.11;
        Sat, 22 May 2021 12:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8KijSDwphJuSFN/VgpPLWyevNGJXXuQctxeSIGKsOPg=;
        b=edVTlmmQdWA6pTSaH7kFxlP+xJjqwjBR/NS30kAtrWaK2uX2rxMMHjXVCPDWurV4hE
         xxJarDGycq6viXfFmyeGjLSEYamin8kuHAgumF6vZUyU0KI3Z2MFSeuyRaQp4ejVowez
         kgOkVesvrNBd+hw+SDr1wo33MqtqJtH+FpZbqEq04pZ9Q3YbJaVxOQaLK782WqCPwqFx
         1qo+3/BdX5Yjf2np/pb9w1KZecfUhawrRS0rUX0W4BfcI7SCp7BrZ3TWur/W1DjAZFvj
         xiM3pIOG8r8UThBOaSWSXMznxin/QT9mPsO5rq8OY4maFsjnfUUB0pnXEVDp5NOHfJEW
         S7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8KijSDwphJuSFN/VgpPLWyevNGJXXuQctxeSIGKsOPg=;
        b=d7WUoQsUFPeHVeyiR9X86pdk6U35oXkxuO4HVc4fTJNJ2wRjkxGhZ3npmLWwMetSNc
         J2PW+kNGe7s3SJH+09PJGCZkubL7W+bQsgmx4CDiqTUCD88xP1nSvzugkff/UJ2dfrd9
         rVcbPJjx16rMYqvYd0fjJa2EbMusyHq6fKJkctQeg2mkae8CzjpXwIRDfrTsDrVIw9cE
         85GUahEjvHPbl2T2NAtPvFqrkEhDineiVpznoRPOw1J0yIXrMILZx1wlvP2S9wv55hSI
         BAHLKZl+Pe3fqQMtV2OxKXOZ6RXD6YYhSPNu9rAvW3/1QkFwx22T5uEw4iwbWjH1VL4z
         u4ag==
X-Gm-Message-State: AOAM532J/reYQZHzWHyOuFV2gvnrS9z0XBLVvXm9TZEGaKzggjEw8vk6
        b56qWS99qn9BDocltkEt/hI=
X-Google-Smtp-Source: ABdhPJynfo35lRhdZ6EpidZ4MqRz7PBvDzGBMKvfaD8Gmo5z7iPxQCplnXRh3AUdIRS0MizF03zZZA==
X-Received: by 2002:aa7:8a1a:0:b029:2d4:a24:8967 with SMTP id m26-20020aa78a1a0000b02902d40a248967mr16663775pfa.11.1621712073036;
        Sat, 22 May 2021 12:34:33 -0700 (PDT)
Received: from Journey.localdomain ([223.226.180.251])
        by smtp.gmail.com with ESMTPSA id k9sm7698173pgq.27.2021.05.22.12.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 12:34:32 -0700 (PDT)
Date:   Sun, 23 May 2021 01:04:28 +0530
From:   Hritik Vijay <hritikxx8@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-next@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: Failed to start load kernel modules on 5.13.0-rc2-next-20210521
Message-ID: <YKlcxO3ofPEr6ak7@Journey.localdomain>
References: <YKlWqLh61Rxid7l9@Journey.localdomain>
 <21727ead-5092-8900-74e9-ee73774b0b97@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21727ead-5092-8900-74e9-ee73774b0b97@infradead.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, May 22, 2021 at 12:28:25PM -0700, Randy Dunlap wrote:
> Hi,
> Here is a reply to a similar message/problem:
> https://lore.kernel.org/lkml/CAEf4BzZuU2TYMapSy7s3=D8iYtVw_N+=hh2ZMGG9w6N0G1HvbA@mail.gmail.com/
> 
> so it looks like Andrii is still debugging this problem.
> 
> -- 
> ~Randy

Hi Randy. Thank you so much. All this time I was wondering if I'm
messing up the compilation/boot somehow. I am not sure how to follow the
thread. Perhaps sending a reply to the linked mail should do the trick,
yes?

Hrtk
