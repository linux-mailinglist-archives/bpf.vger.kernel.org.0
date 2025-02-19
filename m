Return-Path: <bpf+bounces-51969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB326A3C4F1
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 17:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515753B5244
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557BB1FDE11;
	Wed, 19 Feb 2025 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCxX2mpy"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888651F417A
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982294; cv=none; b=PwtRF14V2+HaEcI0AI/4Smub7dnC8rhvIVrl8QTzc1VI8VagQhZhbkNAQIjp3X9UY9AAJit88+BIqiy6NkhJhmp0yawzEIN01ZUX3g2n74Ezgx6HmsNag4MHW1nnP6fgP32kRzgjgMATHqd31XAPzld6ztZ4V7eD6aNNUeg7Xy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982294; c=relaxed/simple;
	bh=WcM1bT6GVc4YZyUFGJk03A9kom2jFjymXkY6It/76Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adPAngSAy5acbHwQCPSISyiVGayIA1+vNNx1AXnsHYiI5azXpFV9xbQ+Spsj5m/ZcqfSrwQTAOqaao8Fi2P6QW0NxQI/C24ZmygJcyzYG+4NORq2SHhsbik1Fn6eYnVSNIsdam/7zBwo5mNUf5YGSIR+Bi1pyKSt6XMf0QFzr6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCxX2mpy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739982291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dak24GPrRSQ3RI7wsvf9bZbacjZtLKK09oCw1Vvw57A=;
	b=cCxX2mpyfFLr6drZYee/A+v713KPdPcAnjNXInQtsQ7kuU5jKUM8h3CMoniPilKAaeQpeL
	S0oMWLgobBP3pUEBEdB5OTJ+a1U8c1hjKN6Fj9M8JX0BmvfpB1RX16olppGedxqOIRGlKS
	BehN8TdLbDQztS8Ug3yMbLj1w4MOpdo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-SyWQvucHMjWWkMEFCNoMNQ-1; Wed,
 19 Feb 2025 11:24:49 -0500
X-MC-Unique: SyWQvucHMjWWkMEFCNoMNQ-1
X-Mimecast-MFC-AGG-ID: SyWQvucHMjWWkMEFCNoMNQ_1739982287
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A5C71903085;
	Wed, 19 Feb 2025 16:24:46 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.44.33.84])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 686C8190C54A;
	Wed, 19 Feb 2025 16:24:36 +0000 (UTC)
Date: Wed, 19 Feb 2025 17:24:32 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, bpf@vger.kernel.org, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Jeremy Linton <jeremy.linton@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Simon Horman <horms@kernel.org>, Gerd
 Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Jan
 Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young
 <dyoung@redhat.com>, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [RFC] kexec: Use bpf to allow kexec to load PE format boot
 image
Message-ID: <20250219172432.71f2db2e@rotkaeppchen>
In-Reply-To: <CAF+s44Tw240R8cG4DKr6y_=aiu634ifMZma-FGkDuoEfoNnUtQ@mail.gmail.com>
References: <20250114012831.4883-1-piliu@redhat.com>
	<20250131184621.12e8e94d@rotkaeppchen>
	<CAF+s44Tw240R8cG4DKr6y_=aiu634ifMZma-FGkDuoEfoNnUtQ@mail.gmail.com>
Organization: Red Hat inc.
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Pingfan,

sorry for the late reply.

