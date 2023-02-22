Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAAA69FFC6
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 00:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjBVXus (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 18:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjBVXus (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 18:50:48 -0500
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E504B4391C
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 15:50:44 -0800 (PST)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
        by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jemarch@gnu.org>)
        id 1pUysk-0004bL-HS; Wed, 22 Feb 2023 18:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
        s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
        From; bh=OhS+n+OGKJezXp3AX5WtYLrikrN8NzV36asHq1geXWw=; b=g0dM62TMpUhsLWFTipr7
        qeb0jP1KNbmXHEmh5Zc1YIvJvDWE/v8s5Z9p4A1dT5WYN4BSXrDeAGniYo1YBgZhsvVLeQqXO2G8f
        3msnMlRVjN4YHwe9UzALJ8oHcz7aX0+naZqAkC4Z4ES6mzZFGb4SDV0n2cwd5bu5rStmn453d9W+y
        +2gd+A/ReVWqRi2Qt1/YdtSxJX400vDUWB5XKI/aVLALB1izXdo95Af9dTr7ZoJxXRUr828MCXaV3
        NNA9Zn7E4jO2yBFKPf9J3sXQGdr0eqPa+nRcxRUNNpwW+c4kAAWHQua/3UML2iFqrnCFZy15nAHkJ
        EAQOSI1xifnJTQ==;
Received: from [77.189.64.242] (helo=termi)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jemarch@gnu.org>)
        id 1pUysk-0007A9-2a; Wed, 22 Feb 2023 18:50:42 -0500
From:   "Jose E. Marchesi" <jemarch@gnu.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Thaler <dthaler@microsoft.com>,
        Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
        bpf <bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>,
        David Vernet <void@manifault.com>
Subject: Re: [Bpf] [PATCH bpf-next v3] bpf, docs: Explain helper functions
In-Reply-To: <CAADnVQL+6i7DRsE9kVdEwQ00ciB95FceRYv4DYdwEMF1HUif9A@mail.gmail.com>
        (Alexei Starovoitov's message of "Wed, 22 Feb 2023 14:43:45 -0800")
References: <20230220225228.2129-1-dthaler1968@googlemail.com>
        <CAADnVQJHvFCTq-fWiore4iL9MV7CicDt=Tn697ZU3QMu-wWxeA@mail.gmail.com>
        <PH7PR21MB38786142836F214747C82A92A3AA9@PH7PR21MB3878.namprd21.prod.outlook.com>
        <CAADnVQL+6i7DRsE9kVdEwQ00ciB95FceRYv4DYdwEMF1HUif9A@mail.gmail.com>
Date:   Thu, 23 Feb 2023 00:50:30 +0100
Message-ID: <87ilftw989.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> BPF psABI should look like:
> https://raw.githubusercontent.com/wiki/hjl-tools/x86-psABI/x86-64-psABI-1.0.pdf

LaTeX sources: https://gitlab.com/x86-psABIs/x86-64-ABI
