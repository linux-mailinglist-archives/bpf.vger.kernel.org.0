Return-Path: <bpf+bounces-40231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50B4983B34
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 04:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73581C22699
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 02:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B7CDDC1;
	Tue, 24 Sep 2024 02:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZnrHUh2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192AB1BC3F
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 02:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727144793; cv=none; b=Fb/bcGuQWHSBqC8BAI1ymN0rSlf0M8+DXKmdMRq2zyLX/sSe3eKaL07mbP/kXlMdsUREJHu11fqcaeBJfRpJqIhmIPycEC1jtuk8UQd6xUNqcbOO3FOJyasDWCHjrMR6hUjECCSt2LMPPw3u2SwBMKYZEmr63PKtnhwrsJd9Cc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727144793; c=relaxed/simple;
	bh=yhO6BhKM/0OWUzueOSP1bsd2TrQ9xUgxstqH5RB2dm4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XlA06vzMkolU+Gu/GZR7jtYpTGDLPr+33JRYDqFDFPMYeCqjnVz6B+uT1mr5eoM5K8pMf7ow5GM6WhOo/WgR5u1J8aNRcAErNtJy+cfyLE9dvWv6C1iG/irtGWq04OYJtu6MTh4Ta2+Y14YPuXKnWp2MJ71v+uh24lH7gSW0Xhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZnrHUh2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-206b9455460so37946825ad.0
        for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 19:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727144791; x=1727749591; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ugooc2Xi9b/ufhQSTE08ungSGOa1rGQ4OjK8RFFrhZE=;
        b=JZnrHUh2kL21MCJUuARVtqjCUNgrUsmMuxsAlEpCLiuN16S56MtmGkxQFPraMZZIBS
         /Wkn6pt6X7XQRVWgxj0Yl0oR1QDMjt+eHhL2i/eYF9vG+MFQB/aX4Rj4ADrzj6HHQT8i
         P6eKHtw7eDN/VgIqo1a6fOf4539kwIyZTDl0i6aEewBZa7zuy1cPT+WGyK8tlAEiDHnW
         2DfubTfJ6GKhTeuoYRwtYhtbef2MVVQOkEPAhf0zx7WMv2+hnqn+Ms/G2Joi1HUzX+64
         ebYIfC39dXLsqEMOAwXR7vvxMryx9dG8I0n6pQUyHKC3F+rSa/yUIkcLxJapL+Ntd06u
         iLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727144791; x=1727749591;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ugooc2Xi9b/ufhQSTE08ungSGOa1rGQ4OjK8RFFrhZE=;
        b=YU+joh2tABeCx2rC3sFxKOlTPvxDffQeIgIGAvIIwgnTyqvA7eTmZOUHl+Y+79wSpO
         z4bas/oiTG+JxP88IwoQvhdQTslZJlYXzECa1UugL3/OJpTPYLQTvzZBKslqqvXyLBWg
         UdLi5Kzr3kAXsw/GsMTnSerRXbatejRbEMX12qY2UFQlHiqm+PR1cr+XkPrp12+tAIl/
         0meU9ZoFCIa8veUhFKeXeOoXb87GVbokI4L5G/RIn1ONOnzVcjtTuHQJmUuesJe97lkX
         Y5m9lWysdew8amk8J12pfiOYTLedXbLAlMt6E2k17R++IR5PnuiidepPydhzNThQZqPJ
         1Dsw==
X-Forwarded-Encrypted: i=1; AJvYcCXzNJeq2Q0xeFNQKHzvqlU5ATXAvyZM42uTzWJxI2lJ20E1B9cd5AuYdzbL3U5RrbBdKi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQC/f9LAKF7QeZildEUhQfsjE20thjIOwSc6O7NrYxrdg68SCz
	4L4LcXc8g1sWLEHQUhDKcjH0XW3B0m61SEn4yAwpZI5/b1I6lyzz
X-Google-Smtp-Source: AGHT+IFTe+qBGzgtlu5G1thLi9MBkeW3SNBGE1+BrIEEkcq1cnuerGNOjiOKbwv9QLJqOuujuSjShw==
X-Received: by 2002:a17:902:e80b:b0:205:866d:177d with SMTP id d9443c01a7336-20aed10b06amr24348695ad.21.1727144791119;
        Mon, 23 Sep 2024 19:26:31 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17e19dbsm1886465ad.149.2024.09.23.19.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 19:26:30 -0700 (PDT)
Message-ID: <15ace64a53203acb2b26a7abcb035c4eb9364552.camel@gmail.com>
Subject: Re: Verifier - wild instructions count fluctiations between
 versions?
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alasdair McWilliam <alasdair.mcwilliam@outlook.com>, bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Mon, 23 Sep 2024 19:26:25 -0700
In-Reply-To: <AS8P194MB2042168EE5CAC311644BA284866F2@AS8P194MB2042.EURP194.PROD.OUTLOOK.COM>
References:
	  <AS8P194MB2042168EE5CAC311644BA284866F2@AS8P194MB2042.EURP194.PROD.OUTLOOK.COM>
