Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B2C574A6B
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 12:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiGNKS7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 06:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiGNKS6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 06:18:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E101A21261
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657793935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=268TOJBBQftVNNNkXRfzqZnsqQ0xNHshbtk7uW04UqU=;
        b=c9WyXtaS4hL68ugqBY0XbTzpLxDOgfK1Hb7skA16Z1k6l0n8AJLtUWX0p559n2ksEycbxC
        Pcl03bvFDEWqnQq8IN8QikXEcHhfoLzR6eu6/NvjqpYmaoRdEw6Gcezoh6KggLd/EuyVhh
        4t1qxmfEdLbLzAj7gdK3PQfrvJbVmi0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-x0NIsz6LNOOTeS_TxF8YwQ-1; Thu, 14 Jul 2022 06:18:54 -0400
X-MC-Unique: x0NIsz6LNOOTeS_TxF8YwQ-1
Received: by mail-ed1-f72.google.com with SMTP id n8-20020a05640205c800b00434fb0c150cso1194448edx.19
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 03:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=268TOJBBQftVNNNkXRfzqZnsqQ0xNHshbtk7uW04UqU=;
        b=CAr783qZvgYn21+dAKjepuiv+Dk6XZVuxx2F8sZQDDOigtwFNqkqPZjqr1xeh1JGen
         j62iFm0uN5JV21A8f02QJOclycvP0i28GE39LgNBVNgrPDtwAzQaawnqvsezJ0srAAGi
         RQpeUK7DaxtTwcskHbuMszEab26KJeSLh+Jcj8F0xIb8Iw8QQOCqhYWi/ffMNfa/fXBF
         X704Wbqc53X1Zy3MonQ+u101f+OQFil1pN1VO7WbhctFmuGZZ2L5b8ETMxc2OQJofMK7
         KSEsxBZYTWZRB2TELuaiRvqfGJGjoFrZmC8LA/PqQRK4lQjogjV79+BlZ1BkTcPVwQaF
         PiZg==
X-Gm-Message-State: AJIora/ozC9T36+GmCSRHucTO+OkYhd0cKv3F+4fCwUkLguoNwKiiWyK
        +TOevAw5xx6f/MPq9nTw3NAFKWqDy/E1gSwvFBzUN4k/o92xLk/bmmdAuiNVvk3P1gnnlxbRHU2
        Kp5Rt4mYvE8GI
X-Received: by 2002:a05:6402:2788:b0:43a:e0aa:97f4 with SMTP id b8-20020a056402278800b0043ae0aa97f4mr11179471ede.329.1657793933132;
        Thu, 14 Jul 2022 03:18:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vRF8ktMAL2EwVubBg1iy8EgoyJJJlqL2+W4RGBTwBRBIpP18bORBGo8OlSmvTGbMSpyKtDhw==
X-Received: by 2002:a05:6402:2788:b0:43a:e0aa:97f4 with SMTP id b8-20020a056402278800b0043ae0aa97f4mr11179435ede.329.1657793932798;
        Thu, 14 Jul 2022 03:18:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7d1cd000000b00435a742e350sm772178edp.75.2022.07.14.03.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:18:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 89B594D9B20; Thu, 14 Jul 2022 12:18:51 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Freysteinn Alfredsson <freysteinn.alfredsson@kau.se>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC PATCH 16/17] selftests/bpf: Add test for XDP queueing
 through PIFO maps
In-Reply-To: <CAEf4BzaZL=fQrvPDGg+VVoWqRRLD0g-3jfeAbAb6M_zEa4nFMg@mail.gmail.com>
References: <20220713111430.134810-1-toke@redhat.com>
 <20220713111430.134810-17-toke@redhat.com>
 <CAEf4BzaZL=fQrvPDGg+VVoWqRRLD0g-3jfeAbAb6M_zEa4nFMg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 14 Jul 2022 12:18:51 +0200
Message-ID: <87y1wwngj8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Jul 13, 2022 at 4:15 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> This adds selftests for both variants of the generic PIFO map type, and =
for
>> the dequeue program type. The XDP test uses bpf_prog_run() to run an XDP
>> program that puts packets into a PIFO map, and then adds tests that pull
>> them back out again through bpf_prog_run() of a dequeue program, as well=
 as
>> by attaching a dequeue program to a veth device and scheduling transmiss=
ion
>> there.
>>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  .../selftests/bpf/prog_tests/pifo_map.c       | 125 ++++++++++++++
>>  .../bpf/prog_tests/xdp_pifo_test_run.c        | 154 ++++++++++++++++++
>>  tools/testing/selftests/bpf/progs/pifo_map.c  |  54 ++++++
>>  .../selftests/bpf/progs/test_xdp_pifo.c       | 110 +++++++++++++
>>  4 files changed, 443 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/pifo_map.c
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pifo_test=
_run.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/pifo_map.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pifo.c
>>
>
> [...]
>
>> +__u16 pkt_count =3D 0;
>> +__u16 drop_above =3D 2;
>> +
>> +SEC("dequeue")
>
> "dequeue" seems like a way too generic term, why not "xdp_dequeue" or
> something like that? Isn't this XDP specific program?

Well, depending on how close the qdisc/xdp APIs end up being we may be
able to reuse the program type but have subtypes (so we could have
"dequeue/xdp" and "dequeue/skb" for instance). But if that doesn't pan
out I do see your point that "dequeue" is a bit too generic; will change
it to 'xdp_dequeue' in that case...

-Toke

