Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF401222B3A
	for <lists+bpf@lfdr.de>; Thu, 16 Jul 2020 20:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgGPSsO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jul 2020 14:48:14 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34568 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgGPSsO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jul 2020 14:48:14 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4CDF520B490A;
        Thu, 16 Jul 2020 11:48:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4CDF520B490A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594925293;
        bh=hSCKLmYwUb9OLxJLhvxvNGSLQTyCxuEbUVTQgeO7+8g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XMgIJC7SVchgQ7K49aPLfrJI+ke9XlGIUP5pmBxYAQRtNRb/9dZzz46NyDI/Dd5Qd
         Yzk0j3i59775q8dqA4WY1Llftl/NSytmlrwp24WEfOC4z0A48OtMTpbsOyLk94wnsj
         SZ3Gu9oiTwKa7Fk4525U7ULHNaF4Ib6Fv0V4YyWc=
Received: by mail-qt1-f171.google.com with SMTP id e12so5713772qtr.9;
        Thu, 16 Jul 2020 11:48:13 -0700 (PDT)
X-Gm-Message-State: AOAM5314qLCaSEfmC9OXNWolB0EAS2cbA0Av/vAAEo1h97YXU6bobohp
        1J3jLwYnMegMexr4bJedII52OSt/8hmEdXY8FHU=
X-Google-Smtp-Source: ABdhPJxq7RwG+/dBZSJZZ/zxJ6F7VxqgzZM5rCwzYUFKFvDRyySYx3XYuVT9FxsDs8MtjKh8Arn616rqVLihWFg2J04=
X-Received: by 2002:ac8:5486:: with SMTP id h6mr6614141qtq.255.1594925292362;
 Thu, 16 Jul 2020 11:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200713130511.6942-1-mcroce@linux.microsoft.com> <20200714173154.i2wxhm4n4ob7sfpd@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200714173154.i2wxhm4n4ob7sfpd@ast-mbp.dhcp.thefacebook.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Thu, 16 Jul 2020 20:47:36 +0200
X-Gmail-Original-Message-ID: <CAFnufp2_vwyCR95Z=Dkd9XXRO8CTQ5NZtNPdJL+1oPRurv-feQ@mail.gmail.com>
Message-ID: <CAFnufp2_vwyCR95Z=Dkd9XXRO8CTQ5NZtNPdJL+1oPRurv-feQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: allow loading instructions from a fd
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 14, 2020 at 7:31 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 13, 2020 at 03:05:11PM +0200, Matteo Croce wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > Allow to load the BPF instructons from a file descriptor,
> > other than a pointer.
> >
> > This is required by the Integrity Subsystem to validate the source of
> > the instructions.
> >
> > In bpf_attr replace 'insns', which is an u64, to a union containing also
> > the file descriptor as int.
> > A new BPF_F_LOAD_BY_FD flag tells bpf_prog_load() to load
> > the instructions from file descriptor and ignore the pointer.
> >
> > As BPF files usually are regular ELF files, start reading from the
> > current file position, so the userspace can skip the ELF header and jump
> > to the right section.
>
> That is not the case at all.
> Have you looked at amount of work libbpf is doing with elf file before
> raw instructions become suitable to be loaded by the kernel?

I see now what bpf_object__relocate() and all the *reloc* functions
do, so it can't be done this way, I see.

A malicious BPF file can be as bad as a malicious binary. Let's say I
want to assert code integrity for BPF files, what could be a viable
option?
Perhaps a signature in the object file as we do with modules?

Regards,
-- 
per aspera ad upstream
