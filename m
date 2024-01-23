Return-Path: <bpf+bounces-20059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC2E837D2B
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 02:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6BA291D87
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 01:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E881AABD;
	Tue, 23 Jan 2024 00:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atuYGBlb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F7C38F8A
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969822; cv=none; b=UOZUtpEz+TBsQiYW6PT6HImgiAIE8DCpNW8JAdv2RTYSWdKnXQM/xyWwEfG+G7CyVKCPCEbCtIqh92HwIh2sUZL6ae/vqQArBLEvwSnJ9hT6VCf+l9xNK4P2OJ/owU7Fje0XZnB4fhre11KIDdme8i9VKRrZbb4QawPCXGjbZz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969822; c=relaxed/simple;
	bh=mpkJCBEnxBYv9tEDsOXvI0diZBCgzq8pPEBGZ7v43Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0hp0tvpIOp9mM6MKOXmHc0+lk9TIQw5fF3xLqdIsX5QzYVfbhkP+0Z6bndjZNbyftl3W/sNXtlRH2udbdQFxP6j4uwgGd3xGDH9O2SrmXnmY/emgUEw1IXbxayT+xD+0hRS5C7WUqz0enDXiuH8KmVnj9+x6ViTR3Q1s9slC0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atuYGBlb; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6dbcfef55dcso2273812b3a.1
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 16:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705969820; x=1706574620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDjwU4tSWg1WO/o16HvpLeGE17JurUj13Zt3+NlHF+M=;
        b=atuYGBlb058m5lyBrPMpEXD4hX5qhG/RgIelCUPLSAfHAfh7DGL6BXar079wqj+fZ8
         XQUwrw0FTf5bb8woWbXhUj39vqkuuNd5lNgoWie8dAlIR/blzhfuRnqFzBLQgRZtMcKj
         en2sr9aSyhDsY2NAbufA1Z4uWA9eUgdYISr+kugs6HxpHMivKG3DBxj5kVr52PQXG5Kn
         6nTEKdkfs4aFeEzmUwAxhQawWJ+OGYZ6WZYIstCBhq+flm5/ZezpCcvy7O9+1ByoBtS2
         DNWyfm6GJPU1dVKwsP1o+2pyRsX7dERsa2yo0CGztwDwjm5j2d72rxh2+l9MrIPcpJpl
         4gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969820; x=1706574620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDjwU4tSWg1WO/o16HvpLeGE17JurUj13Zt3+NlHF+M=;
        b=r2YjgQqbTI08dbZh9yUqV8meweMX0Zzu6ZETpisI8FAr/Qdw920mCF4pGL/LXsE3/d
         9brL9qRzfxUtuL6+r33dHZGEOWwPPTRqdodIkEE+hwFUG0cK+2YcNX+rtlg5zhQ8+xro
         +qkRVHmK1fJce1gLc0KD1a4JfDzYM89qfKiybdAcn5p5hMLiBztrDVtC4WXKUZcX+rcR
         i29jVJ/0bmGTX9f3zo/HYxNIWi0dnmp2GkZqZcjEyzO90TJTe8SVx647w38fojqxRjuF
         P/qiX9SS1TSlKJJUEeFKMD85M4KqoSN67gLpvJ71sG3VhyL6cri/AUe5ATDGM15Frekn
         ctrg==
X-Gm-Message-State: AOJu0YxEiBLLb/WhzculfvJdTrzRbFIgG+ToWlreJToN0lDn8P6xAU28
	XQSUIB7m55VIuQ3n4r2yXHKLlaMUcVzJ26yEyT16xEfehT+9bUx5MTW+DLKkEUcSxHP6dYVJtQi
	tyM6yXqsy8kI+2eVbLKz+SfwT60k=
X-Google-Smtp-Source: AGHT+IGGIxKs+kHotfJ6m9iComw43dMPb6DP0ZpYx9BpZlNLLK5wxXoVEDnGYyGletmeyCOSnME8Bi5XW2Zg9KSzVWo=
X-Received: by 2002:a05:6a20:6d85:b0:19a:49fc:5d98 with SMTP id
 gl5-20020a056a206d8500b0019a49fc5d98mr4930375pzb.68.1705969819872; Mon, 22
 Jan 2024 16:30:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <B653950A-A58F-44C0-AD9D-95370710810F@fb.com>
In-Reply-To: <B653950A-A58F-44C0-AD9D-95370710810F@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Jan 2024 16:30:07 -0800
Message-ID: <CAEf4Bzb6kcR3vqvwzQbCEoW63RW7s6X_fEp9gSRSEck-oz31Yg@mail.gmail.com>
Subject: Re: RFC: Mark "inlined by some callers" functions in BTF
To: Song Liu <songliubraving@meta.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alan Maguire <alan.maguire@oracle.com>, 
	Jordan Rome <jordalgo@meta.com>, Yonghong Song <yhs@meta.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 1:51=E2=80=AFPM Song Liu <songliubraving@meta.com> =
wrote:
>
> The problem
>
> Inlining can cause surprises to tracing users, especially when the tool
> appears to be working. For example, with
>
>     [root@ ~]# bpftrace -e 'kprobe:switch_mm {}'
>     Attaching 1 probe...
>
> The user may not realize switch_mm() is inlined by leave_mm(), and we are
> not tracing the code path leave_mm =3D> switch_mm. (This is x86_64, and b=
oth
> functions are in arch/x86/mm/tlb.c.)
>
> We have folks working on ideas to create offline tools to detect such
> issues for critical use cases at compile time. However, I think it is
> necessary to handle it at program load/attach time.
>
>
> Detect "inlined by some callers" functions
>
> This appears to be straightforward in pahole. Something like the followin=
g
> should do the work:
>
> diff --git i/btf_encoder.c w/btf_encoder.c
> index fd040086827e..e546a059eb4b 100644
> --- i/btf_encoder.c
> +++ w/btf_encoder.c
> @@ -885,6 +885,15 @@ static int32_t btf_encoder__add_func(struct btf_enco=
der *encoder, struct functio
>         struct llvm_annotation *annot;
>         const char *name;
>
> +       if (function__inlined(fn)) {
> +               /* This function is inlined by some callers. */
> +       }
> +
>         btf_fnproto_id =3D btf_encoder__add_func_proto(encoder, &fn->prot=
o);
>         name =3D function__name(fn);
>         btf_fn_id =3D btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, b=
tf_fnproto_id, name, false);
>
>
> Mark "inlined by some callers" functions
>
> We have a few options to mark these functions.
>
> 1. We can set struct btf_type.info.kind_flag for inlined function. Or we
>    can use a bit from info.vlen.

It doesn't feel right to use kflag or vlen for this particular
property. I think decl_tag is the generic way to have extra
information/annotation.

>
> 2. We can simply not generate btf for these functions. This is similar to
>    --skip_encoding_btf_inconsistent_proto.

This is too drastic, IMO. Even if some function was inlined somewhere,
it still might be important to trace non-inlined calls. So just
removing BTF is a regression in behavior.

>
>
> Handle tracing inlined functions
>
> If we go with option 1 above, we have a few options to handle program
> load/attach to "inlined by some callers" functions:
>
> a) We can reject the load/attach;
> b) We can rejuct the load/attach, unless the user set a new flag;
> c) We can simply print a warning, and let the load/attach work.
>

I'd start with c), probably. Everything else is a regression in
behavior compared to what we have today.


>
> Please share your comments on this. Is this something we want to handle?
> If so, which of these options makes more sense?
>
> Thanks,
> Song
>
>

