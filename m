Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868713E50FE
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 04:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhHJCML (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 22:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhHJCMK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 22:12:10 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D527C0613D3;
        Mon,  9 Aug 2021 19:11:49 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id x19so131092uat.2;
        Mon, 09 Aug 2021 19:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0aJYD6TjTDMi3R9m4pgh65PD1DpJvMkeB8G/Vjd7x0=;
        b=iX5627+50O+w7tY7Cx0TB4COgpo90xKNCN+iDrRhyB22OxcEDE2ZmusDTF0xlITbSZ
         MM7ZVCICBUTRDtipUnR1skjQU30zce38v19btEmXyI2/XN98i3zUBukxI/XX1tsoX2yW
         HnW2UAlZivkAa/Rf41H4Y6mrAZek0BCtVCaEA4JJqkczX4U3BO+GwHd0S8MrDWl3yrqt
         WqtsavoBITGNsYAGDAS6UrjyPmqO8FEPxWRbUiV/qAIw73s1VUADpiGG9BGXY9YRZDMC
         WeodRCVTTwJQQ5Z/uucU5bVat6r/BT7AZS5cKYzWIsXWdufViBueISd+FHRmSDVvbyJ+
         Jg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0aJYD6TjTDMi3R9m4pgh65PD1DpJvMkeB8G/Vjd7x0=;
        b=PpDnpra6gp/JbDO8UixX8e/u4OqB6kY6J2msrLkXaDI33DTtnE4ZfV2Ll25s5Uql2V
         9rm5LcW13Y0imeAOuQML+by7sXLO3tNhpU/YjBha7XQsXnNS6YrCOSmJmOmMozVWvoVI
         /3uj3KImZd+hyaN5vSqI4ceQXbIHQZRB/sckL3YkFaqrng8mcCcG3ZpjMZK5CKJqtyIM
         G8iAaQ3JV6/1AinxXrYrZiu+9YVyO+iOQNcZosP92+Ne7gtqCSjAdL25lhoPT9l44nZF
         T5vcpubNHQkNFj1QcUI5DadYDwxbbv6NSVnupdHZlqI8cf+3OkQD1H7esUJCzB34Q5Ob
         53uw==
X-Gm-Message-State: AOAM533uNFHyD42GUnYzF3CdFUFwO5ypFbFAzg122wCd1jVH0+laEdJp
        Fh+0SZ3/otxxSo2735OwFmzceOHKDPlhiJhfSAM=
X-Google-Smtp-Source: ABdhPJzt2PYRxiXJ0IZnBsmNX2iOQMJpUWz+w89tGaOhKsxFTXrX8A4cKRSSibcnHvzJq2jKP7+ev3iEqt/fehzld0k=
X-Received: by 2002:ab0:3ca7:: with SMTP id a39mr5849776uax.127.1628561508276;
 Mon, 09 Aug 2021 19:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210810020508.280639-1-grantseltzer@gmail.com>
In-Reply-To: <20210810020508.280639-1-grantseltzer@gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Mon, 9 Aug 2021 22:11:37 -0400
Message-ID: <CAO658oWxU2dWvgojR-XnmHYyYeCxiB6VAefGvmHx=5=bX0q-TA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Reconfigure libbpf docs to remove
 unversioned API
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 9, 2021 at 10:05 PM grantseltzer <grantseltzer@gmail.com> wrote:
>
> This removes the libbpf_api.rst file from the kernel documentation.
> The intention for this file was to pull documentation from comments
> above API functions in libbpf. However, due to limitations of the
> kernel documentation system, this API documentation could not be
> versioned, which is counterintuitive to how users expect to use it.
> There is also currently no doc comments, making this a blank page.
>
> Once the kernel comment documentation is actually contributed, it
> will still exist in the kernel repository, just in the code itself.
>
> A seperate site is being spun up to generate documentaiton from those
> comments in a way in which it can be versioned properly.

For more info regarding the above mentioned separate documentation
site, see https://github.com/libbpf/libbpf/pull/357
