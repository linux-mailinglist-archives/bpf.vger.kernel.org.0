Return-Path: <bpf+bounces-33114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9E0917527
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 02:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62ED82828C9
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 00:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710711FDD;
	Wed, 26 Jun 2024 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+1H9BWX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45413ECF;
	Wed, 26 Jun 2024 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719360607; cv=none; b=YT+bLDJWyc+2QpprzJOvRSH4oJJhdluACs0MKjphQNBJIZL3mAtCPuXuKIa64TRuNKPNj5wACSZLeBfUlDHdxVWzQeNGXFVkvWWRuL2u+db/2F0mS0fAqFm/NMZpmt7vZiIzp/bWEFB/2h5TNjpS6xIvgecY8h2PtFZ4fEdrSHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719360607; c=relaxed/simple;
	bh=eMP7ajudHCsPyheG4Qo/nMSLT1xHzQ/d07X6OupHdiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0d3huiL1l9mwn2Veimp5MIBOuiiAS7smYp6mZ22NfqW1m9YhifpegZsjsP3gy/nzWXn9xvk76bk7dgolTs/pVVaJHduWDhVJJdcGXeuyPUrEBGxnj/5zDmf8YsAe1pO58kwNetQ+N8yBIyFH+Jtj0LV/zNfFMyc3DV1Yugw4tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+1H9BWX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so48354865e9.3;
        Tue, 25 Jun 2024 17:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719360604; x=1719965404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70Qo4AC1Wx3NmR5z9LHdHSZsllOrp34iipiSSOQGlk4=;
        b=j+1H9BWXgR8kSfzbacA4C7e4/qbjPWj03b7Y+ECJYL8Cr5YeHui9qAOa7Qhpnsl7mJ
         i5hOAMAEhzw8Fa5aEtUd+JL+1Q6qr2xw74X7AjIMvrveRMO3cVeOujDLC29zMLqjlvOg
         5BiH+moGps2gRZne03k103MhBWKvvOw3BYhbf2RmKYFLZCIqOAvi5SHoQZZibWSC+7ZX
         082MC7l5vf0uAmOo+HC+PhMaIMyAsL7DczTvcSQI1JQzbj1VwJkQejEQFLpZh8psIy3l
         JDjx/FYAm5mY43ZG/RY8dHcXhQf8WlhQ46d/xVeW2MhAb0yyKw+6tyZDhOS5SCh4bMWP
         KL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719360604; x=1719965404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70Qo4AC1Wx3NmR5z9LHdHSZsllOrp34iipiSSOQGlk4=;
        b=KiYapvKcTr0jlxtbykY8zvDUm4l46c8RHU+X5s5dVH/jbA/+v1FCfWWboqaZxMlPGd
         S9PP5FeF35Z25Oa/4aIkTCDiH7u6G30fI4EpbG+P5/AM+qr7xVDDr2ttA9NlrWhwMunr
         QRTaUzp3ubvzvI2l88Rq6vIikJsIIlpdep6qB6x+/VzL13KBZFFeu5VjiKpGJh9oqWPc
         gWic2k7+exEjr1EPtmxNEXz+6BLrpVAIQ7E9BoTxnvNy+6KW3RX0e/jSZf6yBsYohNNj
         ugG+g5l8UxmhogDJjLTy6mAl6hs/Xzb1M6qnm4jesPQVob3pF1h8kC7ci6MbuL2FgohE
         ISKw==
X-Forwarded-Encrypted: i=1; AJvYcCVffnkd0Lk2Z8aV2vrEFx/B57ECw1hyiV6Vod/SZvd/zgq0zqSG4z9o1fWtemWwW83W4Xi2ZKImc7BAG4EIRvpWXXVYbS4SJFH3IrwMC12mGTAWG4WWIHDTiw/TRZWpe5kYX1ZfXSKntl1QSQPNMcit/gEiOY3H2cCKrBfYdf6M44Wlriv9
X-Gm-Message-State: AOJu0Yy5Q68skhdAzgR5LKHlWfo2Qs70SC8kXOorB/YpMSI8/NeuZq/V
	QQbW7vJAAU0m2I5hgyDZS+KJ51KZxFM2MCvIRTq6zs8LOZVCwBhCqjWGnZF5OwhdyW2Cr+FTyJ2
	DiEk4KfpzYanCCZNrpGlvAZ8Goko=
X-Google-Smtp-Source: AGHT+IFWLUbVpqwaaUyJdbH/87MDrL2D2z+K+4xkyJZCgbDOIii+IOiczl+nXjDUbOF1TwDE/GGjwf1QQrJRB2hwjIc=
X-Received: by 2002:a05:600c:5699:b0:423:b672:9d64 with SMTP id
 5b1f17b1804b1-4248b980068mr75995775e9.18.1719360603411; Tue, 25 Jun 2024
 17:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620-fault-injection-statickeys-v2-0-e23947d3d84b@suse.cz> <20240620-fault-injection-statickeys-v2-4-e23947d3d84b@suse.cz>
In-Reply-To: <20240620-fault-injection-statickeys-v2-4-e23947d3d84b@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Jun 2024 17:09:52 -0700
Message-ID: <CAADnVQ+4YghLdZ7X-PSUyUvGc2RreFHgTLS-J7hBZm3WTEMEjg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] bpf: support error injection static keys for
 multi_link attached progs
