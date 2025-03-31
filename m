Return-Path: <bpf+bounces-55005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97660A76F68
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 22:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5207B16409F
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 20:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD3E219A86;
	Mon, 31 Mar 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="RgmI+aEh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6D0217664
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453258; cv=none; b=hhHJSCzCJABBuIFzQqROh0SUTi7ewFJnQUyHFEjxCrcpFeBvqqCSnGnl5WpD4+IWZmsvWSHbkHingDEUaTYwIdK3ZcbsNFBCCLlH7bAWMxNrQKYsaBzRCuys+Dz4AcaDyM+uDYq7E1YYLmkOEILDlYKymmJy8aCEnVW5tJ1gEPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453258; c=relaxed/simple;
	bh=Al/1tCYsrdXclJlMIEvLK+68JB9i1no2kWQUIGVnPK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmNmD333JszOyDEcvYkxZBwrOZbxm0fvcOZz0JowxyW4+gckD2iman9twVZ+hvESZnwIoXVsWba1nktZern8silms3Nph39z+Do0OMfFdHViH2n3VeDctuMDV+CpXUhnTHIZCC+vom/pbRYTlNmfyBchlHTD3pgaXiTz2wqK8sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=RgmI+aEh; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaecf50578eso844673866b.2
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 13:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1743453255; x=1744058055; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FtBD1D9Bxpz/b4j3qBbX8bn0WB46Sg/0vM7wDZiZni0=;
        b=RgmI+aEhHLZ83kS7lHh8YcSEZlv59qs5YN/zGLfJMeC2U5ztS+aOIBkJTTH1kwTYeg
         RDvbbplobIIQigVY4qC3toYj7JnAbDPZfBbtCtRmLFXxfssjmI3iEi2j66+DaSQ8tOTP
         ECr+tOrgkT6iMTxX07e7H7g/D/mV/EIv4jThltYCAREQLC3HhwHu4nK8ZHAZ9YnV8pkR
         L/wlC82VFmxpYxi7z5NMZpgINCBUMo8zyCIeSM8hLQ/zP0PoG02d0hdv9LZ9ALMfOMVY
         vsghQtciTaweQK+CUliMNRItk5llfTJqjtUE9gv+Xv3fIynjtm5KYAmaafPRUvhBOKhR
         IN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743453255; x=1744058055;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtBD1D9Bxpz/b4j3qBbX8bn0WB46Sg/0vM7wDZiZni0=;
        b=U+k8JX8IYa+aiHqIMptRT59xfbdNUYpG22gHgerZvqkYS3A3ctI5mh0Jlu+v7d3zgr
         y0Arw6FhZ477wNJg26v33XlR+psDk3c1oPuDazdNa2F2hDcwlWU6FC7VTkveUqg3gOL0
         NYez2TFsT0ujNa5U1z3bd9Coc9Q/ULmh9PreCfesLNp7h8KmskO9axLLFMy84VdspVro
         RYV8b4RqE5svkW8kWwPtLMKsAb2aR2zJhvobVh7dAReovN5bg11IxfQhIIqtqp4YTQMs
         U6uMXeNQOUcogGuNCCHGkdN0XmSPP/tuj3xWJgnPB+zcIftJsWFdFeovlJYEwaUmQ+DC
         Sp+A==
X-Forwarded-Encrypted: i=1; AJvYcCUijl+D6QfXAks8OlO8jyWyQ31giOqkZjL/AIUmKgwipIgwiGm5E5yor5djgn737T/WbIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEJAc/rz38lx27tJeryu4qRjfAD7wPjVN9CCz0wgPtXLOrvPCp
	M0oaRvbgETv8IvtJ94hf3ShDhGKXtdXp6qlwr0XNiE5qD4h0ptO0qEiI/iqb94hojgbDL6qZxT/
	Ff9Y=
X-Gm-Gg: ASbGncuzI7+LPUWTzfUVR7Cg/bVNsoeki/HvMEvr+iiBcHYwR1FWbDUb7h3UCfPGR6n
	TPtIPXKz3eVflmCDwUPOvv7XpHE6TLe5vA/JxiegxBHzoETv98iHz30hnyYPkUuDa8lZZfNepQM
	quBdhuF0BDDKN+rdN7s51Qwm7x5DxfA3AP2O10Zcp1osTpeGvu966o1VLUqcA7zzKJAvTZ3E/lc
	j0tkyw/3vCb1K1lC7T/FzdGFpYAa2PqjEBSWwXEvkkZccx+/6fehn0wFbrTqpztyjfE6ngJQl/E
	eol+V3VDsU3JRuG3ElCWTf9jub8uRyLpcCNlQ0wY7YvxlHn/
X-Google-Smtp-Source: AGHT+IFXWLsOkVhNKx1G8VWKlaoyoHz/BeD3SY6x1XoqBXPo1rxYImBjUMzw9AzPEcPvrmPEt2Ab0Q==
X-Received: by 2002:a17:907:c1f:b0:abf:4ca9:55ff with SMTP id a640c23a62f3a-ac738a9853fmr818003766b.32.1743453255148;
        Mon, 31 Mar 2025 13:34:15 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac719621718sm679928466b.102.2025.03.31.13.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 13:34:14 -0700 (PDT)
Date: Mon, 31 Mar 2025 20:38:41 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 0/4] likely/unlikely for bpf_helpers
Message-ID: <Z+r9UcPhDyikP48+@mail.gmail.com>
References: <20250331081308.1722343-1-a.s.protopopov@gmail.com>
 <CAEf4BzaTf-SKBW8j7Y_D81Y4j+MB76Bn0xBRr0YJdv+B7aWfTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaTf-SKBW8j7Y_D81Y4j+MB76Bn0xBRr0YJdv+B7aWfTQ@mail.gmail.com>

On 25/03/31 01:12PM, Andrii Nakryiko wrote:
> On Mon, Mar 31, 2025 at 1:08 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > Andrii suggested to send this piece with small fixes
> > separately from the insn set rfc.
> >
> > The first patch fixes a comment in <linux/bpf.h>, and the latter
> > three patches add likely/unlikely macros to <bph/bpf_helpers.h>.
> > The reason there are three patches and not one is to separate
> > libbpf changes such that userspace libbpf can be updated more
> > easily, and the order is such that each commit can be built.
> >
> > Anton Protopopov (4):
> >   bpf: fix a comment describing bpf_attr
> >   selftests/bpf: add guard macros around likely/unlikely
> >   libbpf: add likely/unlikely macros
> >   selftests/bpf: remove likely/unlikely definitions
> 
> let's just collapse the last 3 patches into one? libbpf sync process
> will be totally fine with that.

Thanks, I've squashed them in v2.

> pw-bot: cr
> 
> >
> >  include/uapi/linux/bpf.h                          | 2 +-
> >  tools/include/uapi/linux/bpf.h                    | 2 +-
> >  tools/lib/bpf/bpf_helpers.h                       | 8 ++++++++
> >  tools/testing/selftests/bpf/bpf_arena_spin_lock.h | 3 ---
> >  tools/testing/selftests/bpf/progs/iters.c         | 2 --
> >  5 files changed, 10 insertions(+), 7 deletions(-)
> >
> > --
> > 2.34.1
> >

