Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F62697840
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 09:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjBOIeb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 03:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjBOIea (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 03:34:30 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3856A2BEE2
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 00:34:28 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-52eb7a5275aso240453147b3.2
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 00:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lZ0Tbl1JRT8TpgT4ciKif/L2O/2dnKFAn9OEhwx1LKY=;
        b=dnoSQwsXcuOdAmTUN4n1Z54s5MXVwmWD46iY4LYXeF8GleCpym/rek4aZ46EJGOCC2
         tpJxYjOaaZo3I3Yg0xJXhInDJvR3VZjVDroIeQkfef44/m6IcE4SQj6pbzu9T7hZLJCl
         ctkZXBBVNfcSoaL0yIEc/LtxOg4wLolJ5BdMo63+PjZvA523LQEYrWJNEXij7EkoyZPX
         PdNVwOi4S2Lc3ftHXMg/DA5Cq6CQ25vtps2uDSvPMnUTLQ20DMT+osd0CRtv3JYBd2nw
         rNjNv44Kdjf0F5BzTp3GnjT003QXTijAcb4Ecw8D/Otv0QXnzBtX3UB9pj/T8HXGonvO
         SruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZ0Tbl1JRT8TpgT4ciKif/L2O/2dnKFAn9OEhwx1LKY=;
        b=WgKfU6GQ7HmIcJWQ5n5Ax4UsNr/gLUeFsGZVNECGkrOYZZ62mB8M3u3NVs0cAyxLIj
         8z5RWm3p2H0+rWaI2FULabrYXyCSCBk2YkEVyye/xDNLEX3T3zq6jg/F7CcC8UmHhXCb
         hwfHllW+6WY4pp0rn9kUwe6TrFaJyuUPkSE6r0XkZngRVdZTEzFLl3mot5P4svysBEuv
         IgucwYEAciLdD7M+Aeu3dfEsfdI18uqQTsUEU4ogr5MuQLcbErYQizaB3vamHUPtPtYw
         /3iY6+YQ5PLwuU3qZS4XLnO1ZoQBnJa8K3AHg0RUgDyesKsziB5eu2qa+oHvIgrz8I7e
         XVCw==
X-Gm-Message-State: AO0yUKWH4kq0TF7HD/u6I5K7lpk78BrMQPAaJBaYHF9I2/3iIA6g27jX
        GZlFmRseQnsBlyJPBuOGx/dScMblgDUeKd+yTYUjdg==
X-Google-Smtp-Source: AK7set8ljnu+GwuUQ4bAj4hFoVW4I2+uuhh7kwq1uoEl9VQWYBAHdwy47c4ncQV8gkQG7WYcehVwSf5DBTwi77UFuEo=
X-Received: by 2002:a25:ad93:0:b0:8bd:d8e7:aace with SMTP id
 z19-20020a25ad93000000b008bdd8e7aacemr173772ybi.549.1676450067211; Wed, 15
 Feb 2023 00:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20230214041410.6295-1-kerneljasonxing@gmail.com>
In-Reply-To: <20230214041410.6295-1-kerneljasonxing@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 15 Feb 2023 09:34:16 +0100
Message-ID: <CANn89iLq+_0ooWU52Y8cqk=JyrYo89_4TKW4BQ3P0+naYr+z_w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net: no longer support SOCK_REFCNT_DEBUG feature
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     kuniyu@amazon.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org,
        matthieu.baerts@tessares.net, willemdebruijn.kernel@gmail.com,
        nhorman@tuxdriver.com, marcelo.leitner@gmail.com,
        lucien.xin@gmail.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com,
        jaka@linux.ibm.com, bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sctp@vger.kernel.org, mptcp@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 14, 2023 at 5:15 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Commit e48c414ee61f ("[INET]: Generalise the TCP sock ID lookup routines")
> commented out the definition of SOCK_REFCNT_DEBUG in 2005 and later another
> commit 463c84b97f24 ("[NET]: Introduce inet_connection_sock") removed it.
> Since we could track all of them through bpf and kprobe related tools
> and the feature could print loads of information which might not be
> that helpful even under a little bit pressure, the whole feature which
> has been inactive for many years is no longer supported.
>
> Link: https://lore.kernel.org/lkml/20230211065153.54116-1-kerneljasonxing@gmail.com/
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
