Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C718066DB49
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 11:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbjAQKjZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 05:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbjAQKix (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 05:38:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2B739CD1
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 02:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673951626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h3KJE79yIHnB29huev91c70DW7KrTtxOmGhEtqUkXQA=;
        b=U/5+DQVBpjF48paow6w/RWSy3zsauDcAQ8JU/A+uyQ70ybT57aH0HBYG4JJ6RhXku5hkgb
        ORjzZmJNmvrexSW0iWQJ0+vLOMotHbA0WwkWGsEvDvDfH5vRjboTuVdhvYoCYsBWh9hMe6
        FRx0G282d75OAkEoHtTyL3l1oHze5nc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-27-pB4yOWsWMsa6ZetwEuJWcw-1; Tue, 17 Jan 2023 05:33:42 -0500
X-MC-Unique: pB4yOWsWMsa6ZetwEuJWcw-1
Received: by mail-ed1-f69.google.com with SMTP id j10-20020a05640211ca00b0049e385d5830so727649edw.22
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 02:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3KJE79yIHnB29huev91c70DW7KrTtxOmGhEtqUkXQA=;
        b=sJIILqblb4Igf6BS81iPeryXo6PXjvfG61t0mENR3Ij55F8CGGAX9Vtt2rK7muN2Gn
         ketqNrHea/Cj14rYPSVO51pOqbZXg9mL++G+E3CPnqKgq9lgCoWdf+6zHPJ6406R5DaE
         fz5OWTX3b8245Ab74mnLqcuRjIe/YSaRzerMtRfZTpbcZPjDBA6SuJxTRze5uB2jx6Vb
         dWYURECkI8cmctJ5uSKFPzmPbzUvZGEPPGc5ITDHIG3n+1d6lO8kmRmD1v/CwmTErZcX
         CyBYDAtqs8cusMfM4czspw13maan9fKM0rGteLOrQFhBBXe36sEqGZy/Ijt3+o8zTJfr
         bNUA==
X-Gm-Message-State: AFqh2kpHjuWb8vGNYMfBEJm5ki7U8tdE1I+aAm4rOW3d1XXjBw83kDuv
        t2JXFN0PNIQHmc7JICBwDR80w7G4krjevQJvN2UZF7LRcqfU0whQYMcV6hOesVAMtK4uhqVoq8F
        1/03yNUTwrHV7
X-Received: by 2002:a17:907:6e2a:b0:871:e9a0:eba7 with SMTP id sd42-20020a1709076e2a00b00871e9a0eba7mr2969679ejc.57.1673951620789;
        Tue, 17 Jan 2023 02:33:40 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvxXlQdblReVhkBfD9P6awdd+C/UXYFiXv29qCEooauRA+hTsykeWRfwP7ivJWOaj0mQlejSw==
X-Received: by 2002:a17:907:6e2a:b0:871:e9a0:eba7 with SMTP id sd42-20020a1709076e2a00b00871e9a0eba7mr2969651ejc.57.1673951620059;
        Tue, 17 Jan 2023 02:33:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id sb25-20020a1709076d9900b007a4e02e32ffsm13046805ejc.60.2023.01.17.02.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 02:33:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 28D579010D2; Tue, 17 Jan 2023 11:33:35 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        jonathan.lemon@gmail.com, maciej.fijalkowski@intel.com,
        kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
        brouer@redhat.com
Cc:     bpf@vger.kernel.org
Subject: Re: [PATCH net-next] xdp: document xdp_do_flush() before
 napi_complete_done()
In-Reply-To: <20230117094305.6141-1-magnus.karlsson@gmail.com>
References: <20230117094305.6141-1-magnus.karlsson@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 17 Jan 2023 11:33:35 +0100
Message-ID: <87wn5lcuww.fsf@toke.dk>
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

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> From: Magnus Karlsson <magnus.karlsson@intel.com>
>
> Document in the XDP_REDIRECT manual section that drivers must call
> xdp_do_flush() before napi_complete_done(). The two reasons behind
> this can be found following the links below.
>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Link: https://lore.kernel.org/r/20221220185903.1105011-1-sbohrer@cloudfla=
re.com
> Link: https://lore.kernel.org/all/20210624160609.292325-1-toke@redhat.com/

Thanks for fixing this!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

