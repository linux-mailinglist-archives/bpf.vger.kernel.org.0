Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E53058D7E3
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 13:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiHILPp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 9 Aug 2022 07:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237249AbiHILPn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 07:15:43 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754FC1929A;
        Tue,  9 Aug 2022 04:15:42 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 8DCFA200009;
        Tue,  9 Aug 2022 11:15:38 +0000 (UTC)
Message-ID: <8ff97aaacab2fc3838290af0742a7bbf15cb0398.camel@hadess.net>
Subject: Re: [PATCH 0/2] USB: core: add a way to revoke access to open USB
 devices
From:   Bastien Nocera <hadess@hadess.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, bpf@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Date:   Tue, 09 Aug 2022 13:15:38 +0200
In-Reply-To: <YvI3mcXDOHzOL78r@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
         <YvI3mcXDOHzOL78r@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-08-09 at 12:31 +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 09, 2022 at 11:42:58AM +0200, Bastien Nocera wrote:
> > BPF list, first CC: here, I hope the commit messages are clear
> > enough to
> > understand the purpose of the patchset. If not, your comments would
> > be
> > greatly appreciated so I can make the commit messages self-
> > explanatory.
> > 
> > Eric, what would be the right identifier to use for a specific user
> > namespace that userspace could find out? I know the PIDs of the
> > bubblewrap processes that created those user namespaces, would
> > those be
> > good enough?
> > 
> > Changes since v2:
> > - Changed the internal API to pass a struct usb_device
> > - Fixed potential busy loop in user-space when revoking access to a
> >   device
> > 
> > Bastien Nocera (2):
> >   USB: core: add a way to revoke access to open USB devices
> >   usb: Implement usb_revoke() BPF function
> > 
> >  drivers/usb/core/devio.c | 79
> > ++++++++++++++++++++++++++++++++++++++--
> >  drivers/usb/core/usb.c   | 51 ++++++++++++++++++++++++++
> >  drivers/usb/core/usb.h   |  2 +
> >  3 files changed, 128 insertions(+), 4 deletions(-)
> > 
> > -- 
> > 2.37.1
> > 
> 
> You say "changes since v2", but have no version identifier on this
> series at all :(

It was sent as "RFC v2" under the same name. This is v3.

Sorry, but this will probably keep happening until the tools folks have
to use for kernel development aren't as clunky as they are now...
