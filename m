Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9A13731E0
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 23:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhEDVYp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 17:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbhEDVYp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 17:24:45 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D59C061574;
        Tue,  4 May 2021 14:23:49 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b7so9194869ljr.4;
        Tue, 04 May 2021 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t8wotz3AhGgeTQp5SZs5xSv5MZsNA5QgTSconl9j5TM=;
        b=bu10H0MIFzOEkwtjWen71MackfzXsnWN6MZXNRc/W/GcLULK6ZhoaOh5oaLH+41zu+
         VwdEsKswhub4hu2UYG4wp+ZpuOwqPyZHoR+k5bCwf7o4/3rkUu3LE21z8mEsrL3JiKPa
         Zdx7srKYQ8Gp5kF5UUIfL63XhseNUY+E+okCJGV6LuiwOfp5gx8wL0Vb1aI/c1hJQDU7
         mOoMesB+BBckt+Q944oLu3rDaKRXF6+mCis9CzbXFkKRmMWwFjE7jW7VEov5fl2cNb5C
         mO8H2pbIidyO9uUYH76fmbw+M7Ltzq61yV1uy9yKh6foDNMy+xAsFdNJvcbMujalmED1
         Y6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8wotz3AhGgeTQp5SZs5xSv5MZsNA5QgTSconl9j5TM=;
        b=id4mH/sXdi0P2A+ine7yjfA738Mip2fxCP0OvqMTOjHvAZOWs/EC4oVjuVMQac+Guk
         IlZSt4JiwYnUG8EFI+/Y+EPJ72W3TWzqE1ZT9LpYTYRpIzDC+k8L3pfTJQW+z7hfjHn1
         EKIv4xkj5AnXYgEKrfX1JNG+HtusobpDNb5FJ1FiOULeIvI7fz3nFmV0BLjWg5MqqR6z
         uuwC+2jycU6MVMoKJ+G0A0cVUF8LqHkaeiMmL454PW28h8XMQAzIH5aFfvVZ3VHpldWm
         zQPyMOE5l9IaBeBMKK4KanFr9cfS/HKNCA8JiXn4AYc+SGYamZDA7uZqZHqDPHKMowm7
         QMqg==
X-Gm-Message-State: AOAM532iHk5osvImHe66FrJoaE4WmwldgNLj4T/qFSRXWzhwjKJbrxDn
        suYr7qNepKNoA3IkmdrRZLeBsJO0PpMcfViNptY=
X-Google-Smtp-Source: ABdhPJxNURHBTrrBxV0JDij/y6syf0fcI1QGRqpV/yO5lQyEdW71DJjeS5K7n35sHBs2PkzJqrKd5X+lXQYlbWyXvpc=
X-Received: by 2002:a2e:a489:: with SMTP id h9mr8855179lji.21.1620163428021;
 Tue, 04 May 2021 14:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20210504110519.16097-1-alx.manpages@gmail.com> <CAADnVQLdW=jH1CUP02jokEu3Sh+=xKsCXvjA19kfz7KOn9mzkA@mail.gmail.com>
 <YJFZHW2afbAMVOmE@kroah.com> <69fb22e0-84bd-47fb-35b5-537a7d39c692@gmail.com>
 <YJFxArfp8wN3ILJb@kroah.com> <CAKCAbMg_eRCsD-HYmryL8XEuZcaM1Qdfp4XD85QKT6To+h3QcQ@mail.gmail.com>
 <6740a229-842e-b368-86eb-defc786b3658@gmail.com> <8a184afe-14b7-ed15-eb6a-960ea05251d1@iogearbox.net>
 <CAKCAbMidJ=UhsMumDcwiqvkGEG5SROPnv=OA379w_=0dZk5W5g@mail.gmail.com>
In-Reply-To: <CAKCAbMidJ=UhsMumDcwiqvkGEG5SROPnv=OA379w_=0dZk5W5g@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 4 May 2021 14:23:36 -0700
Message-ID: <CAADnVQ+bPMsfva8YyAfvmXATDcykSkznskEtQueu=GKhOnYeZQ@mail.gmail.com>
Subject: Re: [RFC v2] bpf.2: Use standard types and attributes
To:     Zack Weinberg <zackw@panix.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>,
        Joseph Myers <joseph@codesourcery.com>,
        David Laight <David.Laight@aculab.com>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 4, 2021 at 1:33 PM Zack Weinberg <zackw@panix.com> wrote:
> the information that should
> appear in the manpages is the information that is most relevant to
> user space programmers.

The bpf programs are compiled for the kernel and run in the kernel.
Hence bpf man pages must reflect the kernel.
Also there is BTF where type names are part of the verification process.
if a user decides to rename a type it will be rejected by the kernel verifier.
