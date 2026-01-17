Return-Path: <bpf+bounces-79373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 415E8D38FFE
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 18:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 702A630141DE
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 17:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD68278E5D;
	Sat, 17 Jan 2026 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7AYiVwB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3EC143C61
	for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768669964; cv=pass; b=WwEY1zzOb/sGPOXew6ivWXxYd4pw+Q1HyrBBPVAxk5hecFp5DNQWr90i/EnWKKQ7ssd8nREM+6CxUqFMIBcJMslwP3OQGUOdVfWsdfZbY6B4T1rxznH/g6gri1EGBPDL2LudTTlgm+jo3I9gVJhTKji2cKXfux1aHNU2qcheDZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768669964; c=relaxed/simple;
	bh=EW6eCFz2npkpZTyryF60eim7rOKGi0n2VHIwIzrEPTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBAGpqGAzUTDTH1qG4g9BhHhsi0K0DkHHkoDDHt3id6AYXSGNCm+q+JQ/wqJEzgZwnjg23FDj5EzChZ0VRIIB9c2rteq5M0gadOc0jxdwOK4g7Ru5EDvEDlMR58BGW161Jott1J+nhcXaZsd1IgVKOmqDEUXIlB2WdDCHkl01Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7AYiVwB; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso1557523f8f.2
        for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 09:12:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768669961; cv=none;
        d=google.com; s=arc-20240605;
        b=DN6xMgaZhtCINEF0Jot4kW2JDuXi/NYbE6YIxKlDAGbJ9QoE2lHLKShqy6kbxOzxgk
         tYHnLRbipknu8yHgINeLfaMYQfGcuT1NjaA7bOst5IavbAQ1o2jVS0rGlFrlsPcRQJcT
         ssJ8+m1AmBiUX3/RTPWfkAlqzLrboVBMmv5CcOVQ0OR/Vu2MnRIqGXwIHCxfT2MLSSW7
         CTAXszODsk/TAUlpj43O0VxxO32JZqTUePakfmA/ZGcL5T5VCmDR8muJfa4lh6C0B35Y
         a4UymtCg9PLe3kRC6MMxVMFbaI5RwtDKgEtd7CXsnoJwLWwfN9BC27HsdOIAlYQoOmq+
         oWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kpxcl09gBSY5ZAyBTzHgOEcHI2k1tRGF4SuYo7Aj3rY=;
        fh=ZYMvHmGEH6CwMVrVkpRD9a8mtNL0ZF+NsPgi7t/GGQQ=;
        b=LUGwRvp8tG1v2iujjCMDynZiqS4Mh244CVEv/3ewqAvtHeg8Qv+RB3hMnNqXCE/Jdy
         P601yaEmZbUIqRSPWC6xJhbFuFoDynwYNTe3MNvSrJVoATkUxsh5WDXFvMaqulPkySrt
         M545/FM1Lr7T8Y2MB6tKa+C11GwR+C6jIfJ5POgxatNVi05vkQrsXSgPdOgS5Hm/9uwQ
         6siDsciToQ4PB2+px+XFYKTc6lQQLP6Vz4QIW2ds5AFv+MvZsv+W7ISNh7bJPoooPU0/
         dHD4qQvgZD5bxjtFEQ5iH/3It5LQA+ZypaboNWQmcNbR3keeg+krtjhD0HhDqjmfR4SO
         wguA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768669961; x=1769274761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kpxcl09gBSY5ZAyBTzHgOEcHI2k1tRGF4SuYo7Aj3rY=;
        b=D7AYiVwB3HgwG9+o7RosNGrXIwGSXZ4Q/yunI6r0eQGbn2ThRTi5QDrKqgI/GW/klx
         8YPGwP/cuEeC2Y6NSrJG9MLjCcb+JDfWbvAt//adIfBGKxuaop8YqGuqqUZjuW6SjkYj
         /q/k7W/GOJa+CmxQgyeRCBSNCIVW6+apIcfA7dML4LnGX80sxqPb0lwk8BjCgZ7HJpxg
         0wc/HRyk0rjxYbg9ZdP6+Qd5/CQq5TQxrwMZb+xewsqmu3VOWYJeIc4I2hYy747ceDKI
         WFDtYkbUUCCS8VwOIRxB+vQLn6Gcd62LnwdVuxW/VDeQwwTDsGdrksNowD0lrQ+gjhQD
         eUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768669961; x=1769274761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kpxcl09gBSY5ZAyBTzHgOEcHI2k1tRGF4SuYo7Aj3rY=;
        b=C/iT1q92JKAJSwLiul04+QtYCN7698BIfNXZyUJJD8vl86DyY5JIFjX/wSB+4aTd4J
         HlcL6HEpmumzNyuEss9Z9KZEChKadXxayEW5mIPLP4xd5/hCgGmmyjczIhC6teS4kEaE
         YEU3toyDLAmgQu6nr/5MRc91xwe/gq0Vcf4aU+AN/5N0cL23ZswJUlEpx71+4NrQMany
         K3XeWHSXt38EzaWj6Zbh4FqIKIFMR8t5xiPgLQBFEkHBG2iT1PQSOwgTojAZ4rMswtJI
         rLiInbboaOC9KO+pJhM8evLgIOB5WTJf1Src3vlKg5Az1bBxKIlG1h94Eg7c4OCC5eEc
         BbjA==
