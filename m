Return-Path: <bpf+bounces-64760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB64FB16A2F
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 03:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184641AA24B4
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 01:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D9A126BFA;
	Thu, 31 Jul 2025 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4Q+30mV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA182D023;
	Thu, 31 Jul 2025 01:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753926080; cv=none; b=DjJbSrXnMpsBNqIWiL7lZ/XvuBQGjL7xI3gqQPfMzIyBXX13laey8fOanPjvorIsPJ+1ZGlXmbxCSVBtYFRDFl+gtEBB/+sdpbJFRrCF/K6kEWWJPJ604Z/6KFqKhkxrjD6iqGX3jFWcir3QWaeEoyQaZAFiJd9QUaxQ/fOBUUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753926080; c=relaxed/simple;
	bh=tdhLpmgh+j5ElD6i+pbMjfeZfwTGuAl+Bo5yjdqEWDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HguR8BwLe47r32vjTjrqoKqaxOm5kTHblfLcu5PmYzp05CEsqxdHi54ZES96mWyLaf02sP29YA/hYIHBX5gYSUcQSVG1vIv7K+s9dMe1y697wyljUeOeOCMaKZjhqgSoN/eCGz++YGF/q5wltRWsNEfoOcxiJh2HVimy0GXfeMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4Q+30mV; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6196c1bd011so331570eaf.0;
        Wed, 30 Jul 2025 18:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753926078; x=1754530878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fW77B+NyilRLW9+EkEB0yd2VhBMeDvYnsChu9AayKN8=;
        b=P4Q+30mVKu3RMJsFB/O78tL6DA2PNMpBO1ZpkiHkoQswjmurAWBqmEk+kSASUrxI9S
         shdw21wOOIavxA57ZMypJRQ0jBau1/7oe5t22FpfZAFgy2VIVer1kchoVwYyQk+qQG84
         NZIR+D+4tRAhVVvzMkz6gkNMvZf4kfjKcg4zA22QG1FtxDx+ark4qoCpD5WCF6RegmAo
         LqMhFn2M0ZbU3YfjMzF6vjiHezakKDEUycH5eRs6mlL6ZNuCalE/YU8CIZ4ZUVRDn+SH
         ECq04sjY+Jno+zKuPC2E9V8UwqlNdlQWjZEnRU40XfTibn5oBGeMk6OPFHGk+HYR2tLr
         KKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753926078; x=1754530878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fW77B+NyilRLW9+EkEB0yd2VhBMeDvYnsChu9AayKN8=;
        b=lEHvUUG6/35y7e1o8Id9F0O2ooZzR4TdKXoxGmf1zjpI2ZDJiPuOsNjDnw3Dtzhe5F
         NxHmQSHOAKtYOKEaw9wss61+7E0rEtQdN4Zex+EkUnfoegwo5LKXkfFZI40e85Iz9Ygd
         3ZQLzmN5KuJ37hWw2TJlDpapNeCfmYiO7xhETkhMpLTR9PMEQiOSRkNXru0tQUyD0B14
         TA80HONqqc/wNC+rPFBazXJIYbVjM/J3cQXlu+S7oD67388sSxyEnhV2Od3iCdeInnS1
         Usc59noftW4K9yaxTD0naMIAna6oNc0DksE8siKnkRHHrXSYqW/j8AiVy9/h/7jrN4V8
         LieQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7J9WSpwwsMUGMbx7Dq57Bb1H9tEK9+jMOS0lFUiFjSwxuH626XlkqSUqOZ5W/2SCLxuM=@vger.kernel.org, AJvYcCXW5M4DKCniljNXHTUq+AM1XueHqLpvYQCmpMRp8yMi2ArHXzjrbY9+fyHYBUlhyvZKQnAzDR/KUKl/vD7r@vger.kernel.org
X-Gm-Message-State: AOJu0YwuLSaGSqDeItuYAC/enzmgOqK0fs6umDR0sZGT9NWp6We1ojQB
	a+P4Xjy8H+prd+EV0zgg2UyznwOImQGHRYwDJYhCf1Hdx9jBNDU+p7RzfCuLGauYLe2/pp1/IYl
	t56f5qFL/5/O4O+36kKsV4aQLlF76MRrQQimwo7A=
