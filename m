Return-Path: <bpf+bounces-62444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5074BAF9BC7
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 22:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB2887B765F
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5F617A319;
	Fri,  4 Jul 2025 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsgoOnDY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFFD2CA6
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751662082; cv=none; b=iZK5GOibb4YMGtEWbu1/YcbiKCDgKtF62Ow8f2e82awn/FmjZNbHpmmoh2ei6dPmlagXOoI7IzmlRYxMnoHyX/2/e2sybEUACVIcbFl74l8WEh4bDByoe2bBeCOht55+v9k3w+FzDz1m0UcLX6TgGixGmcj2k6vOw7q25SnGO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751662082; c=relaxed/simple;
	bh=ewuiFcBmWXTMLF/zs2+svcm83Ska7yDYUByzzE7m0xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtrRIcPxrkIK6fdBTwZRP0DZA3naeoGqrVVqkZZJ3AsCXSrfQIU9nxJNclYcJxsFNiYZzJ41y4Q+qwEY6vo75Ibqk2UUYMc7JZK+is2W6XpEOJ6wx1656BZRexEflJEelwvjrifT6BHuxsUXv2qg/q5oubWMcbYGihzyimc6awQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsgoOnDY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so13994215e9.1
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751662079; x=1752266879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fS/Ah+mbwEZ7CdZP6O6y6Vizv+YqyGMP4Ylm+Fhopho=;
        b=JsgoOnDYpayQnf1nDG/0HMzMcFGKM7qZQs2Fu6GOqTOIrslBAOMWQ2JygffTtRrXlK
         Qvnrn8rycCwFaho9IDirsSw0J+c72nQxRIpV7CsjOeJhYrCGoejO45P8e5QWs7CURPmr
         8OxUpd/5ixHQ0iduN5TYLtuyOifAgtYBY/7VRZHqnJ6SJSdB96H31apTiKBu0DSay8cg
         ADC6uaC9Y6oMnwxDfinnDnrWF1Y+IXyma7qSaR4xjUIkT5dAAvDWePs7xPT6qp2nqGgs
         kGnIZcRjxtrKp9Ja4F0BtZecfhMHGWAfEx/EtmCZ9kcphjOuDzawmffGtK/KFOfNu14N
         uPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751662079; x=1752266879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fS/Ah+mbwEZ7CdZP6O6y6Vizv+YqyGMP4Ylm+Fhopho=;
        b=AzJFG3ZvQ2M64fTcKzUXjUeIKNxGvfYQWWTfSI/6RVHrmdUKTkweJ1cHFKOpsJKNea
         7/3Yycn3c/GJnJJo6I8PCZa6ILkhWwCaPurWG8MhICzyXG8/wNShgUEvn6dezIv23hSU
         azzWjMwHpPZhS484l17V7fNUkZPyRbugn/q3LihuGTAyvuigSoR6fcfCnuhdJMI1BHg2
         UVO2U/zWl3psY3/M1zWcdo+wBtB1kIcFQNM/GyyzbHTJ3QwuQgSkrk/uyhLBxOnD2H0v
         570yaMEHptQgiYm32AS79m747zq2aWmEQww8j1EGHAUj0FeVtxdhb7RTfSHr03DnTZDU
         32kA==
X-Forwarded-Encrypted: i=1; AJvYcCVNfvIVV0PADLEReRArhu2esWQ0HsjkIUQ20R53cSTTs8yQw0KKIQBZZNzAMhUKHpdLSO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3iPDjDaIsQNCNakF4QrZdINX/vMbBvexzO1Gw18wEeAARUnbX
	7VT+GMI9FfsR+8zvt9MKGibYsrzDRjerE75y7ttQw/uX9M8phSA1liGzVn23eXMKFBWRchP8Nx0
	fHU9fyPhFsvf/yopK/GaznyI/ot+DJZk=
X-Gm-Gg: ASbGncv317XSnGk5Ud6mJsTwby8KSk3Vy4w8F8YER9RhA3CeEfFsz7HxbjfHSG+iYKM
	K2PI0jbzHnGzIt2b/6MqTeq8zGwuzy+xjudtZTBR1SN4fj7VQUVl4Tl58ZTPSFIIbl5zKOyXJLi
	qvulzUxg8xinYfg0B9sBXYMQb0C0KzKL+2IP2djyYT+/R21ONLgURDHLw95Jd2lqTtE8RGDeJv+
	/Y5cNHte7c=
