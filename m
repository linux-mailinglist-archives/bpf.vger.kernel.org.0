Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0FC8A4102
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2019 01:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfH3XYW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Aug 2019 19:24:22 -0400
Received: from www62.your-server.de ([213.133.104.62]:58992 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3XYW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Aug 2019 19:24:22 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i3qFg-0004LR-HR; Sat, 31 Aug 2019 01:24:20 +0200
Received: from [178.197.249.19] (helo=pc-63.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i3qFg-000QKv-Bs; Sat, 31 Aug 2019 01:24:20 +0200
Subject: Re: [PATCH] selftests/bpf: Fix a typo in test_offload.py
To:     Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        bpf@vger.kernel.org, ast@kernel.org, kafai@fb.com
References: <20190829000130.7845-1-standby24x7@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <263f4373-ee01-8116-e9ea-97aca06b13d0@iogearbox.net>
Date:   Sat, 31 Aug 2019 01:24:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190829000130.7845-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25557/Fri Aug 30 10:30:29 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/29/19 2:01 AM, Masanari Iida wrote:
> This patch fix a spelling typo in test_offload.py
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Applied, thanks!
