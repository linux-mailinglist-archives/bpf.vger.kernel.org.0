Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7126436D76
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 00:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhJUWbE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 18:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhJUWbD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 18:31:03 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AC6C061764
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 15:28:47 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id g6so2726648ybb.3
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 15:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8IC//svY/zZt+CDPSHT9rgntEyJlaw1x6VGCAf1xKk=;
        b=E+OFCIaIyKzcJLfZHTkDuz5uAzhcPVFFWqTVdbrZYFIUUNbaIIW1YceGrtdX4CEWxx
         GCmlvbDJnbtpjKfzhA0bokadjaahweiGtcQmMwLZHpECERDBE2Q7RKJzLXzZOSq7+SPe
         S6IqxbqLUkoS4WPkoi0y6z+z26t5lFPFGVYCDsRlMrqPGLrOjTjwkjeE7eqRb+49JdPv
         Q2D0A/LbhmBiYS9nsL8gUdXkEOVxIVwOAF3ZLH4+QpnCbAVHv9a2OkDTmiFT+s4RSrbQ
         OZs3sIQ6IveoJwmeKeRzrSiY+B28YXtNByfF0R0caWdq8iMWXWDIiWCDPgaeQsHKZMQw
         7/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8IC//svY/zZt+CDPSHT9rgntEyJlaw1x6VGCAf1xKk=;
        b=FduVR9CeWwcD1ZWzZ3EjT9wpOnhtQHimsKKOQ5xN21RRDq7EULnnvzh+h5BeCIriMo
         nxeg/jBZzo1Ey1GtddgCN5rDV5cbmTrgMdb023OnNVxQpOjHx1n75X7zY4YdnAnhX2ru
         Z48ZzI8O2t/2HWhb2vcUSIhFOkJtMO7Po6fUzrHKGKX0mcHTIo35cw4WnqI+E24b+V2S
         iMZ++lyvltLhGoRGEDbxxtnqmXRslnfTKTVDt8MbB7vq294Z4EI9OMHkz1k5ctwsH5Se
         3/+AjQDF6YYWpQzwMkixiN5UndRVZ0CzJHTmegww82N2ELuAyQykir/KoD+f8UF9l2Qe
         zYYA==
X-Gm-Message-State: AOAM533SC0722/gYZvzGC9gSMm7xD3GMLc6AhYyRlFJrR+hurW2PSmug
        fZdfUTh9UXrGFdYgzUsdC7V1tbtNsBLf22JyUBI=
X-Google-Smtp-Source: ABdhPJxLw9tkrygHKyPDfwLSTyXACniaPI5XID6FfdULCaTTwE+cqTEqKaU9pC8Xlc6C/TvDDjRQZAwA4Dx4hprdXzY=
X-Received: by 2002:a25:918e:: with SMTP id w14mr9328184ybl.225.1634855326232;
 Thu, 21 Oct 2021 15:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211021054623.3871933-1-andrii@kernel.org> <CAADnVQJY6xQqGhGhA2V2Np43tLsDRS67=WZsM1ZgKj_tA0Y-5A@mail.gmail.com>
In-Reply-To: <CAADnVQJY6xQqGhGhA2V2Np43tLsDRS67=WZsM1ZgKj_tA0Y-5A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 21 Oct 2021 15:28:35 -0700
Message-ID: <CAEf4BzZVAf+eADCCvnf7bQ5H6A-mt0QwthvynFh4DwLvWNKFVQ@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: fix BTF header parsing checks
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Evgeny Vereshchagin <evvers@ya.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 21, 2021 at 3:16 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 20, 2021 at 10:46 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Original code assumed fixed and correct BTF header length. That's not
> > always the case, though, so fix this bug with a proper additional check.
> > And use actual header length instead of sizeof(struct btf_header) in
> > sanity checks.
> >
> > Reported-by: Evgeny Vereshchagin <evvers@ya.ru>
> > Fixes: a138aed4a80 ("bpf: btf: Add BTF support to libbpf")
>
> there is no such commit sha.

Oops, seems like I lost the first digit, it should be:

8a138aed4a80 ("bpf: btf: Add BTF support to libbpf")
