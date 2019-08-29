Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65699A292B
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2019 23:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfH2VqZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Aug 2019 17:46:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34635 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfH2VqY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Aug 2019 17:46:24 -0400
Received: by mail-qt1-f194.google.com with SMTP id a13so5490707qtj.1
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2019 14:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSqo6AxKNUtYnfaTrxof/m+xSjpyGfcpfaCCJQ5tk6g=;
        b=Fh5Rvj/3fFNFxCGpHekafcGa0VdiMLAoiv9sxR2rDEvLo7Hp4Fq64QWwfHvlMsUDLh
         e9gGN1WmCMCzcHxeBcFEMIVKXseqrkWCUlZlHlAWRYWzf0d14grxWyYfDa1TXYVhujK6
         ip65QNUeiypGnOViaLJfzD0bDnaOj32ZHyeq/aBr8QmgMS2toQVIBS+vtjp5NH4kO0kB
         GmwtL9H7Nskbr3bqc49prCFdygHdC5WCswkxK1V7gXoKRnpGWXEmlolyuUiTqn/O2YKz
         kTv4sr/n7b4jbASQ6XuQWkFuuLY4PdwZzz9FjwSlF4O7rU1cjtTeOkrphYcX6Uc8scRj
         5/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSqo6AxKNUtYnfaTrxof/m+xSjpyGfcpfaCCJQ5tk6g=;
        b=moteXcqXBKgmC9O6/hYkDKoKW71mA0qal9S3amrrck8wPeuMAn3BvZB9ip6aJLUhkR
         022v5igK9gHupcIzayqrH7U/wpJlFadUZ3IAicp/iayW1+1xlF14rIamX7o0GWs0Bk6+
         5hlesd1lRCcm1SdVEb4cWVFxoI4x+P/BgZR9HN+kAZ+Cpcnw8SShqDRWFNKKXsV5jFYi
         pUu5iA5f0TyzO4v9ARFMzmQIdURo3Xi2ArgxanWW7puF82tOyIRDLrCJGW3G2zkRn4qX
         2Tm8X8jlawDB6BYq0gcyVR4VSwnnBxbaOhQH3ZACck40UZu+aNZuGz7cJ8Xe5QKYUQE6
         ljgA==
X-Gm-Message-State: APjAAAWLi91dsafXyZ78soK5N6EKXbv1dqqyh/LGrXhQDY3p5wJ27qq9
        Cc1TNgADerXjqiVBqe7cawY5SfmitXe4WPll0lg=
X-Google-Smtp-Source: APXvYqyePjEJXvEb5jzhUE2HMRNKjFxLkxQg14taFpdxGIbPRA6f0+UPzfkhhXSEoENy77FmyfXusYeh0V8stv2Wv90=
X-Received: by 2002:aed:2fe1:: with SMTP id m88mr12103255qtd.77.1567115183889;
 Thu, 29 Aug 2019 14:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190828132214.68828-1-iii@linux.ibm.com> <20190828132214.68828-2-iii@linux.ibm.com>
In-Reply-To: <20190828132214.68828-2-iii@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 29 Aug 2019 14:46:12 -0700
Message-ID: <CAPhsuW70V8kmNzH4ZC0zW3Qk0GW03rz0PLwqBAWeGviV4pJr_g@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] selftests/bpf: introduce bpf_cpu_to_be64 and bpf_be64_to_cpu
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Andrey Ignatov <rdna@fb.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 28, 2019 at 6:23 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> test_lwt_seg6local and test_seg6_loop use custom 64-bit endianness
> conversion macros. Centralize their definitions in bpf_endian.h in order
> to reduce code duplication. This will also be useful when bpf_endian.h
> is promoted to an offical libbpf header.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Song Liu <songliubraving@fb.com>
