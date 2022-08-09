Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F51258D76F
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 12:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiHIKcR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 06:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbiHIKcR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 06:32:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED8722BDD;
        Tue,  9 Aug 2022 03:32:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A17A60F74;
        Tue,  9 Aug 2022 10:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660D2C433D6;
        Tue,  9 Aug 2022 10:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660041135;
        bh=JWmw+cqaXhGSm4QfvzpKOvnCaTd0Um5gyOr1cBdz3ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iw5L9w/PMw3pQAoywpMdJxkcZd8mr0QO7HqNcNzcLPsy6MXn3+Tsm1AODi/INfKvb
         XY0YOcQo5zIlBwR6Aln/lm8rDk2o6Lu6XG45l18MRTl6NNl8/UsNgv6GecDFu/Z9pq
         juuHdsO/X/mBa107okiKxs+Zc2T4RxprBbmXPekk=
Date:   Tue, 9 Aug 2022 12:32:13 +0200
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
Subject: Re: [PATCH 1/2] USB: core: add a way to revoke access to open USB
 devices
Message-ID: <YvI3rUTs/axBANHm@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
 <20220809094300.83116-2-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809094300.83116-2-hadess@hadess.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 09, 2022 at 11:42:59AM +0200, Bastien Nocera wrote:
> There is a need for userspace applications to open USB devices directly,
> for all the USB devices without a kernel-level class driver[1], and
> implemented in user-space.
> 
> As not all devices are built equal, we want to be able to revoke
> access to those devices whether it's because the user isn't at the
> console anymore, or because the web browser, or sandbox doesn't want
> to allow access to that device.
> 
> This commit implements the internal API used to revoke access to USB
> devices, given either bus and device numbers, or/and a user's
> effective UID.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> 
> [1]:
> Non exhaustive list of devices and device types that need raw USB access:
> - all manners of single-board computers and programmable chips and
> devices (avrdude, STLink, sunxi bootloader, flashrom, etc.)
> - 3D printers
> - scanners
> - LCD "displays"
> - user-space webcam and still cameras
> - game controllers
> - video/audio capture devices
> - sensors
> - software-defined radios
> - DJ/music equipment
> - protocol analysers
> - Rio 500 music player

We can't take "footnotes" after a signed-off-by line, you know this :(

