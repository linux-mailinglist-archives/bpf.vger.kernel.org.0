Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED36158D95A
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 15:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242262AbiHIN1a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 9 Aug 2022 09:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiHIN1a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 09:27:30 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E7BD129;
        Tue,  9 Aug 2022 06:27:28 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 35A3440005;
        Tue,  9 Aug 2022 13:27:25 +0000 (UTC)
Message-ID: <76880696185016358ff310acff7c237e43f2e451.camel@hadess.net>
Subject: Re: [PATCH 2/2] usb: Implement usb_revoke() BPF function
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
Date:   Tue, 09 Aug 2022 15:27:24 +0200
In-Reply-To: <YvJX8GS3+msFKjjV@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
         <20220809094300.83116-3-hadess@hadess.net> <YvI5DJnOjhJbNnNO@kroah.com>
         <7cedc4e3a91a520c0c9f5dc65d84d3a0fffed67a.camel@hadess.net>
         <YvJX8GS3+msFKjjV@kroah.com>
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

On Tue, 2022-08-09 at 14:49 +0200, Greg Kroah-Hartman wrote:

<snip>
> And forcibly closing the file descriptor is the goal here I thought. 
> If
> not, I have no idea what this is for at all, sorry.

See c7dc65737c9a607d3e6f8478659876074ad129b8

It was mentioned in the first email I sent about this feature I wanted
to work on:
https://www.spinics.net/lists/linux-usb/msg225448.html

Which I did mention on the v2 I sent a couple of days ago:
https://www.spinics.net/lists/linux-usb/msg229753.html
