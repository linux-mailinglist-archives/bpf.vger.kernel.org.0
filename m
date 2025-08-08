Return-Path: <bpf+bounces-65278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8825B1EE5D
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 20:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90861C204CB
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 18:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7823218EBF;
	Fri,  8 Aug 2025 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCDYOHAa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E7521E0AF;
	Fri,  8 Aug 2025 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754677699; cv=none; b=jeB1qWC8XUWdmA/CdV6u+zCgOQNWBj88oX0M7Rgec7XxryFEv3w4x1VdxsX1muLWrfAtzhqECUW1ZfDQfqhJ87OxNg+4H/B/0RVcQrRw/H4nikd4aSktOhgKTrx+xSf+zUOxQPSG1UTl9lk18eS/XYEbqpK4kAeEVaRqXnyxRso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754677699; c=relaxed/simple;
	bh=IU/5ZcYtXMbWk4ywHw4XgakQiLLgS8g9FlS5re02SXc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NGO4MMLyQ+LvdQtZwYgrzEQqgrV/Akn27z80xuy9pIwkhZCW9MNvvqUM9CcMDxlkr2/URjzWJumG4sVZLK+JNCISg9FO/kUXHNzol5h+j9bFeBL0kK8OyyhAC3AP0NRM5rQu80z6PbiQa4NCT7GTmvGQ7c+Yv9Q0kvlKJjvKdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCDYOHAa; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b429b2470b7so1358402a12.3;
        Fri, 08 Aug 2025 11:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754677697; x=1755282497; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5HSh4b6bYfxkbXoMTmNogaldVZD/3Anv8CmkH0YyIYI=;
        b=kCDYOHAapLRq602rk8KJIB5FGTA5eSspMzOO1zYAIf8QXAcCCSixxsEfPeZ79SvNbI
         5eZMOVvAxqKGxqXf553rsxPX0nXvd0LgDPX+xXROktrlY2xJzqEWBiKZjuL7xU0Xooyd
         oAhy95TL+YWliOHlHS+GmneRNzkfdgKMPbSPfDEQBOdjV7xIpi/Chr4FuhJr5IHxjDB5
         i9ebqL4av7yE01L9vRl6mG4TQTWBBCTFPrgbX3v56RFKHhgqnbatG9/Z7A4MNFFiW1Nn
         3Oj9T+DUC6AZvcL75kq9MP1MicjxQNGZHV2TrZmFNhAXAkxzYgoV8T710Pe/07uxLjQg
         4C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754677697; x=1755282497;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5HSh4b6bYfxkbXoMTmNogaldVZD/3Anv8CmkH0YyIYI=;
        b=hkNOuE51Ws9LkGP2Y7D70JtpzzsodXRVyo6WL2LoRzW2r3mAKZT/Q6iHUA2i2p43HP
         rkm7foDCfro/vvLR0oxb4cAhICzGGcXP0y3ggnVS2p1JMruUdUYGFSNSkjNCxQKr20DJ
         txlT3hRBqmHYMIBCx8rUwkWPeFmCJE8cYFp8truIZq/RCIAFVX+vhEu374yVCWNxOaLn
         PUywZcRiNXGiYw7VA86YSTG6UWLuLnA6uJmIGeXM/v3VnbiEtKfxzS+dYiecQCVaZ5BH
         Owqq+E7UBRHekgIMmA3Rpa1bu1lZl1kdRdFwdSqFcYdXKMCCyWIsL+Tgfr5L0pdt1d03
         a/qg==
X-Forwarded-Encrypted: i=1; AJvYcCWRIQIs5GHALuDrtqzN8BZp0aqEwiqMNfV2v6lGC59U+bnGFHAHOXLHW2P5ymEnJmdt3wWrlxP8hA==@vger.kernel.org, AJvYcCXQMFh6RKBTEFHAGZXMWpg5W9JOAuqEf/NA99f4T+zXUVTD20zfLvnP1ct+QLsH/JmbMbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Pkk46gCMpPulV5+r2HHlrkujr4tlgrIMMfilpn/A+hd7wD+j
	476InSlquezt0PXPIpG+ZEMfUmAB9Ldcwn4RJHq0QMQpzBjZQsYBAUGI
