Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FA445ED57
	for <lists+bpf@lfdr.de>; Fri, 26 Nov 2021 13:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377263AbhKZMId (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 07:08:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376874AbhKZMGd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Nov 2021 07:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637928200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GVX98ikHeZ7eJCoOXrjvQJfNzLzuoPo0mWyUsTqXrE=;
        b=eTCIVqL9Vcs4xlVAO7ON78mspo//SNLNWlIVmcagUZWKWJzKATelniovwnsdntQvGhD2v0
        gsdDQTvNw0M0ve1otho3AdzaT/pRV7R2cxQQWhPBGkB72WzBRiWioH0vWu49Ipw/dlLpzW
        UnnQty0wNGA0KDixxQLRwsh+hmWxYDo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-iEClaDfiOqmfygC6AsFA7Q-1; Fri, 26 Nov 2021 07:03:19 -0500
X-MC-Unique: iEClaDfiOqmfygC6AsFA7Q-1
Received: by mail-ed1-f69.google.com with SMTP id bx28-20020a0564020b5c00b003e7c42443dbso7843993edb.15
        for <bpf@vger.kernel.org>; Fri, 26 Nov 2021 04:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+GVX98ikHeZ7eJCoOXrjvQJfNzLzuoPo0mWyUsTqXrE=;
        b=0uCaBrGM36vrHKRF5Y4CXn1NwRUIaELcniFyg0tjeR5Wnny2N4Ge1DZ8c09AsbQxVK
         QWeZvHanh+MuzsNobtgbmFiSUCm7J3q0LpAbdSM+CK39OzCda6KIyrfoiF06tJV5b6c3
         4ZN8U4p+Omm6P0v61H7OIHqrjoZI2ltyElwKY2RA3Y4hn1XWAyqMrNiS+9GetyxT1PiU
         prum3RmCjc2OMCr5XNp2/+ZED5OX0pk+DapJItu3Nfn+h0SmE9FpjD29NG5yfjXVwpX6
         Gwf8qL3y0WUIci/kxrLK41wvH/y7eXiKuKQS7bbdfyorav6WXRZ87gUJWsYsI7Wy067j
         iRfQ==
X-Gm-Message-State: AOAM530BwZadTlNOg0k46YQxsGMo+FRetNoDgxFb/gJjytL0jTUxiI8Y
        JdOI4vEItZGZO2JQPQgxwQwWIfEtLDz0lQONHfIyOdCCV/qAWdZWN+YLPU+6ihbDzn1X05qshFg
        csltcJGnZXMFX
X-Received: by 2002:aa7:c946:: with SMTP id h6mr47811428edt.190.1637928196860;
        Fri, 26 Nov 2021 04:03:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQA6Z+BWdbXXyqxo121uGQ8KKTBdbgLCQrPsB9Lo/Twf7z/WcPPdkcCsl+v1t+q1ZS/vGzvw==
X-Received: by 2002:aa7:c946:: with SMTP id h6mr47811353edt.190.1637928196355;
        Fri, 26 Nov 2021 04:03:16 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id hq9sm3068890ejc.119.2021.11.26.04.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 04:03:15 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1E4581802A0; Fri, 26 Nov 2021 13:03:15 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] bpf: let bpf_warn_invalid_xdp_action()
 report more info
In-Reply-To: <277a9483b38f9016bc78ce66707753681684fbd7.1637924200.git.pabeni@redhat.com>
References: <cover.1637924200.git.pabeni@redhat.com>
 <277a9483b38f9016bc78ce66707753681684fbd7.1637924200.git.pabeni@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 26 Nov 2021 13:03:15 +0100
Message-ID: <87wnkv9la4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Paolo Abeni <pabeni@redhat.com> writes:

> In non trivial scenarios, the action id alone is not sufficient
> to identify the program causing the warning. Before the previous
> patch, the generated stack-trace pointed out at least the
> involved device driver.
>
> Let's additionally include the program name and id, and the
> relevant device name.
>
> If the user needs additional infos, he can fetch them via a
> kernel probe, leveraging the arguments added here.
>
> v1 -> v2:
>  - do not include the device name for maps caller (Toke)
>
> rfc -> v1:
>  - do not print the attach type, print the program name
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

