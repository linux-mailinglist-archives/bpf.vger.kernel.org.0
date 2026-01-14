Return-Path: <bpf+bounces-78893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2ADD1ECB1
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 13:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94DE23043529
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 12:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E743A346AC2;
	Wed, 14 Jan 2026 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7PbcuUz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSpaNHzN"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D3C395DBE
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394045; cv=none; b=u3uocpScp3anon+Xn6DQwLslhowTX6/e5GCOvn1vCWs9UNyZCcHJJcCTogxC7fFsr0sggi346xRZT/frxvpOyjf89CtTwknG2af7HjyZGK/aZVoVD+FiWMGfQfzR3W5n3c1QP//5eVcqazUlbMoftCIo99b1qiuftMrj90h6llE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394045; c=relaxed/simple;
	bh=bd6vtXKrmS6WjvXJ/4SZe+JXxr4BUxm9h6I4D8SJur8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eKdPyE3X5sKMQSoWZ5y+1EC07cLw664UFx9ACrZKIAnTNDIg9YmN/EzABVdRvYwJIs7kB+f6mNAEInK0HQ8YKrC5Rw5VS8CJjgYO6CTYIzfVBrM83MSUh/noWh4fHEnf/W9vCAQTOLi8IuuSvShMFB816taPdAAxmckdW+UFbYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7PbcuUz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSpaNHzN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768394042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bd6vtXKrmS6WjvXJ/4SZe+JXxr4BUxm9h6I4D8SJur8=;
	b=U7PbcuUz3nqoMMVPIeurVdmIzLkl7xTqjNKSXqpYWiM1xHBNXr4tVKor/rfgvssSSE58yz
	nIIvzJfd/SPwsjoYKmkIXtYWV01zypQpIaf5XUVg1Q4SqsDgVltrDqdttlgMJHhK+iwqAA
	PoeCp9HjnkPyoFh1mHBYZB6d0F92ZC0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-e6_R-Q0rPo2eAueaTbmQJw-1; Wed, 14 Jan 2026 07:34:01 -0500
X-MC-Unique: e6_R-Q0rPo2eAueaTbmQJw-1
X-Mimecast-MFC-AGG-ID: e6_R-Q0rPo2eAueaTbmQJw_1768394040
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-64d1a0f7206so8979390a12.0
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 04:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768394040; x=1768998840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bd6vtXKrmS6WjvXJ/4SZe+JXxr4BUxm9h6I4D8SJur8=;
        b=DSpaNHzNpQceUo5GheE+FhqYVER3m7XNQqPyIoXD4vGDnaNxqb9fV4eEFK4bJGUujt
         shBYvBrNR12f+Ekw2bxvaCxyIbvGZxY3TG6yTQyyJs2sIOVkGOZRVPzvwx6QXzxq1eqG
         gNeIUJzWv3Rtnj6VJhd9fK8wZa2/puMZfWOL0TMMdPaIZe/9xvi01yL/mCYKapOqdSso
         mX5jnnVM3aSdOF5lWTIMhxsS8BsPk4hoOkvXMhSLlhJU/pkoZqVBrhBzxzLnLY5/69Nr
         Gme7VKqwxeVNWE/Jb6qV0fd7yQdLehUrg3AAUL0h/YP+57H4uo+0nSPeodXQzkxnMH/x
         dLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768394040; x=1768998840;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bd6vtXKrmS6WjvXJ/4SZe+JXxr4BUxm9h6I4D8SJur8=;
        b=lNKnhQ+QFoqtrN2VZJ/hm5PfAylq2zqPPKc1Z9XaS07P9qC4cuy7L5FGlELBaxWqrF
         Eq1KUePOgvnWFLO0Y7uRz9quGkp3NygFQVLSd8HciOVCFb7xdprauRNFXus7kdPyCagK
         JlYUhhLx9WlIlIBAUIYVL5Z6XvKPaHoRzV3OxNN/3sTe/2n9b0bG0CfVXeBOLkg+yR5B
         YQfCr8AU3M7jWBrdEduO/4HFtsjc3rpaNujPLYEEfA3BBRDI9z61AoBS/goS0O7O/6od
         uwD0UWXpx0Esooh3iH8pDMoXLf+aQe6T6xqDXVUDHwW+WeMqErk1eYgcIJOkwslVfgt+
         VHlQ==
