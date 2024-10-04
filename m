Return-Path: <bpf+bounces-41017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D989910C7
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 22:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94961F22A53
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFAF1ADFE5;
	Fri,  4 Oct 2024 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu2mWBIu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7971B3A;
	Fri,  4 Oct 2024 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728074721; cv=none; b=Fj80o258JJYHwF+Il3ZbuoBWc6pfN7p7UZXVU/5EajzSKFZfAGbOF5QJq9aE3G2DLL1ZVytnH0S/qDTZdKHCOniIveqwFUGgiumupVSZjWcAOuokzQIssOhxTwrwdv9xDbCLTWbZQq4qk4+dcpEzO1NWTcxM2i4X3cCB/g/daHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728074721; c=relaxed/simple;
	bh=RP2Xg8UoWXUN0E+YVPX7YGoe5R3fBKKdPkMXq69pP+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D53ApXL1+DKoWG3xwiAXHarSDVRjT46wANUoz6IfQ+Srl5gbHo7aMXeecaIQOHLZf5WiE6X6VGhPdqdrTQERq+H8zNbt5rhkAvx3Kar80juZENF22Zbcwl4CaixHy1+x19PmUsIj3ZZYyq4pm98fhYyXYsMzOHLZy1cufKDGniE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zu2mWBIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8B8C4CED2;
	Fri,  4 Oct 2024 20:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728074721;
	bh=RP2Xg8UoWXUN0E+YVPX7YGoe5R3fBKKdPkMXq69pP+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zu2mWBIu+lRwk9xiCLkJ0HYxo2ytZgG0GNOPpIytQoiXkjc5YoeQxlN2DhRZpWYll
	 VfYaKoZQ1ffY3dXvlkOHfnG2BPmJj3IcB0+iLrQWPgDnls/f7vKDab+jR05wFB6Dix
	 2MVJw0SnDTCGGM/5LoMLVG3tzuVLUNS5VzmjNZ0N6c7Yz1Mhy8HKZiIfiS1FdYrZa9
	 9t1Fe3qw1gjpibaqyNlCd/CgfVC9tYlBwnFuCd9Nb83sXIBK+ZqdBljtImXLgcwLBt
	 ZA7UGy9Yo7/tvMqaQknjOod4uuvkrj8ikDNqnypoc2EdzE6KvWijfROMxGJ3DJsKJO
	 vwLfcudZphGxA==
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-83493f2dda4so120782439f.1;
        Fri, 04 Oct 2024 13:45:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwSeJSVPpevWeroMitbDdJasGH43fbQ6+bOmBqoL+PBJvtF3XJGwjCnAcj0uP9X8WC5Ac=@vger.kernel.org, AJvYcCXkFtVPcMt6sn0p//Be2f9Qr9uwcKDDloT5ydpjO8YHpgShBptNDta4nA0vB4Bg7THyZ9M1vvtmJuwHPZCE@vger.kernel.org
X-Gm-Message-State: AOJu0YwFe26C+VLqOXrlonhfvolyoqz5EvqkzltTlEcKDgumN0gXRr75
	11Npe3hRf805259b/b1azUTLCDeVOE9hat2OqMAKl1Krl/fqrNYz7TK/DqBOQhnwF9EmyNoRkg+
	ncYrVq0rOrurDtri+onymTOW7Ehg=
X-Google-Smtp-Source: AGHT+IG8+sYCRR4l8bzYDC1gI0lACy7S7DaWTPR90QGXRixEwHfs+6FoxAIOen0q9V0ZwJpQ5X7LNhoDLpkl8vM01Y8=
X-Received: by 2002:a92:c54e:0:b0:3a1:f6ac:621e with SMTP id
 e9e14a558f8ab-3a375c64e2dmr30372105ab.7.1728074720452; Fri, 04 Oct 2024
 13:45:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002180956.1781008-1-namhyung@kernel.org> <20241002180956.1781008-2-namhyung@kernel.org>
In-Reply-To: <20241002180956.1781008-2-namhyung@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 4 Oct 2024 13:45:09 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5BKxZH2EA=fuQa_3man5_qcUt3euwtfwsqD4g36JngaA@mail.gmail.com>
Message-ID: <CAPhsuW5BKxZH2EA=fuQa_3man5_qcUt3euwtfwsqD4g36JngaA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: Add kmem_cache iterator
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 11:09=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
[...]
> +
> +static void *kmem_cache_iter_seq_start(struct seq_file *seq, loff_t *pos=
)
> +{
> +       loff_t cnt =3D 0;
> +       bool found =3D false;
> +       struct kmem_cache *s;
> +
> +       mutex_lock(&slab_mutex);
> +
> +       /*
> +        * Find an entry at the given position in the slab_caches list in=
stead
> +        * of keeping a reference (of the last visited entry, if any) out=
 of
> +        * slab_mutex. It might miss something if one is deleted in the m=
iddle
> +        * while it releases the lock.  But it should be rare and there's=
 not
> +        * much we can do about it.
> +        */
> +       list_for_each_entry(s, &slab_caches, list) {
> +               if (cnt =3D=3D *pos) {
> +                       /*
> +                        * Make sure this entry remains in the list by ge=
tting
> +                        * a new reference count.  Note that boot_cache e=
ntries
> +                        * have a negative refcount, so don't touch them.
> +                        */
> +                       if (s->refcount > 0)
> +                               s->refcount++;
> +                       found =3D true;
> +                       break;
> +               }
> +               cnt++;
> +       }
> +       mutex_unlock(&slab_mutex);
> +
> +       if (!found)
> +               return NULL;
> +
> +       ++*pos;

This should be

if (*pos =3D=3D 0)
    ++*pos;

> +       return s;
> +}
> +
> +static void kmem_cache_iter_seq_stop(struct seq_file *seq, void *v)
[...]

