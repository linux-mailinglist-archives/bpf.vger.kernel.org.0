Return-Path: <bpf+bounces-74940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68678C68D69
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 11:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id CA11D2A7DE
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 10:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5A634A3A2;
	Tue, 18 Nov 2025 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d98x+MfP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDhKhUcf"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1896034E76A
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461259; cv=none; b=J/s5PA0uvtfJK3FTVFFvdon6b9bbbIw7IJzyffSkh5Gv5NMTZcuRF4eGoi3Nrpb8HgWc/zzc7gweQ5xMKPz+IY/oYGrTfHvcfUMXoeRQagD4JRZoQerTsm6A0Imngt9gJVXncC6ehEZ/Y/n3QMw+HHAKVYp+N9/FqCtdbI3o2os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461259; c=relaxed/simple;
	bh=QKHrTMU8AS2rDV5NflMgKvQqapBxTNGK+ptCn0J05jU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PCWTnd97KtzsjfG/T4vyRj/YZCTNjB+CuX3PJhk+OVOuS5qnx/v3f8HA80sT6Otwk7dX4/b6QFO5yf5C1/9axxF62r1DrT3wWITVAGljgpCkub43bsSH3UWkM/15JLMUh9+AlJVLajnK7PqQ3jpP0DR9u3lbiBdGSdiL9yV8OeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d98x+MfP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDhKhUcf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763461251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qqdb8OtTIWPqMLICOLkFlFxhk9j2szKMv7aCnVG8Juk=;
	b=d98x+MfPStY23dyEFBiBLNwAtDDH5kgGhpkwSOZbFfasZ1RrkR6puF7w14b0GaJWQUdAby
	MlLkYV7Q7psHD5xCfAmnJfefUj8qf1LigFky9Gz71gwp4pKtUqVTibJ+3caajRVlF229is
	xSUjkOm38qGCaG5IoMLoFn69nmqmkGs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-0KUSx-YBP_S2rARf55GeJA-1; Tue, 18 Nov 2025 05:20:50 -0500
X-MC-Unique: 0KUSx-YBP_S2rARf55GeJA-1
X-Mimecast-MFC-AGG-ID: 0KUSx-YBP_S2rARf55GeJA_1763461249
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6450e804cd9so208415a12.3
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 02:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763461249; x=1764066049; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qqdb8OtTIWPqMLICOLkFlFxhk9j2szKMv7aCnVG8Juk=;
        b=MDhKhUcfSMNQhXr5EW7cLe6FIXiYHeg9ntXyCankqnmKUbn4Hc/LT8W0J7m4RRb+p8
         DLbybrFOukGkWA44v0MK/JjUTTwAqwOwnvpQKr/gJDFUHPrRkmp+UPo+kgB8Hvq7Wgzq
         BENj9+iYZOPyhMFKfjoxoHpOtq4pgeY70u1LH1FQw5/zgbO/wZ6QvjaErixIgjIyEodW
         9CQ42RwbAj4zqrnyQNFOECwmkyjIwTIv9rzPDRuXFBBjmGJ2zAdtki2HXUzIgEpyWuvt
         kIqYmvRluMZY6X8oSpBz/285YDMjplkcqPUWSzeWVBye19A8tG6A7NJglOW9g68JyZzw
         1t+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763461249; x=1764066049;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qqdb8OtTIWPqMLICOLkFlFxhk9j2szKMv7aCnVG8Juk=;
        b=c9sYGGS/1uLh2k1CVBP/8Zvx/8b2EQkx5pQvNonZEeOikQuhV8ga7FipK6ZX63vePY
         ZbC96NOTgNAyYhO5XvkTpjE50qLbHHFLpLTuvRk5UpJsGbvB50Ga7cNPFh2V0PRxx89/
         tI1gKc4dsjsjQgVCCWs4xZ9D4VWgTPtsza+MFC+cjhau0uziEkdu+OA0gko6tJSqca/3
         StTLmV8uf+eYmfSAdC8KA2gQxowxVlWSVcB0/qCGSx/2zWXje4Cm6Hk1K4jnpxh96J+L
         Lyl2R7CIIhwcnivAUakl9nTqyYdnqLyo5ALLBF0JGSPApRw9OlgFVjU/n8Qiejn5zweA
         +TDw==
X-Forwarded-Encrypted: i=1; AJvYcCXcpooSUEdJu6ZfoafO2t0xhWBfxHUQCN7WiZt5fYQ+nl/1pbN7SGX0INKyKh8Uzg9239U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8K+1TVkV0Ga7ErbCMLsUTg4EfyBVw2fQ0+dqKsxc8R3TrrsSP
	4/VdnyoPWhQj5ixZ3MLA+LYIuoKa7VSZYvgBa8yFuatbUn1METTENUuKjvshEh3aFqM1P2MLxZp
	1QJ4h2ak0V2i79AsfGHsCW9tQaX9lSygv1ENv11mmBu01b0E6cKF+/w==
X-Gm-Gg: ASbGncts0ej3tzzsWKqPV3W06lY0rR5xcrO+uMLACChEeR6D5RRCZP/CofAE2B2NiBF
	zO4RtEfUD44GDneknjIZmG9isFZlgFIEeOzt3KJtSp+3PPxckZdv6SlecD+wISYtv+Na7idAns3
	cH+CcVIDp29I2+VbvlfuekEFbDFpMhgZRuOSZ9Nom5RQhguHKKErsaV6p679VGUxyZD915EtivR
	wIYx+CLYmTRUTt/veaVzK8bJDkH11lPvxQkXzTbW77CWJsZUAT26vApTzql1OZEfS+Nl8gg23x+
	Dg9iN7WZx4H+LuRaNCfNycKYnkvqD/z9cOpWDQRUqCJdmtaRXrpJmvU+FQoILC9IJy7HIgEHk5I
	KEkdxEUQcBYmWYLHh4gvo5m+hsg==
