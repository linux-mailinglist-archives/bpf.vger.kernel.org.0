Return-Path: <bpf+bounces-44803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6659C7C1A
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 20:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2C01F239F6
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0D2204F66;
	Wed, 13 Nov 2024 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct8HEeyr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1F201253;
	Wed, 13 Nov 2024 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731525950; cv=none; b=eiJ/vYhioSOIJ9eFW+xKlvdPb9FfpfEsWpgu7YQD6ogUfIJPJpEqMSHwNffgAlgEa3eEGcX7xQwrV8piSOPZY+L9OfeqU9t3rxNOwDQfDcTPrgxev98eX+A8TllR0vwhVKUIQOWOe9jWF1LccrsS72kQ3OGRqhQeGviABtX6e5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731525950; c=relaxed/simple;
	bh=zCS2ZMeF1HWgEUFZZMCDIzPVdagt9/38VUpfLXW8SoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXDmUU+iDz9NuIOUh/fBXVxWd6a1UXU0duKWb18Sz2kxnVO0jt/Wo0vyVo4G/gl6ZQetwFXFVgaG58v5mH/ELkf3Y7dOe50bu2dlyshXhlbPclWVzfcLZ5Xfqw4SSjo2mDrWNruytL4NPhLdCeHD+Zq4qjvaMSSWdTHEgXDV0aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ct8HEeyr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43158625112so64623965e9.3;
        Wed, 13 Nov 2024 11:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731525946; x=1732130746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=79OHR5n3SZfsy5UFp+Gd64dReeEkaxfwRsIGDJcWEIM=;
        b=Ct8HEeyrG7Xe6DAZ52HexxMduFBjvLYz49+qUHnaHISpvQVhPNkGgZ9Qb9/BA33SKk
         DfNx5TXTlUzCzBu/l9LdVfMTQG/xBqHmCNYMoGWrSBOPJCi4B91t+3MsY8t5cDTZKUqG
         eh1K2HKzq8ZYvJsTic9vRDy2WaSexUliJpGgf3gl0y2LTf61cGcSLAGTSoQO+hNEimUi
         xNYWbvwIl8FjOMDfTnOSCBqw6eF2TR4vxQPVWQVQMa+Asp9W14bPJbx14ePQy7tqxEbe
         vGfZrenZMs9JD8vg+o0P8WknZGT684EU8pPH2gXD/s/Q4p8SX3XH5Tf4gxaENe8Hgozm
         OS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731525946; x=1732130746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79OHR5n3SZfsy5UFp+Gd64dReeEkaxfwRsIGDJcWEIM=;
        b=E1w+gULvHhCKV6FIW8X7VrqpQRgxYUGn+Fa6NSilY152w7s2KLVY2ccn00kKeRz7lP
         kxFSC0fL8ZHMc56yYPymYBC934PlBs5gtnsMM6WqT+rPsz2KiQy7KAb4cjjNhnKYmNRv
         PkCXjHvQ3QOponR3RhgFL+WmwC80fv7PY2L5cwzwQgM2ec1+AhbpsNYyhwhzYPiTrbfl
         hXj6rBmPk0LbcqZAgHZfsm+Zzu6eGyYXM0CI9kU7osCnRJPsvZTGkXmIG02dEjFfrKEZ
         dIutTDL4Yz2SVdDq4ju9DKVIvHojynl8vDnhSknEGpKIwdEtw/LoXSBzj8wunhulDl/s
         OBsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC/psWQ46L2sr8+VArruE9MTdr44cahWuXnQqNBLJ2scWsBirpi/oeTV632OMihaudT+7RDMfEhl0YxP1R@vger.kernel.org, AJvYcCVcmROo+e4JabzxSilvGPPQvq6Vyb6eWq34VwBRGZmNAQ/OxHZ/XDpBoeswQV4aAHhxtZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/12wKFvImdNqVMm9wpKb7dTICOHfRWAX0TmBWsTmiWX0Zal1
	En3u62RQsTMlb391KoH58bdnal5WQzhGyrfYmbtRna97PhoWis6UyIDMzA==
