Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11E669BB70
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 19:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjBRSkq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Feb 2023 13:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBRSkp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Feb 2023 13:40:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C25212BE5
        for <bpf@vger.kernel.org>; Sat, 18 Feb 2023 10:40:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D636DB808BE
        for <bpf@vger.kernel.org>; Sat, 18 Feb 2023 18:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D95C433EF;
        Sat, 18 Feb 2023 18:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676745642;
        bh=GPdS2p5OxzOJUKre7+mac47zu+qGhpPPbwlcRu3rW3Q=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=CkCVMmpNNh4a5sOkAau7VjFKP9lnAF7TEswzF2JD04WiR8uJaEDLeS3HvR4M8L8CD
         T0qdg9x4apHoqRkuERdfWuk0n0Mfgk+gLQ9Ms4sdMOy9Yd2Vwfd7AAlPTw3uVGtb1F
         9VorsDB8UIFYfN1i6AUbjlWHHf6f8ATYt2pQjFo08VLaZ0px++8AZ87ZC5WwaBRHNo
         gzYWlIlM72lkU0ddlAQgYmfTFXfe7QGaEg4lsKiIezNpyT3M1A06PRyBDvGhVK5R1r
         N7mWEuE1d8k4vvEFWfVnWvzRYdXLGzL0mhb5nd6fy7YEX9twsaMQs7A1/CSLjDuatd
         TDop5TqT7Jvdw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 39856974A80; Sat, 18 Feb 2023 19:40:39 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Dropify Drop <d.dropify@gmail.com>, bpf@vger.kernel.org
Subject: Re: Removing clsact while eBPF program is still attached
In-Reply-To: <CAJxriS2Up7DrF4r9LHX+L_6X0NhP5m4sUTqGGcE5SAna+HFWLA@mail.gmail.com>
References: <CAJxriS2Up7DrF4r9LHX+L_6X0NhP5m4sUTqGGcE5SAna+HFWLA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 18 Feb 2023 19:40:39 +0100
Message-ID: <87h6viq0k8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dropify Drop <d.dropify@gmail.com> writes:

> Hi,
> I am playing around with eBPF + TC and wrote some eBPF code to
> intercept egress and ingress traffic (clsact qdisc) .
> All works great but while the eBPF program is still attached I can via
> command line remove the associated clsact qdisc (tc qdisc del dev
> <interface> clsact) and the eBPF program no longer receives the
> traffic. It is kind of expected but any root user can silently disable
> it.

Well, any root user can also down the interface or do, well, anything,
really, that's kinda the point of having root...

So, erm, don't give root access to people you don't trust not to mess up
your system? :)

-Toke
