Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D31DC0AC
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 11:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbfJRJPu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 05:15:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27997 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391069AbfJRJPt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 05:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571390148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zC6z6XQtb9yBRJMgOJGn7q6B4OFlRqCojM1bXcE7Qz8=;
        b=CQocueYanINxqc18Rtv4saqZIyc48EvqlTuGVYCynqu2YTtkX3R7mq9QUT0ZvBCCIsYM0/
        a3rq8QemGGbtKoD0nwjsjaL5LDTv0jKstfOI62owa5abimRLiXO4qdHH9uMuyGUp0ukuOA
        LgrDOJS2FaYRnEBtHN2nL7jkLrQdtH8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-I8buHJo5PPecfmYiTAYeCQ-1; Fri, 18 Oct 2019 05:15:42 -0400
Received: by mail-lf1-f70.google.com with SMTP id w4so1138890lfl.17
        for <bpf@vger.kernel.org>; Fri, 18 Oct 2019 02:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=DeEGps92J0t9ydm/yww1A/6bTBC0ETCJqy+WADoE7Cw=;
        b=cACwXQH72VtCUjRk+q7xSuBkwhqmwZ5INLwYbaY8w6FWEUBP8jwbfsqu3KRpgxccdt
         P05eF3FTuPKC1zBYZWFuHNJHiYmSbhBDDmK/yzSWftn5/Nwzs1JcDwnJjfuRvW2vsXyZ
         xtgNNoq6oUkZJnMlgE/CRE4KsUfVVoBpVlqT3uiIl+STtHUp6pNf1g6WLb6s+makimP+
         Mx+91BkW5noRvDQY5AlqQPlmfb/kNu3gyut2Q0sAZ9VT7JiYMixDMBOF9lXIlsQScVyg
         ABLhsYvjNiNEFX5ZwITJh7R5x+YzKkgFVrJWTuaot6LAtTE+pXf7ag91tzgzpEwBsAAU
         xiig==
X-Gm-Message-State: APjAAAXnn7iDJQW0avNk5lIWpPQpAjJmPqR6YblLfZiyuN6POQc4pWzA
        X2Mh0IP+fI615nkeEW5O31rDFJTAcv8pi++aCChOXuabCmvwm4lyqKBr2axzwDhVQem+a9YXHe/
        La/wIQWdQrN7z
X-Received: by 2002:ac2:5305:: with SMTP id c5mr5497173lfh.136.1571390141457;
        Fri, 18 Oct 2019 02:15:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwACHjxpiUrh9TdBOXurZjZfpcu6b2bNfWNiEF/mPyrB52Gqf3Zzbb79SS+7RMSDCp2lXnl5w==
X-Received: by 2002:ac2:5305:: with SMTP id c5mr5497158lfh.136.1571390141197;
        Fri, 18 Oct 2019 02:15:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id f5sm2062432lfh.52.2019.10.18.02.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 02:15:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8398C1804C9; Fri, 18 Oct 2019 11:15:39 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     daniel@iogearbox.net, ast@fb.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH bpf] xdp: Prevent overflow in devmap_hash cost calculation for 32-bit builds
In-Reply-To: <20191017115236.17895561@cakuba.netronome.com>
References: <20191017105702.2807093-1-toke@redhat.com> <20191017115236.17895561@cakuba.netronome.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 18 Oct 2019 11:15:39 +0200
Message-ID: <87y2xie7no.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: I8buHJo5PPecfmYiTAYeCQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <jakub.kicinski@netronome.com> writes:

> On Thu, 17 Oct 2019 12:57:02 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
>> Tetsuo pointed out that without an explicit cast, the cost calculation f=
or
>> devmap_hash type maps could overflow on 32-bit builds. This adds the
>> missing cast.
>>=20
>> Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devic=
es by hashed index")
>> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  kernel/bpf/devmap.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
>> index a0a1153da5ae..e34fac6022eb 100644
>> --- a/kernel/bpf/devmap.c
>> +++ b/kernel/bpf/devmap.c
>> @@ -128,7 +128,7 @@ static int dev_map_init_map(struct bpf_dtab *dtab, u=
nion bpf_attr *attr)
>> =20
>>  =09=09if (!dtab->n_buckets) /* Overflow check */
>>  =09=09=09return -EINVAL;
>> -=09=09cost +=3D sizeof(struct hlist_head) * dtab->n_buckets;
>> +=09=09cost +=3D (u64) sizeof(struct hlist_head) * dtab->n_buckets;
>
> array_size()?

Well, array_size does this:

=09if (check_mul_overflow(a, b, &bytes))
=09=09return SIZE_MAX;

However, we don't to return SIZE_MAX on overflow, we want the
calculation itself to be done in 64 bits so it won't overflow... Or?

-Toke

