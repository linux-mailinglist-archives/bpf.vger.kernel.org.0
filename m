Return-Path: <bpf+bounces-75291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DA7C7C42A
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 04:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629EE3A6508
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 03:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D1B1FCFEF;
	Sat, 22 Nov 2025 03:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc+WfPGm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22303D544
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 03:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763781470; cv=none; b=UhLpTnHtq1K9lSqErwshRKyCRzxDG574aBWu4eHhTgCRUPy+XBKZ2QLKyWeZFQNxe4kHp1DTsmYQzyLo5Jq6cytbCUy+b9K4vSX9/mDI231WAkM582UXcnWChmDg5U0Ij1CasdnmIpBBO3ypLoL1AxroXgy3T/5S/bcHa8EFY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763781470; c=relaxed/simple;
	bh=28+WmgM/+CKfCABHq6PC/TsqPLf0JUWaaQiHxzCwkkE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ipcM/TB4h1654TZzOzI3dN1sut71dQd9tydDh2WaCFCb2wncJdjWdBXJDqfBG27bKLgHpynir031HB1FistsVwwxXL1WeD4FigLcQS4Ha1mPHZPxpmHh+MDJUivPJagyYZWDxiX580AHoC/ny2oJnxFcau2ZKHd1lSTYnBvyYY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nc+WfPGm; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso3996828b3a.2
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 19:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763781468; x=1764386268; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Ye4QST3q/cf1iDPtMXXuYLqjmYnlCQ5P5ThZKunQ0s=;
        b=nc+WfPGm7NCCdNDL39mswK1gSCabgaZ1qfitmCiwsJBfLJ7xhTOkrWeQB2qEDbFALY
         mSLpkoushA+foaSBsIgrWd2OhU+Os5RJAK+YA1jtUbSOLaSm4yZLYfPPrzAtNYT8dk8j
         0d8gUTvHuWuNIFqya/MDWnw0r/HPXsqlG8mLL4cMeZHMJVvnZqCNvkjil0sjWfa5wxym
         WY2hz8LuinNgfpjGor+5G6hrd0sQk2le/pxVzgvWlIiA/EO+UJuAcGuqybupEADhA6Ar
         B6JhHs7EI37IrHsLdr2rS/RW5AQhp/lAbo0htDdhB23BJ2Kg5yBWSyDuP9fYy4F9tdAg
         HLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763781468; x=1764386268;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ye4QST3q/cf1iDPtMXXuYLqjmYnlCQ5P5ThZKunQ0s=;
        b=sart7ohQRKj+cQWwwzKjSYc6ocAdRhguY7vALjF0Uuxzjj6kRWO07xYs/PznGCZ9JF
         g6W+qid5Uvs+EbrV2aVX88Rhz220wMCEjUICeIGDXAViMHrMO6NfEePiItbfxlK/oREn
         pKs2iwalU5WbeZe+a9dNaiyTeqw0Z52Y6z2R/X1cpLL8THr2wUT4gflY375U5OJSpdaB
         vZCx1bL9AsQ4LW1ADmTtKRydpGQSF7imN6l/aYD2Ttc9z343GHAqnBER/phh+jOqBxPE
         iUPj32f/ZRFbwnNPPC0yLMmkzYD7X33LJCXKEkCKMa9cww2PLYVb2aLVyeQn7cIeAWaR
         O7CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS74T+kAHEJlNeWCdbXD7rfbwBdHaceyy7WayCzS3eS8GuuFy2J407hCF47zZ28H9ZMEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvJ+5q5/+ESkWzYwp/1G9FUyvxlrHYIRjLkkeipZlJkK6jKtex
	9u8FnGR4F+bM0yL6/V8mUWmlAShO1aPm9XNhxt+iDm0vme7Iq7g1lMbw
