Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB8A15F9CA
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2020 23:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgBNWdJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Feb 2020 17:33:09 -0500
Received: from www62.your-server.de ([213.133.104.62]:58672 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgBNWdJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Feb 2020 17:33:09 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1j2jWF-00052V-76; Fri, 14 Feb 2020 23:33:07 +0100
Received: from [85.7.42.192] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1j2jWF-0005Sh-25; Fri, 14 Feb 2020 23:33:07 +0100
To:     bpf@vger.kernel.org
Cc:     lsf-pc@lists.linux-foundation.org
From:   Daniel Borkmann <daniel@iogearbox.net>
Subject: [LSF/MM/BPF] BPF: various topics
Message-ID: <853944be-2700-6a65-597f-9971707a3a47@iogearbox.net>
Date:   Fri, 14 Feb 2020 23:33:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.1/25723/Fri Feb 14 13:01:55 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'd like to propose various BPF core and networking related topics some of which we
also encountered during Cilium development, for example, during our recent BPF
kube-proxy replacement work:

- Cilium uses BPF cgroups programs for its Kubernetes Service implementation
   in order to select backends and directly connect to them instead of later
   having to perform NAT on the skb itself in lower layers. BPF cgroups hooks
   are not network namespace aware while Kubernetes pods are heavily built
   around network namespaces. In addition to getting BPF cgroups netns aware,
   I'd like to discuss various other needs Cilium has around its BPF cgroups
   usage in order to fix some short-comings we're facing today including
   the addition of new hooks.
- Another issue is the BPF fib lookup helper use in combination with our BPF
   based NodePort implementation, where goal is to discuss design proposals to
   enable the Cilium agent to push L3 addresses into the kernel for its backends
   and have the neighboring subsystem self-manage & maintain their resolution.
- Third topic is to discuss a BPF-based static keys proposal in order to
   dynamically allow to enable/disable functionality at runtime with very low
   overhead and without reloading programs through the verifier. This builds upon
   recent work that has been done around direct jumps for optimizing tail calls.
- Some of the LRU based maps in Cilium have interdependencies; currently, we
   use a band-aid through the means of a garbage collector in order to evict
   data from multiple maps, but what is needed is a LRU eviction callback that
   we can make use of in order to trigger deletion events in dependent maps.
   We'll discuss possible API options on how this could be addressed generically.

Thanks,
Daniel
