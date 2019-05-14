Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A461C46B
	for <lists+bpf@lfdr.de>; Tue, 14 May 2019 10:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfENIJa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 May 2019 04:09:30 -0400
Received: from www62.your-server.de ([213.133.104.62]:56214 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfENIJ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 May 2019 04:09:29 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hQSV5-00045n-F5; Tue, 14 May 2019 10:09:27 +0200
Received: from [178.199.41.31] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hQSV5-000Xmv-8t; Tue, 14 May 2019 10:09:27 +0200
Subject: Re: [PATCH] tools/bpf: Sync kernel btf.h header
To:     Gary Lin <glin@suse.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>
References: <20190514031550.11446-1-glin@suse.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <92597c5e-4200-1ab0-6fab-a1271116aacf@iogearbox.net>
Date:   Tue, 14 May 2019 10:09:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190514031550.11446-1-glin@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25448/Mon May 13 09:57:34 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/14/2019 05:15 AM, Gary Lin wrote:
> For the fix of BTF_INT_OFFSET()
> 
> Signed-off-by: Gary Lin <glin@suse.com>

Both applied, thanks!
