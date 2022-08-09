Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD59E58DCEF
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 19:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbiHIRQf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 9 Aug 2022 13:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242610AbiHIRQe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 13:16:34 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3A32668;
        Tue,  9 Aug 2022 10:16:33 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id B0FEC100007;
        Tue,  9 Aug 2022 17:16:29 +0000 (UTC)
Message-ID: <6f3fa6727e14f39a8c7c32fffb8c3e92cf95b5d5.camel@hadess.net>
Subject: Re: [PATCH 1/2] USB: core: add a way to revoke access to open USB
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
Date:   Tue, 09 Aug 2022 19:16:29 +0200
In-Reply-To: <YvKL79C4k7EpRaKh@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
         <20220809094300.83116-2-hadess@hadess.net> <YvI4em9fCdZgRPnY@kroah.com>
         <d2dc546d771060b0a95d663fb77158d63b75bb9b.camel@hadess.net>
         <YvJYmG/upX2NWRJJ@kroah.com>
         <b1af087bc41a47bc29a7192a5c268243ef54ad26.camel@hadess.net>
         <YvKL79C4k7EpRaKh@kroah.com>
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

On Tue, 2022-08-09 at 18:31 +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 09, 2022 at 03:27:16PM +0200, Bastien Nocera wrote:
> > The link to the user-space programme is in the "RFC v2" version of
> > the
> > patch from last week. It calls into the kernel through that
> > function
> > which is exported through BPF.
> > 
> > > 
> > > > > Again, just revoke the file descriptor, like the BSDs do for
> > > > > a
> > > > > tiny
> > > > > subset of device drivers.
> > > > > 
> > > > > This comes up ever so often, why does someone not just add
> > > > > real
> > > > > revoke(2) support to Linux to handle it if they really really
> > > > > want it
> > > > > (I
> > > > > tried a long time ago, but didn't have it in me as I had no
> > > > > real
> > > > > users
> > > > > for it...)
> > > > 
> > > > This was already explained twice,
> > > 
> > > Explained where?
> > 
> > https://www.spinics.net/lists/linux-usb/msg225448.html
> > https://www.spinics.net/lists/linux-usb/msg229753.html
> 
> Please use lore.kernel.org.

Would be great if it showed up when somebody searches for "linux-usb
mailing-list".

> Anyway, pointing to random old submissions of an RFC series does not
> mean that you do not have to document and justify this design
> decision
> in this patch submission.

I guess me repeatedly asking for guidance as to what information I
should add to the commit message while I was being yelled at didn't get
through.

> Assume that reviewers have NO knowlege of previous submissions of
> your
> patch series.  Because we usually do not, given how many changes we
> review all the time.
> 
> Please resend this, as a v4, and update the changelog descriptions
> based
> on the comments so far on this series and I will be glad to review it
> sometime after -rc1 is out, as there's nothing I can do with it right
> now.

Sure.
