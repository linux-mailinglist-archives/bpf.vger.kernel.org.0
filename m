Return-Path: <bpf+bounces-50612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB59FA2A081
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 07:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA283A44D3
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 06:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1266E1FF1B0;
	Thu,  6 Feb 2025 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+X0w6XA"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182B52E64A
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 06:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821838; cv=none; b=uCdnjUyQwYNU7nAoRrAtHCWSwFLuccqlC7eLqM6CEb7ItXmwbkTApGSDlrFl5uS5pUtvo8eWB51H41oVv+QZ6HtJN53rD3qoHBoNxYHyb52U7QYkrGz0U+bXon8r6DXNLFuPfQeNijrOWYxqLEzYuwVVIQGFK7+7VVy5Gt0TEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821838; c=relaxed/simple;
	bh=EzygjjlXpOwyCmp2/+um0CGPoiVjZZUh7eHmJ/Sy79o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1eJjFxkaRY/0U3gpB/SHX3AWQPi6wPBofQgJIvreGvxGOwzikqVM6bGwCxKNI+FiNMvYLbCqWcuKTTz6+V8mWlekXa3ZlXwiyjZ97Jz0xFcoWhSUj3sd2kZLNXasvvF6EMchPIlK5xDrUf/lVoLTBRzyXbR2upO+4NoCJ06kbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+X0w6XA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738821835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ny9l24N0jRmMCU9/w9kcI7pTSxmMM9zclsDhYuwQT4c=;
	b=N+X0w6XA49irlG2/qZ2x04zoHr68NwaZoxJ4I6nccjUd0o/980BZAGqHduTkoTeCI3FW45
	GDzOsQcV7bIaGZbdLLO3li52s0tQGH8biD7QDwLty33hPnBEvKLWXX12SS1wveTNH9qtJq
	cAGDAUbCFBzP036hYh4VMaGkCPIMxTk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-xRIBQDHBN929Aix-tU0_4w-1; Thu, 06 Feb 2025 01:03:53 -0500
X-MC-Unique: xRIBQDHBN929Aix-tU0_4w-1
X-Mimecast-MFC-AGG-ID: xRIBQDHBN929Aix-tU0_4w
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2165433e229so14458705ad.1
        for <bpf@vger.kernel.org>; Wed, 05 Feb 2025 22:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738821832; x=1739426632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ny9l24N0jRmMCU9/w9kcI7pTSxmMM9zclsDhYuwQT4c=;
        b=DdJrji3p271he+4Kbx/9HdUrjY4vSNw62s89bAiPYr48HmSSHgaoNrURmoU6U58g8u
         dWJk6LUB6IodDlSpJ1s/Eqiwz4B2+a3iK5/TJeAuRYdxpeYaCUhxSZ/vSJw0XVP8zFSE
         sP23f5NkWR1b3M6Gy5JCfRv1yD0kP3eRZQeNaVMoATFYO+zng8nv7q3lDpdiQQCFgwhO
         ZkQZNiMtIDm29WqUPYbNfKzIubaI4APOFJRqlBEZ0Vdbxt3uA5WbZnWLnVVeN6ni/f3W
         Soaur50AsJI9O1kyB9FyMmi1wFMHTD25yKj4kn5x8jwjMN1Sv/CSFlSLg3EHt8WSsg5P
         jL8g==
X-Forwarded-Encrypted: i=1; AJvYcCUsHuzE0R7sOxtau7J8YRs33OW+CO+C79wYgXhiYsp5ZSNbmivoReUot3ncAcHnpvoK5BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQg9OidXnZCa0isRglYZ0JUEOQm3GurZX5MYgLdrPopgxikii4
	jcqBIYUXo5J6M1eDLl5+WJZGAZ0wqC9ywvb27wSEg7ODwU3H0yF+Omsmhk459Uy+W0YwQkVmmII
	iwaKhSxj54RyUUBy3REXlJDtJb6fwkqMvAPJ1hb8WNEyeWmg1Y5TtYREKCDHvUZZcVNQejRdOGd
	vc1BNtLOY05AtN8B32v3uDsuo/
X-Gm-Gg: ASbGncvzokMGO3wcdV5A34KLr52S7VnWch8lbvrL7nv2v6Z654t0QTfuy+JNCpUuRd/
	GKIvVli6M/j6kAIcDxzRXK7kfYfmESM1w4sUikOkbQupJk5wf/00DVrI5x9AV7lk=
