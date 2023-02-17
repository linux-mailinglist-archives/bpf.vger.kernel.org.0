Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F80169B3E5
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 21:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBQUZP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 15:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBQUZF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 15:25:05 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB786358A
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 12:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ZjKHCCBB8hDnEFipaZmNPPWgiwQFjXQNZswn64rDpmY=; b=nGpANjYMwtLgEr5rjrvmLRRId1
        ZcYQ/ggQXA9PnFaWQgqhM1gwA6dm6YIXktlguw6V+3g153BRUaUXYAVEhRQqJzphQkuqKaE5AortX
        lg4GBeqqKY5ZT/FDCu55uqNb1oYJeBkSL68pMl4/rmnbM7EKbGmpKU6s+8nvDLhNWrf+lr/OZpVAi
        UDVEe7EuzjwtvbSv3SnU2bJqg5SiSCjT8646jEibndbQdCy1T+kRayPYOe8HSEBZxhpAgpT8wmTvl
        FSjXOHJxvJAv2uXcuoTofSipUtWqDnLiCKm0df1gfz5t7KlTNW9RbtYIS72bI5rtGG7LOjYJkYtDk
        VXTyj3gw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pT7Hi-000CTU-Gy; Fri, 17 Feb 2023 21:24:46 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pT7Hi-000SXP-BQ; Fri, 17 Feb 2023 21:24:46 +0100
Subject: Re: [PATCH v2 bpf-next 3/3] selftests/bpf: add global subprog context
 passing tests
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     kernel-team@fb.com
References: <20230216045954.3002473-1-andrii@kernel.org>
 <20230216045954.3002473-4-andrii@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0a59c080-8433-3c2d-92f6-079f5793a076@iogearbox.net>
Date:   Fri, 17 Feb 2023 21:24:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230216045954.3002473-4-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26815/Fri Feb 17 09:41:01 2023)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/16/23 5:59 AM, Andrii Nakryiko wrote:
[...]
> +SEC("?perf_event")
> +__success
> +int perf_event_ctx(void *ctx)
> +{
> +	return perf_event_ctx_subprog(ctx);
> +}
> +
> 

(Fixed up the eof newline while applying.)
