Return-Path: <bpf+bounces-57836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F61EAB09AB
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 07:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4767AD519
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 05:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED10267F68;
	Fri,  9 May 2025 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDrlgzL7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C682C267B71;
	Fri,  9 May 2025 05:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746768101; cv=none; b=D7x/ooC49+WNkApW8Fh4spMerwiDOXS9eCfoQCjLL9j6q9hsXSjevniThqCZE06LZBNqE0yf058FNmPiW9vmyJBoMojFABW1ngsBQ8i5AmsCLMKsZNUpd9JFAk0px/roUkLu7cyDmBx5Ab2hoMRcJHutDuSlEOcf2tWjFQBZ/NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746768101; c=relaxed/simple;
	bh=XDQx+8VYOUEPIuOCdctljQaYABm4TqTedFKRdIDwZQM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plYhg/j/EBuksxH7RgXBRqSSG3AJvXp98bgAvYUTfrGh0b1AvpHBBerIBk9uaiGUwqoIl1pPZEHwjPTgHGbI8KOaNl0tabNYbFrOYlBSQb5ue0SKLgQ4IXxG9ciUS96WfkA871qJUtPbvNqvovAVaF7ldND9GoNWb1lszlh4oKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDrlgzL7; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so2714201b3a.0;
        Thu, 08 May 2025 22:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746768099; x=1747372899; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ARSX7//TY0Fs/M//egZhiAwhSvwSj71QYEmAXvKrqh0=;
        b=VDrlgzL7fU9WCxYZCN7IZxSMTnCUpXSFxI/zR7XE409ObaeXQOTgy8q+F1ZjSpSQaK
         GM4U0XPLMQaxXnQ6fTHBnQ/6h9JaUMiUcENSfAcM5IuQ0pFxZ8Vv7qfRaF+D40NmxFEF
         DASvswaxn0HfZsqHN+7o0QElfcHHGPT02j4FUq9ZmaGEL7tFI1VJNmlJdtKlW6trYqFm
         zNAjd3MwyAMHHKnPvB/UCPZ48OpzGYwlSbf5lG2hdFty6XKZA+pbZ0aPsouwJlewW/qR
         UluJ894Q88Z/mVNYJbzwhRnE+1Wk8WpKNx8EHQMb+0mZlYuCUq3ORImNLBmIgesqECo/
         1Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746768099; x=1747372899;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARSX7//TY0Fs/M//egZhiAwhSvwSj71QYEmAXvKrqh0=;
        b=ZiTeUOwJFA3NskGZMXMA35hqH8eBUhSAY8r0DQFePAnPu57Ipa45Anr5Er45d8x9Uy
         0M6VgFPsDmRmAabr/hBNdll3DfoNj5DbcaGQZpp5QdRH2i/wkZXSFtkG4BlBI9Q4Zhb8
         kbOkbFs0J1P/iNdth6EjCbhndQtmGM8AhVYe/EJZsZpA5d7t2JVO2dXIQuVEZFZszfc4
         bgcCj6E3V1td1tir0AFIfcTiaXIB7Eqnq2JO3KiuGUKA6QfJbtBYRace7kGQM5RI0F/d
         23fHVRkPEd2jmzit5xBNDxdWNcti5emMO1pvGYfJeQ0nZ5k/P59SMT5UxCQ4uqyjYW0w
         EC0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxWmPgbFMeWoDOCYCIIkYJaYo20KsMLakX8z2EkuXWGkecGPSZS2l6qaiKKXqybH+pPSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcRZaz8yTAGHo5DrSuJK7CH+B8SmE247RNpr8fS4zSxXIRox5+
	wn/DqdGL+4guwQaiCbAog/zljVT6JbXIcnaoT+xeRfueCQurBPME
