Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB1430947
	for <lists+bpf@lfdr.de>; Fri, 31 May 2019 09:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfEaHWx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 May 2019 03:22:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34708 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaHWw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 May 2019 03:22:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id e19so7053934wme.1
        for <bpf@vger.kernel.org>; Fri, 31 May 2019 00:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=FU04xAR/6h4GqcGgE+2NWUuxq5FrKtSed1UqhDep54o=;
        b=eeJoMp9B+3CUiDjzCQewpNM5ilfXaCzT/ghPtaG5Ck6HrGBJV9s9ZczKJw/NtzJPdO
         7S1gIefCcFM4pZPgMB6f82Tvc/mF1tKoe5uQI+OZ2UETFek+Gk7KiNEDbh6cfSdUQ0v4
         guUzuTpUsUHhBs5iSjQavC6RwG/JxRX/5+dsSAv7VZQlWWA+ubIca8ZlwbGGNrG3NSUM
         8nSWcOhABep4I6s0gPveUTmp1yYvLflDZ84droGjHq/a5gLcZ5GEMaVjlg0MLAjNEEaq
         dCtVG0GgEnJzOKR3BFm1g40CdC6X6JcTwxV4+1PcUU7k+IbpYFBDTw8Tni4aVoIczFgc
         AzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=FU04xAR/6h4GqcGgE+2NWUuxq5FrKtSed1UqhDep54o=;
        b=JzsW7kmivpnWuenRMx9DEUGCFNAaiq1ys+42trXozO/NQsN9ziu3YDaBjYmVBzMah0
         4tV4Rgp+nxYhpBqPWS3VCHtihW950o9jTuazpNsywjo7NxPVbx5MM8Nc3g9KOLiBF0+2
         +emmX0/2hPJpgRTiOSJ864a6Bvgp6p8cjirZu64O4ECLFSUTqatgx1/qnIVBaaT4SLrW
         no67VYJT5HRYdvS8D0In6xUXZyiX2XOgw+kSAQVwfr0GROZ5jnJPjqXsL+t7QUf00YjF
         N6tEg41ollAc4tWF6kixL2PAuRqgF+HYbAtiFHFh1oLg4C5OOUxh9xTQAXXtUG6+m6iF
         mSnA==
X-Gm-Message-State: APjAAAXlgYbFZVhwXg46YmOoVUg2Ae49JtmMIKxP5FfVGHNgQoVI2S49
        BkNb1qCWgcISDM9mPcbMboZzgw==
X-Google-Smtp-Source: APXvYqxPIRDWAk2ZHGMiEu7JvqNMZ/P1bKU8W5EPs76o972GvPxxd8Idq7dd+N0zwckXYzWuOdy59Q==
X-Received: by 2002:a1c:2358:: with SMTP id j85mr4678026wmj.46.1559287371059;
        Fri, 31 May 2019 00:22:51 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id z65sm7566691wme.37.2019.05.31.00.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 00:22:50 -0700 (PDT)
References: <20190530190800.7633-1-luke.r.nels@gmail.com> <CAPhsuW4kMBSjpATqHrEhTmuqje=XZNGOrMyNur8f6K0RNQP=yw@mail.gmail.com> <CAB-e3NSidgz8gLRTL796A0DyRVePPjVDpSC6=gSA4hH8q6VqvQ@mail.gmail.com> <CAPhsuW7rOzyJTac7d9PPHeWW39Hu5pV6Mk0xJr8jyr0HH=-W2A@mail.gmail.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Luke Nelson <luke.r.nels@gmail.com>,
        Song Liu <liu.song.a23@gmail.com>
Cc:     Xi Wang <xi.wang@gmail.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Networking <netdev@vger.kernel.org>,
        linux-riscv@lists.infradead.org, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] bpf, riscv: fix bugs in JIT for 32-bit ALU operations
In-reply-to: <CAPhsuW7rOzyJTac7d9PPHeWW39Hu5pV6Mk0xJr8jyr0HH=-W2A@mail.gmail.com>
Date:   Fri, 31 May 2019 08:22:45 +0100
Message-ID: <87d0jzgkai.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Song Liu writes:

> On Thu, May 30, 2019 at 3:34 PM Luke Nelson <luke.r.nels@gmail.com> wrote:
>>
>> On Thu, May 30, 2019 at 1:53 PM Song Liu <liu.song.a23@gmail.com> wrote:
>> >
>> > This is a little messy. How about we introduce some helper function
>> > like:
>> >
>> > /* please find a better name... */
>> > emit_32_or_64(bool is64, const u32 insn_32, const u32 inst_64, struct
>> > rv_jit_context *ctx)
>> > {
>> >        if (is64)
>> >             emit(insn_64, ctx);
>> >        else {
>> >             emit(insn_32, ctx);
>> >            rd = xxxx;
>> >            emit_zext_32(rd, ctx);
>> >        }
>> > }
>>
>> This same check is used throughout the file, maybe clean it up in a
>> separate patch?

We also need to enable the recent 32-bit opt (on bpf-next) on these missing
insns, like what has been done at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=66d0d5a854a6625974e7de4b874e7934988b0ef8

Perhaps the best way is to wait this patch merged back to bpf-next, then we
do two patches, the first one to enable the opt, the second one then do the
re-factor. I guess this could avoid some code conflict.

Regards,
Jiong

>
> Yes, let's do follow up patch.
>
> Thanks,
> Song

