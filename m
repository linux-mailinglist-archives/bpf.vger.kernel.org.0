Return-Path: <bpf+bounces-3924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8769E7464C7
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 23:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB35280DB7
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 21:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6A4125C0;
	Mon,  3 Jul 2023 21:19:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC7100B3;
	Mon,  3 Jul 2023 21:19:15 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0745E59;
	Mon,  3 Jul 2023 14:19:13 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1b056276889so4118788fac.2;
        Mon, 03 Jul 2023 14:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688419153; x=1691011153;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpqEkaNg2J+Bvai1eAr5gemxKMDFvKrtFaY0+RQFT44=;
        b=YNfVyPMrtM+l//4e83mxX3p1YK5+82O1BU/hVANnM1N6jc2ntbgmhK363IxtXgmU6i
         MYkq24ujV1XDGM3ORTWfQJuonRidDMWsFFoFT9PbCFnPe47VGDgnYE8YkrWzfJm8E6np
         0lYNyASVemcM8upnFdliO0US3UZ5OtaoyWjtSAAE+pizyQ6y+52TKFOd9ZsNvr7n+Vdc
         ukSX+Q68u/XydWPUMP8OLc5pkSOcOUmtZJIIZowifISrhJiMxSOZF19Lb4x3E67EoV19
         zoHO1tXWBrkMN7oK4axUj4yzx+X+XE5x3SqaO9FjkU3VN+vb3f15JZtH2AgTd/8lO2NY
         J35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688419153; x=1691011153;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UpqEkaNg2J+Bvai1eAr5gemxKMDFvKrtFaY0+RQFT44=;
        b=MsXIesY6dc89Csu4Fq3dlQ9cJGm+IhgbTc8MEXd+NwwoQHcwh0p4MJZNsxcRG5kgyn
         F0WRRnraHkqjNh2kGyUq4ZdMYyx2HzliQk7f3hhLoKW0w3odrKkw+F7EHPUG73v5gNXd
         hxsxhB2TNmcvoqI/Pn2nMVQbbqkFVAzPnppVuA8gJJI23g9E4VVurXStIe1JU23J21uS
         gCIk/EKVgwtHwQp744xZ1+Lgcy370ktm4980bZ3ATMxgCuG50d8ogoJcrxm8Z/PWR+KW
         A1dLciq2NDp/lKWG9TGKlCRhGIVszxkPT7T0yCNGf2eL5Xy7fqZ1WuIiMTEEXIx585JI
         xUcw==
X-Gm-Message-State: ABy/qLYwFyxzeRWXkEn7grLql7DRmXXq3cqOEHbGLnbXZ2ZddmppJQAB
	YtjZlwAoZYemGOMpfWVQlig=
X-Google-Smtp-Source: APBJJlHqATpdJTKWq1iDMSIA3foxuxaBzMCf8d8gvgidQSrf4T1i9ibLte2VnDPbJLdegXQwptEYMg==
X-Received: by 2002:a05:6870:7d8e:b0:1ad:2e18:7090 with SMTP id oq14-20020a0568707d8e00b001ad2e187090mr12419826oab.32.1688419152950;
        Mon, 03 Jul 2023 14:19:12 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10::41f])
        by smtp.gmail.com with ESMTPSA id gm4-20020a17090b100400b0025023726fc4sm14271294pjb.26.2023.07.03.14.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 14:19:12 -0700 (PDT)
Date: Mon, 03 Jul 2023 14:19:11 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Ilya Maximets <i.maximets@ovn.org>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>
Message-ID: <64a33b4fcccc_6520520825@john.notmuch>
In-Reply-To: <20230703175329.3259672-1-i.maximets@ovn.org>
References: <20230703175329.3259672-1-i.maximets@ovn.org>
Subject: RE: [PATCH bpf-next] xsk: honor SO_BINDTODEVICE on bind
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ilya Maximets wrote:
> Initial creation of an AF_XDP socket requires CAP_NET_RAW capability.
> A privileged process might create the socket and pass it to a
> non-privileged process for later use.  However, that process will be
> able to bind the socket to any network interface.  Even though it will
> not be able to receive any traffic without modification of the BPF map,
> the situation is not ideal.
> 
> Sockets already have a mechanism that can be used to restrict what
> interface they can be attached to.  That is SO_BINDTODEVICE.
> 
> To change the SO_BINDTODEVICE binding the process will need CAP_NET_RAW.
> 
> Make xsk_bind() honor the SO_BINDTODEVICE in order to allow safer
> workflow when non-privileged process is using AF_XDP.
> 
> The intended workflow is following:
> 
>   1. First process creates a bare socket with socket(AF_XDP, ...).
>   2. First process loads the XSK program to the interface.
>   3. First process adds the socket fd to a BPF map.
>   4. First process ties socket fd to a particular interface using
>      SO_BINDTODEVICE.
>   5. First process sends socket fd to a second process.
>   6. Second process allocates UMEM.
>   7. Second process binds socket to the interface with bind(...).
>   8. Second process sends/receives the traffic.
> 
> All the steps above are possible today if the first process is
> privileged and the second one has sufficient RLIMIT_MEMLOCK and no
> capabilities.  However, the second process will be able to bind the
> socket to any interface it wants on step 7 and send traffic from it.
> With the proposed change, the second process will be able to bind
> the socket only to a specific interface chosen by the first process
> at step 4.
> 
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>

