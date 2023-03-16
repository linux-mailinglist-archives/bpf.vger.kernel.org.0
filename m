Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D796BD9E7
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 21:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCPUK6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 16:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjCPUK5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 16:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8C9DDF15
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678997412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S/vpb1xIhX2vQ4kvOXzbDy79AECXzJiS3LlCu83SQPk=;
        b=Y9rZl+kI7YME/E7O+kmmn47LMc51T2cJRJPoDBJqm6d/g3RL3a/Hw1ZEjT1xVJ4+dWHTT0
        KWnH3/uBq9uwlcdfB78ek9ZBoIjs39duXyR7YNvg5p+eLOcpNys7blVDejoSK+6pGqdTup
        oAdiQRbJjVS/fwvFBeCaaz1RfqtKQfs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-tdMh_ZIrODusqpphry7jBA-1; Thu, 16 Mar 2023 16:10:08 -0400
X-MC-Unique: tdMh_ZIrODusqpphry7jBA-1
Received: by mail-ed1-f69.google.com with SMTP id ev6-20020a056402540600b004bc2358ac04so4604469edb.21
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 13:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678997405;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/vpb1xIhX2vQ4kvOXzbDy79AECXzJiS3LlCu83SQPk=;
        b=BWo/N/66xY7t8bm10Cp9zmZRkHrgZE3Sw3AA25COD+qSZ7lGT3DrAtknwr3/Ps1+7V
         61qP+xEyfPukiM0nXtwjvZrJoS9jXCy5YkruhwZ9/jemD7Af9XTG/LNQJ2CWWEn9n5rq
         gfXssBcj03U+cTdL1zojoIINmjfctQeH1eRv10dZiWSo2I72AIZiU83nNI5debLohvTe
         yQjl9MMvfD+ZQfEVCrY6YBhA7zXgXELjuZsSWgELKntNxgbK/8VVk4ACTqGMEBT0mXF9
         jen4DTMak7tjc+sjgb5+AkJqRZQP57FCwNFSPcR3BS582C91jjCGT0LuPNoUqY6NhxLS
         /6+g==
X-Gm-Message-State: AO0yUKWl3OXpkv9JhF5uge06OqcGxCBkaaPKsJ6pw+loX8LJz5eB4EEf
        JAf4gkvbIkikpAV6yDIwA+WJ0Fs6uysff7G7yoE2ERJh15ilhIeFGZz/2FtQL8jdl+TqkQtxC22
        WY1Q6jbx/A0gu
X-Received: by 2002:aa7:d38e:0:b0:4a3:43c1:8430 with SMTP id x14-20020aa7d38e000000b004a343c18430mr639552edq.4.1678997404830;
        Thu, 16 Mar 2023 13:10:04 -0700 (PDT)
X-Google-Smtp-Source: AK7set/KstoAnY5wxPAVV6js2FmqK22PG2bWRxtvBjMEP5kEuMnnvnnbw/ckF/EqlkBmUW/RWKO0lQ==
X-Received: by 2002:aa7:d38e:0:b0:4a3:43c1:8430 with SMTP id x14-20020aa7d38e000000b004a343c18430mr639493edq.4.1678997403848;
        Thu, 16 Mar 2023 13:10:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q28-20020a50aa9c000000b004fb556e905fsm203845edc.49.2023.03.16.13.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 13:10:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7E9919E30A4; Thu, 16 Mar 2023 21:10:02 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Song Liu <song@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: fix "metadata marker"
 getting overwritten by the netstack
In-Reply-To: <20230316175051.922550-3-aleksander.lobakin@intel.com>
References: <20230316175051.922550-1-aleksander.lobakin@intel.com>
 <20230316175051.922550-3-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 16 Mar 2023 21:10:02 +0100
Message-ID: <875yb0a25h.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Alexei noticed xdp_do_redirect test on BPF CI started failing on
> BE systems after skb PP recycling was enabled:
>
> test_xdp_do_redirect:PASS:prog_run 0 nsec
> test_xdp_do_redirect:PASS:pkt_count_xdp 0 nsec
> test_xdp_do_redirect:PASS:pkt_count_zero 0 nsec
> test_xdp_do_redirect:FAIL:pkt_count_tc unexpected pkt_count_tc: actual
> 220 !=3D expected 9998
> test_max_pkt_size:PASS:prog_run_max_size 0 nsec
> test_max_pkt_size:PASS:prog_run_too_big 0 nsec
> close_netns:PASS:setns 0 nsec
>  #289 xdp_do_redirect:FAIL
> Summary: 270/1674 PASSED, 30 SKIPPED, 1 FAILED
>
> and it doesn't happen on LE systems.
> Ilya then hunted it down to:
>
>  #0  0x0000000000aaeee6 in neigh_hh_output (hh=3D0x83258df0,
> skb=3D0x88142200) at linux/include/net/neighbour.h:503
>  #1  0x0000000000ab2cda in neigh_output (skip_cache=3Dfalse,
> skb=3D0x88142200, n=3D<optimized out>) at linux/include/net/neighbour.h:5=
44
>  #2  ip6_finish_output2 (net=3Dnet@entry=3D0x88edba00, sk=3Dsk@entry=3D0x=
0,
> skb=3Dskb@entry=3D0x88142200) at linux/net/ipv6/ip6_output.c:134
>  #3  0x0000000000ab4cbc in __ip6_finish_output (skb=3D0x88142200, sk=3D0x=
0,
> net=3D0x88edba00) at linux/net/ipv6/ip6_output.c:195
>  #4  ip6_finish_output (net=3D0x88edba00, sk=3D0x0, skb=3D0x88142200) at
> linux/net/ipv6/ip6_output.c:206
>
> xdp_do_redirect test places a u32 marker (0x42) right before the Ethernet
> header to check it then in the XDP program and return %XDP_ABORTED if it's
> not there. Neigh xmit code likes to round up hard header length to speed
> up copying the header, so it overwrites two bytes in front of the Eth
> header. On LE systems, 0x42 is one byte at `data - 4`, while on BE it's
> `data - 1`, what explains why it happens only there.
> It didn't happen previously due to that %XDP_PASS meant the page will be
> discarded and replaced by a new one, but now it can be recycled as well,
> while bpf_test_run code doesn't reinitialize the content of recycled
> pages. This mark is limited to this particular test and its setup though,
> so there's no need to predict 1000 different possible cases. Just move
> it 4 bytes to the left, still keeping it 32 bit to match on more
> bytes.

Wow, this must have been annoying to track down - nice work :)

> Fixes: 9c94bbf9a87b ("xdp: recycle Page Pool backed skbs built from XDP f=
rames")
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Link: https://lore.kernel.org/bpf/CAADnVQ+B_JOU+EpP=3DDKhbY9yXdN6GiRPnpTT=
XfEZ9sNkUeb-yQ@mail.gmail.com
> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com> # + debugging
> Link: https://lore.kernel.org/bpf/8341c1d9f935f410438e79d3bd8a9cc50aefe10=
5.camel@linux.ibm.com
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

