Return-Path: <bpf+bounces-9850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F7979DD1E
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 02:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2271C20E3B
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 00:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A2637E;
	Wed, 13 Sep 2023 00:23:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690327F
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 00:23:57 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598031708
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 17:23:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9936b3d0286so814661266b.0
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 17:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694564635; x=1695169435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23bdJyZk9/WGBYa/EFxJu5CTfZEUx+BsIsREJJocTfs=;
        b=hZlKAPXqKyHTjq2K4oMq8MzYUNBPbPLh1eaqh+chC2YeJTfGvh4PfERS2oQ2POL/21
         3brzJJLJz4gjw69ynJjuH4W2NM4QOEywYcDvSYgHlPMjAJskmA8Cx/DjRjmcNaqtTvJV
         nzpudvvoHk4c2WdCFCJMzwnZ6z7EMFr9szgdeTYuJ3b7Kb/Wcb9Uk7AmDWHOafr3JtTC
         evSEy4ypvzFEx42R5DaAm7npY122m7m1na0ZE7cPkz7a613pDd7tGNjhqnGpQDIn4n8Z
         siNtiKzfszRhWVWQhOQWC5u7a5QO7uJxG4mC3vSrdAdnZjgSROwAVuuCL3Zx+jIzQCto
         09yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694564635; x=1695169435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23bdJyZk9/WGBYa/EFxJu5CTfZEUx+BsIsREJJocTfs=;
        b=bW0Zd0tFgemXhBRzZxJH0XEPBiuxHOoRTuIw8jkuYSbhlzRukXyYUDJMqfJqzA+CPh
         OYEAUaL2NNaJ75hmkNc7tA21uIwa5TWoTWYtTw601ZxlM9M0ufD3nZ90j+4FlF7AwSwe
         NsdeySF/Bi+/A7kyVmWOTH9qsYVml23xJjZbjRvWr3IDsoWXXeRJA35jbfB96N3mOgvW
         dRn9i6Bocpjv8K9Ow/yNI7lJ6/BLJ2dH9b3xQ6wl0It6fG/X6d+6BxaMluYELWi6ZyDW
         2M5KcQQuNllUOWUC5e8UXdTw+ogNcAifHOwQnVf6itWeowy3ygkzgQ46FjB4OcUsRKdz
         jdWA==
X-Gm-Message-State: AOJu0YysIWdSpgWWnMPcgPTUBzgNoHps32XrUzBnRkjJK+nQTihzpiT3
	J5CRMw1J0g8ox2GwEOLMIQshGBL+/YQraIfeHthuVDfZeWE=
X-Google-Smtp-Source: AGHT+IHxf6cZF2KLgIOXpbO+CWs3yWFD06s2ceGGmNNgDeTEqBuknwOKUN6GkxD+86h8WQ0d+3oZDQIsBU4xER37ipk=
X-Received: by 2002:a17:906:748c:b0:9a5:9038:b1e0 with SMTP id
 e12-20020a170906748c00b009a59038b1e0mr667212ejl.16.1694564634579; Tue, 12 Sep
 2023 17:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907234041.58388-1-martin.kelly@crowdstrike.com>
 <20230907234041.58388-2-martin.kelly@crowdstrike.com> <CAEf4BzZXVZ6LTX2KuXDo427kGwi4g1zGNfgEPrHfnJ4AmDq6Nw@mail.gmail.com>
 <e2be44c7-2ed8-9327-2618-5bc7539c89c0@crowdstrike.com>
