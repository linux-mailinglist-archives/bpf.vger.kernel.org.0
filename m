Return-Path: <bpf+bounces-52993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF5BA4B078
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 09:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC79B189384E
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 08:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4BF1D7E57;
	Sun,  2 Mar 2025 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJirG9JD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6526F1CB501;
	Sun,  2 Mar 2025 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740903616; cv=none; b=GNaGcXDLi5nSZGUlmBmXccH9moUKkgk6Ywt0yIAUgJJncWtmcCEaQI/1umYgIXWMAKv9uIATu9Bh9lSqS3gm1oI5Gq9PNfu9gqlkgYq0cJhz6a2r/JdkrYlzqKe+r1bndegwuMyN11v7PtxhR33dQ1fra9pQEBzN1Tvn+0E9CXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740903616; c=relaxed/simple;
	bh=BBOM7aE6y0/SX7NF6KVM2zPYvp2z+fQvq4fIL3RFlMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3HEcXrfi6Q3hCrNM3AHb7Pp8MPFYjPAU/kRL4N5HQxZITsphKZ8vkhRpnuRIuCW596Cv/KcyhRc+6WtOuag2t8sXhwlprC3PLehP/6pbzXbt/0ZsB6UvSNS5BHeo9MvItaJwBF0VAw+ooeBq0FxFTisSDQZN5YybSJ2VO3v+6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJirG9JD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2feb9076cdcso5220604a91.0;
        Sun, 02 Mar 2025 00:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740903613; x=1741508413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hvRvdsHloY5BTybtl092nj/Kn8Sd866ni5GmAJ3o96M=;
        b=fJirG9JDEEJlAc9mCMgbf+IftLe7fRz22yNtXvs+n/Ozo4Ajt5yiD58q2JfbhwiVzs
         qU96bTMraCRZgh8qdc2MdsOYAMwmDkKBMpsc5LNBJ3125zmifxXH2XrEIOxQ2QaA9sGz
         z1JeJK+1NvJbeeeoueIMsUCEOs01d7IRwZPPql2sU/DHovAU/9mIUV0jKdJOCE339Y0K
         sx1GGhhUjsRfjmhBUSDZcV8nXRGRdCQav5SNw9U+Q5JrQTSG1nZ2N2sLIZmOJpkqp6Jh
         dCFIe+2seFuimHZCJsoZC8+8MUyzqt11dV52tJctPdPUeaSHcfxrYQGN7DA1g5fofSc3
         BW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740903613; x=1741508413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvRvdsHloY5BTybtl092nj/Kn8Sd866ni5GmAJ3o96M=;
        b=TN0KPCWEvQu2P5gaU4g64Nlvqys9sVcnSOh+XIQoBEEP22iQlvoqvnVqRmyN5oYjkF
         6VaPy7mTq+Cq0VOWW6CzsHMAYU0NlPSlrZVaNZ6g/HbWLCNwpiwKJRm488HlawPjBPns
         DWhsms1Y1T+q///jhpp9cEmfvcpn5vwFRyNusQdbcqiykYIOGdqYmAnphRqRwQxPFI1w
         vcfpKogiqzXiWPkDtRxK0UkxVrfvUyTEAqeWo7hggr/CKkiqa4hFsaaLQo24RzDP+qAl
         VgHrZ27vCYsB7h5DH6oGsKmgr4EnW9pgj76P+MbEmJhEWecNLfC+oa1SX2S+mfHG7RNd
         09dg==
X-Forwarded-Encrypted: i=1; AJvYcCU0oMu7BXAftVhxf/QqyiReYrGCGUd+TlkkNv6SJyYNqsV7T8Ot4WkxQB46YUzrfmOCEpNWHvFdfipXoGEBrWs=@vger.kernel.org, AJvYcCUSVR5Lzi393Xs/e1zO+J+pil7zjNOu7w/rcRzRZYxWLugtzYf10tBMGFfyCPEEjimxr6e/Brhj@vger.kernel.org, AJvYcCUUY0YnHmxM7Ps0L2Qoe9CipYRxh/rKdPPiqLELx6rHYiJ3qQHmQySBoLHhXdyvnlrQsy8=@vger.kernel.org, AJvYcCW25xZUUUmMMMZHapltW7dZN2REH6EUozlXKH6ejtwWxOegmS08HYDjSo66ePbYnKeXazGh5+X+poiXvj7U@vger.kernel.org, AJvYcCWl1s8xUaysG/KuZ3UJwoa6n+Q4c2rbH2auBftPQwnXllbYqOGtwM5nr08mBiB9rA75G6JTxR0nlrj11LE=@vger.kernel.org, AJvYcCXQs793TNaZZMWEq+RkzUnlRoBOmTT8l4WVg0K4AVsEv6pPV3/+alseueMPQTeNs+YsoOUBHickH6O7eELP@vger.kernel.org, AJvYcCXly423kreFSdam5LMG0INJUQG46FLpU4DLJL/GKiKTh4M8s5EpHsDdJO6F7R1Pl2kkKUuGf2037oPf9po=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8isr4ctZORAIImLEFbXfKd3jfZQKJRuTFojcUnaAOaM1rxhfP
	qN6l6Oo6ZI0LMD2TDTO4j1P81sip29yuB5/gdQd062l7sSPTyHJt