On Thu, 6 Feb 2025 14:03:40 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> Hi Philipp,
>=20
> Thanks for your feedback. Please see my answers below.
>=20
> I'm also reaching out to the BPF maintainers with two concerns: how to
> ensure the integrity of BPF programs and whether introducing some
> additional BPF helpers for the kexec subsystem would be acceptable.
> Those helpers are used to exchange the data between BPF and the kexec
> kernel part.
>=20
>=20
> On Sat, Feb 1, 2025 at 1:46=E2=80=AFAM Philipp Rudo <prudo@redhat.com> wr=
ote:
> >
> > Hi Pingfan,
> >
> > thanks for sharing your thoughts. Please see my comments below.
> >
> > On Tue, 14 Jan 2025 09:28:25 +0800
> > Pingfan Liu <piliu@redhat.com> wrote:
> > =20
> > > Nowadays UEFI PE bootable image is more and more popular on the distr=
ibution.
> > > But it is still an open issue to load that kind of image by kexec wit=
h IMA enabled
> > >
> > > *** A brief review of the history ***
> > > There are two categatories methods to handle this issue.
> > >   -1. UEFI service emulator for UEFI stub
> > >   -2. PE format parser
> > >
> > > For the first one, I have tried a purgatory-style emulator [1]. But it
> > > confronts the hardware scaling trouble.  For the second one, there ar=
e two
> > > choices, one is to implement it inside the kernel, the other is insid=
e the user
> > > space.  Both zboot-format [2] and UKI-format [3] parsers are rejected=
 due to
> > > the concern that the variant format parsers will inflate the kernel c=
ode.  And
> > > finally, we have these kinds of parsers in the user space 'kexec-tool=
s'.
> > >
> > >
> > > From the beginning, it has been perceived that the user space parser =
can not
> > > satisfy the requirement of security-boot without an extra embeded sig=
nature.
> > > This issue was suspended at that time.
> > >
> > > But now, more and more users expect the security feature and want the
> > > kexec_file_load to guarantee it by IMA.  I tried to fix that issue by=
 the extra
> > > embeded signature method. But it is also disliked.
> > >
> > > Enlighted by Philipp suggestion about implementing systemd-stub in bp=
f opcode in the discussion to [1],
> > > I turn to the bpf and hope that parsers in bpf-program can resolve th=
is issue.
> > >
> > > [1]: https://lore.kernel.org/lkml/20240819145417.23367-1-piliu@redhat=
.com/T/
> > > [2]: https://lore.kernel.org/kexec/20230306030305.15595-1-kernelfans@=
gmail.com/
> > > [3]: https://lore.kernel.org/lkml/20230911052535.335770-1-kernel@jfar=
r.cc/
> > > [4]: https://lore.kernel.org/linux-arm-kernel/20230921133703.39042-2-=
kernelfans@gmail.com/T/
> > >
> > >
> > >
> > >
> > > *** Reflect the problem and a new proposal ***
> > >
> > > The UEFI emulator is anchored at the UEFI spec. That will incur lots =
of work
> > > due to various hardware support.  For example, to support TPM, the em=
ulator
> > > should implement PCI/I2C bus protocol.
> > >
> > > But if the problem is confined to the original linux kernel boot prot=
ocol, it will be simple.
> > > Only three things should be considered: the kernel image, the initrd =
and the command line.
> > > If we can get them in a security way, we can tackle the problem.
> > >
> > > The integrity of the file is ensured under the protection of the sign=
ature
> > > envelope.  If the kexeced files are parsed in the user space, the env=
elopes are
> > > opened and invalid.  So they should sink into the kernel space, be ve=
rified and
> > > be manipulated there.  And to manipulate the various format file, we =
need
> > > bpf-program, which know their format.
> > >
> > > There are three parties in this solution
> > > -1. The kexec-tools itself is protected by IMA, and it creates a bpf-=
map and
> > > update UKI addon file names into the map. Later, the bpf-program will=
 call
> > > bpf-helper to pad these files into initrd
> > >
> > > -2. The bpf-program is contained in a dedicated '.bpf' section in PE =
file. When
> > > kexec_file_load a PE image, it extract the '.bpf' section and reflect=
 it to the
