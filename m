Return-Path: <bpf+bounces-5686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B582675E3FA
	for <lists+bpf@lfdr.de>; Sun, 23 Jul 2023 19:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00421C20A6D
	for <lists+bpf@lfdr.de>; Sun, 23 Jul 2023 17:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9862108;
	Sun, 23 Jul 2023 17:10:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B6B1C17
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 17:10:20 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B4BB5
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 10:10:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5222b917e0cso440483a12.0
        for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690132217; x=1690737017;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yCYgB+83w7FONnneOpSfBqDXeZikyV2HJwESUN8po9o=;
        b=h9FqDsGBKjXoqdTP6FI8q0DpNYBlCfqkY7vNtCcLjCatGRXyGPdmspyA/Pe7ZAb2Vf
         mAGToIpxmBGMlI8YySMV/LkUgHKCPRhYmnGiwQUgJRh7GbfNWbHjvtOYCbScMrE/XJv1
         P4HxfDx5nB6g5YP+EpzTBo0+w9tcZheASCU59JcTdXT/oOt1GHMEuz8tRV5K/fO0eAC9
         nlCVcRxbWiQKOB6UZhkClRqBkEzW3bBpAbTSo6YeYb/ZWTcUB+ASKia1XruQ1jOvKLu9
         ZDZ58FzyuNJdP5XODusKqrhYO5sbHqlVPEsuu7TbwxikgQU2ytCT3dZjswDuAi3fS5Ne
         R+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690132217; x=1690737017;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yCYgB+83w7FONnneOpSfBqDXeZikyV2HJwESUN8po9o=;
        b=KWqoPT0fRpP3mm/gK33GD5OAh/6P6kfOPZ33bNg3mkfX8gU2T+kT6pCXJOoNC/dkmN
         wZ8K/DIuUbDjknf1T4iZUP+6C0DPsvWDUKeKmVtDxhxUIRYsdm4kfT7/Mqs6lA+vMcG/
         C/2Dk/ftVTtfuB48tkM7y2Bhc5dn0s75ijAjqj4hclhwaueYSzhN4xREFJTF1Ba8V54l
         Q8WtNt1zSo63VxUFiTT7ok7NtLQq5MkEj6J8R8WJN1YSKbF52lH3eZxw7fWaM5GKbXWH
         Xkbb+cY8HaG27sIIeZUIEqblFnSb8iPxmL/SadDy56ECQkyjSDJ9dga46pvw93iLaPaP
         3qXg==
X-Gm-Message-State: ABy/qLZyI/1eUaLlLyrS/V1WKHS61Y6zJdjpaLueTghpxVZauYrPulMT
	xQPh0xppNzJYxIlkAEqqp4zZaPoxVqQ=
X-Google-Smtp-Source: APBJJlHqFfQklW/CIBSXSNoP+dKbURBBNEwO55HUp24I40A0H/5SRe31Nuj/E0Pdl7otL93s748ZFA==
X-Received: by 2002:a05:6402:1814:b0:521:d23b:f2c5 with SMTP id g20-20020a056402181400b00521d23bf2c5mr6809277edy.14.1690132216998;
        Sun, 23 Jul 2023 10:10:16 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o4-20020aa7c504000000b0051495ce23absm4994113edq.10.2023.07.23.10.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 10:10:16 -0700 (PDT)
Message-ID: <32dc8c48803ff047266ee396fed3ccc9f7f0147e.camel@gmail.com>
Subject: Re: Encoding of V4 32-bit JA
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, Yonghong Song
 <yhs@meta.com>
Cc: bpf@vger.kernel.org
Date: Sun, 23 Jul 2023 20:10:15 +0300
In-Reply-To: <87a5vp6xvl.fsf@oracle.com>
References: <87a5vp6xvl.fsf@oracle.com>
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

On Fri, 2023-07-21 at 18:19 +0200, Jose E. Marchesi wrote:
> Hi Yonghong.
>=20
> This is from the v4 instructions proposal:
>=20
>     =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>     code      value  description                notes
>     =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>     BPF_JA    0x00   PC +=3D imm                  BPF_JMP32 only
>=20
> Is this instruction using source 1 instead of 0?  Otherwise, it would
> have exactly the same encoding than the V3< JA instruction.  Is that
> what is intended?
>=20
> TIA.
>=20

Hi Jose,

I think that assumption is that `BPF_JMP32 | BPF_JA` is currently free:
- documentation [1] implies that only `BPF_JMP` should be used for `BPF_JA`
  (see "notes" column for the first line)
- BPF verifier rejects `BPF_JMP32 | BPF_JA`
- clang always generates `BPF_JMP | BPF_JA`

Thanks,
Eduard

[1] https://www.kernel.org/doc/html/latest/bpf/instruction-set.html#jump-in=
structions

