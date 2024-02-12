Return-Path: <bpf+bounces-21756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9251D851D6E
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 19:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1AC285D00
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 18:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AD245018;
	Mon, 12 Feb 2024 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2zdJX5x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ABE45BEF
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764307; cv=none; b=D7ZWmqJ7O5WPAx5RdCcUsmhjGsuukC8onkjOnCuK+u28Y+xBSkrei3rcy5ofQepc631+q0vlN0tEF+BYtm1VogwZgDHByEKQuICjJZhFpue73Bgh+t0B+wO2Iuz6Yl8hlpJARgWfwee5ndwIhNhd2lw1RvNo30qG/POlh0plWa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764307; c=relaxed/simple;
	bh=b11N2dAh3zhLceQ7Q2F6eJdwu0OAPn6LFibvxEzti3g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FsSsIDc+eX+KC0rhH//zQTTVuOphZDJ3KJazuwvXanNOrpGGgisKq3zwctT5rNT9gcelfF0N0K1+QBT9fHbU2oCkRhM3CZn82NsCAN5xWR01Yg6NLAY6F09tKlTLGZ6FCgJ1DKe0Ek+QwrrIwZnfMRIeZGAkvnwnioLsrcClRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2zdJX5x; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2a17f3217aso461287166b.2
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 10:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707764303; x=1708369103; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=koC4KPt/zdBeBgblMLz30Cr5x0S0YoG2RyqdQG6cS84=;
        b=Z2zdJX5xdzRXbVug4U11DhfqzPfzdIPhL0dH+I+eoKh9uMI4hCuItlI9S8tZglw2dO
         W47Ru52J/tYPPFvd0cPBYV49r309mpB/prJbofP89Qd7/nwaZ4xKVh7G59avC0l86+5i
         KgHFWLXXRIl6On0DfNlbzh5+qy2kLcq3RIMyqaFuaJH562MPxn1iADdZ7o74zEDapvQj
         9/DVbhdN+VLSdE07mEBOneWCKtRsV9yfbJFpTuecOjY/36K+wTiwd9PCkfEJ3Xn++yWY
         Fw3iDoncMI7NdES2iQS6rp0ULDemWyDP5Z8RUyQxJjm/hhGqCgD+g1TF+x7CjRM/wObP
         mOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764303; x=1708369103;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=koC4KPt/zdBeBgblMLz30Cr5x0S0YoG2RyqdQG6cS84=;
        b=FbbGrliUoz5tHxBZHDpCh2McelTV8rFszABmTm/yJQIPeEB8IXekMH5xoae1uI3mNh
         BO8Wjkq0Jm7ymKvnm7xo49Ct8O4oZAFbqypAS7MvloAHJQyNeequ6F6lbL2i7APEx/Me
         tJ+ca7SCxg5e3Xj46T+H5AO13iPgmMmKgzvyTbPLNFSiPMDtBpDN5WqxytYL5E4OvRpq
         lMdd3wvPGBb8enyw99Ito/9yPM7ocvyDTtvZcwqVR6DEFnnyw1/9S76kL9ZuNncuGm1s
         hicEK0CifynsqsSj1islQ8b5J8M/W7/LAOFvry3gXDp4ArxVlSzpiOYtTdEqNiM6e9FO
         tPbg==
X-Forwarded-Encrypted: i=1; AJvYcCUKQozGFlQTJQ+eEoD96hBULj+YzJevtD02Ie5BBJNZtukUQ7ITv4rJNJLsvCBzU0Sx70nEAZQHhMLDd2A/FxD0xdND
X-Gm-Message-State: AOJu0YzbE+1W4Pm0SdurfHjMfpAQ/O/Z3uY8v9s17q0hb/xmbinaEGjO
	T+BQqmdKxdVxsBFEsitTR/BEpK/6s4FOX8doSzDpw+qpw12oiJO3
X-Google-Smtp-Source: AGHT+IEatP1z98ZHMU7xhDzz9DTR4TebEOqNs6F8PGIi6JrY6NZQCJ0TccpTRrRolhYMVgQ1NzJN+g==
X-Received: by 2002:a17:906:5f83:b0:a3c:11a0:b4e8 with SMTP id a3-20020a1709065f8300b00a3c11a0b4e8mr4708486eju.24.1707764302510;
        Mon, 12 Feb 2024 10:58:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSeLYhXaVg/ZVIcX0rI25sa0+9pREzclYi5mqfMlNrRNppbNRyGzgLD0eMXs5P+uhpZIWMk2IiK5xRXGalBWIdqWzmZeuu2xoWV4yUe/FUCvtL8SQ+19jLnxczXgKUC7TETyb19H0weHHoTq2Y04lmn8pcbf5XQynVehPnhIkGCKu7b1UExdyWMmEHqNwGC43Jyj7HWVzWLc9y9RttwL/7wppWnPBtREt8hF99ACA9KFlcGg1pidBKSjfU/8++99+Apyg6DALBGAe7fzyyc3qjYTIksZrwyJuAMGrGYX/79gvFjP5Y7AJr+h5tgCruurlvN0e0GtvoxyvZ70oocpenh72XZqFzqaWhFl3b1N28KAV+V2JYipHF
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b10-20020a170906194a00b00a3c8ad35920sm468774eje.158.2024.02.12.10.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:58:22 -0800 (PST)
Message-ID: <5ca7ab230317267f78df2dab399716979f1d4856.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 13/20] libbpf: Allow specifying 64-bit
 integers in map BTF.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 tj@kernel.org,  brho@google.com, hannes@cmpxchg.org, lstoakes@gmail.com,
 akpm@linux-foundation.org,  urezki@gmail.com, hch@infradead.org,
 linux-mm@kvack.org, kernel-team@fb.com
Date: Mon, 12 Feb 2024 20:58:20 +0200
In-Reply-To: <20240209040608.98927-14-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
	 <20240209040608.98927-14-alexei.starovoitov@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-08 at 20:06 -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> __uint() macro that is used to specify map attributes like:
>   __uint(type, BPF_MAP_TYPE_ARRAY);
>   __uint(map_flags, BPF_F_MMAPABLE);
> is limited to 32-bit, since BTF_KIND_ARRAY has u32 "number of elements" f=
ield.
>=20
> Introduce __ulong() macro that allows specifying values bigger than 32-bi=
t.
> In map definition "map_extra" is the only u64 field.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Another option would be something like:

    #define __ulong(name, val) int (*name)[val >> 32][(val << 32) >> 32]

thus avoiding generation of __unique_value_123 literals,
but these literals probably should not be an issue.


