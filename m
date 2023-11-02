Return-Path: <bpf+bounces-13865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277D67DE966
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 01:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D675C2819E7
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 00:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999C71FB3;
	Thu,  2 Nov 2023 00:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="csAJMU91"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB791FB2
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 00:34:44 +0000 (UTC)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [IPv6:2001:41d0:203:375::b2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC98E101
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 17:34:39 -0700 (PDT)
Message-ID: <bf1ab8f0-bb83-43d1-9ce0-cb6828fdc935@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698885278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iu+GVul9AvnZuUmW/jEYWXX1rNGD/mAXaK4kMnDW9rQ=;
	b=csAJMU91N6CspKtDyLQqP4xNzyQQc31TlRhuYR206iwEeLf+9ThXv7HT5Jw77cjGGHRG7C
	YbC2+ESeDu60xCE6T8cDnAzBkxX1PyvezHjN82TfNwqvK+3lplRtAIq3Zwjsb5804bD5k4
	ki9KKsUwsPDSn9hRiAhs0gDkj4Rm9k4=
Date: Wed, 1 Nov 2023 17:34:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bpf_core_type_id_kernel is not consistent with
 bpf_core_type_id_local
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Lorenz Bauer <lorenz.bauer@isovalent.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, Lorenz Bauer <lmb@isovalent.com>,
 bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>
References: <CAN+4W8h3yDjkOLJPiuKVKTpj_08pBz8ke6vN=Lf8gcA=iYBM-g@mail.gmail.com>
 <e9987f16-7328-627d-8c02-c42c130a61a8@meta.com>
 <CAN+4W8hK9EEb7Qb2How+YwNkkz4wjRyBAK7Y+WcqBzA9ckJ5Qg@mail.gmail.com>
 <CAEf4BzaEPMVFfEYwHxje8sm+26bgeLJ+4hfdGNOMHd5bV8u9rw@mail.gmail.com>
 <CAN+4W8iTm-GS_-Wp=XjY1Txs09G7F4d3vcG_30WDOp-CpDKmCA@mail.gmail.com>
 <CAEf4BzZQQiD5x0PRwGD32bE7izUxhPvRRQTMpifQZYvu+0mMkA@mail.gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZQQiD5x0PRwGD32bE7izUxhPvRRQTMpifQZYvu+0mMkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/1/23 3:42 PM, Andrii Nakryiko wrote:
> On Wed, Nov 1, 2023 at 7:18 AM Lorenz Bauer <lorenz.bauer@isovalent.com> wrote:
>> On Tue, Oct 31, 2023 at 6:24 PM Andrii Nakryiko
>> <andrii.nakryiko@gmail.com> wrote:
>>>> Did you get round to fixing this, or did you decide to leave it as is?
>>> Trying to recall, was there anything to do on the libbpf side, or was
>>> it purely a compiler-side change?
>> I'm not 100% sure TBH. I'd like clang to behave consistently for
>> local_id and target_id. I don't know whether that would break libbpf.
>>
> *checks code* libbpf just passes through whatever ID compiler
> generated, so there doesn't seem to be any change to libbpf. Seems
> like compiler-only change. cc'ing Eduard  as well, if he's curious
> enough to check

Okay, let us try to have a consistent behavior in local/remote type_id
by changing local_id semantics to be the same as target_id.

The corresponding llvm change is similar to

[yhs@devbig309.ftw3 ~/work/llvm-project (ed)]$ git diff
diff --git a/llvm/lib/Target/BPF/BPFPreserveDIType.cpp b/llvm/lib/Target/BPF/BPFPreserveDIType.cpp
index 78e1bf90f1bd..1fbe1207dc6e 100644
--- a/llvm/lib/Target/BPF/BPFPreserveDIType.cpp
+++ b/llvm/lib/Target/BPF/BPFPreserveDIType.cpp
@@ -86,15 +86,17 @@ static bool BPFPreserveDITypeImpl(Function &F) {
        Reloc = BTF::BTF_TYPE_ID_LOCAL;
      } else {
        Reloc = BTF::BTF_TYPE_ID_REMOTE;
-      DIType *Ty = cast<DIType>(MD);
-      while (auto *DTy = dyn_cast<DIDerivedType>(Ty)) {
-        unsigned Tag = DTy->getTag();
-        if (Tag != dwarf::DW_TAG_const_type &&
-            Tag != dwarf::DW_TAG_volatile_type)
-          break;
-        Ty = DTy->getBaseType();
-      }
+    }
+    DIType *Ty = cast<DIType>(MD);
+    while (auto *DTy = dyn_cast<DIDerivedType>(Ty)) {
+      unsigned Tag = DTy->getTag();
+      if (Tag != dwarf::DW_TAG_const_type &&
+          Tag != dwarf::DW_TAG_volatile_type)
+        break;
+      Ty = DTy->getBaseType();
+    }
  
+    if (Reloc == BTF::BTF_TYPE_ID_REMOTE) {
        if (Ty->getName().empty()) {
          if (isa<DISubroutineType>(Ty))
            report_fatal_error(
@@ -102,8 +104,8 @@ static bool BPFPreserveDITypeImpl(Function &F) {
          else
            report_fatal_error("Empty type name for BTF_TYPE_ID_REMOTE reloc");
        }
-      MD = Ty;
      }
+    MD = Ty;
  
      BasicBlock *BB = Call->getParent();
      IntegerType *VarType = Type::getInt64Ty(BB->getContext());

Either Eduard or Myself will submit a llvm patch to fix this in llvm18.

>
>
>> Lorenz

