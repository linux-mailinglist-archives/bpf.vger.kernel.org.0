Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C2E46DB87
	for <lists+bpf@lfdr.de>; Wed,  8 Dec 2021 19:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbhLHSxL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Dec 2021 13:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhLHSxK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Dec 2021 13:53:10 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696C0C061746;
        Wed,  8 Dec 2021 10:49:38 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id y68so8234531ybe.1;
        Wed, 08 Dec 2021 10:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+cnY1K0okMsy3PLdY/Hy3A5G3SC1P+IzOqryKEdViU=;
        b=pSKzaBz7zcDFymm1wtwiiDN6aUW8TiCEGrETMHDhdOjhC1utJBAkpBsIMsISNCSdZ/
         EbaOZ2T01hqDQwsflXysC1bfhio4TvVpqsvyPQ1P3zfkVRXx6iCiiRBpR4FUXClNdA2w
         ENqi0z3g1NZGDIFhQHNBEaGmwPoAXd5/mZpVdNKsr5tzFLu1SEhd4mst6G1SoV4AfP98
         MXO6h/lfWrh47xjv+Y3A6fV6V0qW1CThtavOXwbeR9ZKk1XVFIiXz7l3pIs9SMXSCnH0
         w2YTyPaWQoxGZy7OeWKFPbs5wZI+7s/9WAX5Qll3Ookhn37jnjSjsKsOR4OFfOPVpgDX
         w/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+cnY1K0okMsy3PLdY/Hy3A5G3SC1P+IzOqryKEdViU=;
        b=pGPaUvdx2Bls90oyLHhYCydqjfse3BtEEdJyoXgtr8na6MPjnn4eGWibyYK5robAjn
         66/N5kQeWzJ3sdE91DaOsC25gOBygNGEOYfllFfQ9G48ZK7AVXSudw7vkBN+usuIh/w7
         cAoes4hTKl2j3XG72xqmdZyQ/xRGwVMHOTn7pDZkZtxNkt8LgmGTR5KD2rJbU3aqMJuB
         8xw/jHrhzvBV9w1hQh/2pBmTw1pPnI3aw4may2Xg/a7DZnAAPRVHwVHqW8T8BPlZoRps
         z0E+e7HTCGLtCoBDlGay0szmrh9HN7sybSq0ly6Tm5Wf1Z+TQfRPqumOWNc4phBiDuBo
         pwlw==
X-Gm-Message-State: AOAM5300uC0/QViM8aY+tGl/bhkotMhEWA/7F2fSFDJRCJo5EYmV0GDu
        +s8cjloSIyBce7n5JbzUCU6yEb0+iH/Kz3Y9rmY=
X-Google-Smtp-Source: ABdhPJw5nDKdujDVS5FnoFyewmISuVafleuckZyVOUQ3wkY2W3bGJrIKe4ROd6hrjnE5xQdsvC/dTLoLs7Uav4YAuKg=
X-Received: by 2002:a25:cf46:: with SMTP id f67mr573646ybg.362.1638989377662;
 Wed, 08 Dec 2021 10:49:37 -0800 (PST)
MIME-Version: 1.0
References: <YSQSZQnnlIWAQ06v@kernel.org> <YbC5MC+h+PkDZten@kernel.org>
 <1587op7-6246-638r-5815-2ops848q5r4@vanv.qr> <YbD696GWcp+KeMyg@kernel.org> <YbD7bTb3gYOlOoo3@kernel.org>
In-Reply-To: <YbD7bTb3gYOlOoo3@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Dec 2021 10:49:26 -0800
Message-ID: <CAEf4BzaSNhFgd==Yv=W=hBL53_wBe9EGsxT-x3v-3VCTuHASpQ@mail.gmail.com>
Subject: Re: ANNOUNCE: pahole v1.23 (BTF tags and alignment inference)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jan Engelhardt <jengelh@inai.de>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Yonghong Song <yhs@fb.com>,
        Douglas RAILLARD <douglas.raillard@arm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Matteo Croce <mcroce@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 8, 2021 at 10:37 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Dec 08, 2021 at 03:35:36PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Dec 08, 2021 at 03:26:31PM +0100, Jan Engelhardt escreveu:
> > > On Wednesday 2021-12-08 14:54, Arnaldo Carvalho de Melo wrote:
> > > >   The v1.23 release of pahole and its friends is out, this time
> > > >the main new features are the ability to encode BTF tags, to carry
> > >
> > > [    7s] /home/abuild/rpmbuild/BUILD/dwarves-1.23/btf_encoder.c:145:10: error: 'BTF_KIND_DECL_TAG' undeclared here (not in a function); did you mean 'BTF_KIND_FLOAT'?
>
> > > libbpf-0.5.0 is present, since CMakeLists.txt checked for >= 0.4.0.
>
> > My fault, knowing the flux that libbpf is in getting to 1.0 I should
> > have retested with the perf tools container based tests.
>
> > Can you think about some fix for that? Lemme see if BTF_KIND_DECL_TAG is
> > a define or an enum...
>
> enum {
>         BTF_KIND_UNKN           = 0,    /* Unknown      */
>         BTF_KIND_INT            = 1,    /* Integer      */
>         BTF_KIND_PTR            = 2,    /* Pointer      */
>         BTF_KIND_ARRAY          = 3,    /* Array        */
>         BTF_KIND_STRUCT         = 4,    /* Struct       */
>         BTF_KIND_UNION          = 5,    /* Union        */
>         BTF_KIND_ENUM           = 6,    /* Enumeration  */
>         BTF_KIND_FWD            = 7,    /* Forward      */
>         BTF_KIND_TYPEDEF        = 8,    /* Typedef      */
>         BTF_KIND_VOLATILE       = 9,    /* Volatile     */
>         BTF_KIND_CONST          = 10,   /* Const        */
>         BTF_KIND_RESTRICT       = 11,   /* Restrict     */
>         BTF_KIND_FUNC           = 12,   /* Function     */
>         BTF_KIND_FUNC_PROTO     = 13,   /* Function Proto       */
>         BTF_KIND_VAR            = 14,   /* Variable     */
>         BTF_KIND_DATASEC        = 15,   /* Section      */
>         BTF_KIND_FLOAT          = 16,   /* Floating point       */
>         BTF_KIND_DECL_TAG       = 17,   /* Decl Tag */
>         BTF_KIND_TYPE_TAG       = 18,   /* Type Tag */
>
>         NR_BTF_KINDS,
>         BTF_KIND_MAX            = NR_BTF_KINDS - 1,
> };
>
> Do you guys have any plans on updating libbpf?
>

In what sense? It's already updated and knows about all those new KINDS ([0])

  [0] https://github.com/libbpf/libbpf/blob/3ef05a585efd47abf4dc92265430d0248d7f388a/src/btf.c#L302

> - Arnaldo
