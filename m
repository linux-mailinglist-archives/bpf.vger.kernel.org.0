Return-Path: <bpf+bounces-73040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D28C20F25
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 16:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C362C18942FF
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 15:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E4E36448A;
	Thu, 30 Oct 2025 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jajQrP+V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26403363B98
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838090; cv=none; b=omujT5N9met7FYz7DAEER2am+es5R6WfPyaPTa/XBQVISPWIjNWMAprWuS6JNjUU6AKmOa/1fmKfm7t4MwIA6WHwCD1ywCBXTLmAEeyyzk20gLLZloDq/Xxpf50rT6Mt0/O9es8whzlvH8oPdcy2uMUbSLSNOo9ymp9IifvkmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838090; c=relaxed/simple;
	bh=ECIWqf/VCNCzPTY80OhIw37324pVyeiFSTePderg26o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6HGuEJJLC7Q04utqnegx2cWeIBIY2xNBi+gUR0Ip9GMsaHOZ8/eMaHQaZaKt3dUu18XqcRNj8qZGqz7XF2q0R+JKH3fqLJ4b6wrvxiFTk8cPaswGS1ar1Sl/tVN1N5i4GypsOmf9mnoJ4McPbFV0wvlfsiay7vIQLXlSCXoGhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jajQrP+V; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429bb95a238so338400f8f.0
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761838083; x=1762442883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17s53pVmMkcMZT8ne5HIpndSpVg+pfPjrs/QsaSS0o4=;
        b=jajQrP+VBI480GS5m/RuuYQKeZ5vJDPrMawcKU9fcPND4PyKMdZFpTQsiPbybHi7+j
         6gNmudQdrhl163NcYhTcboP+XDrArAKh51XUQwa34ZlUkjFON5wBSK2vFFSP9iwHz2f8
         d0VTBKyI3KAIgqUacn/NlEUTjkWlBSXpJiGgnk41cXkrilTrz4lQh+eL41iCXjX1/x8e
         PH1qhBSthocC9qeV/JQbiSQc6hAkLR3J3zLWEiQMXqU03kXwr4Z8vY+sQZdXCjuW0OC5
         08WQCs7tcU4sjgcQL6PZsalFCLwgAoneSwHxep22kSdkys0wjvpA3zBtmAOO4ybjlaXK
         elEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761838083; x=1762442883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17s53pVmMkcMZT8ne5HIpndSpVg+pfPjrs/QsaSS0o4=;
        b=NOZgOXHTPxcycbEGls+G2zznJW0bDTnEtRl5bp7Hz0vaeWmohWKJZx1SXAwnXpCltF
         CwlakjD1qlx9q+Ium8nS2nHV7jiJP972mka/2dqVPE3VTaJe8PHYZqaThbqZv2e3tOOa
         hBdFxijyQWxZxFkCI+ZOpaV+67QzYdm1XfEiEQS9XK4X723kAFQzAj7wZWi8uomv9uvr
         to0dJd9Tbvx0Z1p1l/g9B68gYQrxLjJPwUBvTrPx2XOi9DN7Ibred7jJIDNzLajO+BBF
         aHUYTyZQEC7nKbkU1jUPI5k7/phivitzoHNQo6NfEShMrYgjdrPt/KaR7ZazjD3fit3V
         ZKKA==
X-Forwarded-Encrypted: i=1; AJvYcCVg4K3OVjHN1V1w0fWvXo8J57ExmkMqelEFpYwaMyldZ/SAg3nFD47atxDJ2zZiAa+WIJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9R0CZswSP2KTmbIwBD/sCgCKZSVyS3DOK7vMgrEE1LzIf0vJn
	MKzOEQbqCLxdhL15+3YYTvok1POoCKxVxl8zUNPeVNp8ERxP+TtEgq0YHZXY24GSQz2ct+xUhgS
	GD7w4+wcU7nKVngNv7chZomkvcLlx3s8=
X-Gm-Gg: ASbGnctflF16HxIVOA+s+6rXk5iG225KQolOKVaQGYabBKlkqLVRs9EsSq2gZVqnEOh
	1ELzSSX/UUqiNbnAV83diJLfLYbboHf308nGZ54qCPg/+DsmuCghCqDehZHYOJrhhYfQmo9Jn+U
	a0T/1PV1uX4uX2KhsxUj4hcvKnKm+SznARshrYyynUsgGNBWjIlUyAq9XsxbWLJvlKNpsaVJ6Ne
	8Acr3QRsMaL1AI+mNEgiHz0LK9921nEkNaXwdkE1dTNksyCwJZYVx5AgjiFp1yarhYp5NObBZP0
