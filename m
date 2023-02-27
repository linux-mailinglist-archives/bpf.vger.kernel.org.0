Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302FB6A4AF0
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 20:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjB0TfF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 14:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjB0TfF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 14:35:05 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EBAF5
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 11:35:02 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 367DF24061D
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 20:35:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1677526501; bh=g+js4Y3CfJE7XaOr4fnuwQUqMnOX0urciKfmp8v7CHY=;
        h=Date:From:To:Cc:Subject:From;
        b=GAzws22AQfABnqLhBj1IDB1yxs4qXY9C7kFj+uHwn3ZUnaeu4Ji4h6l+18zD6JqNm
         feR98Coy3n1waCAojMpKICYc5QPoO/0LMBTlPEEqBGW70wk4d9xBVuyR0VjycoTgEv
         yvt5PSWwoQ6di2uKft2PRQjxb64uIGc8Z6HudOt/3puxKyvUz6KR2gk4a1TRNMP9+O
         8dItPOwkF0FIYihLC58UwZv7PrwZv5mV2jnzSnZUmlrnJwyTkppwhd2HFHU38dpDgC
         FUpn7OfuLNGTD4IjdJXpnhyKcyoLZwki5J/I7EUfBbfN/2ixvg29AsSVTINiV1DgMi
         jDb0hb5revxxw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PQW0z6FSrz9rxB;
        Mon, 27 Feb 2023 20:34:59 +0100 (CET)
Date:   Mon, 27 Feb 2023 19:34:56 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Batteries-included symbolization with blazesym
Message-ID: <20230227193456.jbxt3mba6xfntieu@muellerd-fedora-PC2BDTX9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Symbolization of addresses is a commonly encountered problem, maybe most so in
the context of BPF and tracing with the capturing of stack traces. Perhaps
superficially straightforward-looking, there a variety of considerations and
intricacies, such as:
- different formats/standards (e.g., ELF symbol information, DWARF, GSYM) cater
  to different use cases and require vastly different steps to work with
  - on top of that, even if a library such as libelf or libdwarf is relied on,
    plenty of format specific details need to be known to symbolize addresses
    properly
- discovery of symbolization sources (e.g., DWARF debug files)
- symbolization trade-offs (performance, memory usage)
- system-specific details and corner cases

We are working on blazesym [0], a library that aims to provide users with a
batteries-included experience for symbolizing addresses (but also the reverse:
mapping symbols to addresses).

We would like to provide a brief overview of the library and its goals and then
open up for discussion. Some topics we are specifically interested in
understanding better:
- What are current issues with symbolization that would be great to support?
- Does the usage of Rust pose a problem in your context? (C bindings are
  available, but a Rust toolchain is required for building; are pre-built
  binaries and packages for common distributions sufficient for your use cases?)

In general, we'd be interested in hearing your use cases and in discussing
whether blazesym is a fit or could be made to work.

Thanks,
Daniel

[0] https://github.com/libbpf/blazesym
