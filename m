Return-Path: <bpf+bounces-51895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26398A3AF60
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 03:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66273AE938
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 02:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E1715A85E;
	Wed, 19 Feb 2025 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jq0Zmujt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0546E54918;
	Wed, 19 Feb 2025 02:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931188; cv=none; b=BxajgVBO+hoIcAQ9yx20mqxX6pbCO+ddnHAhxn0EVsXHv6XtItcuv88QaNCAag6iD/Dy2O23dm8cTGlVt4BxBOJAAribiEzsI/y7xuz0iDoyayLjuy/s37hpm5emVKu5Xg46Wg3alFsyIVv2Ya+EwfWZNyWEsDaw6LNmap/JjB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931188; c=relaxed/simple;
	bh=MXdL2r988f57IcnxnV5NB0njUX0aL9IvbAws6rU3xjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QY9IRhtZ7N+wrZkG/6Gk++x7UXHt3jr3rxx2Fglhi8SMp2aywQKI2vmRW/v4QJ+Pbowlvz8X4feJfOtD9zUmxbrjT5QK8EbklqAxsMk4Qg0ZFFjxO6LVJao3vuhOt9BKp8ydczGe1D4o75KCKezj+jEkt5KRsQ+5QHbxINwTrbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jq0Zmujt; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3cfc8772469so19836595ab.3;
        Tue, 18 Feb 2025 18:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739931186; x=1740535986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXdL2r988f57IcnxnV5NB0njUX0aL9IvbAws6rU3xjM=;
        b=Jq0ZmujtW8cH6GGMP+vJQlIsmL6j6Bx4egQYCE4xcScZzAzvcW7ign+c0USYaBa4Pm
         s94omOR/kQxCZ325PqkqwHx37RbjB2RtqAOeGeQPavxYfHMh1OWn+B77aQ0kFNzmEc+T
         2bBap+4wIhWqzhqAAal+XV6oCK8Bqb7zCXj5H0kSgOh+SGPrJ9VyBvZ3v5WQzLAfQb/A
         8c5bLHhaQpiathGrTnt00svaBFUGcfZrS9l+B9UalOfQZYUD3ji90LR/84Ej/A/jNTJq
         BRQ8Nd8dTz000c4iac2lHt2CXwjqLsTvmoOimA/yhVSaenllgyDpkYodbY70eop33+RT
         LJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739931186; x=1740535986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXdL2r988f57IcnxnV5NB0njUX0aL9IvbAws6rU3xjM=;
        b=klgxJHOYCpHwiqkwUPlL28RmyQ8SISr8AlFql7srOOzhloLpmb67Jif+YXrfL+cmt4
         h/2rfVsx8K5lVgQWmIanlItxNVQDmXKgBLKnJXhty8cXwhYr/hZ7Gnk4skzjtES/NkCH
         tigdbA0OBLP0fiV+U9aj08DbXEWk7pB6MHwJSal6UOv+QtDCaZ4lUVFNJZVnuGE7fETy
         SfknqWxKykOvTToS/gmmU9vcm4HH3Dir4SUjotkARFCGKu3ZqD02jDWbKGPjwK6MAQUj
         tZevOlOBV3IKNZDDGG4mejpc+ahEZDhvDR6KVauWeyu+8AbEbFVST00bxK1QgyOZogmR
         pV2g==
X-Forwarded-Encrypted: i=1; AJvYcCVt6mb9BOwjogCULZH6yIqZS0Y4LdtGKlBoXrXNayZTjI+xiG72wjMGh6T2LoYsqTPL1ZIc+5Y8@vger.kernel.org, AJvYcCXKIv7qgO5MjBbQ3JmgviCJQnEMtsrtj3lvf+1feSBI6PaIYl5LRlZf5TZoOzA4e8+d3xE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+59wKxrVDpgkzmFOlwy85GfnP4hF8hMu0FfQln5I3vOlxOw7
	2ESc3GQK33rjELsrYTm6MbW72ckpS9sp/5k0HqF2ohsTLnGXg6JuySkY3p/Gbu8Qyaozv+JdAb9
	cVoVgV2/gRrCvgfMZ/TXENEtzzJQ=
X-Gm-Gg: ASbGncufck78XmxryJyFULAsqOWxspsBRxi84Lf2Gbrg5xHAvJ/kO0gF1dJ/yjJ0QX4
	B0Ohq2Ut0Kn/sJCXIRU0J+XVN+fY5nN/B9aNAfsKU+sKyxlDVlsLS14H6E1giovVf3POf+NjB
X-Google-Smtp-Source: AGHT+IEesxvTSZRnkrrfVG4JDLjqg9TlKJ/CF5hAEqsbjtZ4pL0JM0MU2u/WxAz4vIZxNsKp3Q/vGj2Qk2opJIT6pug=
X-Received: by 2002:a05:6e02:3312:b0:3d0:4700:db0b with SMTP id
 e9e14a558f8ab-3d2b52a1164mr20342275ab.2.1739931185934; Tue, 18 Feb 2025
 18:13:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217034245.11063-1-kerneljasonxing@gmail.com>
 <20250217034245.11063-2-kerneljasonxing@gmail.com> <4dc10429-29dd-47bb-bd5f-6a8654ed2fec@linux.dev>
 <20250218174754.150c82c3@kernel.org>
In-Reply-To: <20250218174754.150c82c3@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 19 Feb 2025 10:12:29 +0800
X-Gm-Features: AWEUYZlZ9YayU8cbNpXMrN3Ad4YipgYDXBsMUxAl-xJrFKdk66cORRrC_pkxgI4
Message-ID: <CAL+tcoAbVnJwTT_dvFFH+n3aWUG2DHf3Z+Uc8LhYo9fd31Zp+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] tcp: add TCP_RTO_MAX_MIN_SEC definition
To: Jakub Kicinski <kuba@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, dsahern@kernel.org, kuniyu@amazon.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 9:47=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 18 Feb 2025 15:38:17 -0800 Martin KaFai Lau wrote:
> > On 2/16/25 7:42 PM, Jason Xing wrote:
> > > Add minimum value definition as the lower bound of RTO MAX
> > > set by users. No functional changes here.
> >
> > If it is no-op, why it is needed? The commit message didn't explain it =
either.
> > I also cannot guess how patch 2 depends on patch 1.
>
> FWIW this patch also gave me pause when looking at v1.
> I don't think this define makes the code any easier to follow.

Okay, I will drop this in the next re-spin.

Thanks,
Jason

