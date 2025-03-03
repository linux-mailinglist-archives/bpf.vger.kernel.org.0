Return-Path: <bpf+bounces-53119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A277A4CE0E
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 23:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC867A90C9
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 22:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62C71F0E56;
	Mon,  3 Mar 2025 22:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUigq1ck"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35101DFE1
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 22:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040226; cv=none; b=YjTSHmj6IlIzTzyN3pEfJ3KjsIOxQrlN4Vr3TNoV5EgJkRF0kHcxjaNf6zP1S7Vlba8VskJU36KHOe9tzIieT8MO7R59UwJGbNx55vG1gOjYZc3w0LThYrPxaNuf8xINXsgM/OBGOBGZwoEu8c1rfjwx24JA5RMOOcM+3ewJqBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040226; c=relaxed/simple;
	bh=Pu+2gPAMyjcIfhSxV1ioycn2jbZK7PVy105ahAQg0Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkdqtR1IO4IgqYAiWpgPM4OyvELVUlvida8e+C1j3qkkYwDr2tbhOhOOd0wEB4pAqj+aAJtrztIiA8wddIIiu8gA7sghPdLQL+xnS++PB5/1IQgDBshCYwCejFIiYOvyPgXT3wZ0U3FtsJf6JHN4tWA41CnBssYnIntiZkINohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TUigq1ck; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223722270b7so20545ad.1
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 14:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741040224; x=1741645024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y2g5LjnoCgSVPYj+V0KyZ1ldqlVr5HdI2cHTBekjJ8s=;
        b=TUigq1ck0UbvVNHp3YkUjaQHDYjxGjXCoaLCi2t/wktu4wp93M0Lu3V67Jljmyf96f
         /7TL3ra4+aR+3HMPcSVXE/AUXgdM2xcJc/yLuJBuiyXSPpLhM67sq3vcXe668qXW32aG
         dfFG5624Jk1mhnh7PuwOwZKThi2cVt1Bj92OhcSOkgb1rZHPOvOsrdYovmCj/Aab2AAC
         nY23I/nI3p3OINuZIKB3VC2oU37ol3JfwfQZoSdDprc1Cr/eTXcKtSg6AKTvp2dLe7pF
         bAdrcZ+P4c6cy9h8K2qQiDk1BpaZkiKre4YeZX48sqeOQkIBy4/PTkoIJXdUnoDnJg19
         6imA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741040224; x=1741645024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2g5LjnoCgSVPYj+V0KyZ1ldqlVr5HdI2cHTBekjJ8s=;
        b=tjlHSofxgxyvb4aNumNmHUW9J+W2803gvcLC6XElm1Inqj+apQ5vMzUW+JDceedwVl
         I808CqYBXGPfJ5C9sScdygPH2HQqDm7HrTU522Bu2fim9cO5yk2tjTzZsxSUx4Rm+Pxn
         iyhk/Clr+Pe0CoCqOyq4n83rrEhPi5Y6guJ+OsbchCoHo9Kv8BFEaqHqKeLeyvhtuw67
         KSh/xVGfSg8ZKK0wb5lTxh+7RitCdnN5S8NMaF6rquF2gxllsSWf72FEc+qRWZbG0egL
         d6n95WDa/ZXPuI5Mw3HPHbhAd4hKyUUpEzKG+1LahyvIuubXmvBELOSKnkRrGgn0fywS
         MiPw==
X-Gm-Message-State: AOJu0YxMc9ZmmuX57HC1PCBhHsOKaUVrDY3tRQGNPyR3Y50wnBKgwmwe
	QCz252zUqwlVEMmKqgMWjucFVVyAAszKOoD/HY1fsOOCzXBcsHJoe6BZaWUT7Q==
X-Gm-Gg: ASbGncu1Abqf7uag/KEd8kQi2tJ9hoFIpKpfqdbmgcDeisjLBccbjDpyAZbmiNh3Va7
	7f1EQtFc7zS8S9Yh9B9TA3L8vnlbR/IP8PHASHnj5+iY42/SpyjV7Wy3opj3kIXv4q5ZOx/Xtqh
	TiZDO/yte29VtxLX3F+OzWP2p/H3qVvI1E0bNzQfbipdoMU4iA7t6xY8uX9cxuwdjqLoPiJch4x
	wUKjbM34J0KaX6CaGX82F/VqolWO6Ev3voLQitmkoo7rG3a+RPDD3OiLMz3zxMXmc1qB5tX3Xpp
	3ulnItWWXaWSmkrI+m+hQBlftVnlG3r6nSybOtpA0z0H89rd5dMtE2vGm+doTC1mP7weoryaBSe
	IlWZecho=