> > > user space through procfs. And kexec-tools starts the program.  By th=
is way,
> > > the bpf-program itself is free from tampering.
> > >
> > > The bpf-program completes two things:
> > >       -1.parse the image format
> > >       -2.call bpf kexec helpers to manipulate signed files
> > >
> > > -3. The bpf helpers. There will be three helpers introduced.
> > > The first one for the data exchange between the bpf-program and the k=
ernel.
> > > The second one for the decompressor.
> > > The third one for the manipulation of the cpio =20
> >
> > I find this design very complicated. Especially I don't like that the
> > bpf program is exported back to user space to be loaded separately. =20
>=20
> I wish I could avoid the complexity, but unfortunately, I couldn't.
> I'll explain everything later, all at once.
>=20
>=20
> > This does not only requires us to protect kexec-tools by IMA but also
> > all the tools and libraries that are involved in running kexec-tools =20
>=20
> Yes, that is true. But this may not be so important since all files,
> which are passed in by kexec-tools are protected by signature.

True, but that only means that the files are protected when read from
disk. But the bpf program will change/patch those files. Take zBoot for
example. The bpf program will parse the image, decompress it and, pass
the decompressed image back to kexec. For kexec there is no way to
verify if the decompressed image is genuine. So a malicious bpf program
could inject code into the image without kexec noticing. That's why we
need to make sure that the bpf program handling the image is actually
the one that is parsed from the image.

> > (libc, ld, etc.). But even that will probably not be enough when you
> > look at all the different ways user space programs can interact with
> > each other and change each others behavior (see the xz-backdoor for =20
>=20
> IIUC, xz-backdoor is not a proper example, which is tampered at the
> source code level.

I disagree, IMHO the xz-backdoor is a good example here. But I should
have explained it better. You are right, that the malicious code was
added to the xz sources. But xz was only the vehicle to ship the
malicious code. The actual target of it was ssh. What makes it worse is
that there is no dependency of ssh to xz. The attack only worked because
systemd depended on xz and loaded the library before the sshd was
started. Similar attacks could also target for the kexec-tools and
inject a malicious bpf program in your design.

> > example). So when we would probably need to protect all of user space
> > if we want to use this design in a secure boot environment, which is
> > out of scope for the feature.
> >
> > Alternatively, we would need to verify in the kernel that the bpf
> > program loaded by the kexec-tools is identical to the one included in
> > the kernel image. But then what's the point in exporting it in the
> > first place? Especially as already today there is the
> > kernel/bpf/syscall.c:kern_sys_bpf function that allows to run the
> > bpf syscall from within the kernel (with some limitations, but it(
> > allows to load a program).
> > =20
>=20
> Here, let me explain why I cannot avoid the complexity and how this
> design ensures the integrity of the BPF program:
>=20
> I'm not entirely sure, but the function kern_sys_bpf(int cmd, union
> bpf_attr *attr, unsigned int size) requires a bpf_attr, which is
> typically prepared by libbpf. If the BPF program is invoked directly
> from the kernel, there must be some code to handle what libbpf
> normally does. That would be quite complex.

Yes, that's unfortunately true. But we will only need to support a
small subset of the functionality from libbpf. So the complexity should
(hopefully) be manageable. At least when you compare it with the
complexity securing the user space kexec-tools would have.=20

> On the other hand, the built-in BPF program is protected by the
> signature of the UKI. When it is loaded by kexec-tools through the BPF
> API, it still undergoes integrity checking (refer to
> kernel/bpf/core.c: bpf_prog_calc_tag()). Based on this, I argue that
> the IMA on kexec-tools is not as critical.

Yes, the contained bpf program is protected. But as explained above the
problem is that we cannot be sure that the bpf program that is loaded
by kexec-tools is the one contained in the image. And the bpf verifier
won't help here either as it only guarantees that the program doesn't
harm the currently running kernel. But it still could harm the kernel
that is being loaded...

In addition I don't think that the prog->tag will help here. IIUC it is
used to give each program a unique id but not to protect against
loading non-desired programs. And I don't think it would make sense to
use it this way. Especially as the sha1 hash used for the tag is no
longer considered secure.

