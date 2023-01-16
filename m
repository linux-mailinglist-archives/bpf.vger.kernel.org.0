Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8559666C79B
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 17:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjAPQcr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 11:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjAPQcG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 11:32:06 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74570301A5
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 08:20:11 -0800 (PST)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pHSDN-000KP8-SP; Mon, 16 Jan 2023 17:20:05 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pHSDN-000O1P-LB; Mon, 16 Jan 2023 17:20:05 +0100
Subject: Re: [PATCH] selftests/bpf: add missing SPDX license headers
To:     Roberto Valenzuela <valenzuelarober@gmail.com>, andrii@kernel.org,
        mykolal@fb.com
Cc:     shuah@kernel.org, bpf@vger.kernel.org
References: <20230116015623.123395-1-valenzuelarober@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <87598737-a5eb-620f-859e-d40c5d648840@iogearbox.net>
Date:   Mon, 16 Jan 2023 17:20:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230116015623.123395-1-valenzuelarober@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26783/Mon Jan 16 09:28:30 2023)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/16/23 2:56 AM, Roberto Valenzuela wrote:
> Add the missing "SDPX-License-Identifier" license header
> to the test_verifier_log.c and urandom_read.c.
> 
> These changes will resolve the following checkpatch.pl
> script warning:
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> Signed-off-by: Roberto Valenzuela <valenzuelarober@gmail.com>
> ---
>   tools/testing/selftests/bpf/test_verifier_log.c | 2 ++
>   tools/testing/selftests/bpf/urandom_read.c      | 2 ++
>   2 files changed, 4 insertions(+)

This is a bit insufficient, there are many more files than just
this random pick above which do not contain an SPDX string.

> diff --git a/tools/testing/selftests/bpf/test_verifier_log.c b/tools/testing/selftests/bpf/test_verifier_log.c
> index 70feda97cee5..efee9bc3e9b4 100644
> --- a/tools/testing/selftests/bpf/test_verifier_log.c
> +++ b/tools/testing/selftests/bpf/test_verifier_log.c
> @@ -1,3 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
