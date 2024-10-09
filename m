Return-Path: <bpf+bounces-41339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA097995DA2
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 04:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E10F1C2374B
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 02:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55FF5674D;
	Wed,  9 Oct 2024 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8CCPDO9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6FA15C3;
	Wed,  9 Oct 2024 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728439787; cv=none; b=RsG7B8vBr7Ka2j9imBM9FF3fLvJjxSJ4cGKu2G0sINeGUpVe3a460PtopofDj2XkYQCnsDQThpfU6ZuS2N1WvY7QjWqZAhDR2vGfxtEuHJiwFqKgdosezQsljtD+2rqTDGksHO1rWukMA0tDY/tWcslSx0uQHtnNCAjIuVKIdRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728439787; c=relaxed/simple;
	bh=hOluznz/YxpB8XIXcmgZeAKwBIrrS+tSR3kl+8nh03w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFKExwVsfLhh0tkohR8Ncpbbls+YsolfWUbCCkDBJInxCFRwt/1dnyV/xNOppDrCWRCw1c/7Z2yATXKe82QucJf7okLaw+uLj+VPaprycW08N7m/xfcMOw9L3e96b1k/ZCrbUfXWQsV/ssFBpXX/MJvYjvjasg2PcWZngIjK4do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8CCPDO9; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5c91a7141b8so828961a12.1;
        Tue, 08 Oct 2024 19:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728439784; x=1729044584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOluznz/YxpB8XIXcmgZeAKwBIrrS+tSR3kl+8nh03w=;
        b=D8CCPDO9+5kCjuEe2HpVzEz8dX3VU+ClveQayW4n4Ctl4ItTg7AWmkXrJ0FBXXsHA4
         gK1NDLJzu8aQ5SSv3XYMHBAnjB1DtmWMUJwEJ2aZ5xPehCsbKN46Z7fKYmTaxv2ww5Fc
         F+g2WpyZgBczcWitpoPu084XDZ6PVm3s0T0chUFAymzQ57VI0I42I8GJaYHKGRkxUCU0
         H5xKLuukeXjnibgLr+VaLDZ+TU9oCtmxg8/gsdfYyrotVX+R+UABKRm53/su6mfFOBXJ
         0vxUu3vLZsQ6XXJvLrsHgaZ+AZsxpIbcONPprWT/AilEratGPFBO/WJMkI7zwHEn3+/5
         eN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728439784; x=1729044584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOluznz/YxpB8XIXcmgZeAKwBIrrS+tSR3kl+8nh03w=;
        b=gC4hE53rd3+V4W7bs6qdvydeaklA7IvqPn5M+86yc63HdNulMgAczUEfFyOZwRAUOq
         BHxo5eFAZ06lZ8R0d/f1TlzKuWhTCRj4Kp7my+gaDmSAQZKmLYh6yzbHjEYbX/lzlqg+
         mvni5TMZi4cacAIngsMVeyhs5HMvieObqF4CciSsn7jQClerWu++CPsvA/C6XRCu74Cv
         KqNMs2Q/WXcJsaC7jQ6yKbAYjh75fh44sT/Gga1Y2pXYLLVzJOQoQvLucdjLdP705IfF
         VVBDA5OyoSW6hHv6a4AJwZP18dhUhGjqVbhsVBvjlg5Fm/vZoQtmLkPeiFfPzJqZmGPr
         moPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLQJzRTPN9RNq5jDoCgx2kahM9yymeaVMeLD4Ct0cR//1+B2ryBPl3Bswm1V2NY9rPeCw=@vger.kernel.org, AJvYcCXJffZgSvhSEzJYqH2ph817v+rdEk0fdnJBUvTtiF/3DU1LpfHVEsM3Vp7j/rY4BV/UHIX/sDIz@vger.kernel.org
X-Gm-Message-State: AOJu0YyRzeAzaG9RLQUR1ik9XnFEl6fatwPKg2yac5peyomfKV4jJK/q
	v/eIDfruC3UMg135V3ZETvJGWNGKfeZyrDopUPxIwbSDZxYncmqJi4Id8jLHOh4mWIPrxMFW72w
	FngHODY7AZb2updaP3V79Of6RknQ=
X-Google-Smtp-Source: AGHT+IF73H7adqSf5AUeHBO/xbfFrap9m4+kNBUKrcQxAhyURJSaB+vtXJI6hdUpN2Gh8ki2JPySEne+eDtCA5R7Tyk=
X-Received: by 2002:a05:6402:26d3:b0:5be:f3ae:b9ce with SMTP id
 4fb4d7f45d1cf-5c91d675a0cmr889735a12.27.1728439783648; Tue, 08 Oct 2024
 19:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-4-dfefd9aa4318@redhat.com>
In-Reply-To: <20241008-fix-kfunc-btf-caching-for-modules-v1-4-dfefd9aa4318@redhat.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 9 Oct 2024 04:09:07 +0200
Message-ID: <CAP01T75-bpEzwwdkkCA5eNcDRGyJ-wkpbYyhOH4+JMcyrKTzUw@mail.gmail.com>
Subject: Re: [PATCH bpf 4/4] selftests/bpf: Add test for kfunc module order
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Simon Sundberg <simon.sundberg@kau.se>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Oct 2024 at 12:35, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.=
com> wrote:
>
> From: Simon Sundberg <simon.sundberg@kau.se>
>
> Add a test case for kfuncs from multiple external modules, checking
> that the correct kfuncs are called regardless of which order they're
> called in. Specifically, check that calling the kfuncs in an order
> different from the one the modules' BTF are loaded in works.
>
> Signed-off-by: Simon Sundberg <simon.sundberg@kau.se>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