X-Google-Smtp-Source: AGHT+IF7ACglfWHGWFwbQVHXMJUGCirizqztc7cFoX8b+KbBQgoDDCwSe1NYV8vTrgQZPQaKrxmomg==
X-Received: by 2002:a05:6000:1a88:b0:37c:d54e:81fd with SMTP id ffacd0b85a97d-381f1885eaemr16894820f8f.54.1731525945757;
        Wed, 13 Nov 2024 11:25:45 -0800 (PST)
Received: from andrea ([149.62.244.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda05ce0sm18811627f8f.103.2024.11.13.11.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 11:25:45 -0800 (PST)
Date: Wed, 13 Nov 2024 21:25:41 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: puranjay@kernel.org, bpf@vger.kernel.org, lkmm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: Some observations (results) on BPF acquire and release
Message-ID: <ZzT9NR7mlSZQHzpD@andrea>
References: <Zxk2wNs4sxEIg-4d@andrea>
 <13f60db0-b334-4638-a768-d828ecf7c8d0@paulmck-laptop>
 <Zxor8xosL-XSxnwr@andrea>
 <ZxujgUwRWLCp6kxF@andrea>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxujgUwRWLCp6kxF@andrea>

[...]

> I guess the next question (once clarified the intentions for the R
> and Z6.3 tests seen earlier) is "Does BPF really care about 2+2W
> and B-cumulativity for store-release?"; I mentioned some tradeoff,
> but in the end this is a call for the BPF community.

Interpreting the radio silence as an unanimous "No, it doesn't", please find
tentative fixes/patch (on top of the bpf_acquire_release branch cited in an
earlier post) at the bottom of this email.

While testing the changes in question, I noticed an (unrelated) omission in
the current PPO relation; the second patch below addresses that.

Both patches were tested using the "BPF catalogue" available in the tree at
stake: as expected, the only differences in outcomes were for the new/added
five tests.

Please use and integrate according to your preference, any feedback welcome.

  Andrea


From 5bf399413578b6a94c42f6367245be2bdbf58926 Mon Sep 17 00:00:00 2001
From: Andrea Parri <parri.andrea@gmail.com>
Date: Mon, 11 Nov 2024 08:38:42 +0200
Subject: [PATCH 1/2] BPF: Fix propagation ordering, after LKMM

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 catalogue/bpf/tests/2+2W+release+fence.litmus | 15 ++++++++++++
 .../tests/ISA2+release+acquire+acquire.litmus | 15 ++++++++++++
 catalogue/bpf/tests/R+release+fence.litmus    | 14 +++++++++++
 .../bpf/tests/Z6.3+fence+fence+acquire.litmus | 16 +++++++++++++
 herd/libdir/bpf.cat                           | 24 +++++++++----------
 5 files changed, 72 insertions(+), 12 deletions(-)
 create mode 100644 catalogue/bpf/tests/2+2W+release+fence.litmus
 create mode 100644 catalogue/bpf/tests/ISA2+release+acquire+acquire.litmus
 create mode 100644 catalogue/bpf/tests/R+release+fence.litmus
 create mode 100644 catalogue/bpf/tests/Z6.3+fence+fence+acquire.litmus

diff --git a/catalogue/bpf/tests/2+2W+release+fence.litmus b/catalogue/bpf/tests/2+2W+release+fence.litmus
new file mode 100644
index 0000000000000..0f88babbf27de
--- /dev/null
+++ b/catalogue/bpf/tests/2+2W+release+fence.litmus
@@ -0,0 +1,15 @@
+BPF 2+2W+release+fence
+(*
+ * Result: Sometimes
+ *)
+{
+ 0:r2=x; 0:r4=y;
+ 1:r2=y; 1:r4=x; 1:r6=l;
+}
+ P0                                 | P1                                         ;
+ r1 = 1                             | r1 = 1                                     ;
+ *(u32 *)(r2 + 0) = r1              | *(u32 *)(r2 + 0) = r1                      ;
+ r3 = 2                             | r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) ;
+ store_release((u32 *)(r4 + 0), r3) | r3 = 2                                     ;
+                                    | *(u32 *)(r4 + 0) = r3                      ;
+exists ([x]=1 /\ [y]=1)
diff --git a/catalogue/bpf/tests/ISA2+release+acquire+acquire.litmus b/catalogue/bpf/tests/ISA2+release+acquire+acquire.litmus
new file mode 100644
index 0000000000000..44c1308d70b5a
--- /dev/null
+++ b/catalogue/bpf/tests/ISA2+release+acquire+acquire.litmus
@@ -0,0 +1,15 @@
+BPF ISA2+release+acquire+acquire
+(*
+ * Result: Sometimes
+ *)
+{
+ 0:r2=x; 0:r4=y;
+ 1:r2=y; 1:r4=z;
+ 2:r2=z; 2:r4=x;
+}
+ P0                                 | P1                                 | P2                                 ;
+ r1 = 1                             | r1 = load_acquire((u32 *)(r2 + 0)) | r1 = load_acquire((u32 *)(r2 + 0)) ;
+ *(u32 *)(r2 + 0) = r1              | r3 = 1                             | r3 = *(u32 *)(r4 + 0)              ;
+ r3 = 1                             | *(u32 *)(r4 + 0) = r3              |                                    ;
+ store_release((u32 *)(r4 + 0), r3) |                                    |                                    ;
+exists (1:r1=1 /\ 2:r1=1 /\ 2:r3=0)
diff --git a/catalogue/bpf/tests/R+release+fence.litmus b/catalogue/bpf/tests/R+release+fence.litmus
new file mode 100644
index 0000000000000..a0bcbe0bbb804
--- /dev/null
+++ b/catalogue/bpf/tests/R+release+fence.litmus
@@ -0,0 +1,14 @@
+BPF R+release+fence
+(*
+ * Result: Sometimes
+ *)
+{
+ 0:r2=x; 0:r4=y;
+ 1:r2=y; 1:r4=x; 1:r6=l;
+}
+ P0                                 | P1                                         ;
+ r1 = 1                             | r1 = 2                                     ;
+ *(u32 *)(r2 + 0) = r1              | *(u32 *)(r2 + 0) = r1                      ;
+ r3 = 1                             | r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) ;
+ store_release((u32 *)(r4 + 0), r3) | r3 = *(u32 *)(r4 + 0)                      ;
+exists ([y]=2 /\ 1:r3=0)
diff --git a/catalogue/bpf/tests/Z6.3+fence+fence+acquire.litmus b/catalogue/bpf/tests/Z6.3+fence+fence+acquire.litmus
new file mode 100644
index 0000000000000..67e9146bcef2b
--- /dev/null
+++ b/catalogue/bpf/tests/Z6.3+fence+fence+acquire.litmus
@@ -0,0 +1,16 @@
+BPF Z6.3+fence+fence+acquire
+(*
+ * Result: Never
+ *)
+{
+ 0:r2=x; 0:r4=y; 0:r6=l;
+ 1:r2=y; 1:r4=z; 1:r6=m;
+ 2:r2=z; 2:r4=x;
+}
+ P0                                         | P1                                         | P2                                 ;
+ r1 = 1                                     | r1 = 2                                     | r1 = load_acquire((u32 *)(r2 + 0)) ;
+ *(u32 *)(r2 + 0) = r1                      | *(u32 *)(r2 + 0) = r1                      | r3 = *(u32 *)(r4 + 0)              ;
+ r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) | r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) |                                    ;
+ r3 = 1                                     | r3 = 1                                     |                                    ;
+ *(u32 *)(r4 + 0) = r3                      | *(u32 *)(r4 + 0) = r3                      |                                    ;
+exists ([y]=2 /\ 2:r1=1 /\ 2:r3=0)
diff --git a/herd/libdir/bpf.cat b/herd/libdir/bpf.cat
index 28b42497ea0fc..7803a1e818de7 100644
--- a/herd/libdir/bpf.cat
+++ b/herd/libdir/bpf.cat
@@ -43,9 +43,9 @@ show addr_dep as addr
 show data_dep as data
 show ctrl_dep as ctrl
 
