Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B72CDCF3A
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 21:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505960AbfJRTXB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 15:23:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54610 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2505957AbfJRTXB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 15:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571426579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29hCFP1JlKBOETA3Lr+t9Sz32IHHg4kMgOJgEmAIrho=;
        b=QujSPo6GTnh4Ifgn9KrWrtYAgi/IYTTxvSUNPUELLamHE6PGRaKns0aCVoAAQV5c416DYV
        XncfqSn1cguhxFCpz2U0LGyCBSURIQdoQZ6a3jgsGS1h7di4uX390J5aEH2+7i+C+fSgTx
        rR/OlzuZt5LV2n3uacaD0m9FgThvtro=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-kaKhnhhiN9KzUUfEhLsu5A-1; Fri, 18 Oct 2019 15:22:56 -0400
Received: by mail-lf1-f70.google.com with SMTP id d11so1451560lfj.3
        for <bpf@vger.kernel.org>; Fri, 18 Oct 2019 12:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hngD5ZAMeF3Z9iaXLd53XFrcXGDhaXzMrnEYrWjbKE0=;
        b=FfifzDcToJVfVpQ9qlczt6/6+k6MgddxV5OK3f2eN7W9O7Mk6iUKPpIdNP4n6LA2WB
         O/7xM10NA9Om8b1NMzgeIy61a+ANyP7lxvHzYmtCGUblDcC3NfO0aQUyXdiuoDJijXRx
         ixmdTbZWd1tVeNSuRkDwucXBX76z0ddQWLR5ffduIbbZk5XboMa8b0J+jWwwDacvYn/b
         kvvSptOK/l4r5EfaNz44jvXvgNHW9KydqG0dqH5ccF4n4RqfU6iur83U12YliA7PoEyW
         +lBC9oYMkRN9cYEaXL7/L7aKzis/TTdxd+DP4CIOxNagmfWh7QThVMX/SC0mFLOcMXUp
         iYTw==
X-Gm-Message-State: APjAAAWAYyAPhy/QTk6hrN+/jAYUoSY05cMx0uMwVk2VhpQZHP7EInVZ
        bHfH9Z+bp8lsD6Fm9AjDmSgbAa9aq8fJ/NybOKQmkouQX/CcqZB+uhMEJ8VHsfrxUKejN7AquqE
        sIHaDyr6KvYns
X-Received: by 2002:a2e:87ca:: with SMTP id v10mr7056111ljj.43.1571426574866;
        Fri, 18 Oct 2019 12:22:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxXlFL39sjpCAtVlU2+qG/v+p6YXu7+BCTxgb6MPCePhJDyB/5/qDP6U117yiiq5qpaF7Whdw==
X-Received: by 2002:a2e:87ca:: with SMTP id v10mr7056099ljj.43.1571426574683;
        Fri, 18 Oct 2019 12:22:54 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id f28sm2933142lfp.28.2019.10.18.12.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 12:22:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F30731804B6; Fri, 18 Oct 2019 21:22:52 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "Samudrala\, Sridhar" <sridhar.samudrala@intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     "Karlsson\, Magnus" <magnus.karlsson@intel.com>,
        =?utf-8?B?QmrDtnJu?= =?utf-8?B?IFTDtnBlbA==?= 
        <bjorn.topel@intel.com>, Netdev <netdev@vger.kernel.org>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        "Fijalkowski\, Maciej" <maciej.fijalkowski@intel.com>,
        "Herbert\, Tom" <tom.herbert@intel.com>
Subject: Re: FW: [PATCH bpf-next 2/4] xsk: allow AF_XDP sockets to receive packets directly from a queue
In-Reply-To: <acf69635-5868-f876-f7da-08954d1f690e@intel.com>
References: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com> <1570515415-45593-3-git-send-email-sridhar.samudrala@intel.com> <CAADnVQ+XxmvY0cs8MYriMMd7=2TSEm4zCtB+fs2vkwdUY6UgAQ@mail.gmail.com> <3ED8E928C4210A4289A677D2FEB48235140134CE@fmsmsx111.amr.corp.intel.com> <2bc26acd-170d-634e-c066-71557b2b3e4f@intel.com> <CAADnVQ+qq6RLMjh5bB1ugXP5p7vYM2F1fLGFQ2pL=2vhCLiBdA@mail.gmail.com> <2032d58c-916f-d26a-db14-bd5ba6ad92b9@intel.com> <CAADnVQ+CH1YM52+LfybLS+NK16414Exrvk1QpYOF=HaT4KRaxg@mail.gmail.com> <acf69635-5868-f876-f7da-08954d1f690e@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 18 Oct 2019 21:22:52 +0200
Message-ID: <87wod1dfjn.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: kaKhnhhiN9KzUUfEhLsu5A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Samudrala, Sridhar" <sridhar.samudrala@intel.com> writes:

> Performance Results
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Only 1 core is used in all these testcases as the app and the queue irq a=
re pinned to the same core.
>
> -------------------------------------------------------------------------=
---------
>                                 mitigations ON                mitigations=
 OFF
>    Testcase              ------------------------------------------------=
----------
>                          no patches    with patches       no patches   wi=
th patches
> -------------------------------------------------------------------------=
---------
> AF_XDP default rxdrop        X             X                   Y         =
   Y

Is this really exactly the same with and without patches? You're adding
an extra check to xdp_do_redirect(); are you really saying that the
impact of that is zero?

> AF_XDP direct rxdrop        N/A          X+46%                N/A        =
 Y+25%
> Kernel rxdrop              X+61%         X+61%               Y+53%       =
 Y+53%
> -------------------------------------------------------------------------=
---------
>
> Here Y is pps with CPU security mitigations turned OFF and it is 26%
> better than X.

Any particular reason you're not sharing the values of X and Y?

-Toke