> > All in all I think it is better to keep the current design, i.e.
> > kexec-tools only makes one systemcall and the rest is done in the
> > kernel.
> > =20
> As explained above, the main obstruction is to implement the libbpf
> logic inside the kernel.

I can fully understand that. But as described above I believe it is the
easier and better solution. Especially when we only implement the
subset that is needed for kexec to work.

> > In addition, while I agree that ideally we include the new feature
> > into kexec_file_load, I think it's better to define a new system call
> > for images containing bpf in the beginning. With that we have a blank
> > slate we can mess with without the need to take care of keeping the old
> > code working. Plus, it leaves us a fallback to load a dump kernel when
> > we mess up. Once we have a working prototype and a better understanding
> > on what is needed we can still merge it back into kexec_file_load.
> > =20
>=20
> A good suggestion, I will try it.
>=20
> > > ***  Overview of the design in Pseudocode ***
> > >
> > >
> > > ThreadA: kexec thread which invokes kexec_file_load
> > > ThreadB: the dedicated thread in kexec-tools to load bpf-prog
> > > ------
> > > Diag 1. the interaction between bpf-prog loader and its executer
> > >
> > >
> > > ThreadA                                               ThreadB
> > >
> > >                                               wait on eventfd_A
> > >
> > >
> > > expose bpf-prog through procfs
> > > & signal eventfd_A
> > > & wait on eventfd_B
> > >
> > >                                               read the bpf-prog from =
procfs
> > >                                               & initialize the bpf an=
d install it to the fentry
> > >                                               & signal eventfd_B
> > >                                               & wait on eventfd_A aga=
in
> > >
> > > fentry executes bpf-prog to parse image
> > > & generate output for the next stop
> > >
> > >
> > > -------------------
> > > Diag 2. bpf-prog
> > >
> > > SEC("fentry/kexec_pe_parser_hook")
> > > int BPF_PROG(pe_parser, struct kimage *image, ...)
> > > {
> > >
> > >       buf =3D bpf_ringbuf_reserve(rb, size);
> > >       buf_result =3D bpf_ringbuf_reserve(rb, res_sz);
> > >       /* Ask kernel to copy the resource content to here */
> > >       bpf_helper_carrier(resource_name, buf, size, in);
> > >
> > >       /* Parse the format laying on buf */
> > >       ...
> > >       /* call extra bpf-helpers */
> > >       ...
> > >
> > >       /* Ask kernel to copy the resource content from here */
> > >       bpf_helper_carrier(resource_name, buf_result, res_sz, out);
> > >
> > > }
> > >
> > > At present, bpf map functions provides the mechanism to exchange the =
data between the user space and bpf-prog.
> > > But for bpf-prog and the kernel, there is no good choice. So I introd=
uce a bpf helper function
> > >       bpf_helper_carrier(resource_name, buf, size, in)
> > >
> > > The above code implements the data exchange between the kernel and bp=
f-prog.
> > > By this way, the data parsing process is not exposed to the user spac=
e any longer.
> > >
> > >
> > >
> > > extra bpf-helpers:
> > >
> > >       /* Decompress the compressed kernel image */
> > >       bpf_helper_decompress(src, src_size, dst, dst_sz)
> > >
> > >       /*
> > >        * Verify the signature of @addon_filename, padding it to initr=
d's dir @dst_dir
> > >        */
> > >       bpf_helper_supplement_initrd(dst_dir, addon_filename) =20
> >
> > UKI addons can also append entries to the kernel command line. IMHO it
> > will be easiest when we maintain the initrd and command line in the
> > kernel, i.e. the syscall "prepopulates" the initrd and cmdline either
> > from the UKI or what kexec-tools provides. The bpf program then only
> > updates them. That's not ideal but it keeps the bpf program simple in
> > the beginning so we (hopefully) don't run into the limitations bpf
> > programs have. Once we have a working prototype we can still move
> > functionality over to the bpf program.
> > =20
>=20
> Sorry, but I'm not sure whether I understand you clearly. Are you
> suggesting to pass UKI add-ons through a new kexec syscall API?

