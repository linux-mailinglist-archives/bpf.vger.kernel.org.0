Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0BB133F32
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2020 11:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgAHKXq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jan 2020 05:23:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48325 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726252AbgAHKXq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Jan 2020 05:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578479025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pYTFZUh6du+Gz6t/z7W4n8/MYAr68zER/bUdAggvIsw=;
        b=E9LaB548n5XfH9f02+gFb5yfdXcRLVvkBr6KvSsKJmaRGBwvW760mI2dmAUb++R6hsT2rf
        bNJbidnYum4coHUPxE6WI/cWOVscmqbArwc6aD8xNsENd3nirABMbgqz4htnrNK+dkVfvv
        kdBpkKIoCwwRC5axlgj2NxtlL7AoLOA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-IjRNeTwVOsmcJcq7crRrxg-1; Wed, 08 Jan 2020 05:23:44 -0500
X-MC-Unique: IjRNeTwVOsmcJcq7crRrxg-1
Received: by mail-wr1-f70.google.com with SMTP id j13so1236449wrr.20
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2020 02:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=pYTFZUh6du+Gz6t/z7W4n8/MYAr68zER/bUdAggvIsw=;
        b=rpdR557H5rhHKB8jtTl5cdCtJAFJeZNxOfhiNw7jg3387ySnm351ndy9s9UGAXgT8E
         z/VaSCarRp37MVLx7PYw1Z/4SOgD5CEJv4NOpvzCENLMJ+VUMa8wu4E0+p6YcAJj5GsE
         NzKYt/1buN19LcFW9v6BGDuJkn/CbkJK9yNBH5yrcze4/hJ98J6cTcN59Umdrld73u3x
         7Q5t233z/0G/6qDz9n0pTHJTnpxhFe7VWJXiMX1adbj6FNOcZArgrsU946TCSyx5qBCh
         DlXofmBRuevKJL5jeQ7GjVqXvZ6+XOCdYHjpRsPI2IKiHTXf2EPNadU//3WUgy+kbSSy
         /ogA==
X-Gm-Message-State: APjAAAXWk1nmrMH+zz1zSUNKpUKHjoyfMziEimHMPo3fr1TDpdQppPNE
        42GBhNjQSdF+LbBa9FRyBoPW6LMlJyILjLcYan05FFcQgLXkTLjOLlX7bOoRBrLJFxHSl0Ctfra
        zYYof6q4nRoud
X-Received: by 2002:a05:600c:10cd:: with SMTP id l13mr3158410wmd.102.1578479023552;
        Wed, 08 Jan 2020 02:23:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUIZNNclF0SdFdxtPbsI9I5SbnKealXcVOejTCf6A0OXRL0VRe9MnBSxvx2aWufdwqYf9NAA==
X-Received: by 2002:a05:600c:10cd:: with SMTP id l13mr3158389wmd.102.1578479023381;
        Wed, 08 Jan 2020 02:23:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id t1sm3243186wma.43.2020.01.08.02.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 02:23:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E2BA9180ADD; Wed,  8 Jan 2020 11:23:41 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Karlsson\, Magnus" <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/8] xdp: make devmap flush_list common for all map instances
In-Reply-To: <CAJ+HfNg2QFfhrwuEkZJjTKEYHhd1ByHgfmSp7wtwN_w2qB4rqA@mail.gmail.com>
References: <20191219061006.21980-1-bjorn.topel@gmail.com> <20191219061006.21980-6-bjorn.topel@gmail.com> <5e14c6b07e670_67962afd051fc5c05d@john-XPS-13-9370.notmuch> <CAJ+HfNg2QFfhrwuEkZJjTKEYHhd1ByHgfmSp7wtwN_w2qB4rqA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 08 Jan 2020 11:23:41 +0100
Message-ID: <874kx6i6vm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> On Tue, 7 Jan 2020 at 18:58, John Fastabend <john.fastabend@gmail.com> wr=
ote:
>>
> [...]
>> __dev_flush()?
>>
> [...]
>>
>> Looks good changing the function name would make things a bit cleaner IM=
O.
>>
>
> Hmm, I actually prefer the _map_ naming, since it's more clear that
> "entries from the devmap" are being flushed -- but dev_flush() works
> as well! :-) I can send a follow-up with the name change!

Or I can just change it at the point where I'm adding support for
non-map redirect (which is when the _map suffix stops being accurate)? :)

-Toke

