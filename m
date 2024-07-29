Return-Path: <bpf+bounces-35945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E7193FFF5
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5695B1F22D07
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B087D18A92A;
	Mon, 29 Jul 2024 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs97CoVA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A77F484
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286703; cv=none; b=rgH6iEp5bzWCXjVuuicAs0ItLUf9OTI8TCUDQOLKT635fDPy2qrxEAI5wDqBY2LEizi8iqP5htEwMHx7HcQwKOc/7QXpbRO+orNst7I9/KikiYuYeZIDrDpzGG33pNp+U51DA01/HHohI9v8jlC2ndcQBDKB8wzqcGaRePBEfk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286703; c=relaxed/simple;
	bh=OPbPlXUZi8nGaG/J9ZqstdoAg1WNwfJMj+P9D3pHtEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDO26rRXpTz61KY4r0UCXe3KpV9T3DrbFI6oiJE8gwGKDD/yqTwsctXZx41V/rICRChfzaRX/scA+0D7TKTWAQFw3KGIIPHzYjxGCBo4b+1cpmAkV8Zc9VqpdxeWLPz/skZYXR6q9qpuSXjwkc5ZI+8jVmihO/Ku3SacDRJrcYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs97CoVA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb7cd6f5f2so2883068a91.2
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722286701; x=1722891501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9uSNgkqboHdYWPSPQXHmNVFn+KcANAci377u7Br/xE=;
        b=Zs97CoVAbS75fbK4qITcPLb+CjeHdDsyFN9KJeIFeZ4HvNPCAKY1tUweI8F23UHMb9
         RuIiwerrFExlnhMa09aXviWBUC0Cwps4hRQ2Bsa732zz1Z78jFOIE7j3d8VFO+dexGqk
         I24M5W/HXjlCL3gQ4o4G0xeqEcJDNuTn2vbi9MHAbUCxSd7KCp/UdxthbX+J6PJpN0++
         cQI0VWLp6fVRJy8Fgn9ACpIq87UHt5RqujXLNEX56nn863v5w5veQvkiAgBaWyqUz66s
         epROYJc/TOR0usVhd3rGq3Mk2xbMlmHAkAU4kOzRFaZu+s2KfxTzR1h6oBYFMI3KbHwP
         rezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286701; x=1722891501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9uSNgkqboHdYWPSPQXHmNVFn+KcANAci377u7Br/xE=;
        b=SMZZJFz60AsE8KlthfCbJf9ucOuf8P3bnjiRNJ7olBz6Rr0jjBUq37ezCmNQdCv2r7
         02FaVZ2Otmvf7Us/ESdhLwTI2bIxd7gH3m8Ci0d9WXKLQD8LtQ1kViMigX/5Qupk1Q/9
         bMmrk6N2kmdO4pTVh7QMrYrDLlu2UWo6d+bosgi7dfOG0VMJudzIfOvpPjKjjFR0x3ul
         57ApGPs4Xv/weDQN839A0Jk/oUOX+GjMoysrgNSJS9MjVCw0bOirFV3Nv1JT/dyIP45V
         orx0kowZ1CegRwfGaCIgYjWJzpGxcaTC5GayMtV/LcBcsu91Akxryk9bMrxto/nrfhjk
         WZ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgWff8momVzsNMLRjWBf1/1P5U7Y6/eitnuWT0pcUq6nBi/cyTXvT2QyXA/QsXaYBrXegcC995ejal6y4EU4hGYs8d
X-Gm-Message-State: AOJu0Yxooeb1lyhnbLh5dxPuPywkpcEmBhrRRkbfXsay43Fcs5JOWjWW
	Oi5PEj5Ow5OvmZ4PXAv+NCx7k9y+xBiKuLF70vEyqnKdd35YF8unndB5pdpAuiDv8ZQYd1LsEjD
	MZnfmRsuQ6AuEWSzNyY5lgB1pzpw=
X-Google-Smtp-Source: AGHT+IFNgxcYfmNm4/LshVlUWJcyZwD9RZ9iE+dRYmU4ESuvVF8+ld0CvY2shdTLiT1EGC9FVhAVzp/VN/pd7m1tnWQ=
X-Received: by 2002:a17:90b:fd0:b0:2cc:ff56:5be3 with SMTP id
 98e67ed59e1d1-2cf7e21687amr10067135a91.19.1722286700909; Mon, 29 Jul 2024
 13:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CY5PR21MB349314B6ECC4284EA3712FCDD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
 <7ab6fbc6-2f05-4bb1-9596-855f276ab997@linux.dev> <CY5PR21MB3493D67300A4005628E8CB8DD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
