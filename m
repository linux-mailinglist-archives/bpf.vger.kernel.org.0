Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE276331AA
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 01:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiKVAzY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 19:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiKVAzE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 19:55:04 -0500
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DEDE0770
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 16:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1669078498;
        bh=g7gCIlGkU3U+jeFwrooPJAeJ9QmWHloZWrjg/6voWQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=C04sFJSOtw+OZx8TvteMhi8VwThfzDIjxiNqDcnOkb9m69pZpd8k18mdZhq5dTTzo
         uGF8QIBo0nT3/ufV8WN2mhTeXTLbHlwbxIR4br8ecvROJXjTeWxvdX+BfrfB+aIu7b
         YeB79gFCU7EMm9v4pWd6TqyRw+qhcOErxOWWZMV8=
Received: from rtoax.. ([111.199.191.46])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id DB589AA7; Tue, 22 Nov 2022 08:54:53 +0800
X-QQ-mid: xmsmtpt1669078493th1ljpq51
Message-ID: <tencent_942FB754F85E4746D310150D3084F2B22809@qq.com>
X-QQ-XMAILINFO: MiPTq5wGoKOmZeWHy0N8JLti8+/ncftsUxsvL9Q+CSLnwKZ6otErRfZneLvXXi
         hWt9HpUWMQWyPw1M/E93jM6z2POBTuKGuwFUBLVSOG98OYhoPhRlYfzriNoOJppZ0cZBHP9ndEzZ
         LC82FJGEMpEf6/1nH2Wp2aa2ZRCTgz/4lG0USZIeW99vv/mjSTkVgrdTaxz11ziO10CNM+F48qPv
         oSLV9RE4gmztVhM+CHkndbuNsh2k0btVTUe4AT/6cGYCdjqpRewW6PMuR/cpym8GvacPK7jFCSkw
         NcqyR+MHAVvXaGCd2eHdF9KUF32GtwVax+pEfv3C9q8bkMKQ0RmUS6V6hi9U92WPPgxZAqXNkXmJ
         0by2DoUt2O2SywVXWPi9M+w7XT+fmiQa5xr8t7kQUTE4kgR4i9diMTEbKgEOEoq1mPzgcFklDa9H
         N7zRG7Cn8HH7pEmEweRIka2lQs3W3W/1r82EQujQ0ks1chH1dOqdK60cLw5vRAGatos/Ph/sTiwE
         NE99l3+ayVqzb7wHK0/BU5FcgzYyXcXbLZbgTo1lBbsm7Dvm7xKhNn6jDSICJ/EBIiLz9xNfPVZV
         mg+9ZxwPUmthpOU9E1iryVEFnyKoof4dWlKdaukn8cWYlgmX+G28+eXZNPNpZfRlJ2xmykH/Z0rO
         BVRNWf9zZzTc+gRVFQKHPI/3W0juQYDM3JFQJTe8RkyOJwSIbWICgIga5utLgUVqTDqkSbaUhJCY
         9SUVITB2X7mjXxtfXY2nNPo3KI7gPkTV45FeP+jvPEcsLekeEFaE9v8ZT1MMSV64nFK+zwW/DCq5
         inZZJKa0+FgjecvknC0GdwgPID/CTvLi/T7PlaRSGRd0Bx6+a9aOmBZy6RMycphz1QbJf0Fkkll9
         XiYDw9oaUu3/NoIqFTz0KAUxVipAt1CzewPHTYscGAEDZS4CtgAmnQSwC90ZIub1Qdh/rWEJxXD8
         pIyVnKPFcfl2/tQlPBYUU+/9fStvRdesGmeSLUuPqPLAZw9hKx7Y65FWWP3BPDUGvbBBY7DIEl4N
         KW9tOfGQ==
From:   Rong Tao <rtoax@foxmail.com>
To:     void@manifault.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        corbet@lwn.net, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, song@kernel.org, yhs@fb.com
Subject: Re: Re: [PATCH bpf-next v3] docs/bpf: Update btf selftests program and add link
Date:   Tue, 22 Nov 2022 08:54:53 +0800
X-OQ-MSGID: <20221122005453.5660-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <Y3uT7KfjF3OcbjMG@maniforge.lan>
References: <Y3uT7KfjF3OcbjMG@maniforge.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks, David. I forgot to modify the case of the BPF, be sure to check
carefully next time, thanks.

Fix this problem in v4:
  https://lore.kernel.org/lkml/tencent_1FA6904156E8E599CAE4ABDBE80F22830106@qq.com/
