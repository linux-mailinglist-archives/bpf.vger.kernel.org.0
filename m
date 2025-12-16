Return-Path: <bpf+bounces-76758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 298EFCC5085
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 20:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 023D1303E64E
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B1B2DE6F5;
	Tue, 16 Dec 2025 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6EBGOze"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB532BDC0A
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765914380; cv=none; b=cAqbgn5oh1NCf6oo5TfFvFif/eiRPlcDL2t2nylTrVHx4qUlSotcZiWbu4PDFN9oU4ofe30zYjO5s2Q/2x1xV0WLb17l2TPwDcW/qbEmQGg6de1Pj6cFGNE3D8tKjmNtkE49aJpB/Bxnl9TmEesIVpGTcFTjLLjOr6FBPSslwGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765914380; c=relaxed/simple;
	bh=2DhK7VWHNasBJnXaYJO4w1VHQVWDIEhVzB1wuzV722I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KscP2CUpGZkBz96tTcJ3DbcOll0Fe0c7PQCb4T7E4JpJakSaeReJ/fdZNlFteV749xm9aY0DaXCXb8xw6dsYxaJUq0njM0nTNn6a4/WZ56LIKU70+sWsM3muOoi8Y02ppDYlZ9Xt2jIWBhC/WETrtktQ0woNdY2YYGQwkx9Fx08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6EBGOze; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso5548190b3a.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 11:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765914378; x=1766519178; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xf3GHtjFosXjKL7eyP1rgq8NoLv2LiUK+3cMjNVka+Q=;
        b=k6EBGOzeVwrXiw2/YJoacRL7LZdOYElgX9JKqEE/XYMm1aDAiKJJoL+a74sA8m8OP4
         sPemNiahFuySBKEOeuqUncUiCE7CYASG8vT/j0FQhB3jGYf0usgzjWhvbbhdyFbKzFXl
         AtVpatSHVmunT63p1x23tNvQ8e6qqyJK92OJxurHGNpZDKol+lix65yz3JettMC2TE+S
         sSgsQEEYCbSG3LmXZUYKhua38ojJDcJS3pmcYbmJt62gxvhQA6bAdH00FQ3QDm3xKvfs
         BKLFEfooW4Gkr8qtaE2ywTZ9K8DpmAhM67EpSbbe+Mkw6sSe/oNM5LbjcHMQ3V3rUipb
         rXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765914378; x=1766519178;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xf3GHtjFosXjKL7eyP1rgq8NoLv2LiUK+3cMjNVka+Q=;
        b=dW75TtRfBaQgvGsJt5ISi/Wlfkqv4qDDo94jgN0RAr2rIpGdEr2omsMx7gRWgmkdhU
         JGiPBf6DP2hjirz+WwmwYL8LXOKmH66n1pxIMMk+Gqx2FnGW8ztJqE/dHX0X+1NQntj3
         FyXTYCpxFYg9Wumn79miphKsiG45ms5YQHMh4cW4TWMtM9S5sVXkF+99ahMC8amwvUo1
         Jp37wYNBDYIKyCjZyaGBWzlG5cS3AdssTzAgsFyKlCrYvR6pZiEoMhVR3UskRV6M8cFe
         9eICUppdsxhKHqNcip6FMfAed2QPTThuFkHtb381TNm8YGZYm/kp5SYTuaD2RF1ptwEK
         rmNA==
X-Forwarded-Encrypted: i=1; AJvYcCVIa5rKxflMHkBUFj4ZTilGQ3eoK72giwaANVTCQwatXlkzNPfdaGrIFgDJhsY37g9MM7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoUwqsVKOnN/q1V6m2LKgl3UkmtjdPEswQsOaj0e6idwt2CcfH
	UGlZyusCzQ634/KChj3T8a/3HhUSuw6BOASK88Zex2eur58AhyKuD5Jj
X-Gm-Gg: AY/fxX7Mc4HPHH+gO1VZiEmtlPhkka5mfuCW8GtE1Jck0RRiIZgB6oqngKqGfkvtzZy
	h6tJ/kBlttuMzboRBkE3Ikwr3fvIow4ZqwR/fxOHQ9GwAMzGl21bn5Zp9ZtLOylYebW8d5mkxkZ
	QAMReQ+/Raf9/Gv4RC+SCP4Yhe3QeuaaMkSc4RcnMHn2G38NmnpFYa09lEXcpbwfIGmmAiotWSt
	M6Ve2whoEaInu7Zmffqr8mpm1+9CS+Sa3YDlrvVrWnBf3UWowCxtz8u2FLtMCBAfc51tWYa+leD
	KD9vdAJjaPtwY/je5CZagIDtBr/92v9f8vrHzpixMqU7kXz/cbmhKEREn7+1DhuwXnlB1pGf/qu
	Qv5s768KaL63on4yV7zNEkLzNdhG9jWXpQEeJ/UIPXKllT51LwrDmkIlOmJX60XpoPk8e6Lpzbp
	rhKAfP0g/t