To: Vlastimil Babka <vbabka@suse.cz>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mark Rutland <mark.rutland@arm.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 3:49=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Functions marked for error injection can have an associated static key
> that guards the callsite(s) to avoid overhead of calling an empty
> function when no error injection is in progress.
>
> Outside of the error injection framework itself, bpf programs can be
> atteched to kprobes and override results of error-injectable functions.
> To make sure these functions are actually called, attaching such bpf
> programs should control the static key accordingly.
>
> Therefore, add an array of static keys to struct bpf_kprobe_multi_link
> and fill it in addrs_check_error_injection_list() for programs with
> kprobe_override enabled, using get_injection_key() instead of
> within_error_injection_list(). Introduce bpf_kprobe_ei_keys_control() to
> control the static keys and call the control function when doing
> multi_link_attach and release.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  kernel/trace/bpf_trace.c | 59 ++++++++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 53 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 944de1c41209..ef0fadb76bfa 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2613,6 +2613,7 @@ struct bpf_kprobe_multi_link {
>         struct bpf_link link;
>         struct fprobe fp;
>         unsigned long *addrs;
> +       struct static_key **ei_keys;
>         u64 *cookies;
>         u32 cnt;
>         u32 mods_cnt;
> @@ -2687,11 +2688,30 @@ static void free_user_syms(struct user_syms *us)
>         kvfree(us->buf);
>  }
>
> +static void bpf_kprobe_ei_keys_control(struct bpf_kprobe_multi_link *lin=
k, bool enable)
> +{
> +       u32 i;
> +
> +       for (i =3D 0; i < link->cnt; i++) {
> +               if (!link->ei_keys[i])
> +                       break;
> +
> +               if (enable)
> +                       static_key_slow_inc(link->ei_keys[i]);
> +               else
> +                       static_key_slow_dec(link->ei_keys[i]);
> +       }
> +}
> +
>  static void bpf_kprobe_multi_link_release(struct bpf_link *link)
>  {
>         struct bpf_kprobe_multi_link *kmulti_link;
>
>         kmulti_link =3D container_of(link, struct bpf_kprobe_multi_link, =
link);
> +
> +       if (kmulti_link->ei_keys)
> +               bpf_kprobe_ei_keys_control(kmulti_link, false);
> +
>         unregister_fprobe(&kmulti_link->fp);
>         kprobe_multi_put_modules(kmulti_link->mods, kmulti_link->mods_cnt=
);
>  }
> @@ -2703,6 +2723,7 @@ static void bpf_kprobe_multi_link_dealloc(struct bp=
f_link *link)
>         kmulti_link =3D container_of(link, struct bpf_kprobe_multi_link, =
link);
>         kvfree(kmulti_link->addrs);
>         kvfree(kmulti_link->cookies);
> +       kvfree(kmulti_link->ei_keys);
>         kfree(kmulti_link->mods);
>         kfree(kmulti_link);
>  }
> @@ -2985,13 +3006,19 @@ static int get_modules_for_addrs(struct module **=
*mods, unsigned long *addrs, u3
>         return arr.mods_cnt;
>  }
>
> -static int addrs_check_error_injection_list(unsigned long *addrs, u32 cn=
t)
> +static int addrs_check_error_injection_list(unsigned long *addrs, struct=
 static_key **ei_keys,
> +                                           u32 cnt)
>  {
> -       u32 i;
> +       struct static_key *ei_key;
> +       u32 i, j =3D 0;
>
>         for (i =3D 0; i < cnt; i++) {
> -               if (!within_error_injection_list(addrs[i]))
> +               ei_key =3D get_injection_key(addrs[i]);
> +               if (IS_ERR(ei_key))
>                         return -EINVAL;
> +
> +               if (ei_key)
> +                       ei_keys[j++] =3D ei_key;
>         }
>         return 0;
>  }
> @@ -3000,6 +3027,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>  {
>         struct bpf_kprobe_multi_link *link =3D NULL;
>         struct bpf_link_primer link_primer;
> +       struct static_key **ei_keys =3D NULL;
>         void __user *ucookies;
>         unsigned long *addrs;
>         u32 flags, cnt, size;
> @@ -3075,9 +3103,24 @@ int bpf_kprobe_multi_link_attach(const union bpf_a=
ttr *attr, struct bpf_prog *pr
>                         goto error;
>         }
>
> -       if (prog->kprobe_override && addrs_check_error_injection_list(add=
rs, cnt)) {
> -               err =3D -EINVAL;
> -               goto error;
> +       if (prog->kprobe_override) {
> +               ei_keys =3D kvcalloc(cnt, sizeof(*ei_keys), GFP_KERNEL);

cnt can be huge. Like tens of thousands.
while number of keys is tiny. two so far?
So most of the array will be wasted.

Jiri, Andrii,

please take a look as well.

> +               if (!ei_keys) {
> +                       err =3D -ENOMEM;
> +                       goto error;
> +               }
> +
> +               if (addrs_check_error_injection_list(addrs, ei_keys, cnt)=
) {
> +                       err =3D -EINVAL;
> +                       goto error;
> +               }
> +
> +               if (ei_keys[0]) {
> +                       link->ei_keys =3D ei_keys;
> +               } else {
> +                       kvfree(ei_keys);
> +                       ei_keys =3D NULL;
> +               }
>         }
>
>         link =3D kzalloc(sizeof(*link), GFP_KERNEL);
> @@ -3132,10 +3175,14 @@ int bpf_kprobe_multi_link_attach(const union bpf_=
attr *attr, struct bpf_prog *pr
>                 return err;
>         }
>
> +       if (link->ei_keys)
> +               bpf_kprobe_ei_keys_control(link, true);
> +
>         return bpf_link_settle(&link_primer);
>
>  error:
>         kfree(link);
> +       kvfree(ei_keys);
>         kvfree(addrs);
>         kvfree(cookies);
>         return err;
>
> --
> 2.45.2
>

