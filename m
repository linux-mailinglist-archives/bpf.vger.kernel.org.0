Return-Path: <bpf+bounces-74792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA09C65F3E
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 20:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F341F4EA1C3
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 19:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E192F2916;
	Mon, 17 Nov 2025 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SaZRkxyr"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB1D3148C6
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407338; cv=none; b=Xum4v//1e9MSBZzYPo1ytjGoU5ejOt51N5CNlTtdehaZ3eBIRZgzbl3xHSVTpgUDIeYnG9t98sRhTUlQS75KUtE+3lRoTz039Vq6QecTWZbgOjKfjL6VMEyDawj7h9jYYml0hRxHI1+2plFrhUi/ZN5pxdC9ssJW7GsTsWHSc00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407338; c=relaxed/simple;
	bh=6OzAaa8iDws0lcwjqF+XKbYPhYhAfB1q4BqeCW3R5JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgALV+ehr+5jHOcci6hCVz2rDG3uayjCws0k/1WLzDGatkTuBoNvIr0bERtD9y7P+NU2rTP+h4HJCE/3fg5rE+jTGGzDg0WeXnXuYx+evqz9ihe2B7TFMVgulnbXuujFge9IMh67viebVZf4csiv9y8zWi+67m5kz1/O8GJ0JFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SaZRkxyr; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ebbf8915-1404-4d4f-9b5a-b2f3924ec43a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763407323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbe+9JyBXKDiB3Lmr5harb1LuYhqhGndoF1DwtiK2Wc=;
	b=SaZRkxyrfN0vRx6wzM50Jmklt08m7NIoAgk4YCVnJUPh9TNLat3ooxU+Jl+8namMz/jRw3
	VJ4rLD9/6dbgiVBuDVc0/BOG/3GTs90YdonudQiN7Je433jZ8w0ce8ySzUU01ywS26P+JY
	o6U7fvsAOJn7Qw7CkSk25glE4jkV04o=
Date: Mon, 17 Nov 2025 11:21:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 4/4] bpf: Replace bpf memory allocator with
 kmalloc_nolock() in local storage
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>
References: <20251114201329.3275875-1-ameryhung@gmail.com>
 <20251114201329.3275875-5-ameryhung@gmail.com>
 <CAADnVQJD0xLa=bWUerdYsRg8R4S54yqnPnuwkHWL1R663U3Xcg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQJD0xLa=bWUerdYsRg8R4S54yqnPnuwkHWL1R663U3Xcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/14/25 6:01 PM, Alexei Starovoitov wrote:
> On Fri, Nov 14, 2025 at 12:13 PM Amery Hung <ameryhung@gmail.com> wrote:
>>
>>
>> -       if (smap->bpf_ma) {
>> +       if (smap->use_kmalloc_nolock) {
>>                  rcu_barrier_tasks_trace();
>> -               if (!rcu_trace_implies_rcu_gp())
>> -                       rcu_barrier();
>> -               bpf_mem_alloc_destroy(&smap->selem_ma);
>> -               bpf_mem_alloc_destroy(&smap->storage_ma);
>> +               rcu_barrier();
> 
> Why unconditional rcu_barrier() ?
> It's implied in rcu_barrier_tasks_trace().
> What am I missing?

Amery probably can confirm. I think the bpf_obj_free_fields() may only need to
wait for a rcu gp without going through a rcu_tasks_trace gp and the tasks_trace
cb, so it needs to ensure all rcu callbacks has finished.

@@ -247,18 +231,11 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
  	}
  
  	if (reuse_now) {
-		/* reuse_now == true only happens when the storage owner
-		 * (e.g. task_struct) is being destructed or the map itself
-		 * is being destructed (ie map_free). In both cases,
-		 * no bpf prog can have a hold on the selem. It is
-		 * safe to unpin the uptrs and free the selem now.
-		 */
-		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
-		/* Instead of using the vanilla call_rcu(),
-		 * bpf_mem_cache_free will be able to reuse selem
-		 * immediately.
+		/*
+		 * While it is okay to call bpf_obj_free_fields() that unpins uptr when
+		 * reuse_now == true, keep it in bpf_selem_free_rcu() for simplicity.
  		 */
-		bpf_mem_cache_free(&smap->selem_ma, selem);
+		call_rcu(&selem->rcu, bpf_selem_free_rcu);
  		return;
  	}


Others lgtm also,

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>

