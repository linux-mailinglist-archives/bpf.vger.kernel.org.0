Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECC152619D
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 14:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbiEMMOz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 08:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiEMMOy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 08:14:54 -0400
X-Greylist: delayed 476 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 May 2022 05:14:53 PDT
Received: from mail.0l.de (mail.0l.de [IPv6:2a09:11c0:200:101:5054:ff:fedc:4a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E722297400
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 05:14:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC0EC2019A0F
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 14:06:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=dkim; t=1652443613; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding; bh=9P/Rk4f/QTFMYC3uJIsfd3XaA4oLvJ9Gll21n0wgyXo=;
        b=KBkmqcLb1QbQk7FoXA4fY1KEY0FCyJ2zW5kWi8nrG3XwpeZyZYPyCJgEBpBtx2f/950cI3
        r8S15FgvuzkQLIdYc8AzPJkoq8zBGMlXVyJwX771SRAyDj+S6mZVMGXfDVNLbncK+uYCQ+
        urVzBxZx/rkJ796pBB2VomBBS3HRP4GuqyA8CqF5rIj7UAvhX2zTIBizGnjBRjAZSep3XZ
        +sqo64FUOCqt0MnzBrKUC7uRXbaIVP5YEzgq4iFeFyImjhifNdH6a6Drr+VHUxJHqFsBUe
        mm4nS2/jLOHVAR3loe7wE/V3C5Jg0AtU26b4giIc+s8OTUwU14DjD93dmOIpdQ==
User-Agent: Microsoft-MacOutlook/16.60.22041000
Date:   Fri, 13 May 2022 14:06:51 +0200
Subject: bpf_skb_adjust_room after L4 header?
From:   Steffen Vogel <post@steffenvogel.de>
To:     <bpf@vger.kernel.org>
Message-ID: <0150AA03-5A27-4AF4-8E59-A8AD7494CA0E@steffenvogel.de>
Thread-Topic: bpf_skb_adjust_room after L4 header?
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I am currently facing a checksums issue when attempting to insert a custom 4 Byte header between a L4/UDP header and the payload using a TC BPF egress filter.
The goal is to use an eBPF program to transparently push/pop a TURN ChannelData message header from the UDP payload [1].

So far, I have tried to accomplish this with the bpf_skb_adjust_room(..., BPF_ADJ_ROOM_NET) helper by adding some room between after the IP header and manually shifting the UDP header to the newly gained space.

This works when TX checksum offloading is disabled. However, with TX checksum offloading the skb->transport_header is wrong as it has not been adjusted. This also causes to skb->csum_offset to point to the wrong place. 

I guess ideally, we would extend bpf_skb_adjust_room with a new flag value BPF_ADJ_ROOM_TRANSPORT?

XDP is not an option as we also need the eBPF to process the egress path.
Maybe the helpers bpf_skb_change_{head,tail}() might work? But I am concerned about the performance impact caused by a memmove() of the UDP payload just for making new space in the front of the payload.

Or are there any other ways of pushing a header between the L4 header and its payload while properly adjusting the header offsets in the SKB?

Best regards,
Steffen

[1] https://datatracker.ietf.org/doc/html/rfc8656#section-12.4

The problem has also been covered here: https://github.com/cilium/ebpf/issues/339
And there is also feature request for the coturn TURN server: https://github.com/coturn/coturn/issues/759



