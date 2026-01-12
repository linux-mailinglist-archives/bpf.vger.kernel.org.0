Return-Path: <bpf+bounces-78607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 735CFD14B38
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 19:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB5F5300EF75
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 18:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0966E387369;
	Mon, 12 Jan 2026 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD9UI73f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210073816F3
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241753; cv=none; b=pNgh3xP3D+53Aa90b3uIj6InulhBoMTS0A7diBuatSSIzDR99Ajop0oD3AZbDCudkeeK3KasXbvpVWXsJ5yXb3VTWztaDcX4yw5MoDXhNp+lRmRJrqKM4SIOL1iQIbmvwUZTGZNejZvih6dqpfDyc3ITU+A9djosXl4CJkCvTKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241753; c=relaxed/simple;
	bh=Q3/JbfjHM0s5pOiH+0X8YmAIW76XqxUMccCDleAWt8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCxrh+ZbASuPlF21nkKhzdwQEYZ5zIiZd+M4g1Lfuq36m/ehiLiET09DlbVgoAvKMm51XJr3QF19REdR/jmH3myrOOTw01bxyD3QLevo4hDeNwo6LwhhR0MfbwQOH63H/8RjBA2lsMaMEdqwri9AHp3N4oT8PqKDi9AgzG/PZH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD9UI73f; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42fbc305552so4977487f8f.0
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 10:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768241750; x=1768846550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ojpvU3cWd2g8SqNKKl4t4WvT5bdKn7vbbDKVl30Js1Y=;
        b=YD9UI73fbCUVV8hoI0eackAAXRqeqK2Sm8BI2fNjj1X73+gkA92cy1slJDIYygJ6wF
         Yv+Meygjiz4rqQA0jKFH6E/KWaOcKULh0vGu4uwcMy3TqNH0JgX6WHN/3WK6c8QILIIR
         Cjm0SrPsxkXmERpIS60qQDWUGLphHJYB+tHFdJjSRU/11XivusrFf2gIRZzFhSraWuW8
         8yLz8QLpcIqiZv/EW0HV9AoU0DSQLl0Bu6eEkQDho41VzjJP+ZvVOYEP4a2l1dCd+ZQK
         J+QlyMxC9l4dAG+J+DdxAqnyqA2YVsVAHt5c/kFShBSAh+UkkVUCk6QD/jjGNMMCVfgU
         Uxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241750; x=1768846550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojpvU3cWd2g8SqNKKl4t4WvT5bdKn7vbbDKVl30Js1Y=;
        b=g6xuYgFypuVvRI31C8ArdgADSgaOSms4yN6fPmLKWFcYJVUlzeKCk4Evem/QLgtGhd
         Cmj1qYVc1VxQPlW45NdHj2G6qOPgA+oWoKls9tcKz6rA/Am5ihR8LNK6fs1YGahlV9kQ
         Q3FFk6yq9mNVmFmGCH/rODXh4r1kZ5Z3vgYrkZuMhW677zWqHWGjz5TpUMJf7orBGcH0
         sZ6XJvT1DLXIIzXT79phFaql6eADkOf3E3ta4F0FGw7EIfaKxBuxA3ZEeXxAr4RxYMBD
         myhWe7JeQXf1pQPgYHhJBJofvR68z0vVgvhY4WZd20KDAEjfxldJXcfFhSXuvJ0XQ3vI
         QwtA==
X-Forwarded-Encrypted: i=1; AJvYcCWrX7WEZAOm+/1edf7z3mMnx5JM0VkhAz0uf2YKddTps7xpOq+oN8bi+XZ6FFpovise4Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzblixn0oE215D8J1GGFujJbDpCbvR2lk5nkZ/Hb+LkFj2Inb1t
	JhJzsagM/zYdc08zVkdhsLyAYN2zxtEAJN55TGk5QeLd9LvobdD5HLRyMImnwLYMbBksIL1klGq
	Q3Bf1Euz7h8Bs/cR6biBdUmonMPpFrBY=
X-Gm-Gg: AY/fxX7pjCYyc8rIftYD3QfT02ua4TZ04wYaJRO4QpMeKsyaJmHmbUujAkpKd+LidfU
	Xle9z+u9zufKxI7ls5VWa64SU2XZ12fHjZNRUJ8YZZSygOht1t9vS9sO8gMkkv82uKdGKo7qbNU
	ro+n2IBLyaRzGYgrw062BmFQL5naNqMbyqO/j5jnl+Emw5fJ0p/7YaEtg3fZBnJhYMvyfaB5y/C
	/ABPeIiXOwja2f9VHZ71YfhhyHrL2G/RkD5vPd2z38umHNU3UWomP52BWLVt7hJceeyRYPftpuf
	DNJiEsjVRRZvguKvtUa2F9XiuVg2YQ==
X-Google-Smtp-Source: AGHT+IFrIHjOEZZ4tM2qMA7rYlMNt7opT9ul/vacNbwKdyDMZhWjrZGywA5DVNv37cgrq7oj+Zj+eVUaXmIbciST1p8=
X-Received: by 2002:a05:6000:2891:b0:430:f742:fbb2 with SMTP id
 ffacd0b85a97d-432c3760bfemr24448348f8f.19.1768241750266; Mon, 12 Jan 2026
 10:15:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_0074C23A28B59EA264C502FA3C9EF6622A0A@qq.com>
In-Reply-To: <tencent_0074C23A28B59EA264C502FA3C9EF6622A0A@qq.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 12 Jan 2026 19:15:14 +0100
X-Gm-Features: AZwV_Qjto2JyQc1LxIEe9oKkaItYReWdH5nnnmonBtrB0FR17QsUuBkZg3JSaWE
Message-ID: <CAP01T76JECHPV4Fdvm2bds=Eb36UYhQswd7oAJ+fRzW_1ZtnVw@mail.gmail.com>
Subject: Re: [PATCH] bpf/verifier: implement slab cache for verifier state list
To: wujing <realwujing@qq.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	john.fastabend@gmail.com, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Qiliang Yuan <yuanql9@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Jan 2026 at 13:28, wujing <realwujing@qq.com> wrote:
>
> The BPF verifier's state exploration logic in is_state_visited()
> frequently allocates and deallocates 'struct bpf_verifier_state_list'
> nodes to track explored states and prune the search space.
>
> Currently, these allocations use generic kzalloc(), which can lead to
> unnecessary memory fragmentation and performance overhead when
> verifying high-complexity BPF programs with thousands of potential
> states.
>
> This patch introduces a dedicated slab cache, 'bpf_verifier_state_list',
> to manage these allocations more efficiently. This provides better
> allocation speed, reduced fragmentation, and improved cache locality
> during the verification process.
>
> Summary of changes:
> - Define global 'bpf_verifier_state_list_cachep'.
> - Initialize the cache via late_initcall() in bpf_verifier_init().
> - Use kmem_cache_zalloc() in is_state_visited() to allocate new states.
> - Replace kfree() with kmem_cache_free() in maybe_free_verifier_state(),
>   is_state_visited() error paths, and free_states().
>
> Signed-off-by: wujing <realwujing@qq.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> ---
>

Did you run any numbers on whether this improves verification performance?
Without any compelling evidence, I would leave things as-is.

