Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706BB41B8C2
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 22:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242768AbhI1U5s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 16:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242764AbhI1U5r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 16:57:47 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDD4C06161C
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 13:56:07 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 17so379214pgp.4
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 13:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7YNq2K97Nd1xWfmsNA+rmOvJob0o9TebyYRAsD8+4s=;
        b=X7YHqC3Tv4CDiG8i2KH9ODy1YCnAEfFd2hJ16W7XHmdi755k/m1Yo4yK/DKBXrD/1B
         yVzeDjZg/TNaWrweLW/KYrlM5FvXqm+iuXyfGTNXOM02VlXrTX8zEdan6qBA0Bg5d3//
         Y3TarE+kT0TH2GXxCGt0OrVe+Ezwc3p3ZHAF8sqS43kL60ol4JArK5QjMTXH6yJ3+A2P
         7HEx3137auJN/FtAw1e5/ExPMIFDTt3M3l/eCLUpuJwlQkif7l7H2cn8Q0qgMu81FlQU
         lXvcTBU03dol92myHWGHHkiEwlanmhewsVZVNv4s+owBfxTEFnTz880LgtHVm4QI0xI7
         trfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7YNq2K97Nd1xWfmsNA+rmOvJob0o9TebyYRAsD8+4s=;
        b=XUyuay1n5DmCtX13CEmjUSmoIop7P5AFNXytvjoCEWTjF3EHCKKxNoA5G80BU+N2h0
         hwFmPD7nS5X+o/dutsGOXLHWWBLmi0DE/zhab1zDFyRJCsSj0EQ8OuStU/09hM+pvY3e
         JqYrENzSwdq211h2oCmxu5+bMWjogrG6bNYKKgwxQqXbBYUcdoEBKPAkmbabFowO2WEq
         0w/591T/Fqme9YKNXpwv/ByPvKdP2tko1Q4XiGENdV33NMX0b/rbVeGmgAukLNcf3bLi
         Yx/8ZZFfMPnJ7ycqBCEHwTQ/avt5r5NGmtrdH7qwRPWBljN5taRsVFXOZ8Mk4CSD7/MI
         wEjg==
X-Gm-Message-State: AOAM533WUUe5MJLkmKdUjg91YzbAZQ4LK4cbBii3xXZc/wjLAkQf3HJt
        qkm6+OdQekmTuKYe9x8JEAlon3SA8ya4ssGN83gR2WyI
X-Google-Smtp-Source: ABdhPJz8qr0RkA+kxsTbH8rWzPOg1jaqZyCEhLJAWa9ZEnsr8u2WjTTxG4N9gJ5zbOLpoXH2XsV24P+Cvw3j4FjNpSA=
X-Received: by 2002:a62:2707:0:b0:44b:4870:770b with SMTP id
 n7-20020a622707000000b0044b4870770bmr7621473pfn.59.1632862566979; Tue, 28 Sep
 2021 13:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210928161946.2512801-1-andrii@kernel.org>
In-Reply-To: <20210928161946.2512801-1-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 28 Sep 2021 13:55:55 -0700
Message-ID: <CAADnVQLyJ1VSXCLspsjFX46v190skVPzEpF1yMKdW7CDMPMwhw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/10] libbpf: stricter BPF program section
 name handling
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 28, 2021 at 9:57 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Implement opt-in stricter BPF program section name (SEC()) handling logic. For
> a lot of supported ELF section names, enforce exact section name match with no
> arbitrary characters added at the end. See patch #9 for more details.
>
> To allow this, patches #2 through #4 clean up and preventively fix selftests,
> normalizing existing SEC() usage across multiple selftests. While at it, those
> patches also reduce the amount of remaining bpf_object__find_program_by_title()
> uses, which should be completely removed soon, given it's an API with
> ambiguous semantics and will be deprecated and eventually removed in libbpf 1.0.
>
> Patch #1 also introduces SEC("tc") as an alias for SEC("classifier"). "tc" is
> a better and less misleading name, so patch #3 replaces all classifier* uses
> with nice and short SEC("tc").
>
> Last patch is also fixing "sk_lookup/" definition to not require and not allow
> extra "/blah" parts after it, which serve no meaning.
>
> All the other patches are gradual internal libbpf changes to:
>   - allow this optional strict logic for ELF section name handling;
>   - allow new use case (for now for "struct_ops", but that could be extended
>     to, say, freplace definitions), in which it can be used stand-alone to
>     specify just type (SEC("struct_ops")), or also accept extra parameters
>     which can be utilized by libbpf to either get more data or double-check
>     valid use (e.g., SEC("struct_ops/dctcp_init") to specify desired
>     struct_ops operation that is supposed to be implemented);
>   - get libbpf's internal logic ready to allow other libraries and
>     applications to specify their custom handlers for ELF section name for BPF
>     programs. All the pieces are in place, the only thing preventing making
>     this as public libbpf API is reliance on internal type for specifying BPF
>     program load attributes. The work is planned to revamp related low-level
>     libbpf APIs, at which point it will be possible to just re-use such new
>     types for coordination between libbpf and custom handlers.
>
> These changes are a part of libbpf 1.0 effort ([0]). They are also intended to
> be applied on top of the previous preparatory series [1], so currently CI will
> be failing to apply them to bpf-next until that patch set is landed. Once it
> is landed, kernel-patches daemon will automatically retest this patch set.
>
>   [0] https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#stricter-and-more-uniform-bpf-program-section-name-sec-handling
>   [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=547675&state=*
>
> v3->v4:
>   - replace SEC("classifier*") with SEC("tc") (Daniel);

Applied. Thanks
