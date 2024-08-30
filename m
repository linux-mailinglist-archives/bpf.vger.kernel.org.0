Return-Path: <bpf+bounces-38550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 406529660E6
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 13:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27B04B22067
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4C6190684;
	Fri, 30 Aug 2024 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb68CUSm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACE418C35A;
	Fri, 30 Aug 2024 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725018077; cv=none; b=UddBT3ovI7QF4sLCCM6o9sjgfKvIdI8+nDuikFcyzHT8PoKKtaqE+Zm0im4oYb8aA63v2JTu7GFOft19P2SHMZeW1u0oA9vqlAkmI3zpGCLrD3ibBYAKXv2XqE7wPI5m1naKu6tbmRxfglEotWYFqsuoCq59A4kFliELfX9MI8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725018077; c=relaxed/simple;
	bh=TqBzZH2PFI0FMsxL/Hah/ugt42Jh/j19MJWTore5Myw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A373xRzGvVnws5DC7bJaYiseVSyfdoE6ompi5W/q51BWxuzAfY0afsIpP+eKiNqJHz7pPVrPyl5uAp2OwClDoqZrDbFOFOa02RNWh8QRKEImO6g8heZCOXn73arMex8FqthtFUlIpjaF/mvqkfFZrCut7ZfBxNIUk9L2/DGt9Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xb68CUSm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7142a93ea9cso1435028b3a.3;
        Fri, 30 Aug 2024 04:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725018075; x=1725622875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sjO3Ifh9JNu8BhZVefkQiW+93FdbepvClKHfN3BgyfI=;
        b=Xb68CUSmDo507m4/aU+uog9q4YG28YJV6f9no2yJLB5rxyXRMIeIikIiR/K9Wvyglj
         Fnymzu8gw5RttKuJGonE7a59IhXhQQI9CAB7uWy8TUsQDFBBiJfna8bexjxS/o/hhR8W
         sCjayfn0GMo/uJY/z+GML95pE9rVYod28v1aAgppWWB3MmjDQsrp2yUFHyzpLqIeI9dg
         MoByKGnnteKfWNHeqkUsKqiddckW1YlSzfNiRE+JsN8KMPaoThzvi7oHqec1BMAmaqt6
         KsdHJqFRjXwqdt3jXNkuyMYQ6lR5bkJub2ofLj5DemtHbGu6bNPSuLUKIakY8hEDYyua
         17xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725018075; x=1725622875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjO3Ifh9JNu8BhZVefkQiW+93FdbepvClKHfN3BgyfI=;
        b=GCV7UHnmoxD6/h3y7TPu/R8HWgGH7HoNSJNdx6TNoBikDmLZLDBKYkIOBVnZ88VNNe
         vjNTK8NwVKnBccywOWcbS1Eh4atDO/WYXmpYPX/hafhRioDH+mItLlJ7PcvZozW9hd9Y
         ncqQZ5D/zvfIiiC4hDKBWAtub8srowzhzfZf4rLYSvFp2SG+I02aPc4+HtFxwiayLiMZ
         rlawl5vKDK3iTb1Z1M49u1gNmgxVCVC0LHdHEeO+FyusnO0OPCoqBWcN7eC4iegENvOW
         TnhnUO7CJF/WAYMRyJ50XXh3oASo99h3gQPlQr0ejleM4oCLa81uM/1QXsb0q8Uo9ifP
         bEBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDw/Co16FYyCzbIJZng+r2e/LdVdyHWFPOj0RYJVA9d0VbUqc458p7W3/jrNZhQSz1VZn6RRkmz8cwsXO9@vger.kernel.org, AJvYcCVB6XM3b4Rg9H4l79xyTjJiKUE2w+vngiaAIfrCaRn/YctGsqDsKnWTE3RmiasodEaQD88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIsnj6318kpz1jOwJDzjXHKnZAT/ZfXXaxaq/ZGNEUH7cMTcSj
	5hghFQtGW6wsIz8TVC4a2KhbTBpKs4sX9yzhIPhIpbq9EX2ONbGGMSKXKPl0mL+ZkNeSHgMs+SP
	Z1Tlpi3kuk0juie8cItPF9ep5EH8=
