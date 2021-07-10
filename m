Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A3A3C3600
	for <lists+bpf@lfdr.de>; Sat, 10 Jul 2021 20:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhGJSId (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Jul 2021 14:08:33 -0400
Received: from mx1.riseup.net ([198.252.153.129]:50774 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhGJSId (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Jul 2021 14:08:33 -0400
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4GMdHb3vwnzDrhZ;
        Sat, 10 Jul 2021 11:05:47 -0700 (PDT)
X-Riseup-User-ID: 027C2E7FA9882A576F4230443E21B48C75A0196E4E75127C55D378DB13D2B2AC
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4GMdHZ5B8hz5vYk;
        Sat, 10 Jul 2021 11:05:46 -0700 (PDT)
To:     aarcange@redhat.com
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
From:   Jim Newsome <jnewsome@torproject.org>
Organization: The Tor Project, Inc
In-Reply-To: <20201104215702.GG24993@redhat.com>
Subject: Re: RFC: default to spec_store_bypass_disable=prctl
 spectre_v2_user=prctl
Message-ID: <55e3ba77-a305-8abb-1506-5a8aabe24bf3@torproject.org>
Date:   Sat, 10 Jul 2021 13:05:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Is anything happening with this proposal? Is there anything I could do 
to help it along?

My personal motivation is that I'm involved in developing and using the 
[Shadow] simulator, which we use to run hours and days long simulations. 
We're currently looking into running some simulations in gitlab CI 
Docker runner to take advantage of shared hardware, but Docker currently 
doesn't expose a way to opt out of these mitigations without turning off 
seccomp altogether [Docker FR].

I've measured these mitigations to cause simulations to take 50% longer 
[Overhead], so I'm pretty motivated to find a way to disable them :).

[Shadow]: https://shadow.github.io/
[Docker FR]: https://github.com/moby/moby/issues/42619
[Overhead]: 
https://github.com/shadow/shadow/issues/1489#issuecomment-871445482

P.S. Attempting to respond to a thread without actually being subscribed 
to the list; sorry if this ends up not threading correctly. The CC 
header was truncated so also some original recipients have been dropped. 
Original thread: https://lkml.org/lkml/2020/11/4/1135
