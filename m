Return-Path: <bpf+bounces-53786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFCFA5B84E
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 06:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FEA3AE3C4
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 05:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86491E9B2A;
	Tue, 11 Mar 2025 05:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+Np+QcQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D442D1E8325
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 05:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741670189; cv=none; b=aqpiLXcO58E9VriZzMc23DNkUjPmZiiH28TNM5Ole35BAXY8HGpWRkejYyZ1KfXqiVl3NxY4+JeyLcY4xNngTaWNpMKU3z7oTewXNRMV2zk2ryU/qhcOf5eNqnf7LMmyb+V6uGfFo7GZGk83DNVa977XbY125lcn/seOlFb6pTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741670189; c=relaxed/simple;
	bh=k8XJmsj6RcG6m8sDhX+Uke+KLeh3r+tTdT6a3Kf9DKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+IAbLXJ6LuqB1LBpZ6ZgTAnPsqocHHVbotZlH/d9mY8d3X6OlTw94oa/2U2qjFbnRSPB7kd5Wn4Y9jdSxvb8mRKDoiDlxY91Xcgb9pHa13K9AI8f4l6nLSixprPznXFgK5a+eAoXEshLRUu/geu+IMVtn58okXsoDEPgguyJzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+Np+QcQ; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-601a8b6c133so804801eaf.1
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 22:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741670187; x=1742274987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BozVN3FvZJPhoQ2XpumDxv+rrpm9YCVMFCxeVYJTbbI=;
        b=F+Np+QcQSFUDAWRaa5Hk6kzQW4Qn4o6vj1j3IMV9IvIJ0EMYEqC9OSsoXQGJ97UWye
         7CrHfvjxQEENgwjQ/t0thNtb3YMtl4PKLAGKZJebjfPqqr6l9kLY4CCSpk1sxBOu8ekc
         EYZm1SJ4ar8MtHPJ0rgim9xZJq71F3ZZO+zI3zIaVGBWDk+Tto9UxKPJjMOp7t3n8gH0
         BtiOPQATsBDObvZUvTDMucyltBm5LwIZeIANGeWgIRh58kdtLyhwqQS3Nl/rVU+0tj4u
         1SaNs9cyBxBtGHlvyMjSKOso8hR4CP++x+IwWkNHYLMYQrbZVTZkq7CIR5Deh40B93vG
         5IPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741670187; x=1742274987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BozVN3FvZJPhoQ2XpumDxv+rrpm9YCVMFCxeVYJTbbI=;
        b=VZ4X/J5Y9q7k+ZQ+94urW8iYt0qJzbIxr5rM01mxHRcN6AMbAkLlZJ8872wFLMbxIP
         DrDcmXTzBg4yCJpibC4yQpEplDaswYeQ3rz6+qpg9+BDNi9L/P/KJLbXcwGAQdqBQa0U
         EjIMyM+r5eQjWSk3TwOnX028eYNFJGZvapLpKZDjzqIHL5SXpq7Vf7fTXGe5+SMT3EDy
         OgO416xVbyQbBTQuvSvSpu6v4NlvLmAdteOtx+hbPcIWg3/mnjsyxHJULkiRcT/j+p+/
         nUUgDiLnYhyatfdRFT6HhJn/XswHSdyCAkNqS7CpX3drX+a1nxAnlkM/3MhJvD4ZUyml
         LT6g==
X-Gm-Message-State: AOJu0YwdodqlkcyPYk9j9KcoZa4w7JR3My9PXRjkryOi5SucCTTyOQ4t
	shWVq8rgOSwKGLttRcvI/ls98c69PWJLi/oBStfansKFRZZE0kF7SFGoaF7o8akRHeHw0MUPa0c
	ZOkzPjvX9PP+7ZVD9fk/01/khLog=
X-Gm-Gg: ASbGncstcx/xkBV7reOaOFTUSYQIKvSQk4cBdE+1roYpLw30mbU6RQqS2yhzdQrO0io
	w7q6yMi2OwNbmV+aByUSlf4d5jlgAw5fRiRaq9xohdvhbkBxiVmNVidmH/xTdAeOL0PmExmOTX+
	a4kDHUHGFxuTxWMMIN694NJ3d3dQ==
X-Google-Smtp-Source: AGHT+IFIRaSCqWchhjBCAkUW+AA4/WcTLH63V1QhNWkU56+f6H2kLJaHpFrWbmEJpeGZlJetUj3HEFuuQosZcC69T8A=
X-Received: by 2002:a05:6808:159d:b0:3f4:e3e:10c5 with SMTP id
 5614622812f47-3fa28b15db3mr1341497b6e.0.1741670186587; Mon, 10 Mar 2025
 22:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307140120.1261890-1-hengqi.chen@gmail.com> <10239917-2cbe-434e-adc5-69c3f3e66e36@linux.dev>
