Return-Path: <bpf+bounces-5534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA7075B8CA
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834D91C21528
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 20:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AC8156FA;
	Thu, 20 Jul 2023 20:35:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E17E2FA3F
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 20:35:38 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E591731
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 13:35:36 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso1902363e87.2
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 13:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689885335; x=1690490135;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VMDtGeBAHVgrUsRMiFQES5+irnytdObf1HIXPWVLyPE=;
        b=VAIV52zhlo6zc7r3vAiEdqFqEE/irmu8OYonfwmq5t5wpCAca0PkIP7R2rNfYGFC2A
         s1hbrHNPMtct2u5BrmlccQwxO2VxhoL9s8Oq2nzHzMB5DMJ+jUvlBNbLbe/V5xFjsDXD
         HrG8bfu/vp+YpEurhiA9i3zKbe98LzwOPcFo8fvqSSUtI9NA6cTgE9PYnKwvuOsbGq8y
         eCjUOAoKmoKw47Zrr/9lAPJi5PHfynfMqnhkTzK5BHZZZ2gSIB/Wb447OEwWdiS/nG8z
         dgAAGqE8auqt9E6SWMkeDGcU/p0NTmaBeoKejdfB+jaB4ZmMuaCmJfqpDM8a8MUVYKgb
         DJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689885335; x=1690490135;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMDtGeBAHVgrUsRMiFQES5+irnytdObf1HIXPWVLyPE=;
        b=V1+VIHzc5JMkraBUq1vYBA1IJ91E6TLhoHt6RLeuajhFL/BWq5rgypieVxlENK1lTd
         +DHVzjuZg2fEd4/h6JWF+T3C9QrDyMNu3mUmTzZpCGCxPybGBLlzGfazXfo0x/nwG56e
         Dp94bnt9CW54VjZsGgh0KBBs6MQCVgc0sDKRfmCgYJ4QaQPm278hb10ADJFVocENPl5V
         rCEM3PumLVL1exHYlrQDa0ZB+ferG1WKF98AWJtrF63YwFvu1vwPM67B638nf9VG1PXa
         mqpJPM3NsvmrPgaWSzOuQCizsWcmrVOwDHfbp0K64XBhUQBV5ZvLqpV4PNs0falBsX5i
         DC2Q==
X-Gm-Message-State: ABy/qLY6EM6bCIjtGwGJLRBdGhgm6xFOoQJE+K0gmnFoR3Mo+aAOQL1X
	SJeFQlJUVy5PmFqNdgm0IiA=
X-Google-Smtp-Source: APBJJlEMyTJIG8fGwZNw82hQc19EDes+w8ZCUYR51kSwtkwo8g3FftWZR+5mvFlzL4O26GpeyzMpBg==
X-Received: by 2002:ac2:5e34:0:b0:4fb:cab9:ddf with SMTP id o20-20020ac25e34000000b004fbcab90ddfmr2143264lfg.57.1689885334853;
        Thu, 20 Jul 2023 13:35:34 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m17-20020ac24ad1000000b004fb881e5c1dsm367760lfp.50.2023.07.20.13.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:35:34 -0700 (PDT)
Message-ID: <ab4b1d86b5a590e2d85615da9d2add90a7b165a0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 00/17] bpf: Support new insns from cpu v4
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  bpf@ietf.org, Daniel Borkmann <daniel@iogearbox.net>,
 Fangrui Song <maskray@google.com>, kernel-team@fb.com
Date: Thu, 20 Jul 2023 23:35:33 +0300
In-Reply-To: <20230720000103.99949-1-yhs@fb.com>
References: <20230720000103.99949-1-yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-19 at 17:01 -0700, Yonghong Song wrote:
> In previous discussion ([1]), it is agreed that we should introduce
> cpu version 4 (llvm flag -mcpu=3Dv4) which contains some instructions
> which can simplify code, make code easier to understand, fix the
> existing problem, or simply for feature completeness. More specifically,
> the following new insns are proposed:
>   . sign extended load
>   . sign extended mov
>   . bswap
>   . signed div/mod
>   . ja with 32-bit offset
>=20

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

