Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F661FCCEA
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2019 19:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKNSOe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Nov 2019 13:14:34 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44625 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfKNSOe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Nov 2019 13:14:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id g3so7690063ljl.11
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2019 10:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZNM+JziKsWRgPzFHikppmsNDUA0A1seIC7TjX2CgUF4=;
        b=pOjJa6ztLwXYKP6shY1aQY/PWvpD4laXtOi4TwbqmmY18LtdL52BW2J9/z9J2zZqYG
         Of1/yMiC7VlVAI+zdakJX1WfL0VcrxKzcb6hixGg7bEDH42JLHlTZlRgyAuaWSz6mpqM
         L+xXHJVHQhyaniVAtVJOR0ytW8qEn1BAQ0yzUPexJrgpXZE9ayENXVPmlmun/O6KVhHX
         RGdhoxRKYYQn/HbZkObAXLD6P7aM4I+ZuQwqf2AlqWDHL3ufVEUzH4eZTtC9itesKovR
         W/7/zYNFQ/g1CnsZ/K7yWf32M+BkkhyO4Nxac/LesG4q1cmrwmcyRWL4RDoD+mI4GQuB
         EdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNM+JziKsWRgPzFHikppmsNDUA0A1seIC7TjX2CgUF4=;
        b=lJJR/fR5Wjnx5EAM3qz1YRbiej8TuCo2yfJ4gQuNYVqk0+y2qCSM1Noz34Y5/OM11H
         7oWsaG9Crxhph3CWewOQxnQRrvheWx3Jv6TPI3ul5aZOi4S++IDT8BzSnLSLGblc1FLj
         wdC59c9qk5NSzL6uJ6Hndr4Ty9XTqa0Bf+5fYusdkYoHZiZy6pR6xpIVNLzXB8OPx46M
         wYbuC8/t97ETpwzQr+dE7uuLgQ1/YXuHl+JljRstvIkSe0QRXxyfg2eTwuB+E56kZLwh
         oU1ZZowfiHP8LAOQNFn+HvHCTN5Mrs03AtPDq7B+1SAsfZXD+8nZ7v49PrSsoeetqHy8
         ZOMQ==
X-Gm-Message-State: APjAAAWwbmdrJGBUd/mlGSNL6G6G2ZNrt13FNuJ+/goO+zaFIaA72HZj
        L92+JWks7z+6MpLBVWE+AfWuYbedWS6/a4k+kYI=
X-Google-Smtp-Source: APXvYqzMUOBOkpKXJJ8msUqTiYrh+AbbpEAGAh2n9FBP+A5pST9vVvW5yH0ZOeiicCxOkcvg67No2VCZb+hOcwR2kjI=
X-Received: by 2002:a2e:b5b8:: with SMTP id f24mr7405690ljn.188.1573755271774;
 Thu, 14 Nov 2019 10:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20191113170005.48813-1-iii@linux.ibm.com> <CAPhsuW6ktX4zDt4fE=C0G4gCZoY_GRdkJFk0sdpsxYVtohnBxA@mail.gmail.com>
In-Reply-To: <CAPhsuW6ktX4zDt4fE=C0G4gCZoY_GRdkJFk0sdpsxYVtohnBxA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 14 Nov 2019 10:14:19 -0800
Message-ID: <CAADnVQL0sk7XXGYAMWKoZOYSN7qi6vN5ZW3VJbd7e9Q_wJaBAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: make bpf_jit_binary_alloc support alignment
 > 4
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 14, 2019 at 9:40 AM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Wed, Nov 13, 2019 at 9:20 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > Currently passing alignment greater than 4 to bpf_jit_binary_alloc does
> > not work: in such cases it aligns only to 4 bytes.
> >
> > However, this is required on s390, where in order to load a constant
> > from memory in a large (>512k) BPF program, one must use lgrl
> > instruction, whose memory operand must be aligned on an 8-byte boundary.
> >
> > This patch makes it possible to request an arbitrary power-of-2
> > alignment from bpf_jit_binary_alloc by allocating extra padding bytes
> > and aligning the resulting pointer rather than the start offset.
> >
> > An alternative would be to simply increase the alignment of
> > bpf_binary_header.image to 8, but this would increase the risk of
> > wasting a page on arches that don't need it, and would also be
> > insufficient in case someone needs e.g. 16-byte alignment in the
> > future.

why not 8 or 16? I don't follow why that would waste a page.

> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>
> Maybe we can just make it 8 byte aligned for all architectures?
>
> #define BPF_IMAGE_ALIGNMENT 8
