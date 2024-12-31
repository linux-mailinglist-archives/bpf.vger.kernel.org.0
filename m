Return-Path: <bpf+bounces-47726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E089FEC74
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 04:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031A21882D96
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 03:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C3913C918;
	Tue, 31 Dec 2024 03:00:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE072AE7F;
	Tue, 31 Dec 2024 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735614039; cv=none; b=awojkQa9CNF83hK9eyFRf82SK/UyUR8xS8P15M/CLagme6TK+xxGZ5Nl1XCu98icgW9tB49VyuN2yBIcWnZg0szdaytIBzSIBULPkxIz9gGGwZf4YkCUYavqPV6uxlvPEb3NOmvixYbwy9ndsl5uHeW/TuR3c4TGCoC9RS9iMVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735614039; c=relaxed/simple;
	bh=bAUJk69tahyyoHl/5ij4AO2by4uQjV/xTwzsJrYzQ1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWr2bj5g8kiEzztGIO7hCQGLEaIPr+OKQ67Mm8eAl34Nt3CTUSKvvkwIGKE4TBm5Cj8XJm2as5kvWKlD5yx596X99Df7nS2P5mK4R4+sgx/bHaEuUMKtciUcbF+xkPouTbtNPEGvPnrLQd1HHcQS/5vi2gMDqgZ9oc9l8iRC/dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6384844ec72311efa216b1d71e6e1362-20241231
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:6d32dcf7-6313-4bcc-aac9-76275071eb13,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:fcda8dcb68b549cf40d5767336733e2e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 6384844ec72311efa216b1d71e6e1362-20241231
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1642492231; Tue, 31 Dec 2024 11:00:27 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id B28C016002081;
	Tue, 31 Dec 2024 11:00:27 +0800 (CST)
X-ns-mid: postfix-67735E4B-627798623
Received: from [10.42.13.56] (unknown [10.42.13.56])
	by node4.com.cn (NSMail) with ESMTPA id 1AE1816002081;
	Tue, 31 Dec 2024 03:00:27 +0000 (UTC)
Message-ID: <8c81caea-dd2f-4f94-9a26-834fca574d40@kylinos.cn>
Date: Tue, 31 Dec 2024 11:00:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: Use refcount_t instead of atomic_t for mmap_count
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <6ecce439a6bc81adb85d5080908ea8959b792a50.1735542814.git.xiaopei01@kylinos.cn>
 <Z3LNEHfLmtSi4wpO@krava>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <Z3LNEHfLmtSi4wpO@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A8 2024/12/31 00:40, Jiri Olsa =E5=86=99=E9=81=93:
> On Mon, Dec 30, 2024 at 03:16:55PM +0800, Pei Xiao wrote:
>> Use an API that resembles more the actual use of mmap_count.
>=20
> I'm not sure I understand the issue, could you provide more details?
>=20
hi,
refcount_t type which allows us to catch overflow and underflow issues.

thanks!
Pei.
> thanks,
> jirka
>=20
>>
>> Found by cocci:
>> kernel/bpf/arena.c:245:6-25: WARNING: atomic_dec_and_test variation be=
fore object free at line 249.
>>
>> Fixes: b90d77e5fd78 ("bpf: Fix remap of arena.")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202412292037.LXlYSHKl-lk=
p@intel.com/
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>> ---
>>  kernel/bpf/arena.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> index 945a5680f6a5..8caf56a308d9 100644
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
>> @@ -218,7 +218,7 @@ static u64 arena_map_mem_usage(const struct bpf_ma=
p *map)
>>  struct vma_list {
>>  	struct vm_area_struct *vma;
>>  	struct list_head head;
>> -	atomic_t mmap_count;
>> +	refcount_t mmap_count;
>>  };
>> =20
>>  static int remember_vma(struct bpf_arena *arena, struct vm_area_struc=
t *vma)
>> @@ -228,7 +228,7 @@ static int remember_vma(struct bpf_arena *arena, s=
truct vm_area_struct *vma)
>>  	vml =3D kmalloc(sizeof(*vml), GFP_KERNEL);
>>  	if (!vml)
>>  		return -ENOMEM;
>> -	atomic_set(&vml->mmap_count, 1);
>> +	refcount_set(&vml->mmap_count, 1);
>>  	vma->vm_private_data =3D vml;
>>  	vml->vma =3D vma;
>>  	list_add(&vml->head, &arena->vma_list);
>> @@ -239,7 +239,7 @@ static void arena_vm_open(struct vm_area_struct *v=
ma)
>>  {
>>  	struct vma_list *vml =3D vma->vm_private_data;
>> =20
>> -	atomic_inc(&vml->mmap_count);
>> +	refcount_inc(&vml->mmap_count);
>>  }
>> =20
>>  static void arena_vm_close(struct vm_area_struct *vma)
>> @@ -248,7 +248,7 @@ static void arena_vm_close(struct vm_area_struct *=
vma)
>>  	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map)=
;
>>  	struct vma_list *vml =3D vma->vm_private_data;
>> =20
>> -	if (!atomic_dec_and_test(&vml->mmap_count))
>> +	if (!refcount_dec_and_test(&vml->mmap_count))
>>  		return;
>>  	guard(mutex)(&arena->lock);
>>  	/* update link list under lock */
>> --=20
>> 2.25.1
>>
>>