X-Gm-Gg: ASbGncts6iBKdrpTqrwU4xBtsl0PABzCB+ereBfpSBwdxPsvjrw90wJeGOZI1KYMdas
	c2byF4FjqYoiGQOUz13eIKeRJtVIPjXF19TJDNf9KT21kFpmRVA3XTSOC9aUil9766qrjqTbzDW
	RknS/UGRjKu5Yx0ydxwI0IiYaNJi8DujpoHoJjRFG5+hK3irnMB6iibS+pbLOH2v1eYXuC/2hRT
	redF2/Ju/YJtCR9PQ==
X-Google-Smtp-Source: AGHT+IGrwETmgwM/eaomky8/DWT5UsMd/7GLoLVGdUW9DDENQdNs73QE10nEsfnkG9YeUG3EETFAYGo5/JXi9CTKOeo=
X-Received: by 2002:a05:6808:306d:b0:433:577c:cd3a with SMTP id
 5614622812f47-433577cd705mr91843b6e.3.1753926077634; Wed, 30 Jul 2025
 18:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730131257.124153-1-duanchenghao@kylinos.cn> <20250730131257.124153-2-duanchenghao@kylinos.cn>
In-Reply-To: <20250730131257.124153-2-duanchenghao@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 31 Jul 2025 09:41:05 +0800
X-Gm-Features: Ac12FXwfHcYZyp7QvEszP3wp-X7El4czn0VKEBooVZAqU3sLFiaLx6SKAVVgtCs
Message-ID: <CAEyhmHRUn1_ot5LzZ1ir9hLVJsnBW8j-jFDX7-VwsOTtWAG+1A@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] LoongArch: Add larch_insn_gen_{beq,bne} helpers
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yangtiezhu@loongson.cn, chenhuacai@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn, 
	vincent.mc.li@gmail.com, geliang@kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 9:13=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos=
.cn> wrote:
>
> Add larch_insn_gen_beq() and larch_insn_gen_bne() helpers which will
> be used in BPF trampoline implementation.
>

Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>

> Co-developed-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> Co-developed-by: Youling Tang <tangyouling@kylinos.cn>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>  arch/loongarch/include/asm/inst.h |  2 ++
>  arch/loongarch/kernel/inst.c      | 28 ++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/a=
sm/inst.h
> index 3089785ca..2ae96a35d 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -511,6 +511,8 @@ u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int =
imm);
>  u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
>  u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, =
int imm);
>  u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, in=
t imm);
> +u32 larch_insn_gen_beq(enum loongarch_gpr rd, enum loongarch_gpr rj, int=
 imm);
> +u32 larch_insn_gen_bne(enum loongarch_gpr rd, enum loongarch_gpr rj, int=
 imm);
>
>  static inline bool signed_imm_check(long val, unsigned int bit)
>  {
> diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> index 14d7d700b..674e3b322 100644
> --- a/arch/loongarch/kernel/inst.c
> +++ b/arch/loongarch/kernel/inst.c
> @@ -336,3 +336,31 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum =
loongarch_gpr rj, int imm)
>
>         return insn.word;
>  }
> +
> +u32 larch_insn_gen_beq(enum loongarch_gpr rd, enum loongarch_gpr rj, int=
 imm)
> +{
> +       union loongarch_instruction insn;
> +
> +       if ((imm & 3) || imm < -SZ_128K || imm >=3D SZ_128K) {
> +               pr_warn("The generated beq instruction is out of range.\n=
");
> +               return INSN_BREAK;
> +       }
> +
> +       emit_beq(&insn, rj, rd, imm >> 2);
> +
> +       return insn.word;
> +}
> +
> +u32 larch_insn_gen_bne(enum loongarch_gpr rd, enum loongarch_gpr rj, int=
 imm)
> +{
> +       union loongarch_instruction insn;
> +
> +       if ((imm & 3) || imm < -SZ_128K || imm >=3D SZ_128K) {
> +               pr_warn("The generated bne instruction is out of range.\n=
");
> +               return INSN_BREAK;
> +       }
> +
> +       emit_bne(&insn, rj, rd, imm >> 2);
> +
> +       return insn.word;
> +}
> --
> 2.25.1
>

