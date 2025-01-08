Return-Path: <bpf+bounces-48272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65597A063C6
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 164387A33E4
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 17:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B07201036;
	Wed,  8 Jan 2025 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDDRAQkR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82790201018;
	Wed,  8 Jan 2025 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358836; cv=none; b=O3wr2UvE/e2iGxAkSF402pOa+KGTY6hdUSn9VsUo7j3+nYuGxOODkLVkQOPHWLP42hI21OQ65YNUTGw3fuGKuzfJBlLUfMeHs6DA/FtLu/UDJ3WwmS+4zrfGtzMzeHpQKruVKfz8icDn7XRLe8hPK+Jf2f+j2ElsCfzV7t17ASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358836; c=relaxed/simple;
	bh=MQN5tIf/hhF16GdgxF2dKmOHPm8BqFNXSOJQBdYmG0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=toDvRJpmKfuQsPy02pmUixFWX4k3KsmKD7BR7xA+5piD9wycQyFAwFKciNaYyDWzRjNQmdypOYeSZ8YXR0Fikq/+vj0xY1JxfzVD120SznC4u6DtxNpD+q7f/p06goGsduYI4gxMKlXb6SXp1KsAKzuNVePx1uIoYZXjUoTg0Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDDRAQkR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so32142f8f.1;
        Wed, 08 Jan 2025 09:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736358833; x=1736963633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQN5tIf/hhF16GdgxF2dKmOHPm8BqFNXSOJQBdYmG0g=;
        b=CDDRAQkRzPjFcaO1mHjaU7Q9JFgMnF+WcRRE5YrRotWA5sYE6BcTxsis9rm0iet6/h
         nVKXSmiKmvJkylTIf3Ip7ogfjTYAnxT0DEKlmjw5umAnOBEjRBmCGxfkU1egicWvF5zn
         NwYXxk/6LJZfTGuR+T+d7bTm/0iGQoTvCVWHnYNq5xcQco1gkNOkRAjaZpkWHLq28gkr
         qiQ6ZXQNoyfA52qsujObX+Ksn/GwvItUqJ/vc5UeQwceqKfwXfstSOCz4LaHl/3XnFs2
         Ou1AaB3cvKqFz1GjAXQbxS6hYwZCmQWzi2G8r6LUtT5ga7y4mrifUA19xQlbI+uo1Li1
         6MZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736358833; x=1736963633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQN5tIf/hhF16GdgxF2dKmOHPm8BqFNXSOJQBdYmG0g=;
        b=ujkPk+MMwBmzU9rEjRohrhRRIbl+LXgDOA5QfE/LXf6NCJvNVx1vqA4vy9sFfg/IaG
         k0kmUGeTiziQcBzUV3VzX8uq7ugqbyZahtbxtTLEXK8b4gXo7uc4EY9lpeN/4M9Hh5Zr
         8Dtc5i+09KVsFB2blwpI+NkHdhzKh666OXCjYEhyxqiegMUcxRNiy+gma3efJUGUTvif
         Mot6QJkClXR/2YiJcAZMMk+nqEjFJJfgDDq1VKs2Iv3pfN1XZwgCw7o5LAKICawZLkfG
         tP8p9UdgAlnEpwCpXqafYoIV2/0H5qOslPbVmPEBNlBLagHYF+mm3Ke7Jx2tyNaLvr6X
         qsSw==
X-Forwarded-Encrypted: i=1; AJvYcCWhxfutmLN1+ogdissvLuKKVGHK4f9A9kjDtJmWDGDXp6HcwIcyVO/+9XGpuujHAkxZZfM=@vger.kernel.org, AJvYcCWke4y/sKmdwVO+GwaXx8FNr4XqJZfMH1+GiXW/t8p+eBKxRERlaBUUQ78UPsouxeoNK7V6TrcQdxUZD1mQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzOo4wREllaHfkfiC/o0p5/4cCZh+8IpZFOcsuKNme5ffDSKhey
	wGtripvh7RDb6RiakQW3mxz6YbFpFd5v6PWa9kBeZDAzHyMvHru7dMc54V5e1rQE5dLhAKulbxh
	NJZ57NAjvejthUrT0B1DEXKE8LPk=
X-Gm-Gg: ASbGncvFe9lPacqBkYMl4DKfzQDj+eXV5UfmyZ7LBUJ2wXx4SX5mjc9PU0s1x/DesGh
	Uvv1bgqNN9EteBm2llDONjAyGWLKUUTScSjEIBKL1
X-Google-Smtp-Source: AGHT+IHqAIaAsomhqiCc4HSaq8fbIu7/JT6U5vglDW4J7/6EcID5oByGudJ+BbeWZQ8ZApQNsKm7W949NXAB/9zMSuE=
X-Received: by 2002:a5d:588a:0:b0:386:3918:16cd with SMTP id
 ffacd0b85a97d-38a87357316mr3087855f8f.59.1736358832783; Wed, 08 Jan 2025
 09:53:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107090222.310778-1-yangfeng59949@163.com> <Z32ycDDCNTxavo7c@mini-arch>
In-Reply-To: <Z32ycDDCNTxavo7c@mini-arch>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Jan 2025 09:53:41 -0800
X-Gm-Features: AbW1kvZWR1sWfegubVjyfWQJnO9QO3o1EdvnUeU6Vqo5Rt4JNv5Vd2XJB4k-KsM
Message-ID: <CAADnVQLGhwzqkMiBSfsQWgz=BqWZRxXAL+MP_Q3hSzie_PQ+_Q@mail.gmail.com>
Subject: Re: [PATCH] bpf: Replace (arg_type & MEM_RDONLY) with type_is_rdonly_mem
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Feng Yang <yangfeng59949@163.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 3:02=E2=80=AFPM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> On 01/07, Feng Yang wrote:
> > From: Feng Yang <yangfeng@kylinos.cn>
> >
> > The existing 'type_is_rdonly_mem' function is more formal in linux sour=
ce
> >
> > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
>
> Looks ok, but I'm not sure this cleanup is worth it on its own..
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Yeah.
If we do this let's change type_is_rdonly_mem(u32 type)
to enum as well.

pw-bot: cr

