Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DB450E53E
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 18:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243239AbiDYQNm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 12:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240524AbiDYQNj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 12:13:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284B741FAE
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 09:10:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso12811503wme.5
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=3XDMcq+0fpMzep7G5LNuFm+wNoXj+cb40n5L8nOL/yc=;
        b=O5wOaDXPw/nP6ndZN4jmEw5CfrzTjsBnevTmGRylWAiCmzMrOKqbHB+elG/aZJ77SC
         pT88De9bCqiDtZhRp9Wo4TBvdrrjLaFpTkwfvEyHuLzqA3JjQ0Egm3UXW+nBlqJcrCtz
         4oj14SGVRkMpxlJqOzAOdyur00K27ojtfiU0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=3XDMcq+0fpMzep7G5LNuFm+wNoXj+cb40n5L8nOL/yc=;
        b=Z/1IU1rE1xk+CQ/BGIiZ44CxshYPyEKulceKj/eO2Wu4bSaZnfSqGzkNQ+USyQLCDT
         mcIpNDYr8m6tIeXzoNAjLLtIyfdx2RFr72C6IgBHmO7HNIuSeNMmKJSwaJ4snXImSwKx
         c4DZM6QwZq6qc8ekT8N/rM0dIYj6PloCLrXIAN8grceUFlXAzAPQv6771p8Pr0Y2RJdK
         +uAnwSxUSB6l8F3eRmKc7zY3EquqdT6ihkBsn1QqBtKCtJGV1eKU4oI5mx8mg+OHtwpc
         CfwAKPmSS0FpAbZMplX1N5eAHFWrQBTGWLIEUiUqVSWSyDTQb1lqdCD31vEVp+pQT7iX
         V7Xw==
X-Gm-Message-State: AOAM531u6lf56pBzJn1Opj3cJZKEPMHgYEbOTCidFqXLenAT3R1a2JjH
        VXEzBsXjCzntBqNmn9dhQXUwFA==
X-Google-Smtp-Source: ABdhPJzkndurt2JOSMJgx5YGGSLBJkzh+Q3vlf2zQdGIaAs8/lTEfazHFcSZHore16GW9xcDLQuF0A==
X-Received: by 2002:a05:600c:4f08:b0:391:fe3c:40e6 with SMTP id l8-20020a05600c4f0800b00391fe3c40e6mr26484058wmq.34.1650903033615;
        Mon, 25 Apr 2022 09:10:33 -0700 (PDT)
Received: from cloudflare.com (79.184.126.143.ipv4.supernova.orange.pl. [79.184.126.143])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e5ca446bcsm12064035wmp.5.2022.04.25.09.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:10:33 -0700 (PDT)
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
 <20211201181040.23337-6-alexei.starovoitov@gmail.com>
 <87sfq8f0ex.fsf@cloudflare.com>
 <CAEf4BzbT4vQBnZzdD00SuPCDkeb4Cm=F6PLUoO_3X93UQD5hbQ@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH v5 bpf-next 05/17] bpf: Pass a set of bpf_core_relo-s to
 prog_load command.
Date:   Mon, 25 Apr 2022 18:09:16 +0200
In-reply-to: <CAEf4BzbT4vQBnZzdD00SuPCDkeb4Cm=F6PLUoO_3X93UQD5hbQ@mail.gmail.com>
Message-ID: <87levt6t53.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 20, 2022 at 09:50 AM -07, Andrii Nakryiko wrote:
> bpf_attr is supposed to be zeroed out with memset(), so that hole
> should have zero even before core_relo_cnt was added

Thanks for clarifying. Didn't realize this was the contract.

Thought it was worth adding to the bpf(2) man page:

https://lore.kernel.org/linux-man/20220425160803.114851-1-jakub@cloudflare.com/
