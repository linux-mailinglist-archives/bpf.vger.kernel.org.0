Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A859516B938
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2020 06:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgBYFnr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Feb 2020 00:43:47 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33912 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgBYFnr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Feb 2020 00:43:47 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so8748808lfc.1;
        Mon, 24 Feb 2020 21:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p5/5vEBubNjmt22m/UMeJDFdXk5YFn70ecwWdjPyPE8=;
        b=GdNQZQrARMDie/sTWPxRiOwmun0GRWKpBmT1CnCPcTs7WcNLJae8K6mPa6eFJo/n7U
         nyFXy5GBFeey2tSZjlCb3bkAwuRVqfJsBiwH2pKxufIMo4crV00Fxkg24dIm/7y+kQCz
         2oDJEPKBDsWe+ITLLhuZOOTOXZAZbEJ0jzx+r7oARptjNvD4owwRhpEydDUqtQQ9gXZ9
         lthmfGtiv2GxmHanh0COZMw9FGVC3hUQnzo6YoKC/DAToVqme/MtaVtiQS/YnyiarSk2
         2TvuzXpdq5D4yGUFPDK5Z+vHhKiluOLZAP2NJnxFRDWSLKCkloIcT2AxekjPrl/8zCPU
         wCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p5/5vEBubNjmt22m/UMeJDFdXk5YFn70ecwWdjPyPE8=;
        b=hRohDoOX0WPqKkXDN1iB7SYHriKcEYsGnpGS8Vii1IBBtQIMCSZU03k+emigQkTjnb
         j/9tDaZD8WK1F8x3HE29tuTeg+FhQRltNLmys31fe9dB8y2CPPyE5+BQLlTAVKZri4x6
         65sHxk8P2e3tkHnAKknO1kfNdfxKIy08x4OzfH1ygRPCecp9qMfcO78jKKF1vGEjRUsS
         AZZrVPKgB1bQSH/lrnXJajlSIdkqjF5M2ogzrcxh6oam8LfPukVYQNjbcnltYTJsg70z
         WxS/vJp/nRePHZvZfrcF+xse5H5U61sEPUIo9DAxLF6O9kP22ae1OSt20viTd+hgAjpo
         H1Iw==
X-Gm-Message-State: APjAAAWSj42LWa2uz9FGDakboHeNOucIqjbZrBPIsZ81v7AVgWujaOoA
        56Rg3SOqt7XH1fONLxT4nve7jS14CkovBGiiYq4=
X-Google-Smtp-Source: APXvYqx+WlziPWsLP6bLP2Ka9u56rRfhqByB/DBn0OjicY5J8svu/TUsBz7aMQWPnU+NZwrE2hzSp+HaK5Vx7ZHzFzQ=
X-Received: by 2002:a05:6512:304d:: with SMTP id b13mr3576611lfb.134.1582609425105;
 Mon, 24 Feb 2020 21:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20200221165801.32687-1-steve@sk2.org> <CAADnVQ+QNxFk97fnsY1NL1PQWykdok_ha_KajCc68bRT1BLp2A@mail.gmail.com>
 <20200224205028.0f283991@heffalump.sk2.org>
In-Reply-To: <20200224205028.0f283991@heffalump.sk2.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 24 Feb 2020 21:43:33 -0800
Message-ID: <CAADnVQKb-3fzx1xKLwms8pcPiJNLsmFsHyj_gnsE8DKVp1jhYQ@mail.gmail.com>
Subject: Re: [PATCH] docs: sysctl/kernel: document BPF entries
To:     Stephen Kitt <steve@sk2.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 24, 2020 at 11:50 AM Stephen Kitt <steve@sk2.org> wrote:
>
> On Sun, 23 Feb 2020 14:44:31 -0800, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Fri, Feb 21, 2020 at 10:18 AM Stephen Kitt <steve@sk2.org> wrote:
> > > @@ -1152,6 +1166,16 @@ NMI switch that most IA32 servers have fires
> > > unknown NMI up, for example.  If a system hangs up, try pressing the =
NMI
> > > switch.
> > >
> > >
> > > +unprivileged_bpf_disabled
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > +
> > > +Writing 1 to this entry will disabled unprivileged calls to ``bpf()`=
`;
> >
> > 'will disable' ?
>
> Indeed, thanks.
>
> > It doesn't apply to bpf-next with:
> > error: sha1 information is lacking or useless
> > (Documentation/admin-guide/sysctl/kernel.rst).
> > error: could not build fake ancestor
> > Patch failed at 0001 docs: sysctl/kernel: Document BPF entries
>
> Sorry, I forgot to include the base commit information; this is against
> 8f21f54b8a95 in docs-next.
>
> I=E2=80=99ll wait for that to make it to Linus=E2=80=99 tree and re-submi=
t the patch (with
> the fix above).

Please use bpf-next tree as a base for your patch.
