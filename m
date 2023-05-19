Return-Path: <bpf+bounces-928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A39708CE2
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 02:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7826281ABB
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 00:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BC9362;
	Fri, 19 May 2023 00:27:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFC67C
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 00:27:13 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD7210F4
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 17:26:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f3a166f8e9so332525e87.0
        for <bpf@vger.kernel.org>; Thu, 18 May 2023 17:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684456001; x=1687048001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMiihLBJVrhHZP4pWLVWa9QPrNMaGF29hhd3EjtqMr8=;
        b=m+aOUWyCOjsSoUa8VYD84YbCp+g8y9ZnMw8Z1k7eT3HKvnJVakBFTyT/TwvELF7bEa
         ablXHqNAhNgOrSjh9pNkjQlyM/+LYaMRR3kyOBnTajFlDasDL4AvnbFccUTFiEfPTpps
         DkaQ2+Am/LweHoFt/B0PzZyvG8rJa6MNtaRPtfeKtqCPZMxDSdIUGVbnmwSy+hux7Gpw
         DOVfL9+Ga+AnUgyvXlbT5ulaOpIa5YNRWvQmLAQICWWWDZzbVU/jqrccTLD5voFZS1Ka
         BeXPtzfu+tQhJZIa3fXLs3qALBmXZkOLDJMRvWb6YcnJos11sMeLmr8fpVkcCe49/VDX
         MZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684456001; x=1687048001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMiihLBJVrhHZP4pWLVWa9QPrNMaGF29hhd3EjtqMr8=;
        b=Z93g4owqMCEFp74IBSr5T9fXtTXJ3hqMNlZzoNcq8lVDrZk292NFGklKQNnD1YsLYI
         i5/3jMx+DBWYSQl4j87SiEkTaGrWWvGyhWVILErXyRIBrTgXes6nkLSZNiScRu1/44xu
         qbQfXPeg+U29uldgdbdd6bA0zLirMheM4UuZylpNZuuUwq0FiAU90NU1JWaBdorfmGPK
         YyAY/DnqEuWX4V/y4CfAajJPv3ygtkXJTYrL2vOiwDisWFFbUwnH0GG3/rVzDRKNo8DL
         y9RBk6x4MxnT7zy6DT9lKDkWEKQoEdzxyBWV2/BSuBEXqyMTQmDnhE52GsEl50ohRZNR
         ISFg==
X-Gm-Message-State: AC+VfDwFKFQ0IwyJ2gR0gvMuicoNA47GnW3aK3YfAFz2JG+xHueaNUzr
	vs7OAqgDSrEBTKd4jnOCFgtEDkNyA+Ko6rSrnk0=
X-Google-Smtp-Source: ACHHUZ5hRUydHTniW3MSMILptZtfQN7UE+lyXVBXE3hg9wD3Xi2uZE8RW0LdTiGlB1U7UIKkGG+Doa78Ypez0N35OkY=
X-Received: by 2002:ac2:55a5:0:b0:4f0:1a45:2b10 with SMTP id
 y5-20020ac255a5000000b004f01a452b10mr219111lfg.10.1684456001231; Thu, 18 May
 2023 17:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230517161648.17582-1-alan.maguire@oracle.com>
 <20230517161648.17582-6-alan.maguire@oracle.com> <ZGXkN2TeEJZHMSG8@krava>
 <35213852-1d29-e21f-e3f8-d3f164e97294@oracle.com> <ZGZQuqVD7gNjia7Z@krava> <ee0a24c9-1106-c847-2c91-0d828ec7fba3@meta.com>
In-Reply-To: <ee0a24c9-1106-c847-2c91-0d828ec7fba3@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 May 2023 17:26:29 -0700
Message-ID: <CAADnVQ+xJVVbP8GC_iT3NgYhhyUxEWkT-kvNgRfDVyv4eyAgHA@mail.gmail.com>
Subject: Re: [RFC dwarves 5/6] btf_encoder: store ELF function representations
 sorted by name _and_ address
To: Yonghong Song <yhs@meta.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Yafang Shao <laoar.shao@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 18, 2023 at 11:26=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote=
:
> > I wonder now when the address will be stored as number (not string) we
> > could somehow generate relocation records and have the module loader
> > do the relocation automatically
> >
> > not sure how that works for vmlinux when it's loaded/relocated on boot
>
> Right, actual module address will mostly not match the one in dwarf.
> Some during module btf load, we should modify btf address as well
> for later use? Yes, may need to reuse some routines used in initial
> module relocation.


Few thoughts:

Initially I felt that single FUNC with multiple DECL_TAG(addr)
is better, since BTF for all funcs is the same and it's likely
one static inline function that the compiler decided not to inline
(like cpumask_weight), so when libbpf wants to attach prog to it
the kernel should automatically attach in all places.
But then noticed that actually different functions with
the same name and proto will be deduplicated into one.
Their bodies at different locations will be different.
Example: seq_show.
In this case it's better to let libbpf pick the exact one to attach.
Then realized that even the same function like cpumask_weight()
might have different body at different locations due to optimizations.
I don't think dwarf contains enough info to distinguish all the combination=
s.

Considering all that it's better to keep one BTF kind_func -> one addr.
If it's extended the way Alan is proposing with kind_flag
the dedup logic will not combine them due to different addresses.

Also turned out that the kernel doesn't validate decl_tag string.
The following code loads without error:
__attribute__((btf_decl_tag("\x10\xf0")));

I'm not sure whether we want to tighten decl_tag validation and how.
If we keep it as-is we can use func+decl_tag approach
to add 4 bytes of addr in the binary format (if 1st byte is not zero).
But it feels like a hack, since the kernel needs to be changed
anyway to adjust the addresses after module loading and kernel relocation.
So func with kind_flag seems like the best approach.

Regarding relocation of address in the kernel and modules...
We just need to add base_addr to all addrs-es recorded in BTF.
Both for kernel and for module BTFs.
Shouldn't be too complicated.