X-Received: by 2002:a17:902:ea0a:b0:212:6187:6a76 with SMTP id d9443c01a7336-21f17e2782cmr95430335ad.14.1738821832263;
        Wed, 05 Feb 2025 22:03:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7dzc40tSrWKQkq8wlQeWgr9gBjQj7pb5Wb4Tr4grZH+Uw3TcOqk5MXlXo/ixFJP3nQrcLlY7ZaY4hjattlas=
X-Received: by 2002:a17:902:ea0a:b0:212:6187:6a76 with SMTP id
 d9443c01a7336-21f17e2782cmr95429985ad.14.1738821831851; Wed, 05 Feb 2025
 22:03:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114012831.4883-1-piliu@redhat.com> <20250131184621.12e8e94d@rotkaeppchen>
In-Reply-To: <20250131184621.12e8e94d@rotkaeppchen>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 6 Feb 2025 14:03:40 +0800
X-Gm-Features: AWEUYZmojOLoQ1p_kLgdNcgvpwEF1JC0EK8aXV4Z4XN6wcivUrtnnVGPOsFY8Oo
Message-ID: <CAF+s44Tw240R8cG4DKr6y_=aiu634ifMZma-FGkDuoEfoNnUtQ@mail.gmail.com>
Subject: Re: [RFC] kexec: Use bpf to allow kexec to load PE format boot image
To: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@kernel.org>, 
	Gerd Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

Thanks for your feedback. Please see my answers below.

I'm also reaching out to the BPF maintainers with two concerns: how to
ensure the integrity of BPF programs and whether introducing some
additional BPF helpers for the kexec subsystem would be acceptable.
Those helpers are used to exchange the data between BPF and the kexec
kernel part.


On Sat, Feb 1, 2025 at 1:46=E2=80=AFAM Philipp Rudo <prudo@redhat.com> wrot=
e:
>
> Hi Pingfan,
>
> thanks for sharing your thoughts. Please see my comments below.
>
> On Tue, 14 Jan 2025 09:28:25 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
>
> > Nowadays UEFI PE bootable image is more and more popular on the distrib=
ution.
> > But it is still an open issue to load that kind of image by kexec with =
IMA enabled
> >
> > *** A brief review of the history ***
> > There are two categatories methods to handle this issue.
> >   -1. UEFI service emulator for UEFI stub
> >   -2. PE format parser
> >
> > For the first one, I have tried a purgatory-style emulator [1]. But it
> > confronts the hardware scaling trouble.  For the second one, there are =
two
> > choices, one is to implement it inside the kernel, the other is inside =
the user
> > space.  Both zboot-format [2] and UKI-format [3] parsers are rejected d=
ue to
> > the concern that the variant format parsers will inflate the kernel cod=
e.  And
> > finally, we have these kinds of parsers in the user space 'kexec-tools'=
.
> >
> >
> > From the beginning, it has been perceived that the user space parser ca=
n not
> > satisfy the requirement of security-boot without an extra embeded signa=
ture.
> > This issue was suspended at that time.
> >
> > But now, more and more users expect the security feature and want the
> > kexec_file_load to guarantee it by IMA.  I tried to fix that issue by t=
he extra
> > embeded signature method. But it is also disliked.
> >
> > Enlighted by Philipp suggestion about implementing systemd-stub in bpf =
opcode in the discussion to [1],
> > I turn to the bpf and hope that parsers in bpf-program can resolve this=
 issue.
> >
> > [1]: https://lore.kernel.org/lkml/20240819145417.23367-1-piliu@redhat.c=
om/T/
> > [2]: https://lore.kernel.org/kexec/20230306030305.15595-1-kernelfans@gm=
ail.com/
> > [3]: https://lore.kernel.org/lkml/20230911052535.335770-1-kernel@jfarr.=
cc/
> > [4]: https://lore.kernel.org/linux-arm-kernel/20230921133703.39042-2-ke=
rnelfans@gmail.com/T/
> >
> >
> >
> >
> > *** Reflect the problem and a new proposal ***
> >
> > The UEFI emulator is anchored at the UEFI spec. That will incur lots of=
 work
