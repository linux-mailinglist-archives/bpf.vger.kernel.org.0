Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5709F6DC073
	for <lists+bpf@lfdr.de>; Sun,  9 Apr 2023 16:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjDIOt1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Apr 2023 10:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDIOt1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Apr 2023 10:49:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C27835AA
        for <bpf@vger.kernel.org>; Sun,  9 Apr 2023 07:49:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ga37so7535752ejc.0
        for <bpf@vger.kernel.org>; Sun, 09 Apr 2023 07:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1681051764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=65LSbWKUrmCArl+LXVPE7dMWtbfbmdZlWVztuN2QWX0=;
        b=b0gnqKuPzGxBDzcrGs8eDqLRGoQBwJSNtdIQW7jdBZj187QJuJhpCg5slpnkGD2r1g
         JBtHIXOz0t36TBewgWRcItyvOujSFDwZ4lsvBJxvlDfbjOAzNYSah373BzCo29W5s/mJ
         zqP+1d9/mJ0YA/jQzKcOVnEmCysltQfFGuw2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681051764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65LSbWKUrmCArl+LXVPE7dMWtbfbmdZlWVztuN2QWX0=;
        b=6oNOvLcxhMOoDzDGeU3k5R2ZDiOgqMUkO86olwtr252VC9PKCSkbWLLSnVGgtQWe/C
         iiWh+KE4EwinVPK2hWD/WnoVmY7dTJ5eIBvKN+4CdTf3KX/aUJ9eYzikrOwyKu2EijmB
         dBIz7GR9oFXxiY+L4ZW1grDmMQdC1KaVi9O1tzaSK+P2DA4D1/4UNWr85MOItmjbHZBp
         KhUVdxXaZGlnbQM4sy7uI2dgY+lFZJ7klEmy0RsbClIuntrOnaEtfgD6Wx/m/H83KJKN
         qBjLB39qV6uGAMknzkmesaINeN6FogVObuJqKoIyMaYt+W07/+4f63kloJ7Wp1CNBhuS
         BLLg==
X-Gm-Message-State: AAQBX9d972iTMRGDai6jRHPAHbcKi5wt5Wjs5e1UM472ve1iVI2lQSXh
        j7Fj8MvxMXR1rq+SA7BfhOvo+1j1fH+HP4YVtAVLJw==
X-Google-Smtp-Source: AKy350Y//avkrDNCiYLj+3hant+G2KKsf7lq85OXJkIr+RhU38AdQal5f9HWvuw7i/JuxgMRJVbuorj3x81kC4LvY7A=
X-Received: by 2002:a17:907:a68a:b0:92e:7a67:668a with SMTP id
 vv10-20020a170907a68a00b0092e7a67668amr2381028ejc.0.1681051763891; Sun, 09
 Apr 2023 07:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230406212136.19716-1-kal.conley@dectris.com>
In-Reply-To: <20230406212136.19716-1-kal.conley@dectris.com>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Sun, 9 Apr 2023 16:54:05 +0200
Message-ID: <CAHApi-=CZcRcD+knw6TgFxEnk+16bN4nPJKLVbfmsHHL7crtnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] xsk: Elide base_addr comparison in xp_unaligned_validate_desc
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> +       addr = xp_unaligned_add_offset_to_addr(desc->addr);
> +

I guess this assignment should simply be combined with the variable
declaration. This will shorten the function by an additional two lines
of code.
