Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964D41CB192
	for <lists+bpf@lfdr.de>; Fri,  8 May 2020 16:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEHOSj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 May 2020 10:18:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33827 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726770AbgEHOSi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 May 2020 10:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588947516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WzN8B9l0GIXcA1RCf7wrCs1a+NVlNB3Ld5XWiWg8vBU=;
        b=NxpgCdk2tS537XYCHNdPIn6SWbSmVtgCiKenBZNIIHGsVBPiBxGnyFqP0tpKp/tc/j/SX7
        WZO8GJegJRXuuBflGzExrn5o/UTK+mZo9jTKc654IO+fC+QkKh/fWoxsygGUjHuHnRs0FZ
        i/oNwnq6x72TCt4MXb+upjdcsa9WpVQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-naEAXHP2Oh6HtrqVsfOKeg-1; Fri, 08 May 2020 10:18:35 -0400
X-MC-Unique: naEAXHP2Oh6HtrqVsfOKeg-1
Received: by mail-lf1-f70.google.com with SMTP id t11so617071lfc.17
        for <bpf@vger.kernel.org>; Fri, 08 May 2020 07:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WzN8B9l0GIXcA1RCf7wrCs1a+NVlNB3Ld5XWiWg8vBU=;
        b=q5dU2t2SjTBjIg4bwL8OO6anPNn7+Anzsypmacn9RfflLnL+kiEo6t6tg30H59pujD
         yGRO8A0TCEA11a+FPMMOnJb1gqaftP55nPnfmiXa4Xx13XviKWfcfp7/f7ZBtSe85nbJ
         3Mq9X2zCjH48/igGmwf7YjN19wR0M5k/61OcWZTWEmpzepioyw3a99eSvpVZeAbIZQC3
         UwQxRkv0nhyosVnxpf4p8JFQy0uXYVkKak9wYq4RflpVrLQQGp0iTJZK1l8rHH5vt1s6
         HR+14RRtIaRCLKlfnrVJSmQwfpbgQZs6vYYC2Gdj9yPJup9cMjHRYIeBCqGXpB19hVRW
         P25g==
X-Gm-Message-State: AOAM532TxhddSZK8jZXk4TW9RXdZDyblgwjfWsLvSK19Io1hCQTHgoVy
        xqgQZB5lk8+QOuZi/s9V9lAfAymQ9sfHYJ6bamxuShe2/aYvLsLmmblzKAB+D7XlhYFscTMRgJg
        FwKT4M0FdBybn
X-Received: by 2002:a05:6512:3384:: with SMTP id h4mr2135080lfg.150.1588947513735;
        Fri, 08 May 2020 07:18:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKAz143CZzJe9cJqkPeS8sOSI+kjaCZ3yHviVaotQG8+aLR7wQpRvNietrDUaiKAd1G9Ygqg==
X-Received: by 2002:a05:6512:3384:: with SMTP id h4mr2135064lfg.150.1588947513505;
        Fri, 08 May 2020 07:18:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q30sm1296324lfd.32.2020.05.08.07.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 07:18:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B7EC918151A; Fri,  8 May 2020 16:18:31 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: XDP bpf_tail_call_redirect(): yea or nay?
In-Reply-To: <CAJ+HfNhXq=17650ztPcnTSP4ztj8K1zwbC-GojYkZviPBdOGxA@mail.gmail.com>
References: <CAJ+HfNidbgwtLinLQohwocUmoYyRcAG454ggGkCbseQPSA1cpw@mail.gmail.com> <877dxnkggf.fsf@toke.dk> <CAJ+HfNhvzZ4JKLRS5=esxCd7o39-OCuDSmdkxCuxR9Y6g5DC0A@mail.gmail.com> <871rnvkdhw.fsf@toke.dk> <5eb44eb03f8e1_22a22b23544285b87a@john-XPS-13-9370.notmuch> <CAJ+HfNhXq=17650ztPcnTSP4ztj8K1zwbC-GojYkZviPBdOGxA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 08 May 2020 16:18:31 +0200
Message-ID: <87blmyh5mw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> On Thu, 7 May 2020 at 20:08, John Fastabend <john.fastabend@gmail.com> wr=
ote:
>>
> []
>>
>> I'm wondering if we can teach the verifier to recognize tail calls,
>>
>> int xdp_prog1(struct xdp_md *ctx)
>> {
>>         return xdp_do_redirect(ctx, &xsks_map, 0);
>> }
>>
>> This would be useful for normal calls as well. I guess the question here
>> is would a tail call be sufficient for above case or do you need the
>> 'return XDP_PASS' at the end? If so maybe we could fold it into the
>> helper somehow.
>>
>
> No, that was just for handling the "failed call", bpf_tail_call() style.
>
>> I think it would also address Toke's concerns, no new action so
>> bpf developers can just develope like normal but "smart" developers
>> will try do calls as tail calls. Not sure it can be done without
>> driver changes though.
>>
>
> Take me though this. So, the new xdp_do_redirect() would return
> XDP_REDIRECT? If the call is a tail call, we can "consume" (perform
> the REDIRECT action) in the helper, set a "we're done/tail call
> performed" flag in bpf_redirect_info and the xdp_do_redirect() checks
> this flag and returns directly. If the call is *not* a tail call, the
> regular REDIRECT path is performed. Am I following that correctly? So
> we would be able to detect if the optimization has been performed, so
> the "consume" semantics can be done.

Yeah, that was my understanding. And what I meant with the 'new flag'
bit was that you could prototype this by just adding a new flag to
bpf_redirect_map() which would trigger this consume behaviour. That
would allow you to get performance numbers without waiting for the
verifier to learn about tail calls... :)

-Toke