In-Reply-To: <CY5PR21MB3493D67300A4005628E8CB8DD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Jul 2024 13:58:09 -0700
Message-ID: <CAEf4BzZvMOdL+mL9NxxesyXO-xRCwkJYqQ+GXQVBssF3_jid=w@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: perf_event_output payload capture flags?
To: Michael Agun <danielagun@microsoft.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"bpf@ietf.org" <bpf@ietf.org>, "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 4:45=E2=80=AFPM Michael Agun <danielagun@microsoft.=
com> wrote:
>
> CC Dave
>
> Thank you.
>
> Due to Microsoft policies we avoid reading code with strong licensing (li=
ke GPL 2.0).

Linux UAPI headers are licensed as `GPL-2.0 WITH Linux-syscall-note`,
and see [0]. Will cite it in full below. Doesn't this mean that it's
fine to read UAPI definitions?

SPDX-Exception-Identifier: Linux-syscall-note
SPDX-URL: https://spdx.org/licenses/Linux-syscall-note.html
SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+,
LGPL-2.1, LGPL-2.1+, GPL-2.0-only, GPL-2.0-or-later
Usage-Guide:
  This exception is used together with one of the above SPDX-Licenses
  to mark user space API (uapi) header files so they can be included
  into non GPL compliant user space application code.
  To use this exception add it with the keyword WITH to one of the
  identifiers in the SPDX-Licenses tag:
    SPDX-License-Identifier: <SPDX-License> WITH Linux-syscall-note
License-Text:

   NOTE! This copyright does *not* cover user programs that use kernel
 services by normal system calls - this is merely considered normal use
 of the kernel, and does *not* fall under the heading of "derived work".
 Also note that the GPL below is copyrighted by the Free Software
 Foundation, but the instance of code that it refers to (the Linux
 kernel) is copyrighted by me and others who actually wrote it.

 Also note that the only valid version of the GPL as far as the kernel
 is concerned is _this_ particular version of the license (ie v2, not
 v2.2 or v3.x or whatever), unless explicitly otherwise stated.

            Linus Torvalds


  [0] https://github.com/torvalds/linux/blob/master/LICENSES/exceptions/Lin=
ux-syscall-note

>
> Is there some other documentation of the flags, or could you explain them=
 in words?
> Or is that the complete flags description (which is in other documentatio=
n) and I am misunderstanding the code below?
>
> https://github.com/cilium/cilium/blob/3fa44b59eef792e28f70b1fd23e3e17e426=
909f5/bpf/lib/dbg.h#L229
>
> It looks to me here like the capture length is being OR'd into the flags.
>
> Any insights would be appreciated.
>
> Thanks,
> Michael
>
> ________________________________________
> From: Yonghong Song <yonghong.song@linux.dev>
> Sent: Friday, July 26, 2024 9:58 AM
> To: Michael Agun <danielagun@microsoft.com>; bpf@vger.kernel.org <bpf@vge=
r.kernel.org>; bpf@ietf.org <bpf@ietf.org>
> Subject: [EXTERNAL] Re: perf_event_output payload capture flags?
>
> [You don't often get email from yonghong.song@linux.dev. Learn why this i=
s important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On 7/25/24 6:42 PM, Michael Agun wrote:
> > Are the perf_event_output flags (and what the event blob looks like) do=
cumented? Especially for the program type specific perf_event_output functi=
ons.
>
> The documentation is in uapi/linux/bpf.h header.
>
> https://github.com/torvalds/linux/blob/master/include/uapi/linux/bpf.h#L2=
353-L2397
>
>   *         The *flags* are used to indicate the index in *map* for which
>   *         the value must be put, masked with **BPF_F_INDEX_MASK**.
>   *         Alternatively, *flags* can be set to **BPF_F_CURRENT_CPU**
>   *         to indicate that the index of the current CPU core should be
>   *         used.
>
> >
> > I've seen notes in (cilium) code passing payload lengths in the flags, =
and am specifically interested in how the event blob is constructed for per=
f events with payload capture.
>
> Could you share more details about 'passing payload lengths in the flags'=
?
> AFAIK, networking bpf_perf_event_output() actually utilizes bpf_event_out=
put_data(),
> in which 'flags' semantics has the same meaning as the above.
>
> >
> >
> > Thanks,
> > Michael
>

