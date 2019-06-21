Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4284ECE9
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2019 18:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfFUQR4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jun 2019 12:17:56 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:47091 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfFUQRz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jun 2019 12:17:55 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so464208iol.13
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2019 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sw0tar4GKNYE+fKeYGxgNKh8+9qTX2z35GEBt1SVpc0=;
        b=EkOlu8qlRhzBLmqK/JdjBqIW5qryF2RdLS3wOFZsu3n9PHhrG1wi6n0hFXLG1MFQ5/
         KTBVBI7etM1aU/ONn6Qx3W6uNfI4Yqqc6fdLe5cj+t0vt2i/1/wqMnkttynIQB8/u5cO
         IAm1ffnYDxs7vAskpJvZyQo38g5G44Rx2R77/kU2bM/oNK5GsXdJG5uhioKfysrK8Lm8
         2OktVp8osiuoXqbOEL9B58NPIk3A4R/seH4kyi0MzEh7I3xwtNwX/a0GWSgv23582DWp
         dHjg6Aw7vupuRHaqil5vjLFXql1/9Tc+p0qGWipiN27RVTQV9X4JNJKSd+NJpC5BQfeW
         PZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sw0tar4GKNYE+fKeYGxgNKh8+9qTX2z35GEBt1SVpc0=;
        b=mqw0oi7Rwfoz83AHm4ZEcqLWR8KAnBU9tRJ3tKsOtJ+ZhGeSLnKhXZmqJWe7PQL5qH
         gCa23NVzwjwZvFv4CJTCbopOl3AtfF0X/hOUwhqwjConvZuPngSZ2KZ5LVTJEhdV8lQ4
         g4vYnP5R/4RWHpzGaRwfPP5o5txAL/3NdcuZFzOQUFdxH9sstedmgrTcAFb/OerDdyNL
         I2Ott4H4jPp5IOeyna9noTqeFRKR8bHYUL5dSzIjpU39ZyUpYuRuG/Fondvm/hqaxmQw
         n2uYlFl6k9oGikUHn3It1or1pNHzfLuJy4CtqA4R8qnOM3qG+myJmMrPG9h12YBlBS84
         396Q==
X-Gm-Message-State: APjAAAUqkwEj3ZG0ckGR1F8CdgXJBD9CB05Y7tloFzfUbdU587Jo84xa
        amJTpZ7865OqpauknTu/Wq7+tA==
X-Google-Smtp-Source: APXvYqwrP5rrf+639Ym7wMFWZQdU1WfoVNcgUP+bsXyCprN6Jo1hWnpDosiQ8jA1YW4OBOu8ZR8yFw==
X-Received: by 2002:a02:22c6:: with SMTP id o189mr3228179jao.35.1561133874834;
        Fri, 21 Jun 2019 09:17:54 -0700 (PDT)
Received: from localhost (c-73-24-4-37.hsd1.mn.comcast.net. [73.24.4.37])
        by smtp.gmail.com with ESMTPSA id f20sm3921317ioh.17.2019.06.21.09.17.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 09:17:53 -0700 (PDT)
Date:   Fri, 21 Jun 2019 11:17:52 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        xdp-newbies@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>, hawk@kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: selftests: bpf: test_libbpf.sh failed at file test_l4lb.o
Message-ID: <20190621161752.d7d7n4m5q67uivys@xps.therub.org>
References: <CA+G9fYsMcdHmKY66CNhsrizO-gErkOQCkTcBSyOHLpOs+8g5=g@mail.gmail.com>
 <CAEf4BzbTD8G_zKkj-S3MOeG5Hq3_2zz3bGoXhQtpt0beG8nWJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbTD8G_zKkj-S3MOeG5Hq3_2zz3bGoXhQtpt0beG8nWJA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 20, 2019 at 10:17:04PM -0700, Andrii Nakryiko wrote:
> On Thu, Jun 20, 2019 at 1:08 AM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > selftests: bpf test_libbpf.sh failed running Linux -next kernel
> > 20190618 and 20190619.
> >
> > Here is the log from x86_64,
> > # selftests bpf test_libbpf.sh
> > bpf: test_libbpf.sh_ #
> > # [0] libbpf BTF is required, but is missing or corrupted.
> 
> You need at least clang-9.0.0 (not yet released) to run some of these
> tests successfully, as they rely on Clang's support for
> BTF_KIND_VAR/BTF_KIND_DATASEC.

Can there be a runtime check for BTF that emits a skip instead of a fail
in such a case?

Thanks,
Dan

> 
> > libbpf: BTF_is #
> > # test_libbpf failed at file test_l4lb.o
> > failed: at_file #
> > # selftests test_libbpf [FAILED]
> > test_libbpf: [FAILED]_ #
> > [FAIL] 29 selftests bpf test_libbpf.sh
> > selftests: bpf_test_libbpf.sh [FAIL]
> >
> > Full test log,
> > https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190619/testrun/781777/log
> >
> > Test results comparison,
> > https://qa-reports.linaro.org/lkft/linux-next-oe/tests/kselftest/bpf_test_libbpf.sh
> >
> > Good linux -next tag: next-20190617
> > Bad linux -next tag: next-20190618
> > git branch     master
> > git commit    1c6b40509daf5190b1fd2c758649f7df1da4827b
> > git repo
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >
> > Best regards
> > Naresh Kamboju

-- 
Linaro - Kernel Validation
