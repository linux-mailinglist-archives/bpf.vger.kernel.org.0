Return-Path: <bpf+bounces-43848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0082B9BA7D5
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 21:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81FC3B21557
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 20:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5C918B460;
	Sun,  3 Nov 2024 20:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3O+lyj9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D2A14B94F
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730664284; cv=none; b=hGpoUfkJYXqbj7pRN20HgRodA9lAOCfz3LuOHoPRa2qrVLsXz9afxJWYdDp5nJhsmr6wAproM5jPQyxB8DqKXSW0FkilmX0CZ0lTnAhuiHG6WwQrq2pN5eBx92KaZqZLSZoiaEM2EwYmdhYuolkU3NV8DxDk9B8///u/wAZJPqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730664284; c=relaxed/simple;
	bh=Ed1fUs9cipLw4D2Cdk2KunVDPlAIArUaJR4k7ylfCoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILLBektY9hyJrTThyHcOF/P8tpptWrXG0nakuxkKapQRfrO0Z8tFdJam5Ex6yGZFD1lR9v9UGHE3lIXJL0wnV8j5lNP3TBqyvtSUkddbWCxNCE/wLNbIX+qaRgs7GZMv+IuhBuoE2cHrVjuA/keX46X3eiVhrVS5a1xYb72/Z1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3O+lyj9; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso532788566b.2
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 12:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730664282; x=1731269082; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ed1fUs9cipLw4D2Cdk2KunVDPlAIArUaJR4k7ylfCoc=;
        b=V3O+lyj9e0qCOhKc1ClPi2Tteh62KAL5N015b9LRpKs2nEYpnyd/fHHhQdZYV8aCww
         Sc5rTfz8ma7PiMKHIDAL8uFu8OrCyLniUlwkaaJHAxaugI9P5zEBhMy52l6ZyP8afZdZ
         FPbilj6VmjQP4eITVEkSOWta/Me8IpWk68XHLC4ljEkccl6q3vQ+yqxbVThsSBN+hb+S
         vlt4Bceqckd9gXA32IMqVxZas04OtSaUJ1OFOjvqFOmcCbywZZJdkfZzGQbaBuZ7f41e
         IxfsPYvLaUx3FYAw83Ic2+8dPX8+Xp9GDjqhi0RkRi9Xm5k976juce4vtcSCwgq1wII4
         lcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730664282; x=1731269082;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ed1fUs9cipLw4D2Cdk2KunVDPlAIArUaJR4k7ylfCoc=;
        b=j2/65kEOL2NykjLMczXRnzRRlYN3w3AhleT97Udb5+ZTj/uPJLYJbDBGDFWHd8j/WO
         apzp1FgV/P/imSn40isecXv25zwoYq6Xo0zID0LkxFw/5QUcHhb7Uz6uHO8Gtqs+/uFp
         spYLB4o56iUqe/oCi7iS4fZZICWBSNdCG66x34ZVu/NZzfddFrIDgV5P/lzXLptqUlJ/
         QIh7qIS3ELZR6hnwq3imKXw0FuNbhtY/CC7xXum+yBtsZliyMI1ydrW4sxz1+qd6f+SJ
         hWg/FsvJvxS47tPr7cfMRk+qwKkqgNUTN0WsYfmWIyoz8fxZxlv8wOtKhTdXrNYXHEuj
         zSGg==
X-Gm-Message-State: AOJu0Yz83ZnrBAj/0uWU6UBaw8MhJWFzIXQsN1sDtrYqnTYWWwuElIol
	AbCL40/qxGQ9lD1ad6sAeXqJLUcAhy/Npd76YhSq8WrR7xKntwOcQQE15uXCV2fSmLyA8RPqNag
	lEP5Il2j8tujQxX5fml3R8V/P5eU=
X-Google-Smtp-Source: AGHT+IGvMeMZZG5WnvX923vw8VNvJWy6oEdmgmCRS89qoZP6PnjmWLuG26fUriBqj/Om2jcfxIJqkPNPiqQApr3B5Iw=
X-Received: by 2002:a17:907:6d17:b0:a99:fd2c:4f06 with SMTP id
 a640c23a62f3a-a9e50ca30f3mr1506324966b.65.1730664281457; Sun, 03 Nov 2024
 12:04:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101235453.63380-1-alexei.starovoitov@gmail.com> <20241101235453.63380-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20241101235453.63380-3-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 3 Nov 2024 14:04:05 -0600
Message-ID: <CAP01T76dWp7=Ci5o=PLfv-4nA_DPxwCxoGeeJzAUbi5F6WJ4Lg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Switch bpf arena to use drm_mm instead
 of maple_tree
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 18:55, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> bpf arena is moving towards non-sleepable allocations in tracing
> context while maple_tree does kmalloc/kfree deep inside. Hence switch
> bpf arena to drm_mm algorithm that works with externally provided
> drm_mm_node-s. This patch kmalloc/kfree-s drm_mm_node-s, but the next
> patch will switch to bpf_mem_alloc and preallocated drm_mm_node-s.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

