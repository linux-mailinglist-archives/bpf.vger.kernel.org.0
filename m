Return-Path: <bpf+bounces-55317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786ECA7B94B
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 10:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B413BA98D
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 08:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ACE1ACEC6;
	Fri,  4 Apr 2025 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/tABtJg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AAC1A2393;
	Fri,  4 Apr 2025 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743756491; cv=none; b=G9dDbGhBWmHUdyEjlTAh8Bs6bSsREuMA4pDKhrKWFokkPV5vnCZsZ3Pvid/KpQCLFpsSg9784PHZGBR+2EdEGG39dvJzOrZ8BfUtBHXXVAu6NMu+Ps6X7eRF2WyUlsFf5jncS40iN3GF89v9K3eWKU4TldAiTubitsz/B9VBF/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743756491; c=relaxed/simple;
	bh=ZQOEb8u3RDoF68oLgxFL7DOVXtidnbHC/aIeLuWknxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBO1+pw0Qoxxg/DOcNpLqs6+oizHJq9aFxSEhOoTKCAYCxao7qNKPnogdIHoFwVcMAU2GmnZM1AmdaAHGlVh6Z9/06CxRQ3Sy4r/F85HWM18Lw32IRwO2ovL+RTqZsEGQVIqey5NhVZo1aHjtc2DqOG6syhLIfA+zpqxK9QorRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/tABtJg; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af51596da56so1611299a12.0;
        Fri, 04 Apr 2025 01:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743756489; x=1744361289; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GKYFZl2hMBVvq/tGTvaEyWP0BJSuPsnZGbFqpvTq3m8=;
        b=c/tABtJgu+1wJsUkjKrBPvwHxlYzTfKx5KLtxrrgzhfwGhnw/6hl78TLrW9GE5gZLN
         mI+cdtbZozoF4ENePLzbBuob6zSGuyzOVZZ8R0iPpoPK0HqMi0HGj6ryOTfeqfIGSfTK
         pAMxja0NTobZT/w/Lgg//t9A4/GjDCkldDNK+MVjaz5/VjZLw4G991iQZdAIQJ7XfODq
         TNp7/9IjOkmeqRr0gleYDD8SWOYuZgPpFTMqoR9vmorBYSfMczWP+9qes8FCBX8ZMkZ4
         8Wgc6IU/4UzzS5HWxTplc1N3HEIDlsfproGpT5rDScNdUu5vDDlvxrsI51+288VcWt79
         Q9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743756489; x=1744361289;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKYFZl2hMBVvq/tGTvaEyWP0BJSuPsnZGbFqpvTq3m8=;
        b=gbT87ZTSv41xMXleiQCkS52QCQ/SguaEStLV2SMtdBL2LCVmHEOTZqLknQsdv41uKU
         zAb0Ucer2fbARH/u25UKUYyg9QjGnm9dJQ8o78hbYDA56DW4MVLxW+EU4rvRDpiUMFm8
         036pckZg0Y6yvVjiUglpHOfSsHCP/mb7QEhwOBNjqRV/hjE6suCrrAKPKyoZGMALDlqa
         u7bpG3i6XRIVnFYo8EKjzmRY4CqeU5GJYAJjE2xOAoFWEO9NAmsxjmcB2y/tooc3V4q/
         2U70dVingvqB6zCeHUQhb/ykg1+fzoS4wcw2MtRyfswAgoM3+NgizgnaoFPXjJ1ebxhi
         sq4A==
X-Forwarded-Encrypted: i=1; AJvYcCUOtJPBRc5IioM0MW3jFu0MMGXcFrb28zqqD7OckVHxBF8crXx9ww8zsToeBpKF85NtGI23/Vuf3j694bw=@vger.kernel.org, AJvYcCV0TrUz1p8A53RwzcsYcJXW8pfivWu8Yt85TGBd4S3hjzRzm7ixpc70T+17hO4p+1I5Wj0=@vger.kernel.org, AJvYcCW0b3wu7OK+/DWh0/EB65e3kBCAroWppkRrG65nqNUThRS3ZtNeAeQkfMQhGUTUYl2MAXFxbBrSxMJaJAJA@vger.kernel.org, AJvYcCWBIyiuXGIrWc6fLzF1IxJMvw3+0LUNFwnO4Ud4/QWiHh+e8RxMeaOo/6rVExCggf5iNxW9F9ZD2JXsnh98@vger.kernel.org, AJvYcCWJQ/bFk24O5Hp0JZV0XFJhNR4kxbJYnBgRCuzlm2K/5tmLXvLybylL2HJ+yV2TZsYwqKRfssoRwFON4f7vfp8=@vger.kernel.org, AJvYcCWVX06+Jmb1/qFd+FIYYK49QQriTeK0e+YunmPqYugJYDo9NIDl6+zXA+ZeLXAitjjhoBlhNb9w@vger.kernel.org, AJvYcCX/mZk2ieEmy+t92MdHcUygsboq5iZ0SqdlX5kc7F8HcLb9DpCS1zzaTPNKFKGzpusSRSmfr7hcSoBsuSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT7zSbRSPqDnGUtSv16T1bKfA6vLhno9VQU5t1+t6taJeB69yD
	/2gnWmPEGDHklhEr417S7xiG6j4mIeb+JGc+RfRa5saC6MKupRSH
