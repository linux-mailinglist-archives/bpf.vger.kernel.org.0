Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C3DFCBFD
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2019 18:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfKNRkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Nov 2019 12:40:18 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:37998 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfKNRkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Nov 2019 12:40:18 -0500
Received: by mail-qv1-f66.google.com with SMTP id q19so2681959qvs.5
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2019 09:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+8WyiicmDK1Ja6lb7FfUoneixA/LHRTQy3JnVr4Hw9s=;
        b=rxLtngFxfG6VGJM5HaKGbUt1Sp4+BWlxkwCCphmyfTmdt0GDWA06DUwACtoeJd28lB
         7hWcx7h11t0IZS1wtkMgPqoMTCNFxhWaZXG4E6EusWa/OXMMW8Z0fWUceDgMqoVUHbca
         yy8la24DMmNrv1AXtiqYibLg1kqhHML9qcLRYH9Bc4xii8nDhM0SCTmeRLmilfhz7pwN
         Xi4+obdj/9fF38/AWMVd3KBp2b5gTo0WoMJV54Q7Bpy2f1eZRwu2Vsis75wI5nnt+8GD
         MxP5OY2wTK2lDsS9TDbdrtljOpkiF1XucKc4cuu0WVefkCKzgt3vgh5lkS7WgCDsWrjB
         MgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8WyiicmDK1Ja6lb7FfUoneixA/LHRTQy3JnVr4Hw9s=;
        b=MpwUADABY+KegvnOe5L1hfQTVYOaURoHed8vc01Lc2QytfHwFYo5+NiJhyCyRDwIZ5
         ohPtIm8BcSWLRtLx246bOpO80GurEoWXem2RrkfyWtCvHK5i4aRh8fzo0mtWH3HnsHWb
         Hr7iuej1eEwH+LjE8hVCOFL0LP1x6EOJpWhdpPJhWI62hXfxv6unRhJWgheVdxo7OKCC
         kAgtEd13/j9sj9RrvhL9Abp45HlyF9w/LcJCXdLZUxriwsgvVD+FP5b3/q5DucRgAwic
         6C/BQ0sUd2TDs03VUL2dWmetHGG8KQzMvWIy0BP7+tJeZIgiT3zSRBGoQ+ShHBt3v63n
         AnbA==
X-Gm-Message-State: APjAAAWc1nLGOHtZFHme+04GG5LRkwOP0PlOOLrcjiGQeLaoF5k7bGtl
        lNrchNjzkdx1pj2DIbJzhB0m2Q6BiRGyo2N4ktc=
X-Google-Smtp-Source: APXvYqwNzSb2gps29EJC9MlvPm7U3i/mdZLLjmbFCJ4FfIt3OV2ilwmQzv/YerIzshfFw9ZCVZ2dFew3M1Gf03vL9/s=
X-Received: by 2002:ad4:4092:: with SMTP id l18mr8876596qvp.114.1573753216187;
 Thu, 14 Nov 2019 09:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20191113170005.48813-1-iii@linux.ibm.com>
In-Reply-To: <20191113170005.48813-1-iii@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 14 Nov 2019 09:40:05 -0800
Message-ID: <CAPhsuW6ktX4zDt4fE=C0G4gCZoY_GRdkJFk0sdpsxYVtohnBxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: make bpf_jit_binary_alloc support alignment
 > 4
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 13, 2019 at 9:20 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Currently passing alignment greater than 4 to bpf_jit_binary_alloc does
> not work: in such cases it aligns only to 4 bytes.
>
> However, this is required on s390, where in order to load a constant
> from memory in a large (>512k) BPF program, one must use lgrl
> instruction, whose memory operand must be aligned on an 8-byte boundary.
>
> This patch makes it possible to request an arbitrary power-of-2
> alignment from bpf_jit_binary_alloc by allocating extra padding bytes
> and aligning the resulting pointer rather than the start offset.
>
> An alternative would be to simply increase the alignment of
> bpf_binary_header.image to 8, but this would increase the risk of
> wasting a page on arches that don't need it, and would also be
> insufficient in case someone needs e.g. 16-byte alignment in the
> future.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Maybe we can just make it 8 byte aligned for all architectures?

#define BPF_IMAGE_ALIGNMENT 8
