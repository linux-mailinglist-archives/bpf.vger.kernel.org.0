Return-Path: <bpf+bounces-78344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE70D0BB3D
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 18:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F38E23094F87
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042F43659FB;
	Fri,  9 Jan 2026 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8Sn3qVr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522212877FC
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979697; cv=none; b=o4Qv9la5BxEWqzxX9WX/5SxH4yoA8DBJLzfnlK+litRY6Q3DkjM4nJ4NT5bcI31+NXzzFRH3HX2dtNXa2dTUY47uJKNuvCKmW27Wg17+fL4b3X3o3V8S8rXt22qGnzzfh7sHqQaWt4p9OwPHjGG+DbVq0BcaNkU5Dp64FNSho4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979697; c=relaxed/simple;
	bh=yxc+8sWpdSEoZuhfv51mCEtzizNqXce4PXMsVpColjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arvwkSqLtsVAZCwnL6sJfFe5xmut2FGn6+3kz83okbO83ZjoWSm1vrvi3AszQQ6bRsrrNjHwuRgHWsDjqo73J1ZdCZdK6b7JaMvM/+wJ2OJUzszt7Uj7yssW+BXVrkJcwe0NL6WnkHNUCwVVt+MIMyAOJsU67Z24LDopZfUikpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8Sn3qVr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a110548cdeso33504335ad.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 09:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767979696; x=1768584496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdjWJgY6iOVDBFOeMFAelJSLp8i7SGkjRgyLUhxHEnQ=;
        b=L8Sn3qVrWdGJtv4b6gFcsulQGa99Bfn4x/jvTHJgHEuxzeI2t4+lusJps0FmdTG/b5
         3IAsEMs+FIOFRPaBgTcvyqpUZabbUcfTEjh80Wxrli+gyHXNQLRX4x16SNlbZkiET9nh
         PsgpSoBSSaEAg9IrZxHYThJHTiwBjk30/OdB9y7plW5G9C7Mo8KroyfMfLAi7EDGrOIv
         RgL4ISLI6DDjuW441m1OYjtYyQQZmqjTTf8zXKXcPC2I4arsC7Za6QgQGw9NPdGv7ibv
         Ie7EsLDbtY8l24iOsUANgsPWLgSHnW3Cufe8VjSgLxwtwPsLMUECdGvZhsmvgt26uf8x
         C09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767979696; x=1768584496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FdjWJgY6iOVDBFOeMFAelJSLp8i7SGkjRgyLUhxHEnQ=;
        b=TZJhIT1Sc9u38H04Gylon/pj8tpI+3/uoPUm/1uqkTehQju6wHz3d2s7dxqeJTbUtt
         G9jI7vtxjNpsF4ltoxEQ/cDLWH9ixyLXFikWj0OeWpreNqTzmv+Ui6kX7eJv6x7nYrKI
         GE67dvk+EKOAsCwslsv0vyw9l9sYl1IBVPKXtBkXz8g8915zICKbaQhxPO3nhIA8vA6v
         rI1fozNmewALCMkKWu4R5QesYKv2LFOnwsaCHE0smWrwKY89YXv2WWtPvT79m9EWsl7O
         1zxnlt4gvf7fgz2ZfjVLzNxJ+6R5JcEquntycNCyil1+wl3vOq20cPx81/43UyRXUKzY
         FmlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVysnHZXoVaJwDgVx7P6qSyUsUNui+RvKyFOa2I7QebFsxsDVhKglsEOyV8UsWPHjp0Rmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+j7iUGWleQHE0N7hmgd1qs7Q5EeAZyCVEThwKrjDWamxkpBwR
	wBsroQk15gBsh1/gJDr/Fur8hR4D9bu3ZyrPvohbpXfQf5JxY9bZaj6MUCNc4Bv4xMkZA06EmRG
	F4leCLpjXjuqYFJOBvLJDBtDLCqIpYJI=
X-Gm-Gg: AY/fxX77FmymmWp1r47+dW0ci7Z7sf6433RqCnOQFRcIES80WvWl1PIM0BZiFsqqmuk
	L4W0LXdOwKakw54YfvCWntnsyvY/y3gujaDD71gKk/XmrfbF/YlJmRWMiZjcv0oH3UNIvf7FI9/
	4bPcVkJ4yR3T3zBlKSFOtGx2kZVArZ4ZmE/0nrapSU6hR1AQDG5WoTQAfNWACvg4553ciPpb1Zj
	rfvxddQ+g4i3E6ulTmtUzW98zEmQLAXcUlPAzqk4ZVB/zX9r2FJKzQTPy+GPw0gyf7bWCshsd0y
	1QWWSlhY
