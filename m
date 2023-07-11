Return-Path: <bpf+bounces-4798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EB874F892
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 21:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838FB1C20DCC
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 19:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466311EA71;
	Tue, 11 Jul 2023 19:57:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF5A17FE0
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 19:57:02 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA3210E7
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 12:57:00 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b6a084a34cso94487161fa.1
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 12:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689105419; x=1691697419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dgVVgRCbp3N90EUgvjH0IL9CKe/cQvLsChcZk/ROlM=;
        b=IJwyyEyRgwb+8Rz3FzMBGTY5fgNU8zRNuG32L9INHEhKsxoxu1ZiMaOE/tQAdLe6g7
         KgHv9QQPjzcqn0CZlWQWMX+Vljs9nLe5GUvyTke6PxYcHG8YV34c5J7e2vHh440H6cKf
         mLTggsSFMAS8uSS2x7WYGsQ+3BXSrvSiVQvBnWRH8wsUbG8UnrVk6mcYZmsFvaBPtINB
         cKSQF95bhHgPxks3fG3KKrlJ+/ReedvXdEbDWOkNzmsHSrExrXp1i18wtz+eYqYNF4O4
         Z2uNeJrBQl6Va/2H2RkXQzxcdKTbNPxP+yXzzN+DW/8Xn1xVaywMr74pdCb92YIWYTCF
         c/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689105419; x=1691697419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dgVVgRCbp3N90EUgvjH0IL9CKe/cQvLsChcZk/ROlM=;
        b=L2EDsm1BJ11U1cBlH/L+jYK9tIXajELl8+gLGNNoAs0ZgdnuWwEX+iR1Hc3MgSpIKx
         9tbR8UdvnKfgvGWLU7xU+p2z0UF6VV2YeQvpDYIxNPysEYhB1XR9wnkxOhpBh67Llg5d
         ZCIjX4L2X4AGlbWUvg5tyiBa/9mcW3fQ1CZEMaunDlQZqxX4EtppCFsi8lyoN7vziWbg
         3Sapy0R+wlqdJMdb9fwGOrAmA4y5g/r8nK5PChRNManXKSZmxgVgmvDaTB8Tj7MhSmzn
         wxupM7C05efDDAW0z6RQeyRoP9hJsbeAdExZPW9xSzhesCb2V2NOBsxtI7PnJGYGg5fU
         AslA==
X-Gm-Message-State: ABy/qLZ6n06JGkoGDJUiJCRCqIp0U6BYOxzrRWrFxl7uhQqyvrQAnBl/
	l2BUgJVuzITDLnMz6KT5EF0j5d8nEQt0EzLH2sxf8aMi
X-Google-Smtp-Source: APBJJlEcBX8p0B4sno3gnhYxRNx8D6R+qr843GO9SsEFAo4iMpAe9WHgvCcT9O19mF8VptTM5ADm0KqqjI9p2rSC5LU=
X-Received: by 2002:a2e:888a:0:b0:2b6:9871:21b0 with SMTP id
 k10-20020a2e888a000000b002b6987121b0mr2155685lji.36.1689105418676; Tue, 11
 Jul 2023 12:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710215819.723550-1-hawkinsw@obs.cr> <20230710215819.723550-2-hawkinsw@obs.cr>
 <CAADnVQ+F5VT72LzONEo79ksqaRj=c7mJDd_Ebb87767v01Nosw@mail.gmail.com> <871qhe7des.fsf@gnu.org>
In-Reply-To: <871qhe7des.fsf@gnu.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Jul 2023 12:56:47 -0700
Message-ID: <CAADnVQ+S6iOQ71dzYz-Fh5kbvyQAF4GgB18F-SW8NGgOaRgWZg@mail.gmail.com>
Subject: Re: [Bpf] [PATCH 1/1] bpf, docs: Specify twos complement as format
 for signed integers
To: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Will Hawkins <hawkinsw@obs.cr>, bpf <bpf@vger.kernel.org>, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 7:04=E2=80=AFAM Jose E. Marchesi <jemarch@gnu.org> =
wrote:
>
>
> > On Mon, Jul 10, 2023 at 2:58=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> =
wrote:
> >>
> >> In the documentation of the eBPF ISA it is unspecified how integers ar=
e
> >> represented. Specify that twos complement is used.
> >>
> >> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> >> ---
> >>  Documentation/bpf/instruction-set.rst | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf=
/instruction-set.rst
> >> index 751e657973f0..63dfcba5eb9a 100644
> >> --- a/Documentation/bpf/instruction-set.rst
> >> +++ b/Documentation/bpf/instruction-set.rst
> >> @@ -173,6 +173,11 @@ BPF_ARSH  0xc0   sign extending dst >>=3D (src & =
mask)
> >>  BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ =
below)
> >>  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> +eBPF supports 32- and 64-bit signed and unsigned integers. It does
> >> +not support floating-point data types. All signed integers are repres=
ented in
> >> +twos-complement format where the sign bit is stored in the most-signi=
ficant
> >> +bit.
> >
> > Could you point to another ISA document (like x86, arm, ...) that
> > talks about signed and unsigned integers?
>
> AFAIK the only signedness encoding aspect that is always found in ISA
> specifications and should be specified is how numerical immediates are
> encoded in stored instructions.
>
> But that has nothing to do with "data types".

+1 :)

