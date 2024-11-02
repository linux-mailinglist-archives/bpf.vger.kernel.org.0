Return-Path: <bpf+bounces-43818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D52F9BA210
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 19:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0813D282071
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532371A7240;
	Sat,  2 Nov 2024 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7R67p7v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE4191
	for <bpf@vger.kernel.org>; Sat,  2 Nov 2024 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730572301; cv=none; b=fnNzZtMlmJuqQ+RqmL/9y6QeRQmki2ZZuHlIyNDRJNO79gJOQKi2t8UBCyCnjjyV2VkHvmiquNks4KaUBFKblcBYZn/EnG5saY3TFMz4vBxbIUDyL+XodAXpT3ph8hS9KRXcO2O23adJ6V7zPcDnq24bhZCjrAEXs8VYrXKcurk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730572301; c=relaxed/simple;
	bh=v1BnUIARJq8JhsNXWcYOGRfPXEpnnYaH1t6XJ0joFNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tN7H+Lv4bYK8ILEUH1jdqBB6vv6gijmrIz5DB6+Z5XerMwHMyM6wZi6Dya/1f3aXNfXf2t8tbF2lO2AUwSPPZHgOhRkmz1VQXYOK6RCL6y1L3DbZCvz1I1a4Me66fOLDkEGeNarLRvQuw/J6zIVVvJjbpYwSM0WOAUGG3MuwQ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7R67p7v; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so1953081f8f.3
        for <bpf@vger.kernel.org>; Sat, 02 Nov 2024 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730572298; x=1731177098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTOTHa+pUlbyHzeiKK5YtWokvph3lX6blqveUvFV68E=;
        b=F7R67p7vajsE3uzRWWnuwJ9iIwvyzCWIz6aPnHmvH5MMIqxuSp56TktD4VJUh2PCH6
         QKOmpeQJqO/pd08FHbofwGL+e4W5zc1bKHl9qCzzI8pAAU4O17pMA+5RtCnr4Sy/JssS
         6fEmS83liL0K7rPYosvrm6bBRN4ePLcdZpC5Z5f9HZreFTXcSbqFosiAFSmryXWbgtmK
         27Nl4jTI70VRLSsEFJwSjnWUcHOqkVZcHfRdOT+H8nj2WcAec7DqqKqaFXC7Kevo5Fyh
         nNGlUCJYPupB83zurHdtRFzMzbrptA/rDPge3/fvfjhmeM0GpONryGyrem53oCiRZiEc
         YUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730572298; x=1731177098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTOTHa+pUlbyHzeiKK5YtWokvph3lX6blqveUvFV68E=;
        b=fiFBvWbBxp/qHnRPw23AAi8K72JvORQDgGUJVVt9yqEtD4D1Qdvwn0ftyWw5WyDM/K
         Rm4KYdYCKsMCuk+cEsyMbjRcmXNZBE8jvOHC/zc8C4I5Hblgzw8yN6YPULgw8hhNov6Z
         UVmO3aJwcUGv5mtkC6uWSwRoIQr99uA4YtWsD8vwf9VXaSyfuh2capZ52+kqr9C5pmd0
         gRKTZIU8UWu7qgHu7aWsTDUNyL0T+XpuMQal1NbDsi+rb0+OTVFZwYiLBQL3eXZ8VErl
         +cleoZvIG9ldLqD04YaS7OuSuDoborBapFEjPPTQ6whKcxMdhQdPcGyqMjrK0ezMKBbG
         Gk4w==
X-Gm-Message-State: AOJu0Yx63uBTkQd0GkPD57l3OgtbqP/08VwcYQK2Fj780t4UJVp5SD3g
	vO8a1/HBBh4KmYiz4m7CcFGBbala1afiofMZuxPaF6VJjANArJ707cKdTN/xVQlRTQt3A1yY+jG
	2XEpgbMn6QsUKAsvGRW+jYiFsSDk=
X-Google-Smtp-Source: AGHT+IGh6VuVh3AmbqisSw0MX/gE3oc0zgE6yPsIYlkYMMj64f71oW2l2wY3L9rwUGpYzMpKATwGhM0dzZFp7G3dJGs=
X-Received: by 2002:a5d:64e7:0:b0:37d:49cc:cadc with SMTP id
 ffacd0b85a97d-381be7c20ebmr8427894f8f.32.1730572298153; Sat, 02 Nov 2024
 11:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091501.8302-1-houtao@huaweicloud.com> <20241008091501.8302-13-houtao@huaweicloud.com>
 <CAADnVQKSYzEVA2fPLOhZs6Bdz492wmVU9DAp4q0qLdTHYAhEEQ@mail.gmail.com> <c6d60075-ee0e-f875-c098-ffe9ff7e8d6b@huaweicloud.com>
In-Reply-To: <c6d60075-ee0e-f875-c098-ffe9ff7e8d6b@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 2 Nov 2024 11:31:27 -0700
Message-ID: <CAADnVQK3Cu1oai43N5f=GiAWONahmLnZo4Ar82cPoBqQuAPX=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 12/16] bpf: Support basic operations for dynptr
 key in hash map
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>, 
	Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 3:02=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> >> a) lookup
> >> max_entries =3D 8K
> >>
> >> before:
> >> 0:hash_lookup 72347325 lookups per sec
> >>
> >> after:
> >> 0:hash_lookup 64758890 lookups per sec
> > is surprising.
> >
> > Two conditional branches contribute to 12% performance loss?
> > Something fishy.
> > Try unlikely() to hopefully recover most of it.
> > After analyzing 'perf report/annotate', of course.
>
> Using unlikely/likely doesn't help much. It seems the big performance
> gap is due to the inline of lookup_nulls_elem_raw() in
> __htab_map_lookup_elem(). Still don't know the reason why
> lookup_nulls_elem_raw() is not inlined after the change. After marking
> the lookup_nulls_elem_raw() function as inline, the performance gap is
> within ~2% for htab map lookup.  For htab_map_update/delete_elem(),  the
> reason and the result is similar. Should I mark these two functions
> (lookup_nulls_elem_raw and lookup_elem_raw) as inline in the next
> revision, or should I leave it as is and try to fix the degradation in
> another patch set ?

from 12% to 2% by adding 'inline' to lookup_[nulls_]elem_raw() ?
Certainly do it in the patch set.