X-Gm-Gg: ASbGncvhnUbJz9hURQTVOVwgFnf0Flbw91EcICt7g321V6xERz9jExjrUrhQh5PgMNU
	iQC4//tYwab9G1FSfGxpaAHLJA8TWQv9bc2dl2CEWlVNlv/mcS7SjGi4dw2FfegsL1MznfS4Vi0
	/ppbd3ir8eEnRFi7TNEPnp+5jeaauRCpdeUNkRru7r9mlvWH5eO0n+Oiqoqbs5oYyJixlphmRcQ
	hHmNfXSnEJ/ejptvSR1ATRV7U+0uftB/rVE9M/bXWWvo/hmFBYv6ccvDxsHZn/bgarpMZkOVvOc
	qr5K1zd6tlJdwrIeVdOVrJJhunAgCFdcz2o2sJ3jyp0ZZZQFDqzn9R6wqZrhEDPxSOFlumK4
X-Google-Smtp-Source: AGHT+IEhxHA+kpP3f6IyyP7qeoU3p0FUjq/2+GkVz3d5MRAoSIvjaHiRGY0TomgRz3SF6T/LAIMe2Q==
X-Received: by 2002:a17:90b:17d2:b0:2ee:aef4:2c5d with SMTP id 98e67ed59e1d1-2febabdede3mr12777219a91.26.1740903613420;
        Sun, 02 Mar 2025 00:20:13 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235052a622sm58034965ad.231.2025.03.02.00.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 00:20:12 -0800 (PST)
Date: Sun, 2 Mar 2025 16:20:02 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org,
	joel@jms.id.au, eajames@linux.ibm.com, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dmitry.torokhov@gmail.com, mchehab@kernel.org,
	awalls@md.metrocast.net, hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	louis.peens@corigine.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
	johannes@sipsolutions.net, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, akpm@linux-foundation.org, hpa@zytor.com,
	alistair@popple.id.au, linux@rasmusvillemoes.dk,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	david.laight.linux@gmail.com, andrew.cooper3@citrix.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v2 01/18] lib/parity: Add __builtin_parity() fallback
 implementations
Message-ID: <Z8QUsgpCB0m2qKJR@visitorckw-System-Product-Name>
References: <20250301142409.2513835-1-visitorckw@gmail.com>
 <20250301142409.2513835-2-visitorckw@gmail.com>
 <Z8PMHLYHOkCZJpOh@thinkpad>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8PMHLYHOkCZJpOh@thinkpad>

Hi Yury,

