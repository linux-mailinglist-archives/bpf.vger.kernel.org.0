Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8313D82786
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2019 00:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbfHEWVM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Aug 2019 18:21:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45173 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbfHEWVM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Aug 2019 18:21:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so40327755pfq.12
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2019 15:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DgO0e9JRzibIoNYSWRSXWyzZahaXJGjw7Iz1fsfdaDE=;
        b=toZ/NbEoCsXgyHKpgcgPPucnQ3QZ4DxPGIibnYTVX1gUyX+AR9JQr1RXjtWj/K+QNG
         7+CslOMA7Y54u5/RLjGxFEQqjn4BLtYI8XOKispxxbR6zmdsccuex9ZPbYQpppyALE6G
         dJtxX4XbtugsAmYjsFRZ2vh9rwiut105mVGPtVPXr+1if9L9WLG+D9ikusj/Gd5FGa/J
         ZIZxwWmzmnjGdQ+fQg5GOQWkFwLzQp2CxW3w5eTcb9Qi36lXYRt8kKhI/0iRAmkpjVYp
         DpTKwfECH0URtJgwWgbJb+NBLh1DiA5pQLn6dmX95Qr4YwA39YzbPrQMwaW4RFYpRuA6
         mt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DgO0e9JRzibIoNYSWRSXWyzZahaXJGjw7Iz1fsfdaDE=;
        b=NIumci2LRRtq46BTUBB4AF2tGmJb5cC+D290yEDgcxDNXIMRxY4jgV6JeIok+HKpPB
         V8M0Yphz9lRwYxRLj9/btwPpZ4CfZYCQsbXt9xxbpwfDS7V5ZSKFtkvk1xDYYQqAwQRq
         SaM09wwvaIyG3CTrwEiPgEpw0zu4+MZ5Ifm8qqyMCwu7xdVZAsVyAlwhv9ZBTvyQChws
         qbHgnY65fCpB6J8lxklh+Hfhh4epXJCr0NRhKuVpxqGwKx527yYhKur2ZKT56Iqqcpay
         jrR3uvKTTZpDT8icIoqZxqAMap80fS0rp69IwHh1pxlbhlM5Fz+5VT63x7DAB/onz2Xg
         ozmA==
X-Gm-Message-State: APjAAAW0MeXX8dJRSvFFbdmndPNxMzW9vVWGafy9BzVJ+T55bDlDR6fl
        OclEsz72L/eP0Vf781ZuYbywBA==
X-Google-Smtp-Source: APXvYqzbmMrdZBju6JbMmh55mWuN9xDZYf+p8zFgCd55Wgap+s9h3KTBZpDAFFfCOKp6xTbJKa9lLw==
X-Received: by 2002:a63:d555:: with SMTP id v21mr103300pgi.179.1565043671712;
        Mon, 05 Aug 2019 15:21:11 -0700 (PDT)
Received: from ?IPv6:2600:1010:b00d:2934:dc05:ecca:6e98:38d? ([2600:1010:b00d:2934:dc05:ecca:6e98:38d])
        by smtp.gmail.com with ESMTPSA id k64sm64173738pge.65.2019.08.05.15.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 15:21:10 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G77)
In-Reply-To: <CALCETrVtPs8gY-H4gmzSqPboid3CB++n50SvYd6RU9YVde_-Ow@mail.gmail.com>
Date:   Mon, 5 Aug 2019 15:21:09 -0700
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Kees Cook <keescook@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FEA301AD-01E9-4B1D-A7F8-AA1DBF4FDE66@amacapital.net>
References: <369476A8-4CE1-43DA-9239-06437C0384C7@fb.com> <CALCETrUpVMrk7aaf0trfg9AfZ4fy279uJgZH7V+gZzjFw=hUxA@mail.gmail.com> <D4040C0C-47D6-4852-933C-59EB53C05242@fb.com> <CALCETrVoZL1YGUxx3kM-d21TWVRKdKw=f2B8aE5wc2zmX1cQ4g@mail.gmail.com> <5A2FCD7E-7F54-41E5-BFAE-BB9494E74F2D@fb.com> <CALCETrU7NbBnXXsw1B+DvTkfTVRBFWXuJ8cZERCCNvdFG6KqRw@mail.gmail.com> <CALCETrUjh6DdgW1qSuSRd1_=0F9CqB8+sNj__e_6AHEvh_BaxQ@mail.gmail.com> <CALCETrWtE2U4EvZVYeq8pSmQjBzF2PHH+KxYW8FSeF+W=1FYjw@mail.gmail.com> <EE7B7AE1-3D44-4561-94B9-E97A626A251D@fb.com> <CALCETrXX-Jeb4wiQuL6FUai4wNMmMiUxuLLh_Lb9mT7h=0GgAw@mail.gmail.com> <20190805192122.laxcaz75k4vxdspn@ast-mbp> <CALCETrVtPs8gY-H4gmzSqPboid3CB++n50SvYd6RU9YVde_-Ow@mail.gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 5, 2019, at 2:25 PM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> On Mon, Aug 5, 2019 at 12:21 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:


>=20
>> What we need is to drop privileges sooner in daemons like systemd.
>=20
> This is doable right now: systemd could fork off a subprocess and
> delegate its cgroup operations to it.  It would be maybe a couple
> hundred lines of code.  As an added benefit, that subprocess could
> verify that the bpf operations in question are reasonable.
> Alternatively, if there was a CAP_BPF_ADMIN, systemd could retain that
> capability and flip it on and off as needed.

I tried to look at the code and I couldn=E2=80=99t find it. Does systemd dro=
p privileges at all?  Can you point me at the code you=E2=80=99re thinking o=
f
