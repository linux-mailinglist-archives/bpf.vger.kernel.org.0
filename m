Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335D358D7E5
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 13:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbiHILP4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 9 Aug 2022 07:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiHILPz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 07:15:55 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D828193C2;
        Tue,  9 Aug 2022 04:15:54 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 0497840002;
        Tue,  9 Aug 2022 11:15:50 +0000 (UTC)
Message-ID: <8512a37ce2e54f2c44a4fe10b475d61334498c4f.camel@hadess.net>
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
Date:   Tue, 09 Aug 2022 13:15:50 +0200
In-Reply-To: <YvI3rUTs/axBANHm@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
         <20220809094300.83116-2-hadess@hadess.net> <YvI3rUTs/axBANHm@kroah.com>
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

On Tue, 2022-08-09 at 12:32 +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 09, 2022 at 11:42:59AM +0200, Bastien Nocera wrote:
> > There is a need for userspace applications to open USB devices
> > directly,
> > for all the USB devices without a kernel-level class driver[1], and
> > implemented in user-space.
> > 
> > As not all devices are built equal, we want to be able to revoke
> > access to those devices whether it's because the user isn't at the
> > console anymore, or because the web browser, or sandbox doesn't
> > want
> > to allow access to that device.
> > 
> > This commit implements the internal API used to revoke access to
> > USB
> > devices, given either bus and device numbers, or/and a user's
> > effective UID.
> > 
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > 
> > [1]:
> > Non exhaustive list of devices and device types that need raw USB
> > access:
> > - all manners of single-board computers and programmable chips and
> > devices (avrdude, STLink, sunxi bootloader, flashrom, etc.)
> > - 3D printers
> > - scanners
> > - LCD "displays"
> > - user-space webcam and still cameras
> > - game controllers
> > - video/audio capture devices
> > - sensors
> > - software-defined radios
> > - DJ/music equipment
> > - protocol analysers
> > - Rio 500 music player
> 
> We can't take "footnotes" after a signed-off-by line, you know this
> :(

Where would I know this from?

checkpatch.pl doesn't warn about it.