In-Reply-To: <e2be44c7-2ed8-9327-2618-5bc7539c89c0@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Sep 2023 17:23:42 -0700
Message-ID: <CAEf4BzYdNhsFS+xBdhcCrY-m+SFwHOcJnk_AJETnOdiyDo+JxQ@mail.gmail.com>
Subject: Re: Re: [PATCH bpf-next 1/2] libbpf: add ring_buffer__query
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 9:51=E2=80=AFAM Martin Kelly
<martin.kelly@crowdstrike.com> wrote:
>
> On 9/8/23 17:25, Andrii Nakryiko wrote:
> > On Thu, Sep 7, 2023 at 4:42=E2=80=AFPM Martin Kelly
> > <martin.kelly@crowdstrike.com> wrote:
> >> +/* A userspace analogue to bpf_ringbuf_query for a particular ringbuf=
fer index
> >> + * managed by this ringbuffer manager. Flags has the same arguments a=
s
> >> + * bpf_ringbuf_query, and the index given is a 0-based index tracking=
 the order
> >> + * the ringbuffers were added via ring_buffer__add. Returns the data =
requested
> >> + * according to flags.
> >> + */
> >> +__u64 ring_buffer__query(struct ring_buffer *rb, unsigned int index, =
__u64 flags)
> > I can see how this might be useful, but I don't think this exact API
> > and approach will work well.
> >
> > First, I'd just add getters to get consumer and producer position and
> > producer. User-space code can easily derive available data from that
> > (and it's always racy and best effort to determine amount of data
> > enqueued in ringbuf, so having this as part of user-space API also
> > seems a bit off). RING_SIZE is something that user-space generally
> > should know already, or it can get it through a bpf_map__max_entries()
> > helper.
>
> I agree that getting available data is naturally racy, though there's no
> avoiding that. Since producer and consumer are both read atomically, and
> since producer >=3D consumer absent kernel bugs, I don't see this causing
> any harm though, as long as we document it in the API. Despite being
> technically racy, it's very useful to know the rough levels of the
> ringbuffers for monitoring things like "the ringbuffer is close to
> full", which usermode may want to take some action on (e.g. alerting or
> lowering log level to add backpressure). Sure, you could do it by having
> BPF populate the levels using bpf_ringbuf_query and a map, but if you're
> just polling on this from usermode, being able to check this directly is
> more efficient and leads to simpler code. For instance, if you do this
> from BPF and have many ringbuffers via a map-in-map type, you end up
> having to create two separate map-in-maps, which uses more memory and is
> yet another map for usermode to manage just to get this info.

Yes, I see the utility. You don't have to argue why this is useful.

>
> If you prefer to simply expose producer and consumer and not available
> data method though, that's ok with me. That said, it means code using
> this directly would break in the future if somehow the implementation
> changed; if we expose available data directly, we can change the
> implementation in that case and avoid the concern.

There is no way that implementation will change to the point where
there will be no producer/consumer position or their meaning will
differ. This is set in stone as far as kernel API is concerned, so I
wouldn't worry about that.


>
> I have no issue dropping RING_SIZE; I included it simply to mirror
> ringbuf_query, but if we're no longer mirroring it, then we don't need
> to keep it.
>
> > Second, this `unsigned int index` is not a good interface. There is
> > nothing in ring_buffer APIs that operates based on such an index.
> The index is the heart of the problem, and I expected there might be
> concerns about it. The issue is that right now, only struct ring_buffer
> is exposed to the user, but this struct actually contains many
> ringbuffers, with no API for referencing any particular ringbuffer.
>
> One thing we could do is expose struct ring * as an opaque type:
>
> struct ring *ring_buffer__get(struct ring_buffer *rb, unsigned int index)=
;
> __u32 ring_buffer__count(struct ring_buffer *rb);
>
> Then individual ringbuffers could have methods like:
>
> __u64 ring__get_avail_data(struct ring *r);
> __u64 ring__get_producer_pos(struct ring *r);
> __u64 ring__get_consumer_pos(struct ring *r);
>
> And usermode could do something like this:
>
> for (i =3D 0; i < ring_buffer__count(rb); i++) {
>      struct ring *r =3D ring_buffer__get(rb);
>      avail_data =3D ring__get_avail_data(r);
>      /* do some logic with avail_data */
> }
>
> Because struct ring_buffer currently contains many ringbuffers, I think
> we need to add an index, either directly in these methods or by exposing
> struct ring * as an opaque type.
>
> I appreciate your response; please let me know what you think.
>

I don't really have a better proposal (I tried). Let's go with
basically what you proposed, let's just follow libbpf naming
convention to not use "get" in getters. Something like this (notice
return types):

struct ring *ring_buffer__ring(struct ring_buffer *rb, int idx);

unsigned long ring__producer_pos(const struct ring *r);
unsigned long ring__consumer_pos(const struct ring *r);
/* document that this is racy estimate */
size_t ring__avail_data_size(const struct ring *r);
size_t ring__size(const struct ring *r);
int ring__map_fd(const struct ring *r);

so we have a more-or-less complete set of getters. We can probably
also later add consume() implementation (but not poll!).

Also, we'll need to decide whether returned struct ring * pointers are
invalidated on ring_buffer__add() or not. It probably would be less
error-prone if they were not, and it's easy to implement. Instead of
having `struct ring *rings` inside struct ring_buffer, we can have an
array of pointers and keep struct ring * pointers stable.

BTW, we should probably add producer/consumer pos for
user_ring_buffer, which is much more straightforward API-wise, because
it's always a single ringbuf, so no need to build extra abstractions.

