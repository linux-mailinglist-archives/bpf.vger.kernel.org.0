Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4777026572E
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 04:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgIKC5s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 22:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgIKC5j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 22:57:39 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DA2C061796
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 19:57:38 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u4so10792483ljd.10
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 19:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Kh1b57N5y0+2My+aTuSilvFyjhKJHunU+vR0NlYoZA=;
        b=u0xK2PEnpc1JV9+hpEmyNLnck+738TU4/arHjn+L7vXY5G3grN0Zg6n7+lRPybNM1h
         Pb9wRjAF1y8QrkQ2J1agG5mzj8sTploVZU9TY3yvNBuu/Xi4vohLnaTd8u1kjfHluf4R
         SoCkMp9dydT8Evf+C6in+PElcKk6JxNZCfYoPKcnyLi2stiaqmqzgzZOOJLJSxy5YpRR
         owxQAJHmoUmGpYzM6VEzWjE8f5beKG9g4e53Thh8+DeKjLAxNusSB+Wh0vLEKZEUDQHR
         zqNbEyxEjFwIb4HTUpqJIh/YyYXusPOtv0H+1FsMNtGuI+eupapSmuHc1JWEEfINTTJt
         UhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Kh1b57N5y0+2My+aTuSilvFyjhKJHunU+vR0NlYoZA=;
        b=FeGD/5D+r+fvZluOcMAoxqpQcvfJBlk7khzCtqUvmDPNdUe1ZnTUi4TyMO0QuxdEiZ
         uC0VycgXBjtSeM8I/yLL0imOwlQTMXfrJW6itg8kLEatwE6iQ5z/xkraS+DoBhz/eLs+
         QRzDW+NistDC1c+6vQcjo+HwL8NG1OpZrBBOmotRXyeQSOn8i1BhMZDNx6m+zPMWAa/M
         HwEE8tgf9tW4OZZ8yFYBYrkPzXiSYU/3OZEH0ylN5QHRZ2Ov62tBfDlnwqh8PAaKz6AH
         ydcfalwygE4DAOAFB+dQV9MXmJKBPUbe4P6VVIuhCIxcke3bViRIZl+DwbjrO//wCmwE
         9/ww==
X-Gm-Message-State: AOAM530tHdgZjSItnXBeFTEqz+xR2s/4lf5OcKATnUps4hFcsQ8P5nbq
        BfC5iFp3nlJt8LGqotDnCLiL4Wq7K3e3O5tG545ycAYm
X-Google-Smtp-Source: ABdhPJyEisYBe/UiTAv8hQCO1wBZSbGDYPPve29QojsYlzsSUpvQKxZ6mlvX1nifbyMeQvNbLJoP6Aj5ir3zOV70M1M=
X-Received: by 2002:a2e:9782:: with SMTP id y2mr6132780lji.91.1599793056983;
 Thu, 10 Sep 2020 19:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200910171336.3161995-1-iii@linux.ibm.com> <CAEf4BzbNfKhGfMM2N=016NGA0X4jpK2Nu_=tXs1bLhxBZXgo=A@mail.gmail.com>
In-Reply-To: <CAEf4BzbNfKhGfMM2N=016NGA0X4jpK2Nu_=tXs1bLhxBZXgo=A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 10 Sep 2020 19:57:25 -0700
Message-ID: <CAADnVQJU6ibcmB-p_o3oNDX2Rso_KGnjtbXX9-3yuRUjZPk=bw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix test_ksyms on non-SMP kernels
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 10, 2020 at 1:01 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Sep 10, 2020 at 10:13 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > On non-SMP kernels __per_cpu_start is not 0, so look it up in kallsyms.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Applied. Thanks