> > due to various hardware support.  For example, to support TPM, the emul=
ator
> > should implement PCI/I2C bus protocol.
> >
> > But if the problem is confined to the original linux kernel boot protoc=
ol, it will be simple.
> > Only three things should be considered: the kernel image, the initrd an=
d the command line.
> > If we can get them in a security way, we can tackle the problem.
> >
> > The integrity of the file is ensured under the protection of the signat=
ure
> > envelope.  If the kexeced files are parsed in the user space, the envel=
opes are
> > opened and invalid.  So they should sink into the kernel space, be veri=
fied and
> > be manipulated there.  And to manipulate the various format file, we ne=
ed
> > bpf-program, which know their format.
> >
> > There are three parties in this solution
> > -1. The kexec-tools itself is protected by IMA, and it creates a bpf-ma=
p and
> > update UKI addon file names into the map. Later, the bpf-program will c=
all
> > bpf-helper to pad these files into initrd
> >
> > -2. The bpf-program is contained in a dedicated '.bpf' section in PE fi=
le. When
> > kexec_file_load a PE image, it extract the '.bpf' section and reflect i=
t to the
> > user space through procfs. And kexec-tools starts the program.  By this=
 way,
> > the bpf-program itself is free from tampering.
> >
> > The bpf-program completes two things:
> >       -1.parse the image format
> >       -2.call bpf kexec helpers to manipulate signed files
> >
> > -3. The bpf helpers. There will be three helpers introduced.
> > The first one for the data exchange between the bpf-program and the ker=
nel.
> > The second one for the decompressor.
> > The third one for the manipulation of the cpio
>
> I find this design very complicated. Especially I don't like that the
> bpf program is exported back to user space to be loaded separately.

I wish I could avoid the complexity, but unfortunately, I couldn't.
I'll explain everything later, all at once.


> This does not only requires us to protect kexec-tools by IMA but also
> all the tools and libraries that are involved in running kexec-tools

Yes, that is true. But this may not be so important since all files,
which are passed in by kexec-tools are protected by signature.

> (libc, ld, etc.). But even that will probably not be enough when you
> look at all the different ways user space programs can interact with
> each other and change each others behavior (see the xz-backdoor for

IIUC, xz-backdoor is not a proper example, which is tampered at the
source code level.

> example). So when we would probably need to protect all of user space
> if we want to use this design in a secure boot environment, which is
> out of scope for the feature.
>
> Alternatively, we would need to verify in the kernel that the bpf
> program loaded by the kexec-tools is identical to the one included in
> the kernel image. But then what's the point in exporting it in the
> first place? Especially as already today there is the
> kernel/bpf/syscall.c:kern_sys_bpf function that allows to run the
> bpf syscall from within the kernel (with some limitations, but it(
> allows to load a program).
>

Here, let me explain why I cannot avoid the complexity and how this
design ensures the integrity of the BPF program:

I'm not entirely sure, but the function kern_sys_bpf(int cmd, union
bpf_attr *attr, unsigned int size) requires a bpf_attr, which is
typically prepared by libbpf. If the BPF program is invoked directly
from the kernel, there must be some code to handle what libbpf
normally does. That would be quite complex.

On the other hand, the built-in BPF program is protected by the
signature of the UKI. When it is loaded by kexec-tools through the BPF
API, it still undergoes integrity checking (refer to
kernel/bpf/core.c: bpf_prog_calc_tag()). Based on this, I argue that
the IMA on kexec-tools is not as critical.

> All in all I think it is better to keep the current design, i.e.
> kexec-tools only makes one systemcall and the rest is done in the
> kernel.
>
As explained above, the main obstruction is to implement the libbpf
logic inside the kernel.

> In addition, while I agree that ideally we include the new feature
> into kexec_file_load, I think it's better to define a new system call
> for images containing bpf in the beginning. With that we have a blank
> slate we can mess with without the need to take care of keeping the old
> code working. Plus, it leaves us a fallback to load a dump kernel when
> we mess up. Once we have a working prototype and a better understanding
> on what is needed we can still merge it back into kexec_file_load.
>

A good suggestion, I will try it.

