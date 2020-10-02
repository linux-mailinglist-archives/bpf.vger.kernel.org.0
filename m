Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAF028175A
	for <lists+bpf@lfdr.de>; Fri,  2 Oct 2020 18:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbgJBQDJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Oct 2020 12:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387807AbgJBQDJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 12:03:09 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83489C0613D0
        for <bpf@vger.kernel.org>; Fri,  2 Oct 2020 09:03:09 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id t11so1291669pgu.22
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2020 09:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=E4Qed5f4PPfa2+kwFerLIwM88C8GTQsQcm2i22EJA4A=;
        b=Yc+fr9v7mG39Fn2HJU9HJi+x/gdUsYaExTEbtLbErBt2vFh/lx6Wsj+XXUu8qYZaDf
         bHCq2hT6zGCmK+02+zKdgw2Ib0O8GICqusuWcFvgA7EEXd3YbhRBE+O6zpqj5sLTLQAZ
         G4GQyQF9Rxqb7J0EE3jVzdPOXqCP2HV0GySdKpCmRkmpLLbf2aCuDrolIgTwKAUnmMRQ
         8fvxYzrjb803aMs6+wIqAcmUtDKy40t1LAO4T0RYIQn4R/hzSKhnOfjAPFfXAQM7+5+9
         FyxtMRttXbW8ctwixhqcxiRORdUN6MZe7Bff008WZXiG4DC5uEnb7aExd9mOdz6mSqYx
         QwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E4Qed5f4PPfa2+kwFerLIwM88C8GTQsQcm2i22EJA4A=;
        b=ai1Ej9fZpuXH07nE2ojbSNMjTSrllwE1eFiKfUGDOgKoqirApzZ4JaAYFSBSb7wL7t
         w2vc3/za9TAHfMhtSAWz+HJkiMBYq1TIFGM4/Av/oC7qHfSz0jxP1Y33clTs+q7ulH8k
         nvzSprloHC58U3HaEumqMVAZZXZNazsZB/ufhhRHn7ohkU2W959lImDISiAQXnolisWg
         tmXiyIIApCaGH+oSmjFYYOahgZ50ShY2rLzmgaieDfXI1nBAsebZzNgDbxtw7z8pilRY
         9JQXpv8+//G1ydrQF2tCAr/x/0w3OVMQ2l1bs8kZI2uryYqEVXBPZUkMkZyZJYXC7tWL
         Y2zg==
X-Gm-Message-State: AOAM530gWC5uUpiuI8RQMw/mpBFJNQGmzV+FhrSRg908V7vdvqsoGf+G
        FgngKg3KFYLUQhcdCKm51TjZ1Ko=
X-Google-Smtp-Source: ABdhPJzWIGXQ2gCrOYJlvG1/+1R/2hixN85sq06CdYv+tiJNXM6h50KKasSBJolZz4XTOdvN9rZX5ko=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a17:90b:4a4b:: with SMTP id
 lb11mr3331428pjb.111.1601654588631; Fri, 02 Oct 2020 09:03:08 -0700 (PDT)
Date:   Fri, 2 Oct 2020 09:03:06 -0700
In-Reply-To: <20201002013442.2541568-1-kafai@fb.com>
Message-Id: <20201002160306.GB1856340@google.com>
Mime-Version: 1.0
References: <20201002013442.2541568-1-kafai@fb.com>
Subject: Re: [PATCH bpf-next 0/2] Do not limit cb_flags when creating child sk
 from listen sk
From:   sdf@google.com
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/01, Martin KaFai Lau wrote:
> This set fixes an issue that the bpf_skops_init_child() unnecessarily
> limited the child sk from inheriting all bpf_sock_ops_cb_flags
> of the listen sk.  It also adds a test to check that.
Thank you, that fixed it for me!

Tested-by: Stanislav Fomichev <sdf@google.com>
