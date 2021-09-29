Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EFB41C9D8
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 18:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344259AbhI2QMn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 12:12:43 -0400
Received: from www62.your-server.de ([213.133.104.62]:47140 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345691AbhI2QMk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 12:12:40 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mVcAc-000EoN-70; Wed, 29 Sep 2021 18:10:58 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mVcAc-0000Xv-1p; Wed, 29 Sep 2021 18:10:58 +0200
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR
 BSD-2-Clause
To:     Luca Boccassi <bluca@debian.org>, bpf@vger.kernel.org
Cc:     ast@kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20210923000540.47344-1-luca.boccassi@gmail.com>
 <97ba65d49171c1a4eee34722d79b60e5732ce441.camel@debian.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a60b2164-2a4a-ac8b-c8a4-6e16497d620c@iogearbox.net>
Date:   Wed, 29 Sep 2021 18:10:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <97ba65d49171c1a4eee34722d79b60e5732ce441.camel@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26307/Wed Sep 29 11:09:54 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/29/21 6:06 PM, Luca Boccassi wrote:
[...]
> So as far as I understand, only your two acks are missing and then it's
> job done and we can go home!

Already applied including both our ACKs.

Thanks!
Daniel