X-Received: by 2002:a05:6402:2813:b0:640:9eb3:3686 with SMTP id 4fb4d7f45d1cf-64350e8e398mr14659709a12.19.1763461249138;
        Tue, 18 Nov 2025 02:20:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMmLVmalw0Ch5oVUFByxi23ViTAeHA9jZ/CP/GaJCrMyZNeJXWNQJXBphzVUwZfa0E+XKE2w==
X-Received: by 2002:a05:6402:2813:b0:640:9eb3:3686 with SMTP id 4fb4d7f45d1cf-64350e8e398mr14659656a12.19.1763461248670;
        Tue, 18 Nov 2025 02:20:48 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4cbd18sm12247224a12.35.2025.11.18.02.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 02:20:47 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id ABC7F329BD0; Tue, 18 Nov 2025 11:20:46 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Byungchul Park
 <byungchul@sk.com>, "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, horms@kernel.org, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org,
 willy@infradead.org, brauner@kernel.org, kas@kernel.org,
 yuzhao@google.com, usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, asml.silence@gmail.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
 ap420073@gmail.com, dtatulea@nvidia.com
Subject: Re: [RFC mm v6] mm: introduce a new page type for page pool in page
 type
In-Reply-To: <ea294b1d-7698-4f67-abd5-a7b9b67db6bb@kernel.org>
References: <20251117052041.52143-1-byungchul@sk.com>
 <f25a95a4-5371-40bd-8cc8-d5f7ede9a6ac@kernel.org>
 <e470c73a-9867-4387-9a9a-a63cd3b2654f@kernel.org>
 <20251118010735.GA73807@system.software.com>
 <20251118011831.GA7184@system.software.com>
 <ea294b1d-7698-4f67-abd5-a7b9b67db6bb@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 18 Nov 2025 11:20:46 +0100
Message-ID: <874iqrod4x.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 18/11/2025 02.18, Byungchul Park wrote:
>> On Tue, Nov 18, 2025 at 10:07:35AM +0900, Byungchul Park wrote:
>>> On Mon, Nov 17, 2025 at 05:47:05PM +0100, David Hildenbrand (Red Hat) wrote:
>>>> On 17.11.25 17:02, Jesper Dangaard Brouer wrote:
>>>>>
>>>>> On 17/11/2025 06.20, Byungchul Park wrote:
>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>> index 600d9e981c23..01dd14123065 100644
>>>>>> --- a/mm/page_alloc.c
>>>>>> +++ b/mm/page_alloc.c
>>>>>> @@ -1041,7 +1041,6 @@ static inline bool page_expected_state(struct page *page,
>>>>>>     #ifdef CONFIG_MEMCG
>>>>>>                       page->memcg_data |
>>>>>>     #endif
>>>>>> -                    page_pool_page_is_pp(page) |
>>>>>>                       (page->flags.f & check_flags)))
>>>>>>               return false;
>>>>>>
>>>>>> @@ -1068,8 +1067,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
>>>>>>       if (unlikely(page->memcg_data))
>>>>>>               bad_reason = "page still charged to cgroup";
>>>>>>     #endif
>>>>>> -    if (unlikely(page_pool_page_is_pp(page)))
>>>>>> -            bad_reason = "page_pool leak";
>>>>>>       return bad_reason;
>>>>>>     }
>>>>>
>>>>> This code have helped us catch leaks in the past.
>>>>> When this happens the result is that the page is marked as a bad page.
>>>>>
>>>>>>
>>>>>> @@ -1378,9 +1375,12 @@ __always_inline bool free_pages_prepare(struct page *page,
>>>>>>               mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>>>>>>               folio->mapping = NULL;
>>>>>>       }
>>>>>> -    if (unlikely(page_has_type(page)))
>>>>>> +    if (unlikely(page_has_type(page))) {
>>>>>> +            /* networking expects to clear its page type before releasing */
>>>>>> +            WARN_ON_ONCE(PageNetpp(page));
>>>>>>               /* Reset the page_type (which overlays _mapcount) */
>>>>>>               page->page_type = UINT_MAX;
>>>>>> +    }
>>>>>>
>>>>>>       if (is_check_pages_enabled()) {
>>>>>>               if (free_page_is_bad(page))
>>>>>
>>>>> What happens to the page? ... when it gets marked with:
>>>>>      page->page_type = UINT_MAX
>>>>>
>>>>> Will it get freed and allowed to be used by others?
>>>>> - if so it can result in other hard-to-catch bugs
>>>>
>>>> Yes, just like most other use-after-free from any other subsystem in the
>>>> kernel :)
>>>>
>>>> The expectation is that such BUGs are found early during testing
>>>> (triggering a WARN) such that they can be fixed early.
>>>>
>>>> But we could also report a bad page here and just stop (return false).
>
> I agree, that we want to catch these bugs early by triggering a WARN.
> The bad_page() call also triggers dump_stack() and have a burst limiter,
> which I like.  We are running with CONFIG_DEBUG_VM=y in production (as
> the measured overhead was minimal) to monitor these kind of leaks.
>
> For the case with page_pool, we *could* recover more gracefully, by
> returning the page to the page_pool (page->pp) instance.  But I'm
> reluctant to taking this path, as that puts less pressure on fixing the
> leak as we "recovered", as this becomes are warning and not a bug.
> Opinions are welcomed, should we recover or do bad_page() ?

I think we should do bad_page() to get the bugs fixed :)

-Toke


