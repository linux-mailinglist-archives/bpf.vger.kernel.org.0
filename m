Return-Path: <bpf+bounces-21533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3827E84E90C
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C8C1C22661
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5339381BD;
	Thu,  8 Feb 2024 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzrB8a4W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD933714E
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707421255; cv=none; b=cJD5+XiBNrHEQ4fadjAvxBPfOETbBNeBXdHbjUArcTAm+ug26Ko32IffyCxTbyEAh+18vvMms+N1ky+ycOHRZpK9Ja1sY8z0Et4tfKqFYZx8dlPpANgvpFT46f9DUgKQDukTRpOWdRR8N6rA/eqk/7pPnwbNIHPFzCBMX+qTamw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707421255; c=relaxed/simple;
	bh=SAnX8KC+MfL+MT2psUZA7PzKP31URmvWKGXkUgg41Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDmcmyatPui94JxbRByKun/IpJLVveXSoVSIJzB2qO08gOXx34crzwiV3tqFPAZwWsRXOfFz2rjJyGGxgC6J+8B6BauBhc2IzCzgRIIEntukBbvJ9oDoU9c1LWrjulqNJlg3coiuJp6AEwcczBXvDE4+sMyrGzzAnMRuBieH+Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzrB8a4W; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2967682b29aso164725a91.2
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 11:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707421253; x=1708026053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Uvho/3+SQ/oHGmByMgHt7zgIL+iC5vHc1U18bVb5MM=;
        b=SzrB8a4W405B2B3OySnmIH2EJI+Lv0FLP/ohliO3kcJd3hajm5PPYVry5C1cyaKZC7
         gM6i5lnqTGc1mgvI5SlCfrLIpMUmUVnD68XQ56XxO8epEP4P0VLmZt3p0HCbd+Frk0wp
         yxYjPx3SADWCXib28ZthnbotyNT8KY0WIDvbH5+lZ/4lA1KvCj4HRi948SNTUIPFVqK6
         dprRIIhpNTS3zQGshMmV6blIDXBYXRLOyD77xRxsplnh5/MJYAVFwKBEdjlK7DSnoa9a
         sKKeQ03Ay0dVRJM9L7TqrcqN+07FgFfLnJ/P20H144gnTypBGqHWA3l0zGuTqOiUA0jy
         qwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707421253; x=1708026053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Uvho/3+SQ/oHGmByMgHt7zgIL+iC5vHc1U18bVb5MM=;
        b=j8GTizZPru3rYZDVkm+HeiDN8IbOy0zrsOUSU3xZlnVUyVQWJ+8gYBKexaHmSAyDkl
         AzKt9d3mBpvjHMK9n5cohjAk50pWwZS0I8KdrOVR/AVT7cxLHwnSCmlEqF7z+SPt7k8q
         tcBoWJ/q7VTZ0PlFH7Wv6webTaFskpV0XFJ1Kww3HnPZ8ALheTRx3PXLG+JG75ex1Ei8
         18uw04o4jePOC4O1g7Xvqe7KM8+INwXk2ACcReH+0967NLEd2f/6y9nrb/+qDytYRMrJ
         Wd7Xousjs7ceuqLn0GKAmy94jhWihACWzXAVrAIjoDu7St5IHfkBIR+X65hIe5A40vxF
         X3yw==
X-Gm-Message-State: AOJu0YyDWZOvsvMssaHaHRbq+Zsr2WXh4GCOh6AjCDxX5ngj0OpEzMyI
	Il4vXVljlbA3LBCG1G09vjXa6GFJ+e8xZoUa8G6GHI0sxKgZOfSCBYVn6Nri48ea8yCRHG8zbfb
	pBu/0t2UFEMg2b0VkkjTRzN682uc=
X-Google-Smtp-Source: AGHT+IHGBMbZXHIO7wh/7W+Hm0PyEnhoXRGksIqAPIhAHQIpdmj6FHs1+mVU6DCoLu0kkLet6IoYejSmDtZF3q20q9k=
X-Received: by 2002:a17:90b:118d:b0:295:f83d:590 with SMTP id
 gk13-20020a17090b118d00b00295f83d0590mr252273pjb.27.1707421253360; Thu, 08
 Feb 2024 11:40:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com> <20240206220441.38311-2-alexei.starovoitov@gmail.com>
In-Reply-To: <20240206220441.38311-2-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Feb 2024 11:40:41 -0800
Message-ID: <CAEf4BzYBjzHL20NU_yuj+en-YF0dJmHuvB1SOPGZc=tnbhjZhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/16] bpf: Allow kfuncs return 'void *'
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, 
	brho@google.com, hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 2:04=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Recognize return of 'void *' from kfunc as returning unknown scalar.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/verifier.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ddaf09db1175..d9c2dbb3939f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12353,6 +12353,9 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>                                         meta.func_name);
>                                 return -EFAULT;
>                         }
> +               } else if (btf_type_is_void(ptr_type)) {
> +                       /* kfunc returning 'void *' is equivalent to retu=
rning scalar */
> +                       mark_reg_unknown(env, regs, BPF_REG_0);

Acked-by: Andrii Nakryiko <andrii@kernel.org>

I think we should do a similar extension when passing `void *` into
global funcs. It's best to treat it as SCALAR instead of rejecting it
because we can't calculate the size. Currently users in practice just
have to define it as `uintptr_t` and then cast (or create static
wrappers doing the casting). Anyways, my point is that it makes sense
to treat `void *` as non-pointer.

>                 } else if (!__btf_type_is_struct(ptr_type)) {
>                         if (!meta.r0_size) {
>                                 __u32 sz;
> --
> 2.34.1
>

