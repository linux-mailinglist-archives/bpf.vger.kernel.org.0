Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCB2581CA0
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 02:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiG0AAC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 20:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiG0AAB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 20:00:01 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7B1286F9
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 16:59:59 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 674C5240108
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 01:59:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1658879997; bh=BIO+ETwAI0KIAbncYBigC90aNzZzCi4fRRah6ganCRg=;
        h=Date:From:To:Cc:Subject:From;
        b=Hu+jQR4kdtqHWxq0q/YSpE9a6MufxCYlNVnGDNlVF9DKIkqD/n3TV9dR5rxuiOyNU
         2GMySduLCoY0s/IDFYstvv+JDtwdd/3TGSZpXCDE75xbTFjVVUk0YnwsGqpGwRkHwV
         kBZ9YvC2yjnYC3mhnIZCZ1Cl1m4F6orw+5pQO7emp8hFq5CmicsjCCE6Z7N8YcBfqZ
         x20VZLjl9sBJiNooVKYqR9pOB2ZCRYrXi86b4qf2A++o8mNt/apQ+ECQ8WfutVzB6Z
         LVo3q7nJgMCYLRM054F+ObgfFpwlEtsP3a1S+QDVJ/wYUUTXEYXoEAeS4hUVBq6kRj
         ACa4t2XvAbQRQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Lsv6L6X2jz9rxG;
        Wed, 27 Jul 2022 01:59:54 +0200 (CEST)
Date:   Tue, 26 Jul 2022 23:59:51 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 0/3] Maintain selftest configuration in-tree
Message-ID: <20220726235951.exnt2tfcxe5nxo4a@nuc>
References: <20220726201126.2486635-1-deso@posteo.net>
 <42352041-E158-4440-AF7A-E07CA1E932BD@fb.com>
 <518BDA5D-DA78-4BD0-8C96-536ADCCC37AA@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <518BDA5D-DA78-4BD0-8C96-536ADCCC37AA@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 26, 2022 at 11:14:40PM +0000, Mykola Lysenko wrote:
> Hey Daniel,
> 
> While each patch in series shows v3, the cover latter subject still shows v2, although description shows v2 -> v3 changes. This also explains why CI showed v2 version in PR. Something to check in your setup.

Thanks for pointing that out. Let me resend a clean v4 with correct
cover letter (to prevent any confusion from having two v3 floating
around).

Sorry about that.

[..]

Thanks,
Daniel
