Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32DD277C70
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 01:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgIXXrn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 19:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIXXrn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 19:47:43 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B22C0613CE
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 16:47:43 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n14so1261111pff.6
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 16:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dhceond6MhN2R2DQeCMd0g/2xnp3K8y0mvTHC2tschA=;
        b=VFyC5KeNqyRRNwJ2rIqr64ZAdhtd3ZjHKi/FlEg6q1kPOgt6jHtVOG5WenIgUz+WhE
         wPdvUdWlU8OufLk3klwumvuTjCzgSVta9G3tmEHbHyw00UO5g5AmnSaWsmsA1JTkdntn
         +CeaImnE6+DIvQMWrDoXvTu0JKpZVaUbnMIps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dhceond6MhN2R2DQeCMd0g/2xnp3K8y0mvTHC2tschA=;
        b=G3eVfJ/SxPmnu5M+g7Rvy3K4DKH+CRyPEuenp+po6Xd4qpZugwS52y3txyGx/I6WAN
         lJsxsZoDTnEaBofqdjzfX1bfAp25tItPMygpKgIYNd4adXLw5fCFprLeIJTBFoeay7Oo
         060qtQsa/7iYf1AF52WXNSAeo4EfXOYpAiFd2VEmxt0q+ugP//m7CRchIpc0MVd4J07I
         3i/hJs/9tJFT+oszfsyfByfNCmbo/rE4mh1Ctrya0BMfyj7CWQJq5ZmTgYRv8i0/0OlF
         UVZcUTiBL8giCahsE5FErnZNDZmf7KMAnlya1e9RCmXtfBVAfAUHzzjFEWPVGbad9jiW
         Ncww==
X-Gm-Message-State: AOAM530dImG/H2Dqm15SvwlTR3JnpNMP8e0En1WnZZWcd2f8dJ7secDB
        JS4Kuke7W8DHPVGVU2bLUBoM7Q==
X-Google-Smtp-Source: ABdhPJxFkZ2rv0mIiwE5o4BC/5A99M3zCAJji9u/yHJrgtSMDtuGx5fu+J4480xg2ZG87UninMdAIQ==
X-Received: by 2002:a17:902:b18f:b029:d2:1ec0:4161 with SMTP id s15-20020a170902b18fb02900d21ec04161mr1559187plr.58.1600991262838;
        Thu, 24 Sep 2020 16:47:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n125sm526792pfn.185.2020.09.24.16.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 16:47:42 -0700 (PDT)
Date:   Thu, 24 Sep 2020 16:47:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     containers@lists.linux-foundation.org,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v2 seccomp 5/6] selftests/seccomp: Compare bitmap vs
 filter overhead
Message-ID: <202009241646.5739BE3@keescook>
References: <cover.1600951211.git.yifeifz2@illinois.edu>
 <eedf3323eed8615a4be150b39a717de1a68f0c12.1600951211.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eedf3323eed8615a4be150b39a717de1a68f0c12.1600951211.git.yifeifz2@illinois.edu>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 07:44:20AM -0500, YiFei Zhu wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> As part of the seccomp benchmarking, include the expectations with
> regard to the timing behavior of the constant action bitmaps, and report
> inconsistencies better.
> 
> Example output with constant action bitmaps on x86:
> 
> $ sudo ./seccomp_benchmark 100000000
> Current BPF sysctl settings:
> net.core.bpf_jit_enable = 1
> net.core.bpf_jit_harden = 0
> Benchmarking 100000000 syscalls...
> 63.896255358 - 0.008504529 = 63887750829 (63.9s)
> getpid native: 638 ns
> 130.383312423 - 63.897315189 = 66485997234 (66.5s)
> getpid RET_ALLOW 1 filter (bitmap): 664 ns
> 196.789080421 - 130.384414983 = 66404665438 (66.4s)
> getpid RET_ALLOW 2 filters (bitmap): 664 ns
> 268.844643304 - 196.790234168 = 72054409136 (72.1s)
> getpid RET_ALLOW 3 filters (full): 720 ns
> 342.627472515 - 268.845799103 = 73781673412 (73.8s)
> getpid RET_ALLOW 4 filters (full): 737 ns
> Estimated total seccomp overhead for 1 bitmapped filter: 26 ns
> Estimated total seccomp overhead for 2 bitmapped filters: 26 ns
> Estimated total seccomp overhead for 3 full filters: 82 ns
> Estimated total seccomp overhead for 4 full filters: 99 ns
> Estimated seccomp entry overhead: 26 ns
> Estimated seccomp per-filter overhead (last 2 diff): 17 ns
> Estimated seccomp per-filter overhead (filters / 4): 18 ns
> Expectations:
> 	native ≤ 1 bitmap (638 ≤ 664): ✔️
> 	native ≤ 1 filter (638 ≤ 720): ✔️
> 	per-filter (last 2 diff) ≈ per-filter (filters / 4) (17 ≈ 18): ✔️
> 	1 bitmapped ≈ 2 bitmapped (26 ≈ 26): ✔️
> 	entry ≈ 1 bitmapped (26 ≈ 26): ✔️
> 	entry ≈ 2 bitmapped (26 ≈ 26): ✔️
> 	native + entry + (per filter * 4) ≈ 4 filters total (732 ≈ 737): ✔️
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>

BTW, did this benchmark tool's results match your expectations from what
you saw with your RFC? (I assume it helped since you've included in
here.)

-- 
Kees Cook
