Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1C61E6CFD
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 22:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407425AbgE1U7T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 16:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407411AbgE1U7R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 16:59:17 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDCDC08C5C6
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 13:59:17 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id a23so239987qto.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 13:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=q8grmwkB1Uu7Xr0CeCH9WglLj2Vx04nuOdAxXJ3k0cY=;
        b=XX/BUUNnwhdb9swSvCEkLordE9A0dWjRTfGq9nDtVJwvPE8qNeRIIQMGPaUalNT8ba
         ZU1Or2wim60sF1QvpQiEwfbf2UJUbxHyY4jLkXtnlZY8fw3EA9/xMwL4Wyh7IVSU10ew
         G1vQ3gtSKCOGR5OnD3rF0bWRGbl9gtMqp26nIXl9DXeKQEizpwC+T+AjGwIy7ikhEcGY
         ukYrlMpdQplUZm9fxumxw6qphBZ/M8OL3XicY9YjOPMU8Jh9IKGQwI9g0ja9qG9/Y2H5
         qScrSeihZmwf2K2SPfGebCsg8/pLXtzZ4bNCemGPUny7FLWBgslehoz1JHUtcIHNY5pO
         LIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=q8grmwkB1Uu7Xr0CeCH9WglLj2Vx04nuOdAxXJ3k0cY=;
        b=qWYhHXw5O3rX9uPwkhKQ/3GlVO0POEwQu08P/euGk1ogbtVxtHAsJk0zPhQDjERZ1u
         /uozGq+LO7qZwCFQje6N1u10OTPQMIq9Jem80jhBe3GLjUsf793bk/TUbccP0gjwMLvC
         RzSGssNQju2+9W/BOCdEz+oCZOu85lADUww1IU6b0NoquNruSGSOKbEOA5ZJqzZLC3Ui
         PCORQ3UXjsovFYLPwJBmsgd2LkkoR5eYucgb+1Bw8nkssb8NfBPl8Ayo3n7k6rnc7gpr
         W8O6RUKUpe7SmI0OXTFAJPmQDadQMpGpw5gvfXvMLWnfs/lsA5xG/sItuNuOsC/oE3l7
         9QyA==
X-Gm-Message-State: AOAM532FHZzdOpyiyOEarfdLqzQttdnNqF98JdgBtlhP3xByDO6gWdsW
        STjsN5xcZNCNFtBySmpl7EU=
X-Google-Smtp-Source: ABdhPJwygUgxq3XfEx17LhugeBHB1iDStvAS2GZkzX5eT4tHr5xjOzvbeDeMrPdq2dO5rgAIBJxa6A==
X-Received: by 2002:ac8:86:: with SMTP id c6mr5280673qtg.176.1590699556323;
        Thu, 28 May 2020 13:59:16 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id w3sm5893739qkb.85.2020.05.28.13.59.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 13:59:15 -0700 (PDT)
Date:   Thu, 28 May 2020 17:58:31 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+khW7hqemc+xsbMQq-DW3X+mHKO+Lm64hNpWNRyZ75MkUa0Gg@mail.gmail.com>
References: <CAADnVQJwqH2XFnTeXLnqbONtaU3akNh9BZ-tXk8r=NcGGY_noQ@mail.gmail.com> <CAEf4BzZVVgMbNE4d7b5kPUoWPJz-ENgyP1BfC+h-X29r1Pk2fA@mail.gmail.com> <20200522142813.GF14034@kernel.org> <CA+khW7j=ejncVYgY=hKEnkrkwA=Wjwa6Y2PFWgzrV1EV_8rvpw@mail.gmail.com> <CAEf4Bza9TP50Rtdg1s2qZ7t4547wQr=E-72_6m81ZX8vwZOPEA@mail.gmail.com> <CA+khW7ha-5YSgm5kARO=+JEtf-Ahmc1N_TBJ2iLSntk12pfy3w@mail.gmail.com> <CA+khW7hqemc+xsbMQq-DW3X+mHKO+Lm64hNpWNRyZ75MkUa0Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: accessing global and per-cpu vars
To:     Hao Luo <haoluo@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Oleg Rombakh <olegrom@google.com>,
        Martin KaFai Lau <kafai@fb.com>
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Message-ID: <A5E8516C-3386-4F59-AC6C-11F2BE4A02CB@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On May 28, 2020 5:50:52 PM GMT-03:00, Hao Luo <haoluo@google=2Ecom> wrote:
>A quick update on this thread=2E
>
>I came up with a draft patch that fulfills step 1=2E I added a "=2Eksym"
>section for extern vars=2E The libbpf fills these vars' values by reading
>/proc/kallsyms at load time=2E I think I am going to upload this patch
>for
>review together with step 3 and 4 after I work them out=2E
>
>Regarding step 2, I have also worked out a patch in pahole that inserts
>the
>kernel's percpu vars into BTF=2E I realized, because step 2 happens at
>compile time, there is no kallsyms file available to extract symbols,
>so we
>have to read the global vars from vmlinux=2E Currently on v5=2E7-rc7, I w=
as
>able to extract 291 percpu vars, static or global=2E The =2EBTF size
>increases
>from 2d2c10 to 2d4dd0=2E A clean build on my local workstation increases
>from
>10m13s to 11m24s (wall time)=2E Common global percpu vars can be found in
>=2EBTF=2E
>
>haoluo@haoluo:~/kernel/tip/pkgs/images/boot$ bpftool btf dump file
>vmlinux-5=2E7=2E0-smp-DEV | grep runqueues
>
>[14098] VAR 'runqueues' type_id=3D13725, linkage=3Dglobal-alloc
>
>haoluo@haoluo:~/kernel/tip/pkgs/images/boot$ bpftool btf dump file
>vmlinux-5=2E7=2E0-smp-DEV | grep cpu_stopper
>
>[17589] STRUCT 'cpu_stopper' size=3D72 vlen=3D5
>[17609] VAR 'cpu_stopper' type_id=3D17589, linkage=3Dglobal-alloc
>
>Arnaldo, would you please advise on how to upload the pahole patch for
>review? I am going to polish it a bit and think I can upload it for
>review=2E

Cool, send it to me, CC dwarves@vger=2Ekernel=2Eorg,

Thanks,=20

- Arnaldo

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
