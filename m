Return-Path: <bpf+bounces-70183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D2FBB2B50
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 09:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BE63AA349
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 07:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB2F2C08D9;
	Thu,  2 Oct 2025 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBM+O797"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17A39FD9
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390640; cv=none; b=GyGkn1+4en5ozNgun+yut3Cvzqvc41YJC8mt2myCj75y9CYrHocqeJ/0s4c3f0Mw0KvsupEso0h5GJGCubF8zU0A8qQI+ZKie+pHQkjU3t/3zw+Y5vHVXel2augGy/qeiEqjxnoVeBLXvW4TrTc+s4g6P6KZo5xMmINYgR4+a24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390640; c=relaxed/simple;
	bh=pogW6UTv3AOvKQBg1aQA9bsoBme5dZbXcz67mtZLyqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zt95F3H73Nb74RuyImE2zBhZOlpMxNr4iAxv/GDWuml8lgQsYq4QVIu/OBrZ1blw4JOcG39XuTLmLLFI1IO36aX1IexYXitpS+a22V4JRGj+8FAqh4VDkX7B8w3VzcW0BiJ4o1JKRA4Bi5jUctdRrkcoe5jYVah8vgjfW6yPC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBM+O797; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso1042516a12.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 00:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759390637; x=1759995437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pogW6UTv3AOvKQBg1aQA9bsoBme5dZbXcz67mtZLyqk=;
        b=jBM+O797zmC2rk6d/SpYNQnOaY5wuQaHY6fsuDZ7wfUUhDg9fzoF+J384La/6whnJA
         4uI/P4I7DGshWldgdjtIsLYglZ5umDm9mEzWJdmExfmiet4Qy0ies0LczIFEy8wEjJjI
         TExOCi4cROvnEQ7X1D9H/aBDke2ryml8O0ULLt7Pp7WiE3/fmLXctN6Iw/craaOuhyhP
         PYM9CQTfOzYiJbIWhZlaT9s3fBnPz4cWJ68RsEIH16f73oV1y0rd0l1h8pBIlPOhskKh
         Sbo/n/dmWqqIWPpqSYUIUJpr2qOOHaSr0rteKNa8zuPrYJdtDiOOKmbtvRyOIDAeJ939
         EeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759390637; x=1759995437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pogW6UTv3AOvKQBg1aQA9bsoBme5dZbXcz67mtZLyqk=;
        b=FfEYveD5W/cmAZk+UfdtN2SY5TomcM2MiW79BtRR+RKlEN7QgIuVkBgFY2V/oDEOuY
         liszP/tlu+qJH30gejbejkR0OJvu1+riFQdhkzpxb9tCkKtmnbnaschK3q/W3WVu+8dc
         D5N7w6vA4OUEdUlX1Hj8o/UVCEBH910iyA9YoHXFNpgdwyQq7RaQ2Zcqgr9RxqspBJ6z
         wXVLdpA+M53nbrGH7XP8SqXwITDiY4FInU9hny7TbtWRT8P5/02h7aeTV12/iWYp8KXL
         B6Vk4cfa33Qrezn6fo1PGDJWvwEMsxeRsVj3JjRZZ4W5Msoxvp0Lu0JxvukB/30X5GIt
         5XyA==
X-Gm-Message-State: AOJu0YxB9BsiTc3XpEnWJYowhhCC6vnRimsmBoS6cwMyck8zXnm5lU2p
	zoxKub2ups4w1RKBjBYl+BInh96UrZhWau0Pw7KhRhzaiqrthWAq4oCYmANFTXalJlCsGLsqsUu
	3cgxrwNloUr7mFZqUp1tKaEh1NPzdWxs=
X-Gm-Gg: ASbGncuB23x6kcY/G5jH6dLGlmTFrIyzyIVoSzfy1q17y23BiRkxM4bdv378l5NRF4O
	WR22OfWRyY6Qu1I/ZwhK9vDx4J+75y2GqJfqwovRwXaMaN0FyP/2KOx2Qpxng2+ab5oC6sdmHcI
	YzFPijrCttvU62htlE9LeUPWeao4CEAEmbyO6qVGZesCj3uIhCymjCK36uAzF6fn5aafcB6roDd
	efN7IeteLMPKlYrtZm7HLhkCSFkUijsutr82sOJGunVFN3Spz6r8hbRYpqLF/UKkP8EZWGPi4CN
	dulmwzHGY/gE5eu/ijZ2
X-Google-Smtp-Source: AGHT+IGO6ik/HoU8xZyMCup489KvYf8qiqdkB2piJHc/VPMYouIjq7P8J3ui7AQg2eqDVnA+ZQCUEQcUfHAXgd+JX1o=
X-Received: by 2002:a05:6402:5111:b0:634:a852:5104 with SMTP id
 4fb4d7f45d1cf-63678ca643cmr7099047a12.24.1759390636641; Thu, 02 Oct 2025
 00:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001172702.122838-1-sidchintamaneni@gmail.com>
In-Reply-To: <20251001172702.122838-1-sidchintamaneni@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 2 Oct 2025 09:36:39 +0200
X-Gm-Features: AS18NWDfod0Pn6d0yOPvVAYoRv-Cz3GW0lsIjQooSotdin7zHCRYNZNEMyHdbjI
Message-ID: <CAP01T77uCA-7PaWJN-uYkk0J5ks5Wd-9_iCSFcJGpLtcdgA_-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Cleanup unused func args in rqspinlock implementation
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, rjsu26@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 19:27, Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> cleanup unused function args in check_deadlock* functions.
>
> Fixes: 31158ad02ddb ("rqspinlock: Add deadlock detection and recovery")
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]

