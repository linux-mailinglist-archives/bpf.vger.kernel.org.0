Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D80F3A2761
	for <lists+bpf@lfdr.de>; Thu, 10 Jun 2021 10:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFJItF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Jun 2021 04:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229770AbhFJItC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Jun 2021 04:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623314822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9zSJ4Cz0GkyUckoB2hpt+KI040LkYH89elDBGT2GRlo=;
        b=Z83uzniscF4Sr8SnSNWV/LdPJq29gXp394V+sNIG/D1FojMmNysk1W59WrAvUiFvNzGg8Z
        gYuOCzlWgu31IA5EA6zGq7VX8FGQH+q3cjzV7DFw69p0UpTlmKOTLd+hcyXMnlghxLC68i
        NtYra574sPKFyiDxYbh2t8ohIem4Lms=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-svjSdRHCMcmy9FXoYvpBZw-1; Thu, 10 Jun 2021 04:47:03 -0400
X-MC-Unique: svjSdRHCMcmy9FXoYvpBZw-1
Received: by mail-ed1-f69.google.com with SMTP id c21-20020a0564021015b029038c3f08ce5aso13889423edu.18
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 01:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9zSJ4Cz0GkyUckoB2hpt+KI040LkYH89elDBGT2GRlo=;
        b=dOWzr9b8bqQNkkak9xkD7isOEFvd/0pH2sX+usqMLDBgE2gYjBLT5su7Hw52ssk7a8
         tJgP/e8J+dZ8LVWEre48M8CFmndLLkeLo3ZKzWHTCV/fpSrL/3ogDWRvR5cSb324ToM4
         6Y4uuIAiL/jk8dFk0U1uCiB8Ag9U9d3p0Gkom2/Kw9ZzJ+h28TxZa2EXxxymgRhgjHkc
         JDXUSWkPrT47BWYvQ+Ha46qH2gpOkg6YnC0ZlpzJw33zfdhODtzwCwzJiQ7WxzIouh3f
         +OuUTlEmFjby94X9cAg/9KtKnkxq3AxUNl7VX0poT2d1gFUrmiXC+tUh/ooPRWNy5cMT
         cPEg==
X-Gm-Message-State: AOAM531peodeeM6jKo3DINpecn8JOVesT131ETumAqry3Dlh5xrrTR37
        Iu/2TbBAb5aFtWcuPNWhcRbzSrcqcK2zInIGwzYWHlY0e7vVKkzPBGwPO5cYU9L5q9u5FeEObKh
        WBwLK1AASUuyu
X-Received: by 2002:aa7:db94:: with SMTP id u20mr3556178edt.381.1623314822164;
        Thu, 10 Jun 2021 01:47:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnnF4yowBK/HgD7Dfu8coBdUJY/ohwenLzxo3R+Sbyw8sVOVCUkVzrxltIVyfEShOjkCWqIw==
X-Received: by 2002:aa7:db94:: with SMTP id u20mr3556161edt.381.1623314821829;
        Thu, 10 Jun 2021 01:47:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v23sm1021156eds.25.2021.06.10.01.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 01:47:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 99B731802AC; Thu, 10 Jun 2021 10:47:00 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     paulmck@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH bpf-next 06/17] bnxt: remove rcu_read_lock() around XDP
 program invocation
In-Reply-To: <20210609135834.GC4397@paulmck-ThinkPad-P17-Gen-1>
References: <20210609103326.278782-1-toke@redhat.com>
 <20210609103326.278782-7-toke@redhat.com>
 <20210609135834.GC4397@paulmck-ThinkPad-P17-Gen-1>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 10 Jun 2021 10:47:00 +0200
Message-ID: <87eedam7i3.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Wed, Jun 09, 2021 at 12:33:15PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> The bnxt driver has rcu_read_lock()/rcu_read_unlock() pairs around XDP
>> program invocations. However, the actual lifetime of the objects referred
>> by the XDP program invocation is longer, all the way through to the call=
 to
>> xdp_do_flush(), making the scope of the rcu_read_lock() too small. This
>> turns out to be harmless because it all happens in a single NAPI poll
>> cycle (and thus under local_bh_disable()), but it makes the rcu_read_loc=
k()
>> misleading.
>>=20
>> Rather than extend the scope of the rcu_read_lock(), just get rid of it
>> entirely. With the addition of RCU annotations to the XDP_REDIRECT map
>> types that take bh execution into account, lockdep even understands this=
 to
>> be safe, so there's really no reason to keep it around.
>
> And same for the rest of these removals.  Someone might be very happy
> to have that comment at some later date, and that someone just might
> be you.  ;-)

Bah, why do you have to go and make sensible suggestions like that? ;)

Will wait for Martin's review and add this in a v2. BTW, is it OK to
include your patch in the series like this, or should I rather request
that your tree be merged into bpf-next?

-Toke

