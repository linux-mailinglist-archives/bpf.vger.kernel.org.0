Return-Path: <bpf+bounces-21898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EC6853DFE
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8284B1C21C63
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 22:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF047627FC;
	Tue, 13 Feb 2024 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m136vzen"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478563CB5
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 22:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861667; cv=none; b=YfmxZa7tt5iEAWu+GG3SwNKwsHmQofkXZz6M4ot4GEU6KsoH2kGMs9MsKATom8kUE9ViHVdUr/6YJGSCjEiJZXRmX/T23q61IbQJiZ1sD6l8k2zGHHPvmXOlNrA+5JHziYxP7dQKyN8lzpcb2ZPxSRpt/hTz01KVA6afQQsPQak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861667; c=relaxed/simple;
	bh=4CAheeC53KHJFKETnsp4jC4Xbz1peAvkqIPyrcDnt5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PH5gOvnhlQungvdPYP7fpHVFZwD/DwNcYinVNUnzJUvhs+RgT0IUHx1HlYXksqUl67v5Vwz2sAKNLk5B5XtzhjrBwSkFe6FrMppYwPFVOWYISTagddXbOuD8I0vJkuoMIZuW2jgkHpygXtQDfWsiwaYvyZoxk8AUj55cCFt3AVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m136vzen; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33ce57b2283so145813f8f.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 14:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707861664; x=1708466464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4ASdg7dH70LPKeAXxCbwv0Td9T3hnc52HS9C0fPsF0=;
        b=m136vzent41ZS6EyIhLpnCqilYtY3cWb1Lc+cECSR1lJTHDUP8Aopfo6TtC+VQJHgz
         35fFN7rqMttrfDY9LUGNqDlp6kxX4N7nF/Pv5UTrJQQ1WZlzVrZd7GO+X7AJkxWSAvJQ
         T1DNHg73cpYGS4PXQU9vJbdMvvFcNx7e5vuT2DJika48ObcvqVjgUcjYzRb3mq/wL/of
         T4VG5iTVRLGv7EagaouxH6nyvdCTmc0ohxR2PDFA4LRNx1M9cZS7757Gpu6za6r41Swl
         rOBkj+/tWLYFSP9SEn0nOD6VemBzqnCahqSvQQQTwi4BxKFq+ADtIkyB+IIpl69D0TFB
         i2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861664; x=1708466464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4ASdg7dH70LPKeAXxCbwv0Td9T3hnc52HS9C0fPsF0=;
        b=nvXaBRTAFTDvbteh+TL5K/nFyfxnfX38i40T5OaIFq84YQ0zZJ6aI1VDPaD6VuPdBJ
         uYqiwkW4rat23323PTLcGJbFLr2oDk28pLzFOGUD31DC9pp3IXj+zgKcBc/q44ltLcAq
         iqc449jcEjAQeokzPUO7+soetT+qUKrwCpROW/5zh2b6GnWgI/7dWmy50SF74O0O8POg
         x8r3K3ZhHv/BoyPRMTqSuoJJl8wR3l4An54KJFqhb2Y2M9BuABRFZUPZb7hwx5iS8PXl
         2sZYV/+lrG0tRwtY8hxy3UfYIePnzUO5nBN4I7k4e9t7V7GKC/siOFAG1O2Qe6fA94X8
         UZ1g==
X-Gm-Message-State: AOJu0Yz5zqs6Fi3nK14oS2ikj92eD0THJ5Y5Fgs9sSta0bafUmd0oNr9
	CropC1YnkurbIcjwTvzjoPqZ4wLqt+DyA9+jqYeRxd+hCJf+z4P5Ev6cxezy29x3pEyzoMUHXRV
	TZN+WZ1NH/cI96b4QtmM8bukNCO8=
X-Google-Smtp-Source: AGHT+IHnKHMo9HhU4npy2BjCarpmQklf2P5Tw0ijUrIEquhnoUnTrzZskZQNrV5SRQ4GOEWwFM2Ci5QNAAFmiZR3q8U=
X-Received: by 2002:adf:e549:0:b0:33b:4ac6:f73b with SMTP id
 z9-20020adfe549000000b0033b4ac6f73bmr402662wrm.23.1707861663811; Tue, 13 Feb
 2024 14:01:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-8-alexei.starovoitov@gmail.com> <CAP01T75sq=G5pfYvsYuxfdoFGOqSGrNcamCyA0posFA9pxNWRA@mail.gmail.com>
In-Reply-To: <CAP01T75sq=G5pfYvsYuxfdoFGOqSGrNcamCyA0posFA9pxNWRA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Feb 2024 14:00:52 -0800
Message-ID: <CAADnVQJwU6dv_LLyq6Ybcftu72hVU8YLw_C62FXL=Vwty95_8g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 07/20] bpf: Add x86-64 JIT support for
 PROBE_MEM32 pseudo instructions.
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 10:49=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> > +               if (arena_vm_start)
> > +                       push_r12(&prog);
>
> I believe since this is done on entry for arena_vm_start, we need to
> do matching pop_r12 in
> emit_bpf_tail_call_indirect and emit_bpf_tail_call_direct before tail
> call, unless I'm missing something.
> Otherwise r12 may be bad after prog (push + set to arena_vm_start) ->
> tail call -> exit (no pop of r12 back from stack).

Good catch! Fixed.

