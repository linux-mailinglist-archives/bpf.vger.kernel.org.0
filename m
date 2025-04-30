Return-Path: <bpf+bounces-57024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A9AAA410C
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 04:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7127B9A1AF6
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 02:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1E81C6FF2;
	Wed, 30 Apr 2025 02:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyjMzVtN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B88134545
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 02:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745980876; cv=none; b=f73XycacsQZEmz6LoWGUmlawYDHqGwT9aTN1oMgshKhi8lshWHLZyg5gZoifLsf8WkbI44hzDbMpfDxFDDueU0sYPeNm2mNlfXY1TCK9zuawkScniFhzF1uZTS4F7w0DlJ77Hrl9rH7UZBJlfmq6r3utsunv3i8IXaI7M1PedyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745980876; c=relaxed/simple;
	bh=4ZDKouradC0LYtGluHIGMIOi8zOgxaGIq6EF3UiR4PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s1wB4xAUKrWo7gnlqWJhPqkMBc+L09ZWjRFo0M19kVVS/rHKeTLX0ZAk1IHuzxQ+r0r/kK5Vqr5nEiCSHkvkgIjFgIUO13gDwmlLMsRkv8hkOpcc6Suv8SnG8zwVnPPADAxURJGZVci1Kqn/x7ad0eCUK784BYQJM6F1nKqY1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyjMzVtN; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f0ad74483fso76580676d6.1
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 19:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745980874; x=1746585674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZDKouradC0LYtGluHIGMIOi8zOgxaGIq6EF3UiR4PY=;
        b=JyjMzVtNuyh8bUx9eXMLxz9g9d5E6oiwgyrFDTjXseryLeVLiOqk6K2/PmcBGAeOm4
         xjm+NyitPDwfKVKxMQngCbf/3mGG4YdK6sZvihSl/9dd46Ose/aoPpJYAAcYPib9EiZt
         8YRoUj9U04jJ8Q7cmC2Z8aVHmszwb+97Ir0jdjNNXTbUeJGDHuq6svN5b1FPgFGdE1IS
         GdpdhyGudC/N0Z1c3BQSLZiDqF3F1UCElFRlcr414Ps49M21IJqc3Uzr0Oa4Hqk5svO6
         ckGbIb9RNPI3B3oy6c+hs3jmr3AmU6SDeLEYMlKuCWdwvLl38iVklQ2jF9Cy3hjd/+CV
         y18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745980874; x=1746585674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZDKouradC0LYtGluHIGMIOi8zOgxaGIq6EF3UiR4PY=;
        b=adO6AoHB29A2YaQRfC8OVExi3wb4zAnSgqlVKi0aApRetK1Yr1G2ziU7XXKo+aapPj
         fACURKc7HozrdNhDgXEs0PaEMKBX+E7sGNSzYejnKOE+a6gl5cKxORFiPcxytcXaCMLZ
         lM1tkrgEGSdolchCu8a41D3jANRWBgoh8o1Wx9dkmZgUaCL0mkOSzNB/uSGmcTyqzbaR
         BpVajMe3KWeb5Exjpb/r2m5LPFVyMKfji3UyaCXrk/KidJNk+8Pdt7yRrY2EBSinW6CE
         jj6ZcLhrwgAd0kErbhp96H3Fj80tCXXOhcyjPB1Zzr+hyLx+kjS5xND/XgsPpz9GXoOq
         Uw6A==
X-Forwarded-Encrypted: i=1; AJvYcCWEHWSk/XO8RdOYnHYZ2/QbSLG7hMH/Tz/VoPF4ew5HbzO+R0oXu9dcKDGAXiALEW7hWwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqLh5eO+oDi8iYaCBIoBvda2xzLQT4ssZxIgN9PBS5LZCKvP1M
	vGgxLeSa22CpFCU/d+9VBSLCaT2vlK/V5xjY0Kai+MXe3gjeNOvbex/yE3pwiuYxbJ6HRIfETD5
	ENo1uzdDGe/XLzY/oIBqy8TQgwqY=
X-Gm-Gg: ASbGncsJkclYB190mcYg+HK6I5GnP1kY+fqrAKfdE5VZG+h857gqHSOZci01K7sg/dq
	gX0yIZC6Tb/Zb48TIBA7ycD0NoAd3DzLZT+VnWjywBSuy22OhX8sW8F0YTdz0VnALpW3CGGZ2V2
	C9AG1l9hSxAv2wOGX+/IOl290=
X-Google-Smtp-Source: AGHT+IFR1kuojXQFsOpX+8bNLR71d8z097EAwu5UtFx5f83zXV+iieSPFS+Rb443vU8cxFowPZ/S1QlAw7iX0uI5JIM=
X-Received: by 2002:a05:6214:2a49:b0:6e6:61f1:458a with SMTP id
 6a1803df08f44-6f4fce68783mr31074286d6.14.1745980874408; Tue, 29 Apr 2025
 19:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429024139.34365-1-laoar.shao@gmail.com> <20250429024139.34365-2-laoar.shao@gmail.com>
 <D9J7Y3DKHQJI.2MBF33WKN1BH5@nvidia.com>
In-Reply-To: <D9J7Y3DKHQJI.2MBF33WKN1BH5@nvidia.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 30 Apr 2025 10:40:38 +0800
X-Gm-Features: ATxdqUF1yw1wIf5mYXnfRMQw6DatmuTyzRPTsWJjtDxso3SFmXlxsOzy5LX4vcs
Message-ID: <CALOAHbCXSmTMwUNSR=6CBtFRUipFbm-58zX1FDKff55Bv4QbNg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] mm: move hugepage_global_{enabled,always}() to internal.h
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 11:13=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On Mon Apr 28, 2025 at 10:41 PM EDT, Yafang Shao wrote:
> > The functions hugepage_global_{enabled,always}() are currently only use=
d in
> > mm/huge_memory.c, so we can move them to mm/internal.h. They will also =
be
> > exposed for BPF hooking in a future change.
>
> Why cannot BPF include huge_mm.h instead?

To maintain better code organization, it would be better to separate
the BPF-related logic into dedicated files. It will prevent overlap
with other components and improve long-term maintainability.

--=20
Regards
Yafang

