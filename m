Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467216D4CE4
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 17:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDCP7N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 11:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjDCP7J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 11:59:09 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067E52133
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 08:58:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so33026369pjb.4
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680537517;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFGy5yopGnrlojwso7iPjePt0EcMxiKrfI3uI5NjoIo=;
        b=WAe7dx26DJi+kH+d0zIB7fz+zcQkFPeIqIYYHE5lddWPiuxPkhKkdXk/qB1ffMn6zH
         /MrnDhwOIr4b90CtalRM+pqd8+jgisH2Ul9rzn/xnZ+hjHe/f/td2AR+gabICQTj/X3a
         55YYdw8i5WQGMNNqCWT/t+cpqhbyhdBJscJRUpeqCIJnaQz81ei13VDjxSh0KhDyfUEw
         PNCbZTihMBS0K1cwcTRgDhzFV2kDEHNgn927sLJBvtPQdNCEj5gQ+Uke324UQ2Wj6I/m
         WLjpj3l5Gu7dDkA56IJtTiCAYZd2/NShYuQquNMggoiOiGgmoI5SRI/R1817AaxMyxox
         169Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680537517;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFGy5yopGnrlojwso7iPjePt0EcMxiKrfI3uI5NjoIo=;
        b=yPuUQdC2e7xnhHjw54NJs22DFMDFuDgpX+s161zrWsCAjgFI7WUIRXQNSbFIVD2nAF
         SE9ukSM9kcsSYeH9CkC0ygBDtGt11dT8Ts3Zrr4rVJcbAQveyzm9by5zcWH05V2j07BS
         bSt4m1vAHwpkLXTJzuFwh1cEuhrKRinJH1o2b6ReEK+FH+Ms3ZGaqgWSuzTFVOuysVeD
         JGwSvLl7XYMi2vPqA3S6mN5F0u09Q7emHWbAq3ZaB6rOvKSB2sKrWcg2bcvkR6QTD+UF
         kBS0yYGI4LGdWB9Lurt5NxWpYOc4RICrHdOJ2KQLXVhwdzflWslFagUqLpO/b3HjvxUx
         Efcw==
X-Gm-Message-State: AAQBX9epQzaAfEuXau2puRGnEJlEWfOxAb+bkEVwopv6Y6P6lwjmTLcC
        eFgJwJPNOcno2mAK4OCHqDDTkg==
X-Google-Smtp-Source: AKy350bRf2/vavTtFhS2AOmBUhlwu+jv6Wq4jSsEk5YrbH6NrISpaK6yR+oLAWBEmkgoapLXCoUQ4w==
X-Received: by 2002:a05:6a20:8ba8:b0:e3:763d:91e3 with SMTP id m40-20020a056a208ba800b000e3763d91e3mr16460468pzh.49.1680537516973;
        Mon, 03 Apr 2023 08:58:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:b4b3:ae45:a8e8:1b15? ([2601:647:4900:1fbb:b4b3:ae45:a8e8:1b15])
        by smtp.gmail.com with ESMTPSA id m14-20020aa78a0e000000b0062612b97cfdsm7121021pfa.123.2023.04.03.08.58.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2023 08:58:36 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v4 bpf-next 2/4] bpf: Add bpf_sock_destroy kfunc
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <9cfdf301-fc82-d734-bec9-081daef4c896@linux.dev>
Date:   Mon, 3 Apr 2023 08:58:35 -0700
Cc:     bpf@vger.kernel.org, edumazet@google.com,
        Stanislav Fomichev <sdf@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <31903EC7-1796-4376-AEBC-FAF49F585407@isovalent.com>
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
 <20230323200633.3175753-3-aditi.ghag@isovalent.com>
 <ZB4X/uOEdq79Lbof@google.com>
 <ED9BFD83-8CCE-4783-B28F-0742F70AAB8F@isovalent.com>
 <CAKH8qBvibAPqkJ_73-e_CpPRDMMhP9v4nP7vAqw=q9et8DPCig@mail.gmail.com>
 <9cfdf301-fc82-d734-bec9-081daef4c896@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 30, 2023, at 10:30 AM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 3/30/23 9:32 AM, Stanislav Fomichev wrote:
>>>> Maybe make it more opt-in? (vs current "opt ipproto_raw out")
>>>>=20
>>>> if (sk->sk_prot->diag_destroy !=3D udp_abort &&
>>>>    sk->sk_prot->diag_destroy !=3D tcp_abort)
>>>>            return -EOPNOTSUPP;
>>>>=20
>>>> Is it more robust? Or does it look uglier? )
>>>> But maybe fine as is, I'm just thinking out loud..
>>>=20
>>> Do we expect the handler to be extended for more types? Probably =
not... So I'll leave it as is.
>> My worry is about somebody adding .diag_destroy to some new/old
>> protocol in the future, say sctp_prot, without being aware
>> of this bpf_sock_destroy helper and its locking requirements.

Ah, sctp!!=20

>=20
> Other helpers in filter.c is also opt-in. I think it is better to do =
the same here. IPPROTO_TCP and IPPROTO_UDP should have very good use =
case coverage to begin with. It can also help to ensure new selftests =
are written to cover the protocol supporting bpf_sock_destroy in the =
future.
>=20
> I like the comment in bpf_sock_destroy() in this patch. It will be =
even better if it can spell out more clearly that future supporting =
protocol needs to assume the lock_sock has already been done on the bpf =
side.

Ack... I'll make it opt-in.=20

>=20
>> So having an opt-in here (as in sk_protocol =3D=3D IPPROTO_TCP ||
>> sk_protocol =3D=3D IPPROTO_UDP) feels more future-proof than your =
current
>> opt-out (sk_proto !=3D IPPROTO_RAW).
>> WDYT?
>>>>> +            release_sock(sk);
>>>>=20
>>>>>      return 0;
>>>>>  }
>>>>> --
>>>>> 2.34.1
>>>=20
>=20

