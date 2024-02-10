Return-Path: <bpf+bounces-21694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AAF8502E4
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 08:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A491F23798
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 07:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7660D200DC;
	Sat, 10 Feb 2024 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj1E7jfi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2046FC2
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548702; cv=none; b=eHFKEprrK4Vjipn1STE0KuqpKAlokbwSBmYa0OWzmGwxu6QiHX4Km4sBpF5S54narfzuflo/0To2+IlavFBsVu+7gymj6LoE7XwVT6IfhaJkR02QfAnK9zyBZW3hs1l6h2Q/NKcOf5srAcRpq6B62mQbaUsfL1EOm65J+bLJy1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548702; c=relaxed/simple;
	bh=LDEdi0LygHXeagogV+8TsEPIUxQTlY/NMfSZCsehgoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J86c3OUQu/jOkuTzJ4kAoGJ7zyVbjEnW04WrENLcf4cUUxztdKhbo8xRjbaLjLAwt22DhKUQcLkvsmn3vFVnFCXCXYPmDj61V7HPtZwzkrx3nMZYmvv7G9MvJbVcIfZaS3QNwu+zErigQK+cm04yvLAZXsFc0Iv/F80Jj8K8Rfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj1E7jfi; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-51165efb684so2888507e87.3
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 23:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707548698; x=1708153498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LDEdi0LygHXeagogV+8TsEPIUxQTlY/NMfSZCsehgoI=;
        b=Pj1E7jfipQ1zMrnjoUsxu2EewD+CDn/21NjDkp6Dd04+dFq6gSrCyrK35aZ7bcG9J+
         0c/goM4tZplafqqCjp9LV1lJYD49DHOJNuMKoNWzEehfzMp0omYa/7Jg8R8mhlNqDtZA
         AlMGSF1jMoC/lNd5LSUX16HMPMQPDPKhXQPQmV6jm6gXxsRgViF1dxAmQPmBobRKBMMH
         tGlDoLs9Znfn4cshIkYpe+NE3oAOnwMtzLT+48tA90WYwfIvNrIjWO/WriFH3P89Qi8n
         3CFjyIQwp45m4kGc5rT0JGf9uZQVZubob0aBJzQ+353PDnddU7x3D4vWO25791hqaYYb
         1FBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548698; x=1708153498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDEdi0LygHXeagogV+8TsEPIUxQTlY/NMfSZCsehgoI=;
        b=sfhGf6SnEWDWCa8GeNQX6XOGuLy4ea8B3b2mfXBGHmQw3Dznx2YtggruC6jzqcfzhk
         cI6seAvCDt8TcFuwgVcqDRpaInNsM2F4C3ccY07CWDOQQVbIE1rpJ+x1h+NDZmEdv56a
         ZvmuXg3x4xNThEOT9plhxYKV9P66M1708WtRxKA6YkkOGIVS3doqe1DaOCUIM/DCZHVY
         JAJEJG6SP9iO3oVy1Ys8em+0y374VyTqaG6ayi9q+tm8lejUtidqiweQtS1vFf76AI6+
         L5uj5xW2FJ4FKRYzbt44rNGuzeM2hg3ITkiMEwB+yOeCqtF12fMt3uKmrz3w91MAvKuc
         Jiew==
X-Gm-Message-State: AOJu0YxJr4MTvGeMr+hu29zfHxFhgo0XXMjNu/8YT16F40OM/ZUueWK5
	fV5IH2wwBz5iUJtgImfTnuSRekpyrtx6XsbRZ/Y9lHb3pYDYjbkbLaQYNKaqH0HFZCi5uc4T4uD
	VM5OETmH3G27iOTKH13xwHNzz90N6iZvgIjK+DA==
X-Google-Smtp-Source: AGHT+IHROGQdAk5PPmQdD4D84MnIR9Y1t01J1gu7CxYy40iuoVIiDUMWPJaxrhxIevZNXfiEXiryJza5ZPmiXL4zUy4=
X-Received: by 2002:ac2:42c5:0:b0:511:5756:f54d with SMTP id
 n5-20020ac242c5000000b005115756f54dmr669577lfl.60.1707548698361; Fri, 09 Feb
 2024 23:04:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-4-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-4-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 10 Feb 2024 08:04:21 +0100
Message-ID: <CAP01T757c4PgorHZv9G12cmo0CiqocXXLmOLq30Nzjubj5PFGA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/20] bpf: Plumb get_unmapped_area() callback
 into bpf_map_ops
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, tj@kernel.org, brho@google.com, hannes@cmpxchg.org, 
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com, 
	hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 05:06, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Subsequent patches introduce bpf_arena that imposes special alignment
> requirements on address selection.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

