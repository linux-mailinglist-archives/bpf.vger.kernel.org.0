Return-Path: <bpf+bounces-14116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FF37E09B8
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 20:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94013B21459
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 19:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2043F23745;
	Fri,  3 Nov 2023 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V1jEFdV3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883021548F
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 19:58:59 +0000 (UTC)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5365D61
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 12:58:55 -0700 (PDT)
Message-ID: <fa3eaf9d-89d8-4a18-8ff8-64c76a3b52e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699041533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQn9/YVWnNfIFyfjR+xfd/2XN+/TIOg33moNldqBJuA=;
	b=V1jEFdV3DSA2DmVV5tNuynKCFmm4wQQIwbMHUjGv4yCjfWO9ZJF03NFKKrfB+eTzaOyulP
	DvZ2xgXQpZTUCNlV/On6ym1jPHiMQCAju0T5/JjNAAfNuj8iXzMoVj0zJUjgpcaWH+wsAW
	CPTOl5gYLvB5NRo7fJTYS7M2rs7LXBc=
Date: Fri, 3 Nov 2023 12:58:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bpf_core_type_id_kernel is not consistent with
 bpf_core_type_id_local
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Lorenz Bauer <lorenz.bauer@isovalent.com>,
 Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@meta.com>,
 Lorenz Bauer <lmb@isovalent.com>, bpf <bpf@vger.kernel.org>,
 Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>
References: <CAN+4W8h3yDjkOLJPiuKVKTpj_08pBz8ke6vN=Lf8gcA=iYBM-g@mail.gmail.com>
 <e9987f16-7328-627d-8c02-c42c130a61a8@meta.com>
 <CAN+4W8hK9EEb7Qb2How+YwNkkz4wjRyBAK7Y+WcqBzA9ckJ5Qg@mail.gmail.com>
 <CAEf4BzaEPMVFfEYwHxje8sm+26bgeLJ+4hfdGNOMHd5bV8u9rw@mail.gmail.com>
 <CAN+4W8iTm-GS_-Wp=XjY1Txs09G7F4d3vcG_30WDOp-CpDKmCA@mail.gmail.com>
 <CAEf4BzZQQiD5x0PRwGD32bE7izUxhPvRRQTMpifQZYvu+0mMkA@mail.gmail.com>
 <bf1ab8f0-bb83-43d1-9ce0-cb6828fdc935@linux.dev>
 <CAEf4BzaLuL_MtW25t4sehjD2VzCSu3TqbRyQrJJG2t2hCf4LqQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzaLuL_MtW25t4sehjD2VzCSu3TqbRyQrJJG2t2hCf4LqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/1/23 7:16 PM, Andrii Nakryiko wrote:
> On Wed, Nov 1, 2023 at 5:34 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 11/1/23 3:42 PM, Andrii Nakryiko wrote:
>>> On Wed, Nov 1, 2023 at 7:18 AM Lorenz Bauer <lorenz.bauer@isovalent.com> wrote:
>>>> On Tue, Oct 31, 2023 at 6:24 PM Andrii Nakryiko
>>>> <andrii.nakryiko@gmail.com> wrote:
>>>>>> Did you get round to fixing this, or did you decide to leave it as is?
>>>>> Trying to recall, was there anything to do on the libbpf side, or was
>>>>> it purely a compiler-side change?
>>>> I'm not 100% sure TBH. I'd like clang to behave consistently for
>>>> local_id and target_id. I don't know whether that would break libbpf.
>>>>
>>> *checks code* libbpf just passes through whatever ID compiler
>>> generated, so there doesn't seem to be any change to libbpf. Seems
>>> like compiler-only change. cc'ing Eduard  as well, if he's curious
>>> enough to check
>> Okay, let us try to have a consistent behavior in local/remote type_id
>> by changing local_id semantics to be the same as target_id.
>>
>> The corresponding llvm change is similar to
>>
>> [yhs@devbig309.ftw3 ~/work/llvm-project (ed)]$ git diff
>> diff --git a/llvm/lib/Target/BPF/BPFPreserveDIType.cpp b/llvm/lib/Target/BPF/BPFPreserveDIType.cpp
>> index 78e1bf90f1bd..1fbe1207dc6e 100644
>> --- a/llvm/lib/Target/BPF/BPFPreserveDIType.cpp
>> +++ b/llvm/lib/Target/BPF/BPFPreserveDIType.cpp
>> @@ -86,15 +86,17 @@ static bool BPFPreserveDITypeImpl(Function &F) {
>>          Reloc = BTF::BTF_TYPE_ID_LOCAL;
>>        } else {
>>          Reloc = BTF::BTF_TYPE_ID_REMOTE;
>> -      DIType *Ty = cast<DIType>(MD);
>> -      while (auto *DTy = dyn_cast<DIDerivedType>(Ty)) {
>> -        unsigned Tag = DTy->getTag();
>> -        if (Tag != dwarf::DW_TAG_const_type &&
>> -            Tag != dwarf::DW_TAG_volatile_type)
>> -          break;
>> -        Ty = DTy->getBaseType();
>> -      }
>> +    }
>> +    DIType *Ty = cast<DIType>(MD);
>> +    while (auto *DTy = dyn_cast<DIDerivedType>(Ty)) {
>> +      unsigned Tag = DTy->getTag();
>> +      if (Tag != dwarf::DW_TAG_const_type &&
>> +          Tag != dwarf::DW_TAG_volatile_type)
>> +        break;
>> +      Ty = DTy->getBaseType();
>> +    }
>>
>> +    if (Reloc == BTF::BTF_TYPE_ID_REMOTE) {
>>          if (Ty->getName().empty()) {
>>            if (isa<DISubroutineType>(Ty))
>>              report_fatal_error(
>> @@ -102,8 +104,8 @@ static bool BPFPreserveDITypeImpl(Function &F) {
>>            else
>>              report_fatal_error("Empty type name for BTF_TYPE_ID_REMOTE reloc");
>>          }
>> -      MD = Ty;
>>        }
>> +    MD = Ty;
>>
>>        BasicBlock *BB = Call->getParent();
>>        IntegerType *VarType = Type::getInt64Ty(BB->getContext());
>>
>> Either Eduard or Myself will submit a llvm patch to fix this in llvm18.

The change is merged into upstream llvm-project trunk ('main' branch):

https://github.com/llvm/llvm-project/commit/32e35b21b5971cc939b1de1194145d9b934fcb54


> Sounds good, and thank you!
>
>>>
>>>> Lorenz

