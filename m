Return-Path: <bpf+bounces-19101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EBA824CB1
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 03:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1329C285A70
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 02:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9352B1FBF;
	Fri,  5 Jan 2024 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brown.edu header.i=@brown.edu header.b="oxK+CU4z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DC21FAD
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brown.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brown.edu
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbe87cbc052so1073157276.2
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 18:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brown.edu; s=google; t=1704420115; x=1705024915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4lirGd5bZpUo1tvOIy+zyGMevvHIFchfVIby/9FZss=;
        b=oxK+CU4zmaQ8ndFtEn2XM/zfSu0Hy42W7b7OSt3XbntlTFY9dwtqGcxmHg5/FQ3Ewd
         x6Z1QvqqDVftGu6pqW304e+uRPvgEEdebnEJluaaxNuUAzdwJUT7KIfYwO+1Y5QYJjDO
         F4Jaw0XFP7HERTYY7MxP62TVnu8T88WwbeWH6QjO1GKLgoYZERSNo/IbhSu95y7/s0k/
         tGl+nv6q0RopX54VpkQsaDVFolgRF5k1r/j1QrRClMo3WoEnLWpfseony7LWKlGiWVYh
         qFa0lZYcnxj9O2jsM84Kt6NupCbhjrbimAyEFQ9nUgPrJ7C86i3kvoFKQ/AFlb7dBCt3
         QCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704420115; x=1705024915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4lirGd5bZpUo1tvOIy+zyGMevvHIFchfVIby/9FZss=;
        b=dQi7f/hjIH84i8Hm3czjAAauqKGkkguMStBb12zazmc8amD4xWzdvCbJc1tnLX19f0
         XwK+vsUuALCr09UVBxj/0TiMF7YA/RcM17a6rgjEDQP2yYHIdcfLLMjbJgAYTD5TpbM5
         tvOccHhaICRwZQtYPkvrLw+WhCwKSaco2Pr9I+1Mi/73NKjzhXBbPdWdbwi0gmugvh8D
         ZR4zuFyZz6aYmTjPmuSAKzcJFgz2g2vN7JPmeADQHTVh9uzhBcfSzW6PrNttTXcHqY+3
         ekfw0gf6xy99wm0PB+FMo/IIXtQbx8VFFlW9eXG+Hw9A5ceMoPUyjz5O0nZQFQhz48/z
         WCvg==
X-Gm-Message-State: AOJu0YycUsXV7Gc8QwajY9wDmSYHMEjirCRxC2S8LILugu7xYnCFJg8Z
	iyNG0EIxugOtbGr26Y0X+NfJYRG6KqiygAXRZBgjZr8wRMM03EVEgTFvbJhWiQ==
X-Google-Smtp-Source: AGHT+IEBQUQ7wDm86bYMKHcAQ/CxsTqf9eJ9WjdKVY2vvN7syGgHwQI2R5J40LRHPqXczrbJ4kKEA4c9LLHtdQrQs5k=
X-Received: by 2002:a5b:1cf:0:b0:dbe:a39e:d451 with SMTP id
 f15-20020a5b01cf000000b00dbea39ed451mr1417974ybp.1.1704420115173; Thu, 04 Jan
 2024 18:01:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYZPR03MB679243A8E626CC796CB7BDBDB461A@TYZPR03MB6792.apcprd03.prod.outlook.com>
 <CAKOkDnNAQSrWxsJBrcLV7ReaQkX_BHX+EAn69e0cpe9b=FAsUg@mail.gmail.com>
 <CAKOkDnPnNE=MNP-1_8=T9vw6Ox80OAJmKonzpDO4abW8Dz9JwA@mail.gmail.com>
 <SEZPR03MB67865F9167DABCA16AA6811BB4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <CAADnVQJCxFt2R=fbqx1T_03UioAsBO4UXYGh58kJaYHDpMHyxw@mail.gmail.com>
In-Reply-To: <CAADnVQJCxFt2R=fbqx1T_03UioAsBO4UXYGh58kJaYHDpMHyxw@mail.gmail.com>
From: "Jin, Di" <di_jin@brown.edu>
Date: Thu, 4 Jan 2024 21:01:44 -0500
Message-ID: <CAKOkDnPZ5SKYOQhE646Se5oYCi7Rc3ubUTnrE+-aXiViTsA1jQ@mail.gmail.com>
Subject: Re: [External] Fwd: BPF-NX+CFI is a good upstreaming candidate
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Maxwell Bland <mbland@motorola.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"v.atlidakis@gmail.com" <v.atlidakis@gmail.com>, "vpk@cs.brown.edu" <vpk@cs.brown.edu>, 
	Andrew Wheeler <awheeler@motorola.com>, =?UTF-8?B?U2FtbXkgQlMyIFF1ZSB8IOmYmeaWjOeUnw==?= <quebs2@motorola.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Alexei and the rest of the community,

I do want to make a note about the concept of the interpreter being
"less secure".

Firstly the interpreter is not contributing that much to the
exploitation of Spectre. While Google Project Zero did say without the
interpreter building the specific exploit they had for Spectre V2
seems "annoying", that is all there is to it, the security benefit of
removing the interpreter is more like an annoyance instead of a
roadblock. It is quite likely that automated tools can find gadgets
that can do the jobs without too much trouble, the only annoying bit
would be the attackers would have to find different gadgets for
differently built kernels.

Granted, removing any unused functionality can be an improvement for a
system's security, and the observation that the interpreter can be
removed without too much pain was quite interesting when the option
was introduced. But in this specific case, the security trade-off here
is a balancing act between two functionalities: JITed BPF and the
interpreter, since removing BPF altogether is probably not an option
in realistic terms. The JITed BPF has more than contributed its fair
share of assistance to various attacks[1-3], including the original
Spectre attacks[4]. So disabling JIT and keeping the interpreter in
place is, security-wise, an even better mitigation, if we had to
remove one of the two paths.

I would argue that keeping the interpreter, especially hardened with
defenses proposed in EPF, is at the very least a competitive option
for security. It enables system admins to disable JIT as
mitigation/prevention against potential risk from the JITed component
of BPF (which is now impossible), while still enjoying the security
enhancement provided by EPF defenses.

If I can have your blessing on the security trade-off, I can move
forward to try to adapt the patches for submission.

Regards,
Di

[1] Reshetova, Elena, Filippo Bonazzi, and N. Asokan. "Randomization
can=E2=80=99t stop BPF JIT spray." In Network and System Security: 11th
International Conference, NSS 2017, Helsinki, Finland, August 21=E2=80=9323=
,
2017, Proceedings 11, pp. 233-247. Springer International Publishing,
2017.
[2] Nelson, Luke, Jacob Van Geffen, Emina Torlak, and Xi Wang.
"Specification and verification in the field: Applying formal methods
to {BPF} just-in-time compilers in the Linux kernel." In 14th USENIX
Symposium on Operating Systems Design and Implementation (OSDI 20),
pp. 41-61. 2020.
[3] Kirzner, Ofek, and Adam Morrison. "An analysis of speculative type
confusion vulnerabilities in the wild." In 30th USENIX Security
Symposium (USENIX Security 21), pp. 2399-2416. 2021.
[4] Kocher, Paul, Jann Horn, Anders Fogh, Daniel Genkin, Daniel Gruss,
Werner Haas, Mike Hamburg et al. "Spectre attacks: Exploiting
speculative execution." Communications of the ACM 63, no. 7 (2020):
93-101.

