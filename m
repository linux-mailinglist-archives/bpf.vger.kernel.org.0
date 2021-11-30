Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB88746335A
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 12:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhK3Lxy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Nov 2021 06:53:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51741 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231409AbhK3Lxx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Nov 2021 06:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638273033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYC3XnTEw007bEFYMyAJDS/BqhYWTSHCXS0Pa7RRXls=;
        b=BjO8W7Nxabfc6oWV+MDEt6iDZp5a4kjdiTu18Eu8EvFC4FlTNb7nNhJP/xuyZjqOa/mqlU
        ltdKLmxhxQHbSSnAQDi5wwNLeELX6P1NlvVBGgCN6CDgYhNrpIaOjTWVaZb0gFvYO5zCXJ
        XVqDkZlCQ7EwdUSJJo4/Uej2Ke3eGCY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-LwyUp5OpOuCXrv0QwinEUg-1; Tue, 30 Nov 2021 06:50:32 -0500
X-MC-Unique: LwyUp5OpOuCXrv0QwinEUg-1
Received: by mail-ed1-f71.google.com with SMTP id m12-20020a056402430c00b003e9f10bbb7dso16675046edc.18
        for <bpf@vger.kernel.org>; Tue, 30 Nov 2021 03:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QYC3XnTEw007bEFYMyAJDS/BqhYWTSHCXS0Pa7RRXls=;
        b=w9Tlo8NlorfTGU/qnowGknmePFbaMVfyOcyNFYl1Jq8KGmcStUVOgAVadJ5+3olXpz
         FtqiV8KMoYlequkTBuYe2mRviL+7OZL4WStYknoMONyk91ozFfECUj3OkDzHdyKODIEP
         rQgFFqD0ZliD86n46G0nMMdbk+P75jMXZNT0icunVG/B+lwOlb/FZKfLrkH9ctzQbu3q
         n1n5WANXYGvTMkTLjb3/wy6z+0Uwnma2EpQ0SU09NgHSlcnh/3350st5QkQ6Wx15Byze
         finwO9+zYB7HVCb8S7p/SZ1psD9r+U+h6i3eZmBT/QhTJuGClg97tf4RB2qJdV1fZz4u
         tBRA==
X-Gm-Message-State: AOAM530N2H8oioKQj6G3Lo+NdT2OGQ95Zu+a5Vd2ZnO6Kw0fvGKU1l2L
        7MrARC1G/W2dk3sDRNaiDbj0ZAZPM8NJi5pGGKuGwqTgNWRucm3WXK4h8pV5oGDxyX5Q1Cqz8DB
        To9UH/bAPtO5r
X-Received: by 2002:a05:6402:1a42:: with SMTP id bf2mr81541388edb.64.1638273031099;
        Tue, 30 Nov 2021 03:50:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxHEn/BPB80XStTpfeoFDZ6bBAF4TWAd6ni14rD7Mi0KlcY4OziyMXI9urRE05ocRNRqvp2HA==
X-Received: by 2002:a05:6402:1a42:: with SMTP id bf2mr81541370edb.64.1638273030783;
        Tue, 30 Nov 2021 03:50:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id c8sm10719395edu.60.2021.11.30.03.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:50:30 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B36EE1802A3; Tue, 30 Nov 2021 12:33:20 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: [PATCH v3 net-next 2/2] bpf: let bpf_warn_invalid_xdp_action()
 report more info
In-Reply-To: <ddb96bb975cbfddb1546cf5da60e77d5100b533c.1638189075.git.pabeni@redhat.com>
References: <cover.1638189075.git.pabeni@redhat.com>
 <ddb96bb975cbfddb1546cf5da60e77d5100b533c.1638189075.git.pabeni@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 30 Nov 2021 12:33:20 +0100
Message-ID: <87fsrd98u7.fsf@toke.dk>
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
> v2  -> v3:
>  - properly check NULL dev argument (kernel test robot)
>
> v1  -> v2
>   - do not include the device name for maps caller (Toke)
>
> rfc -> v1:
>  - do not print the attach type, print the program name
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

You forgot my ack :) here it is again:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