X-Gm-Gg: ASbGncu6hZ+oJhMPl0bEJUhpb3k10nd3/J05UiqCVEx7ARzOnueQeP7sM0dJgl5HBRt
	JpXdMhDt3GUZyUkFXK3FwkeZjEryLc4wDnNCUEW5yUn13qgkQ6WYMdsyX4lx4ZMnvW9uGZwIFoc
	MnlyrBcZXHu4lNtQFW8Qbzyw9TZrBJj/pqkRgkyct0OJQZtpxan86MtpDzoBLqRAEsFhnOVGdob
	H2bS1lGTZ59i808Ut1krLEHuDfzBLsoXi8Fhlsf6agPwf3QS84Dg8rqdaHElyMI8d0IHFEIVk2l
	ChkCYFYHD+Wz3Evl6Eq0aK5VhY8/YDrlDSNa9NjabA80/m86Ymj+aKTy9GokXktw6Qv4qlDlRQY
	3eKbOWtk=
X-Google-Smtp-Source: AGHT+IFYAcf0T5s6HjYlj/QuNYl0jIoDTjdrzQsmCDNbYyXYiuXaBG99vttbUgOXq2qhMv73bv5R3Q==
X-Received: by 2002:a05:6a21:a4c1:b0:1fe:8f7c:c8e with SMTP id adf61e73a8af0-215ab637034mr2941836637.15.1746768098871;
        Thu, 08 May 2025 22:21:38 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a3c600sm949103b3a.134.2025.05.08.22.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 22:21:38 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Thu, 8 May 2025 22:21:35 -0700
To: Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH dwarves v2] dwarf_loader: Fix skipped encoding of
 function BTF on 32-bit systems
Message-ID: <aB2Q3ylln95YFTCD@kodidev-ubuntu>
References: <Z/+HZ3w2KmbK5OAi@kodidev-ubuntu>
 <20250502070318.1561924-1-tony.ambardar@gmail.com>
 <D9QOFW6WEIT0.2AJBVJINZRRBV@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9QOFW6WEIT0.2AJBVJINZRRBV@bootlin.com>

Hi Alexis,

On Thu, May 08, 2025 at 11:38:06AM +0200, Alexis Lothoré wrote:
> Hello,
> 
> On Fri May 2, 2025 at 9:03 AM CEST, Tony Ambardar wrote:
> > I encountered an issue building BTF kernels for 32-bit armhf, where many
> > functions are missing in BTF data:
> 
> [...]
> 
> > Fixes: a53c58158b76 ("dwarf_loader: Mark functions that do not use expected registers for params")
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> 
> I encountered some issues with pahole 1.30 when trying to generate BTF data
> for functions having some __int128 values ([1]), and have been redirected
> here by Tony. I gave a try to the patch below and confirm that it fixes my
> issue: BTF data is now properly generated for my target function, so:
> 
> Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> 

Glad that resolved your issue, and thank you for the extra testing data
point.

> While at it, to follow-up on Alan's request for more testing, I did the
> following:
> - build kernel and bpf selftests with pahole 1.30, extract BTF raw data
>   with bpftool
> - repeat with pahole 1.30 + Tony's patch
> - I build my kernel for arm64, it is based on bpf-next_base and I use a
>   defconfig very close to the one used in BPF CI (so based on
>   tools/testing/selftests/bpf/config*)
> 

Nice! I notice bootlin has worked on several BPF testing contributions,
and was wondering if your build is some new standard buildroot/yocto
config tailored for BPF testing, and what archs it might support? Reason
for asking is I have a large stack of WIP patches for enabling use of
test_progs across 64/32-bit archs and cross-compilation, and I'm keen to
see other examples of configs, root images, etc. (especially for 32-bit)
At the moment I'm targeting 32-bit armhf support to make progress..

> I observe the following when comparing the resulting BTF data with/without
> Tony's patch:
> - There is no difference on vmlinux BTF data
> - For bpf_testmod.ko, there is a slight shift in the first BTF ID (first ID
>   is 46 with pristine pahole, 47 with patched pahole), which in turns makes
>   a lot of noise in the diff, but the actual diff seems to be about two new
>   BTF entries related to my custom function now being properly detected
>   (BTF_KIND_FUNC and BTF_KIND_FUNC_PROTO)
> 

Right, I noticed the same skew and it does make checking equivalence more
complicated.

> Alexis
> 
> [1] https://lore.kernel.org/bpf/D9Q73OTLEOU4.LNAO9K4POETM@bootlin.com/
> 
> -- 
> Alexis Lothoré, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
Thanks again,
Tony