-(*************)
-(* ppo rules *)
-(*************)
+(**********************)
+(* ppo and prop rules *)
+(**********************)
 
 let ppo =
 (* Explicit synchronization *)
@@ -65,6 +65,10 @@ include "cos-opt.cat"
 
 let com = co | rf | fr
 
+(* Propagation ordering from SC and release operations *)
+let A-cumul = rfe? ; (po_amo_fetch | store_release)
+let prop = (coe | fre)? ; A-cumul* ; rfe?
+
 (**********)
 (* Axioms *)
 (**********)
@@ -72,17 +76,13 @@ let com = co | rf | fr
 (* Sc per location *)
 acyclic com | po-loc as Coherence
 
-(* No thin air *)
-let hb = (ppo | rfe)+
-acyclic hb
+(* No-Thin-Air and Observation *)
+let hb = ppo | rfe | ((prop \ id) & int)
+acyclic hb as Happens-before
 
 (* Propagation *)
-let A-cumul = rfe;po_amo_fetch | rfe;store_release | po_amo_fetch;fre
-let prop = (store_release | po_amo_fetch | A-cumul);hb*
-acyclic prop | co
-
-(* Observation *)
-irreflexive fre;prop
+let pb = prop ; po_amo_fetch ; hb*
+acyclic pb as Propagation
 
 (* Atomicity *)
 empty rmw & (fre;coe) as Atomic
