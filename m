Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07B45095FE
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 06:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiDUEd2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 00:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiDUEd0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 00:33:26 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00BA12771
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 21:30:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t12so3714420pll.7
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 21:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5KHip1nH63CI5qYf/ein5v8QtFgiMbvrTJ/xLO5wWtE=;
        b=kTANYJc5Djaen3m0+inLT7KHhksdVSrW1WD6Zi/IC7zr8Xeo4AT2ZaqBAN1kqoG9aD
         5b3eoQRpTj89vdGvA1XQeWNh6jTKgVTGISXWbnVCpPOanbsNUPUm7uAOz/ckLlDB4bT5
         tGUmrfB8ZKs5xRww1NPj0XrC5CZTTEtBDepiyi4a0vGBreA/VFnP8q5cG+IDuT1UVbfX
         30x6OIEEgUmRVVagXG8LC6l7P239lC8PWi24i5Eqg5fhjck7j/4gdqcSRhosh8xL7S/W
         bWuIpUnzlOHmuXObI5y0Izl09/RWco6eYD9yU4oGWGDYp4vIQvK+WQeK+WLlkwO6ka/F
         o4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5KHip1nH63CI5qYf/ein5v8QtFgiMbvrTJ/xLO5wWtE=;
        b=4teSziFSZPD53NppLHiNlfkW11LN2avmsVW5pIoWoPAXeylBElz73+1WvLpX6QmoJB
         JAJFUg0dk30SVxcU9ANi5NxwWNh7pGwqV2u01CNm9YaQ8yaqkMkDfAaYm0g303jhgzZZ
         m3DR6HJLhncs4lqFgkfPBjzVfkHvUiItxDUdhrMmob7jEbF6FGvTF889MEgCXPn4SC3d
         HNgBCDRXCzNzA8O5WUFTETzo3h7Cvi82KVT5o2vHh9/c0PncJHysBQtx0FWluK7YQN6S
         oHWkd4OUGeN9xlnNHWKj2mV4joqvbGs//qBfV2u/WxxwS5ipE75nEPpUgcpF9LmP6WSt
         RsRQ==
X-Gm-Message-State: AOAM531XmTCI1o8TTvqVDx78RzQKqL3EL88UGbkSIdHwxhMXeDrFwAbm
        MP6HKvPBB4h5QdiLs8Wx+iw=
X-Google-Smtp-Source: ABdhPJxo9CScUB9X6Pskc2fcGjBsIy3GKRxzCK40jx84gjaK/k2BNLVYQW7lyimCA3hlNiur9T5zqw==
X-Received: by 2002:a17:903:244b:b0:158:db5c:8fee with SMTP id l11-20020a170903244b00b00158db5c8feemr23721511pls.1.1650515438298;
        Wed, 20 Apr 2022 21:30:38 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::5:4399])
        by smtp.gmail.com with ESMTPSA id s50-20020a056a001c7200b0050acf7cadc5sm3106555pfw.112.2022.04.20.21.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 21:30:37 -0700 (PDT)
Date:   Wed, 20 Apr 2022 21:30:34 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v5 02/13] bpf: Move check_ptr_off_reg before
 check_map_access
Message-ID: <20220421043034.isiq3uupkpbmv5sc@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220415160354.1050687-1-memxor@gmail.com>
 <20220415160354.1050687-3-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415160354.1050687-3-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 15, 2022 at 09:33:43PM +0530, Kumar Kartikeya Dwivedi wrote:
> Some functions in next patch want to use this function, and those
> functions will be called by check_map_access, hence move it before
> check_map_access.
> 
> Acked-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

I've applied the first two patches.
