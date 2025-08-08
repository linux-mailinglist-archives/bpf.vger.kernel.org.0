Return-Path: <bpf+bounces-65249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D03B1E0BC
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 04:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700073B4ECB
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 02:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BD418A93C;
	Fri,  8 Aug 2025 02:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA93NFmt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF775129A78;
	Fri,  8 Aug 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754621586; cv=none; b=NDlsrafM4rizQmtj+DyohvEkPK2tP4+3f97dugDjj4zP5pkioOHepKimjHTw2UTYVp2KNvSJ2ZizjKwWbZNbQY5p1kggVmSMEQVsDvbq5DsfnM7WM3FNvfZFic17fjxXnc6swykLMtBWibgvM3bRAxEKDCpSCnbdflcFo5HELAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754621586; c=relaxed/simple;
	bh=Om8CSTilbI8kufHxxGHoxmuUmMcsJ0TXJ5MB04D+7R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5DW/xiInkcVN0oMfW/y5xwYDSW9HcWqeL7VaIFOJDVzfitINFri0aevOtVBUf5jvkB2GiN3aHmZPD5xoGUzswaKA0u3ZcAkuaBs3tCKrRqUlXvA7bHcJJqE2tCUCr7u/AtyRBsq+H2l/8WCKMo/kBmueXQPozu4L7bHe7fwlSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jA93NFmt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b783d851e6so1434349f8f.0;
        Thu, 07 Aug 2025 19:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754621583; x=1755226383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Om8CSTilbI8kufHxxGHoxmuUmMcsJ0TXJ5MB04D+7R8=;
        b=jA93NFmtlRMnbXjpfbrTtIJY4nqY9jhABAHcEUnryZTxa8lJ1FQcFLfeuM8X4LD/fT
         ygmQY2kULixj8L/5HJVEfkm0FqeWmwkEwv853Jgk1fOsJLpGZX62eqwfpt3cm8KOtUfe
         xywosxdthwjkAKmNQ1KRzarX9wspWdMe+iBXuhs4miq/SK1Zwrz/5cAP834mDhsKIUaN
         Z4vY8NeOsolMwR0o4pIpyMPaLgchp9aJsc7/mIB5G3Oe7zQhJ/Sh9oq4OeI7KCuWp0+/
         vuQ5rDDkEpQcjtAbFinL1NiKcrq95N6mFhH0G1w9fvtrxvEdFPb8/Q4dRofa+mutugrF
         A72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754621583; x=1755226383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Om8CSTilbI8kufHxxGHoxmuUmMcsJ0TXJ5MB04D+7R8=;
        b=WOzT+jYeXc+JfQrW3Gc958DEjxB/tF496ojF0/sqxJteCvuX01AnslyQdiWoYXbDRk
         huSsxHy8xMrbk17rL9ngnHB8gy5MJfuIQdWDLi5GuQ8y67yfkPR+fS7bNUnpccbGG75O
         pQiA2GsXrPHPNErFhYgjTFspqXXgzAg0TjZcPpaKsrLoaJvwkLFq/zc+/vs4S2zV1vn1
         3qJWEzmHrws15yc3m81a2x0I/8AVHyJUyAm9/YUtcPRl5UqzDLVP8/aLKsG+xmENFMUm
         Hot0AHcWnYvnayYykI3DFaV7wdv7uTmdT4CH/EJsg8dgOxd4lPUPmlW7+nhIGWtPzpIu
         PQQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJxD/9/3yFZO98zesPV5dxoZFLpgS2/jlV3SKdh0bL863IkP1/q0oIXlTpXoFoYVGkUEU=@vger.kernel.org, AJvYcCXTuWvLJj4TRKvEXI+lcuwGPBOnIWoPLGGeBKkkn4ii3qxOhwB268GNoJKhanbVMpC0jTfiFvyc/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGzcXB7OnttTR1Yu0sgVggyQsYSW1mqGSD6DCtQ6Wclv+wGuQo
	8CgH2U649VLUpU+DGuQtabr7iNGP5veTe1eu/EAFPQIed/3tPVslegf7SNLzkkhrt+W6Pak1P1L
	oK2+f9EjZHzy+EsNv4uKwylr1wse7YwY=
X-Gm-Gg: ASbGncvs5NviG+yAzxgoJpRLjG/LgkNqHVrZ4HZOlNVXWGrRLhjWZdbO3kItDlXVut1
	mZF5n4Q25knNYlE/5DHJXrZzeWbpbMUSZpLwPofl20CUThGD3vQ1bmW7LZ3Caj8XFH5dlCveXd5
	IvO91YJ0E32Zq2sJdXQxRpz0OOetDAEEhISgLnEN8YTqMITlqzFFBzlPtymnLCZabSeJmuqYUs5
	YsCzB/k8h+4HOWxFs8z85MYn8leDNpahfHkRQ2utcGUucA=