X-Forwarded-Encrypted: i=1; AJvYcCVO0jlx7Dn8VMzzX3cOzwIDYtuVy7038jZWtm2bcBw+mZaRJAJvSM28YhHHE+uG55/SB4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+tck3fV64Ij7fd7cSJTyaazGVikLaguK1QYyJUfaFMoGKZ/dE
	2c+QEVz3u6V19UHq0vTruelJPuFib190fUcPmDmHOEa4mcuaxe63ekDTNQjzwHGtt5xc+VQk1n5
	HfCXyaC5IW7kWgzQGDGZXB8X1Lio4kzpEqi2a
X-Gm-Gg: AY/fxX7eYXXOA5+Bcr5z96EyDKll/qc2dqdXeNmVFLiiyMzcV0scPm1ErCHSXhDSH0E
	BZNohejH5lr7HInANtbTGcwD/cxvBykGasVkc7WpTVkG8cq4okTMi1DV3RT+Idl6clWw2tM2dB2
	thFtdGzZDlic5FGkMfBlhiaiHzDdnH+zMaT5nV2klKEM822ybln58dajfD7DuCP9PFt2v35qq/8
	M4zFjWbJgwW1J0tWHUylMas1dk0ugeF/K+M+0M6r/X5xykkbZ29EoF2uL351aoSSWzxI3R5unnJ
	jmxdcy7mjBX14MN5Ojcd6srK+8WjYhn/o+W8IeQyvpiQiKvawbE1f6A=
X-Received: by 2002:a5d:5f94:0:b0:430:f5ed:83f9 with SMTP id
 ffacd0b85a97d-43569972ed0mr7729656f8f.2.1768669961170; Sat, 17 Jan 2026
 09:12:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa4cc54a3a0796b16d2d5e13142d104fa5a483e1.camel@gmail.com> <20260117100922.38459-1-realwujing@gmail.com>
In-Reply-To: <20260117100922.38459-1-realwujing@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 17 Jan 2026 09:12:29 -0800
X-Gm-Features: AZwV_QgilT83OH-6JpM7R0L1eN--ecbWWcuj2rGAs0KwdGcr9zMOia66_xvf5S4
Message-ID: <CAADnVQ+F94-KVQTzZZSGY-rjidY_kU+zQDR68jcz8Mq1+4YmkA@mail.gmail.com>
Subject: Re: [PATCH v3] bpf/verifier: optimize precision backtracking by
 skipping precise bits
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Eduard <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, yuanql9@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 17, 2026 at 2:09=E2=80=AFAM Qiliang Yuan <realwujing@gmail.com>=
 wrote:
>
>
> Test case (backtrack_stress.c):
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
>
> struct {
>     __uint(type, BPF_MAP_TYPE_ARRAY);
>     __uint(max_entries, 1);
>     __type(key, __u32);
>     __type(value, __u64);
> } dummy_map SEC(".maps");
>
> SEC("tc")
> int backtrack_stress(struct __sk_buff *skb)
> {
>     __u32 key =3D 0;
>     __u64 *val =3D bpf_map_lookup_elem(&dummy_map, &key);
>     if (!val) return 0;
>     __u64 x =3D *val;
>
>     /* 1. Create a deep dependency chain to fill history for 'x' */
>     x +=3D 1; x *=3D 2; x -=3D 1; x ^=3D 0x55;
>     x +=3D 1; x *=3D 2; x -=3D 1; x ^=3D 0xAA;
>     x +=3D 1; x *=3D 2; x -=3D 1; x ^=3D 0x55;
>     x +=3D 1; x *=3D 2; x -=3D 1; x ^=3D 0xAA;
>
>     /* 2. Create many states via conditional branches */
> #define CHECK_X(n) if (x =3D=3D n) { x +=3D 1; } if (x =3D=3D n + 1) { x =
-=3D 1; }
> #define CHECK_X10(n)  CHECK_X(n) CHECK_X(n+2) CHECK_X(n+4) CHECK_X(n+6) C=
HECK_X(n+8) \
>                       CHECK_X(n+10) CHECK_X(n+12) CHECK_X(n+14) CHECK_X(n=
+16) CHECK_X(n+18)
> #define CHECK_X100(n) CHECK_X10(n) CHECK_X10(n+20) CHECK_X10(n+40) CHECK_=
X10(n+60) CHECK_X10(n+80) \
>                       CHECK_X10(n+100) CHECK_X10(n+120) CHECK_X10(n+140) =
CHECK_X10(n+160) CHECK_X10(n+180)
>
>     CHECK_X100(0)
>     CHECK_X100(200)
>     CHECK_X100(400)
>     CHECK_X100(600)
>     CHECK_X100(800)
>     CHECK_X100(1000)
>
>     /* 3. Trigger mark_chain_precision() multiple times on 'x' */
>     #pragma clang loop unroll(full)
>     for (int i =3D 0; i < 500; i++) {
>         if (x =3D=3D (2000 + i)) {
>             x +=3D 1;
>         }
>     }
>
>     return x;
> }

Thanks for the test. It's a good one.

> Baseline (6.19.0-rc5-baseline, git commit 944aacb68baf):
> File                    Program           Verdict  Duration (us)   Insns =
 States  Program size  Jited size
> ----------------------  ----------------  -------  -------------  ------ =
 ------  ------------  ----------
> backtrack_stress.bpf.o  backtrack_stress  success         197924  289939 =
  34331          5437       28809
> ----------------------  ----------------  -------  -------------  ------ =
 ------  ------------  ----------
...
> Patched (6.19.0-rc5-optimized):
> File                    Program           Verdict  Duration (us)   Insns =
 States  Program size  Jited size
> ----------------------  ----------------  -------  -------------  ------ =
 ------  ------------  ----------
> backtrack_stress.bpf.o  backtrack_stress  success         214600  289939 =
  34331          5437       28809
> ----------------------  ----------------  -------  -------------  ------ =
 ------  ------------  ----------

but the performance results show that your patch makes
absolutely no difference. Total time is the same and
the verifier is doing exactly the same steps.
Try veristat -v -l2 backtrack_stress.bpf.o | grep mark_precise

and you'll see that the output before and after is the same.

The parallel invocations of veristat only add noise.
4m vs 8m page-faults is a noise. It's not a result of the patch.

pw-bot: cr

