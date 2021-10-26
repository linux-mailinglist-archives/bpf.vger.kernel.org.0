Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CBC43A9C8
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 03:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhJZBkq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 21:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhJZBkp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 21:40:45 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A554EC061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 18:38:22 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x66so12656494pfx.13
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 18:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PY5j0rTwm2AD+DFgSjxHgcfYob585Oa3YCa2epDEWcs=;
        b=qKMJ7ayFQJRgvmEl9yCuJWC9CkT6AHmnVs9XVwEswvHueHK+OYMBqoi2/+pKGjv01s
         soaJJfrdZNJ51GYjWHAG7Boy06TbDwDad23o5Bie+iTm1//f3s9JdJWtE1WzXJPKEmdo
         oUMIAkgwxtFoVYQogEtsyrafh0BeY2HkU6WxP8gdYgId6Vz2KkojaNVlBn7iTi6vT0+l
         wpVR741oFRH7Op54AOG/wszxKtr/NBGmHB+05+MiU+9eD+g61yxSZwPDN6dJoYyB9iGa
         TCW5NgbC+zteSpDAcgWCvXi+vHazzML53Qika2VJpo3RI4wPcE59Nypk2EBYFHkgohVI
         IZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PY5j0rTwm2AD+DFgSjxHgcfYob585Oa3YCa2epDEWcs=;
        b=ffO7u4UtleEHVYpBdPpnFvK3r0xqi0KvtINcvEDlGeEsjd93gM8Yvt9UPB5IuzzV7+
         ctmQP2qoZ828lqQANv2nvnetloHkpxUGkg+kUJSRjPHJwRyMvHKJtb8tgbDlCL1Sc3Au
         E/6DWd/oa+kB0N5anhkknG19j7wz3BOljTQnCWbnHaPIL9b5AywYis0jujxYX10nrR6L
         NvAY8LBe7/NbpJdiKiC0CA/Vu5z12eOEqbLRDOjfFODhmy8FTqYZPqJxgvWEn0hnLzQJ
         NkuArKNTtxW+KjJrZdKs/iqu5Ql/go+a7pVbIEBxAsgK53+TfK5z/WlDE/K7s4oFAlOs
         6G4A==
X-Gm-Message-State: AOAM531lrcz21eFn/B4s30VW6risgwmFGFt5rIh6pQlA5HeVULhxUCo7
        bjwYQqeFsDJs+B1y2aUZSww=
X-Google-Smtp-Source: ABdhPJweOHwNi9iusbqt1/vXLKhh9ASeOUzYaRpHRq3v7BlzsU3ftEO6a8GlBrMszAsAPT4hI7PiJw==
X-Received: by 2002:a63:8f4a:: with SMTP id r10mr16634129pgn.337.1635212302107;
        Mon, 25 Oct 2021 18:38:22 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:8f62])
        by smtp.gmail.com with ESMTPSA id p9sm19860118pfn.7.2021.10.25.18.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 18:38:21 -0700 (PDT)
Date:   Mon, 25 Oct 2021 18:38:19 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 0/4] libbpf: add bpf_program__insns() accessor
Message-ID: <20211026013819.v75o22oz2cvsdokw@ast-mbp>
References: <20211025224531.1088894-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025224531.1088894-1-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 03:45:27PM -0700, Andrii Nakryiko wrote:
> Add libbpf APIs to access BPF program instructions. Both before and after
> libbpf processing (before and after bpf_object__load()). This allows to
> inspect what's going on with BPF program assembly instructions as libbpf
> performs its processing magic.
> 
> But in more practical terms, this allows to do a no-brainer BPF program
> cloning, which is something you need when working with fentry/fexit BPF
> programs to be able to attach the same BPF program code to multiple kernel
> functions. Currently, kernel needs multiple copies of BPF programs, each
> loaded with its own target BTF ID. retsnoop is one such example that
> previously had to rely on bpf_program__set_prep() API to hijack program
> instructions ([0] for before and after).
> 
> Speaking of bpf_program__set_prep() API and the whole concept of
> multiple-instance BPF programs in libbpf, all that is scheduled for
> deprecation in v0.7. It doesn't work well, it's cumbersome, and it will become
> more broken as libbpf adds more functionality. So deprecate and remove it in
> libbpf 1.0. It doesn't seem to be used by anyone anyways (except for that
> retsnoop hack, which is now much cleaner with new APIs as can be seen in [0]).
> 
>   [0] https://github.com/anakryiko/retsnoop/pull/1

Applied, Thanks
