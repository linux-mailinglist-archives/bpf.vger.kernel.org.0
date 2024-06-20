Return-Path: <bpf+bounces-32579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1892910173
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 12:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB99F1C213B9
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 10:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220481AAE2E;
	Thu, 20 Jun 2024 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zmv8axE9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03511AAE0F
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718879228; cv=none; b=m3YyE35IN0szeoXbexj4vi4/AtfnLW4MbGJGvY0/y+6MJfxYtwSBFpTq2sn3FPwBGZTFqrQ+nXAis3N0FBRWprXOZKXbi9zgFa3yQUXFLSdhlrOaKPG1O0n6Cq5zxjak6YQMOsqBvWBArV8kT2GDsJxmKxknr95ddh18Csya0q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718879228; c=relaxed/simple;
	bh=nbP+Bhd4Oz50eEYww49+b2pyQ5OQncxkrW0NyGylRy4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRQcarB7Qg2nt4txq1B5TSGdUWJnj5acdpn/FcMqePsrvvU14QyjHIhO8J8Nm00c0wqgR2cRPPFs9TX2kgRfwHrtMKhQgRqBK1jBmNqJMKoFBKflpVXOSFZDU7RVntrjeM4Tw2PEm8C7hOEKhLj8NDIUwhdj+RC1HHYjaNY+UfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zmv8axE9; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6e43dad8ecso124615966b.1
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 03:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718879225; x=1719484025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WunkOUBrHfnw8piozH8R3AlMLN+JNYbl5dNpHNSKR7w=;
        b=Zmv8axE94tzWomGemADl5lQRX2Mu/wfGrcUMxK2o9NxTCuiT2ZqktehIFspjzRHfR3
         yV7dLxTKd256PjMbZajl/e3q+h0CvUIntYN3bMhQKmuAQqMWR7HFwYOZxpmQOKf3zbqW
         stM6V6R9ulGhjKHe4+lcMG2gDV3+SvE6SGsbpwWAUhNsTn3tGdJzbifM54Y57knim7GT
         Ca8lzxgv7EXay9LetxTcfghCOpoeKHCD5GMaIbzgc+iy/JZlSgSXrklzewNURGb+254r
         akzyYPNuKB28Iimh0ZAKgVKopGfT/w+fJMnEmqNO+yCzhKpLznvH9HkXCRNcRCjv1Zoy
         ci/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718879225; x=1719484025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WunkOUBrHfnw8piozH8R3AlMLN+JNYbl5dNpHNSKR7w=;
        b=TtR0tGVwjGt+TvMxV56SB8da3zE/RG64YWrYCQ8xf5iOQ3KhMW1D3065TMC6tlYiqG
         5ETy9asI+3lNBLhxmpiIy7KFOhbd4w5tOAa9VDi8+gNk5m5gECJ7zKGr/iLrbJ8s0eQd
         kD5Z+2ijNVW2p1knOQX3h8q3jfxva/PS/+18RXmgVUJls+IElaR53X9OqySiIVl8VfuC
         saFckMLqewBrOMEc6JF8Qfcqn+nPDYDJdvVULOKS1tLdeKVy+jvKW+WKJzTNBNKfIaHM
         9vzQLABRxYRHUUv93OUt0/0FjagdSzX3ksZfo3SdEI3WBxTArCDSJHDKLU/nE/es3ylb
         aMIA==
X-Forwarded-Encrypted: i=1; AJvYcCXy8A6b0RrH/iYW8DVGacBhXZnIzuhjD1WKh/xXg2HkvRvuc6OxdQ2M+ET/rccxKi0p5b7+XuHSZp/SaipzKT4XX0qi
X-Gm-Message-State: AOJu0YwPp8s5eMFxArXKEFkQr9bZb2QMpX4APtk9aMIvn2Td4dJxVMum
	G9UFU+OPBYQAUotNZP4wo8PF/igDU8jJkCNNI9D/Bbz2GFa98v4O
X-Google-Smtp-Source: AGHT+IH8thtGPzLz/4Nvvx+Z0CNBRzF3zcJOlqEMrL09YKxqNbg9hMNJeJV1sqr0wB+isH2eNQQdZQ==
X-Received: by 2002:a17:907:d406:b0:a6f:b3d3:fed1 with SMTP id a640c23a62f3a-a6fb3d3ff9amr315541866b.10.1718879224903;
        Thu, 20 Jun 2024 03:27:04 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f41684sm752079666b.153.2024.06.20.03.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:27:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 20 Jun 2024 12:27:02 +0200
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf: Fix null pointer dereference in
 resolve_prog_type() for BPF_PROG_TYPE_EXT
Message-ID: <ZnQD9r5OVGPTiXIP@krava>
References: <20240620060701.1465291-1-wutengda@huaweicloud.com>
 <cfab6597-2c2c-4b76-853d-1b0dc13b8e9a@gmail.com>
 <2c5d2fdb-19ee-4b3c-9004-5e4d0a8719b8@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c5d2fdb-19ee-4b3c-9004-5e4d0a8719b8@huaweicloud.com>

