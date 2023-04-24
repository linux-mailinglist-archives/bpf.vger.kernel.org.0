Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DA46ED598
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 21:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjDXTxR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 15:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjDXTxQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 15:53:16 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5485B8C
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 12:52:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a920d484bdso40764765ad.1
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 12:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682365945; x=1684957945;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcQOIt0qOSo6KB7OE69fbdJrAYh9oFpDnkHfal+p1jo=;
        b=bBkBN0G55dGN+h74dphyYp4Oo6AiCOeXviBv9XJh9SGkFh5AEAW0f+GkpxJKdXGw+8
         FJcuG7WtS6VAAtJgy2uzkUgKzTmOWMyeLA7/CIuXzNnzjb7fRMYnULY3tVbbbMwc74Sw
         QZZMG3sV+1E72iW7CmHeTXfOsIOJOTXPYj9qNrcuTd+ywnoszYKYay/A/jQRrFkp9spG
         uzQZ4B2MSTGTwvjy1pFSQqSBhOcsHYukLw2grrTOZscAPuTYYz1Ke5CmZkmuc2oDq5TW
         iqwTaQaAZSb+JmdkvJW6GqfJX028Hbof1fxhYJuMGg0BMYFbknwt+uUn3bN4TGtgJoQo
         tZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682365945; x=1684957945;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QcQOIt0qOSo6KB7OE69fbdJrAYh9oFpDnkHfal+p1jo=;
        b=JMm2onGbgWDrlXk5bEPNhQxYBfVCPCm4kP6Z08N2fqX/EmKHkpYHbaXGCfDDGfqrk7
         G0Y32CkctYgL0s9akn3iDzmVXAiGiKLEuvIMWtfRhAjGVml0i7cJakQ/Uc44NQPsSKIY
         1KNdxT5G1SSafKjaGTQSqlLGaRvsZDPeZfIeaXXTnMuIo4AnTGw6O80g+bj/fxWpQOiH
         gZ/bvti9sNQ4X+IpY2xWF1klYjEpRULqXt/lCXjBVBJOBu89McrD1SvKoPCzt4antO5n
         36D3luLTuoqSWhJsfPt5xlFfE9qgbnxo4zHEC0/WfFQTyT7OhMxTLXVnu/xyvPbaMAqP
         QCBA==
X-Gm-Message-State: AAQBX9caB/6hDvMa0vcAFQ2mWu7rhnxw3v9JoZ+AwDk/SqWxJh2ve4aZ
        DZEF8blNt250oMVoWIOcHNo=
X-Google-Smtp-Source: AKy350Zz6e1CKe3JAGIAdE7dayOMd0aQuActdgYix1YhmoZCTxb8B7x0Uq1BOtVluWq+UU1bikdogQ==
X-Received: by 2002:a17:902:c98a:b0:1a6:e564:6046 with SMTP id g10-20020a170902c98a00b001a6e5646046mr12575607plc.46.1682365944741;
        Mon, 24 Apr 2023 12:52:24 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10:d8b6:344e:b81a:e8b5])
        by smtp.gmail.com with ESMTPSA id om12-20020a17090b3a8c00b002405d3bbe42sm8680673pjb.0.2023.04.24.12.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 12:52:24 -0700 (PDT)
Date:   Mon, 24 Apr 2023 12:52:22 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Message-ID: <6446ddf671562_389cc20852@john.notmuch>
In-Reply-To: <20230420071414.570108-4-joannelkoong@gmail.com>
References: <20230420071414.570108-1-joannelkoong@gmail.com>
 <20230420071414.570108-4-joannelkoong@gmail.com>
Subject: RE: [PATCH v2 bpf-next 3/5] bpf: Add bpf_dynptr_size
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
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong wrote:
> bpf_dynptr_size returns the number of useable bytes in a dynptr.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>
