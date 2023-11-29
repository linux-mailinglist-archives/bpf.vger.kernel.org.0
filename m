Return-Path: <bpf+bounces-16149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A947FDA84
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 15:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16CE9B20F47
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 14:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3546E34CEC;
	Wed, 29 Nov 2023 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyIP63wM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB48BE
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 06:55:11 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a049d19b63bso945822666b.2
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 06:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701269710; x=1701874510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cW/0lMh7azQ8HGmBB4nOHviKqm9JxrP67avtNihuzgA=;
        b=OyIP63wMgPmLdvrX6Elhfx7qWnVLGO1z7PQn4Vju/rtXTPqROV1AD6g0am/D8nSfLe
         g0mBQr+c1Wz+Jz8PTzjwl2BBU1Du7sPwkKYR3JUmPJGN8vHuGLw1ZQtv7OJm4V4XFZgO
         tff1I4UYEJG0h6Nx8Xspuf+beBeLbQUKwETayIun6Fxn0zH+aPFh6yn1QXrRBQpUcpjo
         0/7JTCts+rpbmXRNcwmSFjtm6cgcnYQir6pmH9ENnsPtpeNDUCHjLr4Qr2SGMi4xwMba
         vh6AYdopeqENiovUh7DxS5tkt9TLJ1P3LofKGooFyXu+WOavR5dmoHhfDjfwKB5XgW8U
         EEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269710; x=1701874510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cW/0lMh7azQ8HGmBB4nOHviKqm9JxrP67avtNihuzgA=;
        b=QS2xyCYe1LCqO+VYFgOvZMJT0Qsxo200TeKMJ0eBQQMAlWqnFNPYUdyVdMJycBvhQo
         PEtpQi3Qscsuka5qXT/cyjUmxznQT/WoSmntBeccWPTiLwD6fbJ6/jZKg+zc71R79liG
         je+mb6ZIv8j6PvzR4Mlo6VCPs1QtduGRUpUUQOZbbURTrHO4G0ivlqioLjQrJFmcUsU/
         OM+zS3j47CZWx7vy73S7cwgIDfq8HJfSJMSbJVexYMgezyAg4bv5uDM+mixGVaOXaoXC
         1sVnZC7P4morWqrOi4oMyvVbiX0332CFiM0ItW7KzlDyAFh/pbhjG+pxp9EeYIzashqA
         JHWQ==
X-Gm-Message-State: AOJu0YxybiWDz+e184nUbmOv47ZDzaNx0fS8ESjD4zBNDges8dGblQas
	kVoUiix2aow0gENvrvJQIsLYURSDups=
X-Google-Smtp-Source: AGHT+IHtWmyU8wjKpLElhYgDwMYuG8ta3hwOFDODG7BY4jB+GNZhR41eZJzHYPhbQZzklW4NfECH9Q==
X-Received: by 2002:a17:906:a8d:b0:9fe:1681:22c7 with SMTP id y13-20020a1709060a8d00b009fe168122c7mr12309063ejf.26.1701269709369;
        Wed, 29 Nov 2023 06:55:09 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id hg5-20020a170906f34500b00a0a2cb33ee0sm6092400ejb.203.2023.11.29.06.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:55:09 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 29 Nov 2023 15:55:07 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>,
	Xu Kuohai <xukuohai@huawei.com>, Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCHv2 bpf 1/2] bpf: Add checkip argument to bpf_arch_text_poke
Message-ID: <ZWdQywF4QnrnTc5P@krava>
References: <20231128092850.1545199-1-jolsa@kernel.org>
 <20231128092850.1545199-2-jolsa@kernel.org>
 <ZWZafkt97qhgHynh@google.com>
 <ZWdFIUSXcZnCWax-@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWdFIUSXcZnCWax-@krava>

On Wed, Nov 29, 2023 at 03:05:21PM +0100, Jiri Olsa wrote:
> On Tue, Nov 28, 2023 at 01:24:14PM -0800, Stanislav Fomichev wrote:
> > On 11/28, Jiri Olsa wrote:
> > > We need to be able to skip ip address check for caller in following
> > > changes. Adding checkip argument to allow that.
> > > 
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  arch/arm64/net/bpf_jit_comp.c   |  3 ++-
> > >  arch/riscv/net/bpf_jit_comp64.c |  5 +++--
> > >  arch/s390/net/bpf_jit_comp.c    |  3 ++-
> > >  arch/x86/net/bpf_jit_comp.c     | 24 +++++++++++++-----------
> > >  include/linux/bpf.h             |  2 +-
> > >  kernel/bpf/arraymap.c           |  8 ++++----
> > >  kernel/bpf/core.c               |  2 +-
> > >  kernel/bpf/trampoline.c         | 12 ++++++------
> > >  8 files changed, 32 insertions(+), 27 deletions(-)
> > > 
> > > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> > > index 7d4af64e3982..b52549d18730 100644
> > > --- a/arch/arm64/net/bpf_jit_comp.c
> > > +++ b/arch/arm64/net/bpf_jit_comp.c
> > > @@ -2167,7 +2167,8 @@ static int gen_branch_or_nop(enum aarch64_insn_branch_type type, void *ip,
> > >   * locations during the patching process, making the patching process easier.
> > >   */
> > >  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
> > > -		       void *old_addr, void *new_addr)
> > > +		       void *old_addr, void *new_addr,
> > 
> > [..]
> > 
> > > +		       bool checkip __maybe_unused)
> > 
> > Any idea why only riscv and x86 do this check?
> 
> so arm does the check as well, but needs the data from the lookup
> to patch things properly.. but IIUC it does not suffer the same
> issue because it does not implement direct tail calls [1] which
> is used only on x86
> 
> > 
> > Asking because maybe it makes sense to move this check into some
> > new generic bpf_text_poke and call it in the places where you currently
> > call checkip=true (and keep using bpf_arch_text_poke for checkip=false
> > case).
> > 
> > (don't see any issues with the current approach btw, just interested..)
> 
> I tried to add new function for that, but it did not look good for arm
> because it needs to do the lookup anyway
> 
> hm maybe we could use new arch function that would cover the single
> tail call 'text poke' update in prog_array_map_poke_run and would be
> implemented only on x86 ... using __bpf_arch_text_poke directly

looks like below change would be enough, I'll test and send new version

jirka


---
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8c10d9abc239..9c41c8c19eea 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3025,3 +3025,44 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
 #endif
 	WARN(1, "verification of programs using bpf_throw should have failed\n");
 }
