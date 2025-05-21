Return-Path: <bpf+bounces-58630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0189ABE8C4
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 02:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E219E7A761F
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 00:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49B135950;
	Wed, 21 May 2025 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6o9hlUR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D4F9C1;
	Wed, 21 May 2025 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747789113; cv=none; b=iGUuTWZTiS5+8QpVlvb6MozvpfxbSGp8VGTcY119J5jCR7RP/0z5k8umZsxMP8oMYpAew8ohpTRjnfrvVPhPAJ17haGLzkf7CV7aN41QL83CFp8mHC5grOxf0TiY9YVym3L5H4+x2gITpekBuo1MX7hX3TqTSwD0WJoaOKP1IVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747789113; c=relaxed/simple;
	bh=HyW+5TiMfu23CqQhtcIrNmOiegHzg3H0wfU8MWchsEU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNERVgrFzOO2uTYCODOMoTT9mCjhlE321I25HodKMpKXzoxBfUheLSDEylZ+wJQBZDXHo6jcGr1p/uYA52p0sO9nCJMKtnoqd5U/lUJbaDUgPm95gVVQrzWy1PEQdw/rifeiLveY2Upm2u+bDjpcJDilamfennD5FKUjcAWOymo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6o9hlUR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-231e98e46c0so37200095ad.3;
        Tue, 20 May 2025 17:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747789111; x=1748393911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3q3ks04REvLgidweturj0ZAba0HHBIhzpzDzZr1ALwE=;
        b=Z6o9hlURiNXczJ9qDclJYm02rx41qS5ue14lmAmEY2+/qAKz7rmuIQOIQykvowtTQV
         tvpcPaZG2+MOEEhqMroK7BqDBNOCHskZVje9AoEuOt72tEfhEJ5pT2IduIE698xHEMA1
         b7jpB0z5ushDkpG29rYbcU2iFC9GfmQ3CzzGraAGALInpMYAlP/o8+sRS9dkEkPOR4kS
         apkt9Me7qQ45uL0w0/VroljrllswZ8ej6KoHl2NH5/pxN31/kjDB9Fxg4p47a181DI7p
         jaQkR/Xktl2UOwJemMmqK3lrz/NY5PTL003LwRAHGK6UQ5fFNPL2xfY23ZuFv7qyd6J6
         ClGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747789111; x=1748393911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3q3ks04REvLgidweturj0ZAba0HHBIhzpzDzZr1ALwE=;
        b=nVRyjDSWhvX/PBWmHtYO2uf9XDdBWobqtVsDFcWF2qhQocj4hx7V3BNJvoeSDQ6QBx
         dxMFr+79grS6EV8P0TmTrXKS0lNCzssDFAnJn+zPwQ1B2rpI9yDbomGCRTv2wMnCP37o
         jJSdP7s7qOLHgEO3JW/3TAy6XAOngwymdx6JC4o2ofJgPxyqqIXJQ0fCm1OVxG/swzP9
         l9oQv9Df8QG4ww4oM5DvnWGlnvp9umLHtBgQhwMNHuvNEwpVPROZTKceeOm2y51G5r4E
         Qq0iQZFXLRUjBSmwsRPFR5X2ZLSg5CBeK/H2r1CyhbTMNRTZxXnALBT4iTxS/yY2qxs6
         qWzg==
X-Forwarded-Encrypted: i=1; AJvYcCVfRGIr7DGKuHtcn/i9opX/FFyoOHe8VNxa0760/kIhX/VLKvyv5pCz1owxYdPuykvJ9MY=@vger.kernel.org, AJvYcCWBkaWDBI28ao0Fvf53BVeRJMzb9lrUxQl2Lql7BEoBZTTU6SQRnZUw5HYWUEpiL/XheAxhfDio4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTUxsI4E0RrJLUCtqEK3ijmx3MbIM8yFfFXIShjuANj81GXtkG
	lPS9KGXw1ZIHmlpOdNbeHy7pJoKa7HVf26S05kmtMGiXuCdRFyVsYvEi
X-Gm-Gg: ASbGnctSUK4IxoYUMwc87yDeiq73MPU9+8+KyjBeG1lA0ZeRc24Sa9SzE4ub+N/E0kd
	Gu5i/hBAcEd92ST66nYdeAcM1PbRQRjUsFatCRbwOj2FumA7jvJBBlfN1vbc7xmSMPwxWkfeosy
	fQLYFCTSXkaiyWQPJVrM7flw2uXnAW7hSYDHHfzT3koBrtE+q4HK7SQcVnQ4DPjnGlM+lgGug5F
	/4cNzt7Gkb/n3pA+q1Cq9aCppOhgNZAw3vVfuYITmF8YYJ3XHwAwjHlrcWpae3VWclCgVPDjUTl
	8u3zgODu9s+bRt+dRQb9IulUkN7Y+ceWm7KBy9/TGPQbEeTF11XRqXJA142v94v2gfdSSqFxTm/
	3J/ZVvm2GQeQD6+cBSw==
X-Google-Smtp-Source: AGHT+IE6k+fzD0eNBVN7y4HhpT7EAwkxwLSJMH/EmlHosqk9l8AlZQJro5cUEIEkhULN8N9kK0naaQ==
X-Received: by 2002:a17:903:41d0:b0:220:e362:9b1a with SMTP id d9443c01a7336-231d452dd76mr279392605ad.25.1747789111093;
        Tue, 20 May 2025 17:58:31 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed2ac7sm82687045ad.225.2025.05.20.17.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 17:58:30 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Tue, 20 May 2025 17:58:27 -0700
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, martin.lau@linux.dev,
	ast@kernel.org, andrii@kernel.org, alexis.lothore@bootlin.com,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
	bpf@vger.kernel.org, dwarves@vger.kernel.org
Subject: Re: [RFC bpf-next 0/3] bpf: handle 0-sized structs properly
Message-ID: <aC0lM9/RhCTlZ3W5@kodidev-ubuntu>
References: <20250508132237.1817317-1-alan.maguire@oracle.com>
 <CAEf4BzZfFixwy4vQG8jrUBtAOUFx=t1KG2F+AtKPVNCsMz0vQw@mail.gmail.com>
 <8faae89d-3515-480c-9abe-4d0e7514e41b@oracle.com>
 <9a41b21f-c0ae-4298-bf95-09d0cdc3f3ab@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a41b21f-c0ae-4298-bf95-09d0cdc3f3ab@oracle.com>

On Tue, May 20, 2025 at 09:59:27AM +0100, Alan Maguire wrote:
[...]
> 
> I discussed this with Jose, and the gcc behaviour with zero-sized
> structs varies a bit between architectures. Given that complexity, my
> inclination would be to class functions with 0-sized struct parameters
> as having inconsistent representations. They can then be tackled by
> adding location info on a per-site basis later as part of the
> inline-related work. For now we would just not emit BTF for them, since
> without that site-specific analysis we can't be sure from function
> signature alone where parameters are stored. In practice this means
> leaving one function out of kernel BTF.
> 
> So long story short, I think it might make sense to withdraw this series
> for now and see if we can tweak Tony's patch to class functions with
> 0-sized parameters as inconsistent as the v1 version did, meaning they
> don't get a BTF representation. Thanks!
> 
> Alan
> 
[...]

Agreed that sounds reasonable, and I'd like to resolve the original
problem on 32-bit, so will update my patch and resend.

Thanks,
Tony

