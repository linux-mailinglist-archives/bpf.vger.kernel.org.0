Return-Path: <bpf+bounces-2649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EDD731EA3
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 19:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA92A1C20BD6
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3887E2E0D1;
	Thu, 15 Jun 2023 17:05:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DFDEAC1
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 17:05:17 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A75194;
	Thu, 15 Jun 2023 10:05:16 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b443ebae0dso16163461fa.2;
        Thu, 15 Jun 2023 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686848715; x=1689440715;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=crBt2ITg8SZ2kjr+v53DzcSzxyBX77tw0/FzCIW8K/M=;
        b=DUuKjGKkLd3xr6fw7ISZK9UObyf9IKsH9P5OAMVKBBFO2p+gWILzdkAlmpX9qvis6c
         rNIKx3JtA3BKucyQwwzgvgLT/405EdgBeNp5o+KsahwdLKpFFRk9rdnmg7z7SHJOZPzK
         YLn4jzrY3rv65y71YS5w+xMd3K7068Y2Ui+ewyGSM6j7z0BXzwe5aXPLS7TmDcO+Qqzg
         u3bCkITTMBXCH1+h/MQ7hxPK1TxyNbFO/XRceINXXj2lvq5Cvd0+DfnTBuN35QDj6r2X
         eopRfgU6pF4o7AAyjP/vnsM63+YkWAp33Gis/C6he4BMsfBKr714P9vuRcc0m1IPGn+S
         u2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686848715; x=1689440715;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=crBt2ITg8SZ2kjr+v53DzcSzxyBX77tw0/FzCIW8K/M=;
        b=ikk9cwurbU7oeMZYoclSWrh2//W79KeWqHQwGqJsGH/kBa/XraXxiV9P/5AYnu98fB
         Nd6IJOmGeH/n4fwZB+v8gUA23Z4080V/d4jwCAROIJB/en6tKoduNVnFT/L8Iw9J5XJt
         COINcN5efdFy3nSCOiA37aODQPngNpTHPdZs0px9BmxBwHeYMJy7gTLSiyHTMXWBuuG8
         E93MoEYt6Cq8lljQDl3+VW+g1EK5K2P5QVjBqBLC1sWT2ugjzSFEY8e/TEXaNqVkbGr+
         r9ZQDrKt32VLiLgJa0ap096vKBhn0wF/fuoS4Ne4sRYlKrv4ixQR/HaMldHJbtzmuFXR
         3kRA==
X-Gm-Message-State: AC+VfDy6hnecGDlgPqjNSuBFN25HxxkonSkhOphWGsC/wdjLR7m7pXIs
	9zfTh1ueL7jj+T4XBzNLShepUT8WLK5org==
X-Google-Smtp-Source: ACHHUZ7r4SbDTfLJT6A+Xdd3hkh4l9+0lbKnY5uI/8PhcRo2xcI7zxTj5tNJ3wYJvt8qxVxw9ze7ug==
X-Received: by 2002:a2e:a175:0:b0:2b3:47b3:3c39 with SMTP id u21-20020a2ea175000000b002b347b33c39mr49134ljl.23.1686848714423;
        Thu, 15 Jun 2023 10:05:14 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z27-20020a05651c023b00b002adc6c2cb3bsm3195205ljn.5.2023.06.15.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 10:05:13 -0700 (PDT)
Message-ID: <fbd79f5f2b250ec913c78d91b94ca96fb96f67ee.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf/btf: Accept function names that contain dots
From: Eduard Zingerman <eddyz87@gmail.com>
To: Florent Revest <revest@chromium.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org,  song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org,  sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 nathan@kernel.org,  ndesaulniers@google.com, trix@redhat.com,
 stable@vger.kernel.org
Date: Thu, 15 Jun 2023 20:05:11 +0300
In-Reply-To: <CABRcYm+C+tPwXAGnaDRR_U2hzyt+09fjkKBp3tPx6iKT4wBE2Q@mail.gmail.com>
References: <20230615145607.3469985-1-revest@chromium.org>
	 <CABRcYm+C+tPwXAGnaDRR_U2hzyt+09fjkKBp3tPx6iKT4wBE2Q@mail.gmail.com>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-06-15 at 17:44 +0200, Florent Revest wrote:
> On Thu, Jun 15, 2023 at 4:56=E2=80=AFPM Florent Revest <revest@chromium.o=
rg> wrote:
> >=20
> > When building a kernel with LLVM=3D1, LLVM_IAS=3D0 and CONFIG_KASAN=3Dy=
, LLVM
> > leaves DWARF tags for the "asan.module_ctor" & co symbols.
>=20
> To be fair I can't tell if this is an LLVM bug. It's sort of curious
> that with LLVM_IAS=3D1, these debugging symbols are not kept and they
> are with LLVM_IAS=3D0 but I don't know what the expected behavior should
> be and how BTF should deal with it. I'll let people with more context
> comment on this! :)
>=20
> An easy reproducer is:
>=20
> $ touch pwet.c
>=20
> $ clang -g -fsanitize=3Dkernel-address -c -o pwet.o pwet.c
> $ llvm-dwarfdump pwet.o | grep module_ctor
>=20
> $ clang -fno-integrated-as -g -fsanitize=3Dkernel-address -c -o pwet.o pw=
et.c
> $ llvm-dwarfdump pwet.o | grep module_ctor
>                 DW_AT_name      ("asan.module_ctor")

Interestingly, I am unable to reproduce it using either
clang version 14.0.0-1ubuntu1 or clang main (bd66f4b1da30).

>=20
> > In a dramatic turn of event, this BTF verification failure can cause
> > the netfilter_bpf initialization to fail, causing netfilter_core to
> > free the netfilter_helper hashmap and netfilter_ftp to trigger a
> > use-after-free. The risk of u-a-f in netfilter will be addressed
> > separately
>=20
> To be precise, I meant "netfilter conntrack".
>=20
> I sent the following patch as a more targeted mitigation for the uaf
> https://lore.kernel.org/netfilter-devel/20230615152918.3484699-1-revest@c=
hromium.org/T/#u
>=20