X-Gm-Gg: ASbGncvfXjUNmfZkjUAjADtl5Elbev9ZegbvNgAxlg6dCe6UNumsjhAHrxr6nYXzfjX
	yCnCdbyOrzdmTI0AjDdWxUCz6wyInz9r2xLh1Ea4N0lSVpqbYxYUQMvDT+lsbI+4oUMSo/dndDC
	1GPjSE5Q4D00ymQfhp7TirsDEkBuedJgml/sR5Bi73Kk2cSF5p54IBON21vZ/YEIr/+z6a/v/kG
	/6ZtV9KE7nImAJ0Jpn/qrwRXlRFjCDrPMQkvk++tls54P881GeohesRKBkgvWuwRyd8oBAFRwef
	kYxLwk2cw81URLSV/560l67xEFuAqVoTWJ6heN8/qG51RR6V0dnjFfm3UnYjvpdzWoJy5NCTa1f
	7srZMM9aq0nBl67xLVO4=
X-Google-Smtp-Source: AGHT+IFPWI1jcoxgfjLC5ivAgojhXJ9IG0X4OQUpiKffiSyKGn7PRM9NLv/NgFtqbeR4eVYdMSjo/Q==
X-Received: by 2002:a17:903:4b43:b0:240:25f3:2115 with SMTP id d9443c01a7336-242c1ff406cmr61292295ad.12.1754677697342;
        Fri, 08 Aug 2025 11:28:17 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef5934sm214251505ad.21.2025.08.08.11.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 11:28:16 -0700 (PDT)
Message-ID: <b297444e23c42caeab254c90fa91f46f75212e29.camel@gmail.com>
Subject: Re: [RFC 0/4] BTF archive with unmodified pahole+toolchain
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, nick.alcock@oracle.com, Alan Maguire
 <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>, Kate
 Carcia <kcarcia@redhat.com>, dwarves <dwarves@vger.kernel.org>, Arnaldo
 Carvalho de Melo	 <acme@redhat.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Yonghong Song	 <yonghong.song@linux.dev>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>,  Nick Alcock
 <nick.alcock@oracle.com>, Namhyung Kim <namhyung@kernel.org>, bpf
 <bpf@vger.kernel.org>
Date: Fri, 08 Aug 2025 11:28:13 -0700
In-Reply-To: <CAADnVQ+cvvHN9CunLP03yRFKz2YJirmF0j80-fZ0A-8aVVopPg@mail.gmail.com>
References: <20250807182538.136498-1-acme@kernel.org>
	 <CAADnVQ+cvvHN9CunLP03yRFKz2YJirmF0j80-fZ0A-8aVVopPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-07 at 19:09 -0700, Alexei Starovoitov wrote:

[...]

> Before you jump into 1,2,3 let's discuss the end goal.
> I think the assumption here is that this btf-for-each-.o approach
> is supposed to speed up the build, right ?
> pahole step on vmlinux is noticeable, but it's still a fraction
> of three vmlinux linking steps.
> How much are we realistically thinking to shave off of that pahole dedup =
time?

Hi Alan, Arnaldo, Nick,

I'd like to second Alexei's question.
In the cover letter Arnaldo points out that un-deduplicated BTF
amounts for 325Mb, while total DWARF size is 365Mb.
I tried measuring total amount of DWARF in my kernel building directory:

  for f in $(find . -name "*.o" | grep -Ev '(scripts|vmlinux|tools|module-c=
ommon)'); do \
    readelf -SW $f | grep "\.debug";
  done \
  | awk 'BEGIN {val=3D0} {val +=3D strtonum("0x"$6)} END {printf("%d", val)=
}' \
  | numfmt --to=3Dsi

And it says 845M.
The size of DWARF sections in the final vmlinux is comparable to yours: 307=
Mb.
The total size of the generated binaries is 905Mb.
So, unless the above calculations are messed up, the total gain here is:
- save ~500Mb generated during build
- save some time on pahole not needing to parse/convert DWARF

Is this is what you are trying to achieve?

In theory, having BTF handled completely by compiler and linker makes
sense to me.  However, pahole is already here and it does the job.
So, I see several drawbacks:
- As you note, there would be two avenues to generate BTF now:
  - DWARF + pahole
  - BTF + pahole (replaced by BTF + ld at some point?)
  This is a potential source of bugs.
  Is the goal to forgo DWARF+pahole at some point in the future?
- I assume that it is much faster to land changes in pahole compared
  to changes in gcc, so future btf modifications/features might be a
  bit harder to execute. Wdyt?

Thanks,
Eduard