X-Google-Smtp-Source: AGHT+IFCJbLrEtCHhanEI1+ZwlGHuGmV1EaBGzFRHO1vOifIwId/qsnjHX4RjQc7NcI3w0gWiW2tSw==
X-Received: by 2002:a05:6a20:a121:b0:366:5d1a:c735 with SMTP id adf61e73a8af0-369afef6ecdmr18983386637.57.1765914378456;
        Tue, 16 Dec 2025 11:46:18 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34ce3ee7e94sm774980a91.0.2025.12.16.11.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 11:46:18 -0800 (PST)
Message-ID: <9a096b2a16d552031a12f3f4f5a2c725212df5e6.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize
 nested structs for BTF dump
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, qmo@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	bpf@vger.kernel.org
Date: Tue, 16 Dec 2025 11:46:15 -0800
In-Reply-To: <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
		 <20251216171854.2291424-2-alan.maguire@oracle.com>
	 <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 11:00 -0800, Eduard Zingerman wrote:
> On Tue, 2025-12-16 at 17:18 +0000, Alan Maguire wrote:
>
> [...]
>
> > @@ -1460,10 +1466,16 @@ static void btf_dump_emit_type_chain(struct btf=
_dump *d,
> >  		case BTF_KIND_UNION:
> >  			btf_dump_emit_mods(d, decls);
> >  			/* inline anonymous struct/union */
> > -			if (t->name_off =3D=3D 0 && !d->skip_anon_defs)
> > +			if (t->name_off =3D=3D 0 && !d->skip_anon_defs) {
> >  				btf_dump_emit_struct_def(d, id, t, lvl);
> > -			else
> > +			} else if (decls->cnt =3D=3D 0 && !fname[0] && d->force_anon_struct=
_members) {
> > +				/* anonymize nested struct and emit it */
> > +				btf_dump_set_anon_type(d, id, true);
> > +				btf_dump_emit_struct_def(d, id, t, lvl);
> > +				btf_dump_set_anon_type(d, id, false);
>
>
> Hi Alan,
>
> I think this is a solid idea.
>
> It seems to me that with current implementation there would be a
> trouble in the following scenario:
>
>   struct foo { struct foo *ptr; };
>   struct bar {
>     struct foo;
>   }
>
> Because state for 'foo' will be anonymize =3D=3D true at the moment when
> 'ptr' field is printed.
>
> Maybe pass a direct parameter to btf_dump_emit_struct_def()?

Digging a bit more into this, here are a couple of weird examples:

  $ cat ~/tmp/ms-ext-test.c
  struct foo {
    struct foo *ptr;
  };

  struct bar {
    struct foo;
  };

  struct bar root;
  $ gcc -g -c -o ~/tmp/ms-ext-test.o ~/tmp/ms-ext-test.c
  $ pahole -J ~/tmp/ms-ext-test.o
  $ bpftool btf dump file ~/tmp/ms-ext-test.o format c
  #ifndef __VMLINUX_H__
  #define __VMLINUX_H__

  #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
  #pragma clang attribute push (__attribute__((preserve_access_index)), app=
ly_to =3D record)
  #endif

  #ifndef __ksym
  #define __ksym __attribute__((section(".ksyms")))
  #endif

  #ifndef __weak
  #define __weak __attribute__((weak))
  #endif

  #ifndef __bpf_fastcall
  #if __has_attribute(bpf_fastcall)
  #define __bpf_fastcall __attribute__((bpf_fastcall))
  #else
  #define __bpf_fastcall
  #endif
  #endif

  struct foo {
  	struct foo *ptr;
  };


  /* BPF kfuncs */
  #ifndef BPF_NO_KFUNC_PROTOTYPES
  #endif

  #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
  #pragma clang attribute pop
  #endif

  #endif /* __VMLINUX_H__ */


  $ cat ~/tmp/ms-ext-test.c
  struct foo {
    struct foo *ptr;
  };

  struct bar {
    struct foo;
    int a;
  };

  struct bar root;
  $ cgcc -fms-extensions -g -c -o ~/tmp/ms-ext-test.o ~/tmp/ms-ext-test.c
  $ pahole -J ~/tmp/ms-ext-test.o
  $ tools/bpf/bpftool/bpftool btf dump file ~/tmp/ms-ext-test.o format c
  #ifndef __VMLINUX_H__
  #define __VMLINUX_H__

  #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
  #pragma clang attribute push (__attribute__((preserve_access_index)), app=
ly_to =3D record)
  #endif

  #ifndef __ksym
  #define __ksym __attribute__((section(".ksyms")))
  #endif

  #ifndef __weak
  #define __weak __attribute__((weak))
  #endif

  #ifndef __bpf_fastcall
  #if __has_attribute(bpf_fastcall)
  #define __bpf_fastcall __attribute__((bpf_fastcall))
  #else
  #define __bpf_fastcall
  #endif
  #endif

  struct foo {
  	struct foo *ptr;
  };

  struct bar {
  	struct  {
  		struct  *ptr;
  	};
  	int a;
  };


  /* BPF kfuncs */
  #ifndef BPF_NO_KFUNC_PROTOTYPES
  #endif

  #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
  #pragma clang attribute pop
  #endif

  #endif /* __VMLINUX_H__ */

