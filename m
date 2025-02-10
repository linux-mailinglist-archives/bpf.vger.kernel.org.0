Return-Path: <bpf+bounces-50987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6C7A2F029
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 15:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AB53A78DA
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 14:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E031F8BC8;
	Mon, 10 Feb 2025 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gCsrhQL8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB001F8BBD
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198870; cv=none; b=jyrZchfFKUP0QvMqUVbJpMwupVr/6kxCZT1gt0L1nz+fHuu9cjSRrL9cMRnqdV6LIXmELCYEtyJocy3vr0XiaxH0WgZmiCaDq5pGS6rIJ7dQ+WwZuBzPvTyj6NPOvYqqOxSqBukaf47fqos3vGL3mBUoYx69MH/maaCFdux0HIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198870; c=relaxed/simple;
	bh=FSpTQe3b8o6+Jav6J98B+jgoo4xBuSUgUI/RFXjz5AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/9+zcMsr+x+3rAeZu9RrApaP49F432vYIaKc6OOXRs7KaI5+pq6IXWHt7IFPlyrTLt7Uxk9cuqnp8itxAbopYUo4/hOoJCWyRQKOzK+hXc/4857TfI3G6PkOup1O0IhAdC8ZUp2F2x8ugEkACRVsh6T5b4TPsyAz1B1+Whs1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gCsrhQL8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38dd0dc2226so2291379f8f.2
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 06:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739198866; x=1739803666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbiQm+cpPA7ar4TiCqD5Kv0ylLMwSCONMu3++tRjFfo=;
        b=gCsrhQL8UiEczk7ztYqPbWnZf4r2vxuMxCNh137H2d7YMrDCF7aFT0Gwy8It2fKrOl
         UOM/kjTexKpbTFYtp+q4pv0XmrHCTLJoc082mkCVPfzTAQiR2JGpeqBKQUoHoH8zIFMI
         YPZBROrhGR29OLbwCNX7lnxBL/Vn6r0Aw9GJqTp0Dl6rLldp1le5G/nnsuDk0W1Dd5iM
         x4HKjntJHS6IuBkDhm8OGcKmP7uho5RQrXNBg7Gj0Es5mf3x50Evf1ZQuwnZdda8gas2
         yEcsdz44Xr7yELJ0tkvjksWrGtf0sUDA3EKlGuiHB9w65m2voyzvOcXj7Jj4V0G7q+SB
         TKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739198866; x=1739803666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbiQm+cpPA7ar4TiCqD5Kv0ylLMwSCONMu3++tRjFfo=;
        b=sjMTAkJ3jUI1tv7nui7fJRxa6YIp2ealeOWNHxminFdNbRmlgvCMKOSxL8730AVfgP
         tpDjiT+bFkRNRncZo6M1TnCJGcK+iSjQcNvsZfohxbPDRgGRmUPKL7sAGr4PrzlvujG4
         HPWFlBFajO+gv/SR0YnGEUKXf5EVNYkmsIN4ALbHAqcFy/uhKPJ284OJgVsaLOnR32Rs
         h1blbF75VWlgef75z0gJHpU2CRXdY/CskieGzgFRxmeOtd/J6v7DaIMKT8F6dvjCQQfW
         YztuFqE6xD3FxNrtjVvEQXayOhjWzp6KcJj8EOLmoBACSKI5oJNpuzcZELcDbFRUqenU
         s1Gw==
X-Forwarded-Encrypted: i=1; AJvYcCW52RWSUpmtBTvFYDz+e0euzM1pkOOYx86bvjLJT+nu0E80uqX/AqkQUWsJNKS1aiXWWa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxciJ/vJWInds1/KFgwcWVIwJVKQsILiUb7T8sHjNfmaSXVDTk9
	0+a2dZPHbALK0nocQIVJQ8njINnYbZnMRCp7auZPDYoUXkN2Mdp53qPwDQ4bbgNwAIgatqgrYV8
	qmYwfz1MELPyfty9DKnWAYbtSstO2G1tL+GDl
X-Gm-Gg: ASbGncsSg1zxhsvMJDHQMSYgDEjuxCnHQVCzD8B8MyJMtpqmFStG4uAVf66hgZsjdr4
	Vwf+TU+qDPRZKagxYhkpe3EGg3bT/YAZ4F6pgS6jTUg7/jJhEF9zqCWr7e/+/zO4BltB85xA4D1
	7FIhmqJJtn0ZDurNBdUOFZP5TIVw==
X-Google-Smtp-Source: AGHT+IG7ldY5/6LO+N9pj46753edUT2gqJvmRR+tJ8Khu38aqx9VLAlDJZDdXzi4iznKekfdWT52gtXGVIC+vKwwsMM=
X-Received: by 2002:a05:6000:1448:b0:38d:af2e:d5c3 with SMTP id
 ffacd0b85a97d-38dc8dd1864mr9957958f8f.17.1739198866457; Mon, 10 Feb 2025
 06:47:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739171594.git.yan@cloudflare.com> <85618439eea75930630685c467ccefeac0942e2b.1739171594.git.yan@cloudflare.com>
 <Z6nEsGSbWqCSaVp3@krava>
