Return-Path: <bpf+bounces-14591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445887E6D3A
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 16:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7361E1C2094B
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2CF200C8;
	Thu,  9 Nov 2023 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWIbn0so"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3CE1A73B
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 15:20:56 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008C430DC
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 07:20:55 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9d267605ceeso164961366b.2
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 07:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699543254; x=1700148054; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YAyecrLeKq6h73KJLiv1V6G7m3P9rBqu9cetqda3OcQ=;
        b=SWIbn0soZJAM189yKkaY1jSF78lLdC0c7vp/EIoZ2ERu59XEMAfmkBsaCEYUhmrBbl
         vVQVwtHEeGQpNf7mw1ckn1R/VrbyzujYHr9huSneb0e8NZ6HrZCTZy4HFmbiq/b5wbpt
         H5Nktrzu4Uh4EjbIcn6sK0Erx4QbVxsHKoc3lKzno4QM0LOoRgHl9s/te7CCg2kQcSYm
         JIbhRMIEtnZo9KP05fcOus3+fvXE3gce9c7keL47vIyO1jmE/ZUDEAcIPWoApeANwMtn
         pNcJHMTFTjOS9lzDT0ZKRfBDnhI5zuR/xKznkBn3/wBh3eIprHgbkNYUvOsm0wu29ZNJ
         cP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699543254; x=1700148054;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YAyecrLeKq6h73KJLiv1V6G7m3P9rBqu9cetqda3OcQ=;
        b=HsaaI/AMDQcbiosLJWpkz7pe9Vq2gNkeu56WaUMGYaXEPEpCxU7axYj22f+xSPFeH3
         au5jlpCI3NxCDSpUDln2lb9WJippvPuurzomkIF/oYlM5qd2/Oxgd1VfHLPBwsETiHCx
         m/mJGLaNqphE6sIksQuvKjsEweyNWhMbx94RNTLu7/Ae1x2qfN6E/cBvkkrzQ/M6ifzH
         ZggJjV0Ytbd8fW5CNXBa7CRQnbG4G82ebSylEVmVbBtVHYeFBYw9rxZMrwnOx8macb5n
         o1h8IJcW05RookCGAzDCUchonxTmGLW/K1OeCuQGjNwx7elJZRrBzo1ttYJgMhQyGsAv
         OO6Q==
X-Gm-Message-State: AOJu0YxZLtwPnwzo2rR6iZ7JERz2YnMDntUyzHlrMRar/GkImOrns1vH
	geeyPEi4vrvzUQ34zP+yhaU=
X-Google-Smtp-Source: AGHT+IH9DgsGgD7OC/A4WEwBnk1HBDw2UTf5wxw+htSMCFRrvne5FcCSW+1cTeoGYrynKok1JEobFA==
X-Received: by 2002:a17:907:94c3:b0:9d2:bf19:88aa with SMTP id dn3-20020a17090794c300b009d2bf1988aamr4924414ejc.59.1699543254412;
        Thu, 09 Nov 2023 07:20:54 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id me10-20020a170906aeca00b009b9af27d98csm2664533ejb.132.2023.11.09.07.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 07:20:53 -0800 (PST)
Message-ID: <8163041bb608879cee598cb6262c04fc18bf226f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 5/7] bpf: preserve STACK_ZERO slots on partial
 reg spills
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 09 Nov 2023 17:20:53 +0200
In-Reply-To: <20231031050324.1107444-6-andrii@kernel.org>
References: <20231031050324.1107444-1-andrii@kernel.org>
	 <20231031050324.1107444-6-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-30 at 22:03 -0700, Andrii Nakryiko wrote:
> Instead of always forcing STACK_ZERO slots to STACK_MISC, preserve it in
> situations where this is possible. E.g., when spilling register as
> 1/2/4-byte subslots on the stack, all the remaining bytes in the stack
> slot do not automatically become unknown. If we knew they contained
> zeroes, we can preserve those STACK_ZERO markers.
>=20
> Add a helper mark_stack_slot_misc(), similar to scrub_spilled_slot(),
> but that doesn't overwrite either STACK_INVALID nor STACK_ZERO. Note
> that we need to take into account possibility of being in unprivileged
> mode, in which case STACK_INVALID is forced to STACK_MISC for correctness=
,
> as treating STACK_INVALID as equivalent STACK_MISC is only enabled in
> privileged mode.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Could you please add a test case?

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -1355,6 +1355,21 @@ static void scrub_spilled_slot(u8 *stype)
>  		*stype =3D STACK_MISC;
>  }
> =20
> +/* Mark stack slot as STACK_MISC, unless it is already STACK_INVALID, in=
 which
> + * case they are equivalent, or it's STACK_ZERO, in which case we preser=
ve
> + * more precise STACK_ZERO.
> + * Note, in uprivileged mode leaving STACK_INVALID is wrong, so we take
> + * env->allow_ptr_leaks into account and force STACK_MISC, if necessary.
> + */
> +static void mark_stack_slot_misc(struct bpf_verifier_env *env, u8 *stype=
)

Nitpick: I find this name misleading, maybe something like "remove_spill_ma=
rk"?

[...]



