Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553EC60E3F4
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 17:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiJZPAo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 26 Oct 2022 11:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbiJZPAn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 11:00:43 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4946D4E41F;
        Wed, 26 Oct 2022 08:00:41 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 7415424000D;
        Wed, 26 Oct 2022 15:00:36 +0000 (UTC)
Message-ID: <48c37b1286e42eb5ee9308e74d7337950261ae7c.camel@hadess.net>
Subject: Re: [PATCH 2/2] usb: Implement usb_revoke() BPF function
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-usb@vger.kernel.org, bpf@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Date:   Wed, 26 Oct 2022 17:00:35 +0200
In-Reply-To: <20220809094300.83116-3-hadess@hadess.net>
References: <20220809094300.83116-1-hadess@hadess.net>
         <20220809094300.83116-3-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.0 (3.46.0-2.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey,

On Tue, 2022-08-09 at 11:43 +0200, Bastien Nocera wrote:
> This functionality allows a sufficiently privileged user-space
> process
> to upload a BPF programme that will call to usb_revoke_device() as if
> it were a kernel API.
> 
> This functionality will be used by logind to revoke access to devices
> on
> fast user-switching to start with.
> 
> logind, and other session management software, does not have access
> to
> the file descriptor used by the application so other identifiers
> are used.

Locally, I have a newer version of the code that I've been able to test
successfully on some hardware, but I haven't been able to cover all of
its branches.

So I've started writing some test application that would create devices
with multiple interfaces using dummy_hcd, and client software that
talks to those fake devices. I also have a version of the revoke tool.

My question is about all the dependencies that those test tools could
use, and where to host it.

- Can I use libusb?
- Can I use libusbgx and raw-gadget?
- Can I use the GLib versions of those libraries?
- Do I need to have those tests as part of the kernel?
- Does it need to integrate with the kernel's compilation?
- Can I use a Makefile? meson?

Ultimately, only the revoke tool might have a use as a general purpose
debugging application, with the functionality being integrated in
systemd and co.

Opinions?