In-Reply-To: <Z6nEsGSbWqCSaVp3@krava>
From: Brian Vazquez <brianvv@google.com>
Date: Mon, 10 Feb 2025 09:47:31 -0500
X-Gm-Features: AWEUYZldNIPj7qeSesCp6JrxJzjY8eMHw9cqOTJjk2DHFgRetrTVHr8pLaFcEP4
Message-ID: <CAMzD94QZQjpwOA8Os3khG32d2zgH8i=Sy1VoudRCGqZudyHkag@mail.gmail.com>
Subject: Re: [PATCH v3 bpf 1/2] bpf: skip non exist keys in generic_map_lookup_batch
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Yan Zhai <yan@cloudflare.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com, 
	Hou Tao <houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 4:19=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sun, Feb 09, 2025 at 11:22:35PM -0800, Yan Zhai wrote:
> > The generic_map_lookup_batch currently returns EINTR if it fails with
> > ENOENT and retries several times on bpf_map_copy_value. The next batch
> > would start from the same location, presuming it's a transient issue.
> > This is incorrect if a map can actually have "holes", i.e.
> > "get_next_key" can return a key that does not point to a valid value. A=
t
> > least the array of maps type may contain such holes legitly. Right now
> > these holes show up, generic batch lookup cannot proceed any more. It
> > will always fail with EINTR errors.
> >
> > Rather, do not retry in generic_map_lookup_batch. If it finds a non
> > existing element, skip to the next key. This simple solution comes with
> > a price that transient errors may not be recovered, and the iteration
> > might cycle back to the first key under parallel deletion. For example,
>
> probably stupid question, but why not keep the retry logic and when
> it fails then instead of returning EINTR just jump to the next key
>
> jirka

+1, keeping the retry logic but moving to the next key on error sounds
like a sensible approach.


>
>
> > Hou Tao <houtao@huaweicloud.com> pointed out a following scenario:
> >
> > For LPM trie map:
> > (1) ->map_get_next_key(map, prev_key, key) returns a valid key
> >
> > (2) bpf_map_copy_value() return -ENOMENT
> > It means the key must be deleted concurrently.
> >
> > (3) goto next_key
> > It swaps the prev_key and key
> >
> > (4) ->map_get_next_key(map, prev_key, key) again
> > prev_key points to a non-existing key, for LPM trie it will treat just
> > like prev_key=3DNULL case, the returned key will be duplicated.
> >
> > With the retry logic, the iteration can continue to the key next to the
> > deleted one. But if we directly skip to the next key, the iteration loo=
p
> > would restart from the first key for the lpm_trie type.
> >
> > However, not all races may be recovered. For example, if current key is
> > deleted after instead of before bpf_map_copy_value, or if the prev_key
> > also gets deleted, then the loop will still restart from the first key
> > for lpm_tire anyway. For generic lookup it might be better to stay
> > simple, i.e. just skip to the next key. To guarantee that the output
> > keys are not duplicated, it is better to implement map type specific
> > batch operations, which can properly lock the trie and synchronize with
> > concurrent mutators.
> >
> > Fixes: cb4d03ab499d ("bpf: Add generic support for lookup batch op")
> > Closes: https://lore.kernel.org/bpf/Z6JXtA1M5jAZx8xD@debian.debian/
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > Acked-by: Hou Tao <houtao1@huawei.com>
> > ---
> > v2->v3: deleted a used macro
> > v1->v2: incorporate more useful information inside commit message.
> > ---
> >  kernel/bpf/syscall.c | 18 +++++-------------
> >  1 file changed, 5 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index c420edbfb7c8..e5f1c7fd0ba7 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -1968,8 +1968,6 @@ int generic_map_update_batch(struct bpf_map *map,=
 struct file *map_file,
> >       return err;
> >  }
> >
> > -#define MAP_LOOKUP_RETRIES 3
> > -
> >  int generic_map_lookup_batch(struct bpf_map *map,
> >                                   const union bpf_attr *attr,
> >                                   union bpf_attr __user *uattr)
> > @@ -1979,8 +1977,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
> >       void __user *values =3D u64_to_user_ptr(attr->batch.values);
> >       void __user *keys =3D u64_to_user_ptr(attr->batch.keys);
> >       void *buf, *buf_prevkey, *prev_key, *key, *value;
> > -     int err, retry =3D MAP_LOOKUP_RETRIES;
> >       u32 value_size, cp, max_count;
> > +     int err;
> >
> >       if (attr->batch.elem_flags & ~BPF_F_LOCK)
> >               return -EINVAL;
> > @@ -2026,14 +2024,8 @@ int generic_map_lookup_batch(struct bpf_map *map=
,
> >               err =3D bpf_map_copy_value(map, key, value,
> >                                        attr->batch.elem_flags);
> >
> > -             if (err =3D=3D -ENOENT) {
> > -                     if (retry) {
> > -                             retry--;
> > -                             continue;
> > -                     }
> > -                     err =3D -EINTR;
> > -                     break;
> > -             }
> > +             if (err =3D=3D -ENOENT)
> > +                     goto next_key;
> >
> >               if (err)
> >                       goto free_buf;
> > @@ -2048,12 +2040,12 @@ int generic_map_lookup_batch(struct bpf_map *ma=
p,
> >                       goto free_buf;
> >               }
> >
> > +             cp++;
> > +next_key:
> >               if (!prev_key)
> >                       prev_key =3D buf_prevkey;
> >
> >               swap(prev_key, key);
> > -             retry =3D MAP_LOOKUP_RETRIES;
> > -             cp++;
> >               cond_resched();
> >       }
> >
> > --
> > 2.39.5
> >
> >

