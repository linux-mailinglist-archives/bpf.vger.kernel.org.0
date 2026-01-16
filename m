Return-Path: <bpf+bounces-79313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF7BD37A1D
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 18:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03DDD30A36C6
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 17:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92F727E1DC;
	Fri, 16 Jan 2026 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cmArL0V4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4866369988
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584619; cv=pass; b=MtnLwiBI7VD+bCbSyZYuYREnYGQuuxnYOU4jZp+pBC6Dh8RT2qwAUMKEP+o8/ds899ErB+4TUpTcpwcp3l803Y5P3QSvwp82wOwszjdM+pXnvUf5d6eWG0Kc1wbNluN7iQ+DGkt2melUADxGr/CPG5J+j4c6ToQnw8j2MiWTsD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584619; c=relaxed/simple;
	bh=dI/o20x9Y2HfQtj2OfDVbvhM6LWHTEelpWzil3w2nKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3pJqZeU1xHvrjbrANGRaSveHHrCs4J+AWx8qPeqQgfPWQ93p1wZS7i+qGR8HSKQ1jAIWFjw1/wpJDeNxRYaOtv82URe0hzz9FMPoGols+Be8SpSMNJTD7OldkCe0PRx3VTcOM36kIiX10sS7lTxg+bIuHjO+qD6PyZHAi9xX7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cmArL0V4; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12331482a4dso10060c88.1
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 09:30:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768584617; cv=none;
        d=google.com; s=arc-20240605;
        b=e01dN3AxdeKB4Fcve07dFYgoWovZDILeH0fVcQd6WKk2hlpoTR/zAM+FNwojcYZu6e
         I1NBDaz7VTWZ5LXv3zQqaxIpGq/1LSGke2SNEd5rnK0Rlp/+8YEbCeObayLl4oW6JbpZ
         UwMebkmQRFT5a+kaBJtt1udzEQRMqZTdiFYqxslLSFP/JeITLrB02JKEriXfBTRwJc8U
         qUONVJe1v8xHF7T8J0LpM55VQwdy0YhGP1JTTr2H283JeaQYs9ia27ZeUaLi2fmzwRd9
         ypOL0cCurtFj4PqSizsV/W+ur34/gesPnDJTUKmwBz45yi+k05C86ZqUAxA+dZPtKnN2
         o4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=53uWNErBo7wI6ZcBPOrPDVWa4idMxyXiq3MzbljTtl8=;
        fh=nlkk9793zJ1tq7F1Min4pOKYTuQaY/m0mwXB1Am2iIE=;
        b=i3Sh3GS5p1rbaB8yoxqhQd7chiE5QMSatgJF8GSQMk017l4jyn1C42Vm7rWIHRKZFg
         GSDWVKPCVw4JCWA0yjNLgC5LZCwGfIQtCLDQutR2KLn13StKQ86jih8uBLOIy1fpdjoI
         +W6ULXk/Nf7uDeeYavu8E9UoxeoBjbhRO7yt8rVihcRleEpkekEXgEjJHbrierTBhYFI
         F461TCaa6PGTpnp7xCA+0vxZwIVuDyHzurWD/MLixYCtDX43SNCo2ViSVH8dKf6AuDfx
         EsfGXmnlq2drp5oaZPE77cChVa8J5rC50inqCPMv8B6FT2GJXfhHhN15MhGkob7P3yvx
         PbxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768584617; x=1769189417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53uWNErBo7wI6ZcBPOrPDVWa4idMxyXiq3MzbljTtl8=;
        b=cmArL0V4qqR7/5sIHYIcA9rSymTbXYqV70HFF6xTyNOeH7qA8YhTd2FikYD+dFGSN0
         rH0m2KEr6pebHHNc6PjO9D3pXGb/1uwMn22YSAHJsCN9rv3CrljviOdEkt6CuobMlP7d
         LUF26xUKKVOWhcHHhAikD+ooSzblcGMXVtLYclQnfxZn1a5/7+6iwYF2dIaiWzGzmbNP
         gJgHgPOWcKX0yNKrfAoWECZE1lRPvSs+05/GXdEuQS3Q8P9gg0N1Wt3TsaGWvDIBU6s9
         7B+in8LSaKU9fhYVhXCXdG0G1HY5+8K57h7KAaD4Yuu4kCbPb/vYCHT/BnyhHSWsE5L8
         1DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768584617; x=1769189417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53uWNErBo7wI6ZcBPOrPDVWa4idMxyXiq3MzbljTtl8=;
        b=bk7BIpTgfJ+J4HTvZLHKF0LkQIi/cF9VwhQq0I1Rs80LcC1ETZ6wdVV9IN0dUhT9oo
         UFVuE0k8wTC+TLg+tMzcfly4HFM0rPcmEL8y4QTIMdLbwpB9noXpItmQgCED/jiI+FIR
         OW+GHxAnImpwTg6Ppkdo/RcYy+9ABHSHaL4cVulM7pz4FLt2MfsSbplZvoNezPDerQsg
         h3Qo4OU/fLIKTFtLqJTJML6o5j4hFrbJTS7B0ZBBMHUNi3GaozaqzqFCVOad4Q/WYRwp
         mto5Msa882jemCJaoqxLoZB6jyaBh5sS6yWMZH8Qr6Bgx+LX8u7I7sU2mgcFSKGrCE8x
         7dFg==
