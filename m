Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332F858D76E
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 12:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239907AbiHIKb6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 06:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiHIKb6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 06:31:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9500A2316F;
        Tue,  9 Aug 2022 03:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0027560F97;
        Tue,  9 Aug 2022 10:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BDFC433C1;
        Tue,  9 Aug 2022 10:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660041116;
        bh=WG6HNx5fPEM83cbBjERH0yaKplVZjzF8hr0utFyOdY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tv212bpi2NVNmXcOVPNTWUTheJEa6KvuVXewowz8UPX2beFR2ViwG6vH7NDBFuD2i
         DAgR6QqvMQ+oY4uW4Mner4c1/UF2OYTXsHE6gJJI59WQNGc2a7CEx0CWX/2itHkcMR
         aI/cJin3Mn3tbaXFOhxO6//sR6BbClLOoAxufPFA=
Date:   Tue, 9 Aug 2022 12:31:53 +0200
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
Message-ID: <YvI3mcXDOHzOL78r@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809094300.83116-1-hadess@hadess.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 09, 2022 at 11:42:58AM +0200, Bastien Nocera wrote:
> BPF list, first CC: here, I hope the commit messages are clear enough to
> understand the purpose of the patchset. If not, your comments would be
> greatly appreciated so I can make the commit messages self-explanatory.
> 
> Eric, what would be the right identifier to use for a specific user
> namespace that userspace could find out? I know the PIDs of the
> bubblewrap processes that created those user namespaces, would those be
> good enough?
> 
> Changes since v2:
> - Changed the internal API to pass a struct usb_device
> - Fixed potential busy loop in user-space when revoking access to a
>   device
> 
> Bastien Nocera (2):
>   USB: core: add a way to revoke access to open USB devices
>   usb: Implement usb_revoke() BPF function
> 
>  drivers/usb/core/devio.c | 79 ++++++++++++++++++++++++++++++++++++++--
>  drivers/usb/core/usb.c   | 51 ++++++++++++++++++++++++++
>  drivers/usb/core/usb.h   |  2 +
>  3 files changed, 128 insertions(+), 4 deletions(-)
> 
> -- 
> 2.37.1
> 

You say "changes since v2", but have no version identifier on this
series at all :(