-- 
2.43.0


From 84520eaacbcb399b5cc7b4cbe0f716ad84e87824 Mon Sep 17 00:00:00 2001
From: Andrea Parri <parri.andrea@gmail.com>
Date: Mon, 11 Nov 2024 08:03:48 +0200
Subject: [PATCH 2/2] BPF: Fix overlapping-address ordering

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 catalogue/bpf/tests/LB+release-oa+acquire.litmus | 15 +++++++++++++++
 herd/libdir/bpf.cat                              | 13 ++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)
 create mode 100644 catalogue/bpf/tests/LB+release-oa+acquire.litmus

diff --git a/catalogue/bpf/tests/LB+release-oa+acquire.litmus b/catalogue/bpf/tests/LB+release-oa+acquire.litmus
new file mode 100644
index 0000000000000..1544179357e9b
--- /dev/null
+++ b/catalogue/bpf/tests/LB+release-oa+acquire.litmus
@@ -0,0 +1,15 @@
+BPF LB+release-oa+acquire
+(*
+ * Result: Never
+ *)
+{
+ 0:r2=x; 0:r4=y;
+ 1:r2=y; 1:r4=x;
+}
+ P0                                 | P1                                 ;
+ r1 = *(u32 *)(r2 + 0)              | r1 = load_acquire((u32 *)(r2 + 0)) ;
+ r3 = 1                             | r3 = 1                             ;
+ store_release((u32 *)(r4 + 0), r3) | *(u32 *)(r4 + 0) = r3              ;
+ r5 = 2                             |                                    ;
+ *(u32 *)(r4 + 0) = r5              |                                    ;
+exists (0:r1=1 /\ 1:r1=2)
diff --git a/herd/libdir/bpf.cat b/herd/libdir/bpf.cat
index 7803a1e818de7..4917d0f77009f 100644
--- a/herd/libdir/bpf.cat
+++ b/herd/libdir/bpf.cat
@@ -47,6 +47,10 @@ show ctrl_dep as ctrl
 (* ppo and prop rules *)
 (**********************)
 
+(* Compute coherence relation *)
+include "cos-opt.cat"
+let com = co | rf | fr
+
 let ppo =
 (* Explicit synchronization *)
  po_amo_fetch | rcpc
@@ -57,13 +61,8 @@ let ppo =
 (* Pipeline Dependencies *)
 | [M];(addr|data);[W];rfi;[R]
 | [M];addr;[M];po;[W]
-(* Successful cmpxchg R -(M)> W *)
-| rmw
-
-(* Compute coherence relation *)
-include "cos-opt.cat"
-
-let com = co | rf | fr
+(* Overlapping-address ordering *)
+| (coi | fri)
 
 (* Propagation ordering from SC and release operations *)
 let A-cumul = rfe? ; (po_amo_fetch | store_release)
-- 
2.43.0


