Return-Path: <bpf+bounces-66636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE75B37AD1
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 08:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97395E4E43
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 06:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C70313522;
	Wed, 27 Aug 2025 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxRdLwbu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C4275AED;
	Wed, 27 Aug 2025 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277545; cv=none; b=gBOegQn4CuKF/frjO688eC48mLGCk8mO5YTwqXwedjnoXd+Zocj9WtJzjfjIkRm8MCPAwOhBvvSP0EuSK9zDMQrnSrU0wEtsEDOeIeAptjvPJ92LOQp1841ONWD3gPAKdCui6RO4pyy5oH2MQKYFM9+bqp9Wix3VJRhGGPRfXT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277545; c=relaxed/simple;
	bh=T+2u93IfVeCj3TdA0aMvFY6a0vSk1JJX6KGWGZ/oqf4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EEsAWE+KGPBpPhGoubYft/7nikG6vIWAU3cmwrmv2x1fC6CVUhvuDhPQCR/DVUhH0RIiVR9lmmK4LnCRKuzfIu4qN5wpQ1c7HffvV8/oJCmxUMxuLlYfnsqB8s0Mo0o8TSeR7YiQJfpHmQvKyK60Pd0nEm98b5HG5WwW1K3y+jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxRdLwbu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-246fc803b90so24069015ad.3;
        Tue, 26 Aug 2025 23:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756277543; x=1756882343; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RsgCuG6amV5ZXRiMAmM4AutUJpp22NoeKUm8ub/DhiU=;
        b=QxRdLwbu3n23bhjRvwAWw7rJfBjwiGqk59imr574enP3KVloAuWO3/f/BRlZLFWaDr
         AawBmgm24r/4uXvOue80xmBTngYEr1BxdrrzDgN40l3uE2OmdriXbYl7UYY10z97wgyL
         8u5k2AsmNZbjUwKM8kCs6E78P6zsGhMuFwKIbC18BGug2vcuU/b621CvFcYaffujZCO/
         +jVINXnbjWsl5ZCRN7PkuNKHnsQnX7j6jC+z2Uxf9rHsTqWHjfhkKbMnaabEuuRirEtR
         w6EDOBh2P9UzdnicmwvdISk2hZT0wi8S4mW5xQgOfPyZvyKj9Aqkk44yi/9ns7XSCYGV
         jYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756277543; x=1756882343;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RsgCuG6amV5ZXRiMAmM4AutUJpp22NoeKUm8ub/DhiU=;
        b=CH9sCyG32lsYZw+gfhXZBlHCHi+hkWSkTvCMR7lWjLOAr7gQVKFfntXYEZpC46Xt9i
         0BRdKT0rZxK+qndD/uENcmG4qom7CmyVfBUx4zd6hYQ1Ot9C3MckF//wZFHVeiJC2w/b
         OJat3J+OT8NN+Kr4KFbxqnVtsWyylsW45Fx62bU8OvQad/oKYCmlafp9n9QoPug4ggvA
         cPwCeN0+nOiZsJ3VR6prOwAAWlI06Nn53Fyba4OiCP9M8t3jBhgMTIIjR53rvelyCSoi
         y/UsSDpmws/1oh+jROvQCgwziNq2u/DSnBHER3cWlUBHKvgAZUmN8QXOZalt0WFJ1Exp
         xGCA==
X-Forwarded-Encrypted: i=1; AJvYcCU7jx5iyZCLO/dyMEAfyIIVaRMPNDECKJgENpvto4XtZuIbusabmi5OsRttDxyzqz6xfxxIIymTWYesOwaN@vger.kernel.org, AJvYcCW9+pP+qBJHA8GUi+MGglc2MLQS5/r3KX6omHkxDfGw8W76oHx5qbe8GqR/V23WN5oqAE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGQ76mIIPr8MmEWEu0Zad2RNqJh4WbqJqcd0Dpsrc/2nAnvptG
	TDi10slFX80JUuLek2SNg4GyPCpsV0uAzzcEZ06sfu2MUHUxCgjsbA6K
X-Gm-Gg: ASbGnctOIqBSU5Esfs0SfzO9TxGxqTkS99FxXBAwS9LJBEjI2fkBnDz2y53pUGodAyP
	K9fjhzUUiu1ogqzTHW0VOkrhDucKfbeVsh4/oCDwC8sHodSz+/zEqRncoHZPHl4xRpjkihmU1ps
	/m42135wPmL2f4+WkYNXJVTp2FZsBguXUFIFtIqj/LjVMVMVrS7moTjne7Gvp0B9M5+7a9H7HC1
	medHRT3tMp2R7BSZqj77VYtoJaoosSeL7U3muV1UnLo9peWE4BN38ARk51Y4YJPM89gLMhmOsMf
	bm1m8dy2DVU6Md8UxCBr+4fprtkguwNFBAwHdBp52f8/W0m2JujveCBiD37ozUT/WlQRZZZs5Dh
	s+mLCrMPXhk2uWvx1eA==