X-Google-Smtp-Source: AGHT+IEAz1CncJLTHs4vbJOSiPzAzwMwsNpSTJi0Ohh+K4gNLq0R2DDfrLmUR/N5QLcWNU8FRZZbpn9iuxNhIzY0Q6k=
X-Received: by 2002:a05:6a20:cfa9:b0:1ce:cbf6:21e1 with SMTP id
 adf61e73a8af0-1cecbf6246amr82215637.53.1725018075352; Fri, 30 Aug 2024
 04:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3a48e38f29cc8c73e36a6d3339b9303571d522a8.camel@gmail.com>
 <07EBE3E5-61A7-4F64-92BA-24A1DCA9583B@gmail.com> <bd8a6dc3e52369a30c73578ea1144a48f736f393.camel@gmail.com>
In-Reply-To: <bd8a6dc3e52369a30c73578ea1144a48f736f393.camel@gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Fri, 30 Aug 2024 20:41:03 +0900
Message-ID: <CAO9qdTH5SgSy_Mn6VMUNnkKa-Dr9x2bpgG6q=_3K8jJJT1p6sQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: add check for invalid name in btf_name_valid_section()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Eduard Zingerman wrote:
>
> On Fri, 2024-08-30 at 11:03 +0900, Jeongjun Park wrote:
>
> [...]
>
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index edad152cee8e..d583d76fcace 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -820,7 +820,6 @@ static bool btf_name_valid_section(const struct btf *btf, u32 offset)
> > >
> > >        /* set a limit on identifier length */
> > >        src_limit = src + KSYM_NAME_LEN;
> > > -       src++;
> > >        while (*src && src < src_limit) {
> > >                if (!isprint(*src))
> > >                        return false;
> >
> > However, this patch is logically flawed.
> > It will return true for invalid names with
> > length 1 and src[0] being NULL. So I think
> > it's better to stick with the original patch.
>
> Fair enough, however the isprint check should be done for the first character.
> So the full fix is a combination :)

So does that mean it's appropriate to add if(!isprint(*src)) instead
of if(!*src)?
As far as I know, the first character of name doesn't need isprint() check,
so if that's true, it would be appropriate to use isprint. Once this
is confirmed,
I'll send you a v2 patch that added selftest.

Regards,
Jeongjun Park

>
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -818,9 +818,11 @@ static bool btf_name_valid_section(const struct btf *btf, u32 offset)
>         const char *src = btf_str_by_offset(btf, offset);
>         const char *src_limit;
>
> +       if (!*src)
> +               return false;
> +
>         /* set a limit on identifier length */
>         src_limit = src + KSYM_NAME_LEN;
> -       src++;
>         while (*src && src < src_limit) {
>                 if (!isprint(*src))
>                         return false;
>
>
> And corresponding test cases (tools/testing/selftests/bpf/prog_tests/btf.c):
>
> {
>         .descr = "datasec: name with non-printable first char not is ok",
>         .raw_types = {
>                 /* int */
>                 BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
>                 /* VAR x */                                     /* [2] */
>                 BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
>                 BTF_VAR_STATIC,
>                 /* DATASEC ?.data */                            /* [3] */
>                 BTF_TYPE_ENC(3, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
>                 BTF_VAR_SECINFO_ENC(2, 0, 4),
>                 BTF_END_RAW,
>         },
>         BTF_STR_SEC("\0x\0\7foo"),
>         .err_str = "Invalid name",
>         .btf_load_err = true,
> },{
>         .descr = "datasec: name '\\0' is not ok",
>         .raw_types = {
>                 /* int */
>                 BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
>                 /* VAR x */                                     /* [2] */
>                 BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
>                 BTF_VAR_STATIC,
>                 /* DATASEC \0 */                                /* [3] */
>                 BTF_TYPE_ENC(3, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
>                 BTF_VAR_SECINFO_ENC(2, 0, 4),
>                 BTF_END_RAW,
>         },
>         BTF_STR_SEC("\0x\0"),
>         .err_str = "Invalid name",
>         .btf_load_err = true,
> },
>
> Could you please resend your patch as a patch-set fix + selftests update?
>