Content-Type: multipart/mixed; boundary="=-bwkvy6P+tDulgO7sIX5q"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-bwkvy6P+tDulgO7sIX5q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-09-23 at 19:35 +0100, Alasdair McWilliam wrote:
> Hello,
>=20
> First post so please be gentle :-)
>=20
> I've got an eBPF workload running on kernel 6.1 LTS and we're running gre=
at.
>=20
> Use case actually is using eBPF in combination with XDP and AF_XDP for
> volumetric DDoS mitigation.
>=20
> Makeup of the eBPF program is mostly packet parsing, LPM and map
> lookups, and 2x calls to the bpf_loop() helper. Currently no iterators,
> dynptrs, etc, but lots of switch-case blocks.
>=20
> I've started to test newer kernel versions in preparation to upgrade our
> stack from 6.1 LTS to 6.6 LTS to gain access to newer functionality and
> just for future proofing. However, when loading the BPF object code on a
> 6.6 kernel, the BPF verifier refuses to load the program that 6.1
> accepts and runs well.
>=20
> This caught me by surprise, because I have witnessed our stack boot
> successfully on a 6.7 kernel. So, I've run veristat [0] on the exact
> same eBPF object file, compiled by clang17, but each time running on a
> different kernel version. Results fluctuate wildly!
>=20
> Results on 6.1.106: success: 53687 insns and 5114 states [1]
> Results on 6.6.52:  failure: 1000001 insns and 39501 states [2]
> Results on 6.7.9:   success: 131418 insns and 8839 states [3]

Hi Alasdair,

It might be the case that your issues with bpf_loop() are triggered by
the following commit:
- "bpf: verify callbacks as if they are called unknown number of times":
  - ab5cfac139ab for 6.7.y
  - b43550d7d58e for 6.6.y
  - not backported to 6.1.y

This commit is a correctness fix, w/o it bodies of the loop callbacks
were not checked exhaustively. But side effect of this fix is
significant verification time regression for some programs.

Comparing BPF related commits in both branches (starting from merge
base, using script from the attachment) gives somewhat sporadic
results:

  Commits stats:
    only in stable/linux-6.6.y    : 50
    only in stable/linux-6.7.y    : 96
    common                        : 74

  Only in stable/linux-6.6.y:
    ...

  Only in stable/linux-6.7.y:
    ...

Of these only "bpf: Improve JEQ/JNE branch taken logic" from 6.7
looks like an optimization, however it did not show any changes in
veristat data for selftests.

=3D> it's hard to say what's missing from 6.6 for your use-case.

Maybe let's discuss options for your program optimization
with regards to verifier performance?

Thanks,
Eduard

P.S. hope I did not mess up the script.


--=-bwkvy6P+tDulgO7sIX5q
Content-Type: application/x-shellscript; name="compare-bpf-commits-in-branches.sh"
Content-Disposition: attachment; filename="compare-bpf-commits-in-branches.sh"
Content-Transfer-Encoding: base64

YT1zdGFibGUvbGludXgtNi42LnkKYj1zdGFibGUvbGludXgtNi43LnkKbWVyZ2VfYmFzZT0kKGdp
dCBtZXJnZS1iYXNlICRhICRiKQoKZnVuY3Rpb24gZ2V0X2NvbW1pdHMgewogICAgYnJhbmNoPSQx
CiAgICBnaXQgbG9nIC0tcHJldHR5PWZvcm1hdDpcIiVzXCIgJGJyYW5jaCAkbWVyZ2VfYmFzZS4u
JGJyYW5jaCBcCiAgICAgICAgfCBncmVwICdicGY6JyB8IGdyZXAgLXYgc2VsZnRlc3RzIHwgZ3Jl
cCAtdiAnbGliYnBmOicgfCBzZWQgJ3MvIi8vZycgfCBzb3J0Cn0KCmNvbW1pdHNfYT0iJChnZXRf
Y29tbWl0cyAkYSkiCmNvbW1pdHNfYj0iJChnZXRfY29tbWl0cyAkYikiCm9ubHlfaW5fYT0kKGNv
bW0gLTIzIDwoZWNobyAiJGNvbW1pdHNfYSIpIDwoZWNobyAiJGNvbW1pdHNfYiIpKQpvbmx5X2lu
X2I9JChjb21tIC0xMyA8KGVjaG8gIiRjb21taXRzX2EiKSA8KGVjaG8gIiRjb21taXRzX2IiKSkK
Y29tbW9uPSQoY29tbSAtMTIgPChlY2hvICIkY29tbWl0c19hIikgPChlY2hvICIkY29tbWl0c19i
IikpCgpuYj0kKGVjaG8gIiRvbmx5X2luX2IiIHwgd2MgLWwpCm5jPSQoZWNobyAiJGNvbW1vbiIg
fCB3YyAtbCkKZWNobyAiQ29tbWl0cyBzdGF0czoiCnByaW50ZiAiICAlLTMwczogJWRcbiIgIm9u
bHkgaW4gJGEiICQoZWNobyAiJG9ubHlfaW5fYSIgfCB3YyAtbCkKcHJpbnRmICIgICUtMzBzOiAl
ZFxuIiAib25seSBpbiAkYiIgJChlY2hvICIkb25seV9pbl9iIiB8IHdjIC1sKQpwcmludGYgIiAg
JS0zMHM6ICVkXG4iICJjb21tb24iICAgICAkKGVjaG8gIiRjb21tb24iIHwgd2MgLWwpCmVjaG8g
IiIKCmVjaG8gIk9ubHkgaW4gJGE6IgplY2hvICIkb25seV9pbl9hIiB8IHNlZCAncy9eLyAgLycK
ZWNobyAiIgplY2hvICJPbmx5IGluICRiOiIKZWNobyAiJG9ubHlfaW5fYiIgfCBzZWQgJ3MvXi8g
IC8nCg==


--=-bwkvy6P+tDulgO7sIX5q--

