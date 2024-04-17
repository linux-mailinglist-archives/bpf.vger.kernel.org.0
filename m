Return-Path: <bpf+bounces-27023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F408A7CEE
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 09:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BB928284A
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 07:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52066A8A3;
	Wed, 17 Apr 2024 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aqf9HC2m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF1940850;
	Wed, 17 Apr 2024 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338250; cv=none; b=pqb9XcZ6qbfXu9AfpMxsTToEWpY6zQQD8COOeGm3htBQcg8Qzpv6CeWx0sB/5izBBTSaHhCYtHF3hKl3ebryYkEdcp/W/ZteOV3Ftuu4UaRRsF4YwF5xN1+2lF1PLfrJlXlsBCEJAbR2GCoIrAp+a5Mk9GdIDEdIlLjdh5nDvHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338250; c=relaxed/simple;
	bh=V4lv9QAgXIfIVyOy2mUKTwIbsLP0WTd3oSTm2v768c8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spQwzA9ARbWHRv0DrOHr5goeB6ZaYKZkLVD68fs2EoIZRCkZ5cvYqievCxvV77108qZ5sjqKX+Y/DTHDW59e9ClqvvLkjE2Ky/xADSAimquR2npSTn6ErnzKKXWNPaBqc0gLb2PE6xM0QKvjU5HSpKIKuqKxDWuDFQJ1K17h0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aqf9HC2m; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343c891bca5so3446771f8f.2;
        Wed, 17 Apr 2024 00:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713338247; x=1713943047; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ggl42zVrBdWXeGc93czmjM6s9Fyw3wz00pYFrGL6UPE=;
        b=Aqf9HC2m0QbWvP+LlOe5uFt9QpzLEOnj6VwtDzdHwhYwtIzAghr+VnYmYhfLsJcAX+
         YTDavQHvc/ej6y485ylaA5Q8SdIEYQg92/g1JeT3X+ks6Kkk3L0lI268qs4gASKxRBGx
         aaWtxUth4nrfWA6QIMLadLzE6xC08FlQ+JBXCSh91LhTYxBTZYxdVj0yQIX5ZygkKxlf
         175Q5FI+IaUHaoo16aGMuFLIc5FZcTSZamJ/Lz910322FuUHjRHRNPYIKAVy2OTiQYVI
         U+yp+JQ5yaurNxSn+quqahEkbK8/tKM8A/axrJ6aEphrddqmjGulRIsPgOvtL9imYjS8
         7RbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713338247; x=1713943047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ggl42zVrBdWXeGc93czmjM6s9Fyw3wz00pYFrGL6UPE=;
        b=DAIbSdSqlPY/ByOnV+Odo0sg5oho51nK/syF8ljh/YkYRgdsV0c+IICRXluktw5Gss
         smd6fkcWHz5odP2wAi4h/uzdzi44yubaJxRYjGgUo5OuB1FAgdxp/F7LSbEzNM7BmYW7
         DNRHOHIcaOgDe4Bqyhrnqa/kKNpvv6CBIhrTOIDMFfzb+3yknv9QsWgmYdzxK8SjBqez
         ZdJD00JsXPiMq0mNj/886j6iwMYcN3YKI06rPUxo11wM2OhHwcy0VGB2WdTz7vGuhlOy
         6XdVC2oKYeeyqSu+7KkFIAwD33VGxtEhb1+iFGVQOJUDiJx20eYrDOCX2c0z4VfALiXk
         tQ+w==
X-Forwarded-Encrypted: i=1; AJvYcCX54X2FPrzqW+aVGTurHqxyQZeGPy6BPV8r8F5a/+ZYwmgsn+8eGI0LELm0PYid39Sn+aZA9c8ZJo47IsSauRqQXJbTV68YOeY7389x9x0Y5gVFMmbe3Pil8qpMj6Dj/dAf
X-Gm-Message-State: AOJu0Yz77h55dbhiAoyd3bGNFHmYlJzi53rp8yDQt4N6HtfeOrNcudup
	6YMQc5H/r5kPzuDWrjt1R3PYH6mBrNUABnvKaOHJn4564EsYVdts
X-Google-Smtp-Source: AGHT+IF3Ak86VL7pFvOSdAF9WJs3e6X5MmjIWzPfbrgMWdYNRNryLXnnA4PhqFNEyfTJVPyB95zKbA==
X-Received: by 2002:adf:e2cb:0:b0:346:5c1b:39c with SMTP id d11-20020adfe2cb000000b003465c1b039cmr12300405wrj.41.1713338246957;
        Wed, 17 Apr 2024 00:17:26 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id b10-20020a056000054a00b00341b7d5054bsm16891820wrf.72.2024.04.17.00.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 00:17:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 17 Apr 2024 09:17:24 +0200
To: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <olsajiri@gmail.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	haoluo@google.com, sdf@google.com, kpsingh@kernel.org,
	john.fastabend@gmail.com, yonghong.song@linux.dev, song@kernel.org,
	eddyz87@gmail.com, andrii@kernel.org, ast@kernel.org,
	martin.lau@linux.dev, khazhy@chromium.org, vmalik@redhat.com,
	ndesaulniers@google.com, ncopa@alpinelinux.org, dxu@dxuuu.xyz
Subject: Re: [PATCH] bpf: btf: include linux/types.h for u32
Message-ID: <Zh93hKfHgsw5wQAw@krava>
References: <20240414045124.3098560-1-dmitrii.bundin.a@gmail.com>
 <Zh0ZhEU1xhndl2k8@krava>
 <CANXV_Xwmf-VH5EfNdv=wcv8J=2W5L5RtOs8n-Uh5jm5a1yiMKw@mail.gmail.com>
 <Zh4ojsD-aV2vHROI@krava>
 <ddc0ac5b-9bd4-f31a-a7ec-83f7a10e6ab1@iogearbox.net>
 <CANXV_XwGhdV7v05Xjjp-g9yW4E0FjA=84M8jZ6bcf7yuooDkig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXV_XwGhdV7v05Xjjp-g9yW4E0FjA=84M8jZ6bcf7yuooDkig@mail.gmail.com>

On Wed, Apr 17, 2024 at 09:26:03AM +0300, Dmitrii Bundin wrote:
> On Tue, Apr 16, 2024 at 5:47 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > Please add the error description as motivation aka "why" into the commit
> > description, otherwise it's not really obvious looking at it at a later
> > point in time why the include was needed.
> 
> Doesn't the comment /* for u32 */ following the include explain the
> purpose? I thought the include was actually missing since relying on
> indirect declaration of u32 is relatively fragile.

I think you can add similar descirption as for the already merged tool
change in bpf/master, and also include the Fixes/stable tags

commit 62248b22d01e96a4d669cde0d7005bd51ebf9e76
Author: Natanael Copa <ncopa@alpinelinux.org>
Date:   Thu Mar 28 11:59:13 2024 +0100

    tools/resolve_btfids: fix build with musl libc
    
    Include the header that defines u32.
    This fixes build of 6.6.23 and 6.1.83 kernels for Alpine Linux, which
    uses musl libc. I assume that GNU libc indirecly pulls in linux/types.h.
    
    Fixes: 9707ac4fe2f5 ("tools/resolve_btfids: Refactor set sorting with types from btf_ids.h")
    Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218647
    Cc: stable@vger.kernel.org
    Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
    Tested-by: Greg Thelen <gthelen@google.com>
    Link: https://lore.kernel.org/r/20240328110103.28734-1-ncopa@alpinelinux.org
    Signed-off-by: Alexei Starovoitov <ast@kernel.org>


jirka

