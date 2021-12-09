Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CC546F7A7
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 00:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbhLIXu4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 18:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbhLIXu4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Dec 2021 18:50:56 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9819FC061746
        for <bpf@vger.kernel.org>; Thu,  9 Dec 2021 15:47:22 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x5so6965632pfr.0
        for <bpf@vger.kernel.org>; Thu, 09 Dec 2021 15:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GJs/Vbk1b/YGazDlEG0OnxBZgmoPaEddfzMx8OsYV9A=;
        b=hfNfbz9P47ef/K5rolpMlXFQDFpm9XPxCW4ks3Af2DNurIoXfTR6LRCHwSXSswXjSs
         Bew08ulmUfW3e++MQLSkQNsMfYVFS845k1JERWtA2+ezNW0Rpps/7WezZ8kR7S6c8upK
         YD2p8ktcSVfVuBZYkk2HI9KDlMAxJcKlbR6msSpQ7aRWe7N5yRhUlcWJ3kDQQ8HEcJ+3
         ZFre2p33qveslRO6nm5P03f2UmE6fytZR2dUl8Re5x8xVtUFNUXGCBLval5uha3opy9o
         cv1762ZAAy1ksUNuaeztQSzJjyLpAxEIoRTLRLqhVlEn6+SZ0dEthxddoCggB9HWdu0N
         vnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GJs/Vbk1b/YGazDlEG0OnxBZgmoPaEddfzMx8OsYV9A=;
        b=5tedy+1MXbtYL9hztiGQ2R7viMtEHjhzlxjooC7I9s2C7xLTtTUaHNvtIgo8Uv3v91
         z9gAuYnLiji9twSHJRu2hubtkMZ+0oLGPAR0vSF6nMgIjxf4sAf7J+EiVkG+NF+1eaBA
         B0bPJtQVwZ8YYNmFXgWwfrpfocl7ey0jOvWQkeTN4wK55fo6C4HkL+NbnUcYLFcnq6ks
         ONHJXz2q6RSHsYG7zWNc49zZSK0NSNrsHCiKUOCP47cMDbTUkFmvmXJ8e69Uj76Urn3S
         vlQxo96LbYRKZKoOo7YwoNOrifn1q283nZMCBMRMEH4hSSZlUJhv/ik59aSn6EfgYDEv
         DqJw==
X-Gm-Message-State: AOAM5332r4V6r8Kv6h49g8GH+neJ3BdccDxAsysuSAOXSLWTDdGXjH+5
        EzGp1Y+NhUYMunOhTKDOwX0=
X-Google-Smtp-Source: ABdhPJw4Xl3HUYamkQgXdgxpFc5GnpgDeBoW/4KOFNf+tOYq7VtcZD5tjYb7GVMOJ3OalXHkuLGtxQ==
X-Received: by 2002:a63:ef44:: with SMTP id c4mr36368029pgk.146.1639093642095;
        Thu, 09 Dec 2021 15:47:22 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8515])
        by smtp.gmail.com with ESMTPSA id t67sm777494pfd.24.2021.12.09.15.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 15:47:21 -0800 (PST)
Date:   Thu, 9 Dec 2021 15:47:19 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 00/12] Enhance and rework logging controls in
 libbpf
Message-ID: <20211209234719.tnuktgvwvihvagle@ast-mbp.dhcp.thefacebook.com>
References: <20211209193840.1248570-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209193840.1248570-1-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 09, 2021 at 11:38:28AM -0800, Andrii Nakryiko wrote:
> Add new open options and per-program setters to control BTF and program
> loading log verboseness and allow providing custom log buffers to capture logs
> of interest. Note how custom log_buf and log_level are orthogonal, which
> matches previous (alas less customizable) behavior of libbpf, even though it
> sort of worked by accident: if someone specified log_level = 1 in
> bpf_object__load_xattr(), first attempt to load any BPF program resulted in
> wasted bpf() syscall with -EINVAL due to !!log_buf != !!log_level. Then on
> retry libbpf would allocated log_buffer and try again, after which prog
> loading would succeed and libbpf would print verbose program loading log
> through its print callback.
> 
> This behavior is now documented and made more efficient, not wasting
> unnecessary syscall. But additionally, log_level can be controlled globally on
> a per-bpf_object level through bpf_object_open_opts, as well as on
> a per-program basis with bpf_program__set_log_buf() and
> bpf_program__set_log_level() APIs.
> 
> Now that we have a more future-proof way to set log_level, deprecate
> bpf_object__load_xattr().
> 
> v2->v3:
>   - added log_buf selftests for bpf_prog_load() and bpf_btf_load();
>   - fix !log_buf in bpf_prog_load (John);
>   - fix log_level==0 in bpf_btf_load (thanks selftest!);

Applied, Thanks
