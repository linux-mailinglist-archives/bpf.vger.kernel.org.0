Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D1643E30
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2019 17:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbfFMPsE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jun 2019 11:48:04 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32923 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732416AbfFMPsC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Jun 2019 11:48:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id y17so15491699lfe.0
        for <bpf@vger.kernel.org>; Thu, 13 Jun 2019 08:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MhxG2VWV0PUqNmkC6UYengHNix8YULmmoQX86iMuI1Q=;
        b=HwzQ0rH3HntP0X1Ut+3aziFTUNyu7eZWshFffAcbuEQadz4P6sC2snoDJGp4KSyvu2
         Kig7hRqtroYC7jNl67KKgqHxE423RPSnEeZfbHsd+gLto0eo7V3yt/GGwc+21qgO0c3A
         GIH+62EGfN0eHFV/TMnqz5oJqV2MDDVZaYpN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MhxG2VWV0PUqNmkC6UYengHNix8YULmmoQX86iMuI1Q=;
        b=phd7bchDsGCK5s8SfZQ8WQgRd6RWJjyzQ5pdI3dsSp91xtT3uI6zQwKoBptAZEu0jD
         BISlHO6eQo/evEXBHMpriG20AHUMDRFbWwRq9lyrJSlGBI4wx6v5qwWg0uyTuDksn923
         zRg7z+MTrkSv34tNIQrjy959JNvlbRDFdXYbPjWesJWoREenWsLHFmm1GN8xRH57lZEV
         ZRP6hHvTJFJWub6KmEHKREMxUpnxcSHNQf/vF//k420y6j9E9gobFA7x5mAp1//7+mRA
         ZhyQdRXy8bYTSDsM9c+paV9ejFqyLezwEISjMP9V1nRNpTc1jAuhpyXqvpFg438pWQmC
         XXvw==
X-Gm-Message-State: APjAAAVAO8u8Q+bb18J/71gV7/UZ64ebAQYfh6rbAS+1KnwZgPI0dXY7
        6yka2UzBx+UYQMJuu2X1mCkuASHWLxsSIMsxeAK7/Q==
X-Google-Smtp-Source: APXvYqzrRigc/QwtHv0h+SK0yPrIqLoP/sTRt4T7cb0mR/3kmBMhY1s0fNVfrmh2vHW4vI1uCiYqipwR2/fMUdkpn8I=
X-Received: by 2002:a19:c383:: with SMTP id t125mr38852030lff.89.1560440880394;
 Thu, 13 Jun 2019 08:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190613112709.7215-1-afabre@cloudflare.com> <20190613154152.GA9636@mini-arch>
In-Reply-To: <20190613154152.GA9636@mini-arch>
From:   Arthur Fabre <afabre@cloudflare.com>
Date:   Thu, 13 Jun 2019 16:47:49 +0100
Message-ID: <CAOn4ftu8dv4rOei=Janw8bRMGLM5bganNGjp3nLUof82Z9vSiQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: selftests: Fix warning in flow_dissector
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ah yes good catch. I guess it hasn't made it into bpf-next yet.

On Thu, Jun 13, 2019 at 4:41 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
>
> On 06/13, Arthur Fabre wrote:
> > Building the userspace part of the flow_dissector resulted in:
> >
> > prog_tests/flow_dissector.c: In function =E2=80=98tx_tap=E2=80=99:
> > prog_tests/flow_dissector.c:176:9: warning: implicit declaration
> > of function =E2=80=98writev=E2=80=99; did you mean =E2=80=98write=E2=80=
=99? [-Wimplicit-function-declaration]
> >   return writev(fd, iov, ARRAY_SIZE(iov));
> >          ^~~~~~
> >          write
> >
> > Include <sys/uio.h> to fix this.
> Wasn't it fixed already?
>
> See
> https://lore.kernel.org/netdev/20190528190218.GA6950@ip-172-31-44-144.us-=
west-2.compute.internal/
>
> > Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/=
tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> > index fbd1d88a6095..c938283ac232 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> > @@ -3,6 +3,7 @@
> >  #include <error.h>
> >  #include <linux/if.h>
> >  #include <linux/if_tun.h>
> > +#include <sys/uio.h>
> >
> >  #define CHECK_FLOW_KEYS(desc, got, expected)                         \
> >       CHECK_ATTR(memcmp(&got, &expected, sizeof(got)) !=3D 0,          =
 \
> > --
> > 2.20.1
> >
