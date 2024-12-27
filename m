Return-Path: <bpf+bounces-47645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB439FCF3D
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 01:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7F8163940
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 00:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A999B8488;
	Fri, 27 Dec 2024 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eIDlMCtl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00938C0B
	for <bpf@vger.kernel.org>; Fri, 27 Dec 2024 00:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735259011; cv=none; b=cledBzeVQctA//6HXyEwLodzo2Nt/EwOrSg8dUDKtdmifP6wo7dzHr8pHuC2I/AZb6H7CYU4HswdM9/94d/nVYp7OhPBOUUvKDLlHJa1LxNVa/0xlHgsX00SbZQ02eQ6C1n1kKhiFPadJXaOIYu9CpbAUh1f26EwFOaqSuWL3ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735259011; c=relaxed/simple;
	bh=RjmESX1QcfzoOG/ifZILFYkxkqyTluMBYAu+dEk96Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bwn/OlU/6V4jlXxABUMhGRudz0tOiBc3Yd8NGh6meM/AoloxZMQQb0htXZWA/7JKHgGnJBT8fbQvtLRKH/yJ4Jb2yGo6sAWzMF+tH5ScgqzxI20BkwTGnuSuihldQgRFN+rkt4vAN2Is15Iu4KofV9ZxZM4kt76CjbXaA472dXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eIDlMCtl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-219f6ca9a81so528215ad.1
        for <bpf@vger.kernel.org>; Thu, 26 Dec 2024 16:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735259007; x=1735863807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wnK8GTp4kq3AREja2sD0O7Kb+4zQCe/fm63LSJLYU5k=;
        b=eIDlMCtlXiaRkdfND4rkTdj5lIlqezfcv0mDVh9jk1E4mgasxv01Gf8H0zu5AkqB2f
         N4XMvwUmiEGmkJCYXh0y00MJYmdSl/hEy6d4WpDT75Jt/HlcD0BK65W3aNppz4LQ2E98
         qme4qcqj3iKMnxzk+V9O3jP4U+M0S6SgLvTsEB4pJ1y6kLlN2aGPtlDOoYgdNxdyY2As
         x8ZLbLErSMatrFOqETmvRR9JQj/LXRFULM8JDU8G/CTXNSNbAAlK9oE0DArIk/JYhJCv
         nJnunRcufCph6FaIpy/L6ASk84rAI1Yp1BzsY6fWysubdyGKXS7HlTgZz9f5jr5b6AsI
         GZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735259007; x=1735863807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnK8GTp4kq3AREja2sD0O7Kb+4zQCe/fm63LSJLYU5k=;
        b=RY/UcVM3rBCx7Cl0c1yVgUjUjiCL0c6QdPPxh2dW3Do317cPVuPTFeZxyG7CgLV5jB
         +wP9xECHWlPi32q5FuaO05Xwe7iKgMFYvBXW2kNxKYfB4fd+CCV6GBit6eEvGhH/fI4M
         nTAFNWZAxF4lAcKck+3Bp8NfYBwY15st05AzwbIoOVbRVK/TQKewfugR4c76QvoUchh/
         GkkC/+jfuCIuamxMVs1kxn51yp4EWXtMteCPRsx/4lKYCwg0GVptJECzK1usHWAoVQum
         Pun4aNttTylhVq1DkAZ0HP+4RWjA5ojoh/iYS6tma1MUJWMasw2drMSpAszwqeAKto51
         y/nA==
X-Gm-Message-State: AOJu0Yx3+5VlwL9G/7GcSqT7fkdV2a/KZn7gddIIVTGn/nSAtBGraczF
	KkAksOgxkSJahC350FTJiV3UpL7jfJIgClaMLprcjhE9J7dO7ALMhzEgqIVMUw==
X-Gm-Gg: ASbGncthCAZuaux/f+O7BlylHRYDnfSYYa6M6XCDffNAHRPt13wz4izhpqu0Jo9PZKz
	L17szq4fl1L+cuONMP/6Kse6VFoocrxhP/QvtCq7MzU/bTMUp362gxYQ8lZcMa+i7IiIIbj99pD
	3/bh+WieJ5xO5O9QQucA4tHrXX6JiYtXmifjiRBQ2041+TvMHxSpAg/L5n9Ge7RNsot6oEuSkXa
	zEzs0154TxgvYaK/5DLiFp3lJjgJ1u1hbjbTLYIPdXi/IIjd6N71WEI95lUE4U268CR2FaAIs1O
	eyf+s4F9LGeRQ8pgOeE=
X-Google-Smtp-Source: AGHT+IHpHqj1gmmKbJ5wgeQtJmbecxZqinDCXpnpb8KG6ML+4CQGLd/qnQTT2vlVqTeJ+vFDw2fSfA==
X-Received: by 2002:a17:903:2350:b0:20b:5e34:1850 with SMTP id d9443c01a7336-219e773876bmr10975425ad.23.1735259006920;
        Thu, 26 Dec 2024 16:23:26 -0800 (PST)
Received: from google.com (40.155.125.34.bc.googleusercontent.com. [34.125.155.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed644816sm16394234a91.25.2024.12.26.16.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 16:23:26 -0800 (PST)
Date: Fri, 27 Dec 2024 00:23:22 +0000
From: Peilin Ye <yepeilin@google.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	David Vernet <dvernet@meta.com>,
	Dave Marchevsky <davemarchevsky@meta.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v1 2/4] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z23zes0fA3KGABcN@google.com>
References: <cover.1734742802.git.yepeilin@google.com>
 <6ca65dc2916dba7490c4fd7a8b727b662138d606.1734742802.git.yepeilin@google.com>
 <f704019d-a8fa-4cf5-a606-9d8328360a3e@huaweicloud.com>
 <Z23hntYzWuZOnScP@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z23hntYzWuZOnScP@google.com>

On Thu, Dec 26, 2024 at 11:07:10PM +0000, Peilin Ye wrote:
> > > +	if (BPF_ATOMIC_TYPE(insn->imm) == BPF_ATOMIC_LOAD)
> > > +		ptr = src;
> > > +	else
> > > +		ptr = dst;
> > > +
> > > +	if (off) {
> > > +		emit_a64_mov_i(true, tmp, off, ctx);
> > > +		emit(A64_ADD(true, tmp, tmp, ptr), ctx);
> > 
> > The mov and add instructions can be optimized to a single A64_ADD_I
> > if is_addsub_imm(off) is true.
> 
> Thanks!  I'll try this.

The following diff seems to work:

--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -658,9 +658,15 @@ static int emit_atomic_load_store(const struct bpf_insn *insn, struct jit_ctx *c
                ptr = dst;

        if (off) {
-               emit_a64_mov_i(true, tmp, off, ctx);
-               emit(A64_ADD(true, tmp, tmp, ptr), ctx);
-               ptr = tmp;
+               if (is_addsub_imm(off)) {
+                       emit(A64_ADD_I(true, ptr, ptr, off), ctx);
+               } else if (is_addsub_imm(-off)) {
+                       emit(A64_SUB_I(true, ptr, ptr, -off), ctx);
+               } else {
+                       emit_a64_mov_i(true, tmp, off, ctx);
+                       emit(A64_ADD(true, tmp, tmp, ptr), ctx);
+                       ptr = tmp;
+               }
        }
        if (arena) {
                emit(A64_ADD(true, tmp, ptr, arena_vm_base), ctx);

I'll include it in the next version.  I think the same thing can be done
for emit_lse_atomic() and emit_ll_sc_atomic(); let me do that in a
separate patch.

Thanks,
Peilin Ye


