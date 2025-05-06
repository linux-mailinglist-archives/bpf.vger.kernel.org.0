Return-Path: <bpf+bounces-57464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77766AAB882
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12B11746A1
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDB0286D4E;
	Tue,  6 May 2025 03:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsoh4J+9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A94B242D6D
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746491887; cv=none; b=l3K+iIVB+hm7fUnXC52vgWm86e0an9ZFamncjTv0MUZe3Iy38mJ7mwtq5oaVoECjpaT+ouUqTVn0xQ6oQfzVXg0b2L6mlDWnkW2UAUfr9hIYYnDJjfOd3R2MOxIn4jziVgpifMLgWhzipiOf7UoBr5jtaWFgq0xcgNXcVBcWGZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746491887; c=relaxed/simple;
	bh=3Thda7S7fTrK58T1VG3G41HE8TXjtD6eOvBZWs1UCRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8uchO/n4tdj7ogcK7SAr6hT/xPfBx49dKPZjNcATGdy/Qn2YCx94dieMhegnrdjamiJm2K84eIRcXdA8kcgHWAtbIiapCv959B33x/8fxQlFuwvIExALawDoxkvOZ/9Wg/Y/A8zIzr7n5tv+vxnp+e1bQppd7aGDWOtWBCEe5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsoh4J+9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746491883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Thda7S7fTrK58T1VG3G41HE8TXjtD6eOvBZWs1UCRo=;
	b=bsoh4J+9UWmEoBZtIBWq15xSj7aO3d8r06w7YiTIDaVdFadaZZynEeOBgfp4smbS4yu3ZA
	oSj3+XoGvUQwxKKAO+ddRoWSWIpKs63qurdFi7Gok+hRbkKXv6ewkZ2rLaDHsnZrBJxORA
	CnB5QZxOeIZdSU4aT1bUIRpE3KSYiaE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-pyDyRX6gPv64ET2qbB0KkQ-1; Mon, 05 May 2025 20:38:02 -0400
X-MC-Unique: pyDyRX6gPv64ET2qbB0KkQ-1
X-Mimecast-MFC-AGG-ID: pyDyRX6gPv64ET2qbB0KkQ_1746491882
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso4466998a91.2
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 17:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746491881; x=1747096681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Thda7S7fTrK58T1VG3G41HE8TXjtD6eOvBZWs1UCRo=;
        b=q0jPzhnbiL07FdkUpbZnG5CJKWuctNM2UBuKZlHCbGPLEtS7dUUvSPVEbLeaV5iwvV
         z+PE5+BEw6UhKbWhQbzMVRMEyxVdJZwG/iIUF2QwSb4SFjFisbuG3X0YXvftR8ZK6cnH
         S8a6O2pK1ZB6TFiYHfhTqF91KY3fR37+fuLCiJvqvy1gDKTwefFmbQL8Kf/05DhFhbkT
         7yXwXL8HMLjirMT+Coljd3bDe0ldbVmYSvRHvUtktGgvhexv1BlD6tfwXZNT2lWD+6xg
         rrdVeW/nLq4GObOSRZ1So1v9aE2OucXqAaYUQMxYI6PS9ZL2k+kFGVBSpPRPjkWNGmSl
         rdpA==
X-Gm-Message-State: AOJu0Ywg/mlTTrQlBecyt22elQG0UIL+Nb3vGaCtDggIbhRl9I+jbkiR
	E4QMhTlfl+lqntMLk/qKsK02dIyVCbpvGynSHXIMNf9wSrMeoU7DoRzDEuEYu759xQw0mOySFJk
	v0D0hZOnwGnsQ98Oa2Rzxr4y9y9PeoGc3SOrlds5ftarYsr+ZCbwYfcW921p8YvT6WOHjp7Y68x
	+FiCtRS+hj+IU5nFKYg1sGH/Is
X-Gm-Gg: ASbGnct5l3mcI7SX6/lm5ZrkEyebkd50u4v4bnUM7Y0SW2vcwarSrlgleagm1m951L+
	7d9EuPjA6myl6iArIJxmePLLuFkdKCOdDCw2hVBu2hUgcaX5YjMXSkFUx6w3kI6Qd0eGDqw==
X-Received: by 2002:a17:90a:e706:b0:306:b78a:e22d with SMTP id 98e67ed59e1d1-30a619a1979mr13444667a91.20.1746491881623;
        Mon, 05 May 2025 17:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq92lKdPDOjXTASCfCpZmgjp6GAkt6aAzy0xoeRkNlGPRkJ1vsPpEtKqMuRudM0xPVKmHs5+Hmx/dzYXboDxY=
X-Received: by 2002:a17:90a:e706:b0:306:b78a:e22d with SMTP id
 98e67ed59e1d1-30a619a1979mr13444646a91.20.1746491881257; Mon, 05 May 2025
 17:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429041214.13291-1-piliu@redhat.com> <20250429041214.13291-5-piliu@redhat.com>
 <CAADnVQKTSubuisSBap_J=tgO15fCdtwF-NDY_1HLP_m6o28mhw@mail.gmail.com>
 <CAF+s44QM55AtGyquKvj0XAzZAjOii7VJYWsGD50iK3+r6GZSmg@mail.gmail.com> <CAADnVQKKr7C+eRin=efg5umLumghGfYJst2MwDwpB5bEtt4rSA@mail.gmail.com>
In-Reply-To: <CAADnVQKKr7C+eRin=efg5umLumghGfYJst2MwDwpB5bEtt4rSA@mail.gmail.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 6 May 2025 08:37:50 +0800
X-Gm-Features: ATxdqUFuTVAhoinefB-V1imhTA7ZCVA5NjxlNSYorcyBkyCWXUw-XhLHlUTVcvc
Message-ID: <CAF+s44RC4UfSwckLR6tHJo=Owv8jvaBp-wN3PRGbYC3G3EoHYg@mail.gmail.com>
Subject: Re: [RFCv2 4/7] bpf/kexec: Introduce three bpf kfunc for kexec
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kexec@lists.infradead.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

Sorry to reply late since I just got back from holiday.

On Thu, May 1, 2025 at 12:16=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Apr 30, 2025 at 3:47=E2=80=AFAM Pingfan Liu <piliu@redhat.com> wr=
ote:
> >
> > On Wed, Apr 30, 2025 at 8:04=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
[...]

> >
> > Thanks for your suggestion. I originally considered using these kfuncs
> > only in kexec context (Later, introducing a dedicated BPF_PROG_TYPE
> > for kexec).
>
> We do not add new prog types anymore.
> They're frozen just like the list of helpers.
>

Got it.

> > They are placed under a lock so that a malice attack can
> > not exhaust the memory through repeatedly calling to the decompress
> > kfunc.
>
> attack? This is all root only anyway and all memory is counted
> towards memcg.
> Make sure to use GFP_KERNEL_ACCOUNT and something similar
> to bpf_map_get_memcg.
>

Your clarification makes sense. I will follow that guide.

> > To generalize these kfunc, I think I can add some boundary control of
> > the memory usage to prevent such attacks.
>
> Don't reinvent the wheel. memcg is the mechanism.
>

Sure. Thanks for your insight. It is helpful.

Best Regards,

Pingfan

> > > They also must be KF_SLEEPABLE.
> > > Please test your patches with all kernel debugs enabled.
> > > Otherwise you would have seen all these "sleeping while atomic"
> > > issues yourself.
> > >
> >
> > See, I will have all these debug options for the V3 test.
> >
> > Appreciate your insight.
> >
> > Regards,
> >
> > Pingfan
> >
>


