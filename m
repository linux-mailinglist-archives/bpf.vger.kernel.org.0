Return-Path: <bpf+bounces-43759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36D39B97C4
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7878D1F232FF
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 18:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0CF1CF280;
	Fri,  1 Nov 2024 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4rw9yuZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545261CDFCB;
	Fri,  1 Nov 2024 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486342; cv=none; b=sghFOcr8FM5pOarX1BpMYsF32E9DIMJmWrv4vCXSHsGQ4WOhZlweR3k3Wz17TjQFnn7M0z8ZYvvfKEqvAxrP1B7/Xl0HL4XnpLjYhw5TLSElExy2tLmXfEVRDO+jTdtJR7XW+c5dGGxH9FjA4wMc2XC/erX126sZL3hiHYL013Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486342; c=relaxed/simple;
	bh=nscJz4mScA+las7Vvq/kD5Df8NTSLqkMky6anwpOB0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kM4PuLh7QqxWeTWnG1u+yQSigqmlzHjN278RpNeI2fle/YjdH+998JpOEo1YRqBU1JA/TQmEAvRA0tou5cvYF8JdJlN5/4FK99mj9z2DwxDqEKGQFMyBIm7AOoR0wLbFAp1v30cQTyJ0YzJ9A9alP9QAD4Sc32I34kN68AyO7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4rw9yuZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c767a9c50so23335445ad.1;
        Fri, 01 Nov 2024 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730486339; x=1731091139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+TfQU3HPvfeEnVpBs62c2W5DPlSdZgLA0VURBeB+Cc=;
        b=L4rw9yuZf0HjFJch8lzC5DJsm59TDwuEGIFqOBRCLNbTs/7TLoGv7O8VIBSUpQFD+L
         bT9v+O5yXN5oYLfmH6XZBPIqZ7ms2BoRF7khQQQE3V6mpZM56T0C9S0ti2JpyOGRdqNl
         HrQpcqsgUaVI3IgjSL2ehb2LCGRnU08zN6wfuufNPRW1BeUIBRWX3hAlCQqZJ9cfx2Jb
         RuDMVjHDshDt47fEGevfMlEnr2LEPe00CfKKMsiSionfWQQDCO0e7VPI0Z/6JzeGBfqy
         U9XRJIclGNbNOk74URW+K62Eu/0dexAb42lyTEpJfwm6k9IRgT8S2KSKzuF4m+B/wrsD
         cmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730486339; x=1731091139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+TfQU3HPvfeEnVpBs62c2W5DPlSdZgLA0VURBeB+Cc=;
        b=ftKk1VibxWBWb8LAfqOeOlCNe3H6Bj/w4sDh0qX/ukI6++mXgFMMyjRpPLjQyyL0aP
         sM1Un1kVn4JOXaQc7rBC0ONckUNj+R5nZpQR8WnkbM/rAAibte0AScuEFkf/T1TT4zjM
         2DwdCHHTrXXwWuFRxKnzFIdsoSMmwJa/VWFAtvAkJx5F+n0QdKuUx6DRJOsZzYLAXHnz
         pbRerpt59Qw3XRMnGT9lTpwK5/K9YuiGxzjobDKKTY3jkPI9VQ1RFZz1OJrXU6KE14Ap
         OA43dz0CCsq0nhXtMwL1FmvYNGXxobGrhdhQx6LcP8xcBx2/dG8cQ8dhvxms+w2OBLRi
         dXfA==
X-Forwarded-Encrypted: i=1; AJvYcCUCVxfpaqkIg/2tFvjUnyU48r7rfjZOYT5mGxJIoClIOQrEQcVh2uzdQswiapWpYBBBRdTIMoTN+HRhy7X0@vger.kernel.org, AJvYcCV4BU9DO4bE7WtTa/niWS0CTOmznv8CdQiENartS2+6+tLVCwD5lE14eRKH7XQ+lueQHD5GjTdAIhB1nyFzzAnWpg==@vger.kernel.org, AJvYcCWQXGZangudNpOW2XpkOGTWIYBcTaIwdjunGsrpU5cX2++HKGXfyHtkCr7sIIv4UQsm074=@vger.kernel.org, AJvYcCXv0aQqQaBjuWT8G+YhztR4GYMa1g8IvbKLxgi5blu4D/wqFXL062cBLmveZypadpPHCkzsn8HlHvSM3UahsDDOaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmOXzFyTPDEBLIDLIapVvP9VeLHZVJfv17qmBvb0ZB3yuSNHUk
	VIaA3h3/KHMAiZxkY6tCTo3LtOL6u1IL2JZiESIQWZm5+EAkXQ3Gh6XYraOlZsAb5R9C8+fNmyy
	r6+COmBdBlMMpR/OGPRUjjPTN1as=
