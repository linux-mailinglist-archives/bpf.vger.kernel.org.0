Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40092DC1B6
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 14:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgLPN51 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 08:57:27 -0500
Received: from www62.your-server.de ([213.133.104.62]:44448 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgLPN51 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 08:57:27 -0500
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kpXIL-000DHr-Jc; Wed, 16 Dec 2020 14:56:45 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kpXIL-000Fkj-Dw; Wed, 16 Dec 2020 14:56:45 +0100
Subject: Re: Can we share /sys/fs/bpf like /tmp?
To:     Lorenz Bauer <lmb@cloudflare.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>
References: <CACAyw98GbSi6UWDoN+A-B7Fct7fHsdgP67D5qf1oQVbUjdo1Fw@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4fa59cd4-5fda-24e1-5382-a66579f51c7a@iogearbox.net>
Date:   Wed, 16 Dec 2020 14:56:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACAyw98GbSi6UWDoN+A-B7Fct7fHsdgP67D5qf1oQVbUjdo1Fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26018/Tue Dec 15 15:37:09 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/16/20 2:29 PM, Lorenz Bauer wrote:
> Hi,
> 
> We're currently in the process of deploying our BPF socket dispatch
> control plane. This is the first piece of code where we persist maps
> my pinning them into a bpffs. We tried using /sys/fs/bpf but ran into
> permission problems:
> 
>      $ ls -ld /sys/fs/bpf
>      drwx-----T 2 root root 0 Dec 10 21:48 /sys/fs/bpf
> 
> For various reasons our program has a dedicated user, so we can't
> access /sys/fs/bpf. I did some digging into how the mode came about.
> In our environment the mount is done by systemd:
> 
> * First, systemd mounted without explicit mode set [1]. I think this
> means originally the mode was 1777.
> * Second, systemd changed this to 0700 [2]. The commit references some
> discussion with BPF folks, but I can't find a source for this
> discussion.
> 
> What were the reasons for changing the mode to 0700? Would it be
> reasonable to mount /sys/fs/bpf with 1777 nowadays?

If you don't specify anything particular a3af5f800106 ("bpf: allow for
mount options to specify permissions") the sb is created with S_IRWXUGO.

It's probably caution on systemd side (?), currently don't recall any
particular discussion on this matter.

Either way, you can mount your own private instance of bpf fs instance
anyway which supports anyway different mount flavors if needed [0]. So
it's no different from tmp fs or others - apart from explicitly not
having userns support.

   [0] https://www.kernel.org/doc/html/latest/filesystems/sharedsubtree.html

> Thanks
> Lorenz
> 
> 1: https://github.com/systemd/systemd/commit/43b7f24b5e0dd048452112bfb344739764c58694
> 2: https://github.com/systemd/systemd/commit/39f305a901934dfcc064cffd4e419b92d90b02c0
> --
> Lorenz Bauer  |  Systems Engineer
> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
> 
> www.cloudflare.com
> 

