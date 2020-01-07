Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37102132418
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2020 11:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgAGKrm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jan 2020 05:47:42 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:39621 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGKrm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jan 2020 05:47:42 -0500
Received: by mail-il1-f193.google.com with SMTP id x5so45328706ila.6
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2020 02:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=v9o63yWZgkgdSqghjfIhGgS/KdbPOOBvJuoX59hXFcg=;
        b=aX2bnmlWN9plSqAoINXMqsgVHWNef1GkvlzA0IV7hHx0JF8uycYnbE4r5o1B6GrZjr
         I4j9RRmxRQBHcewEnVIo+eMa1dbHawpkUnHCCYskwAj4GgRvicLYP7aYimgpB+mmNrOx
         sIujYzd2mEaOJnYEXEOuwOW4p7UrqS/OrWfzWvgFc0LPKvjIGNjHljnkZpNd35CV12Ey
         KP1rOcYBKCsuyVizHxpNFPL9jnad949cgMnGJ/gIFe1eQcCrJOyQkX5+IldFaA55hu37
         ehG3oklaxhTNyyhdKLhI6POXc/My9hI/EuHUsSEllLccPmEr5DdA0GDUoLhxJosunPRa
         GSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=v9o63yWZgkgdSqghjfIhGgS/KdbPOOBvJuoX59hXFcg=;
        b=TAMLxtS4o5TxtY8Skf6rYVrw8ylznoTqbGq7IP8IoLP4DYxz1gdWQBSaZfWbGgSZK4
         440TPcbW7ag+VmRN06diKk4NMP7Elu43S7/qwPV0JRVsmuzbeW1N9bNWYb5H9L0+5pl+
         3S+QVXejp9GZb9LCup2qdfFzv66hxYTmCxiTzmaXkJv9r5WGL5Prn8QjfN3mZUOQjpxV
         N/uXsd4C6Aqx/sqV+PkuYMQF3XWv5Ey7wL2a3CLAhfGslb7WKLINP0vmqUXxq0Pt8MTm
         qQC4WUn/4znpCA3aCyfUdAgIDcgT5qzHz+ZtdasNlnpKXqE/2eXDOhFjxpBP4xPgymPJ
         0mEg==
X-Gm-Message-State: APjAAAUM3NKMYZlTUwjoD/83EJG10tAqtOHgcWZXcmsndIPxoJlAJhDR
        wdRBFdBa/jqZ2W+lrA5Hd1oEIQ==
X-Google-Smtp-Source: APXvYqyxCOxBpeNyqV1KRHHkYJIOm33zBzLtBlGF3pl+3N/mseE+EV2DexXOcKQXfTO5bMjTAcPFKw==
X-Received: by 2002:a92:4818:: with SMTP id v24mr82585142ila.96.1578394061469;
        Tue, 07 Jan 2020 02:47:41 -0800 (PST)
Received: from localhost (67-0-46-172.albq.qwest.net. [67.0.46.172])
        by smtp.gmail.com with ESMTPSA id z17sm2493899ior.22.2020.01.07.02.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 02:47:40 -0800 (PST)
Date:   Tue, 7 Jan 2020 02:47:39 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     =?ISO-8859-15?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>
cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-riscv@lists.infradead.org,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 6/9] riscv, bpf: provide RISC-V specific JIT
 image alloc/free
In-Reply-To: <CAJ+HfNgrekRMM_XS1eK_Cn77BNEgs2gxEsTEvxDpKH9M4R7TJQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.2001070243310.75790@viisi.sifive.com>
References: <20191216091343.23260-1-bjorn.topel@gmail.com> <20191216091343.23260-7-bjorn.topel@gmail.com> <7ceab77a-92e7-6415-3045-3e16876d4ef8@iogearbox.net> <CAJ+HfNgmcjLniyG0oj7OE60=NASfskVzP_bgX_JXp+SLczmyOQ@mail.gmail.com>
 <alpine.DEB.2.21.9999.2001031730370.283180@viisi.sifive.com> <CAJ+HfNgrekRMM_XS1eK_Cn77BNEgs2gxEsTEvxDpKH9M4R7TJQ@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-531874526-1578394059=:75790"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-531874526-1578394059=:75790
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 7 Jan 2020, Bj=C3=B6rn T=C3=B6pel wrote:

> On Sat, 4 Jan 2020 at 02:32, Paul Walmsley <paul.walmsley@sifive.com> wro=
te:
>
> > Looks like Palmer's already reviewed it.  One additional request: could
> > you update the VM layout debugging messages in arch/riscv/mm/init.c to
> > include this new area?
>=20
> Sure, I'll send that as a follow-up!=20

Thanks.

> Related; Other archs, e.g. arm64, has moved away from dumping the VM=20
> layout (commit 071929dbdd86 ("arm64: Stop printing the virtual memory=20
> layout")), and instead rely on _PTDUMP. Going forward that probably=20
> applies to riscv as well!

For the specific case of the page table dumper: we're waiting for the=20
generic ptdump patchset to be merged first - hopefully for v5.6.  The=20
RISC-V integration patches against it were posted to the lists back in=20
October.  But, to me, that targets a different use-case than the VM layout=
=20
debug print code.


- Paul
--8323329-531874526-1578394059=:75790--
