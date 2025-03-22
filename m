Return-Path: <bpf+bounces-54563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595DEA6C746
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 03:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609A717F128
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 02:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9576A33B;
	Sat, 22 Mar 2025 02:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ArGwcii+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC5258A;
	Sat, 22 Mar 2025 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742611834; cv=none; b=t7/+GdN/7F5bB6nOGrteVyjuirPYO6bFxy8w644EKKtjx/5s46dvzXIy3JHOpx/6pgzxwzE6IE/GXlvONRDM4UCer+AwGhhrK6Fc1Tl92lp3qW7qH2MDPkkI3pWCaUqhl/cojSThOt3tDzM1iw+AzzzI6szZzxJm8P2z4QnrWLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742611834; c=relaxed/simple;
	bh=1BiFl53oc1kpxx5ey5R66T3DEw8hBTtgDLrRn9rgAp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imP0gJn4ILfNFE96HZ7n/lYS2Q/CKckw8QPdulxT88b4k6/OOC9ucdkMUxLQjhQGbrFo1ps2r7heyjYE+5tkBdMFoHuCR9OrnJosEs7cEjfwDqluQk1R515IH4U+Lq3L0r1Z3/INlOi5BTVdeLIPfHU1fYf9NgSfcGA7aPl3mjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ArGwcii+; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742611833; x=1774147833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3NTXoE812gxhkh6ZaJaWv3L2T+sfHWpWaHGpsXz0hn4=;
  b=ArGwcii+0TfZAOzdf2zs6iXnoTxs0fop2YlZqmklML7y1Oulm+jPbujr
   igIM7U6zfmvm4RLz2P3kksmCR2xPN8VWMFGn5wKi0GAqe2yBxPPeyibWy
   yV0T2J7ZqKbwI/birUWe9j/z+3+o0a34srUt7Y35WoJmeARDHKGRJy7FB
   U=;
X-IronPort-AV: E=Sophos;i="6.14,266,1736812800"; 
   d="scan'208";a="477254702"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 02:50:29 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:51031]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.36:2525] with esmtp (Farcaster)
 id beeba110-8be0-460e-a2d7-bfdc7e614639; Sat, 22 Mar 2025 02:50:28 +0000 (UTC)
X-Farcaster-Flow-ID: beeba110-8be0-460e-a2d7-bfdc7e614639
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 22 Mar 2025 02:50:27 +0000
Received: from b0be8375a521.amazon.com (10.37.244.8) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 22 Mar 2025 02:50:21 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <eddyz87@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <enjuk@amazon.com>, <haoluo@google.com>,
	<iii@linux.ibm.com>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kohei.enju@gmail.com>, <kpsingh@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <martin.lau@linux.dev>, <sdf@fomichev.me>,
	<song@kernel.org>, <yepeilin@google.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add selftests for load-acquire/store-release when register number is invalid
Date: Sat, 22 Mar 2025 11:48:56 +0900
Message-ID: <20250322025013.76028-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <65ff9c62d0d2c355121468b04c0701081d3275fd.camel@gmail.com>
References: <65ff9c62d0d2c355121468b04c0701081d3275fd.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

> [...]
> 
> > +SEC("socket")
> > +__description("load-acquire with invalid register R11")
> > +__failure __failure_unpriv __msg("R11 is invalid")
> > +__naked void load_acquire_with_invalid_reg(void)
> > +{
> > +	asm volatile (
> > +	".8byte %[load_acquire_insn];" // r0 = load_acquire((u64 *)(r11 + 0));
> > +	"exit;"
> > +	:
> > +	: __imm_insn(load_acquire_insn,
> > +		     BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_0, 11 /* invalid reg */, 0))
> > +	: __clobber_all);
> > +}
> > +
> >  #else /* CAN_USE_LOAD_ACQ_STORE_REL */
> >  
> >  SEC("socket")
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_store_release.c b/tools/testing/selftests/bpf/progs/verifier_store_release.c
> > index cd6f1e5f378b..2dc1d713b4a6 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_store_release.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_store_release.c
> > @@ -257,6 +257,20 @@ __naked void store_release_leak_pointer_to_map(void)
> >  	: __clobber_all);
> >  }
> >  
> > +SEC("socket")
> > +__description("store-release with invalid register R11")
> > +__failure __failure_unpriv __msg("R11 is invalid")
> > +__naked void store_release_with_invalid_reg(void)
> > +{
> > +	asm volatile (
> > +	".8byte %[store_release_insn];" // store_release((u64 *)(r11 + 0), r1);
> > +	"exit;"
> > +	:
> > +	: __imm_insn(store_release_insn,
> > +		     BPF_ATOMIC_OP(BPF_DW, BPF_STORE_REL, 11 /* invalid reg */, BPF_REG_1, 0))
> 
> On my machine / config, the value of 11 was too small to trigger the
> KASAN warning. Value of 12 was sufficient.
> Curious if it is my config, did you see KASAN warning locally when running this test
> before applying the fix?

Yes, as you pointed out, R11 doesn't trigger the KASAN splat in practice. 
For the splat, we need a value of 12 or larger.

The sizes of struct bpf_reg_state and bpf_func_state are 120 and 1368 
respectively.[1]
In the bpf_func_state, the member `regs` ranges from 0 to 1320 bytes (each 
120 bytes for each R0 to R10).
Also, the member `type`, which is accessed in is_ctx_reg(), is the first 
member of struct bpf_reg_state.

Therefore, when the register is R11, `regs->type` reads 4 bytes from 1320.
Since the size of bpf_func_state is 1368 and it doesn't exceed the end of 
the allocated memory, it doesn't trigger the KASAN splat.

OTOH, when the register is R12, `regs->type` reads 4 bytes from 1440 (120 
* 12 + 0).
This triggers the KASAN splat since it's larger than bpf_func_state's size.

Here is a part of the splat I saw in my environment when specifying R12. 
This says that the buggy address is 1440 (1368 + 72) and also matches 
previous analysis.

    The buggy address belongs to the object at ffff888112603800
     which belongs to the cache kmalloc-2k of size 2048
    The buggy address is located 72 bytes to the right of
     allocated 1368-byte region [ffff888112603800, ffff888112603d58)
    ...
    Memory state around the buggy address:
     ffff888112603c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     ffff888112603d00: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
    >ffff888112603d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                   ^
     ffff888112603e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
     ffff888112603e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

> Maybe set the value to 15 here and above to maximize probability of KASAN warning?

Understood. Thank you for the feedback.

I chose the minimum invalid register regardless of the actual occurrence 
of the splat, since the validity check of this type might be `regno >= 
MAX_BPF_REG` or not.
Sorry for my confusing choice.

Since I'm not attached to that particular choice, I'll change it to R15.
Thank you for reviewing and providing feedback!

> 
> > +	: __clobber_all);
> > +}
> > +
> >  #else
> >  
> >  SEC("socket")

Regards,
Kohei

---
[1]
struct bpf_reg_state {
        enum bpf_reg_type          type;                 /*     0     4 */
...

        /* size: 120, cachelines: 2, members: 19 */
        /* padding: 3 */
        /* last cacheline: 56 bytes */
};

struct bpf_func_state {
        struct bpf_reg_state       regs[11];             /*     0  1320 */
...
        int                        allocated_stack;      /*  1360     4 */

        /* size: 1368, cachelines: 22, members: 12 */
        /* sum members: 1363, holes: 1, sum holes: 1 */
        /* padding: 4 */
        /* last cacheline: 24 bytes */
};

