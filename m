Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE4D6BF63A
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 00:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCQXYI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 19:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCQXYG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 19:24:06 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196FD39B96
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 16:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=kPjt+HFekeVXNgeLx5HhibCH5tjLIJFwHOQJNAasTM4=; b=QbHuXoQrbnrqTQfcTCGJZM387F
        tjwiPJRso2AQzID5xsVKR9f58bIrKmBRxG67JsMsbZk7OMLzex9yrp8sR02G1CG8fcOXyIrQ2GSt+
        YmP1FfpOF0pTunD4hhe3sbovZyAdYttNrJCeqqNELQMgngXMT/I3MCz7NxizXbcGUN4sygzuJP+FM
        brUiUKmMHpiLC12ZEz7giAO5Mk3LOffyHCI3sGdoUk5IJJPctQ9O3h6j7CaNTGAOzNHCv2DJG75TW
        2EwPwOXs/BqojF6FYd8hR/kBGXH7QI2J1U5kWRb5RH+/FxHkzJMYR42AsMl7ggN3hCezT9COgqCBQ
        AWTVOaHQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pdJ5J-000AuE-Mk; Sat, 18 Mar 2023 00:02:05 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pdJ5J-000TNn-Dd; Sat, 18 Mar 2023 00:02:05 +0100
Subject: Re: [PATCH bpf-next 3/6] bpf: switch BPF verifier log to be a
 rotating log by default
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@kernel.org
Cc:     kernel-team@meta.com, i@lmb.io, timo@incline.eu
References: <20230317220351.2970665-1-andrii@kernel.org>
 <20230317220351.2970665-4-andrii@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bb0b7006-9a22-df8e-f623-d8a9d3069fc1@iogearbox.net>
Date:   Sat, 18 Mar 2023 00:02:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230317220351.2970665-4-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26846/Fri Mar 17 08:22:57 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/17/23 11:03 PM, Andrii Nakryiko wrote:
> Currently, if user-supplied log buffer to collect BPF verifier log turns
> out to be too small to contain full log, bpf() syscall return -ENOSPC,
> fails BPF program verification/load, but preserves first N-1 bytes of
> verifier log (where N is the size of user-supplied buffer).
> 
> This is problematic in a bunch of common scenarios, especially when
> working with real-world BPF programs that tend to be pretty complex as
> far as verification goes and require big log buffers. Typically, it's
> when debugging tricky cases at log level 2 (verbose). Also, when BPF program
> is successfully validated, log level 2 is the only way to actually see
> verifier state progression and all the important details.
> 
> Even with log level 1, it's possible to get -ENOSPC even if the final
> verifier log fits in log buffer, if there is a code path that's deep
> enough to fill up entire log, even if normally it would be reset later
> on (there is a logic to chop off successfully validated portions of BPF
> verifier log).
> 
> In short, it's not always possible to pre-size log buffer. Also, in
> practice, the end of the log most often is way more important than the
> beginning.
> 
> This patch switches BPF verifier log behavior to effectively behave as
> rotating log. That is, if user-supplied log buffer turns out to be too
> short, instead of failing with -ENOSPC, verifier will keep overwriting
> previously written log, effectively treating user's log buffer as a ring
> buffer.
> 
> Importantly, though, to preserve good user experience and not require
> every user-space application to adopt to this new behavior, before
> exiting to user-space verifier will rotate log (in place) to make it
> start at the very beginning of user buffer as a continuous
> zero-terminated string. The contents will be a chopped off N-1 last
> bytes of full verifier log, of course.
> 
> Given beginning of log is sometimes important as well, we add
> BPF_LOG_FIXED (which equals 8) flag to force old behavior, which allows
> tools like veristat to request first part of verifier log, if necessary.
> 
> On the implementation side, conceptually, it's all simple. We maintain
> 64-bit logical start and end positions. If we need to truncate the log,
> start position will be adjusted accordingly to lag end position by
> N bytes. We then use those logical positions to calculate their matching
> actual positions in user buffer and handle wrap around the end of the
> buffer properly. Finally, right before returning from bpf_check(), we
> rotate user log buffer contents in-place as necessary, to make log
> contents contiguous. See comments in relevant functions for details.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Did you check behavior with other loaders if changing default works ok
for them, e.g. their behavior/buffer around ENOSPC handling for growing?

The go loader library did some parsing around the log [0], adding Lorenz
and Timo for Cc for checking.

   [0] https://github.com/cilium/ebpf/blob/master/internal/errors.go
       https://github.com/cilium/ebpf/blob/master/prog.go#L61
