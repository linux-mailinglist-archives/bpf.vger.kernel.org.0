Return-Path: <bpf+bounces-589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66D1704224
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 02:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB972814BA
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 00:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9BC17CE;
	Tue, 16 May 2023 00:15:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA1D199
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 00:14:59 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BFE5FD1
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 17:14:57 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so1914301a12.1
        for <bpf@vger.kernel.org>; Mon, 15 May 2023 17:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684196096; x=1686788096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+XsjuCh7as/QLJharPdqbbKkM2JjryIACXOfyjMJ3E=;
        b=COLLY4ntdL5RfD5Aza/QPCBVul9J55D0uP6zruJpRjAiEB27wKjTT8lz3FDSvmayEp
         epcycdy09617pGUk5DuxVHUB2YW8H8PdDs7vRjUruZaYlvLBqTLFy51hLxhxpf/6SxKL
         P757EkJEJmDHWLQUepWj6sRhmuaJDhMU8XKFrBw7ZLS1EyrK3+D7CIV5mownYh1z2E6i
         9W6v+1pUxKzdQ8v9KL4QAB8jdybfZkAgE+i8JCUSQrLj6O53A3U/LTLOQDBTYBhbF8Ej
         RBGXdFDkRBSWLgeZfXWWVs/tfzyCAp1/c6gp3/f2a7GnkhOIuyON2ilOfkUZ+g8m3FFW
         NUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684196096; x=1686788096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+XsjuCh7as/QLJharPdqbbKkM2JjryIACXOfyjMJ3E=;
        b=KcJ1jwzmspol+yUG8JAFE3zq5lRkzitmU0QjgRBYhkyNPiVAzIqVjEN/HOV7Ay6c+e
         MmmergAcfd70xn0edkDTGzWS78hJCF72FDdby1mLpgDId/tne/WI8++8tbG75qKcUMfO
         I7L5JjJGFDamJc9fFnu7ZJ5EZ9Mh7gquBZxI5ua5AMvZ8xjEx1K/I6o1GgBUho67Ms8R
         aSvV0sSaFy4857xZDcupiJsPq+cpIz78xnOuN3Y4NLVWDXuRNKc66LOtU0IO9p/2U9jU
         ODDgkIqe9kuXzhLSfFQHQEqMBsZ8rcfSFQamnEOrDK/VGd+IMICFMDQy9A/cXcfdPjMT
         Zgzw==
X-Gm-Message-State: AC+VfDxo48oWQutxtwBh+bd+njW3xqLlImoLusyFAbB1iOVBTJICVqYZ
	c8e33uny8mqeXYD3q1Tz2gWX/88qf7eOfXQyMCE=
X-Google-Smtp-Source: ACHHUZ7Z9xIkLxuNR7fijjfX1P3qSGBThjcnEL9aFu5+a15HBKXRVbTk8Mr4p+kiAUHkSPnJr8N6hc5Vl+Pf2D4iDrw=
X-Received: by 2002:a17:907:8a08:b0:969:2df9:a0dd with SMTP id
 sc8-20020a1709078a0800b009692df9a0ddmr25631077ejc.25.1684196095616; Mon, 15
 May 2023 17:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230515200207.2541162-1-andrii@kernel.org> <e47459b1-d67e-4d29-d270-1fa160d4d4da@meta.com>
In-Reply-To: <e47459b1-d67e-4d29-d270-1fa160d4d4da@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 May 2023 17:14:43 -0700
Message-ID: <CAEf4BzZWr5DOksCyzHHTmwbgxO26a-bAUbV5na6GDQsw0P=t+Q@mail.gmail.com>
Subject: Re: [PATCH bpf] samples/bpf: use canonical fallthrough pseudo-keyword
 in hbm.c
To: Yonghong Song <yhs@meta.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 15, 2023 at 5:02=E2=80=AFPM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 5/15/23 1:02 PM, Andrii Nakryiko wrote:
> > Rename now unsupported __fallthrough into fallthrough ([0]) in
> > samples/bpf/hbm.c to fix samples/bpf compilation.
> >
> >    [0] https://www.kernel.org/doc/html/latest/process/deprecated.html?h=
ighlight=3Dfallthrough#implicit-switch-case-fall-through
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> LGTM. But there is an alternative, see below.
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---
> >   samples/bpf/hbm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
> > index 6448b7826107..7ddf25e9d098 100644
> > --- a/samples/bpf/hbm.c
> > +++ b/samples/bpf/hbm.c
> > @@ -498,7 +498,7 @@ int main(int argc, char **argv)
> >                                       "Option -%c requires an argument.=
\n\n",
> >                                       optopt);
> >               case 'h':
> > -                     __fallthrough;
> > +                     fallthrough;
>
> We could remove this 'fallthrough' completely since there is
> no code under case 'h'.


yep, should have done it from the get go, will send v2

>
> >               default:
> >                       Usage();
> >                       return 0;

