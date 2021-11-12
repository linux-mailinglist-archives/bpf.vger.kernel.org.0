Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A0944DF77
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 01:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhKLBCC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 20:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbhKLBCC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 20:02:02 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6154C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 16:59:12 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c4so7072209pfj.2
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 16:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R4RxUyDyQgyTinlQCQGjenkQgQ4iWswHHCcjm77mi8s=;
        b=YIvY2ZPSf+IwwiMnPpcLfgm35zlQzG9Ws9rAD/UOOyir3qGI9IxrsviIXZrCXLm/f0
         fke0aZlO6xSoxihpYRZH9fIiQnADi76BEdFAQ1/u1jciJWsBXo1yc+THFVDt+nI1Bk/F
         lrpdzQHbHswpwbBqUKvz32pw9EY3DcxfSo6fdsjEuCDpEW8Cxp8ONqBN59L+ZznK6L7U
         x7MqZiA7hG4h8IoHoZFmFYDC20FTI2EWn/tOytFaThOytthRKBPv0JM6UgenphwIxgsg
         OGLpE5TKi6lNP3rJysQc6C3ftNN3zeug3OTwSnmfWHTx92IIGEmEJ0HHiK2fSsSEMPYB
         UaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R4RxUyDyQgyTinlQCQGjenkQgQ4iWswHHCcjm77mi8s=;
        b=UEX1PsqBW3mr2nSnQfQvgeGBjFLaMjPXpWlKJ7NacP0ysu+f3j+DP8tKPEuRVKgVqq
         utM05WA0LKnuxHTB5hM4iIVTUct49dT/TKmZO/8sffYmU18ZFXIbmY43UumynX/CYaob
         Vj5yRKVxumRU0sAGHJkTkf5jJqKqIUkyRePjI3rl3HBNyBwnwBriRwEAEFKtPQf+jjTH
         vKK78UMfLYNkf3hs6EfQNJaDVCu59KyEmzBfnaKu+6MUGBgD9M3vdHBNDydVrFu9lHNv
         cbkh9x1JFfGN4tyf3TSuBerA94eDwM2LpZueKIF7KXn0wljA7w3pt9b7FuU1eXXI8p+2
         Sw0g==
X-Gm-Message-State: AOAM532a4Va5QLdFDw/5jdzvJqZdNji/Z6eQf+L2iLVniP9uZnMa+Udv
        cPZULPoTEOiu258e5+vnAuqUbsFSG6I=
X-Google-Smtp-Source: ABdhPJyGo2S9ZWZFEGTqv6EBxP5ARcJPnAkdQrWBNXoUYb4b6xfcd0BafKImGCEHlyc3a2ZcuxvN8w==
X-Received: by 2002:a63:dc42:: with SMTP id f2mr7390119pgj.275.1636678752414;
        Thu, 11 Nov 2021 16:59:12 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:9ee9])
        by smtp.gmail.com with ESMTPSA id z4sm3970693pfg.101.2021.11.11.16.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 16:59:12 -0800 (PST)
Date:   Thu, 11 Nov 2021 16:59:10 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 0/9] Future-proof more tricky libbpf APIs
Message-ID: <20211112005910.ktvjmbkgxpp5qfvr@ast-mbp.dhcp.thefacebook.com>
References: <20211111053624.190580-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111053624.190580-1-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 10, 2021 at 09:36:15PM -0800, Andrii Nakryiko wrote:
> This patch set continues the work of revamping libbpf APIs that are not
> extensible, as they were added before we figured out all the intricacies of
> building APIs that can preserve ABI compatibility (both backward and forward).
> 
> What makes them tricky is that (most of) these APIs are actively used by
> multiple applications, so we need to be careful about refactoring them. See
> individual patches for details, but the general approach is similar to
> previous bpf_prog_load() API revamp. The biggest different and complexity is
> in changing btf_dump__new(), because function overloading through macro magic
> doesn't work based on number of arguments, as both new and old APIs have
> 4 arguments. Because of that, another overloading approach is taken; overload
> happens based on argument types.
> 
> I've validated manually (by using local test_progs-shared flavor that is
> compiling test_progs against libbpf as a shared library) that compiling "old
> application" (selftests before being adapted to using new variants of revamped
> APIs) are compiled and successfully run against newest libbpf version as well
> as the older libbpf version (provided no new variants are used). All these
> scenarios seem to be working as expected.
> 
> v1->v2:
>   - add explicit printf_fn NULL check in btf_dump__new() (Alexei);
>   - replaced + with || in __builtin_choose_expr() (Alexei);
>   - dropped test_progs-shared flavor (Alexei).

Applied, Thanks
