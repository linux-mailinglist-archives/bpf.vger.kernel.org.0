Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681AC147B2
	for <lists+bpf@lfdr.de>; Mon,  6 May 2019 11:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfEFJgR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 May 2019 05:36:17 -0400
Received: from www62.your-server.de ([213.133.104.62]:40372 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfEFJgQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 May 2019 05:36:16 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hNa2g-0000UI-Jm; Mon, 06 May 2019 11:36:14 +0200
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hNa2g-000QDF-D8; Mon, 06 May 2019 11:36:14 +0200
Subject: Re: [PATCH bpf] libbpf: remove unnecessary cast-to-void
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, netdev@vger.kernel.org
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, magnus.karlsson@gmail.com,
        bpf@vger.kernel.org
References: <20190506092443.24483-1-bjorn.topel@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2f46de83-7b76-b7ba-54ed-9b084bb83df8@iogearbox.net>
Date:   Mon, 6 May 2019 11:36:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190506092443.24483-1-bjorn.topel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25441/Mon May  6 10:04:24 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/06/2019 11:24 AM, Björn Töpel wrote:
> From: Björn Töpel <bjorn.topel@intel.com>
> 
> The patches with fixes tags added a cast-to-void in the places when
> the return value of a function was ignored.
> 
> This is not common practice in the kernel, and is therefore removed in
> this patch.
> 
> Reported-by: Daniel Borkmann <daniel@iogearbox.net>
> Fixes: 5750902a6e9b ("libbpf: proper XSKMAP cleanup")
> Fixes: 0e6741f09297 ("libbpf: fix invalid munmap call")
> Signed-off-by: Björn Töpel <bjorn.topel@intel.com>

Applied, thanks!