> > ***  Overview of the design in Pseudocode ***
> >
> >
> > ThreadA: kexec thread which invokes kexec_file_load
> > ThreadB: the dedicated thread in kexec-tools to load bpf-prog
> > ------
> > Diag 1. the interaction between bpf-prog loader and its executer
> >
> >
> > ThreadA                                               ThreadB
> >
> >                                               wait on eventfd_A
> >
> >
> > expose bpf-prog through procfs
> > & signal eventfd_A
> > & wait on eventfd_B
> >
> >                                               read the bpf-prog from pr=
ocfs
> >                                               & initialize the bpf and =
install it to the fentry
> >                                               & signal eventfd_B
> >                                               & wait on eventfd_A again
> >
> > fentry executes bpf-prog to parse image
> > & generate output for the next stop
> >
> >
> > -------------------
> > Diag 2. bpf-prog
> >
> > SEC("fentry/kexec_pe_parser_hook")
> > int BPF_PROG(pe_parser, struct kimage *image, ...)
> > {
> >
> >       buf =3D bpf_ringbuf_reserve(rb, size);
> >       buf_result =3D bpf_ringbuf_reserve(rb, res_sz);
> >       /* Ask kernel to copy the resource content to here */
> >       bpf_helper_carrier(resource_name, buf, size, in);
> >
> >       /* Parse the format laying on buf */
> >       ...
> >       /* call extra bpf-helpers */
> >       ...
> >
> >       /* Ask kernel to copy the resource content from here */
> >       bpf_helper_carrier(resource_name, buf_result, res_sz, out);
> >
> > }
> >
> > At present, bpf map functions provides the mechanism to exchange the da=
ta between the user space and bpf-prog.
> > But for bpf-prog and the kernel, there is no good choice. So I introduc=
e a bpf helper function
> >       bpf_helper_carrier(resource_name, buf, size, in)
> >
> > The above code implements the data exchange between the kernel and bpf-=
prog.
> > By this way, the data parsing process is not exposed to the user space =
any longer.
> >
> >
> >
> > extra bpf-helpers:
> >
> >       /* Decompress the compressed kernel image */
> >       bpf_helper_decompress(src, src_size, dst, dst_sz)
> >
> >       /*
> >        * Verify the signature of @addon_filename, padding it to initrd'=
s dir @dst_dir
> >        */
> >       bpf_helper_supplement_initrd(dst_dir, addon_filename)
>
> UKI addons can also append entries to the kernel command line. IMHO it
> will be easiest when we maintain the initrd and command line in the
> kernel, i.e. the syscall "prepopulates" the initrd and cmdline either
> from the UKI or what kexec-tools provides. The bpf program then only
> updates them. That's not ideal but it keeps the bpf program simple in
> the beginning so we (hopefully) don't run into the limitations bpf
> programs have. Once we have a working prototype we can still move
> functionality over to the bpf program.
>

Sorry, but I'm not sure whether I understand you clearly. Are you
suggesting to pass UKI add-ons through a new kexec syscall API?

> The way I see it this should work with three helper functions.
> One to read+verify a file and one each to append data to the initrd or
> command line.
>
Yes, there should be another helper to manipulate kernel cmdline addons.

> >       Note: Due to the UEFI environment (such as edk2) only providing b=
asic
> >         file operations for FAT filesystems, any UEFI-stub PE image (li=
ke systemd-stub)
> >         is restricted to these basic operation services.  As a result, =
the
> >         functionality of such bpf-kexec helpers is inherently limited.
>
> Is this limitation really necessary? The way I see it this is a
> limitation to keep the UEFI environment simple. But when we run kexec
> the kernel is fully booted. So we can make use of all the file systems
> included in the kernel.
>
Yes, as for the capability, we can utilize all file systems. My main
concern is the stability of the BPF helpers. I believe people are
reluctant to update them frequently.

Thanks,

Pingfan

> Thanks
> Philipp
>
> > *** Thoughts about the basic operation ***
> >
> > The basic operations have influence on the stability of bpf-kexec-helpe=
rs.
> >
> > The kexec_file_load faces three kinds of elements: linux-kernel, initrd=
 and cmdline.
> >
> > For the kernel, on arm64 or riscv, in order to get the bootable image f=
rom the compressed data,
> > there should be a bpf-helper function as a wrapper of __decompress()
> >
> > For initrd, systemd-sysext may require padding extra file into initrd
> >
> > For cmdline, it may require some string trim or conjoin.
> >
> > Overall, these user requirements are foreseeable and straightforward,
> > suggesting that bpf-kexec-helpers will likely remain stable without sig=
nificant
> > changes.
> >
> >
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: Jeremy Linton <jeremy.linton@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Simon Horman <horms@kernel.org>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Cc: Philipp Rudo <prudo@redhat.com>
> > Cc: Jan Hendrik Farr <kernel@jfarr.cc>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Pingfan Liu <piliu@redhat.com>
> > To: kexec@lists.infradead.org
> > To: bpf@vger.kernel.org
> >
>


