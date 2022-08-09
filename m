Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B98158D807
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 13:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbiHIL3K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 07:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiHIL3J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 07:29:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B893A1EEE1;
        Tue,  9 Aug 2022 04:29:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73B5EB81193;
        Tue,  9 Aug 2022 11:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986ACC433C1;
        Tue,  9 Aug 2022 11:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660044546;
        bh=DmuZgZWKA/ghLutfQxNLjCQFo328QlB4BLCnFTuaWIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XY1NVC1Iz5z4fWGVYB2Ry4mPfYCJ6bedGSPYIe/JkpB76ahE01X+QBFdzaGiFZr3x
         pVEcplRdEn4K1ZVC//Axg4Jik1KOryNi6LBJQW3yw79yjyXfgfbTXj3fgqB7ymKfS+
         7AuKv05TegHBNfqBnKea1SC4xLA80sRRP03ZCOZo=
Date:   Tue, 9 Aug 2022 13:29:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-usb@vger.kernel.org, bpf@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 0/2] USB: core: add a way to revoke access to open USB
 devices
Message-ID: <YvJE/52C2Vm+zOgb@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
 <YvI3mcXDOHzOL78r@kroah.com>
 <8ff97aaacab2fc3838290af0742a7bbf15cb0398.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff97aaacab2fc3838290af0742a7bbf15cb0398.camel@hadess.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 09, 2022 at 01:15:38PM +0200, Bastien Nocera wrote:
> Sorry, but this will probably keep happening until the tools folks have
> to use for kernel development aren't as clunky as they are now...

It's an editor, you can get them to do anything you want to do, they are
not clunky...