X-Gm-Gg: ASbGncvDZhajHNqOcwISOcl/c9g2ZuT0G9QV9j2oWMBGyO0VLQtfSLA3m1sdCmef/yZ
	pVApAseOPhWk418U1++ptQ7eJlMq0AznPVm6BQsGJbKjaK90kS8BSvWvTLVLoSuQtisYyjEE+xw
	S9OE+P+hW5nyevEpotSzqGcMCNOu8hXSpIGM4eWyrabR52fZjpcchBaPLUFl6gYDgPZc4MrBPJr
	ESwbOZVgrs8jls9j0ZBr3ubd66T8PeMogFXIU4ngUtQmC3ttS2twVtDP5z9tYm/K/rmndxlkSNt
	g9eCmGdyzUWrQF40emnMmgT5NezNVxU1AJvPhMSO+HDi40e3WERQdzLpK8mepCuGJXPVTwdRlUX
	ufV4fyCoRLZA6b1ZkNtxVZxIKvJ0elfseCzHjhgipy7bzaiimbFObqUyAVR6VQGa2mgOjWzJk97
	XKxCpk7Y8=
X-Google-Smtp-Source: AGHT+IHO4ydTIhSbO2WNmt5oQ8Fe9+lLI3hTdcPFypXFjku1lq/7R/Xw48pDAtfS2vUSo60Sn+NJ4A==
X-Received: by 2002:a05:6a21:9997:b0:34f:ec32:6a3c with SMTP id adf61e73a8af0-3614edd7f2dmr6332542637.28.1763781468130;
        Fri, 21 Nov 2025 19:17:48 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed37ab3fsm7571035b3a.22.2025.11.21.19.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 19:17:47 -0800 (PST)
Message-ID: <ef19d394a7b4993a4f42fc063a9e33bf174f7035.camel@gmail.com>
Subject: Re: [PATCH v2 3/4] libbpf: offset global arena data into the arena
 if possible
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	memxor@gmail.com, andrii@kernel.org, yonghong.song@linux.dev
Date: Fri, 21 Nov 2025 19:17:45 -0800
In-Reply-To: <20251118030058.162967-4-emil@etsalapatis.com>
References: <20251118030058.162967-1-emil@etsalapatis.com>
	 <20251118030058.162967-4-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-17 at 22:00 -0500, Emil Tsalapatis wrote:
> Currently, libbpf places global arena data at the very beginning of
> the arena mapping. Stray NULL dereferences into the arena then find
> valid data and lead to silent corruption instead of causing an arena
> page fault. The data is placed in the mapping at load time, preventing
> us from reserving the region using bpf_arena_reserve_pages().
>=20
> Adjust the arena logic to attempt placing the data from an offset within
> the arena (currently 16 pages in) instead of the very beginning. If
> placing the data at an offset would lead to an allocation failure due
> to global data being as large as the entire arena, progressively reduce
> the offset down to 0 until placement succeeds.
>=20
> Adjust existing arena tests in the same commit to account for the new
> global data offset. New tests that explicitly consider the new feature
> are introduced in the next patch.
>=20
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

[...]

> @@ -3006,6 +3011,17 @@ static int init_arena_map_data(struct bpf_object *=
obj, struct bpf_map *map,
> =C2=A0	memcpy(obj->arena_data, data, data_sz);
> =C2=A0	obj->arena_data_sz =3D data_sz;
> =C2=A0
> +	/*
> +	 * find the largest offset for global arena variables
> +	 * where they still fit in the arena
> +	 */
> +	for (off_pages =3D max_off_pages; off_pages > 0; off_pages >>=3D 1) {
> +		if (off_pages * page_sz + data_alloc_sz <=3D mmap_sz)
> +			break;
> +	}
> +
> +	obj->arena_data_off =3D off_pages * page_sz;
> +
> =C2=A0	/* make bpf_map__init_value() work for ARENA maps */
> =C2=A0	map->mmaped =3D obj->arena_data;
> =C2=A0

Please correct me if I'm wrong about the goals of this change:
a. Avoid allocating global data at NULL address
b. Reserve some space to use by upcoming arena-KASAN functionality.

For (b) wouldn't it be simpler to implicitly increase the arena map
size by an amount needed for KASAN functionality? Then there would be
no need to guess the necessary data offset.

For (a), is there a way to move an address of first valid mmaped page
(from BPF perspective) w/o physically allocating the first page?

[...]

