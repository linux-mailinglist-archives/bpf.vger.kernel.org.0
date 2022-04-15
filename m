Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776B65033F3
	for <lists+bpf@lfdr.de>; Sat, 16 Apr 2022 07:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiDOXOa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 19:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiDOXOa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 19:14:30 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A77E3BBE1
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 16:12:00 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 141so7559713qkf.3
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 16:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oOmrucnQNYYe+Fen0W8WuTTn0eDcXDdGmsSlnV6rvs4=;
        b=l9wF1ZVQ3T+PaRZMg4Ejky9C6lJLkzDkG7vxYudbDWfRtBcg8GsI2U55M6GAbPXnBZ
         eYt8Znx0Gq+DpGcBo034+6NlAiqH5imaDWqPYDd+lURB+K7uflNh0Ug+j2krIoTqCtS4
         Jm/W/I+40Sh61GLUJwl2FEhgZurFwN8T+OOSs3VSQk8ujkuh4iXxOLktZabWFTN+vsSO
         LPz4gWOsQVF2K8k2Yqisu9khgjLV6Kb3rwiALfX3K8rvuPp2iwHRGj4iACdAPMvjfUPz
         AI7BD25iD4JGfxPpREn8N65/z8WmzbbELPBPxajsfPEpioeg5Ja4ihZjDeCpvljzEBX8
         hhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oOmrucnQNYYe+Fen0W8WuTTn0eDcXDdGmsSlnV6rvs4=;
        b=59ISVDZnxuxesCrKAhfGUwp6qoEKO3sSq1dKe/onrMxS7w9n1dq6vtcF7RZfFzrcmz
         WCMplYDDUnU7XWe/DneJ9XdQpUqSXerrHl/QlGR1Jq2ad2Nbm55PJ2WZfD1AW46MMQp3
         52EOiwMfHpIv1UKvoAopUYIMMWKvfh81gux6f5+0cpkKfo1IF42Ukf9QAv3Vsl5vq8WR
         xas3+gvh7VcZeAo2rAK4CAOjJKbEn2AwIsIoinw1RugJjYoVkSmaQcDDhK9JCVKrsWE5
         gksQnbtd+CWF2WaLHfRF3KZIzL3dHU9XBcNkeO/zu1tB0p66lgnI6D/0q01pQc7vlLr3
         ehTQ==
X-Gm-Message-State: AOAM533TeeD6aQnCEbzs7CR+8nJxLKkMEIv5JNSWOau3vidqQxweiz26
        qZgw0s87murrri2rXA0hb1ijRA8uyw==
X-Google-Smtp-Source: ABdhPJwjZJpBs+mNtw3kV8PqGtvMFEulMgZ4EH9Yg0erK0vgMWE3kU9521CrBTgllqSUIsHhyPxbxA==
X-Received: by 2002:a05:620a:450e:b0:69c:86b2:70ff with SMTP id t14-20020a05620a450e00b0069c86b270ffmr746941qkp.62.1650064319594;
        Fri, 15 Apr 2022 16:11:59 -0700 (PDT)
Received: from bytedance (ec2-13-57-97-131.us-west-1.compute.amazonaws.com. [13.57.97.131])
        by smtp.gmail.com with ESMTPSA id v9-20020a05622a130900b002f1cff33c08sm3447977qtk.77.2022.04.15.16.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 16:11:59 -0700 (PDT)
Date:   Fri, 15 Apr 2022 16:11:55 -0700
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     =?utf-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>, yhs@fb.com,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, bpf@vger.kernel.org, shuah@kernel.org,
        ast@kernel.org, andrii@kernel.org
Subject: Re: [External] [PATCH bpf-next v2 3/3] selftests/bpf: add ipv6 vxlan
 tunnel source testcase
Message-ID: <20220415231155.GA9900@bytedance>
References: <20220322154231.55044-1-fankaixi.li@bytedance.com>
 <20220322154231.55044-4-fankaixi.li@bytedance.com>
 <20220324193755.vbtg2dvi4x3rysx2@kafai-mbp>
 <CAEEdnKFbq=TpmrXtFi8A-pPcLS-pRS2TT_726v7S52XMX6crQA@mail.gmail.com>
 <CAEEdnKH2g0gZ5y2x_1BCK1MHt6_r=_RLw18=apbwpn9+Thi7nA@mail.gmail.com>
 <20220407175333.tnmk4am3hzpfhept@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407175333.tnmk4am3hzpfhept@kafai-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Martin,

On Thu, Apr 07, 2022 at 10:53:33AM -0700, Martin KaFai Lau wrote:
> The .sh is not run by CI also.

Just curious: by "CI", did you mean libbpf-ci [1] ?

If so, why doesn't libbpf-ci run these .sh tests?  Recently we triggered
a bug (see [2]) in ip6_gre by running test_tunnel.sh.  I think it
could've been spotted much sooner if test_tunnel.sh was being run.

[1] https://github.com/libbpf/libbpf/actions/workflows/test.yml
[2] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=ab198e1d0dd8

Thanks,
Peilin Ye