In-Reply-To: <10239917-2cbe-434e-adc5-69c3f3e66e36@linux.dev>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Tue, 11 Mar 2025 13:16:15 +0800
X-Gm-Features: AQ5f1Joz75kKP_o_9P-W16lMRvX-nv-NK4iTB-5EV5ioTxWcqACjFeQe7En1n2g
Message-ID: <CAEyhmHT+DZDjXixnWgCq028K7KZ84bWHY1+Kv9bjJAQW9vryHQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix uprobe offset calculation
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, deso@posteo.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yonghong,

On Sat, Mar 8, 2025 at 2:48=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 3/7/25 6:01 AM, Hengqi Chen wrote:
> > As reported on libbpf-rs issue([0]), the current implementation
> > may resolve symbol to a wrong offset and thus missing uprobe
> > event. Calculate the symbol offset from program header instead.
> > See the BCC implementation (which in turn used by bpftrace) and
> > the spec ([1]) for references.
> >
> >    [0]: https://github.com/libbpf/libbpf-rs/issues/1110
> >    [1]: https://refspecs.linuxfoundation.org/elf/
> >
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>
> Hengqi,
>
> There are some test failures in the CI. For example,
>    https://github.com/kernel-patches/bpf/actions/runs/13725803997/job/383=
92284640?pr=3D8631
>

Yes, I've received an email from BPF CI.
It seems like the uprobe multi testcase is unhappy with this change.

> Please take a look.
> Your below elf_sym_offset change matches some bcc implementation, but
> maybe maybe this is only under certain condition?
>

Remove the `phdr.p_flags & PF_X` check fix the issue. Need more investigati=
on.

> Also, it would be great if you can add detailed description in commit mes=
sage
> about what is the problem and why a different approach is necessary to
> fix the issue.
>

Will do. Thanks.

> > ---
> >   tools/lib/bpf/elf.c | 32 ++++++++++++++++++++++++--------
> >   1 file changed, 24 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> > index 823f83ad819c..9b561c8d1eec 100644
> > --- a/tools/lib/bpf/elf.c
> > +++ b/tools/lib/bpf/elf.c
> > @@ -260,13 +260,29 @@ static bool symbol_match(struct elf_sym_iter *ite=
r, int sh_type, struct elf_sym
> >    * for shared libs) into file offset, which is what kernel is expecti=
ng
> >    * for uprobe/uretprobe attachment.
> >    * See Documentation/trace/uprobetracer.rst for more details. This is=
 done
> > - * by looking up symbol's containing section's header and using iter's=
 virtual
> > - * address (sh_addr) and corresponding file offset (sh_offset) to tran=
sform
> > + * by looking up symbol's containing program header and using its virt=
ual
> > + * address (p_vaddr) and corresponding file offset (p_offset) to trans=
form
> >    * sym.st_value (virtual address) into desired final file offset.
> >    */
> > -static unsigned long elf_sym_offset(struct elf_sym *sym)
> > +static unsigned long elf_sym_offset(Elf *elf, struct elf_sym *sym)
> >   {
> > -     return sym->sym.st_value - sym->sh.sh_addr + sym->sh.sh_offset;
> > +     size_t nhdrs, i;
> > +     GElf_Phdr phdr;
> > +
> > +     if (elf_getphdrnum(elf, &nhdrs))
> > +             return -1;
> > +
> > +     for (i =3D 0; i < nhdrs; i++) {
> > +             if (!gelf_getphdr(elf, (int)i, &phdr))
> > +                     continue;
> > +             if (phdr.p_type !=3D PT_LOAD || !(phdr.p_flags & PF_X))
> > +                     continue;
> > +             if (sym->sym.st_value >=3D phdr.p_vaddr &&
> > +                 sym->sym.st_value < (phdr.p_vaddr + phdr.p_memsz))
> > +                     return sym->sym.st_value - phdr.p_vaddr + phdr.p_=
offset;
> > +     }
> > +
> > +     return -1;
> >   }
> >
> >   /* Find offset of function name in the provided ELF object. "binary_p=
ath" is
> > @@ -329,7 +345,7 @@ long elf_find_func_offset(Elf *elf, const char *bin=
ary_path, const char *name)
> >
> >                       if (ret > 0) {
> >                               /* handle multiple matches */
> > -                             if (elf_sym_offset(sym) =3D=3D ret) {
> > +                             if (elf_sym_offset(elf, sym) =3D=3D ret) =
{
> >                                       /* same offset, no problem */
> >                                       continue;
> >                               } else if (last_bind !=3D STB_WEAK && cur=
_bind !=3D STB_WEAK) {
>
> [...]
>

