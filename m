Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A504BCBAD
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 03:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiBTC0g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Feb 2022 21:26:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiBTC0f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 21:26:35 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F71139B95
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 18:26:14 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h125so11213303pgc.3
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 18:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o5ibvica1JkuwvDzlFEmilPT0FsIvObmWzVpm9Vpog8=;
        b=iIuSVhPykn426TElrXV2P/HJE3rdICG6aacRYE5eb41pkaeN9xM2XdXDC4ielRPGC1
         OzSUF9V4CiThTTa79ytOd103mYhxzznMPZ+Bo94FOAn3f2BnkX3O5ieETVJuS7KE+YyP
         oU2VmD7dsMedsORXwfQrtczLqoa19k/KpYssJdtRh5LRXKciPIwBB9wgdR8q0Ovss0ik
         pw4XpHSLRMBhDK+8/K/q865LonDd2tG8pzjtG1sQk8ahWoch8b0u1Jmi6MfLCVj4ezPL
         z5qVf3YQhv/a5RxIhpKWTNGzqfAYN5KFV30fPrxRaVlwpM1QdtfFwjosJdtaQmupGfFj
         8CaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o5ibvica1JkuwvDzlFEmilPT0FsIvObmWzVpm9Vpog8=;
        b=RPypFAdVGROmqv10yVdQ748VX7wDxrs7V9ZTwhYmTbb0JQ4c5VfpkUuOn0hOUvJkWq
         0Bcg/9PMbVUymLZV1WVIOFXD1x2SHH0Le5zGkR0puaEBdx8xAATI4CESMEfPwUx4qhTA
         ejOH6R1qXJDEA8AXoXsvmr0KPCmdAoJPGm4ObOWnq6+Wc4UNRLR4WktWhBTgAVspxgtA
         XtSOwTpPWP4SgtIdKITwk/GHsNVwBQFo5hff4nczirCBLuyP/fv4t5ezRjxK+SLu/772
         zOOIUJXzNOiBCQfK3Z+4jrYo8WzHjRdlXAy5L/0QIazlwUeRpoBigM2s6rvpYUKk66se
         WM2A==
X-Gm-Message-State: AOAM533FBAcs8TkZPHwlMJIUiBGTVFoaSD5mU9wH10SxWa3ku15DMEFX
        bcXnLOn65smpD/DTj3yOSQI=
X-Google-Smtp-Source: ABdhPJwRxfrLlbaRM9AIo7GwLc84eE8xCbIFKBYsytwvkcz8bGLcXYU3ypmVzUGepO0l2QbmF5dmng==
X-Received: by 2002:a05:6a00:16d6:b0:4e0:ed6a:cf82 with SMTP id l22-20020a056a0016d600b004e0ed6acf82mr14033132pfc.9.1645323973899;
        Sat, 19 Feb 2022 18:26:13 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:e3e2])
        by smtp.gmail.com with ESMTPSA id z11sm3246293pjq.53.2022.02.19.18.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 18:26:13 -0800 (PST)
Date:   Sat, 19 Feb 2022 18:26:11 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf v1 0/5] More fixes for crashes due to bad
 PTR_TO_BTF_ID reg->off
Message-ID: <20220220022611.nor4eeh6vdaaqgyr@ast-mbp.dhcp.thefacebook.com>
References: <20220219113744.1852259-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219113744.1852259-1-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 19, 2022 at 05:07:39PM +0530, Kumar Kartikeya Dwivedi wrote:
> 
> Tests for patch 1 depend on fixup_kfunc_btf_id in test_verifier, hence will be
> sent after merge window opens, some other changes after bpf tree merges into
> bpf-next, but all pending ones can be seen here [0].

Let's get everything through bpf-next. There is no urgency in any of these fixes.
Please post it all including ptr_to_btf_id-in-map set.
