Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9121832458D
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 22:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhBXVCb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 16:02:31 -0500
Received: from www62.your-server.de ([213.133.104.62]:48360 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbhBXVCa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 16:02:30 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lF1I1-000DNv-OW; Wed, 24 Feb 2021 22:01:45 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lF1I1-000Bhl-J1; Wed, 24 Feb 2021 22:01:45 +0100
Subject: Re: arch_prepare_bpf_trampoline() for arm ?
To:     Luigi Rizzo <rizzo@iet.unipi.it>
References: <CA+hQ2+hhDG2JprNLaUdX4xgcihvchEda1aJuQN3jtJ3hYucDcQ@mail.gmail.com>
Cc:     bpf@vger.kernel.org, kpsingh@chromium.org, will@kernel.org
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6af0ab27-48f1-e389-d2f4-41b3c1db4a18@iogearbox.net>
Date:   Wed, 24 Feb 2021 22:01:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CA+hQ2+hhDG2JprNLaUdX4xgcihvchEda1aJuQN3jtJ3hYucDcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26090/Wed Feb 24 13:09:42 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/24/21 8:54 PM, Luigi Rizzo wrote:
> I prepared a BPF version of kstats[1]
> https://github.com/luigirizzo/lr-cstats
> that uses fentry/fexit hooks to monitor the execution time
> of a kernel function.
> 
> I hoped to have it working on ARM64 too, but it looks like
> arch_prepare_bpf_trampoline() only exists for x86.
> 
> Is there any outstanding patch for this function on ARM64,
> or any similar function I could look at to implement it myself ?

Not that I'm currently aware of, arm64 support would definitely be great
to have. From x86 side, the underlying arch dependency was basically on
text_poke_bp() to patch instructions on a live kernel. Haven't checked
recently whether an equivalent exists on arm64 yet, but perhaps Will
might know.

> [1] kstats is an in-kernel also in the above repo and previously
> discussed at https://lwn.net/Articles/813303/

