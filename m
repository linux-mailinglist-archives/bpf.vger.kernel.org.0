Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA144C05B
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 12:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhKJL5u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 06:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJL5t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 06:57:49 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA0DC061764
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 03:55:01 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id t11so4774808ljh.6
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 03:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJBYeKbyuFnxWRx/yzd9DIfo4zFjEF+kJb4DPlegKoU=;
        b=yvTU+Pn638oDi5a5GEV4t1ihLSjORPtRlQUmlcW7QSm517HNztsIu00bRPycn9Ko2Y
         E8f30nQnMQ5lZH9Nl+tfyq1+xNw6bz8NVy/exMCdJxeZ6u2JUEHxuc5m42mrK/ToWrsh
         GRx+BoJEqwuzwD+O+2Thz8uED4UE/CYIEa4aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJBYeKbyuFnxWRx/yzd9DIfo4zFjEF+kJb4DPlegKoU=;
        b=EOv2TggLXiSjrTKya3KPhonNLkwX5N/qj9zs+TmHBcnhImC5flPtFnyiofnCdxzpD2
         eV47G3ork5E4kPcjVBTocdhuaZ6T9R2n0obeEIx/LXoFxSzj2pieipA03uNfdFymyw/L
         ryE+CBVqUoeJ1rRVlMjQeOAIbSmzaf0owvAC63m476F+qEcY3w3a4E07ZuRi9C4fyRIQ
         1kONmIMNvReWNBJ+pkyFGappntavetXSL+iV4ASUPqVqCH3WW5vcPv2jtipd8/fN4Rkx
         KmO19DXzCxgLL5mAcy/r06avlGx/DtNp17JvlQtR6hgjUA5Uk3XusTH1NnJA+RP4f6nS
         GY/A==
X-Gm-Message-State: AOAM533If0Dx56SxPpqmPh3BdlWIsUhhOkPeVjo0MP0ROOikGY8qb8UX
        aWphnQaEYwkQPG+bG0U3iTIHJRGZ8RQlW/tKqXICWA==
X-Google-Smtp-Source: ABdhPJy8ULRwKBmn+C3Fc8lyYoeoDPUCQKNOf/5sGl8YbhpO9Sl5ko934GsOxzQhtayRJGOHYFHRqJW2QnN/umJkR2w=
X-Received: by 2002:a2e:b545:: with SMTP id a5mr14883106ljn.510.1636545300069;
 Wed, 10 Nov 2021 03:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20211110111016.5670-1-markpash@cloudflare.com>
In-Reply-To: <20211110111016.5670-1-markpash@cloudflare.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 10 Nov 2021 11:54:49 +0000
Message-ID: <CACAyw9_eT54_Az5B5pWVL86rii6BpKH8BT_HeKZWq4j4FNZAYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/2] Get ingress_ifindex in BPF_SK_LOOKUP prog type
To:     Mark Pashmfouroush <markpash@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Nov 2021 at 11:10, Mark Pashmfouroush
<markpash@cloudflare.com> wrote:
>
> BPF_SK_LOOKUP users may want to have access to the ifindex of the skb
> which triggered the socket lookup. This may be useful for selectively
> applying programmable socket lookup logic to packets that arrive on a
> specific interface, or excluding packets from an interface.
>

For the series:

Revieview-by: Lorenz Bauer <lmb@cloudflare.com>

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
