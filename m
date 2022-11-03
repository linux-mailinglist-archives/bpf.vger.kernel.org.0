Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F18618AE1
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 22:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKCVzJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 17:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiKCVzI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 17:55:08 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD1F220F4
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:55:06 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id z1so2066111qkl.9
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 14:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5y49eme4zzL+e52tDvAMTGmOmqDzIlH1h0s5CXM1IwM=;
        b=szy/rqU1CLfERLcD3zDPqfRHVFwZCNTJEkmQs2hYSIhA5cvh4UTb6chAJL4r4Thnn9
         IB8FcKH2wmOmi3w1Z5svFQbT1xUxdWcvJ+bn6YuxcmqIlAeU9SuTgEnM++6ybWIG8nI/
         6bbeNTFZXfhW/uiGwC8NGfSs/H1dxiRDKJLlChvuOjj2UHiVpaPdjnxTP4Qe80X8eIKo
         5O2dfqqrIDkUtJ2l47hUh3ZP26JXhYmvRhPs/t0vXwhJzNvK0kosXctLAp9XJXkd9+Ov
         0Vf3/ar1Z3ZUrki4X1unNWCvcThY/rWqtyoYNceP0w1ZVDPfSGnyRdmcTPXDSCsfR6g2
         kpcg==
X-Gm-Message-State: ACrzQf0J++83VDHOxn2OeaIATzQFzqA2ELaLn3Ih+ecAfueS3Q2EQOqt
        SRBspt7Bz3Iyjbl8jhZ2S6o=
X-Google-Smtp-Source: AMsMyM4mwGyxASv9n/uQHS1sY5y6UI+ZPylQkXCKUm3cpsz72F/MyP+1SxHUdRgPljd67xbBcyy+/w==
X-Received: by 2002:ae9:e015:0:b0:6fa:2b3a:9680 with SMTP id m21-20020ae9e015000000b006fa2b3a9680mr18725226qkk.417.1667512505275;
        Thu, 03 Nov 2022 14:55:05 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::b27e])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a254b00b006fa120f979asm1573483qko.43.2022.11.03.14.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 14:55:04 -0700 (PDT)
Date:   Thu, 3 Nov 2022 16:55:04 -0500
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v4 05/24] bpf: Drop
 reg_type_may_be_refcounted_or_null
Message-ID: <Y2Q4uHta5oGVXwZJ@maniforge.dhcp.thefacebook.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-6-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103191013.1236066-6-memxor@gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 12:39:54AM +0530, Kumar Kartikeya Dwivedi wrote:
> It is not scalable to maintain a list of types that can have non-zero
> ref_obj_id. It is never set for scalars anyway, so just remove the
> conditional on register types and print it whenever it is non-zero.
> 
> Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: David Vernet <void@manifault.com>
