Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B2A6E175A
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 00:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDMW37 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 18:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDMW34 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 18:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6624986A8
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 15:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681424944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2DXFP3dB1bKLbWwK18eQnwRV9pZt3DISx+mq7u3Xyg4=;
        b=Q1lTe/rJFJn09Gbp34WizuUPpx2RD38hw4hv951fynPdjmznpFtY1Qdj+oamX5UGNLZFn9
        tNOzE8XGqDr4l+JCnTU7OjOeead0lWCL8W9jKdMUyjMIl37kKkSymxVsThW/MH/WGiAh4Y
        lUeeA5LqjCszqMgh+pwjwTqzDV9iGrk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-GqCrAbq3PrS08u1Sth6c-g-1; Thu, 13 Apr 2023 18:29:03 -0400
X-MC-Unique: GqCrAbq3PrS08u1Sth6c-g-1
Received: by mail-ed1-f69.google.com with SMTP id q19-20020a50c353000000b0050683052191so74182edb.19
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 15:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681424942; x=1684016942;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DXFP3dB1bKLbWwK18eQnwRV9pZt3DISx+mq7u3Xyg4=;
        b=jQIQygE1FjKEnJXLR/Oa3mNLW5VatotjoIpI+EFSdSi920djnnmggqWWT6651HR1IJ
         9gccpjCcOXj4Rstc6a/hz46+/0U14fNx9Zk9WLpLhPnIPBG9ZJlt9TfnrosxRreiIz4n
         Qfh3goaTMz2/3qs2RC5PbOKmxnl9WGJYsnorqSk5csejpMbZF701wAMckGwpPp5c4VUh
         Xsp3lCydAywOUJe3/dX9aWYjJGsfo/gG/QNCZSZ9VtUAlfMJc//3bNNGaiXCoIx/zPju
         p5i3+RBGuiZZcw7IY2e+qOA12HxVCfrJ0rhJS9PnWIMf9WzoCmNW4QwRaG/muVCsNtqU
         F/HQ==
X-Gm-Message-State: AAQBX9ee/0+eRLIm1ziG5UAuq3HLh07D98EGd9zPBZ0rBVm1mClC6Kcs
        lpt9Ci0MqkPXRHTMsON62wegyxSn0vQIbKQUQz98Yy0JUZaR1ZlzapNOiatCzzQtT4X839NDQGV
        ukHlBaZR60We+
X-Received: by 2002:a17:906:80cd:b0:94e:d5d7:7bfb with SMTP id a13-20020a17090680cd00b0094ed5d77bfbmr922175ejx.40.1681424941465;
        Thu, 13 Apr 2023 15:29:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZoLl7yF+5cXOYIhLuGb0DLXmWW4xsCqLqX6l6ZjfH+FEUZNnp0roFCxzbVj/FQJmpn/sASRA==
X-Received: by 2002:a17:906:80cd:b0:94e:d5d7:7bfb with SMTP id a13-20020a17090680cd00b0094ed5d77bfbmr922151ejx.40.1681424940573;
        Thu, 13 Apr 2023 15:29:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id de34-20020a1709069be200b0094e8b90bbccsm1540519ejc.221.2023.04.13.15.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 15:29:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 78700AA7C0F; Fri, 14 Apr 2023 00:28:59 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kal Cutter Conley <kal.conley@dectris.com>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        =?utf-8?B?QmrDtnJu?= =?utf-8?B?IFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] xsk: Support UMEM chunk_size > PAGE_SIZE
In-Reply-To: <CAHApi-=BcdTD7KvE0OEzYya0RmDLDBS19NgtZsESADYXbySLOQ@mail.gmail.com>
References: <20230406130205.49996-1-kal.conley@dectris.com>
 <20230406130205.49996-2-kal.conley@dectris.com> <87sfdckgaa.fsf@toke.dk>
 <ZDBEng1KEEG5lOA6@boxer>
 <CAHApi-nuD7iSY7fGPeMYiNf8YX3dG27tJx1=n8b_i=ZQdZGZbw@mail.gmail.com>
 <875ya12phx.fsf@toke.dk>
 <CAHApi-=rMHt7uR8Sw1Vw+MHDrtkyt=jSvTvwz8XKV7SEb01CmQ@mail.gmail.com>
 <87ile011kz.fsf@toke.dk>
 <CAHApi-m4gu8SX_1rBtUwrw+1-Q3ERFEX-HPMcwcCK1OceirwuA@mail.gmail.com>
 <87o7nrzeww.fsf@toke.dk>
 <CAHApi-=BcdTD7KvE0OEzYya0RmDLDBS19NgtZsESADYXbySLOQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 14 Apr 2023 00:28:59 +0200
Message-ID: <87edonzaac.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kal Cutter Conley <kal.conley@dectris.com> writes:

>> "More annoying" is not a great argument, though. You're basically saying
>> "please complicate your code so I don't have to complicate mine". And
>> since kernel API is essentially frozen forever, adding more of them
>> carries a pretty high cost, which is why kernel developers tend not to
>> be easily swayed by convenience arguments (if all you want is a more
>> convenient API, just build one on top of the kernel primitives and wrap
>> it into a library).
>
> I was trying to make a fair comparison from the user's perspective
> between having to allocate huge pages and deal with discontiguous
> buffers. That was all.
>
> I think the "your code" distinction is a bit harsh. The kernel is a
> community project. Why isn't it "our" code? I am trying to add a
> feature that I think is generally useful to people. The kernel only
> exists to serve its users.

Oh, I'm sorry if that came across as harsh, that was not my intention! I
was certainly not trying to make a "you vs us" distinction; I was just
trying to explain why making changes on the kernel side carries a higher
cost than an equivalent (or even slightly more complex) change on the
userspace side, because of the UAPI consideration.

> I believe I am doing more good than harm sending these patches.

I don't think so! You've certainly sparked a discussion, that is good :)

-Toke

