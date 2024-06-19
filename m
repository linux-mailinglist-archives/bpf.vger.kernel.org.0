Return-Path: <bpf+bounces-32520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427F390F0F0
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 16:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9891C211FA
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 14:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D727E38DFC;
	Wed, 19 Jun 2024 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/vdWVCv"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA51C23775
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808039; cv=none; b=HAw4d2fOCuwt9fwhHvJ3ePSNm2aRXeRFrwbamECC1nKOSSyh8dy7KmXXeiAiuJWVBeyVmG22zzrjvJs4VCXD9dcXoXnPnq4Mkii7BTvXJbuddu4OOyBwWf4t4e7X9guja+t7z8XfDzs551ca1gfzEt+72Xp6WQUohekEbEHiO7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808039; c=relaxed/simple;
	bh=z0Mpv6gcJa3VDpSzPcPg/SCmOnYRbY7zuWvo13wbiqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNj3BT+7uvs/XxCQlKINgLX45Xe4i6+mRLgQZ+dB5dW1KsqCUBLiRhkI5RCYYFfK5jDI2/Q/yxhY98bu2XhQfOcKjjdcLbfzG1NnyyPTTEQYXO14qlJjsKkYbwewGBNKm92Ikzc2cATOinmBdkveBQOjuEwq18ljxQDB7oh89tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V/vdWVCv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718808036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0q4qMgcNqiwKOKLULuCG3ztTE8UvFIWH7RjHNIB9mr0=;
	b=V/vdWVCvmzamcPAS6hXd+KdnFYawgHVYk/9PE3Yx9qGSgR5koDd/B1KfOQuupsENhbvL+/
	VsH4WxnLu3f5WKRTKP5Ire052HPQd33EkZVieQKUQ14aU4az/FgrNbE253+Z1CiTOBUZtg
	9rPZaCKS33IBuW9OM8F2eIjvKzDCyPE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-6uouwswPPmOORU9DfPV1ug-1; Wed,
 19 Jun 2024 10:40:33 -0400
X-MC-Unique: 6uouwswPPmOORU9DfPV1ug-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF2FF19560B3;
	Wed, 19 Jun 2024 14:40:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.168])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4C3F51955E83;
	Wed, 19 Jun 2024 14:40:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Jun 2024 16:38:59 +0200 (CEST)
Date: Wed, 19 Jun 2024 16:38:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Liao Chang <liaochang1@huawei.com>
Cc: jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	nathan@kernel.org, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] uprobes: Fix the xol slots reserved for
 uretprobe trampoline
Message-ID: <20240619143852.GA24240@redhat.com>
References: <20240619013411.756995-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619013411.756995-1-liaochang1@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 06/19, Liao Chang wrote:
>
> When the new uretprobe system call was added [1], the xol slots reserved
> for the uretprobe trampoline might be insufficient on some architecture.

Confused... this doesn't depend on the change above?

> For example, on arm64, the trampoline is consist of three instructions
> at least. So it should mark enough bits in area->bitmaps and
> and area->slot_count for the reserved slots.

Do you mean that on arm64 UPROBE_SWBP_INSN_SIZE > UPROBE_XOL_SLOT_BYTES ?

From arch/arm64/include/asm/uprobes.h

	#define MAX_UINSN_BYTES		AARCH64_INSN_SIZE

	#define UPROBE_SWBP_INSN	cpu_to_le32(BRK64_OPCODE_UPROBES)
	#define UPROBE_SWBP_INSN_SIZE	AARCH64_INSN_SIZE
	#define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES

	typedef __le32 uprobe_opcode_t;

	struct arch_uprobe_task {
	};

	struct arch_uprobe {
		union {
			u8 insn[MAX_UINSN_BYTES];
			u8 ixol[MAX_UINSN_BYTES];

So it seems that UPROBE_SWBP_INSN_SIZE == MAX_UINSN_BYTES and it must
be less than UPROBE_XOL_SLOT_BYTES, otherwise

arch_uprobe_copy_ixol(..., uprobe->arch.ixol, sizeof(uprobe->arch.ixol))
in xol_get_insn_slot() won't fit the slot as well?

OTOH, it look as if UPROBE_SWBP_INSN_SIZE == UPROBE_XOL_SLOT_BYTES, so
I don't understand the problem...

Oleg.

> [1] https://lore.kernel.org/all/20240611112158.40795-4-jolsa@kernel.org/
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  kernel/events/uprobes.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 2816e65729ac..efd2d7f56622 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1485,7 +1485,7 @@ void * __weak arch_uprobe_trampoline(unsigned long *psize)
>  static struct xol_area *__create_xol_area(unsigned long vaddr)
>  {
>  	struct mm_struct *mm = current->mm;
> -	unsigned long insns_size;
> +	unsigned long insns_size, slot_nr;
>  	struct xol_area *area;
>  	void *insns;
>  
> @@ -1508,10 +1508,13 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
>  
>  	area->vaddr = vaddr;
>  	init_waitqueue_head(&area->wq);
> -	/* Reserve the 1st slot for get_trampoline_vaddr() */
> -	set_bit(0, area->bitmap);
> -	atomic_set(&area->slot_count, 1);
>  	insns = arch_uprobe_trampoline(&insns_size);
> +	/* Reserve enough slots for the uretprobe trampoline */
> +	for (slot_nr = 0;
> +	     slot_nr < max((insns_size / UPROBE_XOL_SLOT_BYTES), 1);
> +	     slot_nr++)
> +		set_bit(slot_nr, area->bitmap);
> +	atomic_set(&area->slot_count, slot_nr);
>  	arch_uprobe_copy_ixol(area->pages[0], 0, insns, insns_size);
>  
>  	if (!xol_add_vma(mm, area))
> -- 
> 2.34.1
> 


