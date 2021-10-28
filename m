Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A61F43DE11
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 11:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhJ1JwA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 05:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhJ1Jvq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Oct 2021 05:51:46 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9363CC061225
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 02:49:18 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id k13so9607200ljj.12
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 02:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fk20SFTna7oenyJFMvCkJ++ZR0TFp2usytKYkzVEf0s=;
        b=kf7QbjWu1KoXK2GcxquXY75XDFKY96HN8PhY+2IdmX0My5dsmxhOifxj3w+ZaB8bI1
         mTFK+tYsuwaU9fDQtOw0yMiZeS4i4l45HAoV8jZRaqMfQKixIfM+z9QIDq1gQI2fnCPM
         cKkuo2/nXat3lC4ncjsZfWKecL2Cq0VFHHxyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fk20SFTna7oenyJFMvCkJ++ZR0TFp2usytKYkzVEf0s=;
        b=FALawloYL2p94sAFWwN5T3h4O8zU5+VtyOy897IfwN2QvWjvq6q88+WgMPUWczreq+
         zKiepMLrqFIqE5D4ENesoZmSe3hMfxOONYjQFrZx8syAG2nzER78Jr1Wf2JnjY7B8hVu
         bCuT03v/h5g+Y/i0j1lGGztQddJPDIhWA4cE+dMexOQ5t5sUDxA7WL5EiU5OeYOrlKM5
         rUootYC2Ioh3DF1J2mZXCfBfTur0xQpn0WwgMxyShQ9aj0txNq9cKroojTFJLP2KDhOD
         AdN46ml+gpphnwMXIhcAXFZoJfoNX9x7PnB+5kqVESvGg7j0AhKGjNLTh6lL/I1Opi7k
         xVPA==
X-Gm-Message-State: AOAM532QmL1LFBR2qY0JPwHg5lANP0fD70R2pTh6+g+HMfZsRsh/LRKW
        ogsyIPtSKFOBp8fVzYJs1LixsSEmeQOOlGviMfPWsQ==
X-Google-Smtp-Source: ABdhPJy79YQNwa1VedoC9Fu2+mb2Y9ZRSMvFCQS6gRxPDar6Suys0za7kSVoiq/FhiIJ2iaPRaXNwxunO+FZ+29u4rE=
X-Received: by 2002:a05:651c:2328:: with SMTP id bi40mr3584357ljb.121.1635414556987;
 Thu, 28 Oct 2021 02:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211021151528.116818-1-lmb@cloudflare.com> <20211021151528.116818-2-lmb@cloudflare.com>
 <b215bb8c-3ffd-2b43-44a3-5b25243db5be@iogearbox.net> <CAOssrKciL5EDhrbQe1mkOrtD1gwkrEBRQyQmVhRE8Z-Kjb0WGw@mail.gmail.com>
In-Reply-To: <CAOssrKciL5EDhrbQe1mkOrtD1gwkrEBRQyQmVhRE8Z-Kjb0WGw@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 28 Oct 2021 10:49:06 +0100
Message-ID: <CACAyw9_yWL2YdYs2WbZ-Up2MqUKH7s5=g+v230TzYa=A4gx9SA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] libfs: support RENAME_EXCHANGE in simple_rename()
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 28 Oct 2021 at 09:43, Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> This is not sufficient.   RENAME_EXCHANGE can swap a dir and a
> non-dir, in which case the parent nlink counters need to be fixed up.
>
> See shmem_exchange().   My suggestion is to move that function to
> libfs.c:simple_rename_exchange().

Thanks for the pointer, I sent a v3.

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