X-Forwarded-Encrypted: i=1; AJvYcCWYgsS1fAzuPmAAma5sNdC6Ex+1yghLqy2KWBiHoCcoVVi1a2Z7h3G0AyzEePkcl5gpSpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVwe55JiIUlCIVz1QmozL0EYj5/hwqwFZ8d6mjKpRN/fUB52i
	AfAHWG1mcW6W412zp4KhGpjfWM0+UezQdlQuWYVGFCvas0m1TWmM6plA0h3GQmw0+ADqTWNyOg0
	3TEJJP0e2y0/6iHfjrki3YnSCNA5AJwbQwbf4B4uy
X-Gm-Gg: AY/fxX6cJnI2pUhHkqKRCDiR172aAdvUEHVqUtpQtSqi96Ns/SY6eU/mU2h79LFmMS1
	X6kaJSLw2cg3YsC5Xy22q6Bqfrn99JKq5fzqy3GUO85lq8l4gxQ3arvbf6LBfGkmaMHxUw/KTCs
	HO5JgrP7UjupxYVtfwGqJ2/uUl2QsTva5k9BxAfZBTcjDCJBd+3P0BMeZSZu8J/KFzATOJJWGvG
	pocOz2+8B5dz+H5N7ABmHPHvl4KxCPDVgWHOHkltpVBsvJNHSGvf+Sry06tZ9ZPn/gFT1bjhbYk
	2xTSrNm1qYOknl1RlA2coSKZ5/P0YxX6+lSKgig=
X-Received: by 2002:a05:701b:2212:b0:120:5719:1852 with SMTP id
 a92af1059eb24-1244b44d299mr107912c88.16.1768584614413; Fri, 16 Jan 2026
 09:30:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-8-kalyazin@amazon.com>
 <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