On Thu, Jun 20, 2024 at 04:54:51PM +0800, Tengda Wu wrote:
> 
> 
> On 2024/6/20 14:46, Leon Hwang wrote:
> > 
> > 
> > On 20/6/24 14:07, Tengda Wu wrote:
> >> When loading a EXT program without specifying `attr->attach_prog_fd`,
> >> the `prog->aux->dst_prog` will be null. At this time, calling
> >> resolve_prog_type() anywhere will result in a null pointer dereference.
> > 
> > Interesting, same NULL pointer dereference causes another issue[0].
> > 
> > As for my case, when resolve_prog_type(), it has to use
> > prog->aux->saved_dst_prog_type instead of prog->aux->dst_prog->type for
> > EXT program, in order to avoid NULL pointer dereference.
> > 
> > [0] https://lore.kernel.org/bpf/20240602122421.50892-2-hffilwlqm@gmail.com/
> > 
> > Thanks,
> > Leon
> >This looks good, but unfortunately, there is still a problem with using 
> `prog->aux->saved_dst_prog_type` to resolve prog type, because its value still 
> comes from `prog->aux->dst_prog`in check_attach_btf_id(). 
> 
> Additionally, resolve_prog_type() not always be used after check_attach_btf_id().
> The following example stack trace proves the existence of this situation. It 
> shows that NULL pointer dereference occurs in add_subprog_and_kfunc(), which
> check_attach_btf_id() has not yet reached. 
> 
> So it may be more effective to check and avoid dst_prog empty when EXT program loads.

also please note it's breaking test_libbpf_probe_prog_types test

  test_libbpf_probe_prog_types:FAIL:BPF_PROG_TYPE_EXT unexpected BPF_PROG_TYPE_EXT: actual 0 != expected 1

because the attach_prog_fd wasn't needed to load EXT program before,
but I guess the following attach would fail.. so it's likely ok

jirka

> 
> >>
> >> Example stack trace:
> >>
> >> [    8.107863] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
> >> [    8.108262] Mem abort info:
> >> [    8.108384]   ESR = 0x0000000096000004
> >> [    8.108547]   EC = 0x25: DABT (current EL), IL = 32 bits
> >> [    8.108722]   SET = 0, FnV = 0
> >> [    8.108827]   EA = 0, S1PTW = 0
> >> [    8.108939]   FSC = 0x04: level 0 translation fault
> >> [    8.109102] Data abort info:
> >> [    8.109203]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> >> [    8.109399]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> >> [    8.109614]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> >> [    8.109836] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000101354000
> >> [    8.110011] [0000000000000004] pgd=0000000000000000, p4d=0000000000000000
> >> [    8.112624] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> >> [    8.112783] Modules linked in:
> >> [    8.113120] CPU: 0 PID: 99 Comm: may_access_dire Not tainted 6.10.0-rc3-next-20240613-dirty #1
> >> [    8.113230] Hardware name: linux,dummy-virt (DT)
> >> [    8.113390] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >> [    8.113429] pc : may_access_direct_pkt_data+0x24/0xa0
> >> [    8.113746] lr : add_subprog_and_kfunc+0x634/0x8e8
> >> [    8.113798] sp : ffff80008283b9f0
> >> [    8.113813] x29: ffff80008283b9f0 x28: ffff800082795048 x27: 0000000000000001
> >> [    8.113881] x26: ffff0000c0bb2600 x25: 0000000000000000 x24: 0000000000000000
> >> [    8.113897] x23: ffff0000c1134000 x22: 000000000001864f x21: ffff0000c1138000
> >> [    8.113912] x20: 0000000000000001 x19: ffff0000c12b8000 x18: ffffffffffffffff
> >> [    8.113929] x17: 0000000000000000 x16: 0000000000000000 x15: 0720072007200720
> >> [    8.113944] x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
> >> [    8.113958] x11: 0720072007200720 x10: 0000000000f9fca4 x9 : ffff80008021f4e4
> >> [    8.113991] x8 : 0101010101010101 x7 : 746f72705f6d656d x6 : 000000001e0e0f5f
> >> [    8.114006] x5 : 000000000001864f x4 : ffff0000c12b8000 x3 : 000000000000001c
> >> [    8.114020] x2 : 0000000000000002 x1 : 0000000000000000 x0 : 0000000000000000
> >> [    8.114126] Call trace:
> >> [    8.114159]  may_access_direct_pkt_data+0x24/0xa0
> >> [    8.114202]  bpf_check+0x3bc/0x28c0
> >> [    8.114214]  bpf_prog_load+0x658/0xa58
> >> [    8.114227]  __sys_bpf+0xc50/0x2250
> >> [    8.114240]  __arm64_sys_bpf+0x28/0x40
> >> [    8.114254]  invoke_syscall.constprop.0+0x54/0xf0
> >> [    8.114273]  do_el0_svc+0x4c/0xd8
> >> [    8.114289]  el0_svc+0x3c/0x140
> >> [    8.114305]  el0t_64_sync_handler+0x134/0x150
> >> [    8.114331]  el0t_64_sync+0x168/0x170
> >> [    8.114477] Code: 7100707f 54000081 f9401c00 f9403800 (b9400403)
> >> [    8.118672] ---[ end trace 0000000000000000 ]---
> >>
> >> Fix this by adding dst_prog non-empty check in BPF_PROG_TYPE_EXT case
> >> when calling bpf_prog_load().
> >>
> >> Fixes: 4a9c7bbe2ed4 ("bpf: Resolve to prog->aux->dst_prog->type only for BPF_PROG_TYPE_EXT")
> >> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> >> Cc: stable@vger.kernel.org # v5.18+
> >> ---
> >>  kernel/bpf/syscall.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index f45ed6adc092..4490f8ccf006 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -2632,9 +2632,12 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
> >>  			return 0;
> >>  		return -EINVAL;
> >>  	case BPF_PROG_TYPE_SYSCALL:
> >> -	case BPF_PROG_TYPE_EXT:
> >>  		if (expected_attach_type)
> >>  			return -EINVAL;
> >> +		return 0;
> >> +	case BPF_PROG_TYPE_EXT:
> >> +		if (expected_attach_type || !dst_prog)
> >> +			return -EINVAL;
> >>  		fallthrough;
> >>  	default:
> >>  		return 0;
> 

