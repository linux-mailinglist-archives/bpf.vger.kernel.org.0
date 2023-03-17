Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511BB6BDFD7
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 04:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCQDyi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 23:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCQDyh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 23:54:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7404A6EA6
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 20:54:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso3726619pjb.3
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 20:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679025276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bHaL67qZGKqWWfKCVTxU8uegI01NukZcW9rcix21i8=;
        b=N9Ytgu/vMaF/bTfK5ZoR1jHMCasBjKC8LsSDfhLT0nTeda4VdW+0/6XfEqy0SW6gc6
         Gnu74F2dHqcsEOzUsvmnhyQko/yrkei+BLKRBfOMaCaOpFUnBiAWEljUxvCXrXytGSZf
         +O6eQ2xgqlII3B7ZM8BBuruJAR1gi1+XqCQSC4+EpjiIdCXeqVgnSOYJQZcpFk1z74hi
         FKwWRUoDXC68cnFekVkVFBgdQJ0PElyEnJzOfiEr+kfpEQkg0/5/7LsiZ+2pp6B0aOol
         A3QOxoZ48bpKAhvUtvAPEcEoxfBaMJwEBSIRRKTWiASLpa6TAeQsT6fU5C1GX/0B0Lz+
         3B1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679025276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bHaL67qZGKqWWfKCVTxU8uegI01NukZcW9rcix21i8=;
        b=rhXeYp3T4svI9NJAu1GrZJ+xyu4kSZ99wd+QNmuioN1CDl1I2LMr1NWdMxiupJxqwq
         HT9RIZaxDssxhIYkOtONKNv/NgNl8vZGT7NQRZCmVRGKZE0ABfscW7Qe2mDkvwZC2i6u
         CJhrPjobYoco81+o+V3ApICpLR7AHo7nudDnGSMfII3uCjifEz1Gsd2xtFRtuQc8eoW9
         ao9lsXTJFf/6lIdfhwMvv2vH/PG+MDc0mSW210EwPP8jaxQRw3thFUCQod6lNAMSvGtf
         qUPEuiHQSSB0v9IhxWPBGlVkEvnzrv7qG6BhqUcHtK01QUWCI2aTSxPLB/4Re/tuZcn9
         yN6w==
X-Gm-Message-State: AO0yUKU5jD9MoXMxkbWcBBNTeAv5gT8fHrabU769a5u53qlJ9OVhhr5O
        VHcHNQxmo2QzWgDO+iOmwxM=
X-Google-Smtp-Source: AK7set/u5VLLR7wSPokOXL+ThhbXtdu1ZKzxPTxIzjD6KcBRN1MMkotSUT9rpzJqjJbJM0zvWnKCzA==
X-Received: by 2002:a17:902:ecc7:b0:19e:2fb0:a5d9 with SMTP id a7-20020a170902ecc700b0019e2fb0a5d9mr1625671plh.32.1679025275517;
        Thu, 16 Mar 2023 20:54:35 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:2bcf])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902b58a00b00198b01b412csm421677pls.303.2023.03.16.20.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 20:54:35 -0700 (PDT)
Date:   Thu, 16 Mar 2023 20:54:32 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 3/6] bpf: switch BPF verifier log to be a
 rotating log by default
Message-ID: <20230317035432.tznxagpp666ow5aq@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230316183013.2882810-1-andrii@kernel.org>
 <20230316183013.2882810-4-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316183013.2882810-4-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 16, 2023 at 11:30:10AM -0700, Andrii Nakryiko wrote:
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
> ---
>  include/linux/bpf_verifier.h                  |  32 ++-
>  kernel/bpf/log.c                              | 182 +++++++++++++++++-
>  kernel/bpf/verifier.c                         |  17 +-
>  .../selftests/bpf/prog_tests/log_fixup.c      |   1 +
>  4 files changed, 209 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 83dff25545ee..cff11c99ed9a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -491,25 +491,42 @@ struct bpf_insn_aux_data {
>  #define BPF_VERIFIER_TMP_LOG_SIZE	1024
>  
>  struct bpf_verifier_log {
> -	u32 level;
> -	char kbuf[BPF_VERIFIER_TMP_LOG_SIZE];
> +	/* Logical start and end positions of a "log window" of the verifier log.
> +	 * start_pos == 0 means we haven't truncated anything.
> +	 * Once truncation starts to happen, start_pos + len_total == end_pos,
> +	 * except during log reset situations, in which (end_pos - start_pos)
> +	 * might get smaller than len_total (see bpf_vlog_reset()).
> +	 * Generally, (end_pos - start_pos) gives number of useful data in
> +	 * user log buffer.
> +	 */
> +	u64 start_pos;
> +	u64 end_pos;
...
>  
> -void bpf_vlog_reset(struct bpf_verifier_log *log, u32 new_pos)
> +void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
>  {
>  	char zero = 0;
>  
>  	if (!bpf_verifier_log_needed(log))
>  		return;
>  
> -	log->len_used = new_pos;
> +	/* if position to which we reset is beyond current log window, then we
> +	 * didn't preserve any useful content and should adjust adjust
> +	 * start_pos to end up with an empty log (start_pos == end_pos)
> +	 */
> +	log->end_pos = new_pos;
> +	if (log->end_pos < log->start_pos)
> +		log->start_pos = log->end_pos;
> +
>  	if (put_user(zero, log->ubuf + new_pos))

Haven't analyzed the code in details and asking based on comments...
new_pos can be bigger than ubuf size and above write will be out of bounds, no?