On Sat, Mar 01, 2025 at 10:10:20PM -0500, Yury Norov wrote:
> On Sat, Mar 01, 2025 at 10:23:52PM +0800, Kuan-Wei Chiu wrote:
> > Add generic C implementations of __paritysi2(), __paritydi2(), and
> > __parityti2() as fallback functions in lib/parity.c. These functions
> > compute the parity of a given integer using a bitwise approach and are
> > marked with __weak, allowing architecture-specific implementations to
> > override them.
> > 
> > This patch serves as preparation for using __builtin_parity() by
> > ensuring a fallback mechanism is available when the compiler does not
> > inline the __builtin_parity().
> > 
> > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> >  lib/Makefile |  2 +-
> >  lib/parity.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 49 insertions(+), 1 deletion(-)
> >  create mode 100644 lib/parity.c
> > 
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 7bab71e59019..45affad85ee4 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -51,7 +51,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
> >  	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
> >  	 percpu-refcount.o rhashtable.o base64.o \
> >  	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
> > -	 generic-radix-tree.o bitmap-str.o
> > +	 generic-radix-tree.o bitmap-str.o parity.o
> >  obj-y += string_helpers.o
> >  obj-y += hexdump.o
> >  obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
> > diff --git a/lib/parity.c b/lib/parity.c
> > new file mode 100644
> > index 000000000000..a83ff8d96778
> > --- /dev/null
> > +++ b/lib/parity.c
> > @@ -0,0 +1,48 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * lib/parity.c
> > + *
> > + * Copyright (C) 2025 Kuan-Wei Chiu <visitorckw@gmail.com>
> > + * Copyright (C) 2025 Yu-Chun Lin <eleanor15x@gmail.com>
> > + *
> > + * __parity[sdt]i2 can be overridden by linking arch-specific versions.
> > + */
> > +
> > +#include <linux/export.h>
> > +#include <linux/kernel.h>
> > +
> > +/*
> > + * One explanation of this algorithm:
> > + * https://funloop.org/codex/problem/parity/README.html
> 
> I already asked you not to spread this link. Is there any reason to
> ignore it?
> 
In v2, this algorithm was removed from bitops.h, so I moved the link
here instead. I'm sorry if it seemed like I ignored your comment.

> > + */
> > +int __weak __paritysi2(u32 val);
> > +int __weak __paritysi2(u32 val)
> > +{
> > +	val ^= val >> 16;
> > +	val ^= val >> 8;
> > +	val ^= val >> 4;
> > +	return (0x6996 >> (val & 0xf)) & 1;
> > +}
> > +EXPORT_SYMBOL(__paritysi2);
> > +
> > +int __weak __paritydi2(u64 val);
> > +int __weak __paritydi2(u64 val)
> > +{
> > +	val ^= val >> 32;
> > +	val ^= val >> 16;
> > +	val ^= val >> 8;
> > +	val ^= val >> 4;
> > +	return (0x6996 >> (val & 0xf)) & 1;
> > +}
> > +EXPORT_SYMBOL(__paritydi2);
> > +
> > +int __weak __parityti2(u64 val);
> > +int __weak __parityti2(u64 val)
> > +{
> > +	val ^= val >> 32;
> > +	val ^= val >> 16;
> > +	val ^= val >> 8;
> > +	val ^= val >> 4;
> > +	return (0x6996 >> (val & 0xf)) & 1;
> > +}
> > +EXPORT_SYMBOL(__parityti2);
> 
> OK, it seems I wasn't clear enough on the previous round, so I'll try
> to be very straightforward now.
> 
> To begin with, the difference between __parityti2 and __paritydi2 
> doesn't exist. I'm seriously. I put them side by side, and there's
> no difference at all.
> 
> Next, this all is clearly an overengineering. You bake all those weak,
> const and (ironically, missing) high-efficient arch implementations.
> But you show no evidence that:
>  - it improves on code generation,
>  - the drivers care about parity()'s performance, and
>  - show no perf tests at all.
> 
> So you end up with +185/-155 LOCs.
> 
> Those +30 lines add no new functionality. You copy-paste the same
> algorithm again and again in very core kernel files. This is a no-go
> for a nice consolidation series.
> 
> In the previous round reviewers gave you quite a few nice suggestions.
> H. Peter Anvin suggested to switch the function to return a boolean, I
> suggested to make it a macro and even sent you a patch, Jiri and David
> also spent their time trying to help you, and became ignored.
> 
> Nevertheless. NAK for the series. Whatever you end up, if it comes to
> v3, please make it simple, avoid code duplication and run checkpatch.
> 
In v1, I used the same approach as parity8() because I couldn't justify
the performance impact in a specific driver or subsystem. However,
multiple people commented on using __builtin_parity or an x86 assembly
implementation. I'm not ignoring their feedback-I want to address these
comments. Before submitting, I sent an email explaining my current
approach: using David's suggested method along with __builtin_parity,
but no one responded. So, I decided to submit v2 for discussion
instead.

To avoid mistakes in v3, I want to confirm the following changes before
sending it:

(a) Change the return type from int to bool.
(b) Avoid __builtin_parity and use the same approach as parity8().
(c) Implement parity16/32/64() as single-line inline functions that
    call the next smaller variant after xor.
(d) Add a parity() macro that selects the appropriate parityXX() based
    on type size.
(e) Update users to use this parity() macro.

However, (d) may require a patch affecting multiple subsystems at once
since some places that already include bitops.h have functions named
parity(), causing conflicts. Unless we decide not to add this macro in
the end.

As for checkpatch.pl warnings, they are mostly pre-existing coding
style issues in this series. I've kept them as-is, but if preferred,
I'm fine with fixing them.

If anything is incorrect or if there are concerns, please let me know.

Regards,
Kuan-Wei

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index c1cb53cf2f0f..47b7eca8d3b7 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -260,6 +260,43 @@ static inline int parity8(u8 val)
 	return (0x6996 >> (val & 0xf)) & 1;
 }

+static inline bool parity16(u16 val)
+{
+	return parity8(val ^ (val >> 8));
+}
+
+static inline bool parity32(u32 val)
+{
+	return parity16(val ^ (val >> 16));
+}
+
+static inline bool parity64(u64 val)
+{
+	return parity32(val ^ (val >> 32));
+}
+
+#define parity(val)			\
+({					\
+	bool __ret;			\
+	switch (BITS_PER_TYPE(val)) {	\
+	case 64:			\
+		__ret = parity64(val);	\
+		break;			\
+	case 32:			\
+		__ret = parity32(val);	\
+		break;			\
+	case 16:			\
+		__ret = parity16(val);	\
+		break;			\
+	case 8:				\
+		__ret = parity8(val);	\
+		break;			\
+	default:			\
+		BUILD_BUG();		\
+	}				\
+	__ret;				\
+})
+
 /**
  * __ffs64 - find first set bit in a 64 bit word
  * @word: The 64 bit word