X-Google-Smtp-Source: AGHT+IGxPnK6ofvk8uoxokjuMjqUWFXOOpoGf9mDM685YhV5AC4BZAmdg1kEwqisml5kHQ/vKS/1zDC4W6EgYEAFcAs=
X-Received: by 2002:a05:6000:2dc1:b0:3a5:300d:ead0 with SMTP id
 ffacd0b85a97d-3b497038f2emr3050220f8f.43.1751662078569; Fri, 04 Jul 2025
 13:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702224209.3300396-1-eddyz87@gmail.com> <20250702224209.3300396-5-eddyz87@gmail.com>
 <CAP01T74AYNX5ARJ5YXryUyKvn5o0Dv0JBoq3CCKcD8rh==uKQA@mail.gmail.com>
 <fb5b8613584dbce72359e44ef3974e4cb7c8298e.camel@gmail.com>
 <de7f3a2c5bc521c1111b0ed1870291c0889e4757.camel@gmail.com>
 <CAP01T75+cXUv4Je+bYQNb-Us_MF1s1Zc9fL0wmowLExKUQ8KNg@mail.gmail.com>
 <a8f522a0e9eaf060727b7782d700f998efaa757c.camel@gmail.com>
 <CAP01T74_diwrEB0D=LOqVGQTGjiETm65cqh3zZEL5S5EkTYaZQ@mail.gmail.com>
 <e5acf74c70f6aa01ca7be4c0afce9dd6a20a910e.camel@gmail.com>
 <CAADnVQKh9pAaAcJp_bSFjz5=K-6XPgb_Jdo8yhv3VYQhb-6=xA@mail.gmail.com>
 <CAP01T76tXJVMk_Yy1USRNity5rA=DXe9BgS7OOa0G960UsVPcg@mail.gmail.com> <f61674e3d16bee41b35acaac70285f673259d023.camel@gmail.com>
In-Reply-To: <f61674e3d16bee41b35acaac70285f673259d023.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 4 Jul 2025 13:47:47 -0700
X-Gm-Features: Ac12FXxOdWNbvvvAynEQG1Y0wwqkfpv7ev_mrUVw5tDiJqA0s4p0lhPlmOnIQzI
Message-ID: <CAADnVQLDO8zBjMuS=7REBhAxKm9Gn9qaMBdODf_qrTQvcOeTvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: attribute __arg_untrusted for global
 function parameters
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 1:34=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2025-07-04 at 22:20 +0200, Kumar Kartikeya Dwivedi wrote:
> > On Fri, 4 Jul 2025 at 22:06, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Jul 4, 2025 at 12:23=E2=80=AFPM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >
> > > > On Fri, 2025-07-04 at 21:15 +0200, Kumar Kartikeya Dwivedi wrote:
> > > >
> > > > [...]
> > > >
> > > > > Yeah, so if the user specifies a type and has co-re enabled, they=
're
> > > > > accessing a kernel struct.
> > > > > If they're doing it without co-re, it's broken today already, or =
they
> > > > > know the struct is fixed in layout somehow so it's ok.
> > > > > If not, they want to access things at fixed offsets. So we can ju=
st
> > > > > use the type they're using to model untrusted derefs.
> > > > >
> > > > > So always using prog BTF makes sense to me.
> > > >
> > > > Ok, I'm switching to always using prog BTF.
> > >
> > > Hold on. The concept of ptr_to_btf_id|untrusted that points to
> > > prog type doesn't exist today. We should be careful when introducing
> > > such things.
> > > I prefer to keep btf_get_ptr_to_btf_id() in this patch
> > > and think through untrusted|ptr_to prog type later,
> > > since the use case of untrusted local type doesn't quite resonate wit=
h me.
> >
> > Yeah, we can add it separately from this set, but otherwise I don't
> > see the problem with the idea.
> > There is no reason to restrict ourselves to kernel types.

The reason not to do it is to avoid cornering ourselves.
Like, we defined byte access to 'char *' in a global func too soon.
I didn't like the idea, but didn't have better alternative, and
now we cannot extend it to an array of chars or any other semantics.

> > All accesses will be untrusted, it's like probe_read so it should be
> > well-formed for any type.
> > It's the same reason why pointers to non-struct makes sense. Ideally
> > any type should be allowed.
> >
> > Otherwise to reconstruct a walk of untrusted pointer chains the user
> > will do it by hand.
> > Showing the structure types to the verifier allows it to be inserted
> > automatically.
>
> I agree with Kumar, it's an expansion of the idea behind
> bpf_rdonly_cast(...,0). Having some untrusted pointer source
> (e.g. value from a program stack trace) one can already write:
>
>   struct foo {
>     struct bar *bar;
>   };
>
>   struct foo *foo =3D bpf_rdonly_cast(magic_value, 0);
>   struct bar *bar =3D bpf_rdonly_cast(foo->bar, 0);
>
> We can make it more convenient by introducing an additional kfunc:
>
>   struct foo {
>     struct bar *bar;
>   };
>
>   struct foo *foo =3D bpf_rdonly_cast_local(magic_value, bpf_core_type_id=
_local(struct foo));
>   ... just use foo->bar ...

Such usage only makes sense for kernel types.
If 'struct foo' is prog type then passing it to a global
function to do probe_mem style access doesn't make sense to me.
If it's prog type it's either used in arena or with bpf_obj_new.
I don't see a case whether the prog needs to probe_read
its own objects.

> As for global function parameters. Discussed this with Kumar off-list
> a bit. There are types with generic names in vmlinux.h, like "region",
> "regex", "hash", "key". So, imo, the above bpf_rdonly_cast_local()
> should be accompanied by its own tag: __arg_untrusted_local.

I still don't see a value in bpf_rdonly_cast_local.
struct foo example looks artificial.

