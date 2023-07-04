Return-Path: <bpf+bounces-3998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23D87478BF
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 21:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38901C20A56
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 19:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D00E79DD;
	Tue,  4 Jul 2023 19:37:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ECC6128;
	Tue,  4 Jul 2023 19:37:10 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC62110D9;
	Tue,  4 Jul 2023 12:37:09 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5702415be17so66327127b3.2;
        Tue, 04 Jul 2023 12:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688499429; x=1691091429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qNcOBkx9KVjEG4DcNywvaFsWzeBVICK48QZpMcCWbo=;
        b=YoZEoS3HG+fXtDw3Jor1iWRblhnEgEBM16kwycBU8suOmtv9Wtd26RvJH77xQhwPGN
         lBbN9ouQOhII8QMt4oidpGYD7dpcLIi784wwl7XoWOMSMISloDMLULgVIDSIxAVXJN41
         MgnIhrrSxOkq415c7jYj3CMY659EnZ+fGTAUuCDeeZABg7uSeDYKm7QcsHZySXBtXIKT
         AYAcFLPgb9BV/oRP5aGSXlJtlYUi0WpDLpSIW/1R63avlDGQvWLoS9msGfh8FE1GlpOs
         4Dq0oglqUO/vqPOiV58Psf4oklGn0ds9KKN0WQ+KlxlzOl1hPSUOdEsZ9LA07MJMTVWJ
         Fjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688499429; x=1691091429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qNcOBkx9KVjEG4DcNywvaFsWzeBVICK48QZpMcCWbo=;
        b=GgCOGGeomqUUBrgsOlOchRPx+Ti7KH6AaHVsHMIFvHXMZdJ4aeVtrMAsT95Yrntte1
         zbIE/jfZOiScmkvaWcQ4QNPk04/Jg4/Z8AjeCdjOdTI6l9Zw1osYBpEH69fDYV6YW5+F
         UGnrkkOnSjNHjA1UVEOPZpy8rnxPVy0ntgqCxiRbZ/SJu3PuuvTzI1WKYNkp144br38n
         L5VrtC/ZhVfXQcJPMrt80EHgeygUK4GY234PtEOwrdCPJWPi/vdpDCOKolzdoV2TDe6R
         +c8osUyRz67jKnvGh574/VZ8nVg/TXkuhsfjuVvlE5gsNXm2QB1fxxmmcmj8rqcYdGiW
         rfwg==
X-Gm-Message-State: ABy/qLZPSRs2cNqQJPeK/L1ON61g6jyv3YwyOGwIGCr+PQBQrL7GneVo
	wSNzMRyFaBWK7nkB8d+spIlU6plTXTgvczQL58I=
X-Google-Smtp-Source: APBJJlFoUpjRi+mWcyDvy5B5ZmEbHoM/utkiPaiGLIBn5qZEXeQzTOmRyhM2Y6Hw2AT5O7sEROWU0gih9QJjEpuATeA=
X-Received: by 2002:a81:9e43:0:b0:565:3749:c24d with SMTP id
 n3-20020a819e43000000b005653749c24dmr15651223ywj.14.1688499428944; Tue, 04
 Jul 2023 12:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703175048.151683-1-jthinz@mailbox.tu-berlin.de>
 <64a33ce7b50d2_6520520875@john.notmuch> <bdffeca8e222b0126100dec5dcd9d9b186ea6905.camel@mailbox.tu-berlin.de>
In-Reply-To: <bdffeca8e222b0126100dec5dcd9d9b186ea6905.camel@mailbox.tu-berlin.de>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 4 Jul 2023 15:36:32 -0400
Message-ID: <CAF=yD-K7NiEROeHM5GzW2ArtprcYg7WFwPFz7+0LOOT2DCY_+A@mail.gmail.com>
Subject: Re: [PATCH 0/2] bpf, net: Allow setting SO_TIMESTAMPING* from BPF
To: =?UTF-8?B?SsO2cm4tVGhvcmJlbiBIaW56?= <jthinz@mailbox.tu-berlin.de>
Cc: John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Deepa Dinamani <deepa.kernel@gmail.com>, Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Mon, 2023-07-03 at 14:25 -0700, John Fastabend wrote:
> > J=C3=B6rn-Thorben Hinz wrote:
> > > BPF applications, e.g., a TCP congestion control, might benefit
> > > from
> > > precise packet timestamps. These timestamps are already available
> > > in
> > > __sk_buff and bpf_sock_ops, but could not be requested: A BPF
> > > program
> > > was not allowed to set SO_TIMESTAMPING* on a socket. This change
> > > enables
> > > BPF programs to actively request the generation of timestamps from
> > > a
> > > stream socket.
> > >
> > > To reuse the setget_sockopt BPF prog test for
> > > bpf_{get,set}sockopt(SO_TIMESTAMPING_NEW), also implement the
> > > missing
> > > getsockopt(SO_TIMESTAMPING_NEW) in the network stack.
> > >
> > > I reckon the way I added getsockopt(SO_TIMESTAMPING_NEW) causes an
> > > API
> > > change: For existing users that set SO_TIMESTAMPING_NEW but queried
> > > SO_TIMESTAMPING_OLD afterwards, it would now look as if no
> > > timestamping
> > > flags have been set. Is this an acceptable change? If not, I=E2=80=99=
m
> > > happy to
> > > change getsockopt() to only be strict about the newly-implemented
> > > getsockopt(SO_TIMESTAMPING_NEW), or not distinguish between
> > > SO_TIMESTAMPING_NEW and SO_TIMESTAMPING_OLD at all.
> >
> > Yeah, I think it would be best if we keep the old behavior and let
> > SO_TIMESTAMPING_OLD return timestamps for both new/old. It looks
> > like it should be relatively easy to implement?
> Alright, I guessed that would be preferred.
>
> Yes, if there is no objection to making the added
> getsockopt(SO_TIMESTAMPING_NEW) this tiny bit more =E2=80=9Cstrict=E2=80=
=9D, it=E2=80=99s just
> a matter of modifying the if inserted in sk_getsockopt(). (And, well,
> in the other case I would even remove this if.)

The difference is in the struct that is returned, on 32-bit platforms.
Both calls should always be allowed? See also
put_cmsg_scm_timestamping64 vs put_cmsg_scm_timestamping.

For the second patch: the _OLD/_NEW was introduced to work around
limitations on 32-bit platforms. This is intended to be transparent to
users, by defining SO_TIMESTAMPING accordingly.

Can the new BPF code always enforce the 64-bit version, that is, only
implement the _NEW variants? And perhaps just call it SO_TIMESTAMPING
directly.

