Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB71CC9584
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2019 02:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfJCAT5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 20:19:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38134 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbfJCAT4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 20:19:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so634626wmi.3
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 17:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=otXrdRXRXX4CQWq3GYXb5YP6U6iBo7U72/9DY4vWCe8=;
        b=UyRUiqxpxePfHhLvHWalEtfH7bXcfip6Jpuw1CuN4CME/z2VjKvnYoiACUL8njpxWx
         NrFj3wRuC+4G387TGIaHSpAOPY+RzGZ4sS0j/azLBk/U985whs44i6Y3Q8GidUtPoAtr
         gPg9sFSMc6bNH86zfYj2HsjOVmJbhRxv5A2Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=otXrdRXRXX4CQWq3GYXb5YP6U6iBo7U72/9DY4vWCe8=;
        b=IxpgSP2uP+/SnMQT6l5Sh6ebAv6yN37Yz9Lk2Vgz1oAW/oB4XZYf780V9GfHS7atIr
         9XAEzCtLMojSxRgaugFakp0z/ououXIXkHmN+Xo/qrAurEGjy5LS/uPP93SPtaLC/Nah
         mWnnH7my1Q9iG2pw6+Q2LeISVrpSgWqC4sMtDywa1vcHcy2ngFka5L8pB1FStQaqc6Gx
         8pObHTi4cmm8+mtfIKkwpgmD2YinYfQxN1ocH/PefVQZtXYDxjOah9LkhAKFo3OD5hj9
         GgidncaE6otuZhIwPraABxcevnjYPIvrRuo4+FAJrFdv8OyViPss7cula9VBvTCptJoJ
         at8A==
X-Gm-Message-State: APjAAAVPOuwdfSYlgRHEQcpj0O8VwWHEHWjyjUCGveUVglwlLxoJZBd7
        rTMj7BT1EwGD6y7sOCPXbux0UP4l/LH7J9dvCKl2Iw==
X-Google-Smtp-Source: APXvYqxalUowEr9ft2/u7jrMhV84UjQI79UjdzbXbSZaI9zycwf1BjEeLazp7AlXXo82ElFFmqdBxB6sMQbjZwxUAj0=
X-Received: by 2002:a05:600c:24cf:: with SMTP id 15mr4781220wmu.139.1570061993266;
 Wed, 02 Oct 2019 17:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191001113307.27796-1-bjorn.topel@gmail.com> <20191001113307.27796-3-bjorn.topel@gmail.com>
 <CAPhsuW627h-Sf8uCpaE4eyu+wpkOPK+6eXkOhwMBnvFVVDQdKQ@mail.gmail.com>
In-Reply-To: <CAPhsuW627h-Sf8uCpaE4eyu+wpkOPK+6eXkOhwMBnvFVVDQdKQ@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 3 Oct 2019 02:19:42 +0200
Message-ID: <CACYkzJ6R4bY2B61fC-EYGn0f-osPOVrZEJsatWyJRFn9_1JN2A@mail.gmail.com>
Subject: Re: [PATCH 2/2] samples/bpf: fix build by setting HAVE_ATTR_TEST to zero
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        adrian.hunter@intel.com, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tested-by: KP Singh <kpsingh@google.com>

I can confirm that samples/bpf are building for me now (x86_64,
clang-8) after applying this series and:

 * https://lore.kernel.org/bpf/CAPhsuW5c9v0OnU4g+eYkPjBCuNMjC_69pFhzr=3DnTf=
DMAy4bK6w@mail.gmail.com
 * https://lore.kernel.org/bpf/20191002191652.11432-1-kpsingh@chromium.org/

on the current bpf-next/master.


- KP

On Wed, Oct 2, 2019 at 11:00 PM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Tue, Oct 1, 2019 at 4:36 AM Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.c=
om> wrote:
> >
> > From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> >
> > To remove that test_attr__{enabled/open} are used by perf-sys.h, we
> > set HAVE_ATTR_TEST to zero.
> >
> > Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> Acked-by: Song Liu <songliubraving@fb.com>