X-Google-Smtp-Source: AGHT+IEoTfo4TNw4P4ewmD3fmkA6z28ycidagkXgXZhflGUxyOEfcxd5Zz7ComAIMQ04cJm1JLLsvw==
X-Received: by 2002:a17:902:f7d2:b0:20c:f40e:6ec3 with SMTP id d9443c01a7336-223d9e6616cmr720025ad.22.1741040224035;
        Mon, 03 Mar 2025 14:17:04 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734d444a9fasm7386454b3a.60.2025.03.03.14.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 14:17:03 -0800 (PST)
Date: Mon, 3 Mar 2025 22:16:57 +0000
From: Peilin Ye <yepeilin@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	oe-kbuild-all@lists.linux.dev, bpf@ietf.org,
	Alexei Starovoitov <ast@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	David Vernet <void@manifault.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v4 04/10] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z8YqWQuyArxCQWeD@google.com>
References: <2c82b29f3530b961b41f94a4942e490ab35a31c8.1740978603.git.yepeilin@google.com>
 <202503031631.OeUhVRHz-lkp@intel.com>
 <CAADnVQLLhNRmpjwDYHB0-59TDrGcgXzqSkop+-5eHYsG-Ws08Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLLhNRmpjwDYHB0-59TDrGcgXzqSkop+-5eHYsG-Ws08Q@mail.gmail.com>

On Mon, Mar 03, 2025 at 10:43:07AM -0800, Alexei Starovoitov wrote:
> > compiler: arc-elf-gcc (GCC) 13.2.0
> 
> ...
> 
> >    kernel/bpf/core.c:2228:25: note: in expansion of macro 'LOAD_ACQUIRE'
> >     2228 |                         LOAD_ACQUIRE(DW, u64)
> >          |                         ^~~~~~~~~~~~

*facepalm*

> Peilin,
> 
> how do you plan on fixing this?
> So far I could only think of making compilation conditional for CONFIG_64BIT
> and let the verifier reject these insns on 32-bit arches.

Agreed - after searching for "Need native word sized stores/loads for
atomicity." on lore, it appears that we can't have 64-bit
smp_{load_acquire,store_release}() on 32-bit arches.  My draft fix is:

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 323af18d7d49..6df1d3e379a4 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2225,7 +2225,9 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
                        LOAD_ACQUIRE(B,   u8)
                        LOAD_ACQUIRE(H,  u16)
                        LOAD_ACQUIRE(W,  u32)
+#ifdef CONFIG_64BIT
                        LOAD_ACQUIRE(DW, u64)
+#endif
 #undef LOAD_ACQUIRE
                        default:
                                goto default_label;
@@ -2241,7 +2243,9 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
                        STORE_RELEASE(B,   u8)
                        STORE_RELEASE(H,  u16)
                        STORE_RELEASE(W,  u32)
+#ifdef CONFIG_64BIT
                        STORE_RELEASE(DW, u64)
+#endif
 #undef STORE_RELEASE
                        default:
                                goto default_label;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dac7af73ac8a..d0e4c6bab37d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7814,8 +7814,16 @@ static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
        case BPF_CMPXCHG:
                return check_atomic_rmw(env, insn);
        case BPF_LOAD_ACQ:
+               if (BPF_SIZE(insn->code) == BPF_DW && BITS_PER_LONG != 64) {
+                       verbose(env, "64-bit load-acquire is only supported on 64-bit arches\n");
+                       return -ENOTSUPP;
+               }
                return check_atomic_load(env, insn);
        case BPF_STORE_REL:
+               if (BPF_SIZE(insn->code) == BPF_DW && BITS_PER_LONG != 64) {
+                       verbose(env, "64-bit store-release is only supported on 64-bit arches\n");
+                       return -ENOTSUPP;
+               }
                return check_atomic_store(env, insn);
        default:
                verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n",

Thanks,
Peilin Ye


