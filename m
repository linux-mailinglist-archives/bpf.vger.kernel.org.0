Return-Path: <bpf+bounces-53932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7A2A5EA86
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 05:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D5E1896CB6
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 04:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4796F145A11;
	Thu, 13 Mar 2025 04:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnuLFg5k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3C13C8E8
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 04:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741839803; cv=none; b=QddSNPGrpAbs3wajEov498c31B7uSEIWui1ddcr3VIgufBhd3IvFhirgKhqv1Ngx8SK6vZqs1oGp/8qojReT8GC+fTvcZYq6F03MPlmJ4w9fm3SP+JnJNVb0dB80JhkMz1gywgGeYvLmkN3Ugelrm1eJwbd1LTl7eJrFOLTJKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741839803; c=relaxed/simple;
	bh=ijo+Yhwe+rUPRrKCnemqPOZx7Myj2ZEEuDq22hBnUIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGlZuIHzC+ntaEtDJGkxljGcW4h3cx1lbsanRCOwN1eUOoUaSop2tOeeneiuZiKeSkOaQTCCXXMB93pxTLcNRND+7JFadLJmkzjmEc9V5ClVLaoIhqkLkjDEjIwgS/uWLbE87YX9dLiuuASRvn3ftlnfHJoHIbQQKfNiQVQlY+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnuLFg5k; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3fa6c54cc1aso364652b6e.1
        for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 21:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741839801; x=1742444601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VG5Szf+piGb4IeggQyjJ5v/DmNAg5ge0XU5M9eKgME8=;
        b=lnuLFg5klTNTJe4VrNBu5XgkaWDTj8EIUKWzDh+ThxNx2Vlm6ZORDZ5XQlZhGsS9rj
         1dt0nF5eTqNLjCJp91l6DY3Lof+7GBUitgsq2uNkn1okDwNRQRiM0TnOkF5vrjBMnWEA
         S3vaPinRFcSdT5iu8Iybs+HfI+wtfdjhBiZOfH412WRBEVsl8PAISiiPi6MP+hfNOTDw
         RQutgGZWfz1STMcfPlCX52xkzI6uS0VJrRsU/+wMnAyQtXNwwF1w4U/PuiJCN4Gi+1ks
         vBvTEmSVbgN0Dp42LdPZTb9tVQUwvvUODswlmHfhryw13ZLGA/OaTELoAXAlQ3pJktOZ
         zqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741839801; x=1742444601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VG5Szf+piGb4IeggQyjJ5v/DmNAg5ge0XU5M9eKgME8=;
        b=qJ7rWvBJvSBU31gdB96i/m2KljY/lg3Jscq5YjEDAInbuChLHc7oQVr/JhtktgYl51
         +19SQ+5zdex/5zrabtqaWbRQMk+s02uid4DJ1JbLCOHa0x6liz25rbnNtGPH+2pCFLQB
         e5dFPraaJeGdVsIoiH+IVMt0gkRCowOWycahR5a/YXlMRk11en/RMLHEapSfLMUT39QL
         JRkPx/WwVqiVqZEff7zYoyv3XCJK8vnDyordKL11MqPUmlausQpGqvvQqC6e8UDD8pUC
         o1TDzCTh4vMO/61oxwju7A+PImPMgRQ5fCjuTP+6MUnpsCPyYe6udcPPZrNi5pEqwlXg
         XbsA==
X-Forwarded-Encrypted: i=1; AJvYcCW00T8e/Fr+hy/CAlm3yWA+vRHQ2lL/KyRDWZlVUCYHrF88OIW/c7oeAuptoapYryK6c90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQsepdscAFcqjPQqe323ecl+htcZdw+OaMxZzceAcJZvgL4CUy
	Ko/D+XdD8LLl00z0hQhcPf3r8dGDXiS4fPSf/QAWPoguVVNjqP+wwM51/j0l7WEwqm/cqqcdc4B
	zTE/DzNqzFrj0RACOa3S1208m4XI165OI
X-Gm-Gg: ASbGncv/Fyghgn9+SyMX1cSK6b/D9BdZeXzsditlu3E0djXnOL8RmCwumcPvnVZ8AyK
	kxxY5R+sPM1x/F6HPoutBQgGRj6ntkL+2sKJbiimfrREy53dwfFxCZl6mLDEDrKv/fwDZujZRPZ
	gUzsXkdHtgWWdqLfxDnsE1UnmQCPGpGOcR8MTH
X-Google-Smtp-Source: AGHT+IHC7XSZeB+e/ekiGbqkhnQlJLA8Woab3ENjUvmV2rcrkBPX4T/ftenBByUH1hQMIdYFzGE2EDXcY/hjyFl6rXw=
X-Received: by 2002:a05:6808:2008:b0:3fc:1f7b:c3a2 with SMTP id
 5614622812f47-3fc1f7bc69dmr2413626b6e.17.1741839801069; Wed, 12 Mar 2025
 21:23:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307140120.1261890-1-hengqi.chen@gmail.com>
 <10239917-2cbe-434e-adc5-69c3f3e66e36@linux.dev> <CAEyhmHT+DZDjXixnWgCq028K7KZ84bWHY1+Kv9bjJAQW9vryHQ@mail.gmail.com>
 <CAEf4BzbAi-g-jyFoHdXHNfOT3DLTnKN1XioPhR=XYJnM7+_VOQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbAi-g-jyFoHdXHNfOT3DLTnKN1XioPhR=XYJnM7+_VOQ@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 13 Mar 2025 12:23:10 +0800
X-Gm-Features: AQ5f1JobhhCQXfDVRBfNsOHHK8ag4vaptMToWPTqlwbDU9-Sg7X4lxzM3wRW0EA
Message-ID: <CAEyhmHRobpifJ_h3q2ucnhunV_r2MLO4QE5sAMZKQmAMYaBzjw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix uprobe offset calculation
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, andrii@kernel.org, 
	eddyz87@gmail.com, deso@posteo.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrii,

