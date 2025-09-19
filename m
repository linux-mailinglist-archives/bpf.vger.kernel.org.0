Return-Path: <bpf+bounces-68879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 600E7B8796D
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 03:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A3D1CC0EE8
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 01:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ED621FF26;
	Fri, 19 Sep 2025 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+tiq5CT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D713189
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 01:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758245194; cv=none; b=G5eio9bURq7rZ1Ns4gWgpXu2kt8dDL9Dr2Cl81bXdwhswj2jiAtSAAsy1ow+9/id0+UYp6rqkbvG5CDxjAOedCYVN8+KULt32455cFYaHkUbqAUNbJusBZKGZkeT/D4LpBm7i754ZPg9UCgfTpQoGMFHFjCVGNsJF/2/tc3OGwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758245194; c=relaxed/simple;
	bh=ZsHCRhTumv1lyX2Ar5c6vxInDBzmrXReNDq698rPss8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBq62wsBiO5i82Ds5IvA9BlZp2VVEQeIhhGA/EOvuhcFRCpTFj8m2OZc6CSscDNRoce6w/uX3nZPi1qbEvrAeLsjub/PMVuqd92ZZBOpfq2tAs+KwYot3ACYYMZTX/M0FPcYIRXaNLG2TUhJPL5HzYwRPYP8OgE2dY7v8Wl3nJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+tiq5CT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758245191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBqT4GDWcNMH7b8efKieP9YpFeoByi0GaQLbR+k6Z54=;
	b=B+tiq5CTuyQ3BZMN6AMNmdZaydAmVAPbRd49W6B+CYADOsFtBNZ5j79Hy6vETbrmTXLUkp
	OMIQ1jetYAf/Q10WtXKxxFVSW4NWOimEsJhWmYf+0U+ay9r3yD+/Giyrb6RO2rBC3mwPJg
	tsLpEznrM6JOCYyGIDJZQxaxkq2hMFk=
