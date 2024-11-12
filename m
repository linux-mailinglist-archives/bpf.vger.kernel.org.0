Return-Path: <bpf+bounces-44586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 867FE9C4D91
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 05:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EFB1F2379F
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 04:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC79208203;
	Tue, 12 Nov 2024 04:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvAfu4os"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855411553AB;
	Tue, 12 Nov 2024 04:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731384525; cv=none; b=ZZyL5gNX14cikgZQCx1DMMczhzGfCvbNF5ZPS+3hLSEhTGHI6JQevV7YmImT0BxiT/MERLlm7C7KDrZC+Mn+srQoYNx913E9UMdFB20otShek+JYRfazzneOLjsFePjqWI76pCw5tTAdJuLaBhlgNUoPDPzy2qMnjMO7ILk1Q18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731384525; c=relaxed/simple;
	bh=x44oSdF0nwBPGTpVBEx+1NZSMpUJQedkRCb7nBMhKMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYB8YDW1oiI8a9ZA6Vqa6gNeKNLn4hktV8JO75HE67G+4oU+c7zzQG4stwhbefqy+jxqtJJsJBgaetRoStyNNS4o66FFlC8PNNHA6kfL51bGC9PrVNQFNX6itrIN6UHl+/2i6VqGkEb26bwJJwOnREFvDJ9gO5n0bamqxtT6Zkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvAfu4os; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ee386ce3dfso4699929a12.1;
        Mon, 11 Nov 2024 20:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731384523; x=1731989323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQnNufH5nF3Uw0ZlVqwMJJAJ0p73ToD5HmlOSlkMruU=;
        b=DvAfu4osCTM4opfBPon2MxO38MzFhjIZzs+03MOkmoCO1Elg5bbx6ghHgv7z/Xfsng
         LHjm09+44/GPhAFHue87eqAaKTo9mv/dumMU0ZzTLKp5YM/UH+yv6qg08CEufOrV0O38
         MbKo6AJtjN8JjRbF2RhtxsfEuqmw7QsCFZEQXSeOiM0DtzZdZ9l3Idcmi60QYSe44DtN
         aFIFbAmg7HJIU21eQVNJuE+9bCh8cFy++b3HjGryaoIKp8+C+DYmnMyx1qms/fB3nfwK
         JnbdLDLi24eK7ZkwG4EOoEY5PK3Zc5tvzaVNWtSx2vpCkphu6A4UbBpop1f03GLonsI1
         nHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731384523; x=1731989323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQnNufH5nF3Uw0ZlVqwMJJAJ0p73ToD5HmlOSlkMruU=;
        b=E1Kusk7EvD5B4VwH4sjzE4cuQW0AfKWU2ftGji2rqSSjX/X2H59BA9vYJh7rNh4ruM
         +E7Ec518HoscxHdLvfCSEtdz6+sq3pNsYo+wFktMKR1aSbA8F4XraiX1/K4tnAZePi+j
         iA9eoljOn6BxroOXsXfwRbx45qRuBNebf94jCa4cTmP2tZtOo9+txIwPUw8UwULU7uVo
         epuOe+k4z3jce6iW/azL+iicL/evGfTO9mCEhnJOasrIdrkmM1q98d93u80MYttGpnMz
         TFfmAvr2LieArt8AHUFRRna4X0qpSEv+2cuG4fhTqm/Y/PYgg1VOXc/3MP1Pt8UYZJw7
         +tsg==
X-Forwarded-Encrypted: i=1; AJvYcCW0UmDITSbP+bEyZGccT5GVakZ85jSeuoF6lk4H/ce76zjmmMCY1mMoxO7wAsh1LYPF+e2ZBsTk7OwIaPgE@vger.kernel.org, AJvYcCXth4hKWZaBpRW5WihTXp/r2C4+qScS3L6xuyGXvlBYr54nXHBwGIz6bTRahX+kXU1R9kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBb+OVuLvMW2JhTUUi1ejKNUx1+I7xpp3IgVpIoh3qC4pcU9zo
	f0znA8s5yXbx9scEX6WzOz093UVynxv601SQ+5YKNmOe0OZE0075Xjw8dsHpRnT9UEDOaeyx0MT
	Io7xVSqYkKdCzKZHZss0fCdZ65Ho=
X-Google-Smtp-Source: AGHT+IGDJzpDc0ps2CN5aFTmaMRmVqKuqF3PMSugsWmzNm2gbi/ZWw5m9L49BoCN3W855CARtjc7/i563+qpLL66Gqg=
X-Received: by 2002:a17:90b:4b45:b0:2e0:8780:ecb with SMTP id
 98e67ed59e1d1-2e9b1f64d99mr23732679a91.12.1731384522738; Mon, 11 Nov 2024
 20:08:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111024814.272940-1-luoyifan@cmss.chinamobile.com>
In-Reply-To: <20241111024814.272940-1-luoyifan@cmss.chinamobile.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Nov 2024 20:08:30 -0800
Message-ID: <CAEf4BzYgqb=NcSCJiJQEPUPhE02cUZqaFdYc4FJXvQUeXxhHJA@mail.gmail.com>
Subject: Re: [PATCH] bpftool: Fix incorrect format specifier for var
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 6:48=E2=80=AFPM Luo Yifan <luoyifan@cmss.chinamobil=
e.com> wrote:
>
> In cases where the SIGNED condition is met, the variable var is still
> used as an unsigned long long. Therefore, the %llu format specifier
> should be used to avoid incorrect data print. This patch fixes it.
>
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
> ---
>  tools/bpf/bpftool/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 7d2af1ff3..ff58ff85e 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -283,7 +283,7 @@ static int dump_btf_type(const struct btf *btf, __u32=
 id,
>                                 jsonw_end_object(w);
>                         } else {
>                                 if (btf_kflag(t))
> -                                       printf("\n\t'%s' val=3D%lldLL", n=
ame,
> +                                       printf("\n\t'%s' val=3D%lluLL", n=
ame,
>                                                (unsigned long long)val);

the fix should be casting to (long long) instead

pw-bot: cr

>                                 else
>                                         printf("\n\t'%s' val=3D%lluULL", =
name,
> --
> 2.27.0
>
>
>