X-Google-Smtp-Source: AGHT+IEhn4rNF8qnL/Tfa4q5sugvVRa6tKpP0whDELH4iHxymFGyJGAbpLqtLnkNNW6CjVQw4dN21auzmLEVKbdfYfQ=
X-Received: by 2002:a17:903:354b:b0:2a0:ccee:b35a with SMTP id
 d9443c01a7336-2a3ee4da855mr94193945ad.46.1767979695574; Fri, 09 Jan 2026
 09:28:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109101325.47721-1-alan.maguire@oracle.com>
In-Reply-To: <20260109101325.47721-1-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 09:28:03 -0800
X-Gm-Features: AQt7F2rQmIY4BXYYMdNuIEEAqsJdQ7nRmThF4SQt6WxdzZrFFcIEN_1jH5svZJk
Message-ID: <CAEf4Bzaysi-ji0Q2m=6Fc0YTPnrKVOPDNoQW9Y6rB03R4Pe3aw@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: BTF dedup should ignore modifiers in type
 equivalence checks
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, nilay@linux.ibm.com, 
	bvanassche@acm.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 2:14=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> We see identical type problems in [1] as a result of an occasionally
> applied volatile modifier to kernel data structures. Such things can
> result from different header include patterns, explicit Makefile
> rules etc.  As a result consider types with modifiers const, volatile
> and restrict as equivalent for dedup equivalence testing purposes.
>
> Type tag is excluded from modifier equivalence as it would be possible
> we would end up with the type without the type tag annotations in the
> final BTF, which could potentially lead to information loss.

Hold on... I'm not a fan of just randomly ignoring modifiers in BTF
dedup. If we think volatile is not important, let pahole just drop it.
I think BTF dedup itself shouldn't be randomly ignoring information
like this.

Better yet, of course, is to fix kernel headers to not have mismatched
type definitions, no?

pw-bot: cr

>
> [1] https://lore.kernel.org/bpf/42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linu=
x.ibm.com/
>
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index b136572e889a..89fbeed948a8 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4677,12 +4677,10 @@ static int btf_dedup_is_equiv(struct btf_dedup *d=
, __u32 cand_id,
>         cand_kind =3D btf_kind(cand_type);
>         canon_kind =3D btf_kind(canon_type);
>
> -       if (cand_type->name_off !=3D canon_type->name_off)
> -               return 0;
> -
>         /* FWD <--> STRUCT/UNION equivalence check, if enabled */
> -       if ((cand_kind =3D=3D BTF_KIND_FWD || canon_kind =3D=3D BTF_KIND_=
FWD)
> -           && cand_kind !=3D canon_kind) {
> +       if ((cand_kind =3D=3D BTF_KIND_FWD || canon_kind =3D=3D BTF_KIND_=
FWD) &&
> +           cand_type->name_off =3D=3D canon_type->name_off &&
> +           cand_kind !=3D canon_kind) {
>                 __u16 real_kind;
>                 __u16 fwd_kind;
>
> @@ -4699,7 +4697,24 @@ static int btf_dedup_is_equiv(struct btf_dedup *d,=
 __u32 cand_id,
>                 return fwd_kind =3D=3D real_kind;
>         }
>
> -       if (cand_kind !=3D canon_kind)
> +       /*
> +        * Types are considered equivalent if modifiers (const, volatile,
> +        * restrict) are present for one but not the other.
> +        */
> +       if (cand_kind !=3D canon_kind) {
> +               __u32 next_cand_id =3D cand_id;
> +               __u32 next_canon_id =3D canon_id;
> +
> +               if (btf_is_mod(cand_type) && !btf_is_type_tag(cand_type))
> +                       next_cand_id =3D cand_type->type;
> +               if (btf_is_mod(canon_type) && !btf_is_type_tag(canon_type=
))
> +                       next_canon_id =3D canon_type->type;
> +               if (cand_id =3D=3D next_cand_id && canon_id =3D=3D next_c=
anon_id)
> +                       return 0;
> +               return btf_dedup_is_equiv(d, next_cand_id, next_canon_id)=
;
> +       }
> +
> +       if (cand_type->name_off !=3D canon_type->name_off)
>                 return 0;
>
>         switch (cand_kind) {
> --
> 2.39.3
>

