Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D131229D9EE
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 00:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389998AbgJ1XGT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 19:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388293AbgJ1XGG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Oct 2020 19:06:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB21C0613CF
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 16:06:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y14so691896pfp.13
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 16:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9PplpyvvaIOj2Y/5kJ2lSLbGtePMNRLQQnpCF0jdyN0=;
        b=TdohaQZ/BrRblyumctbhdJ4bNszcr6wO6SUFTzytM/C04THUKCMfKnp+tPTZ0GRTJj
         0YSBLwrj0SLmuGrxSOz2Vw03WyZiAyI7RdZbEIskrACPIs/md9Dlmtn+6kDQJBGbauoG
         E58xUoxQSho+vXimj1OCNMDTRkBLggfwyxj93+6agKlKzbhVgGnqCgFdvIDghloLxvlm
         3GB2BzuC4kR/d2d8psFc2VEhsFLJj4C3lHTg3sOXblIKNgDOPUEupKhD8ncjeOZn2NkI
         +3cByYfqzeG0soGXcGV7dGDhbM8K9lY0Fb0LnCRl1UMO+05NDZIjNmgUi+Wkp7WGVxUk
         7kLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9PplpyvvaIOj2Y/5kJ2lSLbGtePMNRLQQnpCF0jdyN0=;
        b=klZuVUMPlrbfF2Ji40HTrFfmFxm2K+g1uG2+uDUDs2ZmbylSO8Rusn2K4UQsMhKcoH
         HWZ0WGTWpzEyT/qLYVymhJHbkQfh0rbIiuSv0SCFPwAMojO+IErKNBmmaUiN1b+4U0JF
         Va+8f8MN0VDRsjUvjj1LGg0SPpVeBevetZ4FLriHzXOI627JQAFkg5/5IzJjdX/Dz5io
         YUmlAKi2xSCMI/urOprDK9kjvoMC1bRzualF+4Py8nltoAeFEkD1OS6kG7KJkccbGLp9
         f2vFdRprlhQazWjVF7CGq4Kf4gsQQ0V1YnxtXQaDyMqh+ldMy63hMrZ2RNe2bh2ugRKJ
         Nevg==
X-Gm-Message-State: AOAM531RE2PgFL2l2MMpohJ0ZUgHQABfm+J+jhXKfQRuvZFbnajlMVeU
        kjHT8UUky+BDvJY+kKYjjUU=
X-Google-Smtp-Source: ABdhPJw7StgrmEFbkTjxvJGz0lPIOGyNZ/S7J7dQmlJJ1fanOK+HDmNms/ALpH5Ox/uqKvB0nVys1w==
X-Received: by 2002:a63:e906:: with SMTP id i6mr1484658pgh.114.1603926365660;
        Wed, 28 Oct 2020 16:06:05 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::4:1c8])
        by smtp.gmail.com with ESMTPSA id z23sm416779pgf.12.2020.10.28.16.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 16:06:04 -0700 (PDT)
Date:   Wed, 28 Oct 2020 16:06:02 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Alon, Liran" <liran@amazon.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Dan Aloni <dan@kernelim.com>, bpf <bpf@vger.kernel.org>,
        security@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH] btf: Expose kernel BTF only to tasks with CAP_PERFMON
Message-ID: <20201028230602.4g7guvb5nzgosgwb@ast-mbp.dhcp.thefacebook.com>
References: <20201028203853.2412751-1-dan@kernelim.com>
 <CAEf4BzZxabLCaNj0E5UEcnrEY25ujSLOzTbYRXneJy2HrY64JA@mail.gmail.com>
 <3bccbaac-ec63-bc06-0e4b-5501c0788822@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bccbaac-ec63-bc06-0e4b-5501c0788822@amazon.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 29, 2020 at 12:30:49AM +0200, Alon, Liran wrote:
> > Guarding /sys/kernel/bpf/vmlinux behind CAP_PERFMON would break a lot
> > of users relying on BTF availability to build their BPF applications.
> True. If this patch is applied, would need to at least be behind an optin
> knob. Similar to dmesg_restrict.

It's not going to be applied. If a file shouldn't be read by a user
it should have appropriate file permissions instead of 444.
Checking capable() in read() is very non-unix way to deal with permissions.
