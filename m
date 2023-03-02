Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582166A8C0B
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 23:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCBWlq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 17:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCBWlp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 17:41:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29C94DBFA;
        Thu,  2 Mar 2023 14:41:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71576B815BE;
        Thu,  2 Mar 2023 22:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA6EC433D2;
        Thu,  2 Mar 2023 22:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677796902;
        bh=k+dmwZ9Bw8n3y0H0GmPQ1j/if3pOfwJU4LNQW1GU9OA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KQwvCz75KjAWBgGL3mu00pfCyOEkbGeW3ixZwTbX+x+n5LDkX0p5yTdJOTJAWdw17
         mnzB+6gETRsP74nfbsnSy1VR4kpbJZw4tBCh3Dw1WVml/onYvW5wG03RvfFT+docHN
         04kycytHLVFrT3yzuK6Q97haEgZziWsPeCDCA6Wli+qEphPPRfY9aWLlSP1eiSX2/c
         cwVH9aswxni3YAHDfJI12YAXnfQ+Ejr+fK8HE2r4U7kO+11DpKmR09ciezt7yhaPRg
         yX8XNt0znXwz5XvitAb5k64T+XvVJGieaoIEFeRgqlKBEc9GEo0VDaD7+RjMlAMuis
         f4qowfjQQtfIQ==
Date:   Thu, 2 Mar 2023 14:41:40 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: splat in ikheaders_read (bpftrace)
Message-ID: <20230302144140.7a1ca7d3@kernel.org>
In-Reply-To: <64012596.170a0220.1940.0a34@mx.google.com>
References: <20230302112130.6e402a98@kernel.org>
        <22EA7360-E2FC-4A23-BF0B-EFDE523F9605@kernel.org>
        <20230302140814.294aece0@kernel.org>
        <20230302141231.2c0a3761@kernel.org>
        <64012596.170a0220.1940.0a34@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2 Mar 2023 14:39:17 -0800 Kees Cook wrote:
> I've improved the reporting, and yeah, it's due to the declaration:
> 
>   memcpy: detected buffer overflow: 4096 byte read from buffer of size 1
> 
> But that's an easy fix -- this has been done in lots of other places. It
> needs to be an array, not a single char. (I'm surprised we hadn't seen
> this before.)

LGTM, feel free to add my Tested-by, if that matters :)
Thanks!