Yes, that's my idea. IMHO the "ideal" design should look something like
this

1. user space prepares the required data (e.g. kernel command line,
   which initrd/addons to use etc.) into a private data structure, e.g.
   a bpf_map.
2. user space calls kexec and passes the file descriptor for the image
   and the "private data".
3. kexec verifies the image and parses the bpf program from it
4. kexec loads and runs the bpf program passing the private data to it.
5. the bpf program does its job and returns the prepared image, initrd
   and, kernel cmdline back to kexec.
6. kexec then simply continues with what it already does today.

What I like about this design is that the kernel doesn't need to
know the exact structure of the "private data". It's something user
space and the stub need to agree on and thus can be different for each
image/stub. That gives a lot of flexibility for future changes.
In a way it's a step back to the legacy kexec_load. With the difference
that the image isn't prepared in user space but by a bpf program that
is protected by the image signature and thus works with secureboot.

The downside is that the bpf program would be quite complex. That's why
I believe its better to start with an approach where kexec implements a
big portion of the needed functionality. Once that is working we can
move the functionality over to the bpf program piece by piece and see
if/where we run into problems with the limitations of bpf programs.

> > The way I see it this should work with three helper functions.
> > One to read+verify a file and one each to append data to the initrd or
> > command line.
> > =20
> Yes, there should be another helper to manipulate kernel cmdline addons.
>=20
> > >       Note: Due to the UEFI environment (such as edk2) only providing=
 basic
> > >         file operations for FAT filesystems, any UEFI-stub PE image (=
like systemd-stub)
> > >         is restricted to these basic operation services.  As a result=
, the
> > >         functionality of such bpf-kexec helpers is inherently limited=
. =20
> >
> > Is this limitation really necessary? The way I see it this is a
> > limitation to keep the UEFI environment simple. But when we run kexec
> > the kernel is fully booted. So we can make use of all the file systems
> > included in the kernel.
> > =20
> Yes, as for the capability, we can utilize all file systems. My main
> concern is the stability of the BPF helpers. I believe people are
> reluctant to update them frequently.

Yeah, bpf-helpers need to be stable. But is there a reason not to add a
bpf-helper that operates on file descriptors? kexec_file_load uses them
and is part of the uapi. So it has the same (if not higher)
requirement for stability.

Thanks
Philipp

> Thanks,
>=20
> Pingfan
>=20
> > Thanks
> > Philipp
> > =20
> > > *** Thoughts about the basic operation ***
> > >
> > > The basic operations have influence on the stability of bpf-kexec-hel=
pers.
> > >
> > > The kexec_file_load faces three kinds of elements: linux-kernel, init=
rd and cmdline.
> > >
> > > For the kernel, on arm64 or riscv, in order to get the bootable image=
 from the compressed data,
> > > there should be a bpf-helper function as a wrapper of __decompress()
> > >
> > > For initrd, systemd-sysext may require padding extra file into initrd
> > >
> > > For cmdline, it may require some string trim or conjoin.
> > >
> > > Overall, these user requirements are foreseeable and straightforward,
> > > suggesting that bpf-kexec-helpers will likely remain stable without s=
ignificant
> > > changes.
> > >
> > >
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > Cc: John Fastabend <john.fastabend@gmail.com>
> > > Cc: Jeremy Linton <jeremy.linton@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Simon Horman <horms@kernel.org>
> > > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > Cc: Philipp Rudo <prudo@redhat.com>
> > > Cc: Jan Hendrik Farr <kernel@jfarr.cc>
> > > Cc: Baoquan He <bhe@redhat.com>
> > > Cc: Dave Young <dyoung@redhat.com>
> > > Cc: Eric Biederman <ebiederm@xmission.com>
> > > Cc: Pingfan Liu <piliu@redhat.com>
> > > To: kexec@lists.infradead.org
> > > To: bpf@vger.kernel.org
> > > =20
> > =20
>=20