+
+void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
+			       struct bpf_prog *new, struct bpf_prog *old)
+{
+	u8 *old_addr, *new_addr, *old_bypass_addr;
+	int ret;
+
+	old_bypass_addr = old ? NULL : poke->bypass_addr;
+	old_addr = old ? (u8 *)old->bpf_func + poke->adj_off : NULL;
+	new_addr = new ? (u8 *)new->bpf_func + poke->adj_off : NULL;
+
+	if (new) {
+		ret = __bpf_arch_text_poke(poke->tailcall_target,
+					   BPF_MOD_JUMP,
+					   old_addr, new_addr);
+		BUG_ON(ret < 0);
+		if (!old) {
+			ret = __bpf_arch_text_poke(poke->tailcall_bypass,
+						   BPF_MOD_JUMP,
+						   poke->bypass_addr,
+						   NULL);
+			BUG_ON(ret < 0);
+		}
+	} else {
+		ret = __bpf_arch_text_poke(poke->tailcall_bypass,
+					   BPF_MOD_JUMP,
+					   old_bypass_addr,
+					   poke->bypass_addr);
+		BUG_ON(ret < 0);
+		/* let other CPUs finish the execution of program
+		 * so that it will not possible to expose them
+		 * to invalid nop, stack unwind, nop state
+		 */
+		if (!ret)
+			synchronize_rcu();
+		ret = __bpf_arch_text_poke(poke->tailcall_target,
+					   BPF_MOD_JUMP,
+					   old_addr, NULL);
+		BUG_ON(ret < 0);
+	}
+}
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 2058e89b5ddd..73b6e6e3a8fd 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -1012,11 +1012,16 @@ static void prog_array_map_poke_untrack(struct bpf_map *map,
 	mutex_unlock(&aux->poke_mutex);
 }
 
+void __weak bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
+				      struct bpf_prog *new, struct bpf_prog *old)
+{
+	WARN_ON_ONCE(1);
+}
+
 static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 				    struct bpf_prog *old,
 				    struct bpf_prog *new)
 {
-	u8 *old_addr, *new_addr, *old_bypass_addr;
 	struct prog_poke_elem *elem;
 	struct bpf_array_aux *aux;
 
@@ -1025,7 +1030,7 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 
 	list_for_each_entry(elem, &aux->poke_progs, list) {
 		struct bpf_jit_poke_descriptor *poke;
-		int i, ret;
+		int i;
 
 		for (i = 0; i < elem->aux->size_poke_tab; i++) {
 			poke = &elem->aux->poke_tab[i];
@@ -1068,39 +1073,7 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 			    poke->tail_call.key != key)
 				continue;
 
-			old_bypass_addr = old ? NULL : poke->bypass_addr;
-			old_addr = old ? (u8 *)old->bpf_func + poke->adj_off : NULL;
-			new_addr = new ? (u8 *)new->bpf_func + poke->adj_off : NULL;
-
-			if (new) {
-				ret = bpf_arch_text_poke(poke->tailcall_target,
-							 BPF_MOD_JUMP,
-							 old_addr, new_addr);
-				BUG_ON(ret < 0 && ret != -EINVAL);
-				if (!old) {
-					ret = bpf_arch_text_poke(poke->tailcall_bypass,
-								 BPF_MOD_JUMP,
-								 poke->bypass_addr,
-								 NULL);
-					BUG_ON(ret < 0 && ret != -EINVAL);
-				}
-			} else {
-				ret = bpf_arch_text_poke(poke->tailcall_bypass,
-							 BPF_MOD_JUMP,
-							 old_bypass_addr,
-							 poke->bypass_addr);
-				BUG_ON(ret < 0 && ret != -EINVAL);
-				/* let other CPUs finish the execution of program
-				 * so that it will not possible to expose them
-				 * to invalid nop, stack unwind, nop state
-				 */
-				if (!ret)
-					synchronize_rcu();
-				ret = bpf_arch_text_poke(poke->tailcall_target,
-							 BPF_MOD_JUMP,
-							 old_addr, NULL);
-				BUG_ON(ret < 0 && ret != -EINVAL);
-			}
+			bpf_arch_poke_desc_update(poke, new, old);
 		}
 	}
 }

