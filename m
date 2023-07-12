Return-Path: <bpf+bounces-4820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93F474FD6A
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 05:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4721280C5F
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 03:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DCD65A;
	Wed, 12 Jul 2023 03:06:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB006393;
	Wed, 12 Jul 2023 03:06:52 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778BA1712;
	Tue, 11 Jul 2023 20:06:51 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6b98ac328so100094041fa.0;
        Tue, 11 Jul 2023 20:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689131210; x=1691723210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y195SUNCHBbNT/VMVyexhThJQuOxhdoX1raDncFr8bA=;
        b=aTHRDnU31zxNZOqU2uGReCqyJg78q/Erygx2xiERN3mbbK2gPYq2IGyIyYOzDehcLQ
         RX5Dtx1/X30BycYP2hKuoWccnowvh/alpuBett6/AdKIXqDwf20YGVP+nUSDPWYtXm4o
         VQkJoGSaVaTU6jS+6wdI0tpzBWKL5jWImaBEInwoq8gde0PDngbkwDJUag5rM81/whcc
         uNoeBopym5vvkO13Nr2QIetrGUQ3zJGjguTuhdEe2TdB2/p840dYV6VeVWcpvAjrgPPu
         j+djbl0zjnpmljFkkuk+Qi16zvxM4Lyrm4Fp9HXpIXGDRvg7yYMShAURLp3Qg/qPhKxb
         SEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689131210; x=1691723210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y195SUNCHBbNT/VMVyexhThJQuOxhdoX1raDncFr8bA=;
        b=LOUxFsg1cNI9Rp6pSgiTntUnHHYS6wLF7j/KvVRJeRTkcWfilzCFDo9V4z+TZ81thZ
         P1xHLyDDPvZfJWvV/i615SwFixfjhP/abSKuIL4ZMHQk++4n0sBhhWweLXjCx7rOYs02
         5xUJkKTYenVV45zeINolLDfHOSY4Z7UFdeO/cmtxOhG73lTmEOEHTh5mVYf2jMyk1b2M
         NfU3FxB686mYzRDlw8j23H2lRs/XIUwYNGb7pKGmiII6xy8pojhQjWZeh1llqXMnx56J
         TocfG0Xxj0ysJfxU5scXD0/il13PUxtMZX29XhDBC1AVL9zl+bHZuSv1pKz4Cigiskon
         CrPw==
X-Gm-Message-State: ABy/qLZ+ZNT0fJkPqvCr8MuAxAUiKcjNZwxyrdnK/fIbHcSJr3psbdEy
	CayDYOJBMCVpOR+Oq/NcC+BdcTCZPHB1DANpMOg=
X-Google-Smtp-Source: APBJJlGzjs8HpdbveKPMn8j8O4frDBHf+8FXEux2iNVNzNMvSZq4fzzxSP2ZXxCogWGXhE4DA4zQNdPlQIatrv+N5lY=
X-Received: by 2002:a2e:7c0c:0:b0:2b6:cf5e:5da0 with SMTP id
 x12-20020a2e7c0c000000b002b6cf5e5da0mr14569879ljc.40.1689131209534; Tue, 11
 Jul 2023 20:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711105930.29170-1-larysa.zaremba@intel.com>
 <a05a4ac2-40c8-da67-6727-b9844930386e@redhat.com> <CAKH8qBtBHD=1bXQyPUczLRUSNagNTKC6DNhO1rqHmrGE5kLHWQ@mail.gmail.com>
In-Reply-To: <CAKH8qBtBHD=1bXQyPUczLRUSNagNTKC6DNhO1rqHmrGE5kLHWQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Jul 2023 20:06:38 -0700
Message-ID: <CAADnVQ+Peos-Y08_h27EYf=cO8ewdNwf-T0mmHvcEREv9+C04Q@mail.gmail.com>
Subject: Re: [PATCH bpf] xdp: use trusted arguments in XDP hints kfuncs
To: Stanislav Fomichev <sdf@google.com>
Cc: Jesper Dangaard Brouer <jbrouer@redhat.com>, Larysa Zaremba <larysa.zaremba@intel.com>, 
	bpf <bpf@vger.kernel.org>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Network Development <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 10:00=E2=80=AFAM Stanislav Fomichev <sdf@google.com=
> wrote:
>
> On Tue, Jul 11, 2023 at 7:21=E2=80=AFAM Jesper Dangaard Brouer
> <jbrouer@redhat.com> wrote:
> >
> >
> > On 11/07/2023 12.59, Larysa Zaremba wrote:
> > > Currently, verifier does not reject XDP programs that pass NULL point=
er to
> > > hints functions. At the same time, this case is not handled in any dr=
iver
> > > implementation (including veth). For example, changing
> > >
> > > bpf_xdp_metadata_rx_timestamp(ctx, &timestamp);
> > >
> > > to
> > >
> > > bpf_xdp_metadata_rx_timestamp(ctx, NULL);
> > >
> > > in xdp_metadata test successfully crashes the system.
> > >
> > > Add KF_TRUSTED_ARGS flag to hints kfunc definitions, so driver code
> > > does not have to worry about getting invalid pointers.
> > >
> >
> > Looks good to me, assuming this means verifier will reject BPF-prog's
> > supplying NULL.
> >
> > Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> >
> > > Fixes: 3d76a4d3d4e5 ("bpf: XDP metadata RX kfuncs")
> > > Reported-by: Stanislav Fomichev <sdf@google.com>
> > > Closes: https://lore.kernel.org/bpf/ZKWo0BbpLfkZHbyE@google.com/
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>
> Acked-by: Stanislav Fomichev <sdf@google.com>
>
> Thank you for the fix!

Applied. Thanks