In-Reply-To: <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 16 Jan 2026 09:30:02 -0800
X-Gm-Features: AZwV_Qg33M1rO31dgikgfsTaot12EQbVpaEnX3TxsJMPXzhkvu_Y-NHzJrI17yU
Message-ID: <CAGtprH_qGGRvk3uT74-wWXDiQyY1N1ua+_P2i-0UMmGWovaZuw@mail.gmail.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct map
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"kalyazin@amazon.co.uk" <kalyazin@amazon.co.uk>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "david@kernel.org" <david@kernel.org>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "jgross@suse.com" <jgross@suse.com>, 
	"surenb@google.com" <surenb@google.com>, "riel@surriel.com" <riel@surriel.com>, 
	"pfalcato@suse.de" <pfalcato@suse.de>, "peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "thuth@redhat.com" <thuth@redhat.com>, "maz@kernel.org" <maz@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "ast@kernel.org" <ast@kernel.org>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, 
	"alex@ghiti.fr" <alex@ghiti.fr>, "pjw@kernel.org" <pjw@kernel.org>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "willy@infradead.org" <willy@infradead.org>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "wyihan@google.com" <wyihan@google.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, "jmattson@google.com" <jmattson@google.com>, 
	"luto@kernel.org" <luto@kernel.org>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, 
	"haoluo@google.com" <haoluo@google.com>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>, 
	"mhocko@suse.com" <mhocko@suse.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"hpa@zytor.com" <hpa@zytor.com>, "song@kernel.org" <song@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "maobibo@loongson.cn" <maobibo@loongson.cn>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"Yu, Yu-cheng" <yu-cheng.yu@intel.com>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"shuah@kernel.org" <shuah@kernel.org>, "prsampat@amd.com" <prsampat@amd.com>, 
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "itazur@amazon.co.uk" <itazur@amazon.co.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, 
	"jackabt@amazon.co.uk" <jackabt@amazon.co.uk>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "derekmn@amazon.com" <derekmn@amazon.com>, 
	"xmarcalx@amazon.co.uk" <xmarcalx@amazon.co.uk>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "jackmanb@google.com" <jackmanb@google.com>, "bp@alien8.de" <bp@alien8.de>, 
	"corbet@lwn.net" <corbet@lwn.net>, "ackerleytng@google.com" <ackerleytng@google.com>, 
	"jannh@google.com" <jannh@google.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, 
	"kas@kernel.org" <kas@kernel.org>, "will@kernel.org" <will@kernel.org>, 
	"seanjc@google.com" <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 3:04=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Wed, 2026-01-14 at 13:46 +0000, Kalyazin, Nikita wrote:
> > Add GUEST_MEMFD_FLAG_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD()
> > ioctl. When set, guest_memfd folios will be removed from the direct map
> > after preparation, with direct map entries only restored when the folio=
s
> > are freed.
> >
> > To ensure these folios do not end up in places where the kernel cannot
> > deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct
> > address_space if GUEST_MEMFD_FLAG_NO_DIRECT_MAP is requested.
> >
> > Note that this flag causes removal of direct map entries for all
> > guest_memfd folios independent of whether they are "shared" or "private=
"
> > (although current guest_memfd only supports either all folios in the
> > "shared" state, or all folios in the "private" state if
> > GUEST_MEMFD_FLAG_MMAP is not set). The usecase for removing direct map
> > entries of also the shared parts of guest_memfd are a special type of
> > non-CoCo VM where, host userspace is trusted to have access to all of
> > guest memory, but where Spectre-style transient execution attacks
> > through the host kernel's direct map should still be mitigated.  In thi=
s
> > setup, KVM retains access to guest memory via userspace mappings of
> > guest_memfd, which are reflected back into KVM's memslots via
> > userspace_addr. This is needed for things like MMIO emulation on x86_64
> > to work.
>
> TDX does some clearing at the direct map mapping for pages that comes fro=
m gmem,
> using a special instruction. It also does some clflushing at the direct m=
ap
> address for these pages. So I think we need to make sure TDs don't pull f=
rom
> gmem fds with this flag.

Disabling this feature for TDX VMs for now seems ok. I assume TDX code
can establish temporary mappings to the physical memory and therefore
doesn't necessarily have to rely on direct map.

Is it safe to say that we can remove direct map for guest memory for
TDX VMs (and ideally other CC VMs as well) in future as needed?

>
> Not that there would be any expected use of the flag for TDs, but it coul=
d cause
> a crash.

