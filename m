Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067B1332ECD
	for <lists+bpf@lfdr.de>; Tue,  9 Mar 2021 20:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhCITKo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Mar 2021 14:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhCITKZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Mar 2021 14:10:25 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E287C06174A
        for <bpf@vger.kernel.org>; Tue,  9 Mar 2021 11:10:25 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id h4so22197697ljl.0
        for <bpf@vger.kernel.org>; Tue, 09 Mar 2021 11:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhz5UmsfM87iu7Jv8OMFbiKHWte+5QkZdb4FZo410lQ=;
        b=LHmVFa5U/WIEa2Ibsp3Hx9TignR4oT7tkewbQIpdRqZ6fLlSPaO/rxHcdLKUgX2FLd
         36hJ4mJkYgDHIwIaw6vw5cNhsXMmBNtiNjGo9FBUzYdQubYkTyMiGJi8JUj2wCtiJZK+
         gEujScqPIFvO9Vnogkt1/vRzYxI3nVRTa4CEHp4KMfHMAbGLgJji3fNT9JMWWKHPsquh
         5WEPz1WYnUZP+G/EOtFig7HHEwwVVrgqWzbW0I+WNWE35FXnF0w1021/9DMdWx6Qke2v
         35yaTck/EkopuVBu6G02x6lhkHlngslu1I+zz2fOequ1kdP+rV4JbMYkNCKy42IeyRMr
         nLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhz5UmsfM87iu7Jv8OMFbiKHWte+5QkZdb4FZo410lQ=;
        b=GgEKuV4lVOQZc7tg8d/maPEF7QEl+Wi+pkPECSSs7n69k06kKfOuSX7qzHi1dMlBgW
         pUMOro3MZxAKO255MqHChkrH7nXl51sWHTqf4tQk1y42yYBd8HwSAiXmQ/+Y7OTkOyH1
         MkEVsGQk0mmZNugusni6b6d8qAJExbXgWoDrGoZqx4oQihE7smlFkyfYuWbPbYJ8kO9l
         NQtx8sRATJL3Xnx1RCWCkdawD7kJFFzOB+SItqKhJC3lR6BAtqBSRApcFk/uN6E83qaQ
         vnCfaFcVrNMkA0vd1jcSeLZDNCu73g4IeOEOGWpY6uc5ZYTqHuSzuqLWBEJHwyDMG2fC
         QVlQ==
X-Gm-Message-State: AOAM532sjFY02min4JLaht4+xpF6mxwAWWRGrxq741egEZ9Ny0tL7kyM
        seSt436jOljSjUCmOtXOWwDiNs3B5uR3FqT5008=
X-Google-Smtp-Source: ABdhPJwEPRCPDEUc+eEihNTeQnstTV7vRp/pOs4FcECurXNibANAKQcssqG9vMBo9GhXhItOOuSqdMHA0ZvG46HdHDs=
X-Received: by 2002:a2e:9704:: with SMTP id r4mr17502430lji.486.1615317023948;
 Tue, 09 Mar 2021 11:10:23 -0800 (PST)
MIME-Version: 1.0
References: <20210305170844.151594-1-iii@linux.ibm.com>
In-Reply-To: <20210305170844.151594-1-iii@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Mar 2021 11:10:12 -0800
Message-ID: <CAADnVQJ=2GoJQxygRyGOnhBLuuuUVE62fyVSOqyC35Q+2LR+PQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] selftests/bpf: Add clang-based
 BTF_KIND_FLOAT tests
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 5, 2021 at 9:09 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> The two tests here did not make it into the main BTF_KIND_FLOAT series
> because of dependency on LLVM.

Applied. Thanks
