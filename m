Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5DC32325B
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 21:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhBWUq4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 15:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbhBWUqY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 15:46:24 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1883C061574
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 12:45:43 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id h25so60845eds.4
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 12:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NozYZU1bAfNdIG5JtSkKa87zG+RKiElyAQ58w2uVmeo=;
        b=agp6o9eThVt8g6uYecy/26AFJ+sZf2asJYY/D1b5z3LlpYuzgrW2ftto7UEQ4W3jcW
         swe6+KSKtIEbbCeOCTM+hY58p7RgPUgcicOAqT+sIYt4thhrYyRXx1M6kipY+7VVZORV
         NU+orB37SLwA3uxxg+RhC7CRpithufDilXPXC5fM832FbA3CgRgrf0JKtSdEC8abxQRZ
         KlYsvuE/2dbOkg7E5grvp+VNDaDbvdW9ISQuxcI5kFsByazw1+xKLC4SaUAJfBzlWjAm
         n/d0r4VP7c56SSmurZ6bdCuCYvV4AVMZRNno1za1JaV+IpM5yFMICQ3x/m9Lwe/WbzYO
         84lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NozYZU1bAfNdIG5JtSkKa87zG+RKiElyAQ58w2uVmeo=;
        b=V2p4ZwxwDQIUV6FhNSQUfRsgpnlh1bQQmTOuoNCw6940eijYH8mBHqXo71IxNX4c1g
         VazJDUllDvAFNfziDCI4i4r+oCwQLMi0Ihx7iwZKBiT06GuqYpU7sCXAsCNyp0ggxxO1
         1BCibkrSOQi6Yjler7qPb5lyBLrtx5H7dU4DT/zLPonRFWhZ0zmYN3+gaQJaG9Q8pr7m
         xSjBuTaC9L7aOdNalwOQ3yzqSUqsCzcHPzzKMzjvGSZ6/7rVIyx4E1kwMByimpaYPDMF
         zQU+sVFbMMLgwqhaShB45JmA7UYPvgSVoxT4oCMFqaOXPJy3wl0x4yu/R3LKlGXX7UY8
         DEIQ==
X-Gm-Message-State: AOAM530FmNzbnFgGzjbCHjWh6giNbZI8aCyuMT5+u5Q0ePENKIVMBNDJ
        fl6/pDmnnU5Gb/nGrGm8BMnk6ZX86lzAo1a79Omx
X-Google-Smtp-Source: ABdhPJyjgdQi2IP6HpUZrBMWFCYnTVpoLP8+fLj4S1n8ilxv8EoVfH867O0aR98uL7Kx7FmP8RAXtd6aoHHQeY2ga48=
X-Received: by 2002:a50:a086:: with SMTP id 6mr29295197edo.70.1614113142343;
 Tue, 23 Feb 2021 12:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20210212211607.2890660-1-morbo@google.com>
In-Reply-To: <20210212211607.2890660-1-morbo@google.com>
From:   Bill Wendling <morbo@google.com>
Date:   Tue, 23 Feb 2021 12:44:58 -0800
Message-ID: <CAGG=3QWuxzwKGuYhVu+EfXPFZMNsO7-=NtHbdXAyvcVjvKF3hA@mail.gmail.com>
Subject: Re: [RFC 0/1] Combining CUs into a single hash table
To:     dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bump for exposure.

On Fri, Feb 12, 2021 at 1:16 PM Bill Wendling <morbo@google.com> wrote:
>
> Hey gang,
>
> I would like your feedback on this patch.
>
> This patch creates one hash table that all CUs share. The impetus for this
> patch is to support clang's LTO (Link-Time Optimizations). Currently, pahole
> can't handle the DWARF data that clang produces, because the CUs may refer to
> tags in other CUs (all of the code having been squozen together).
>
> One solution I found is to process the CUs in two steps:
>
>   1. add the CUs into a single hash table, and
>   2. perform the recoding and finalization steps in a a separate step.
>
> The issue I'm facing with this patch is that it balloons the runtime from
> ~11.11s to ~14.27s. It looks like the underlying cause is that some (but not
> all) hash buckets have thousands of entries each. I've bumped up the
> HASHTAGS__BITS from 15 to 16, which helped a little. Bumping it up to 17 or
> above causes a failure.
>
> A couple of things I thought of may help. We could increase the number of
> buckets, which would help with distribution. As I mentioned though, that seemed
> to cause a failure. Another option is to store the bucket entries in a
> non-list, e.g. binary search tree.
>
> I wanted to get your opinions before I trod down one of these roads.
>
> Share and enjoy!
> -bw
>
> Bill Wendling (1):
>   dwarf_loader: have all CUs use a single hash table
>
>  dwarf_loader.c | 45 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 12 deletions(-)
>
> --
> 2.30.0.478.g8a0d178c01-goog
>
