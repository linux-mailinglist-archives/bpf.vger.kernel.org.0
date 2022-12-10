Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20DD6490DB
	for <lists+bpf@lfdr.de>; Sat, 10 Dec 2022 22:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiLJVp6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Dec 2022 16:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJVp5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Dec 2022 16:45:57 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FB313DDC
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 13:45:56 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so11756880pjr.3
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 13:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n1sSE4TWkHyQu0fEETj0FzMZ10jj4qG+25G84v2cHcU=;
        b=j8kq9O514NtOg7oxjWA2rM1yC/HSqwy/Z12wY4yLXdJ5XJB04jtjzio/6tU7f5MEUU
         8peSdOk6VhFXB8EfFfAbtzo3rRjWLWWCHDyxXWJ7gCWFe1c1d1Xu5G44v7YalOdvu9Rb
         HaiiBH+61FC6gV7iPJFAoBEPk2bVPIHIClY6kg1d2gI0iV3UxYTmVI4eRDymXtaE/vpp
         9abSgeaU6TiKiNIfnZP1XbH7w6TYdjgGrizGhK598GmZoCskOBKaPRrIMN6IIT/rSjy3
         K7nzBS3g8VXFFtt03Uv2KLM6IwC/uG9De7C0bWa1vjP4Um0eBeV//R7KjiXf0PbGRlnO
         rDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1sSE4TWkHyQu0fEETj0FzMZ10jj4qG+25G84v2cHcU=;
        b=fHS9eayHiUDhCKwBADFewkJa/vooRvDbKckQon6xGo+c/Xi/OnpXbKJfyDiXQrdZ2x
         WGewkdJbh/yu24b7yVRLOxJoz6Ki2PkH/JP+T3n9XI9KuCV7gd8d9RFtTtIFEMVA+Q3w
         XUjokzyZ6iXwWndgoETdDGz/s7STfx/n1xZbKAad33ymb5WO/QYXlX6dLJUSmXuE0HkM
         r3L5lBJswGBIhZu8YNnrb77KuWP6WGFoFb5MJtj1/1H+/GyyHVnX3ngCbyEKdwZkgvHz
         i9ajUhZb0O4zcmrjy0EHtsq6IZnrtl+3NU4qubb/bU7eVrTiErOIcmkgkXeFD78HGnWb
         Dycg==
X-Gm-Message-State: ANoB5pke6WTJUhuxOXOasZZdokXBArlKuwjyamNP1H+ngUFkwY2Is3Pu
        WI8eQymEmjdC8suxsebV2xM=
X-Google-Smtp-Source: AA0mqf4tW1oGBfiSGgKTvMPxvH8IGZy5KxzDfVXv1k/P6W8Gg8Eqv8vyw5RhA4y1C9lyRYhiGKYU8A==
X-Received: by 2002:a17:902:b907:b0:186:60c0:9f9e with SMTP id bf7-20020a170902b90700b0018660c09f9emr9681713plb.39.1670708755736;
        Sat, 10 Dec 2022 13:45:55 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:55c6])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902cec100b00188fcc4fc00sm3419619plg.79.2022.12.10.13.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 13:45:55 -0800 (PST)
Date:   Sat, 10 Dec 2022 13:45:52 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        memxor@gmail.com, ecree.xilinx@gmail.com
Subject: Re: [PATCH bpf-next 6/7] selftests/bpf: Add pruning test case for
 bpf_spin_lock
Message-ID: <20221210214552.ewk4kd7hi6m276vr@macbook-pro-6.dhcp.thefacebook.com>
References: <20221209135733.28851-1-eddyz87@gmail.com>
 <20221209135733.28851-7-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209135733.28851-7-eddyz87@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 09, 2022 at 03:57:32PM +0200, Eduard Zingerman wrote:
> From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> 
> Test that when reg->id is not same for the same register of type
> PTR_TO_MAP_VALUE between current and old explored state, we currently
> return false from regsafe and continue exploring.
> 
> Without the fix in prior commit, the test case fails.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Nice set of fixes. Thanks.
When you resend somebody else's patch please add your SOB.
This time I did it while applying.
