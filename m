Return-Path: <bpf+bounces-4711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F3874E504
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 05:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF82280E31
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21443C02;
	Tue, 11 Jul 2023 03:01:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C974623DA
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 03:01:48 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D7F1712
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 20:01:21 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6a6f224a1so84711631fa.1
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 20:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689044443; x=1691636443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yD1/QET0H7GCDRzUTBD6N5PpQd/kikCUI2RLjjjRGxs=;
        b=WRRecegVOujYjoJFDv+plxKF8HYevpAa9A7SuIgY6Z+q7S3zTNKPe/OMqJyKVEXd8S
         NYtv+QW6+gDE7rcKb95nDG55g/G5L6aJsINxmWqB7IZu981TQi3ToqBpJXKGlYSGG8gD
         2cYVrY8RWHyCDakPPCps75INLkItUgFigy9gaeFv6ngm3GqiqdiMd2Avdpm9gLH+E6/5
         97pjAVoHXpg9HzRbYHBp4HM0pX6HP9AdIVAve70Kq4/gsHia/fcf4o9CRQqEHzGTHHdJ
         ToYKhFqYMU5L4ULxKNWfK6ugdQ1UQ/o2CZZQOHI+RZtGm2THDDEvYMmUIGsnfku4eARZ
         wPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689044443; x=1691636443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yD1/QET0H7GCDRzUTBD6N5PpQd/kikCUI2RLjjjRGxs=;
        b=WhX2dJHweC3Fwjq+tHbVY1p5oBhhduUFU+mon78P11LVOjaA3Dgg3nHvvdomOuPnLB
         LtP7mQAiRPa56+XxQtmG3Y48uAU9LQqSx1IG/KcEJ/Sc5imifX/3jM4U4HzfYTyfakFF
         oxR+WnwMmzl3XrOHjGJ/EPAuzLjN2vEMuhUvr8mpoNJMi6KhA+RXBIeNYvAC3NwbSslW
         vOu/YmGIR9itf8DX3JgLg58mLZZt9R2Q5N0HGjJ/DuKbfTZPPdL20PSgCWBKUQ1RZOAd
         5sPJSWADNlgsGQr9ZdxMHRf3Z10b5ltOuxXoUozfBE8X0oi5CMN+TGCFECODG63GqpWm
         pz2A==
X-Gm-Message-State: ABy/qLZeNUQz7usEu0/4mJdE23R916TPSn6EsNOMUgKY/l5ued8xmENw
	NUBKzM6R0JmiNGkNtQV1jUXaCQQP+NOO48+pKzc=
X-Google-Smtp-Source: APBJJlHUw3gaBZUJJg5oo6IIH8IbZplYHllIi9LBViqPOkVo4UCV2KlXZef1AztQpcLvoBgB8MbmPNUqN32MrVjHxMI=
X-Received: by 2002:a2e:9a86:0:b0:2b5:86e4:558e with SMTP id
 p6-20020a2e9a86000000b002b586e4558emr12361079lji.38.1689044443268; Mon, 10
 Jul 2023 20:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710215819.723550-1-hawkinsw@obs.cr> <20230710215819.723550-2-hawkinsw@obs.cr>
In-Reply-To: <20230710215819.723550-2-hawkinsw@obs.cr>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jul 2023 20:00:31 -0700
Message-ID: <CAADnVQ+F5VT72LzONEo79ksqaRj=c7mJDd_Ebb87767v01Nosw@mail.gmail.com>
Subject: Re: [PATCH 1/1] bpf, docs: Specify twos complement as format for
 signed integers
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 2:58=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wrot=
e:
>
> In the documentation of the eBPF ISA it is unspecified how integers are
> represented. Specify that twos complement is used.
>
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> ---
>  Documentation/bpf/instruction-set.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/in=
struction-set.rst
> index 751e657973f0..63dfcba5eb9a 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -173,6 +173,11 @@ BPF_ARSH  0xc0   sign extending dst >>=3D (src & mas=
k)
>  BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ bel=
ow)
>  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> +eBPF supports 32- and 64-bit signed and unsigned integers. It does
> +not support floating-point data types. All signed integers are represent=
ed in
> +twos-complement format where the sign bit is stored in the most-signific=
ant
> +bit.

Could you point to another ISA document (like x86, arm, ...) that
talks about signed and unsigned integers?