Received: from mail-pg1-f199.google.com (209.85.215.199 [209.85.215.199]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-saV6S-nzPcezV_kwHws7hQ-1; Thu,
 18 Sep 2025 21:26:30 -0400
X-MC-Unique: saV6S-nzPcezV_kwHws7hQ-1
X-Mimecast-MFC-AGG-ID: saV6S-nzPcezV_kwHws7hQ_1758245185
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b55118e2d01so577073a12.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 18:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758245185; x=1758849985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBqT4GDWcNMH7b8efKieP9YpFeoByi0GaQLbR+k6Z54=;
        b=Md2tNP2Ekq2sCnTfXXr3I5WxkLgzPYcMFPRiHM5aPQQi6zXQj8TSaf1hSdMmsok7Pl
         CHkZk7QK2tru5kn821ewD3ZPkzAw3dP0h+6KLL6PsUzBQwxqk5UfdojGqmqHuk85Teae
         KJE16sRs7I2e+nRRZy8bXtcb5rdl7pV1+C3dfpgtxWiqpLaoFzB0iRI2MglNLu8Uhg10
         CX0RFFFveyE2ngvhU3/aCbqyv9qvtBN/Q6I84X8oqkhb/o/fMwzc9d+6qlrgx8B66v6Y
         HtXNVYzkkef1yd7HctEIfiD2Gk6t1APYDkWTYBtSAwxzWRujo04PUL3b1J7+wVgB+5Br
         Nk+A==
X-Forwarded-Encrypted: i=1; AJvYcCXpwtsMw5dyqZMrnv7YlKhwZK+VVgpvuk4+Y1C/crRjmRc6Fs4RYBrEaMC5plwxJ1zRZNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykZJJd86V93dQC/yOWI9+LbqZB6WANZWsneKzDtFuNeqksA6Fa
	QPSTXGk3vciwuA2Nc411Wp3aDx44OcqPk9+TzFotLo2JnYGaJLapSawyC2OSUn8n8jfEAloG3vA
	RS5cvwBiZIp92aA5ntMIZOBYDSCwpxAtgUAn1aapMS3FsVHu07pAKGfV/SGB8CR66AgJI4im0WC
	sgFbdU/Vkz+ToE65Dgk6m8UoL419bM
X-Gm-Gg: ASbGnctfsM5Ujlir9PHOxjnWKyI0fkr0aMjYpUMDue7XHQRrRFZ/neCW/ytPfBzU75I
	aEnD0gWWW62Q9SCR5IQAZxQPu9TBeJVDrbrI3ysNP66q/aXbwLDNDJzb4pUgkq/dMW7jUeYbg/U
	OoMLnAUptYwYTJRvH2qQyKtg==
X-Received: by 2002:a17:903:283:b0:24c:be1f:c1f9 with SMTP id d9443c01a7336-269ba401ffcmr18340745ad.8.1758245184594;
        Thu, 18 Sep 2025 18:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO2skCMLMEd8sMR6CZiuCIRgOkrs+OOLYvaa57nTFwaSIwdWHTuOC81sk4hi68CyPIOebLgrM0B/PMSkLqmrE=
X-Received: by 2002:a17:903:283:b0:24c:be1f:c1f9 with SMTP id
 d9443c01a7336-269ba401ffcmr18340485ad.8.1758245184190; Thu, 18 Sep 2025
 18:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819012428.6217-1-piliu@redhat.com> <20250819012428.6217-7-piliu@redhat.com>
 <20250901163042.721db92d@rotkaeppchen> <aMkJNuORiqSZfpok@fedora> <20250918154342.0589fd4b@rotkaeppchen>
In-Reply-To: <20250918154342.0589fd4b@rotkaeppchen>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 19 Sep 2025 09:26:13 +0800
X-Gm-Features: AS18NWDr6iUFJ3p1GM1beWie7SyVvsRSJs8JGgscj1z7Bvo9Oa_M3LitZF84RwI
Message-ID: <CAF+s44Tz=yJVUeRz7Y5LZm7Rso7OLa6Y0cHGoPs4gPFa3PTeRw@mail.gmail.com>
Subject: Re: [PATCHv5 06/12] kexec: Integrate with the introduced bpf kfuncs
To: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Viktor Malik <vmalik@redhat.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 9:43=E2=80=AFPM Philipp Rudo <prudo@redhat.com> wro=
te:
>
> Hi Pingfan,
>
> On Tue, 16 Sep 2025 14:52:38 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
>
> > On Mon, Sep 01, 2025 at 04:30:42PM +0200, Philipp Rudo wrote:
> > > Hi Pingfan,
> > >
> > >
> > > On Tue, 19 Aug 2025 09:24:22 +0800
> > > Pingfan Liu <piliu@redhat.com> wrote:
> > >
> > > > This patch does two things:
> > > > First, register as a listener on bpf_copy_to_kernel()
> > > > Second, in order that the hooked bpf-prog can call the sleepable kf=
uncs,
> > > > bpf_handle_pefile and bpf_post_handle_pefile are marked as
> > > > KF_SLEEPABLE.
> > > >
> > > > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > Cc: Philipp Rudo <prudo@redhat.com>
> > > > Cc: Baoquan He <bhe@redhat.com>
> > > > Cc: Dave Young <dyoung@redhat.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: bpf@vger.kernel.org
> > > > To: kexec@lists.infradead.org
> > > > ---
> > > >  kernel/kexec_pe_image.c | 67 +++++++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 67 insertions(+)
> > > >
> > > > diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
> > > > index b0cf9942e68d2..f8debcde6b516 100644
> > > > --- a/kernel/kexec_pe_image.c
> > > > +++ b/kernel/kexec_pe_image.c
> > > > @@ -38,6 +38,51 @@ static struct kexec_res parsed_resource[3] =3D {
> > > >   { KEXEC_RES_CMDLINE_NAME, },
> > > >  };
> > > >
> > > > +/*
> > > > + * @name should be one of : kernel, initrd, cmdline
> > > > + */
> > > > +static int bpf_kexec_carrier(const char *name, struct mem_range_re=
sult *r)
> > > > +{
> > > > + struct kexec_res *res;
> > > > + int i;
> > > > +
> > > > + if (!r || !name)
> > > > +         return -EINVAL;
> > > > +
> > > > + for (i =3D 0; i < 3; i++) {
> > > > +         if (!strcmp(parsed_resource[i].name, name))
> > > > +                 break;
> > > > + }
> > > > + if (i >=3D 3)
> > > > +         return -EINVAL;
> > >
> > > Can you please replace the magic '3' by ARRAY_SIZE, just like you did
> > > below when (un-)registering the listener.
> > >
> >
> > Yes, I will introduce a macro KEXEC_RES_ARRAY_SIZE to unify all of them=
.
>
> Why do you want to introduce a new macro? Why not simply use
> ARRAY_SIZE(parsed_resource)?
>

The input parameters of kexec_file_load determine that the array size
of parsed_resource[] itself should be three.
And that should be the origin.

Thanks,

Pingfan

> Thanks
> Philipp
>
> > Thanks,
> >
> > Pingfan
> >
> > > Thanks
> > > Philipp
> > >
> > > > +
> > > > + res =3D &parsed_resource[i];
> > > > + /*
> > > > +  * Replace the intermediate resource generated by the previous st=
ep.
> > > > +  */
> > > > + if (!!res->r)
> > > > +         mem_range_result_put(res->r);
> > > > + mem_range_result_get(r);
> > > > + res->r =3D r;
> > > > + return 0;
> > > > +}
> > > > +
> > > > +static struct carrier_listener kexec_res_listener[3] =3D {
> > > > + { .name =3D KEXEC_RES_KERNEL_NAME,
> > > > +   .alloc_type =3D 1,
> > > > +   .handler =3D bpf_kexec_carrier,
> > > > + },
> > > > + { .name =3D KEXEC_RES_INITRD_NAME,
> > > > +   .alloc_type =3D 1,
> > > > +   .handler =3D bpf_kexec_carrier,
> > > > + },
> > > > + { .name =3D KEXEC_RES_CMDLINE_NAME,
> > > > +   /* kmalloc-ed */
> > > > +   .alloc_type =3D 0,
> > > > +   .handler =3D bpf_kexec_carrier,
> > > > + },
> > > > +};
> > > > +
> > > >  static bool pe_has_bpf_section(const char *file_buf, unsigned long=
 pe_sz);
> > > >
> > > >  static bool is_valid_pe(const char *kernel_buf, unsigned long kern=
el_len)
> > > > @@ -159,6 +204,22 @@ __attribute__((used, optimize("O0"))) void bpf=
_post_handle_pefile(struct kexec_c
> > > >   dummy +=3D 2;
> > > >  }
> > > >
> > > > +BTF_KFUNCS_START(kexec_modify_return_ids)
> > > > +BTF_ID_FLAGS(func, bpf_handle_pefile, KF_SLEEPABLE)
> > > > +BTF_ID_FLAGS(func, bpf_post_handle_pefile, KF_SLEEPABLE)
> > > > +BTF_KFUNCS_END(kexec_modify_return_ids)
> > > > +
> > > > +static const struct btf_kfunc_id_set kexec_modify_return_set =3D {
> > > > + .owner =3D THIS_MODULE,
> > > > + .set =3D &kexec_modify_return_ids,
> > > > +};
> > > > +
> > > > +static int __init kexec_bpf_prog_run_init(void)
> > > > +{
> > > > + return register_btf_fmodret_id_set(&kexec_modify_return_set);
> > > > +}
> > > > +late_initcall(kexec_bpf_prog_run_init);
> > > > +
> > > >  /*
> > > >   * PE file may be nested and should be unfold one by one.
> > > >   * Query 'kernel', 'initrd', 'cmdline' in cur_phase, as they are i=
nputs for the
> > > > @@ -213,6 +274,9 @@ static void *pe_image_load(struct kimage *image=
,
> > > >   cmdline_start =3D cmdline;
> > > >   cmdline_sz =3D cmdline_len;
> > > >
> > > > + for (int i =3D 0; i < ARRAY_SIZE(kexec_res_listener); i++)
> > > > +         register_carrier_listener(&kexec_res_listener[i]);
> > > > +
> > > >   while (is_valid_format(linux_start, linux_sz) &&
> > > >          pe_has_bpf_section(linux_start, linux_sz)) {
> > > >           struct kexec_context context;
> > > > @@ -250,6 +314,9 @@ static void *pe_image_load(struct kimage *image=
,
> > > >           disarm_bpf_prog();
> > > >   }
> > > >
> > > > + for (int i =3D 0; i < ARRAY_SIZE(kexec_res_listener); i++)
> > > > +         unregister_carrier_listener(kexec_res_listener[i].name);
> > > > +
> > > >   /*
> > > >    * image's kernel_buf, initrd_buf, cmdline_buf are set. Now they =
should
> > > >    * be updated to the new content.
> > >
> >
>