X-Google-Smtp-Source: AGHT+IGXaWxPk/3M+cKYU/Pj7lpnExCAg79uXAbYfhqPsFtqXmL801omvA7wJAIBtF+VQCS8C9jbNQcSyBX5V1IM/6A=
X-Received: by 2002:a05:6000:2006:b0:427:847:9d59 with SMTP id
 ffacd0b85a97d-429b4c9ee68mr3815611f8f.45.1761838083095; Thu, 30 Oct 2025
 08:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-10-6ffa2c9941c0@suse.cz> <aQLqZjjq1SPD3Fml@hyeyoo>
 <06241684-e056-40bd-88cc-0eb2d9d062bd@suse.cz>
In-Reply-To: <06241684-e056-40bd-88cc-0eb2d9d062bd@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 30 Oct 2025 08:27:51 -0700
X-Gm-Features: AWmQ_bnX5zwf36gXg3U_L6nD0Y-OhNsAUiH1Wv4xcOqbTsg1lnruV_RapPX3X1o
Message-ID: <CAADnVQ+K-gWm6KKzKZ0vVwfT2H1UXSoaD=eA1aRUHpA5MCLAvA@mail.gmail.com>
Subject: Re: [PATCH RFC 10/19] slab: remove cpu (partial) slabs usage from
 allocation paths
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:09=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/30/25 05:32, Harry Yoo wrote:
> > On Thu, Oct 23, 2025 at 03:52:32PM +0200, Vlastimil Babka wrote:
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index e2b052657d11..bd67336e7c1f 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -4790,66 +4509,15 @@ static void *___slab_alloc(struct kmem_cache *=
s, gfp_t gfpflags, int node,
> >>
> >>      stat(s, ALLOC_SLAB);
> >>
> >> -    if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
> >> -            freelist =3D alloc_single_from_new_slab(s, slab, orig_siz=
e, gfpflags);
> >> -
> >> -            if (unlikely(!freelist))
> >> -                    goto new_objects;
> >> -
> >> -            if (s->flags & SLAB_STORE_USER)
> >> -                    set_track(s, freelist, TRACK_ALLOC, addr,
> >> -                              gfpflags & ~(__GFP_DIRECT_RECLAIM));
> >> -
> >> -            return freelist;
> >> -    }
> >> -
> >> -    /*
> >> -     * No other reference to the slab yet so we can
> >> -     * muck around with it freely without cmpxchg
> >> -     */
> >> -    freelist =3D slab->freelist;
> >> -    slab->freelist =3D NULL;
> >> -    slab->inuse =3D slab->objects;
> >> -    slab->frozen =3D 1;
> >> -
> >> -    inc_slabs_node(s, slab_nid(slab), slab->objects);
> >> +    freelist =3D alloc_single_from_new_slab(s, slab, orig_size, gfpfl=
ags);
> >>
> >> -    if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin)) {
> >> -            /*
> >> -             * For !pfmemalloc_match() case we don't load freelist so=
 that
> >> -             * we don't make further mismatched allocations easier.
> >> -             */
> >> -            deactivate_slab(s, slab, get_freepointer(s, freelist));
> >> -            return freelist;
> >> -    }
> >> +    if (unlikely(!freelist))
> >> +            goto new_objects;
> >
> > We may end up in an endless loop in !allow_spin case?
> > (e.g., kmalloc_nolock() is called in NMI context and n->list_lock is
> > held in the process context on the same CPU)
> >
> > Allocate a new slab, but somebody is holding n->list_lock, so trylock f=
ails,
> > free the slab, goto new_objects, and repeat.
>
> Ugh, yeah. However, AFAICS this possibility already exists prior to this
> patch, only it's limited to SLUB_TINY/kmem_cache_debug(s). But we should =
fix
> it in 6.18 then.
> How? Grab the single object and defer deactivation of the slab minus one
> object? Would work except for kmem_cache_debug(s) we open again a race fo=
r
> inconsistency check failure, and we have to undo the simple slab freeing =
fix
>  and handle the accounting issue differently again.
> Fail the allocation for the debug case to avoid the consistency check
> issues? Would it be acceptable for kmalloc_nolock() users?

You mean something like:
diff --git a/mm/slub.c b/mm/slub.c
index a8fcc7e6f25a..e9a8b75f31d7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4658,8 +4658,11 @@ static void *___slab_alloc(struct kmem_cache
*s, gfp_t gfpflags, int node,
        if (kmem_cache_debug(s)) {
                freelist =3D alloc_single_from_new_slab(s, slab,
orig_size, gfpflags);

-               if (unlikely(!freelist))
+               if (unlikely(!freelist)) {
+                       if (!allow_spin)
+                               return NULL;
                        goto new_objects;
+               }

or I misunderstood the issue?