X-Google-Smtp-Source: AGHT+IHoJnXkEaTbOBWPNouuj+qrRmx72r1uxYPQxAX+Ce+0u6O+vnrGMDVdszghlu9cw8W/HceQAw==
X-Received: by 2002:a17:902:cec2:b0:242:9bc4:f1c9 with SMTP id d9443c01a7336-2462efdbcc7mr250167235ad.56.1756277543107;
        Tue, 26 Aug 2025 23:52:23 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2467d4030fesm106277545ad.137.2025.08.26.23.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 23:52:22 -0700 (PDT)
Message-ID: <622cc7980bad96bb2c7ac8d23619da1374c794a4.camel@gmail.com>
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  David Vernet
 <void@manifault.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 26 Aug 2025 23:52:17 -0700
In-Reply-To: <aK6aiEbgYaI9K-pt@gpd4>
References: <20250822140553.46273-1-arighi@nvidia.com>
	 <86de1bf6-83b0-4d31-904b-95af424a398a@linux.dev>
	 <45c49b4eedc6038d350f61572e5eed9f183b781b.camel@gmail.com>
	 <aK6aiEbgYaI9K-pt@gpd4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-27 at 07:41 +0200, Andrea Righi wrote:
> On Tue, Aug 26, 2025 at 10:02:31PM -0700, Eduard Zingerman wrote:
> > On Tue, 2025-08-26 at 13:17 -0700, Yonghong Song wrote:
> >
> > [...]
> >
> > > I tried with gcc14 and can reproduced the issue described in the abov=
e.
> > > I build the kernel like below with gcc14
> > >    make KCFLAGS=3D'-O3' -j
> > > and get the following build error
> > >    WARN: resolve_btfids: unresolved symbol bpf_strnchr
> > >    make[2]: *** [/home/yhs/work/bpf-next/scripts/Makefile.vmlinux:91:=
 vmlinux] Error 255
> > >    make[2]: *** Deleting file 'vmlinux'
> > > Checking the symbol table:
> > >     22276: ffffffff81b15260   249 FUNC    LOCAL  DEFAULT    1 bpf_str=
nchr.cons[...]
> > >    235128: ffffffff81b1f540   296 FUNC    GLOBAL DEFAULT    1 bpf_str=
nchr
> > > and the disasm code:
> > >    bpf_strnchr:
> > >      ...
> > >
> > >    bpf_strchr:
> > >      ...
> > >      bpf_strnchr.constprop.0
> > >      ...
> > >
> > > So in symbol table, we have both bpf_strnchr.constprop.0 and bpf_strn=
chr.
> > > For such case, pahole will skip func bpf_strnchr hence the above reso=
lve_btfids
> > > failure.
> > >
> > > The solution in this patch can indeed resolve this issue.
> >
> > It looks like instead of adding __noclone there is an option to
> > improve pahole's filtering of ambiguous functions.
> > Abstractly, there is nothing wrong with having a clone of a global
> > function that has undergone additional optimizations. As long as the
> > original symbol exists, everything should be fine.
> >
> > Since kfuncs are global, this should guarantee that the compiler does n=
ot
> > change their signature, correct? Does this also hold for LTO builds?
> > If so, when pahole sees a set of symbols like [foo, foo.1, foo.2, ...],
> > with 'foo' being global and the rest local, then there is no real need
> > to filter out 'foo'.
> >
> > Wdyt?
>
> I think we should do both: fix resolve_btfids to ignore compiler
> optimization suffixes (.isra., .constprop., .part., .cold, ...) and add
> __noclone.
>
> This feels like the safest path IMHO. Fixing resolve_btfids alone works
> with current compilers, but future compiler versions, under aggressive
> IPA/LTO optimizations, might decide that the main global symbol is
> redundant and drop it altogether, leading to similar issues.
>
> Basically, fixing the tool makes the BTF pipeline more robust, adding
> __noclone also makes the exported symbols themselves more robust,
> regardless of compiler optimizations.

If we are being really paranoid about LTO builds, is __noclone sufficient?
E.g. [1] does not imply that signature can't be changed.
We currently apply only __retain__, here is a little test with both attribu=
tes:

    $ cat foo.c
    __attribute__((__noclone__, __retain__))
    int foo(int a) {
      return a;
    }

    $ cat main.c
    int foo(int);

    int main(int argc, char **argv) {
      return foo(0);
    }

    $ gcc -O3 -Wall -flto foo.c main.c -o a.out
    $ nm a.out | grep foo
    $ objdump -Sdr a.out | grep foo
    $ objdump -Sdr a.out | less
    $ nm a.out | grep foo | wc -l
    0
    $ objdump -Sdr a.out | grep foo | wc -l
    0

export.h:EXPORT_SYMBOL does the following trick:

  extern typeof(cachemode2protval) cachemode2protval;
  static void * __attribute__((__used__))
         __attribute__((__section__(".discard.addressable")))
         __UNIQUE_ID___addressable_cachemode2protval489 =3D (void *)(uintpt=
r_t)&cachemode2protval;
         asm(".section \".export_symbol\",\"a\" ;\
              __export_symbol_cachemode2protval: ;\
              .asciz \"\" ;\
              .ascii \"\" \"\\0\" ;\
              .balign 8 ;\
              .quad cachemode2protval ;\
              .previous");

Should we employ something similar?

[1] https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#inde=
x-noclone-function-attribute