X-Gm-Message-State: AOJu0Ywj3cWq4uGAep6bkFSM9LdpXvlDEA1O1+vq/EvV25UYXVQh33sT
	vB6XG40MjvqjBClbT3r0ffrqy60L1pKgcxMjwxJzQVmzPNyMkrfAZKeUxTR4DwENR5/aKl0vJc1
	JJ4DtX8RXD1a7l+g25ZdJjGoXh7UbQOpEnuZgQlry0m0MyNpfdPgKlQ==
X-Gm-Gg: AY/fxX7LygxB0T4ygZh7usOpPs4RhVTnNxEA8okLjVURZ3Yc89DVCAxO6ZnWxrRPHaS
	qf70eLAnEi0NQtaOyAEbMr/wfIN12OAa5eanE/RJMmy+AMrUhiWQwJqMnttGHJFjOvrdE+iHFVr
	j2Wdj9mE0PHWHJbveN+6VpwEnCaRSrME0mp2dTlQe2CQwu5lKKwNCLl8n3GesXK/BVSmhpRI0BV
	0wGetaRIqWwkJ+hmnfN01NX1/pvyyRCriir7SBAG0IMXUBfCac/M0xKU2ed96EmFOrWEJNCDqhI
	ngadXzhnyPwO7a9j/rPmdA4RZVUNEPC1ym6xBrel/hX1Hhcxd0aVaW8GUfZzae1TLKfzemi8Es5
	AzOlQPNQt1KQ/vlnQUWqwui5DyjnDWqNDqg==
X-Received: by 2002:a05:6402:1d51:b0:653:7bdc:9561 with SMTP id 4fb4d7f45d1cf-653ee1692eemr1683452a12.15.1768394039747;
        Wed, 14 Jan 2026 04:33:59 -0800 (PST)
X-Received: by 2002:a05:6402:1d51:b0:653:7bdc:9561 with SMTP id 4fb4d7f45d1cf-653ee1692eemr1683429a12.15.1768394039373;
        Wed, 14 Jan 2026 04:33:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d51c5sm22896574a12.14.2026.01.14.04.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 04:33:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 647BA408B93; Wed, 14 Jan 2026 13:33:56 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, netdev@vger.kernel.org, Jesper Dangaard Brouer
 <hawk@kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [bpf-next,v3] bpf: cpumap: report queue_index to xdp_rxq_info
In-Reply-To: <CAGF5Uf7FiD_RQoFx9qLeOaCMH8QC0-n=ozg631g_5QVRHLZ27Q@mail.gmail.com>
References: <20260114060430.1287640-1-saiaunghlyanhtet2003@gmail.com>
 <87h5so1n49.fsf@toke.dk>
 <CAGF5Uf48mRAuUZpTAGCGQtveDoDpF_1SKXFoBECqYzU4+dVwwg@mail.gmail.com>
 <87bjiw1l0v.fsf@toke.dk>
 <CAGF5Uf7FiD_RQoFx9qLeOaCMH8QC0-n=ozg631g_5QVRHLZ27Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Jan 2026 13:33:56 +0100
Message-ID: <87zf6gz83v.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com> writes:

> On Wed, Jan 14, 2026 at 8:39=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>
>> Yeah, this has been discussed as well :)
>>
>> See:
>> https://netdevconf.info/0x19/sessions/talk/traits-rich-packet-metadata.h=
tml
>>
>> Which has since evolved a bit to these series:
>>
>> https://lore.kernel.org/r/20260105-skb-meta-safeproof-netdevs-rx-only-v2=
-0-a21e679b5afa@cloudflare.com
>>
>> https://lore.kernel.org/r/20260110-skb-meta-fixup-skb_metadata_set-calls=
-v1-0-1047878ed1b0@cloudflare.com
>>
>> (Also, please don't top-post on the mailing lists)
>>
>> -Toke
>>
>
> Thanks for the pointers. It is really great to see this series. One
> question: Would adding queue_index to the packet traits KV store be
> a useful follow-up once the core infrastructure lands?

Possibly? Depends on where things land, I suppose. I'd advise following
the discussion on the list until it does :)

-Toke