X-Gm-Gg: ASbGncvTfwN7HF3F4A+oXR2eUK2jaHcm+kJMIDrK4fE8i1QuufdBRgpjzUah5prUH5Y
	iGg/EXVCunVVxag0mIAospw0i5XmUUkZb8GBMpuqP/aSTgjqXASHNNlc8reLwMCTU9+Z5Ud1pZn
	q5XVL7LUScxUKksRra62grNeCIGmS3DqSNrYNHLecDuTdy7LJaVeozJ8Qb2KAIpiIBCWnsTy7i4
	BR0Uqi/EZQeIpWvgrY4xyc2dhJEle+As2TPY//wKAZSvYNXu98GuVYpsNLtPiCz5CjvBuIGa3hN
	i/Egu+iZOIER5Wxvr0/a94tNVHjZEodRT7EhVJLKFHk2cw+E+opN+6UrhvjwVOYMTPgtQ3ZN
X-Google-Smtp-Source: AGHT+IHQy54LZ/NyiSvEoks7UryUue+uQARWbnhEUMyhIJqZeMH+xfpWnZ/jGnglOqtjlSonVKNhIw==
X-Received: by 2002:a05:6a21:999d:b0:1f5:8748:76cc with SMTP id adf61e73a8af0-20108188cdemr3659983637.31.1743756488698;
        Fri, 04 Apr 2025 01:48:08 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc32c999sm2377463a12.19.2025.04.04.01.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 01:48:07 -0700 (PDT)
Date: Fri, 4 Apr 2025 16:47:58 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	David Laight <david.laight.linux@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
	akpm@linux-foundation.org, alistair@popple.id.au,
	andrew+netdev@lunn.ch, andrzej.hajda@intel.com,
	arend.vanspriel@broadcom.com, awalls@md.metrocast.net, bp@alien8.de,
	bpf@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev, dave.hansen@linux.intel.com,
	davem@davemloft.net, dmitry.torokhov@gmail.com,
	dri-devel@lists.freedesktop.org, eajames@linux.ibm.com,
	edumazet@google.com, eleanor15x@gmail.com,
	gregkh@linuxfoundation.org, hverkuil@xs4all.nl,
	jernej.skrabec@gmail.com, jirislaby@kernel.org, jk@ozlabs.org,
	joel@jms.id.au, johannes@sipsolutions.net, jonas@kwiboo.se,
	jserv@ccns.ncku.edu.tw, kuba@kernel.org, linux-fsi@lists.ozlabs.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-serial@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux@rasmusvillemoes.dk, louis.peens@corigine.com,
	maarten.lankhorst@linux.intel.com, mchehab@kernel.org,
	mingo@redhat.com, miquel.raynal@bootlin.com, mripard@kernel.org,
	neil.armstrong@linaro.org, netdev@vger.kernel.org,
	oss-drivers@corigine.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, rfoss@kernel.org,
	richard@nod.at, simona@ffwll.ch, tglx@linutronix.de,
	tzimmermann@suse.de, vigneshr@ti.com, x86@kernel.org
Subject: Re: [PATCH v3 00/16] Introduce and use generic parity16/32/64 helper
Message-ID: <Z++cvrLOz2VAaUkO@visitorckw-System-Product-Name>
References: <Z824SgB9Dt5zdWYc@visitorckw-System-Product-Name>
 <Z9CyuowYsZyez36c@thinkpad>
 <80771542-476C-493E-858A-D2AF6A355CC1@zytor.com>
 <Z9GtcNJie8TRKywZ@thinkpad>
 <Z9G2Tyypb3iLoBjn@visitorckw-System-Product-Name>
 <Z9KMKwnZXA2mkD2s@visitorckw-System-Product-Name>
 <Z+AlyB461xwMxMtG@visitorckw-System-Product-Name>
 <eec0dfd7-5e4f-4a08-928c-b7714dbc4a17@zytor.com>
 <Z+6dh1ZVIKWWOKaP@visitorckw-System-Product-Name>
 <Z-6zzP2O-Q7zvTLt@thinkpad>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-6zzP2O-Q7zvTLt@thinkpad>

