Return-Path: <bpf+bounces-37557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7289095780B
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 00:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A821C214AC
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 22:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764431DC49B;
	Mon, 19 Aug 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="SyVViUUN"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43C159565
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 22:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107663; cv=none; b=kya4pN52tHPAk6ewL4NQvvSMZUzO7qyv6Bf+CXkwDB9/14CSCtue8U+Sp8viKLL1JRFl/N0Bxuu9wdQOl3Ov8TxgEhtT3tbqgbyEGS8sWX3RarJSs0KmtyVCj6pKjsUZZhE5r+Gw9QTpCV3HAEJfou8CIfteMMmKuPG34PPHmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107663; c=relaxed/simple;
	bh=hTbKmJOGZfCzH52APlluJCLYRP2J1Rs4LnQK5gJEU08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqoHOqgo1tfQ8V7Z4hiYEu2MRX309G6xK7Iwxz2PXzWE+m+TpBVBKtgoO8eLxaXPrRNGBqrXh4o3eC3QW0LogbUudZIX19wNO2JZg28KAzTltTcHxO1sg3qzOn5jxipJd48XQx+Te5GGIk7u+CnMdl6oDEj8B2DCiLpUiDxJe54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=SyVViUUN; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1724107654; x=1724712454; i=linux@jordanrome.com;
	bh=9P8z8ylV7WTziqZu5dQA3Pu7Mxqt2VZyLH54l+SERUA=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SyVViUUNkD+4dPjEvH+SEpQ8OzygKY+6cr2cPTpTMO4kY9s/39Fko4II8Bkx1Av/
	 /rviiQujrdamW4Q31OMI0HN2EIb3JVEJV8ekUKHMvaXyZqqm316DjcRjfk7Kl3osN
	 qOdWODSkr15Q3RniUwFuFcVQFYM6w1cd6tiIt4eIC2ORUD17l7WsYW+elENel4B5Y
	 g3ei6iy4zAiVPnzXleyNwnPCxHiKgr972boUmpxL/9LOcMfTmSK7miLhNsOWkzOZa
	 /x2eOcupnWRTXCtu4vQifKtikFInchKc6UwvyNEmhyWjLBc/Ys/zTAsJ70OBTHRco
	 d6oT9cjjHpfrk4bjYA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f178.google.com ([209.85.166.178]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MCJn4-1soSdI044Q-00D9UO for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 00:47:34
 +0200
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39d30f0f831so10745845ab.0
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 15:47:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YzlNqpK3Fzhm3oriSVY5P49bQDwWAi2DvL/r5ozTS8lp6F6jbxO
	8WhZTnRTbg1iEQtiIchjTP2Y1zEH35OPXX6HCLAA8239DY9Om3aeu+IsQrtd4PmpiI2rblm8RxS
	4MYDzQJVDkvyt/1fTejM6Tn66+Ts=
X-Google-Smtp-Source: AGHT+IFjbmhjuBxqQ63ZWYaGuiak4MYKOqn/tbt+t8Rs/h5TQ+c44l/PShVx09JZe2lcLBW9726bGheGtN4vMK9QjsY=
X-Received: by 2002:a05:6e02:170a:b0:398:fa06:1d71 with SMTP id
 e9e14a558f8ab-39d26ce6ef8mr160007865ab.7.1724107653583; Mon, 19 Aug 2024
 15:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818002350.1401842-1-linux@jordanrome.com>
 <20240818002350.1401842-2-linux@jordanrome.com> <CAEf4BzZD0O835HqkJ7vbHHGtJdab3JpXRSsiPF1dA0q=A5tgpg@mail.gmail.com>
In-Reply-To: <CAEf4BzZD0O835HqkJ7vbHHGtJdab3JpXRSsiPF1dA0q=A5tgpg@mail.gmail.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Mon, 19 Aug 2024 18:47:21 -0400
X-Gmail-Original-Message-ID: <CA+QiOd7vXKSJFYVv5uBt78Jx8fqdW7F-thtVJNoktmKSMg5+MQ@mail.gmail.com>
Message-ID: <CA+QiOd7vXKSJFYVv5uBt78Jx8fqdW7F-thtVJNoktmKSMg5+MQ@mail.gmail.com>
Subject: Re: [bpf-next v6 2/2] bpf: Add tests for bpf_copy_from_user_str kfunc
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h5KO1iMG7+511oFQn/5O7QzbF4XmK5M8Bepbs+rm54xCFz0hp/K
 rVoIX7j7oXXtZ7JAW4Z0qRORZP+Iq9cQuEVGIpjIoHJ0/4RZx8JF16I9Jb046QkBGBmRFGm
 78zTOQ4Jg/SXqlq3DrdOlZyZtmkZePty/+2+JJmQ38dmqGYaDY5tXvTyrF36IWGoH6jmYpC
 L3mV69nJAiglBOqAupY9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TsM3rdJcuQA=;WRuCJQxMAy5Gm9XLT6lOE3ebZUa
 8h+k7UyjySNeN+4KXEPk97XSBXf3eQFRYgb4JYLlueZln9IM02GiR339AuIGZV2uZLJlxf+G9
 4NIgC0rxctfkpwgWeSg8EaRDXM3QZx7l2VCGm8hLDfvdaTqVV8a/iaQF+abR8VIk0lW0GNzIx
 b3TtpMPjRWZjvFzXO2DBN84HOK9TPP3z85fMuE/J+c0EnMWCoOlCMCRF7Fiu+rWddPwIur0xE
 A9VY9e6DdRsuby1zbyokSD97LDDOmTn9NEGCJBIZd0QKITJUe1KstflePGFHg2RsN8ftWmY1q
 vCElFz5BtVpM6JPTStlep8GHRbHLvoEcHuSFlZ46cFUfc1NZhWEm143E2OvOCKbSNQ+CTevsD
 8CZvYlpcqQwo0o9VBldga8nbgO2FDSlOyeT+GkVe+18YQgA0WBKVV8g+bjJ3f35/OZ+E0xFVg
 h9/uORj+H8aGDDvzSeeYznAhvuH+1Y9xkK7Qh9zKfsaTbkPVKy5seIm/t5a1IXkM0frxEriAR
 2bwdiDt/80eLKHPao+gDizQtKxRw1vg4I24Eu1SgxKTErwjhg6c+4bQ4OAsJ+UEydFBLoRr7I
 nJw8LD/jMMfnBXUaAH863ppxqQxkdGicIPyhXsfnuPWa6jfNTUZ8uUzmL032K9nDAe7ICvH7t
 zQdte8Ex5OJv++5+vVIrD8lKcy7qhSSpC9ZTZRSy5FGcwWGrf6AwX3S/0/LPu3oC36tHQa9NH
 frfBkCiJ5knkuzchmwv+uw8ntsL8LaxDg==

On Mon, Aug 19, 2024 at 6:42=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Aug 17, 2024 at 5:24=E2=80=AFPM Jordan Rome <linux@jordanrome.com=
> wrote:
> >
> > This adds tests for both the happy path and
> > the error path.
> >
> > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > ---
> >  .../selftests/bpf/prog_tests/attach_probe.c   |  8 ++-
> >  .../selftests/bpf/prog_tests/read_vsyscall.c  |  1 +
> >  .../selftests/bpf/progs/read_vsyscall.c       |  9 ++-
> >  .../selftests/bpf/progs/test_attach_probe.c   | 57 ++++++++++++++++++-
> >  4 files changed, 68 insertions(+), 7 deletions(-)
> >
>
> Thanks for adding more test cases! See a small nit below, but otherwise L=
GTM
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> [...]
>
> >
> > +static __always_inline bool verify_sleepable_user_copy_str(void)
> > +{
> > +       int ret;
> > +       char data_long[20];
> > +       char data_long_pad[20];
> > +       char data_long_err[20];
> > +       char data_short[4];
> > +       char data_short_pad[4];
> > +
> > +       ret =3D bpf_copy_from_user_str(data_short, sizeof(data_short), =
user_ptr, 0);
> > +
> > +       if (bpf_strncmp(data_short, 4, "tes\0") !=3D 0 || ret !=3D 4)
> > +               return false;
> > +
> > +       ret =3D bpf_copy_from_user_str(data_short_pad, sizeof(data_shor=
t_pad), user_ptr, BPF_F_PAD_ZEROS);
> > +
> > +       if (bpf_strncmp(data_short, 4, "tes\0") !=3D 0 || ret !=3D 4)
> > +               return false;
> > +
> > +       ret =3D bpf_copy_from_user_str(data_long, sizeof(data_long), us=
er_ptr, 0);
> > +
> > +       if (bpf_strncmp(data_long, 10, "test_data\0") !=3D 0 || ret !=
=3D 10)
> > +               return false;
> > +
> > +       ret =3D bpf_copy_from_user_str(data_long_pad, sizeof(data_long_=
pad), user_ptr, BPF_F_PAD_ZEROS);
> > +
> > +       if (bpf_strncmp(data_long_pad, 10, "test_data\0") !=3D 0 || ret=
 !=3D 10 || data_long_pad[19] !=3D '\0')
> > +               return false;
> > +
> > +       ret =3D bpf_copy_from_user_str(data_long_err, sizeof(data_long_=
err), (void *)data_long, BPF_F_PAD_ZEROS);
> > +
> > +       if (ret > 0 || data_long_err[9] !=3D '\0')
>
> shouldn't the condition be something along the data_long_err[0] !=3D
> '\0' || data_long_err[19] !=3D '\0' to check that the entire buffer is
> zeroed out?
>

Good catch. I think in a previous iteration `data_long` was only 10
chars long. Will fix.

> > +               return false;
> > +
> > +       ret =3D bpf_copy_from_user_str(data_long, sizeof(data_long), us=
er_ptr, 2);
> > +
> > +       if (ret !=3D -EINVAL)
> > +               return false;
> > +
> > +       return true;
> > +}
> > +
>
> [...]

