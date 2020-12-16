Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3069F2DC32C
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 16:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgLPPeZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 10:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgLPPeY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 10:34:24 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A10C06179C
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 07:33:33 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m25so49329720lfc.11
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 07:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GbwSjRXYz/5ab4R4zIIU5K5iiHI2ES3d6oAX9GMDkzw=;
        b=EEW4HTtqnLPbkYmHJICO1m/LdfBt0n8HeaTkkWkl9Ym5WNcgWNxcIdBIpJri5C6o57
         ZM0AMjCuLYvWmDk+MjjmVl8eMQHdI18Ez/rOO06JfziyMgatgT9JxFxCgrWuRfjx7eHi
         hvjMbLpG7GIg4TUEI6HxIm5DdKAfceC5wayoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbwSjRXYz/5ab4R4zIIU5K5iiHI2ES3d6oAX9GMDkzw=;
        b=Bhm/NgeO1qQ9q+F/p0gcPZeXOZs1sItJH2SdocXgOtYOY9Em8AXKSSu1qbwruCL7Zg
         Vtpi32MX+hf+/IEa7KhJCz2t5bQ0bgOfEYk8b+PxwWV1b/A0OVHwbuNL/BIAqLq13OoO
         vW3NWH9W5e7bYQOrqvCWSd4qyVjY1y4SPMO+kNFl/NLYX/nIjx7lF411pzJco/ykOO1T
         ZytS42JNpYRRZRSI/CdbM2nyuEKps81mdtO7DTjJRReDrcgISDsWrnE/UPdJRiQCmhih
         fOavM7atu0uFXfDcjuyfYLgdjPqUg1c8Gq9oLPhRiRJA4enTp51Cr+biZbVhM5+GrHFq
         KnCg==
X-Gm-Message-State: AOAM533WSXW/HrZJIU2kxrWjQJ6LWXANXIKbGRafWuQBQ13/1IISji52
        6kpCSOYNeunTlZA5fLZv5UdPinr9ENTws1BL2gwuKg==
X-Google-Smtp-Source: ABdhPJwC0zgjuMxEMLEg4c6Dg088UTrJAJfBOlL7PfMrKzCbhgechotDehWkZSIs0AMOkFLV5ArQws5CJTmP9Y5cvWA=
X-Received: by 2002:a2e:8e3b:: with SMTP id r27mr15313442ljk.196.1608132811323;
 Wed, 16 Dec 2020 07:33:31 -0800 (PST)
MIME-Version: 1.0
References: <CACAyw98GbSi6UWDoN+A-B7Fct7fHsdgP67D5qf1oQVbUjdo1Fw@mail.gmail.com>
 <4fa59cd4-5fda-24e1-5382-a66579f51c7a@iogearbox.net>
In-Reply-To: <4fa59cd4-5fda-24e1-5382-a66579f51c7a@iogearbox.net>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 16 Dec 2020 16:33:20 +0100
Message-ID: <CACAyw9_1+XpOXSJ9ycsJqMzBF+DrDo8FLnMVzPP8aaPr8bbnWw@mail.gmail.com>
Subject: Re: Can we share /sys/fs/bpf like /tmp?
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 16 Dec 2020 at 14:56, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> > What were the reasons for changing the mode to 0700? Would it be
> > reasonable to mount /sys/fs/bpf with 1777 nowadays?
>
> If you don't specify anything particular a3af5f800106 ("bpf: allow for
> mount options to specify permissions") the sb is created with S_IRWXUGO.

Makes sense, thanks for the context. I checked iproute2, that mounts
/sys/fs/bpf with 0700 if it doesn't exist.

> It's probably caution on systemd side (?), currently don't recall any
> particular discussion on this matter.

Alexei then maybe?

> Either way, you can mount your own private instance of bpf fs instance
> anyway which supports anyway different mount flavors if needed [0]. So
> it's no different from tmp fs or others - apart from explicitly not
> having userns support.

Yeah, that's what we're doing at the moment. It's just another step
that is easy to forget, and makes some operational stuff more
complicated. So I wonder if there is a downside to just changing our
/sys/fs/bpf to 1777.

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