On Thu, Mar 13, 2025 at 2:47=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 10, 2025 at 10:16=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.c=
om> wrote:
> >
> > Hi Yonghong,
> >
> > On Sat, Mar 8, 2025 at 2:48=E2=80=AFPM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
> > >
> > >
> > >
> > > On 3/7/25 6:01 AM, Hengqi Chen wrote:
> > > > As reported on libbpf-rs issue([0]), the current implementation
> > > > may resolve symbol to a wrong offset and thus missing uprobe
> > > > event. Calculate the symbol offset from program header instead.
> > > > See the BCC implementation (which in turn used by bpftrace) and
> > > > the spec ([1]) for references.
> > > >
> > > >    [0]: https://github.com/libbpf/libbpf-rs/issues/1110
> > > >    [1]: https://refspecs.linuxfoundation.org/elf/
> > > >
> > > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > >
> > > Hengqi,
> > >
> > > There are some test failures in the CI. For example,
> > >    https://github.com/kernel-patches/bpf/actions/runs/13725803997/job=
/38392284640?pr=3D8631
> > >
> >
> > Yes, I've received an email from BPF CI.
> > It seems like the uprobe multi testcase is unhappy with this change.
> >
> > > Please take a look.
> > > Your below elf_sym_offset change matches some bcc implementation, but
> > > maybe maybe this is only under certain condition?
> > >
> >
> > Remove the `phdr.p_flags & PF_X` check fix the issue. Need more investi=
gation.
> >
> > > Also, it would be great if you can add detailed description in commit=
 message
> > > about what is the problem and why a different approach is necessary t=
o
> > > fix the issue.
> > >
> >
> > Will do. Thanks.
> >
> > > > ---
> > > >   tools/lib/bpf/elf.c | 32 ++++++++++++++++++++++++--------
> > > >   1 file changed, 24 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> > > > index 823f83ad819c..9b561c8d1eec 100644
> > > > --- a/tools/lib/bpf/elf.c
> > > > +++ b/tools/lib/bpf/elf.c
> > > > @@ -260,13 +260,29 @@ static bool symbol_match(struct elf_sym_iter =
*iter, int sh_type, struct elf_sym
> > > >    * for shared libs) into file offset, which is what kernel is exp=
ecting
> > > >    * for uprobe/uretprobe attachment.
> > > >    * See Documentation/trace/uprobetracer.rst for more details. Thi=
s is done
> > > > - * by looking up symbol's containing section's header and using it=
er's virtual
> > > > - * address (sh_addr) and corresponding file offset (sh_offset) to =
transform
> > > > + * by looking up symbol's containing program header and using its =
virtual
> > > > + * address (p_vaddr) and corresponding file offset (p_offset) to t=
ransform
> > > >    * sym.st_value (virtual address) into desired final file offset.
> > > >    */
> > > > -static unsigned long elf_sym_offset(struct elf_sym *sym)
> > > > +static unsigned long elf_sym_offset(Elf *elf, struct elf_sym *sym)
> > > >   {
> > > > -     return sym->sym.st_value - sym->sh.sh_addr + sym->sh.sh_offse=
t;
> > > > +     size_t nhdrs, i;
> > > > +     GElf_Phdr phdr;
> > > > +
> > > > +     if (elf_getphdrnum(elf, &nhdrs))
> > > > +             return -1;
> > > > +
> > > > +     for (i =3D 0; i < nhdrs; i++) {
> > > > +             if (!gelf_getphdr(elf, (int)i, &phdr))
> > > > +                     continue;
> > > > +             if (phdr.p_type !=3D PT_LOAD || !(phdr.p_flags & PF_X=
))
> > > > +                     continue;
> > > > +             if (sym->sym.st_value >=3D phdr.p_vaddr &&
> > > > +                 sym->sym.st_value < (phdr.p_vaddr + phdr.p_memsz)=
)
> > > > +                     return sym->sym.st_value - phdr.p_vaddr + phd=
r.p_offset;
>
> Hengqi,
>
> Can you please provide an example where existing code doesn't work? I thi=
nk that
>
> sym->sym.st_value - sym->sh.sh_addr + sym->sh.sh_offset
>
> and
>
> sym->sym.st_value - phdr.p_vaddr + phdr.p_offset
>
>
> Should result in the same, and we don't need to search for a matching
> segment if we have an ELF symbol and its section. But maybe I'm
> mistaken, so can you please elaborate a bit?

The binary ([0]) provided in the issue shows some counterexamples.
I could't find an authoritative documentation describing this though.
A modified version ([1]) of this patch could pass the CI now.

  [0]: https://github.com/libbpf/libbpf-rs/issues/1110#issuecomment-2699221=
802
  [1]: https://github.com/kernel-patches/bpf/pull/8647

>
> > > > +     }
> > > > +
> > > > +     return -1;
> > > >   }
> > > >
> > > >   /* Find offset of function name in the provided ELF object. "bina=
ry_path" is
> > > > @@ -329,7 +345,7 @@ long elf_find_func_offset(Elf *elf, const char =
*binary_path, const char *name)
> > > >
> > > >                       if (ret > 0) {
> > > >                               /* handle multiple matches */
> > > > -                             if (elf_sym_offset(sym) =3D=3D ret) {
> > > > +                             if (elf_sym_offset(elf, sym) =3D=3D r=
et) {
> > > >                                       /* same offset, no problem */
> > > >                                       continue;
> > > >                               } else if (last_bind !=3D STB_WEAK &&=
 cur_bind !=3D STB_WEAK) {
> > >
> > > [...]
> > >

