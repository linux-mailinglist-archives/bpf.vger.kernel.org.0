Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC33E30C3B2
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 16:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbhBBP01 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 10:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbhBBPZZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 10:25:25 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CBAC061788
        for <bpf@vger.kernel.org>; Tue,  2 Feb 2021 07:24:44 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id lg21so3241525ejb.3
        for <bpf@vger.kernel.org>; Tue, 02 Feb 2021 07:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIRz/qmNHPd2tbUMQo4AtdAVZoeVdYva2t3igHKGKl4=;
        b=QVE5tE4LsL8ixPkCNOFxPaOzvtW5s8i0EZto0/S+SwvmJhGUjdl+pHx3TB+EzdzQFK
         7SZwBMgQlBy3k+t/+PMIZJa0EOfXzUVUeg+8D+6hVFKnG70fSlU8XmI5l7j5cPoPuoHa
         /cPWzR3KXGkd7rdhSNaevjvanFh2tL4/r/EGrKv2S3bG56fv8G5+EoDJV+qlDeVUtbTA
         Cz03wW4XCJqmHOffBNQsSVmDXRYFuHgP7IIaDo100ilx4s3eG5KxPP8J4ZyFUVe0KHLG
         ExwDF82E+HSc4vaO39alCNFnfe6tkEUX2vZFkIj6Dmhj685XmQhy97nPE0lwufV2DjCE
         JAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIRz/qmNHPd2tbUMQo4AtdAVZoeVdYva2t3igHKGKl4=;
        b=MX9PNdzDxcuujp2BTpqRFsMyADtQkL44S2Q08gOVD1zODV95GoMJ86DhL5ppy9zSjG
         3E9bHzO+K9WkUAzBX//7UIO9THybl3aHf0z6oRCc+nzrVKgMwEqSUlhsdaZo7n2479H6
         eyYMtaKEerb5rWmBB/1slYji35ZSeRZF5Y4mEK2TcKyD5Fefi1nUoTYsmT4Q2azunOxM
         WPuROwYqijXtq4vEGrkWI/bqrziG30UN4GxUzHuMJStvlvhJyJYa4ERnKbvcsBtw96x1
         jqNRcPPVd+YWcWtH0S3GpKAsgRxkj0H4HGSPo8bh1ii4LS59FglMv0QySXAeNFG17I+1
         G+Lg==
X-Gm-Message-State: AOAM530pEi5/GMS+MvAOpqGeyoQ+MZxCTvHcEJKokpoNe4aCegMYSu4u
        7kbZ/xF5jDl7ENYCN+YxqjRgStKfkE71hxhinnIUWJ2HJSb5
X-Google-Smtp-Source: ABdhPJxfceIpUpL9QOzPJiBALgYaPapZrEcVE0SyYa1sSnHb4evF65MHt1+2ZDcMxurEeQsaMP+EC8nkrHixjzn/xOg=
X-Received: by 2002:a17:906:ff43:: with SMTP id zo3mr22845900ejb.542.1612279482885;
 Tue, 02 Feb 2021 07:24:42 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhQgy959hkpU8fwZnrTqGphVSA+ONF99Yy4ZQFyjQ_030A@mail.gmail.com>
 <CAADnVQJaJ0i2L2k-dM+neeT61q+pwEd+F6ASGh4Xbi-ogj0hfQ@mail.gmail.com>
 <CAHC9VhSTJ=009hsXm=8jtQ_ZL-n=+tzKPbWj2Cnoa5w3iVNuew@mail.gmail.com>
 <CAADnVQKbku+Mv++h2TKYZfFN7NjPgaeLHJsw0oFNUhjUZ6ehSQ@mail.gmail.com>
 <YBXGChWt/E2UDgZc@krava> <YBci6Y8bNZd6KRdw@krava> <20210201122532.GE794568@kernel.org>
 <YBgVLqNxL++zVkdK@krava> <YBhjOaoV2NqW3jFI@krava> <CAFqZXNsjzQ-2x4-szW5pBg77bzSK-RmwPvQSN+UaxJXqqZ_2qA@mail.gmail.com>
 <20210202124306.GA849267@kernel.org>
In-Reply-To: <20210202124306.GA849267@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Feb 2021 10:24:31 -0500
Message-ID: <CAHC9VhT2_3D1MDFEOiStHS_X6=Opop=xmj5Zpv9bEKTQDM6gDA@mail.gmail.com>
Subject: Re: selftest/bpf/test_verifier_log fails on v5.11-rc5
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 2, 2021 at 7:43 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> I've updated a f33 system to rawhide to test all this, fixed up some
> extra warnings wrt mallinfo(), strndup() error path handling/potential
> buffer overflow issue and will add a conditional define for
> DW_FORM_implicit_const found in the libbpf CI tests that Andrii pointed
> out to me, then go and tag 1.20 and do the rawhide/fedora package update
> dance.

Thanks for taking care of this.  FWIW, it looks like both my x86_64
and aarch64 test runs with your Rawhide scratch build went through
without a problem last night.

-- 
paul moore
www.paul-moore.com