On Thu, Apr 03, 2025 at 12:14:04PM -0400, Yury Norov wrote:
> On Thu, Apr 03, 2025 at 10:39:03PM +0800, Kuan-Wei Chiu wrote:
> > On Tue, Mar 25, 2025 at 12:43:25PM -0700, H. Peter Anvin wrote:
> > > On 3/23/25 08:16, Kuan-Wei Chiu wrote:
> > > > 
> > > > Interface 3: Multiple Functions
> > > > Description: bool parity_odd8/16/32/64()
> > > > Pros: No need for explicit casting; easy to integrate
> > > >        architecture-specific optimizations; except for parity8(), all
> > > >        functions are one-liners with no significant code duplication
> > > > Cons: More functions may increase maintenance burden
> > > > Opinions: Only I support this approach
> > > > 
> > > 
> > > OK, so I responded to this but I can't find my reply or any of the
> > > followups, so let me go again:
> > > 
> > > I prefer this option, because:
> > > 
> > > a. Virtually all uses of parity is done in contexts where the sizes of the
> > > items for which parity is to be taken are well-defined, but it is *really*
> > > easy for integer promotion to cause a value to be extended to 32 bits
> > > unnecessarily (sign or zero extend, although for parity it doesn't make any
> > > difference -- if the compiler realizes it.)
> > > 
> > > b. It makes it easier to add arch-specific implementations, notably using
> > > __builtin_parity on architectures where that is known to generate good code.
> > > 
> > > c. For architectures where only *some* parity implementations are
> > > fast/practical, the generic fallbacks will either naturally synthesize them
> > > from components via shift-xor, or they can be defined to use a larger
> > > version; the function prototype acts like a cast.
> > > 
> > > d. If there is a reason in the future to add a generic version, it is really
> > > easy to do using the size-specific functions as components; this is
> > > something we do literally all over the place, using a pattern so common that
> > > it, itself, probably should be macroized:
> > > 
> > > #define parity(x) 				\
> > > ({						\
> > > 	typeof(x) __x = (x);			\
> > > 	bool __y;				\
> > > 	switch (sizeof(__x)) {			\
> > > 		case 1:				\
> > > 			__y = parity8(__x);	\
> > > 			break;			\
> > > 		case 2:				\
> > > 			__y = parity16(__x);	\
> > > 			break;			\
> > > 		case 4:				\
> > > 			__y = parity32(__x);	\
> > > 			break;			\
> > > 		case 8:				\
> > > 			__y = parity64(__x);	\
> > > 			break;			\
> > > 		default:			\
> > > 			BUILD_BUG();		\
> > > 			break;			\
> > > 	}					\
> > > 	__y;					\
> > > })
> > >
> > Thank you for your detailed response and for explaining the rationale
> > behind your preference. The points you outlined in (a)–(d) all seem
> > quite reasonable to me.
> > 
> > Yury,
> > do you have any feedback on this?
> > Thank you.
> 
> My feedback to you:
> 
> I asked you to share any numbers about each approach. Asm listings,
> performance tests, bloat-o-meter. But you did nothing or very little
> in that department. You move this series, and it means you should be
> very well aware of alternative solutions, their pros and cons.
> 
It seems the concern is that I didn't provide assembly results and
performance numbers. While I believe that listing these numbers alone
cannot prove which users really care about parity efficiency, I have
included the assembly results and my initial observations below. Some
differences, like mov vs movzh, are likely difficult to measure.

Compilation on x86-64 using GCC 14.2 with O2 Optimization:

Link to Godbolt: https://godbolt.org/z/EsqPMz8cq

For u8 Input:
- #2 and #3 generate exactly the same assembly code, while #1 replaces
  one `mov` instruction with `movzh`, which may slightly slow down the
  performance due to zero extension.
- Efficiency: #2 = #3 > #1

For u16 Input:
- As with u8 input, #1 performs an unnecessary zero extension, while #3
  replaces one of the `shr` instructions in #2 with a `mov`, making it
  slightly faster.
- Efficiency: #3 > #2 > #1

For u32 Input:
- #1 has an additional `mov` instruction compared to #2, and #2 has an
  extra `shr` instruction compared to #3.
- Efficiency: #3 > #2 > #1

For u64 Input:
- #1 and #2 generate the same code, but #3 has one less `shr`
  instruction compared to the others.
- Efficiency: #3 > #1 = #2

---

Adding -m32 Flag to View Assembly for 32-bit Machine:

Link to Godbolt: https://godbolt.org/z/GrPa86Eq5

For u8 Input:
- #2 and #3 generate identical assembly code, whereas #1 has additional
  `mov`, `shr`, and `push/pop` instructions.
- Efficiency: #2 = #3 > #1

For u16 Input:
- #1 uses a lot of `xmm` register operations, making it slower than #2
  and #3. Additionally, #2 has an extra `shr` instruction compared to #3.
- Efficiency: #3 > #2 > #1

For u32 Input:
- #1 again uses a lot of `xmm` register operations, so it is slower
  than #2 and #3, and #2 has an additional `shr` instruction compared to #3.
- Efficiency: #3 > #2 > #1

For u64 Input:
- Both #1 and #2 use `xmm` register operations, but #1 has a few extra
  `movdqa` instructions. #3 is more concise, using a few `shr`, `xor`,
  and `mov` instructions to complete the operation.
- Efficiency: #3 > #2 > #1

Regards,
Kuan-Wei

