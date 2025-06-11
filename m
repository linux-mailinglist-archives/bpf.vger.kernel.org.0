Return-Path: <bpf+bounces-60357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C055AD5D2F
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 19:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0119D3A9728
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 17:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630A5222574;
	Wed, 11 Jun 2025 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2PWERXt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEF2221FD6
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662464; cv=none; b=tOcBPSrNHO//5FvWzFw3lkFWn2mNYqF0aAYUhaJ0hw+9UgQUQ8/cysVMau/+gEhx8VHmLf2V4Csywz1gOfFJIzI0ViM75oWnNZJJvQ+ZM9WfhpaXp1Ygk6bK9bpBzqG42q+6W1DKTGwywccqCUKiaezixBqmh8+Otc+tsnQc9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662464; c=relaxed/simple;
	bh=HpuX6uXXDdRqKGkUplqApGYf7n4pQ4n1YKaQS/Bqm1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gk5cRXsXRTJ+yqGafMGwtO5LD6gDhPUxbooQ7h7PcdNx4d69L+uSex/wtuGCvpNgCquwTFoYNkpkLjKxml6K8ebbMbe78AEL7LtrLAsNC67LnsbpPGQNNm3U5WKTpio1eOXgX5wa/+qmlWKILzLll3OHKHDRwlN0QUaoW0t1oyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2PWERXt; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fafb6899c2so866926d6.0
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749662462; x=1750267262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpuX6uXXDdRqKGkUplqApGYf7n4pQ4n1YKaQS/Bqm1g=;
        b=I2PWERXtiQRvwc1ZQUSZXkeEc+3TXbe48hlG/e60wj/yOaDDXDParCnA++hl4AsFCL
         8z+1GBsolupvYMtcqf0hFLKyXh/4+jygO7WePXtLtP0Fsat2ibjEC80ZbcXUvE2NeeLs
         l3TAmkLKtn33o1Ybf/HEchFBtrmoueu+YDZhOSaJSamaEG5/09O4fELSBTrOXKiBLU+v
         9JvfoHQjx/dv7xJUgc2ljgHJ9GGiB0d9675SUnr1WJYhiOPRi3wL/Pc7/+pgpBFrWr70
         W53pYRYO35mzW6w2Xig4sm/CSkurctWF1cbBYAT17rfrzsrG49TwKNa4QiFL33vf5pPC
         JIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749662462; x=1750267262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpuX6uXXDdRqKGkUplqApGYf7n4pQ4n1YKaQS/Bqm1g=;
        b=eKr6qN3mdX9wyCBpc+sg3JrDKSQxrrGTwvY3eEKzZKkSmDeQDwg3KahEzj6Le9spWy
         /cU62vqxO/hRXBGqug0NKA3813JXol2T8rVspACWpyYVgemVRPbdjynEflqHQeO+SgVB
         S64rwITMYkFNJdsQQz4VI9+8HOeVRTu5YdY3WI/23+tN4uExKfUBgEY0eyHpsMtQ6+fb
         uFwXuXKG161kbSPZpGVAPOOU4R2hToboEKoVX/BQ9K/9QseWKrwEQV4s8Xq6zsG2s5ev
         TZDnUFLevDZeAuHFZLyUODX3oxkIdCK6V7aTBgeVNXwVX1AvWPKqjdbgeFno13pSwDje
         yMeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8njnKZ45sipsFgj+yWWR7u9pfPDTllXQh0OyCWJ1c491TGatqGluD85sQcB0f0CiJ16w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWLwEsnFrwCtiKKsR3ePYIgC/czMklqe9KabFMGn04XhPmKTLK
	T4y9SVy7pHFFumYmhHHnAUn+o7efqdTwOGOAj71kR8eXL7NOf857S+0fDg8pJDGYA1GmcFC4lzF
	gWVbVQt4Xn2RECdXXA+k/LLTJZWyJO4C+7zyc54RdIloiHZslGhS6ai7f
X-Gm-Gg: ASbGncvwgRdCLVhce9GyBdeM2yoSQBANuNsI/R7MglNtQ55GGle1QKiZDiWjv02pT6Q
	VLPn8blINYONcSx1MXxB6LgQsGPHSxkj+1y7HH8Jr23hpIOWHLtKfD6p8f4mBdiTec+f99pJC0r
	gwbBN3+1QUrvEltIPtB0KlwuYMZw0BZaAhroa/YGw4dZ8=
X-Google-Smtp-Source: AGHT+IEhBRuN7B6LTZSzKYkY+Fjb2lZgXyxJ8Yl907OIMJvAVPiU/JV/c+cD9SxUr3eRy1O+wSBc6HX0nM4di6nPfvk=
X-Received: by 2002:a05:6122:2088:b0:52f:a0c8:263d with SMTP id
 71dfb90a1353d-5312dc2164amr411708e0c.5.1749662449580; Wed, 11 Jun 2025
 10:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603203701.520541-1-blakejones@google.com> <aElbyWY-cIQNf4wp@krava>
In-Reply-To: <aElbyWY-cIQNf4wp@krava>
From: Blake Jones <blakejones@google.com>
Date: Wed, 11 Jun 2025 10:20:38 -0700
X-Gm-Features: AX0GCFs5Krou7gfrh8qKoaSovcVxAQ3oWFMVkI5FV16KOLRRiLHpznUaJBLq07s
Message-ID: <CAP_z_Cgo0mLn6+cObVSBu4dY2SZaDTO6HZ-0D=1uAhuoc+jQRQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] libbpf: add support for printing BTF character
 arrays as strings
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Wed, Jun 11, 2025 at 3:34=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
> could this be used in bpftool map dump? ;-) I checked, but it looks like
> bpftool map dump is using something else to dump data.. I admit I haven't
> spent much on time that

I actually started this work by looking at bpftool's dumper, and only
after a bit of time did I realize that there was a more general dumper
in libbpf. I suspect that part of why no one has updated bpftool to
use libbpf for this is that bpftool's dumper also has a "display in
JSON" mode which libbpf doesn't support. So yes, it could be done, but
it would take some work.

Blake

