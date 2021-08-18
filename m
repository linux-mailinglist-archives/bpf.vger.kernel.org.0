Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7FF3F0E5B
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 00:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhHRWsr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Aug 2021 18:48:47 -0400
Received: from www62.your-server.de ([213.133.104.62]:60700 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhHRWsq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Aug 2021 18:48:46 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mGULx-0007mj-MQ; Thu, 19 Aug 2021 00:48:09 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mGULx-000MBg-Gf; Thu, 19 Aug 2021 00:48:09 +0200
Subject: Re: [PATCH bpf] bpf: Fix possible out of bound write in narrow load
 handling
To:     Andrey Ignatov <rdna@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, andriin@fb.com, dan.carpenter@oracle.com,
        kernel-team@fb.com
References: <20210818221143.1004463-1-rdna@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4589201d-48ea-d3ef-d0cf-7dc8cc23d108@iogearbox.net>
Date:   Thu, 19 Aug 2021 00:48:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210818221143.1004463-1-rdna@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26267/Wed Aug 18 10:21:27 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/19/21 12:11 AM, Andrey Ignatov wrote:
> Fix a verifier bug found by smatch static checker in [0].
> 
> When narrow load is handled, one or two new instructions are added to
> insn_buf array, but before it was only checked that
> 
> 	cnt >= ARRAY_SIZE(insn_buf)
> 
> And it's safe to add a new instruction to insn_buf[cnt++] only once. The
> second try will lead to out of bound write. And this is what can happen
> if `shift` is set.

Afaik, the insn_buf[] should always be large enough, could you add something to
the commit message of this fix whether this created an actual issue in practice
where we do oob overrun insn_buf[] (or whether it's 'only' the static checker
report ... from above paragraph I read you saw the former in practice)?

Thanks,
Daniel
