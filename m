Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5381E8433
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 18:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgE2Q6w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 May 2020 12:58:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37129 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725601AbgE2Q6w (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 May 2020 12:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590771530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3tGbByuZRXmFAd1dhTbS4zQ9lQJnPiWlv2z/6LTD3Nc=;
        b=FKkVX6S9tNNvkDoBMOIRwJpnmr4YrT0swKiDRNXJFQ6tKPsd1W79NrKHd2aLI6vW1re0pD
        l1bZJflti/9DznrxJk3IKkPY3Yz8RD/BDFPhFrRy8OknJrJTRGNxV1JxIsEmgfysvoVTa2
        ncFi8Y+6+eoqKziX0ulKLVTqf8OIwfQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-eh8oEKrmP9CeC2nBVbXLQw-1; Fri, 29 May 2020 12:58:49 -0400
X-MC-Unique: eh8oEKrmP9CeC2nBVbXLQw-1
Received: by mail-ed1-f69.google.com with SMTP id bm11so1428207edb.8
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 09:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3tGbByuZRXmFAd1dhTbS4zQ9lQJnPiWlv2z/6LTD3Nc=;
        b=kka/24uXMjxTbd97Jx2sASQNz4J9VU7S1FELZmLolxlilQI+JhCflFt48oylJVTpSe
         je0yY1a0Q7BqcWsh5VAvzQax5etDWTBUWNeoNMgQOGx42+/Z3qGH5VdIUKavmC6HC8aZ
         NGVktrkQ29f4qVtOeYIF9otceYIHRTVKWq7xQHGcCEK0QpKyZyGe/Ee/toG1wu+uHot2
         c//YEal8uFAxeYWG0l2lLFGoJuCgDQgmgEd3txNmQpk6rRxt1ZCr2YTNIfID75ratVL1
         Y4bIetWjNbDuDnv9AntJOdKlQq78m0JkJsGGeTZwmlwlwC3Ygl3VOfFFm6kXRCS+CnZk
         sq+g==
X-Gm-Message-State: AOAM5301DqESQ6cqf7x13C9vAE7pP0Ory6cvC0noDK8jokjL1Iu1ug9Z
        avlKGOEgDUp4Rkn154zjt+I6vcH8Fu0Cof9i5O2QO59P6yU1PPJ2q5kMxxzPVU2nT+BShKvTMz4
        KUKtsOSodXuQE
X-Received: by 2002:a17:906:a402:: with SMTP id l2mr9054157ejz.14.1590771527866;
        Fri, 29 May 2020 09:58:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoWj0+rD5MVx5oFzuR+OBuCd+njf3lM2FmatSR0r39pJxoz4nqQBEhHHIeZZnLhbUlr1oHDQ==
X-Received: by 2002:a17:906:a402:: with SMTP id l2mr9054143ejz.14.1590771527699;
        Fri, 29 May 2020 09:58:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id dj28sm7334529edb.69.2020.05.29.09.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 09:58:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AAD59182019; Fri, 29 May 2020 18:58:46 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     David Ahern <dsahern@gmail.com>, David Ahern <dsahern@kernel.org>,
        netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        brouer@redhat.com, lorenzo@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Subject: Re: [PATCH v3 bpf-next 5/5] selftest: Add tests for XDP programs in devmap entries
In-Reply-To: <a8fd8937-25d7-0822-67a7-e01b856261be@gmail.com>
References: <20200529052057.69378-1-dsahern@kernel.org> <20200529052057.69378-6-dsahern@kernel.org> <87r1v2zo3y.fsf@toke.dk> <a8fd8937-25d7-0822-67a7-e01b856261be@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 29 May 2020 18:58:46 +0200
Message-ID: <87lflazni1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Ahern <dsahern@gmail.com> writes:

> On 5/29/20 10:45 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.=
c b/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c
>>> new file mode 100644
>>> index 000000000000..b360ba2bd441
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c
>>> @@ -0,0 +1,22 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* fails to load without expected_attach_type =3D BPF_XDP_DEVMAP
>>> + * because of access to egress_ifindex
>>> + */
>>> +#include <linux/bpf.h>
>>> +#include <bpf/bpf_helpers.h>
>>> +
>>> +SEC("xdp_dm_log")
>> Guess this should be xdp_devmap_log now?
>>=20
> no. this program is for negative testing - it should load as an XDP
> program without the expected_attach_type set. See the comment at the top
> of the file.

Ah, right, sorry - missed that (obviously) :)

-Toke

