Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABEC523A6E
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 18:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344840AbiEKQgL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 12:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344834AbiEKQgJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 12:36:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D622655A
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 09:36:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o69so2728279pjo.3
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 09:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HhUxFGCX8HXa/WG3XBraQYK60HzDtg2xLNJrs1MzQfc=;
        b=CY7H8so834NQzvrLPCQUkIYoePIcaiEuyxzfQVVczjQotAYlL4lEKjOWS163G43wLV
         kZS3Me4FDKNOUpI/G7WwuXRvN9VwzoCGDZJ8myvySu/Ui51FXQKjLkjfM724wtM7k2vN
         pjDAxx2y9FrDtdLzW7V69FoiWV0mKWSVHQxhZIW4UuAATus0FmUoEZDzr1OBboxJKFTN
         RSdope9E653swVofla6Dy5pdoGXz9PAreGi9dFoNRs+y8aW25Q+M5L8g5jQTe5M+rwXk
         GZFKZ6OGmcqzj+ZtdZc5dsT4MS+oJYo8tohVaK/nTE93ekCdavQ+kuTzgSaeo+PQUGs3
         wKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HhUxFGCX8HXa/WG3XBraQYK60HzDtg2xLNJrs1MzQfc=;
        b=rMsyv4EeOprAqvKpvOs4D/Orsi/UQWojaRNNzcR2oGVQL2fvV7sbYRr/PYHNbS1RX6
         85R3o1rl0lcsQW1APIs2ViomeltYR1NKkpP773D1cKjqC1harIYH0JcC8ttscnyXa12V
         3IvYlwczND25YBVHbmJDDPc2XdaxByueeivh348l3JVFHvqZTApErjZUtGttMeKZk1+W
         w7XExMQgzTWVvbP7oGcw9/P4mNIWdzcW+od44PO8doy/+/zQ+M4CCYQMbqI3Ln7NrX9x
         CXvDFT2Do12Zj9vbZCYmKXKqJMiKmacXF6JrgJzJius1IU/uvNKbFV2Vq+0WjyA+0++q
         WYtQ==
X-Gm-Message-State: AOAM533EtN0BpJr4SwGIAY4x3XVM/WPLjkm7iCT0SMPfGn5QkaBpP1kl
        /AFnycbXlqdx14yyglHXRM8=
X-Google-Smtp-Source: ABdhPJzwDmyflesxZD0z0HCm4lI80wuCa1RWKs9o10V3x9V3l0ZsC3nIbUkI3ud5hbeAOb7cZ+hLVQ==
X-Received: by 2002:a17:90b:3442:b0:1d9:8af8:28ff with SMTP id lj2-20020a17090b344200b001d98af828ffmr6294401pjb.201.1652286967428;
        Wed, 11 May 2022 09:36:07 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::4:6b86])
        by smtp.gmail.com with ESMTPSA id 18-20020a621712000000b0050dc762817asm2009606pfx.84.2022.05.11.09.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:36:06 -0700 (PDT)
Date:   Wed, 11 May 2022 09:36:04 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        keescook@chromium.org, bpf@vger.kernel.org
Subject: Re: [RFC bpf-next 0/2] bpf: allow unprivileged map access to some
 map types
Message-ID: <20220511163604.5kuczj6jx3ec5qv6@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <1652275168-18630-1-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652275168-18630-1-git-send-email-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 11, 2022 at 02:19:26PM +0100, Alan Maguire wrote:
> Unprivileged BPF disabled (kernel.unprivileged_bpf_disabled >= 1)
> is the default in most cases now; when set, the BPF system call is
> blocked for users without CAP_BPF/CAP_SYS_ADMIN.  In some use cases
> prior to having unpriviliged_bpf_disabled set to >= 1 however,
> it made sense to split activities between capability-requiring
> ones - such as program load+attach - and those that might not require
> capabilities such as reading perf/ringbuf events, reading or
> updating BPF map configuration etc.  One example of this sort of
> approach is a service that loads a BPF program, and a user-space
> program that, after it has been loaded, interacts with it via
> pinned maps.
> 
> Such a split model is not possible with unprivileged BPF disabled,
> since even those activities such as map interactions, retrieving
> map information from pinned paths etc are blocked to
> unprivileged users.  However, granting CAP_BPF to such unprivileged
> users is quite a big hammer, allowing them to do pretty much
> anything with BPF.
> 
> This very rough RFC explores the idea - with
> CONFIG_BPF_UNPRIV_MAP_ACCESS=y - of allowing unprivileged processes
> to retrieve and work with a restricted set of BPF maps.  See
> patch 1 for the restrictions on BPF cmd and map type. Note that
> permission checks on maps are still enforced, so it's still
> possible to prevent unwanted interference by unprivileged users
> by pinning a map and setting permissions to prevent access.
> CONFIG_BPF_UNPRIV_MAP_ACCESS defaults to n, preserving current
> behaviour of blocking all BPF syscall commands.
> 
> Discussion on the bpf mailing list already alluded to this idea [1],
> though it's possible I misinterpreted it.

Thanks for the follow up. We had a long discussion about this during lsfmmbpf.
In short a bunch of folks wants to address this problem.
Your summary of the problem is accurate.
The patch though is overly cautious in fixing the issue.
The bpf ACL model is the same as traditional file's ACL.
The creds and ACLs are checked at open().  Then during file's write/read
additional checks might be performed. BPF has such functionality already. 
Different map_creates have capability checks while map_lookup has:
map_get_sys_perms(map, f) & FMODE_CAN_READ.
In other words it's enough to gate FD-receiving parts of bpf
with unprivileged_bpf_disabled sysctl.
The rest is handled by availability of FD and access to files in bpffs.
Additional kconfig is unnecessary. Also no need to filter
different map types. Only array/hash/ringbuf are ok for unpriv
when that sysctl is off. The rest of maps have their own cap_bpf checks
at creation time which is enough.
The patch 1 should probably be something like:
  if (!capable &&
      (cmd == BPF_MAP_CREATE || cmd == BPF_PROG_LOAD))
    return -EPERM;
For all other commands the user has to have a valid map/btf/prog FD to proceed.
There are few special commands that don't need to be in the above 'if':
. BPF_[PROG|MAP|BTF]_GET_NEXT_ID have explicit cap_sys_admin check.
. BPF_OBJ_GET is using traditional file ACLs to access.
. BPF_BTF_LOAD has its own cap_bpf check.

Of course there could be bugs in any of unpriv code paths, but they were
enabled with sysctl off for long time. When/if new bugs are found they will be fixed.
The unprivileged_bpf_disabled's default was flipped only because of HW bugs.
In all HW spectre exploits BPF_PROG_LOAD was the mandatory command.
Just disabling that command is enough. The BPF_MAP_CREATE alone
cannot be used in spectre-like attack. But map_create without prog_load
is a useless combination for unrpiv. So having sysctl affecting them
both makes sense from symmetry pov. libbpf and other loaders typically
create a map first, so with sysctl off the unpriv users will see those eperms first.
I hope it's mostly accurate summary of the discussion.
