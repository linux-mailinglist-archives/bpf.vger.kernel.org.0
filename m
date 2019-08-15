Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD64A8F236
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2019 19:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfHORaj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Aug 2019 13:30:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44975 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbfHORaj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Aug 2019 13:30:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id d79so2418059qke.11
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 10:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=kTXwh3ITHtbuzL/JpnSHLuhe4DA+bICqQKV7LfiAy7M=;
        b=Zd5hGD+L09TBXib4aG8KMAx4pu4d0xdhyVaeyRrIovmsgBWBsssft6eQ9eeddRvKQV
         PJqceHEJUiJW2SstS3zHM3ntdFxCoEFvlHQA9YPKzcjWAvmf2TcupYGGQ7O8tkKhbtZn
         uqqtHRPpqN9AfB8Ni3Iul/AT5Ilm+MJY/LB8uwYXpa5ML+PrSCErbIAIC1bfBl6Z1JcS
         UPmKC+wFJy7l47dZX7gDuJE8yEi/W+Mh1653bQ+i6ySzBZxZkeKNCKgYGR6ZglrceBkr
         S/cAvqa2HtEOJZiTb3p0gfR+uMv/JvSwiPx9JobGHaO7SQExdDpwscdt/Kz5CTieL2Ft
         OB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=kTXwh3ITHtbuzL/JpnSHLuhe4DA+bICqQKV7LfiAy7M=;
        b=cAJ9bz9zTt0utJDLG2u0/QEdP5a48xqK1ZaRFAFg+N5P3jBW5b/aq59bpfwyFK9vvW
         SNEJonhFxaklP5IHCbqm8Ss7gie09E9xZGFU/Ibx6qvYbHmRqrbXY75DEV/YmcP74aZ/
         mDgUZ7HZqaKzps4YmCxROGvpipkHD4IGi03/aH6KQTWovkMqRhq3vamuzEWutNgZGlx3
         JMWhKBP5M97f1NbN1VpzyULG7xeKjqv5izKzk9ak+iNr32itXxy3pcNb+984PIU0+bGZ
         012zdeJEQkBMAt7IqDQvx7KnCFIn/Kx32DRyYZhjR2c6dnLSd8uBx+JqhrehpLZ8If/p
         M6Zw==
X-Gm-Message-State: APjAAAVBEU5fnEELCMAct8olyN98TShcnKPH4zQWxdo3OUVECr1c6jEk
        f4kdpr4QVB4gUDF5JViN0GIOvw==
X-Google-Smtp-Source: APXvYqwO1aQB1OxnAqtkNli05DpdgUH1L8j8p1pJtfd09Aqg+Y+EpJghSL2tuW6JKyhSqv5Lg3icrQ==
X-Received: by 2002:a37:9802:: with SMTP id a2mr5166879qke.346.1565890238320;
        Thu, 15 Aug 2019 10:30:38 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id s184sm1783093qkf.73.2019.08.15.10.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:30:38 -0700 (PDT)
Date:   Thu, 15 Aug 2019 10:30:23 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Quentin Monnet <quentin.monnet@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        oss-drivers@netronome.com
Subject: Re: [PATCH bpf] tools: bpftool: close prog FD before exit on
 showing a single program
Message-ID: <20190815103023.0bd2c210@cakuba.netronome.com>
In-Reply-To: <CAEf4BzbL3K5XWSyY6BxrVeF3+3qomsYbXh67yzjyy7ApsosVBw@mail.gmail.com>
References: <20190815142223.2203-1-quentin.monnet@netronome.com>
        <CAEf4BzbL3K5XWSyY6BxrVeF3+3qomsYbXh67yzjyy7ApsosVBw@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 15 Aug 2019 10:09:38 -0700, Andrii Nakryiko wrote:
> On Thu, Aug 15, 2019 at 7:24 AM Quentin Monnet wrote:
> > When showing metadata about a single program by invoking
> > "bpftool prog show PROG", the file descriptor referring to the program
> > is not closed before returning from the function. Let's close it.
> >
> > Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
> > Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
> > Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> > ---
> >  tools/bpf/bpftool/prog.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index 66f04a4846a5..43fdbbfe41bb 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
> > @@ -363,7 +363,9 @@ static int do_show(int argc, char **argv)
> >                 if (fd < 0)
> >                         return -1;
> >
> > -               return show_prog(fd);
> > +               err = show_prog(fd);
> > +               close(fd);
> > +               return err;  
> 
> There is a similar problem few lines above for special case of argc ==
> 2, which you didn't fix.

This is the special argc == 2 case.

> Would it be better to make show_prog(fd) close provided fd instead or
> is it used in some other context where FD should live longer (I
> haven't checked, sorry)?

I think it used to close that's how the bug crept in. Other than the bug
it's fine the way it is.