X-Google-Smtp-Source: AGHT+IEg2+MsOd+eMb2frAUqUmMaAXKh30q8kAuyzUXULIKUtqvbrwX9gD226J/AHKAIExa78gTfG4D16NEKLWu3mok=
X-Received: by 2002:a05:6000:4387:b0:3a4:f72a:b18a with SMTP id
 ffacd0b85a97d-3b900b52958mr940385f8f.26.1754621583036; Thu, 07 Aug 2025
 19:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807182538.136498-1-acme@kernel.org> <CAADnVQ+cvvHN9CunLP03yRFKz2YJirmF0j80-fZ0A-8aVVopPg@mail.gmail.com>
 <CA+JHD92DODDESCfwiiCs_ZQ5bGesK5NC+xe5EvONF5g+-Bg+9Q@mail.gmail.com>
In-Reply-To: <CA+JHD92DODDESCfwiiCs_ZQ5bGesK5NC+xe5EvONF5g+-Bg+9Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Aug 2025 19:52:51 -0700
X-Gm-Features: Ac12FXwJcqs8H4-a9nkNUtgZ7JdGP2Q7KmybBD2upZsfMWTkGhT5CjbhzJXvj0g
Message-ID: <CAADnVQLr=-E1isAGDH1+U9h4Dta7hgzi==9SnWpKpCWtHQxa5g@mail.gmail.com>
Subject: Re: [RFC 0/4] BTF archive with unmodified pahole+toolchain
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, 
	dwarves <dwarves@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, Nick Alcock <nick.alcock@oracle.com>, 
	Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 7:36=E2=80=AFPM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> On Thu, Aug 7, 2025, 11:09=E2=80=AFPM Alexei Starovoitov <alexei.starovoi=
tov@gmail.com> wrote:
>>
>> On Thu, Aug 7, 2025 at 11:25=E2=80=AFAM Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>> >
>> >
>> > This is complementary to today's series from Alan Maguire, as we can u=
se
>> > the one liner for the kernel build process to test his series without
>> > requiring installing a toolchain that generates BTF for each .o file
>> > that will result in vmlinux.
>> >
>> > Next steps on my side are to:
>> >
>> > 1. change pahole for when it receives --format_path=3Dbtf check if
>> > btf__is_archive(btf) is true, then just replace the current vmlinux .B=
TF
>> > contents with the raw data in this just loaded BTF, short circuiting
>> > the whole process.
>> >
>> > 2. the kernel build process should be changed to allow one to ask for
>> > just BTF, not DWARF, and if so, using the above method, strip the DWAR=
F
>> > info after using it to generate BTF.
>> >
>> > Then when compilers are producing BTF, we switch to that, falling back
>> > to the above method when a compiler is known to generate buggy BTF.
>> >
>> > And also to use in CIs, to compare the output generated by the various
>> > methods in the various components.
>> >
>> > 3. In 2 we can even use the same scheme we use for parallelizing DWARF
>> > loading when loading all the BTF archive members concatenated in vmlin=
ux
>> > to dedup them.
>>
>> Before you jump into 1,2,3 let's discuss the end goal.
>> I think the assumption here is that this btf-for-each-.o approach
>> is supposed to speed up the build, right ?
>>
>> pahole step on vmlinux is noticeable, but it's still a fraction
>> of three vmlinux linking steps.
>
>
> I'll need to try thunderbird on the smartphone to send from the smartphon=
e, having said that:
>
>
> I never looked at why we have those three linking steps, will try to educ=
ate myself about that.
>
>> How much are we realistically thinking to shave off of that pahole dedup=
 time?
>
>
> Difficult to say, but given this comment I made:
>
> "Also an observation: for distros the optimal way to produce BTF _and_ DW=
ARF seems to be the one we have now, don't bother generating .BTF for all .=
o, just generate DWARF and at the end generate BTF from it 8-)"
>
> I fear that most approaches to generate BTF for vmlinux by generating BTF=
 by the compiler or pahole for every .o will only make the total vmlinux ge=
neration for the common case (distros) slower, not faster.

Yes. My gut feel is the same.

> Be it the compiler or pahole from DWARF, generating BTF _in addition to D=
WARF_ for each .o will double the space for the things being represented, a=
s the major benefit from BTF is dedup, not per .o (it's more compact, but n=
ot by orders of magnitude as with dedup for the whole vmlinux).
>
> Option 3 may end up to be the best, i.e. generate BTF directly (compiler)=
 or from DWARF (pahole) and immediately add it using btf__add_btf() via som=
e BTF thread, _stripping_ it right away from the .o, to avoid doubling the =
disk space needed (DWARF+BTF per .o), and then, in the end, just dedup, hav=
ing DWARF (if asked, which 99% of distros will do) and BTF, again, most dis=
tros will want (except things like raspberry pi distros, sigh).
>
> The same technique, BTW, could be used to reduce the build disk space nee=
ded for DWARF, if we can live with completely stripped .o files (no BTF, no=
 DWARF) having it only (dedup'ed: BTF, or not: DWARF) after we harvest it f=
or use in the final vmlinux.

I see where you're going, but disk space is cheap and modern
build systems have fast drives. Spinning rust is a thing of the past.
The total size of intermediate objects doesn't matter much.
Stripping dwarf won't reduce .o by sizable amount, so I/O throughput
won't budge.

> But the changes in my series are so small that I think they merit conside=
ration even so.

Agree with that as well, but I'm just not easy about "BTF archives" :)
The name is too ambitious. Concatenated BTF sections is fine,
but let's not make a big deal out of it.

