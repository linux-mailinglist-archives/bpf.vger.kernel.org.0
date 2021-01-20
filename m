Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E832FD427
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 16:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390332AbhATPdz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 10:33:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390323AbhATO4N (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Jan 2021 09:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611154485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X49NCmr4OtIJ2Tlhjkaw9vv7Dceo8nUFaTM3w1LgmjA=;
        b=f/x7wj9T38ISm4GGBL4EvLDsdygtMYObsJzokhnAV88mzFghdlQetFhHwX/PBC2CRshS7u
        V/BxCBxuz/3wiwNPgggAkyDuDd9LqBQKk74xgqCzRyzjJOeFjEwUPOZFC18AX+dQ7uvTh2
        oCnGB0OlU1kqBSAyHpUTnZ6Z+j0pwsE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-52JXekGGMI2QBsNO0j3qTg-1; Wed, 20 Jan 2021 09:54:44 -0500
X-MC-Unique: 52JXekGGMI2QBsNO0j3qTg-1
Received: by mail-ed1-f72.google.com with SMTP id u17so11229319edi.18
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 06:54:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=X49NCmr4OtIJ2Tlhjkaw9vv7Dceo8nUFaTM3w1LgmjA=;
        b=ZzhGKzV890/oyEZ+04uzM8C8r1y/lnSwwnnVJlQlPNt/O17/6PtlPPKOuGiRA9UHj5
         lY4eCznPsXfoW24fYJPqcIvXW8JenIlREZKR+nI495ncPuHCZZRV47F3kCUt3OuufUN8
         OVXjMwUnyhwQUhNWvX0akkqUUW7qnFbZhakV+D0g34Mzp9XezTweORt6ISrrklv+mA7x
         nu2U156yTFQzX/9x0krQ8jrFqL5TBFXfa4S2pOXnkzrFyR7g6xk/txkbAzoDL/uqYryS
         zzZYmbXMnSLl5rnZDxFsS8zCWyPErgVNFVYL1SbevLleH8PaOuwI44tvNwwlYlR1Mb77
         TC0Q==
X-Gm-Message-State: AOAM5332/E07Y5ICN+cR2KKP53Nglv6sI3xUihqcTWVwTgFgg+Nm7P6W
        iDRJ96j7hxydZa8Qelu6VD5hKzg32uH1vwuT7VgrcBDNADTFOUG4E9sdFCH2D3npwLsFkd6gCpT
        172Hhb9PmjL+W
X-Received: by 2002:a17:906:4bc1:: with SMTP id x1mr6408423ejv.509.1611154483107;
        Wed, 20 Jan 2021 06:54:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznxKp8R07OXJgtMpuBX1xmrWJ/UPYE/s1NRu+fNuUBSpMWC5OFnQe2n1P4DF+kdpbQsAkp/w==
X-Received: by 2002:a17:906:4bc1:: with SMTP id x1mr6408406ejv.509.1611154482966;
        Wed, 20 Jan 2021 06:54:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q2sm1196924edv.93.2021.01.20.06.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 06:54:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E1E58180331; Wed, 20 Jan 2021 15:54:41 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        kuba@kernel.org, jonathan.lemon@gmail.com, maximmi@nvidia.com,
        davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        ciara.loftus@intel.com, weqaar.a.janjua@intel.com
Subject: Re: [PATCH bpf-next v2 4/8] xsk: register XDP sockets at bind(),
 and add new AF_XDP BPF helper
In-Reply-To: <46162f5f-5b3c-903b-8b8d-7c1afc74cb05@intel.com>
References: <20210119155013.154808-1-bjorn.topel@gmail.com>
 <20210119155013.154808-5-bjorn.topel@gmail.com> <878s8neprj.fsf@toke.dk>
 <46162f5f-5b3c-903b-8b8d-7c1afc74cb05@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 20 Jan 2021 15:54:41 +0100
Message-ID: <87k0s74q1a.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com> writes:

> On 2021-01-20 13:50, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:
>>=20
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index c001766adcbc..bbc7d9a57262 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -3836,6 +3836,12 @@ union bpf_attr {
>>>    *	Return
>>>    *		A pointer to a struct socket on success or NULL if the file is
>>>    *		not a socket.
>>> + *
>>> + * long bpf_redirect_xsk(struct xdp_buff *xdp_md, u64 action)
>>> + *	Description
>>> + *		Redirect to the registered AF_XDP socket.
>>> + *	Return
>>> + *		**XDP_REDIRECT** on success, otherwise the action parameter is ret=
urned.
>>>    */
>>=20
>> I think it would be better to make the second argument a 'flags'
>> argument and make values > XDP_TX invalid (like we do in
>> bpf_xdp_redirect_map() now). By allowing any value as return you lose
>> the ability to turn it into a flags argument later...
>>
>
> Yes, but that adds a run-time check. I prefer this non-checked version,
> even though it is a bit less futureproof.

That...seems a bit short-sighted? :)
Can you actually see a difference in your performance numbers?

-Toke

