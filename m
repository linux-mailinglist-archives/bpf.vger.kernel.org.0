Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3097D6D3F6A
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 10:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjDCIuI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 04:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjDCIuG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 04:50:06 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3208A50;
        Mon,  3 Apr 2023 01:50:00 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so114284523edo.2;
        Mon, 03 Apr 2023 01:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680511798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F1csYuc8Du+yp6knHrKqTSIkRPNcCOVusY7pemIXMNI=;
        b=NR0lUwCqM13kiX4Ei0Wpeh4pxSI8UQQzUXYoO85m56tZ2rNpR1aa5TKAHjt6qmiHgx
         41akPXEgY+X2SDyOEJiV0xvN9/iNkHrmJxMQe+NDfGAd1Rbl7gXNMRQG2YEpWPcQobuk
         RSoM965Jaa+wOVGjbxkuKhXvExt1k2x1i/d2I5s8/8/fRFDEJFTC7M8EZ7jIZ7U5c3UG
         1mkZeaP1mnib6E9SDioYTvhE+3mEiJmGd5P3TCyInLeE5P6hK1ksukbP2VYTQ/7v8bbk
         AwZ5TlxOv+yjLUOw8GfcU1yraGmY56PT+vfAdkZdXmwM1MBRI0jPvMPWKo8pGZXUCo94
         IlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680511798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1csYuc8Du+yp6knHrKqTSIkRPNcCOVusY7pemIXMNI=;
        b=sqD2rxEckzdcagh0VFV11zr3Hc3FjXap7e03FKxcI/Z3wfaAd/89vgrZITZU2VT9fO
         Zy2lWDpW2cCeljw4JKrHwDOZxjt/BfLbrb9M3w2wZaHgONfSkE/w31YKq008y85CKkXo
         cupDfUMpVKaCBVnCQxrNJVRpEB75dYzyto7UOHpM1ScS/wd4PtmlzU/Y2STNUzRX5KYb
         xPEdw29kWu590T+56qGk9DPgvVDxnquRLqjoer3KX7K7pDOXtex3Enn5oZ7NJsNXrAU5
         sxeDKW+suvzWNQDUlaOGdAhrAvdvoJUY0YerWNAOclqKmuXJKgmHkGs9zGyEKhbDmTOx
         BCyw==
X-Gm-Message-State: AAQBX9cBw1b5SFvh/HxC/F5GiHyB6DWaX7/Nm26QgzMus6k9klAS1ys8
        ek81oBmQ5nYTM4jXlfZaaQ9En3an1uMKSvlq
X-Google-Smtp-Source: AKy350YKFA2hrAAFD23ldjQlNISQa4Kzn5iawZXIIDNQdadr6n/MRqHG6wssuEkw6iEjd1oZcfXysA==
X-Received: by 2002:a17:906:4786:b0:946:a1c8:e000 with SMTP id cw6-20020a170906478600b00946a1c8e000mr26881504ejc.44.1680511798526;
        Mon, 03 Apr 2023 01:49:58 -0700 (PDT)
Received: from localhost (tor-exit-relay-8.anonymizing-proxy.digitalcourage.de. [185.220.102.254])
        by smtp.gmail.com with ESMTPSA id t6-20020a170906608600b0094863433fdcsm1679976ejj.51.2023.04.03.01.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 01:49:58 -0700 (PDT)
Date:   Mon, 3 Apr 2023 11:49:54 +0300
From:   Maxim Mikityanskiy <maxtram95@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Joe Stringer <joe@isovalent.com>, bpf@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, corbet@lwn.net,
        martin.lau@linux.dev, john.fastabend@gmail.com
Subject: Re: [PATCH bpf-next v4 2/2] docs/bpf: Add LRU internals description
 and graph
Message-ID: <ZCqTMq3sHMrx2boI@mail.gmail.com>
References: <20230401200651.1022113-2-joe@isovalent.com>
 <202304022107.IwHc05cs-lkp@intel.com>
 <ZCpK5wOI0ZEedhrr@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCpK5wOI0ZEedhrr@debian.me>
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 03 Apr 2023 at 10:41:27 +0700, Bagas Sanjaya wrote:
> On Sun, Apr 02, 2023 at 09:47:49PM +0800, kernel test robot wrote:
> > All warnings (new ones prefixed by >>):
> > 
> > >> Warning: Orthogonal edges do not currently handle edge labels. Try using xlabels.
> > 
> 
> Hi,
> 
> I can't reproduce the warning above. My system has graphviz 2.42.2
> installed (via Debian package). What graphviz version do kernel test
> robot have?

I have the same warning on Arch Linux.

$ dot --version
dot - graphviz version 7.1.0 (0)