X-Google-Smtp-Source: AGHT+IEOfotrZon1B8S0vYxCvcvMHe8XxPJ7H0/1D9CTLG2Sr9LpUDvl6NrxRyxW6o/UXOkcOo5C2QxVVPPdCjFqKrU=
X-Received: by 2002:a17:90b:1a92:b0:2e2:b3fb:991f with SMTP id
 98e67ed59e1d1-2e94c2b0377mr6217413a91.15.1730486339571; Fri, 01 Nov 2024
 11:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730150953.git.jpoimboe@kernel.org> <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>
 <20241030055314.2vg55ychg5osleja@treble.attlocal.net> <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
 <0f40b9b8-53a9-4b45-883b-d4d5ecf9fff6@oracle.com>
In-Reply-To: <0f40b9b8-53a9-4b45-883b-d4d5ecf9fff6@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 11:38:47 -0700
Message-ID: <CAEf4BzbLt3b8xH3eSvRJdnorZvQfWzOFeV-gYRxDmaS6YVba2A@mail.gmail.com>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
To: Indu Bhagat <indu.bhagat@oracle.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 2:38=E2=80=AFPM Indu Bhagat <indu.bhagat@oracle.com=
> wrote:
>
> On 10/31/24 1:57 PM, Andrii Nakryiko wrote:
> > On Tue, Oct 29, 2024 at 10:53=E2=80=AFPM Josh Poimboeuf <jpoimboe@kerne=
l.org> wrote:
> >>
> >> On Tue, Oct 29, 2024 at 04:32:40PM -0700, Andrii Nakryiko wrote:
> >>> It feels like this patch is trying to do too much. There is both new
> >>> UAPI introduction, and SFrame format definition, and unwinder
> >>> integration, etc, etc. Do you think it can be split further into more
> >>> focused smaller patches?
> >>
> >> True, let me see if I can split it up.
> >>
> >>>> +
> >>>> +                       if ((eppnt->p_flags & PF_X) && k < start_cod=
e)
> >>>> +                               start_code =3D k;
> >>>> +
> >>>> +                       if ((eppnt->p_flags & PF_X) && k + eppnt->p_=
filesz > end_code)
> >>>> +                               end_code =3D k + eppnt->p_filesz;
> >>>> +                       break;
> >>>> +               }
> >>>> +               case PT_GNU_SFRAME:
> >>>> +                       sframe_phdr =3D eppnt;
> >>>
> >>> if I understand correctly, there has to be only one sframe, is that
> >>> right? Should we validate that?
> >>
> >> Yes, there shouldn't be more than one PT_GNU_SFRAME for the executable
> >> itself.  I can validate that.
> >>
> >>>> +                       break;
> >>>>                  }
> >>>>          }
> >>>>
> >>>> +       if (sframe_phdr)
> >>>> +               sframe_add_section(load_addr + sframe_phdr->p_vaddr,
> >>>> +                                  start_code, end_code);
> >>>> +
> >>>
> >>> no error checking?
> >>
> >> Good point.  I remember discussing this with some people at Cauldon/LP=
C,
> >> I just forgot to do it!
> >>
> >> Right now it does all the validation at unwind, which could really slo=
w
> >> things down unnecessarily if the sframe isn't valid.
> >>
> >>>> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
> >>>> +
> >>>> +#define INIT_MM_SFRAME .sframe_mt =3D MTREE_INIT(sframe_mt, 0),
> >>>> +
> >>>> +extern void sframe_free_mm(struct mm_struct *mm);
> >>>> +
> >>>> +/* text_start, text_end, file_name are optional */
> >>>
> >>> what file_name? was that an extra argument that got removed?
> >>
> >> Indeed, that was for some old code.
> >>
> >>>>          case PR_RISCV_SET_ICACHE_FLUSH_CTX:
> >>>>                  error =3D RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
> >>>>                  break;
> >>>> +       case PR_ADD_SFRAME:
> >>>> +               if (arg5)
> >>>> +                       return -EINVAL;
> >>>> +               error =3D sframe_add_section(arg2, arg3, arg4);
> >>>
> >>> wouldn't it be better to make this interface extendable from the get
> >>> go? Instead of passing 3 arguments with fixed meaning, why not pass a
> >>> pointer to an extendable binary struct like seems to be the trend
> >>> nowadays with nicely extensible APIs. See [0] for one such example
> >>> (specifically, struct procmap_query). Seems more prudent, as we'll
> >>> most probably will be adding flags, options, extra information, etc)
> >>>
> >>>    [0] https://lore.kernel.org/linux-mm/20240627170900.1672542-3-andr=
ii@kernel.org/
> >>
> >> This ioctl interface was admittedly hacked together.  I was hoping
> >> somebody would suggest something better :-)  I'll take a look.
> >>
> >>>> +static int find_fde(struct sframe_section *sec, unsigned long ip,
> >>>> +                   struct sframe_fde *fde)
> >>>> +{
> >>>> +       struct sframe_fde __user *first, *last, *found =3D NULL;
> >>>> +       u32 ip_off, func_off_low =3D 0, func_off_high =3D -1;
> >>>> +
> >>>> +       ip_off =3D ip - sec->sframe_addr;
> >>>
> >>> what if ip_off is larger than 4GB? ELF section can be bigger than 4GB=
, right?
> >>
> >> That's baked into sframe v2.
> >
> > I believe we do have large production binaries with more than 4GB of
> > text, what are we going to do about them? It would be interesting to
> > hear sframe people's opinion. Adding such a far-reaching new format in
> > 2024 with these limitations is kind of sad. At the very least maybe we
> > should allow some form of chaining sframe definitions to cover more
> > than 4GB segments? Please CC relevant folks, I'm wondering what
> > they're thinking about this.
> >
>
> SFrame V2 does have that limitation. We can try to have 64-bit
> representation for the 'ip' in the SFrame FDE and conditionalize it
> somehow (say, with a flag in the header) so as to not bloat the majority
> of applications.

Hi Indu,

I think that's prudent if we believe that SFrame is the solution here.
See my reply to Josh. Real-world already approach 4GB limits, and
things are not going to shrink in the years to come. So yeah, probably
we need some adjustments to the format to at least allow 64-bit
offsets (though trying to stick to 32-bit as much as possible, of
course, if they work).

I'm not really familiar with the nuances of the format just yet, so
can't really provide anything more useful at this point. What would be
the sort of gold reference for Sframe format to familiarize myself
thoroughly?

BTW, I wanted to ask. Are there any plans to add SFrame support to
Clang as well? It feels like without that there is no future for
SFrame as a general-purpose solution for stack traces.

>
> >>
> >>> and also, does it mean that SFrame doesn't support executables with
> >>> text bigger than 4GB?
> >>
> >> Yes, but is that a realistic concern?
> >
> > See above, yes. You'd be surprised. As somewhat corroborating
> > evidence, there were tons of problems and churn (within at least Meta)
> > with DWARF not supporting more than 2GB sizes, so yes, this is not an
> > abstract problem for sure. Modern production applications can be
> > ridiculously big.
> >
> >>
> >>>> +       } else {
> >>>> +               struct vm_area_struct *vma, *text_vma =3D NULL;
> >>>> +               VMA_ITERATOR(vmi, mm, 0);
> >>>> +
> >>>> +               for_each_vma(vmi, vma) {
> >>>> +                       if (vma->vm_file !=3D sframe_vma->vm_file ||
> >>>> +                           !(vma->vm_flags & VM_EXEC))
> >>>> +                               continue;
> >>>> +
> >>>> +                       if (text_vma) {
> >>>> +                               pr_warn_once("%s[%d]: multiple EXEC =
segments unsupported\n",
> >>>> +                                            current->comm, current-=
>pid);
> >>>
> >>> is this just something that fundamentally can't be supported by SFram=
e
> >>> format? Or just an implementation simplification?
> >>
> >> It's a simplification I suppose.
> >
> > That's a rather random limitation, IMO... How hard would it be to not
> > make that assumption?
> >
> >>
> >>> It's not illegal to have an executable with multiple VM_EXEC segments=
,
> >>> no? Should this be a pr_warn_once() then?
> >>
> >> I don't know, is it allowed?  I've never seen it in practice.  The
> >
> > I'm pretty sure you can do that with a custom linker script, at the
> > very least. Normally this probably won't happen, but I don't think
> > Linux dictates how many executable VMAs an application can have. And
> > it probably just naturally happens for JIT-ted applications (Java, Go,
> > etc).
> >
> > Linux kernel itself has two executable segments, for instance (though
> > kernel is special, of course, but still).
> >
> >> pr_warn_once() is not reporting that it's illegal but rather that this
> >> corner case actually exists and maybe needs to be looked at.
> >
> > This warn() will be logged across millions of machines in the fleet,
> > triggering alarms, people looking at this, making custom internal
> > patches to disable the known-to-happen warn. Why do we need all this?
> > This is an issue that is trivial to trigger by user process that's not
> > doing anything illegal. Why?
> >
> >>
> >> --
> >> Josh
>

