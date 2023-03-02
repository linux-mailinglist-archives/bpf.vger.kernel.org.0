Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69986A87EF
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 18:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCBRcR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 12:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjCBRcQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 12:32:16 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4124125A6
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 09:32:15 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id z2so18310455plf.12
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 09:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677778335;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMK/pDXz+E7PRGYljWORBZUeAjAOpLANtXUVqZkzxkw=;
        b=GWYiLLPK3vcPIC4KGhgUqhwQcijMiygaldlw2hYrwp012ZztmmGuCGB1500bKtz7KF
         mcXuXv0J9iiKS8nNiPjWaV9eCcGKsxf4r8wF6bVRb4CixQV59Oi/gE4D3M2+fJM0Fk6P
         GPyDS4PU0kfSmgUWl2679ukg7PajwsF6XMlGJ/o7QxenyksfVoHuS8lw8ReWdvG7IpLu
         JA0I6c7iamD0aCZrun7RpB/tnSsUjvqIYTJJJw+5PQ14O9NWBQra08PDlynWRznOZUzq
         4Thu+pHmanVG1tRsJx6UcLiXblW9kLwDR2wp8hwx3cFF8GYzpfc10wdEcZt/pPtmtz26
         NLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677778335;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMK/pDXz+E7PRGYljWORBZUeAjAOpLANtXUVqZkzxkw=;
        b=Ch6nf1EGHMjoMLMQM0nRmYOV1tOwr6PydN4+2avXPeowB8ZITLQUG9F307+NWDaAvH
         HSimRpOhA+go1kAU6n3PLh7J4l/6tv4ECnBXc3PV10oTrDqjDsy/iFM41rhLeX9h0pyt
         Rl/Vt0gV12HIpBIVfzgaWNVH772yDIPQEzJaub+ButPz5XXtq+PlQwBItFAKYHVIQ9kI
         TcFbveuO5PkCzorqGnUUXaLTkSF8mGobrLcM3wn/ndo1ROak3gDCDeBPUCSUSK/I0F/t
         6hc3tEVIHg6q67GzNEXbV36XylO97XEUkGC6E4LRHNFavRaBxos2FwE6rZ/zGuf/2vro
         omyA==
X-Gm-Message-State: AO0yUKUWkrbjh/WxBchd4ykOXFdgcu0YJ9tYHgQrdOjjnkUTLFUQin5H
        YrT9/N1ZRfJrNJ3CcA9hNZ05D356ib0=
X-Google-Smtp-Source: AK7set/1W6F4YZzWhPakKXbohXJBh6+uo7f/QyxZfteef7tVAYsvuqTYZw8kUpJwIwLudgp3z4FxCg==
X-Received: by 2002:a17:902:a511:b0:19c:eb50:88b9 with SMTP id s17-20020a170902a51100b0019ceb5088b9mr9798447plq.29.1677778334908;
        Thu, 02 Mar 2023 09:32:14 -0800 (PST)
Received: from worktop ([2620:10d:c090:500::5:c1fd])
        by smtp.gmail.com with ESMTPSA id p19-20020a1709028a9300b0019cec7d88c3sm10697258plo.236.2023.03.02.09.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 09:32:14 -0800 (PST)
Date:   Thu, 2 Mar 2023 09:32:00 -0800
From:   Manu Bretelle <chantr4@gmail.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] BPF CI: A year later
Message-ID: <ZADdkKaGcEmjC0tF@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Last year, Mykola Lysenko presented how BPF CI [0] works ([1][2]). This year we
would like to go over what has happened behind the BPF CI system curtains, what
improvements were made, what issues were encountered, and which pain points we
are still battling with.

We would also like to take the opportunity to close the talk with an interactive
demo for the audience to run a change that goes through the BPF CI [3] so people
can benefit from a multi-arch environment to validate their changes before
submitting it to the mailing list.

Finally, we would like to hear feedback from the audience to better understand
what are contributors challenges with regards to testing, as well as probably
find overlapping areas (vmtest [4] anyone?) where we could benefit from better
cooperation.

Thanks,

Manu

[0] https://github.com/kernel-patches/bpf
[1] https://youtu.be/CkM_HZ--vkI
[2] https://docs.google.com/presentation/d/1RQZjLkbXmSFOr_4Sj5BdQsXbUh_vMshXi7w09pUpWsY/edit#slide=id.p
[3] https://www.kernel.org/doc/html/latest/bpf/bpf_devel_QA.html#q-how-do-i-run-bpf-ci-on-my-changes-before-sending-them-out-for-review
[4] https://lore.kernel.org/bpf/f1ea109c-5f07-4734-83f5-12c4252fa5ae@app.fastmail.com/T/#t
