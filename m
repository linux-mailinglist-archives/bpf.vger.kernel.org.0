Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665B720F7B9
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 16:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgF3O4j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 10:56:39 -0400
Received: from www62.your-server.de ([213.133.104.62]:37070 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgF3O4j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 10:56:39 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jqHgb-0005vi-Qz; Tue, 30 Jun 2020 16:56:37 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jqHgb-0004VV-Mf; Tue, 30 Jun 2020 16:56:37 +0200
Subject: Re: BUG: kernel NULL pointer dereference in
 __cgroup_bpf_run_filter_skb
To:     Rudi Ratloser <reimth@gmail.com>, bpf@vger.kernel.org
References: <CAOLRBTUSkRbku25rbw6Fyb019wFqFvEN=6xGM+RgFJFQ=NH4KQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b62a18d0-1f78-3bf5-38b2-08d9a779e432@iogearbox.net>
Date:   Tue, 30 Jun 2020 16:56:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAOLRBTUSkRbku25rbw6Fyb019wFqFvEN=6xGM+RgFJFQ=NH4KQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25859/Tue Jun 30 15:38:05 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/30/20 4:28 PM, Rudi Ratloser wrote:
> We have experienced a kernel BPF null pointer dereference issue on all
> our machines since mid of June. It might be related to an upgrade of
> libvirt/kvm/qemu at that point of time. But we’re not sure.
> 
> None of the servers can be used with this bug, as they crash latest
> one hour after reboot. The time period until kernel panic can be
> easily reduced down to 2 minutes, when starting one or more
> applications of the following list:
> - LXD daemon (4.2.1)
> - libvirtd daemon (6.4.0) with qemu/kvm guests
> - NFS server 2.5.1
> - Mozilla Firefox
> - Mozilla Thunderbird
> 
> If none of the applications run, the systems seem to be stable.
> 
> Intermediate solution:
> Downgrade Linux kernel to 4.9.226 LTS or 4.4.226  LTS on all the machines
> 
> Why this solution works is not clear, yet. One of the major
> differences we saw is, that both kernel packages have been configured
> with user namespaces disabled.
> 
> We experienced the kernel freeze on following Arch Linux kernels:
> - 5.7.0 (5.7.0-3-MANJARO x64)
> - 5.6.16 (5.6.16-1-MANJARO x64)
> - 5.4.44 (5.4.44-1-MANJARO x64)
> - 4.19.126 (4.19.126-1-MANJARO x64)
> - 4.14.183 (4.14.183-1-MANJARO x64)
> Kernel configs can be taken from https://gitlab.manjaro.org/packages/core.
> 
> Subsequent e-mails will contain the relevant extracts from journal or
> netconsole logs.
> 
> Help and support on this issue is welcome.

Fix is under discussion here:

   https://lore.kernel.org/netdev/20200616180352.18602-1-xiyou.wangcong@gmail.com/

Thanks,
Daniel
