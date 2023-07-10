Return-Path: <bpf+bounces-4641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B2D74E010
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 23:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23671C20BC1
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 21:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C33B156D1;
	Mon, 10 Jul 2023 21:13:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33604154B2
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 21:13:05 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0EC1BF;
	Mon, 10 Jul 2023 14:13:04 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so9908626a12.0;
        Mon, 10 Jul 2023 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689023583; x=1691615583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6kK/RQkOW6K2HTjk8dBNhoajxT80PJhfhYbeHP0IQ4=;
        b=MOBWdpCFwqMfSGCNViCX1Rx2N7wqpnJDbY+/+muq7eZUcASjGpTFgIHVmGfOLAiYkV
         iEP/Y2/ym5EqCHgUABkHf1pOgO0/+Z9R1ymBWTrt3xSOOkJn1vb9oPKJBW0t8RgYmlVS
         BKKTXxt8HtFjvNxQzjOc6iA5qS7U0IHE3uYHsXZ5XhzSx1uRv1I6sBrw7y0vc8Yg3vFB
         i+gGXpsUs0PCYgCdjrFfcOWUFBBbtUZulx6r4E3webIrjg04Z8JB+sXQn6cmOdm5nzpx
         AJArxl+DC+9ts49BSA2iMPbSikZ84MhlnWiVFAlGYAofSBxc7oiu/byrS+wmFylfRNk7
         9LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023583; x=1691615583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6kK/RQkOW6K2HTjk8dBNhoajxT80PJhfhYbeHP0IQ4=;
        b=j0grWtASl+/Pv7z0KS9gcUXmKqLobOk8nMXDS79OxWOLCjiMEqYhxgWNGh2bU5FzCl
         MwK9ISh8HXuZEtnnh9D8fasD3zNWJemFhhVXTTUwP/CR4B48UIYiiGooJqjBXaxmHtQ/
         Cos/Avst1jQQN3Z74H5sIikvfVA5ZFdiViTRnOm2P91bJDtmy9ifOidBe0AJWtNwFvQ6
         /BoS8CfrVWjjiILbSLabSfPIwI3aqm/ZIe8tQyZ5oCSFh/LSWRcPLncEq4wGRrhaf8cK
         93yU63WeuyH3rMD7w2eTUZ6yN6WW+ydfdLr3fA6inaOioQ97gHG6KSPV6Cu3cMWUfaCE
         ImNA==
X-Gm-Message-State: ABy/qLZxPwah7g4yqKrGZ6KY/qk0tOVSBAdkks/jjnjeRYqvSsDXwIoA
	0GMPVRgrC01nEbYRU6sAHFXGuhZh0J4KnAi/+j4=
X-Google-Smtp-Source: APBJJlGXAuAsz/yEmN/U9nSHxK3Z513ezbL/SXnLdK29inJRIJNQ0mPvqyZSYWXw4qvCEuPNyj+Kyc0NTC7TEL+M2l0=
X-Received: by 2002:aa7:c74a:0:b0:51e:1a58:eac0 with SMTP id
 c10-20020aa7c74a000000b0051e1a58eac0mr19869791eds.12.1689023582711; Mon, 10
 Jul 2023 14:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710055614.1030300-1-sanpeqf@gmail.com> <ZKw+6edWZJoSPGdn@google.com>
In-Reply-To: <ZKw+6edWZJoSPGdn@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Jul 2023 14:12:50 -0700
Message-ID: <CAEf4Bzb-xSmpVFM_nCX7DgLuT=tR2GRCDHa0mw8FwO-rpy3xoA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libbpf: fix some typo of hashmap init
To: Stanislav Fomichev <sdf@google.com>
Cc: John Sanpe <sanpeqf@gmail.com>, daniel@iogearbox.net, ast@kernel.org, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 10:25=E2=80=AFAM Stanislav Fomichev <sdf@google.com=
> wrote:
>
> On 07/10, John Sanpe wrote:
> > Remove the whole HASHMAP_INIT. It's not used anywhere in libbpf.
> >
> > Signed-off-by: John Sanpe <sanpeqf@gmail.com>
>
> Acked-by: Stanislav Fomichev <sdf@google.com>
>
> Doesn't look like it was ever used.

Ack for the change, but the subject doesn't correspond to the change
itself. You are not fixing typo, you are removing static
initialization helper.

